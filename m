Received: from eggs.gnu.org ([209.51.188.92]:49401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ggU2d-000650-3N
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 07:30:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ggU2Z-0007rd-6s
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 07:30:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59390)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1ggU2V-0007qB-H6
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 07:29:55 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon,  7 Jan 2019 16:22:42 +0400
Message-Id: <20190107122304.22997-7-marcandre.lureau@redhat.com>
In-Reply-To: <20190107122304.22997-1-marcandre.lureau@redhat.com>
References: <20190107122304.22997-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 06/28] compat: replace PC_COMPAT_3_1 &
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
Cc: peter.maydell@linaro.org

Use static arrays instead.

Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Acked-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/boards.h        |  3 +++
 include/hw/compat.h        | 11 -----------
 include/hw/i386/pc.h       |  9 ++-------
 hw/arm/virt.c              |  6 +-----
 hw/core/machine.c          | 13 +++++++++++++
 hw/i386/pc.c               |  9 +++++++++
 hw/i386/pc_piix.c          |  7 ++-----
 hw/i386/pc_q35.c           |  7 ++-----
 hw/ppc/spapr.c             |  6 +-----
 hw/s390x/s390-virtio-ccw.c |  6 +-----
 10 files changed, 34 insertions(+), 43 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index 0566742412..b9a5c2d087 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -288,4 +288,7 @@ struct MachineState {
     } \
     type_init(machine_initfn##_register_types)
=20
+extern GlobalProperty hw_compat_3_1[];
+extern const size_t hw_compat_3_1_len;
+
 #endif
diff --git a/include/hw/compat.h b/include/hw/compat.h
index 3ca85b037c..6f4d5fc647 100644
--- a/include/hw/compat.h
+++ b/include/hw/compat.h
@@ -1,17 +1,6 @@
 #ifndef HW_COMPAT_H
 #define HW_COMPAT_H
=20
-#define HW_COMPAT_3_1 \
-    {\
-        .driver   =3D "pcie-root-port",\
-        .property =3D "x-speed",\
-        .value    =3D "2_5",\
-    },{\
-        .driver   =3D "pcie-root-port",\
-        .property =3D "x-width",\
-        .value    =3D "1",\
-    },
-
 #define HW_COMPAT_3_0 \
     /* empty */
=20
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index c7c0c944e8..dd1d6fd0f3 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -294,13 +294,8 @@ int e820_add_entry(uint64_t, uint64_t, uint32_t);
 int e820_get_num_entries(void);
 bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
=20
-#define PC_COMPAT_3_1 \
-    HW_COMPAT_3_1 \
-    {\
-        .driver   =3D "intel-iommu",\
-        .property =3D "dma-drain",\
-        .value    =3D "off",\
-    },
+extern GlobalProperty pc_compat_3_1[];
+extern const size_t pc_compat_3_1_len;
=20
 #define PC_COMPAT_3_0 \
     HW_COMPAT_3_0 \
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 19bec3fe59..ebd5f306e4 100644
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
index bd644c976b..d6204967c3 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -22,6 +22,19 @@
 #include "qemu/error-report.h"
 #include "sysemu/qtest.h"
=20
+GlobalProperty hw_compat_3_1[] =3D {
+    {
+        .driver   =3D "pcie-root-port",
+        .property =3D "x-speed",
+        .value    =3D "2_5",
+    },{
+        .driver   =3D "pcie-root-port",
+        .property =3D "x-width",
+        .value    =3D "1",
+    },
+};
+const size_t hw_compat_3_1_len =3D G_N_ELEMENTS(hw_compat_3_1);
+
 static char *machine_get_accel(Object *obj, Error **errp)
 {
     MachineState *ms =3D MACHINE(obj);
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index f248662e97..33d09a832a 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -109,6 +109,15 @@ static struct e820_entry *e820_table;
 static unsigned e820_entries;
 struct hpet_fw_config hpet_cfg =3D {.count =3D UINT8_MAX};
=20
+GlobalProperty pc_compat_3_1[] =3D {
+    {
+        .driver   =3D "intel-iommu",
+        .property =3D "dma-drain",
+        .value    =3D "off",
+    },
+};
+const size_t pc_compat_3_1_len =3D G_N_ELEMENTS(pc_compat_3_1);
+
 void gsi_handler(void *opaque, int n, int level)
 {
     GSIState *s =3D opaque;
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 2423428acd..c938437627 100644
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
index d84614546c..fad3d6da17 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -323,14 +323,11 @@ DEFINE_Q35_MACHINE(v4_0, "pc-q35-4.0", NULL,
=20
 static void pc_q35_3_1_machine_options(MachineClass *m)
 {
-    static GlobalProperty compat[] =3D {
-        PC_COMPAT_3_1
-    };
-
     pc_q35_4_0_machine_options(m);
     m->default_kernel_irqchip_split =3D false;
     m->alias =3D NULL;
-    compat_props_add(m->compat_props, compat, G_N_ELEMENTS(compat));
+    compat_props_add(m->compat_props, hw_compat_3_1, hw_compat_3_1_len);
+    compat_props_add(m->compat_props, pc_compat_3_1, pc_compat_3_1_len);
 }
=20
 DEFINE_Q35_MACHINE(v3_1, "pc-q35-3.1", NULL,
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index f3b8c18de3..f04135fffd 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4023,12 +4023,8 @@ DEFINE_SPAPR_MACHINE(4_0, "4.0", true);
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
     mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("power8_v2.0");
 }
=20
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 21f3325c5a..5e8b48e75b 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -667,12 +667,8 @@ static void ccw_machine_3_1_instance_options(Machine=
State *machine)
=20
 static void ccw_machine_3_1_class_options(MachineClass *mc)
 {
-    static GlobalProperty compat[] =3D {
-        HW_COMPAT_3_1
-    };
-
     ccw_machine_4_0_class_options(mc);
-    compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
+    compat_props_add(mc->compat_props, hw_compat_3_1, hw_compat_3_1_len)=
;
 }
 DEFINE_CCW_MACHINE(3_1, "3.1", false);
=20
--=20
2.20.1.2.gb21ebb671b
