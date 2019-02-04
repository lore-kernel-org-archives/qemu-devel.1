Received: from eggs.gnu.org ([209.51.188.92]:51529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1gqeC6-00011d-7p
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 08:21:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1gqe1K-000526-GE
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 08:10:44 -0500
Received: from forwardcorp1g.cmail.yandex.net ([87.250.241.190]:43579)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yury-kotov@yandex-team.ru>)
	id 1gqe1G-0004Ay-NQ
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 08:10:40 -0500
From: Yury Kotov <yury-kotov@yandex-team.ru>
Date: Mon,  4 Feb 2019 16:09:58 +0300
Message-Id: <20190204130958.18904-5-yury-kotov@yandex-team.ru>
In-Reply-To: <20190204130958.18904-1-yury-kotov@yandex-team.ru>
References: <20190204130958.18904-1-yury-kotov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 4/4] migration: Add capabilities validation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Cc: wrfsh@yandex-team.ru

Currently we don't check which capabilities set in the source QEMU.
We just expect that the target QEMU has the same enabled capabilities.

Add explicit validation for capabilities to make sure that the target VM
has them too. This is enabled for only new capabilities to keep compatibi=
ly.

Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
---
 migration/savevm.c | 101 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/migration/savevm.c b/migration/savevm.c
index 322660438d..9603a38bca 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -57,6 +57,7 @@
 #include "sysemu/replay.h"
 #include "qjson.h"
 #include "migration/colo.h"
+#include "qemu/bitmap.h"
=20
 #ifndef ETH_P_RARP
 #define ETH_P_RARP 0x8035
@@ -316,6 +317,8 @@ typedef struct SaveState {
     uint32_t len;
     const char *name;
     uint32_t target_page_bits;
+    uint32_t caps_count;
+    uint8_t *capabilities;
 } SaveState;
=20
 static SaveState savevm_state =3D {
@@ -323,15 +326,51 @@ static SaveState savevm_state =3D {
     .global_section_id =3D 0,
 };
=20
+static bool should_validate_capability(int capability)
+{
+    assert(capability >=3D 0 && capability < MIGRATION_CAPABILITY__MAX);
+    /* Validate only new capabilities to keep compatibility. */
+    switch (capability) {
+    case MIGRATION_CAPABILITY_X_IGNORE_SHARED:
+        return true;
+    default:
+        return false;
+    }
+}
+
+static uint32_t get_validatable_capabilities_count(void)
+{
+    MigrationState *s =3D migrate_get_current();
+    uint32_t result =3D 0;
+    int i;
+    for (i =3D 0; i < MIGRATION_CAPABILITY__MAX; i++) {
+        if (should_validate_capability(i) && s->enabled_capabilities[i])=
 {
+            result++;
+        }
+    }
+    return result;
+}
+
 static int configuration_pre_save(void *opaque)
 {
     SaveState *state =3D opaque;
     const char *current_name =3D MACHINE_GET_CLASS(current_machine)->nam=
e;
+    MigrationState *s =3D migrate_get_current();
+    int i, j;
=20
     state->len =3D strlen(current_name);
     state->name =3D current_name;
     state->target_page_bits =3D qemu_target_page_bits();
=20
+    state->caps_count =3D get_validatable_capabilities_count();
+    state->capabilities =3D g_renew(uint8_t, state->capabilities,
+                                  state->caps_count);
+    for (i =3D j =3D 0; i < MIGRATION_CAPABILITY__MAX; i++) {
+        if (should_validate_capability(i) && s->enabled_capabilities[i])=
 {
+            state->capabilities[j++] =3D i;
+        }
+    }
+
     return 0;
 }
=20
@@ -347,6 +386,45 @@ static int configuration_pre_load(void *opaque)
     return 0;
 }
=20
+static bool configuration_validate_capabilities(SaveState *state)
+{
+    bool ret =3D true;
+    MigrationState *s =3D migrate_get_current();
+    unsigned long *source_caps_bm;
+    int i;
+
+    source_caps_bm =3D bitmap_new(MIGRATION_CAPABILITY__MAX);
+    for (i =3D 0; i < state->caps_count; i++) {
+        int capability =3D state->capabilities[i];
+        if (capability >=3D MIGRATION_CAPABILITY__MAX) {
+            error_report("Received unknown capability %d", capability);
+            ret =3D false;
+        } else {
+            set_bit(capability, source_caps_bm);
+        }
+    }
+
+    for (i =3D 0; i < MIGRATION_CAPABILITY__MAX; i++) {
+        bool source_state, target_state;
+        if (!should_validate_capability(i)) {
+            continue;
+        }
+        source_state =3D test_bit(i, source_caps_bm);
+        target_state =3D s->enabled_capabilities[i];
+        if (source_state !=3D target_state) {
+            error_report("Capability %s is %s, but received capability i=
s %s",
+                         MigrationCapability_str(i),
+                         target_state ? "on" : "off",
+                         source_state ? "on" : "off");
+            ret =3D false;
+            /* Don't break here to report all failed capabilities */
+        }
+    }
+
+    g_free(source_caps_bm);
+    return ret;
+}
+
 static int configuration_post_load(void *opaque, int version_id)
 {
     SaveState *state =3D opaque;
@@ -364,6 +442,10 @@ static int configuration_post_load(void *opaque, int=
 version_id)
         return -EINVAL;
     }
=20
+    if (!configuration_validate_capabilities(state)) {
+        return -EINVAL;
+    }
+
     return 0;
 }
=20
@@ -380,6 +462,11 @@ static bool vmstate_target_page_bits_needed(void *op=
aque)
         > qemu_target_page_bits_min();
 }
=20
+static bool vmstate_capabilites_needed(void *opaque)
+{
+    return get_validatable_capabilities_count() > 0;
+}
+
 static const VMStateDescription vmstate_target_page_bits =3D {
     .name =3D "configuration/target-page-bits",
     .version_id =3D 1,
@@ -391,6 +478,19 @@ static const VMStateDescription vmstate_target_page_=
bits =3D {
     }
 };
=20
+static const VMStateDescription vmstate_capabilites =3D {
+    .name =3D "configuration/capabilities",
+    .version_id =3D 1,
+    .minimum_version_id =3D 1,
+    .needed =3D vmstate_capabilites_needed,
+    .fields =3D (VMStateField[]) {
+        VMSTATE_UINT32_V(caps_count, SaveState, 1),
+        VMSTATE_VARRAY_UINT32_ALLOC(capabilities, SaveState, caps_count,=
 1,
+                                    vmstate_info_uint8, uint8_t),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const VMStateDescription vmstate_configuration =3D {
     .name =3D "configuration",
     .version_id =3D 1,
@@ -404,6 +504,7 @@ static const VMStateDescription vmstate_configuration=
 =3D {
     },
     .subsections =3D (const VMStateDescription*[]) {
         &vmstate_target_page_bits,
+        &vmstate_capabilites,
         NULL
     }
 };
--=20
2.20.1
