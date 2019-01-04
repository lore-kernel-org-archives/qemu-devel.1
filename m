Received: from eggs.gnu.org ([208.118.235.92]:44029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gfTK4-0003s9-V1
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 12:31:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gfTK1-0001KS-Rl
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 12:31:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42132)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gfTK1-0001Jg-5R
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 12:31:49 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri,  4 Jan 2019 21:30:25 +0400
Message-Id: <20190104173042.32714-12-marcandre.lureau@redhat.com>
In-Reply-To: <20190104173042.32714-1-marcandre.lureau@redhat.com>
References: <20190104173042.32714-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 11/28] compat: replace PC_COMPAT_2_9 &
 HW_COMPAT_2_9 macros
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
 include/hw/compat.h        | 19 -------------------
 include/hw/i386/pc.h       |  9 ++-------
 hw/arm/virt.c              |  6 +-----
 hw/core/machine.c          | 21 +++++++++++++++++++++
 hw/i386/pc.c               |  9 +++++++++
 hw/i386/pc_piix.c          |  7 ++-----
 hw/i386/pc_q35.c           |  7 ++-----
 hw/ppc/spapr.c             |  2 +-
 hw/s390x/s390-virtio-ccw.c |  2 +-
 10 files changed, 42 insertions(+), 43 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index 732eb7bb73..0e69350939 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -303,4 +303,7 @@ extern const size_t hw_compat_2_11_len;
 extern GlobalProperty hw_compat_2_10[];
 extern const size_t hw_compat_2_10_len;
=20
+extern GlobalProperty hw_compat_2_9[];
+extern const size_t hw_compat_2_9_len;
+
 #endif
diff --git a/include/hw/compat.h b/include/hw/compat.h
index f414786604..ef154ca470 100644
--- a/include/hw/compat.h
+++ b/include/hw/compat.h
@@ -1,25 +1,6 @@
 #ifndef HW_COMPAT_H
 #define HW_COMPAT_H
