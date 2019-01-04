Received: from eggs.gnu.org ([208.118.235.92]:44076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gfTKE-00040p-SB
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 12:32:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gfTKD-0001Rj-35
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 12:32:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39906)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gfTKC-0001Qf-Rg
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 12:32:01 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri,  4 Jan 2019 21:30:27 +0400
Message-Id: <20190104173042.32714-14-marcandre.lureau@redhat.com>
In-Reply-To: <20190104173042.32714-1-marcandre.lureau@redhat.com>
References: <20190104173042.32714-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 13/28] compat: replace PC_COMPAT_2_7 &
 HW_COMPAT_2_7 macros
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
 include/hw/compat.h        | 23 -----------------------
 include/hw/i386/pc.h       | 34 ++--------------------------------
 hw/arm/virt.c              |  5 +----
 hw/core/machine.c          | 25 +++++++++++++++++++++++++
 hw/i386/pc.c               | 34 ++++++++++++++++++++++++++++++++++
 hw/i386/pc_piix.c          |  7 ++-----
 hw/i386/pc_q35.c           |  7 ++-----
 hw/ppc/spapr.c             |  2 +-
 hw/s390x/s390-virtio-ccw.c |  5 +----
 10 files changed, 71 insertions(+), 74 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index 03278a8c39..ac4854db0f 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -309,4 +309,7 @@ extern const size_t hw_compat_2_9_len;
 extern GlobalProperty hw_compat_2_8[];
 extern const size_t hw_compat_2_8_len;
=20
+extern GlobalProperty hw_compat_2_7[];
+extern const size_t hw_compat_2_7_len;
+
 #endif
diff --git a/include/hw/compat.h b/include/hw/compat.h
index 65d6748054..7ceab17401 100644
--- a/include/hw/compat.h
+++ b/include/hw/compat.h
@@ -1,29 +1,6 @@
 #ifndef HW_COMPAT_H
 #define HW_COMPAT_H
