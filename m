Received: from eggs.gnu.org ([2001:4830:134:3::10]:53885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gXCOp-00034Y-8Q
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 16:50:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gXCOh-0006cw-Da
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 16:50:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50714)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gXCOd-0006YX-FY
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 16:50:25 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6A52530016E7
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 21:50:15 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 13 Dec 2018 01:48:36 +0400
Message-Id: <20181212214850.29953-15-marcandre.lureau@redhat.com>
In-Reply-To: <20181212214850.29953-1-marcandre.lureau@redhat.com>
References: <20181212214850.29953-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 14/28] compat: replace PC_COMPAT_2_6 &
 HW_COMPAT_2_6 macros
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
 include/hw/boards.h        |  3 +++
 include/hw/compat.h        | 15 ---------------
 include/hw/i386/pc.h       | 23 ++---------------------
 hw/arm/virt.c              |  5 +----
 hw/core/machine.c          | 17 +++++++++++++++++
 hw/i386/pc.c               | 23 +++++++++++++++++++++++
 hw/i386/pc_piix.c          |  6 ++----
 hw/i386/pc_q35.c           |  6 ++----
 hw/ppc/spapr.c             |  2 +-
 hw/s390x/s390-virtio-ccw.c |  2 +-
 10 files changed, 52 insertions(+), 50 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index 611b34b26a..a9d413cdb7 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -311,4 +311,7 @@ extern const size_t hw_compat_2_8_len;
 extern GlobalProperty hw_compat_2_7[];
 extern const size_t hw_compat_2_7_len;
=20
+extern GlobalProperty hw_compat_2_6[];
+extern const size_t hw_compat_2_6_len;
+
 #endif
diff --git a/include/hw/compat.h b/include/hw/compat.h
index 7ceab17401..c744233fb6 100644
--- a/include/hw/compat.h
+++ b/include/hw/compat.h
@@ -1,21 +1,6 @@
 #ifndef HW_COMPAT_H
 #define HW_COMPAT_H