=20
-#define HW_COMPAT_2_9 \
-    {\
-        .driver   =3D "pci-bridge",\
-        .property =3D "shpc",\
-        .value    =3D "off",\
-    },{\
-        .driver   =3D "intel-iommu",\
-        .property =3D "pt",\
-        .value    =3D "off",\
-    },{\
-        .driver   =3D "virtio-net-device",\
-        .property =3D "x-mtu-bypass-backend",\
-        .value    =3D "off",\
-    },{\
-        .driver   =3D "pcie-root-port",\
-        .property =3D "x-migrate-msix",\
-        .value    =3D "false",\
-    },
-
 #define HW_COMPAT_2_8 \
     {\
         .driver   =3D "fw_cfg_mem",\
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index d77843a711..fb79f0b988 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -309,13 +309,8 @@ extern const size_t pc_compat_2_11_len;
 extern GlobalProperty pc_compat_2_10[];
 extern const size_t pc_compat_2_10_len;
=20
-#define PC_COMPAT_2_9 \
-    HW_COMPAT_2_9 \
-    {\
-        .driver   =3D "mch",\
-        .property =3D "extended-tseg-mbytes",\
-        .value    =3D stringify(0),\
-    },\
+extern GlobalProperty pc_compat_2_9[];
+extern const size_t pc_compat_2_9_len;
=20
 #define PC_COMPAT_2_8 \
     HW_COMPAT_2_8 \
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 75ab14305a..a0898f27d3 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1918,12 +1918,8 @@ DEFINE_VIRT_MACHINE(2, 10)
=20
 static void virt_machine_2_9_options(MachineClass *mc)
 {
-    static GlobalProperty compat[] =3D {
-        HW_COMPAT_2_9
-    };
-
     virt_machine_2_10_options(mc);
-    compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
+    compat_props_add(mc->compat_props, hw_compat_2_9, hw_compat_2_9_len)=
;
 }
 DEFINE_VIRT_MACHINE(2, 9)
=20
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 7673454a66..aa5f03fba2 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -101,6 +101,27 @@ GlobalProperty hw_compat_2_10[] =3D {
 };
 const size_t hw_compat_2_10_len =3D G_N_ELEMENTS(hw_compat_2_10);
=20
+GlobalProperty hw_compat_2_9[] =3D {
+    {
+        .driver   =3D "pci-bridge",
+        .property =3D "shpc",
+        .value    =3D "off",
+    },{
+        .driver   =3D "intel-iommu",
+        .property =3D "pt",
+        .value    =3D "off",
+    },{
+        .driver   =3D "virtio-net-device",
+        .property =3D "x-mtu-bypass-backend",
+        .value    =3D "off",
+    },{
+        .driver   =3D "pcie-root-port",
+        .property =3D "x-migrate-msix",
+        .value    =3D "false",
+    },
+};
+const size_t hw_compat_2_9_len =3D G_N_ELEMENTS(hw_compat_2_9);
+
 static char *machine_get_accel(Object *obj, Error **errp)
 {
     MachineState *ms =3D MACHINE(obj);
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index c0bb82c454..3f6f5df363 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -186,6 +186,15 @@ GlobalProperty pc_compat_2_10[] =3D {
 };
 const size_t pc_compat_2_10_len =3D G_N_ELEMENTS(pc_compat_2_10);
=20
+GlobalProperty pc_compat_2_9[] =3D {
+    {
+        .driver   =3D "mch",
+        .property =3D "extended-tseg-mbytes",
+        .value    =3D stringify(0),
+    },
+};
+const size_t pc_compat_2_9_len =3D G_N_ELEMENTS(pc_compat_2_9);
+
 void gsi_handler(void *opaque, int n, int level)
 {
     GSIState *s =3D opaque;
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index aea678dc91..02520bceb9 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -493,12 +493,9 @@ DEFINE_I440FX_MACHINE(v2_10, "pc-i440fx-2.10", NULL,
=20
 static void pc_i440fx_2_9_machine_options(MachineClass *m)
 {
-    static GlobalProperty compat[] =3D {
-        PC_COMPAT_2_9
-    };
-
     pc_i440fx_2_10_machine_options(m);
-    compat_props_add(m->compat_props, compat, G_N_ELEMENTS(compat));
+    compat_props_add(m->compat_props, hw_compat_2_9, hw_compat_2_9_len);
+    compat_props_add(m->compat_props, pc_compat_2_9, pc_compat_2_9_len);
     m->numa_auto_assign_ram =3D numa_legacy_auto_assign_ram;
 }
=20
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index a9c4fc27e4..e94d2d05c7 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -380,12 +380,9 @@ DEFINE_Q35_MACHINE(v2_10, "pc-q35-2.10", NULL,
=20
 static void pc_q35_2_9_machine_options(MachineClass *m)
 {
-    static GlobalProperty compat[] =3D {
-        PC_COMPAT_2_9
-    };
-
     pc_q35_2_10_machine_options(m);
-    compat_props_add(m->compat_props, compat, G_N_ELEMENTS(compat));
+    compat_props_add(m->compat_props, hw_compat_2_9, hw_compat_2_9_len);
+    compat_props_add(m->compat_props, pc_compat_2_9, pc_compat_2_9_len);
 }
=20
 DEFINE_Q35_MACHINE(v2_9, "pc-q35-2.9", NULL,
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 483a1373df..477ff5eb94 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4127,7 +4127,6 @@ static void spapr_machine_2_9_class_options(Machine=
Class *mc)
 {
     sPAPRMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
     static GlobalProperty compat[] =3D {
-        HW_COMPAT_2_9
         {
             .driver =3D TYPE_POWERPC_CPU,
             .property =3D "pre-2.10-migration",
@@ -4136,6 +4135,7 @@ static void spapr_machine_2_9_class_options(Machine=
Class *mc)
     };
=20
     spapr_machine_2_10_class_options(mc);
+    compat_props_add(mc->compat_props, hw_compat_2_9, hw_compat_2_9_len)=
;
     compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
     mc->numa_auto_assign_ram =3D numa_legacy_auto_assign_ram;
     smc->pre_2_10_has_unused_icps =3D true;
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 95ad7ba842..549f6e0231 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -752,7 +752,6 @@ static void ccw_machine_2_9_class_options(MachineClas=
s *mc)
 {
     S390CcwMachineClass *s390mc =3D S390_MACHINE_CLASS(mc);
     static GlobalProperty compat[] =3D {
-        HW_COMPAT_2_9
         {
             .driver   =3D TYPE_S390_STATTRIB,
             .property =3D "migration-enabled",
@@ -761,6 +760,7 @@ static void ccw_machine_2_9_class_options(MachineClas=
s *mc)
     };
=20
     ccw_machine_2_10_class_options(mc);
+    compat_props_add(mc->compat_props, hw_compat_2_9, hw_compat_2_9_len)=
;
     compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
     s390mc->css_migration_enabled =3D false;
 }
--=20
2.20.1.2.gb21ebb671b
