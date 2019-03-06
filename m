Received: from eggs.gnu.org ([209.51.188.92]:43534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1h1Uwz-0006Gk-0E
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 06:43:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1h1Uwx-0004sF-Gq
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 06:43:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59002)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1h1Uwx-0004p9-6u
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 06:43:03 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed,  6 Mar 2019 11:42:14 +0000
Message-Id: <20190306114227.9125-10-dgilbert@redhat.com>
In-Reply-To: <20190306114227.9125-1-dgilbert@redhat.com>
References: <20190306114227.9125-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 09/22] migration: Add capabilities validation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com, marcel.apfelbaum@gmail.com, wei.w.wang@intel.com, yury-kotov@yandex-team.ru, chen.zhang@intel.com
Cc: eblake@redhat.com, armbru@redhat.com

From: Yury Kotov <yury-kotov@yandex-team.ru>

Currently we don't check which capabilities set in the source QEMU.
We just expect that the target QEMU has the same enabled capabilities.

Add explicit validation for capabilities to make sure that the target VM
has them too. This is enabled for only new capabilities to keep compatibi=
ly.

Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
Message-Id: <20190215174548.2630-6-yury-kotov@yandex-team.ru>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
  dgilbert: Manual merge
---
 migration/savevm.c | 137 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 137 insertions(+)

diff --git a/migration/savevm.c b/migration/savevm.c
index b3868f7fb5..013098581f 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -57,6 +57,7 @@
 #include "sysemu/replay.h"
 #include "qjson.h"
 #include "migration/colo.h"
+#include "qemu/bitmap.h"
 #include "net/announce.h"
=20
 const unsigned int postcopy_ram_discard_version =3D 0;
@@ -249,6 +250,8 @@ typedef struct SaveState {
     uint32_t len;
     const char *name;
     uint32_t target_page_bits;
+    uint32_t caps_count;
+    MigrationCapability *capabilities;
 } SaveState;
=20
 static SaveState savevm_state =3D {
@@ -256,15 +259,51 @@ static SaveState savevm_state =3D {
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
+    state->capabilities =3D g_renew(MigrationCapability, state->capabili=
ties,
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
@@ -280,6 +319,40 @@ static int configuration_pre_load(void *opaque)
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
+        MigrationCapability capability =3D state->capabilities[i];
+        set_bit(capability, source_caps_bm);
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
@@ -297,9 +370,53 @@ static int configuration_post_load(void *opaque, int=
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
+static int get_capability(QEMUFile *f, void *pv, size_t size,
+                          const VMStateField *field)
+{
+    MigrationCapability *capability =3D pv;
+    char capability_str[UINT8_MAX + 1];
+    uint8_t len;
+    int i;
+
+    len =3D qemu_get_byte(f);
+    qemu_get_buffer(f, (uint8_t *)capability_str, len);
+    capability_str[len] =3D '\0';
+    for (i =3D 0; i < MIGRATION_CAPABILITY__MAX; i++) {
+        if (!strcmp(MigrationCapability_str(i), capability_str)) {
+            *capability =3D i;
+            return 0;
+        }
+    }
+    error_report("Received unknown capability %s", capability_str);
+    return -EINVAL;
+}
+
+static int put_capability(QEMUFile *f, void *pv, size_t size,
+                          const VMStateField *field, QJSON *vmdesc)
+{
+    MigrationCapability *capability =3D pv;
+    const char *capability_str =3D MigrationCapability_str(*capability);
+    size_t len =3D strlen(capability_str);
+    assert(len <=3D UINT8_MAX);
+
+    qemu_put_byte(f, len);
+    qemu_put_buffer(f, (uint8_t *)capability_str, len);
+    return 0;
+}
+
+static const VMStateInfo vmstate_info_capability =3D {
+    .name =3D "capability",
+    .get  =3D get_capability,
+    .put  =3D put_capability,
+};
+
 /* The target-page-bits subsection is present only if the
  * target page size is not the same as the default (ie the
  * minimum page size for a variable-page-size guest CPU).
@@ -324,6 +441,25 @@ static const VMStateDescription vmstate_target_page_=
bits =3D {
     }
 };
=20
+static bool vmstate_capabilites_needed(void *opaque)
+{
+    return get_validatable_capabilities_count() > 0;
+}
+
+static const VMStateDescription vmstate_capabilites =3D {
+    .name =3D "configuration/capabilities",
+    .version_id =3D 1,
+    .minimum_version_id =3D 1,
+    .needed =3D vmstate_capabilites_needed,
+    .fields =3D (VMStateField[]) {
+        VMSTATE_UINT32_V(caps_count, SaveState, 1),
+        VMSTATE_VARRAY_UINT32_ALLOC(capabilities, SaveState, caps_count,=
 1,
+                                    vmstate_info_capability,
+                                    MigrationCapability),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const VMStateDescription vmstate_configuration =3D {
     .name =3D "configuration",
     .version_id =3D 1,
@@ -337,6 +473,7 @@ static const VMStateDescription vmstate_configuration=
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
