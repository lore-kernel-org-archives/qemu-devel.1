Received: from eggs.gnu.org ([208.118.235.92]:44058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gfTKB-0003wJ-6C
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 12:32:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gfTK8-0001O4-RT
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 12:31:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42172)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gfTK6-0001ME-RC
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 12:31:56 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri,  4 Jan 2019 21:30:26 +0400
Message-Id: <20190104173042.32714-13-marcandre.lureau@redhat.com>
In-Reply-To: <20190104173042.32714-1-marcandre.lureau@redhat.com>
References: <20190104173042.32714-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 12/28] compat: replace PC_COMPAT_2_8 &
 HW_COMPAT_2_8 macros
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
 include/hw/compat.h        | 43 -----------------------------------
 include/hw/i386/pc.h       | 29 ++----------------------
 hw/arm/virt.c              |  5 +----
 hw/core/machine.c          | 46 ++++++++++++++++++++++++++++++++++++++
 hw/i386/pc.c               | 29 ++++++++++++++++++++++++
 hw/i386/pc_piix.c          |  7 ++----
 hw/i386/pc_q35.c           |  7 ++----
 hw/ppc/spapr.c             |  2 +-
 hw/s390x/s390-virtio-ccw.c |  2 +-
 10 files changed, 87 insertions(+), 86 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index 0e69350939..03278a8c39 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -306,4 +306,7 @@ extern const size_t hw_compat_2_10_len;
 extern GlobalProperty hw_compat_2_9[];
 extern const size_t hw_compat_2_9_len;
=20
+extern GlobalProperty hw_compat_2_8[];
+extern const size_t hw_compat_2_8_len;
+
 #endif
diff --git a/include/hw/compat.h b/include/hw/compat.h
index ef154ca470..65d6748054 100644
--- a/include/hw/compat.h
+++ b/include/hw/compat.h
@@ -1,49 +1,6 @@
 #ifndef HW_COMPAT_H
 #define HW_COMPAT_H
