Received: from eggs.gnu.org ([2001:4830:134:3::10]:53485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gXCNo-00023o-Jk
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 16:49:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gXCNn-0006Aj-24
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 16:49:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45182)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gXCNm-00069v-PF
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 16:49:30 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2A1F83004416
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 21:49:30 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 13 Dec 2018 01:48:28 +0400
Message-Id: <20181212214850.29953-7-marcandre.lureau@redhat.com>
In-Reply-To: <20181212214850.29953-1-marcandre.lureau@redhat.com>
References: <20181212214850.29953-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 06/28] compat: replace PC_COMPAT_3_1 &
 HW_COMPAT_3_1 macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: imammedo@redhat.com, ehabkost@redhat.com

Use static arrays instead.

Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/hw/boards.h  | 3 +++
 include/hw/compat.h  | 3 ---
 include/hw/i386/pc.h | 4 ++--
 hw/arm/virt.c        | 6 +-----
 hw/core/machine.c    | 3 +++
 hw/i386/pc.c         | 3 +++
 hw/i386/pc_piix.c    | 7 ++-----
 hw/i386/pc_q35.c     | 7 ++-----
 hw/ppc/spapr.c       | 6 +-----
 9 files changed, 17 insertions(+), 25 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index f743d9d4a4..dc8c748c62 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -287,4 +287,7 @@ struct MachineState {
     } \
     type_init(machine_initfn##_register_types)
=20
+extern GlobalProperty hw_compat_3_1[];
+extern const size_t hw_compat_3_1_len;
+
 #endif
diff --git a/include/hw/compat.h b/include/hw/compat.h
index 70958328fe..6f4d5fc647 100644
--- a/include/hw/compat.h
+++ b/include/hw/compat.h
@@ -1,9 +1,6 @@
 #ifndef HW_COMPAT_H
 #define HW_COMPAT_H
=20
-#define HW_COMPAT_3_1 \
-    /* empty */
-
 #define HW_COMPAT_3_0 \
     /* empty */
=20
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 9d29c4b1df..dd1d6fd0f3 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -294,8 +294,8 @@ int e820_add_entry(uint64_t, uint64_t, uint32_t);
 int e820_get_num_entries(void);
 bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
=20
-#define PC_COMPAT_3_1 \
-    HW_COMPAT_3_1 \
+extern GlobalProperty pc_compat_3_1[];
+extern const size_t pc_compat_3_1_len;
=20
 #define PC_COMPAT_3_0 \
     HW_COMPAT_3_0 \
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index d38fedf717..235305d043 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1874,12 +1874,8 @@ DEFINE_VIRT_MACHINE_AS_LATEST(4, 0)
=20
 static void virt_machine_3_1_options(MachineClass *mc)
 {
-    static GlobalProperty compat[] =3D {
-        HW_COMPAT_3_1
-    };
-
     virt_machine_4_0_options(mc);
-    compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
+    compat_props_add(mc->compat_props, hw_compat_3_1, hw_compat_3_1_len)=
;
 }
 DEFINE_VIRT_MACHINE(3, 1)
=20
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 6e24924aba..bdeeda68e4 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -22,6 +22,9 @@
 #include "qemu/error-report.h"
 #include "sysemu/qtest.h"
=20
+GlobalProperty hw_compat_3_1[] =3D {};
+const size_t hw_compat_3_1_len =3D G_N_ELEMENTS(hw_compat_3_1);
+
 static char *machine_get_accel(Object *obj, Error **errp)
 {
     MachineState *ms =3D MACHINE(obj);
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 4cd2fbca4d..a872b7ceea 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -109,6 +109,9 @@ static struct e820_entry *e820_table;
 static unsigned e820_entries;
 struct hpet_fw_config hpet_cfg =3D {.count =3D UINT8_MAX};
=20
+GlobalProperty pc_compat_3_1[] =3D {};
+const size_t pc_compat_3_1_len =3D G_N_ELEMENTS(pc_compat_3_1);
+
 void gsi_handler(void *opaque, int n, int level)
 {
     GSIState *s =3D opaque;
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index d1abe637f1..5342019d83 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -440,14 +440,11 @@ DEFINE_I440FX_MACHINE(v4_0, "pc-i440fx-4.0", NULL,
=20
 static void pc_i440fx_3_1_machine_options(MachineClass *m)
 {
-    static GlobalProperty compat[] =3D {
-        PC_COMPAT_3_1
-    };
-
     pc_i440fx_4_0_machine_options(m);
     m->is_default =3D 0;
     m->alias =3D NULL;
-    compat_props_add(m->compat_props, compat, G_N_ELEMENTS(compat));
+    compat_props_add(m->compat_props, hw_compat_3_1, hw_compat_3_1_len);
+    compat_props_add(m->compat_props, pc_compat_3_1, pc_compat_3_1_len);
 }
=20
 DEFINE_I440FX_MACHINE(v3_1, "pc-i440fx-3.1", NULL,
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index c18bfd68c6..1eb1e82b25 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -322,13 +322,10 @@ DEFINE_Q35_MACHINE(v4_0, "pc-q35-4.0", NULL,
=20
 static void pc_q35_3_1_machine_options(MachineClass *m)
 {
-    static GlobalProperty compat[] =3D {
-        PC_COMPAT_3_1
-    };
-
     pc_q35_4_0_machine_options(m);
     m->alias =3D NULL;
-    compat_props_add(m->compat_props, compat, G_N_ELEMENTS(compat));
+    compat_props_add(m->compat_props, hw_compat_3_1, hw_compat_3_1_len);
+    compat_props_add(m->compat_props, pc_compat_3_1, pc_compat_3_1_len);
 }
=20
 DEFINE_Q35_MACHINE(v3_1, "pc-q35-3.1", NULL,
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 2313362ff2..038d1859a6 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3965,12 +3965,8 @@ DEFINE_SPAPR_MACHINE(4_0, "4.0", true);
  */
 static void spapr_machine_3_1_class_options(MachineClass *mc)
 {
-    static GlobalProperty compat[] =3D {
-        HW_COMPAT_3_1
-    };
-
     spapr_machine_4_0_class_options(mc);
-    compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
+    compat_props_add(mc->compat_props, hw_compat_3_1, hw_compat_3_1_len)=
;
 }
=20
 DEFINE_SPAPR_MACHINE(3_1, "3.1", false);
--=20
2.20.0
