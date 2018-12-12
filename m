Received: from eggs.gnu.org ([2001:4830:134:3::10]:54003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gXCP2-0003J3-IN
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 16:50:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gXCP1-0006rK-6f
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 16:50:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56186)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gXCP0-0006oJ-2o
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 16:50:47 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C5769307DAB0
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 21:50:40 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 13 Dec 2018 01:48:41 +0400
Message-Id: <20181212214850.29953-20-marcandre.lureau@redhat.com>
In-Reply-To: <20181212214850.29953-1-marcandre.lureau@redhat.com>
References: <20181212214850.29953-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 19/28] compat: replace PC_COMPAT_2_1 &
 HW_COMPAT_2_1 macros
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

Use static arrays instead.  I decided to rename the conflicting
pc_compat_2_1() function with pc_compat_2_1_fn().

Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/hw/boards.h  |  3 +++
 include/hw/compat.h  | 31 -------------------------------
 include/hw/i386/pc.h | 17 +++--------------
 hw/core/machine.c    | 33 +++++++++++++++++++++++++++++++++
 hw/i386/pc.c         | 15 +++++++++++++++
 hw/i386/pc_piix.c    | 12 +++++-------
 hw/ppc/spapr.c       |  6 +-----
 7 files changed, 60 insertions(+), 57 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index 0b0a1f4079..d4aca54968 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -326,4 +326,7 @@ extern const size_t hw_compat_2_3_len;
 extern GlobalProperty hw_compat_2_2[];
 extern const size_t hw_compat_2_2_len;
=20
+extern GlobalProperty hw_compat_2_1[];
+extern const size_t hw_compat_2_1_len;
+
 #endif
diff --git a/include/hw/compat.h b/include/hw/compat.h
index 3bd91908e4..b2d0bdd599 100644
--- a/include/hw/compat.h
+++ b/include/hw/compat.h
@@ -1,35 +1,4 @@
 #ifndef HW_COMPAT_H
 #define HW_COMPAT_H
=20
-#define HW_COMPAT_2_1 \
-    {\
-        .driver   =3D "intel-hda",\
-        .property =3D "old_msi_addr",\
-        .value    =3D "on",\
-    },{\
-        .driver   =3D "VGA",\
-        .property =3D "qemu-extended-regs",\
-        .value    =3D "off",\
-    },{\
-        .driver   =3D "secondary-vga",\
-        .property =3D "qemu-extended-regs",\
-        .value    =3D "off",\
-    },{\
-        .driver   =3D "virtio-scsi-pci",\
-        .property =3D "any_layout",\
-        .value    =3D "off",\
-    },{\
-        .driver   =3D "usb-mouse",\
-        .property =3D "usb_version",\
-        .value    =3D stringify(1),\
-    },{\
-        .driver   =3D "usb-kbd",\
-        .property =3D "usb_version",\
-        .value    =3D stringify(1),\
-    },{\
-        .driver   =3D "virtio-pci",\
-        .property =3D "virtio-pci-bus-master-bug-migration",\
-        .value    =3D "on",\
-    },
-
 #endif /* HW_COMPAT_H */
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 49b45bb79d..784ea7a92c 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -333,6 +333,9 @@ extern const size_t pc_compat_2_3_len;
 extern GlobalProperty pc_compat_2_2[];
 extern const size_t pc_compat_2_2_len;
=20
+extern GlobalProperty pc_compat_2_1[];
+extern const size_t pc_compat_2_1_len;
+
 /* Helper for setting model-id for CPU models that changed model-id
  * depending on QEMU versions up to QEMU 2.4.
  */
@@ -353,20 +356,6 @@ extern const size_t pc_compat_2_2_len;
         .value    =3D "QEMU Virtual CPU version " v,\
     },