=20
-#define HW_COMPAT_2_8 \
-    {\
-        .driver   =3D "fw_cfg_mem",\
-        .property =3D "x-file-slots",\
-        .value    =3D stringify(0x10),\
-    },{\
-        .driver   =3D "fw_cfg_io",\
-        .property =3D "x-file-slots",\
-        .value    =3D stringify(0x10),\
-    },{\
-        .driver   =3D "pflash_cfi01",\
-        .property =3D "old-multiple-chip-handling",\
-        .value    =3D "on",\
-    },{\
-        .driver   =3D "pci-bridge",\
-        .property =3D "shpc",\
-        .value    =3D "on",\
-    },{\
-        .driver   =3D TYPE_PCI_DEVICE,\
-        .property =3D "x-pcie-extcap-init",\
-        .value    =3D "off",\
-    },{\
-        .driver   =3D "virtio-pci",\
-        .property =3D "x-pcie-deverr-init",\
-        .value    =3D "off",\
-    },{\
-        .driver   =3D "virtio-pci",\
-        .property =3D "x-pcie-lnkctl-init",\
-        .value    =3D "off",\
-    },{\
-        .driver   =3D "virtio-pci",\
-        .property =3D "x-pcie-pm-init",\
-        .value    =3D "off",\
-    },{\
-        .driver   =3D "cirrus-vga",\
-        .property =3D "vgamem_mb",\
-        .value    =3D "8",\
-    },{\
-        .driver   =3D "isa-cirrus-vga",\
-        .property =3D "vgamem_mb",\
-        .value    =3D "8",\
-    },
-
 #define HW_COMPAT_2_7 \
     {\
         .driver   =3D "virtio-pci",\
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index fb79f0b988..12c47d2506 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -312,33 +312,8 @@ extern const size_t pc_compat_2_10_len;
 extern GlobalProperty pc_compat_2_9[];
 extern const size_t pc_compat_2_9_len;
=20
-#define PC_COMPAT_2_8 \
-    HW_COMPAT_2_8 \
-    {\
-        .driver   =3D TYPE_X86_CPU,\
-        .property =3D "tcg-cpuid",\
-        .value    =3D "off",\
-    },\
-    {\
-        .driver   =3D "kvmclock",\
-        .property =3D "x-mach-use-reliable-get-clock",\
-        .value    =3D "off",\
-    },\
-    {\
-        .driver   =3D "ICH9-LPC",\
-        .property =3D "x-smi-broadcast",\
-        .value    =3D "off",\
-    },\
-    {\
-        .driver   =3D TYPE_X86_CPU,\
-        .property =3D "vmware-cpuid-freq",\
-        .value    =3D "off",\
-    },\
-    {\
-        .driver   =3D "Haswell-" TYPE_X86_CPU,\
-        .property =3D "stepping",\
-        .value    =3D "1",\
-    },
+extern GlobalProperty pc_compat_2_8[];
+extern const size_t pc_compat_2_8_len;
=20
 #define PC_COMPAT_2_7 \
     HW_COMPAT_2_7 \
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index a0898f27d3..d4dee3ece7 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1926,12 +1926,9 @@ DEFINE_VIRT_MACHINE(2, 9)
 static void virt_machine_2_8_options(MachineClass *mc)
 {
     VirtMachineClass *vmc =3D VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
-    static GlobalProperty compat[] =3D {
-        HW_COMPAT_2_8
-    };
=20
     virt_machine_2_9_options(mc);
-    compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
+    compat_props_add(mc->compat_props, hw_compat_2_8, hw_compat_2_8_len)=
;
     /* For 2.8 and earlier we falsely claimed in the DT that
      * our timers were edge-triggered, not level-triggered.
      */
diff --git a/hw/core/machine.c b/hw/core/machine.c
index aa5f03fba2..efda98a9ab 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -21,6 +21,7 @@
 #include "sysemu/numa.h"
 #include "qemu/error-report.h"
 #include "sysemu/qtest.h"
+#include "hw/pci/pci.h"
=20
 GlobalProperty hw_compat_3_1[] =3D {
     {
@@ -122,6 +123,51 @@ GlobalProperty hw_compat_2_9[] =3D {
 };
 const size_t hw_compat_2_9_len =3D G_N_ELEMENTS(hw_compat_2_9);
=20
+GlobalProperty hw_compat_2_8[] =3D {
+    {
+        .driver   =3D "fw_cfg_mem",
+        .property =3D "x-file-slots",
+        .value    =3D stringify(0x10),
+    },{
+        .driver   =3D "fw_cfg_io",
+        .property =3D "x-file-slots",
+        .value    =3D stringify(0x10),
+    },{
+        .driver   =3D "pflash_cfi01",
+        .property =3D "old-multiple-chip-handling",
+        .value    =3D "on",
+    },{
+        .driver   =3D "pci-bridge",
+        .property =3D "shpc",
+        .value    =3D "on",
+    },{
+        .driver   =3D TYPE_PCI_DEVICE,
+        .property =3D "x-pcie-extcap-init",
+        .value    =3D "off",
+    },{
+        .driver   =3D "virtio-pci",
+        .property =3D "x-pcie-deverr-init",
+        .value    =3D "off",
+    },{
+        .driver   =3D "virtio-pci",
+        .property =3D "x-pcie-lnkctl-init",
+        .value    =3D "off",
+    },{
+        .driver   =3D "virtio-pci",
+        .property =3D "x-pcie-pm-init",
+        .value    =3D "off",
+    },{
+        .driver   =3D "cirrus-vga",
+        .property =3D "vgamem_mb",
+        .value    =3D "8",
+    },{
+        .driver   =3D "isa-cirrus-vga",
+        .property =3D "vgamem_mb",
+        .value    =3D "8",
+    },
+};
+const size_t hw_compat_2_8_len =3D G_N_ELEMENTS(hw_compat_2_8);
+
 static char *machine_get_accel(Object *obj, Error **errp)
 {
     MachineState *ms =3D MACHINE(obj);
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 3f6f5df363..b094e5b2ad 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -195,6 +195,35 @@ GlobalProperty pc_compat_2_9[] =3D {
 };
 const size_t pc_compat_2_9_len =3D G_N_ELEMENTS(pc_compat_2_9);
=20
+GlobalProperty pc_compat_2_8[] =3D {
+    {
+        .driver   =3D TYPE_X86_CPU,
+        .property =3D "tcg-cpuid",
+        .value    =3D "off",
+    },
+    {
+        .driver   =3D "kvmclock",
+        .property =3D "x-mach-use-reliable-get-clock",
+        .value    =3D "off",
+    },
+    {
+        .driver   =3D "ICH9-LPC",
+        .property =3D "x-smi-broadcast",
+        .value    =3D "off",
+    },
+    {
+        .driver   =3D TYPE_X86_CPU,
+        .property =3D "vmware-cpuid-freq",
+        .value    =3D "off",
+    },
+    {
+        .driver   =3D "Haswell-" TYPE_X86_CPU,
+        .property =3D "stepping",
+        .value    =3D "1",
+    },
+};
+const size_t pc_compat_2_8_len =3D G_N_ELEMENTS(pc_compat_2_8);
+
 void gsi_handler(void *opaque, int n, int level)
 {
     GSIState *s =3D opaque;
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 02520bceb9..b1fa038a69 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -504,12 +504,9 @@ DEFINE_I440FX_MACHINE(v2_9, "pc-i440fx-2.9", NULL,
=20
 static void pc_i440fx_2_8_machine_options(MachineClass *m)
 {
-    static GlobalProperty compat[] =3D {
-        PC_COMPAT_2_8
-    };
-
     pc_i440fx_2_9_machine_options(m);
-    compat_props_add(m->compat_props, compat, G_N_ELEMENTS(compat));
+    compat_props_add(m->compat_props, hw_compat_2_8, hw_compat_2_8_len);
+    compat_props_add(m->compat_props, pc_compat_2_8, pc_compat_2_8_len);
 }
=20
 DEFINE_I440FX_MACHINE(v2_8, "pc-i440fx-2.8", NULL,
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index e94d2d05c7..7e608b3ffb 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -390,12 +390,9 @@ DEFINE_Q35_MACHINE(v2_9, "pc-q35-2.9", NULL,
=20
 static void pc_q35_2_8_machine_options(MachineClass *m)
 {
-    static GlobalProperty compat[] =3D {
-        PC_COMPAT_2_8
-    };
-
     pc_q35_2_9_machine_options(m);
-    compat_props_add(m->compat_props, compat, G_N_ELEMENTS(compat));
+    compat_props_add(m->compat_props, hw_compat_2_8, hw_compat_2_8_len);
+    compat_props_add(m->compat_props, pc_compat_2_8, pc_compat_2_8_len);
 }
=20
 DEFINE_Q35_MACHINE(v2_8, "pc-q35-2.8", NULL,
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 477ff5eb94..a19353827f 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4151,7 +4151,6 @@ DEFINE_SPAPR_MACHINE(2_9, "2.9", false);
 static void spapr_machine_2_8_class_options(MachineClass *mc)
 {
     static GlobalProperty compat[] =3D {
-        HW_COMPAT_2_8
         {
             .driver   =3D TYPE_SPAPR_PCI_HOST_BRIDGE,
             .property =3D "pcie-extended-configuration-space",
@@ -4160,6 +4159,7 @@ static void spapr_machine_2_8_class_options(Machine=
Class *mc)
     };
=20
     spapr_machine_2_9_class_options(mc);
+    compat_props_add(mc->compat_props, hw_compat_2_8, hw_compat_2_8_len)=
;
     compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
     mc->numa_mem_align_shift =3D 23;
 }
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 549f6e0231..22e96ab353 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -774,7 +774,6 @@ static void ccw_machine_2_8_instance_options(MachineS=
tate *machine)
 static void ccw_machine_2_8_class_options(MachineClass *mc)
 {
     static GlobalProperty compat[] =3D {
-        HW_COMPAT_2_8
         {
             .driver   =3D TYPE_S390_FLIC_COMMON,
             .property =3D "adapter_routes_max_batch",
@@ -783,6 +782,7 @@ static void ccw_machine_2_8_class_options(MachineClas=
s *mc)
     };
=20
     ccw_machine_2_9_class_options(mc);
+    compat_props_add(mc->compat_props, hw_compat_2_8, hw_compat_2_8_len)=
;
     compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
 }
 DEFINE_CCW_MACHINE(2_8, "2.8", false);
--=20
2.20.1.2.gb21ebb671b