=20
-#define HW_COMPAT_2_7 \
-    {\
-        .driver   =3D "virtio-pci",\
-        .property =3D "page-per-vq",\
-        .value    =3D "on",\
-    },{\
-        .driver   =3D "virtio-serial-device",\
-        .property =3D "emergency-write",\
-        .value    =3D "off",\
-    },{\
-        .driver   =3D "ioapic",\
-        .property =3D "version",\
-        .value    =3D "0x11",\
-    },{\
-        .driver   =3D "intel-iommu",\
-        .property =3D "x-buggy-eim",\
-        .value    =3D "true",\
-    },{\
-        .driver   =3D "virtio-pci",\
-        .property =3D "x-ignore-backend-features",\
-        .value    =3D "on",\
-    },
-
 #define HW_COMPAT_2_6 \
     {\
         .driver   =3D "virtio-mmio",\
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 12c47d2506..504fbc79a9 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -315,38 +315,8 @@ extern const size_t pc_compat_2_9_len;
 extern GlobalProperty pc_compat_2_8[];
 extern const size_t pc_compat_2_8_len;
=20
-#define PC_COMPAT_2_7 \
-    HW_COMPAT_2_7 \
-    {\
-        .driver   =3D TYPE_X86_CPU,\
-        .property =3D "l3-cache",\
-        .value    =3D "off",\
-    },\
-    {\
-        .driver   =3D TYPE_X86_CPU,\
-        .property =3D "full-cpuid-auto-level",\
-        .value    =3D "off",\
-    },\
-    {\
-        .driver   =3D "Opteron_G3" "-" TYPE_X86_CPU,\
-        .property =3D "family",\
-        .value    =3D "15",\
-    },\
-    {\
-        .driver   =3D "Opteron_G3" "-" TYPE_X86_CPU,\
-        .property =3D "model",\
-        .value    =3D "6",\
-    },\
-    {\
-        .driver   =3D "Opteron_G3" "-" TYPE_X86_CPU,\
-        .property =3D "stepping",\
-        .value    =3D "1",\
-    },\
-    {\
-        .driver   =3D "isa-pcspk",\
-        .property =3D "migrate",\
-        .value    =3D "off",\
-    },
+extern GlobalProperty pc_compat_2_7[];
+extern const size_t pc_compat_2_7_len;
=20
 #define PC_COMPAT_2_6 \
     HW_COMPAT_2_6 \
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index d4dee3ece7..0134d0d439 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1939,12 +1939,9 @@ DEFINE_VIRT_MACHINE(2, 8)
 static void virt_machine_2_7_options(MachineClass *mc)
 {
     VirtMachineClass *vmc =3D VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
-    static GlobalProperty compat[] =3D {
-        HW_COMPAT_2_7
-    };
=20
     virt_machine_2_8_options(mc);
-    compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
+    compat_props_add(mc->compat_props, hw_compat_2_7, hw_compat_2_7_len)=
;
     /* ITS was introduced with 2.8 */
     vmc->no_its =3D true;
     /* Stick with 1K pages for migration compatibility */
diff --git a/hw/core/machine.c b/hw/core/machine.c
index efda98a9ab..cc92b0cc84 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -168,6 +168,31 @@ GlobalProperty hw_compat_2_8[] =3D {
 };
 const size_t hw_compat_2_8_len =3D G_N_ELEMENTS(hw_compat_2_8);
=20
+GlobalProperty hw_compat_2_7[] =3D {
+    {
+        .driver   =3D "virtio-pci",
+        .property =3D "page-per-vq",
+        .value    =3D "on",
+    },{
+        .driver   =3D "virtio-serial-device",
+        .property =3D "emergency-write",
+        .value    =3D "off",
+    },{
+        .driver   =3D "ioapic",
+        .property =3D "version",
+        .value    =3D "0x11",
+    },{
+        .driver   =3D "intel-iommu",
+        .property =3D "x-buggy-eim",
+        .value    =3D "true",
+    },{
+        .driver   =3D "virtio-pci",
+        .property =3D "x-ignore-backend-features",
+        .value    =3D "on",
+    },
+};
+const size_t hw_compat_2_7_len =3D G_N_ELEMENTS(hw_compat_2_7);
+
 static char *machine_get_accel(Object *obj, Error **errp)
 {
     MachineState *ms =3D MACHINE(obj);
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index b094e5b2ad..ed46f9c27f 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -224,6 +224,40 @@ GlobalProperty pc_compat_2_8[] =3D {
 };
 const size_t pc_compat_2_8_len =3D G_N_ELEMENTS(pc_compat_2_8);
=20
+GlobalProperty pc_compat_2_7[] =3D {
+    {
+        .driver   =3D TYPE_X86_CPU,
+        .property =3D "l3-cache",
+        .value    =3D "off",
+    },
+    {
+        .driver   =3D TYPE_X86_CPU,
+        .property =3D "full-cpuid-auto-level",
+        .value    =3D "off",
+    },
+    {
+        .driver   =3D "Opteron_G3" "-" TYPE_X86_CPU,
+        .property =3D "family",
+        .value    =3D "15",
+    },
+    {
+        .driver   =3D "Opteron_G3" "-" TYPE_X86_CPU,
+        .property =3D "model",
+        .value    =3D "6",
+    },
+    {
+        .driver   =3D "Opteron_G3" "-" TYPE_X86_CPU,
+        .property =3D "stepping",
+        .value    =3D "1",
+    },
+    {
+        .driver   =3D "isa-pcspk",
+        .property =3D "migrate",
+        .value    =3D "off",
+    },
+};
+const size_t pc_compat_2_7_len =3D G_N_ELEMENTS(pc_compat_2_7);
+
 void gsi_handler(void *opaque, int n, int level)
 {
     GSIState *s =3D opaque;
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index b1fa038a69..182d868de8 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -514,12 +514,9 @@ DEFINE_I440FX_MACHINE(v2_8, "pc-i440fx-2.8", NULL,
=20
 static void pc_i440fx_2_7_machine_options(MachineClass *m)
 {
-    static GlobalProperty compat[] =3D {
-        PC_COMPAT_2_7
-    };
-
     pc_i440fx_2_8_machine_options(m);
-    compat_props_add(m->compat_props, compat, G_N_ELEMENTS(compat));
+    compat_props_add(m->compat_props, hw_compat_2_7, hw_compat_2_7_len);
+    compat_props_add(m->compat_props, pc_compat_2_7, pc_compat_2_7_len);
 }
=20
 DEFINE_I440FX_MACHINE(v2_7, "pc-i440fx-2.7", NULL,
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 7e608b3ffb..35377524d0 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -400,13 +400,10 @@ DEFINE_Q35_MACHINE(v2_8, "pc-q35-2.8", NULL,
=20
 static void pc_q35_2_7_machine_options(MachineClass *m)
 {
-    static GlobalProperty compat[] =3D {
-        PC_COMPAT_2_7
-    };
-
     pc_q35_2_8_machine_options(m);
     m->max_cpus =3D 255;
-    compat_props_add(m->compat_props, compat, G_N_ELEMENTS(compat));
+    compat_props_add(m->compat_props, hw_compat_2_7, hw_compat_2_7_len);
+    compat_props_add(m->compat_props, pc_compat_2_7, pc_compat_2_7_len);
 }
=20
 DEFINE_Q35_MACHINE(v2_7, "pc-q35-2.7", NULL,
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index a19353827f..c83b0c0d66 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4223,7 +4223,6 @@ static void spapr_machine_2_7_class_options(Machine=
Class *mc)
 {
     sPAPRMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
     static GlobalProperty compat[] =3D {
-        HW_COMPAT_2_7
         {
             .driver   =3D TYPE_SPAPR_PCI_HOST_BRIDGE,
             .property =3D "mem_win_size",
@@ -4249,6 +4248,7 @@ static void spapr_machine_2_7_class_options(Machine=
Class *mc)
     spapr_machine_2_8_class_options(mc);
     mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("power7_v2.3");
     mc->default_machine_opts =3D "modern-hotplug-events=3Doff";
+    compat_props_add(mc->compat_props, hw_compat_2_7, hw_compat_2_7_len)=
;
     compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
     smc->phb_placement =3D phb_placement_2_7;
 }
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 22e96ab353..f28feedd4b 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -795,13 +795,10 @@ static void ccw_machine_2_7_instance_options(Machin=
eState *machine)
 static void ccw_machine_2_7_class_options(MachineClass *mc)
 {
     S390CcwMachineClass *s390mc =3D S390_MACHINE_CLASS(mc);
-    static GlobalProperty compat[] =3D {
-        HW_COMPAT_2_7
-    };
=20
     s390mc->cpu_model_allowed =3D false;
     ccw_machine_2_8_class_options(mc);
-    compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
+    compat_props_add(mc->compat_props, hw_compat_2_7, hw_compat_2_7_len)=
;
 }
 DEFINE_CCW_MACHINE(2_7, "2.7", false);
=20
--=20
2.20.1.2.gb21ebb671b