=20
-#define HW_COMPAT_2_6 \
-    {\
-        .driver   =3D "virtio-mmio",\
-        .property =3D "format_transport_address",\
-        .value    =3D "off",\
-    },{\
-        .driver   =3D "virtio-pci",\
-        .property =3D "disable-modern",\
-        .value    =3D "on",\
-    },{\
-        .driver   =3D "virtio-pci",\
-        .property =3D "disable-legacy",\
-        .value    =3D "off",\
-    },
-
 #define HW_COMPAT_2_5 \
     {\
         .driver   =3D "isa-fdc",\
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 504fbc79a9..ca62def2c9 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -318,27 +318,8 @@ extern const size_t pc_compat_2_8_len;
 extern GlobalProperty pc_compat_2_7[];
 extern const size_t pc_compat_2_7_len;
=20
-#define PC_COMPAT_2_6 \
-    HW_COMPAT_2_6 \
-    {\
-        .driver   =3D TYPE_X86_CPU,\
-        .property =3D "cpuid-0xb",\
-        .value    =3D "off",\
-    },{\
-        .driver   =3D "vmxnet3",\
-        .property =3D "romfile",\
-        .value    =3D "",\
-    },\
-    {\
-        .driver =3D TYPE_X86_CPU,\
-        .property =3D "fill-mtrr-mask",\
-        .value =3D "off",\
-    },\
-    {\
-        .driver   =3D "apic-common",\
-        .property =3D "legacy-instance-id",\
-        .value    =3D "on",\
-    },
+extern GlobalProperty pc_compat_2_6[];
+extern const size_t pc_compat_2_6_len;
=20
 #define PC_COMPAT_2_5 \
     HW_COMPAT_2_5
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index ce0152ec54..ec59819a91 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1952,12 +1952,9 @@ DEFINE_VIRT_MACHINE(2, 7)
 static void virt_machine_2_6_options(MachineClass *mc)
 {
     VirtMachineClass *vmc =3D VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
-    static GlobalProperty compat[] =3D {
-        HW_COMPAT_2_6
-    };
=20
     virt_machine_2_7_options(mc);
-    compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
+    compat_props_add(mc->compat_props, hw_compat_2_6, hw_compat_2_6_len)=
;
     vmc->disallow_affinity_adjustment =3D true;
     /* Disable PMU for 2.6 as PMU support was first introduced in 2.7 */
     vmc->no_pmu =3D true;
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 92f4c71354..5f1af02c86 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -183,6 +183,23 @@ GlobalProperty hw_compat_2_7[] =3D {
 };
 const size_t hw_compat_2_7_len =3D G_N_ELEMENTS(hw_compat_2_7);
=20
+GlobalProperty hw_compat_2_6[] =3D {
+    {
+        .driver   =3D "virtio-mmio",
+        .property =3D "format_transport_address",
+        .value    =3D "off",
+    },{
+        .driver   =3D "virtio-pci",
+        .property =3D "disable-modern",
+        .value    =3D "on",
+    },{
+        .driver   =3D "virtio-pci",
+        .property =3D "disable-legacy",
+        .value    =3D "off",
+    },
+};
+const size_t hw_compat_2_6_len =3D G_N_ELEMENTS(hw_compat_2_6);
+
 static char *machine_get_accel(Object *obj, Error **errp)
 {
     MachineState *ms =3D MACHINE(obj);
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index eb305b4122..85988bbf78 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -252,6 +252,29 @@ GlobalProperty pc_compat_2_7[] =3D {
 };
 const size_t pc_compat_2_7_len =3D G_N_ELEMENTS(pc_compat_2_7);
=20
+GlobalProperty pc_compat_2_6[] =3D {
+    {
+        .driver   =3D TYPE_X86_CPU,
+        .property =3D "cpuid-0xb",
+        .value    =3D "off",
+    },{
+        .driver   =3D "vmxnet3",
+        .property =3D "romfile",
+        .value    =3D "",
+    },
+    {
+        .driver =3D TYPE_X86_CPU,
+        .property =3D "fill-mtrr-mask",
+        .value =3D "off",
+    },
+    {
+        .driver   =3D "apic-common",
+        .property =3D "legacy-instance-id",
+        .value    =3D "on",
+    }
+};
+const size_t pc_compat_2_6_len =3D G_N_ELEMENTS(pc_compat_2_6);
+
 void gsi_handler(void *opaque, int n, int level)
 {
     GSIState *s =3D opaque;
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index b956b4abe0..5f3dc8a809 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -525,14 +525,12 @@ DEFINE_I440FX_MACHINE(v2_7, "pc-i440fx-2.7", NULL,
 static void pc_i440fx_2_6_machine_options(MachineClass *m)
 {
     PCMachineClass *pcmc =3D PC_MACHINE_CLASS(m);
-    static GlobalProperty compat[] =3D {
-        PC_COMPAT_2_6
-    };
=20
     pc_i440fx_2_7_machine_options(m);
     pcmc->legacy_cpu_hotplug =3D true;
     pcmc->linuxboot_dma_enabled =3D false;
-    compat_props_add(m->compat_props, compat, G_N_ELEMENTS(compat));
+    compat_props_add(m->compat_props, hw_compat_2_6, hw_compat_2_6_len);
+    compat_props_add(m->compat_props, pc_compat_2_6, pc_compat_2_6_len);
 }
=20
 DEFINE_I440FX_MACHINE(v2_6, "pc-i440fx-2.6", NULL,
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index e321f14cb5..063df36cad 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -410,14 +410,12 @@ DEFINE_Q35_MACHINE(v2_7, "pc-q35-2.7", NULL,
 static void pc_q35_2_6_machine_options(MachineClass *m)
 {
     PCMachineClass *pcmc =3D PC_MACHINE_CLASS(m);
-    static GlobalProperty compat[] =3D {
-        PC_COMPAT_2_6
-    };
=20
     pc_q35_2_7_machine_options(m);
     pcmc->legacy_cpu_hotplug =3D true;
     pcmc->linuxboot_dma_enabled =3D false;
-    compat_props_add(m->compat_props, compat, G_N_ELEMENTS(compat));
+    compat_props_add(m->compat_props, hw_compat_2_6, hw_compat_2_6_len);
+    compat_props_add(m->compat_props, pc_compat_2_6, pc_compat_2_6_len);
 }
=20
 DEFINE_Q35_MACHINE(v2_6, "pc-q35-2.6", NULL,
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 445996c0b4..797f480564 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4203,7 +4203,6 @@ DEFINE_SPAPR_MACHINE(2_7, "2.7", false);
 static void spapr_machine_2_6_class_options(MachineClass *mc)
 {
     static GlobalProperty compat[] =3D {
-        HW_COMPAT_2_6
         {
             .driver   =3D TYPE_SPAPR_PCI_HOST_BRIDGE,
             .property =3D "ddw",
@@ -4213,6 +4212,7 @@ static void spapr_machine_2_6_class_options(Machine=
Class *mc)
=20
     spapr_machine_2_7_class_options(mc);
     mc->has_hotpluggable_cpus =3D false;
+    compat_props_add(mc->compat_props, hw_compat_2_6, hw_compat_2_6_len)=
;
     compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
 }
=20
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 7ef024b7e4..73b7bf4fe3 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -799,7 +799,6 @@ static void ccw_machine_2_6_class_options(MachineClas=
s *mc)
 {
     S390CcwMachineClass *s390mc =3D S390_MACHINE_CLASS(mc);
     static GlobalProperty compat[] =3D {
-        HW_COMPAT_2_6
         {
             .driver   =3D TYPE_S390_IPL,
             .property =3D "iplbext_migration",
@@ -813,6 +812,7 @@ static void ccw_machine_2_6_class_options(MachineClas=
s *mc)
=20
     s390mc->ri_allowed =3D false;
     ccw_machine_2_7_class_options(mc);
+    compat_props_add(mc->compat_props, hw_compat_2_6, hw_compat_2_6_len)=
;
     compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
 }
 DEFINE_CCW_MACHINE(2_6, "2.6", false);
--=20
2.20.0