=20
-#define PC_COMPAT_2_1 \
-    HW_COMPAT_2_1 \
-    PC_CPU_MODEL_IDS("2.1.0") \
-    {\
-        .driver =3D "coreduo" "-" TYPE_X86_CPU,\
-        .property =3D "vmx",\
-        .value =3D "on",\
-    },\
-    {\
-        .driver =3D "core2duo" "-" TYPE_X86_CPU,\
-        .property =3D "vmx",\
-        .value =3D "on",\
-    },
-
 #define PC_COMPAT_2_0 \
     PC_CPU_MODEL_IDS("2.0.0") \
     {\
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 8f387e9063..7570408caa 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -299,6 +299,39 @@ const size_t hw_compat_2_3_len =3D G_N_ELEMENTS(hw_c=
ompat_2_3);
 GlobalProperty hw_compat_2_2[] =3D {};
 const size_t hw_compat_2_2_len =3D G_N_ELEMENTS(hw_compat_2_2);
=20
+GlobalProperty hw_compat_2_1[] =3D {
+    {
+        .driver   =3D "intel-hda",
+        .property =3D "old_msi_addr",
+        .value    =3D "on",
+    },{
+        .driver   =3D "VGA",
+        .property =3D "qemu-extended-regs",
+        .value    =3D "off",
+    },{
+        .driver   =3D "secondary-vga",
+        .property =3D "qemu-extended-regs",
+        .value    =3D "off",
+    },{
+        .driver   =3D "virtio-scsi-pci",
+        .property =3D "any_layout",
+        .value    =3D "off",
+    },{
+        .driver   =3D "usb-mouse",
+        .property =3D "usb_version",
+        .value    =3D stringify(1),
+    },{
+        .driver   =3D "usb-kbd",
+        .property =3D "usb_version",
+        .value    =3D stringify(1),
+    },{
+        .driver   =3D "virtio-pci",
+        .property =3D "virtio-pci-bus-master-bug-migration",
+        .value    =3D "on",
+    },
+};
+const size_t hw_compat_2_1_len =3D G_N_ELEMENTS(hw_compat_2_1);
+
 static char *machine_get_accel(Object *obj, Error **errp)
 {
     MachineState *ms =3D MACHINE(obj);
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 045d7071d9..46132827e5 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -530,6 +530,21 @@ GlobalProperty pc_compat_2_2[] =3D {
 };
 const size_t pc_compat_2_2_len =3D G_N_ELEMENTS(pc_compat_2_2);
=20
+GlobalProperty pc_compat_2_1[] =3D {
+    PC_CPU_MODEL_IDS("2.1.0")
+    {
+        .driver =3D "coreduo" "-" TYPE_X86_CPU,
+        .property =3D "vmx",
+        .value =3D "on",
+    },
+    {
+        .driver =3D "core2duo" "-" TYPE_X86_CPU,
+        .property =3D "vmx",
+        .value =3D "on",
+    },
+};
+const size_t pc_compat_2_1_len =3D G_N_ELEMENTS(pc_compat_2_1);
+
 void gsi_handler(void *opaque, int n, int level)
 {
     GSIState *s =3D opaque;
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 6c250e64fc..c7b5e0a3ad 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -323,7 +323,7 @@ static void pc_compat_2_2_fn(MachineState *machine)
     pc_compat_2_3_fn(machine);
 }
=20
-static void pc_compat_2_1(MachineState *machine)
+static void pc_compat_2_1_fn(MachineState *machine)
 {
     pc_compat_2_2_fn(machine);
     x86_cpu_change_kvm_default("svm", NULL);
@@ -331,7 +331,7 @@ static void pc_compat_2_1(MachineState *machine)
=20
 static void pc_compat_2_0(MachineState *machine)
 {
-    pc_compat_2_1(machine);
+    pc_compat_2_1_fn(machine);
 }
=20
 static void pc_compat_1_7(MachineState *machine)
@@ -593,19 +593,17 @@ DEFINE_I440FX_MACHINE(v2_2, "pc-i440fx-2.2", pc_com=
pat_2_2_fn,
 static void pc_i440fx_2_1_machine_options(MachineClass *m)
 {
     PCMachineClass *pcmc =3D PC_MACHINE_CLASS(m);
-    static GlobalProperty compat[] =3D {
-        PC_COMPAT_2_1
-    };
=20
     pc_i440fx_2_2_machine_options(m);
     m->hw_version =3D "2.1.0";
     m->default_display =3D NULL;
-    compat_props_add(m->compat_props, compat, G_N_ELEMENTS(compat));
+    compat_props_add(m->compat_props, hw_compat_2_1, hw_compat_2_1_len);
+    compat_props_add(m->compat_props, pc_compat_2_1, pc_compat_2_1_len);
     pcmc->smbios_uuid_encoded =3D false;
     pcmc->enforce_aligned_dimm =3D false;
 }
=20
-DEFINE_I440FX_MACHINE(v2_1, "pc-i440fx-2.1", pc_compat_2_1,
+DEFINE_I440FX_MACHINE(v2_1, "pc-i440fx-2.1", pc_compat_2_1_fn,
                       pc_i440fx_2_1_machine_options);
=20
 static void pc_i440fx_2_0_machine_options(MachineClass *m)
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 2e71eb08e9..1c5b0e40b1 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4302,12 +4302,8 @@ DEFINE_SPAPR_MACHINE(2_2, "2.2", false);
=20
 static void spapr_machine_2_1_class_options(MachineClass *mc)
 {
-    static GlobalProperty compat[] =3D {
-        HW_COMPAT_2_1
-    };
-
     spapr_machine_2_2_class_options(mc);
-    compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
+    compat_props_add(mc->compat_props, hw_compat_2_1, hw_compat_2_1_len)=
;
 }
 DEFINE_SPAPR_MACHINE(2_1, "2.1", false);
=20
--=20
2.20.0
