Received: from eggs.gnu.org ([2001:4830:134:3::10]:53955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gXCOy-0003FF-DJ
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 16:50:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gXCOw-0006p6-HL
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 16:50:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55212)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gXCOt-0006ln-Vg
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 16:50:40 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 03FE630020DB
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 21:50:36 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 13 Dec 2018 01:48:40 +0400
Message-Id: <20181212214850.29953-19-marcandre.lureau@redhat.com>
In-Reply-To: <20181212214850.29953-1-marcandre.lureau@redhat.com>
References: <20181212214850.29953-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 18/28] compat: replace PC_COMPAT_2_2 &
 HW_COMPAT_2_2 macros
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
pc_compat_2_2() function with pc_compat_2_2_fn().

Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/hw/boards.h  |  3 ++
 include/hw/compat.h  |  3 --
 include/hw/i386/pc.h | 97 ++------------------------------------------
 hw/core/machine.c    |  3 ++
 hw/i386/pc.c         | 95 +++++++++++++++++++++++++++++++++++++++++++
 hw/i386/pc_piix.c    | 12 +++---
 hw/ppc/spapr.c       |  2 +-
 7 files changed, 110 insertions(+), 105 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index a51d896a70..0b0a1f4079 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -323,4 +323,7 @@ extern const size_t hw_compat_2_4_len;
 extern GlobalProperty hw_compat_2_3[];
 extern const size_t hw_compat_2_3_len;
=20
+extern GlobalProperty hw_compat_2_2[];
+extern const size_t hw_compat_2_2_len;
+
 #endif
diff --git a/include/hw/compat.h b/include/hw/compat.h
index fbe64d5983..3bd91908e4 100644
--- a/include/hw/compat.h
+++ b/include/hw/compat.h
@@ -1,9 +1,6 @@
 #ifndef HW_COMPAT_H
 #define HW_COMPAT_H
=20
-#define HW_COMPAT_2_2 \
-    /* empty */
-
 #define HW_COMPAT_2_1 \
     {\
         .driver   =3D "intel-hda",\
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index def40cd545..49b45bb79d 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -330,6 +330,9 @@ extern const size_t pc_compat_2_4_len;
 extern GlobalProperty pc_compat_2_3[];
 extern const size_t pc_compat_2_3_len;
=20
+extern GlobalProperty pc_compat_2_2[];
+extern const size_t pc_compat_2_2_len;
+
 /* Helper for setting model-id for CPU models that changed model-id
  * depending on QEMU versions up to QEMU 2.4.
  */
@@ -350,100 +353,6 @@ extern const size_t pc_compat_2_3_len;
         .value    =3D "QEMU Virtual CPU version " v,\
     },
=20
-#define PC_COMPAT_2_2 \
-    HW_COMPAT_2_2 \
-    PC_CPU_MODEL_IDS("2.2.0") \
-    {\
-        .driver =3D "kvm64" "-" TYPE_X86_CPU,\
-        .property =3D "vme",\
-        .value =3D "off",\
-    },\
-    {\
-        .driver =3D "kvm32" "-" TYPE_X86_CPU,\
-        .property =3D "vme",\
-        .value =3D "off",\
-    },\
-    {\
-        .driver =3D "Conroe" "-" TYPE_X86_CPU,\
-        .property =3D "vme",\
-        .value =3D "off",\
-    },\
-    {\
-        .driver =3D "Penryn" "-" TYPE_X86_CPU,\
-        .property =3D "vme",\
-        .value =3D "off",\
-    },\
-    {\
-        .driver =3D "Nehalem" "-" TYPE_X86_CPU,\
-        .property =3D "vme",\
-        .value =3D "off",\
-    },\
-    {\
-        .driver =3D "Westmere" "-" TYPE_X86_CPU,\
-        .property =3D "vme",\
-        .value =3D "off",\
-    },\
-    {\
-        .driver =3D "SandyBridge" "-" TYPE_X86_CPU,\
-        .property =3D "vme",\
-        .value =3D "off",\
-    },\
-    {\
-        .driver =3D "Haswell" "-" TYPE_X86_CPU,\
-        .property =3D "vme",\
-        .value =3D "off",\
-    },\
-    {\
-        .driver =3D "Broadwell" "-" TYPE_X86_CPU,\
-        .property =3D "vme",\
-        .value =3D "off",\
-    },\
-    {\
-        .driver =3D "Opteron_G1" "-" TYPE_X86_CPU,\
-        .property =3D "vme",\
-        .value =3D "off",\
-    },\
-    {\
-        .driver =3D "Opteron_G2" "-" TYPE_X86_CPU,\
-        .property =3D "vme",\
-        .value =3D "off",\
-    },\
-    {\
-        .driver =3D "Opteron_G3" "-" TYPE_X86_CPU,\
-        .property =3D "vme",\
-        .value =3D "off",\
-    },\
-    {\
-        .driver =3D "Opteron_G4" "-" TYPE_X86_CPU,\
-        .property =3D "vme",\
-        .value =3D "off",\
-    },\
-    {\
-        .driver =3D "Opteron_G5" "-" TYPE_X86_CPU,\
-        .property =3D "vme",\
-        .value =3D "off",\
-    },\
-    {\
-        .driver =3D "Haswell" "-" TYPE_X86_CPU,\
-        .property =3D "f16c",\
-        .value =3D "off",\
-    },\
-    {\
-        .driver =3D "Haswell" "-" TYPE_X86_CPU,\
-        .property =3D "rdrand",\
-        .value =3D "off",\
-    },\
-    {\
-        .driver =3D "Broadwell" "-" TYPE_X86_CPU,\
-        .property =3D "f16c",\
-        .value =3D "off",\
-    },\
-    {\
-        .driver =3D "Broadwell" "-" TYPE_X86_CPU,\
-        .property =3D "rdrand",\
-        .value =3D "off",\
-    },
-
 #define PC_COMPAT_2_1 \
     HW_COMPAT_2_1 \
     PC_CPU_MODEL_IDS("2.1.0") \
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 449f7ec8f6..8f387e9063 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -296,6 +296,9 @@ GlobalProperty hw_compat_2_3[] =3D {
 };
 const size_t hw_compat_2_3_len =3D G_N_ELEMENTS(hw_compat_2_3);
=20
+GlobalProperty hw_compat_2_2[] =3D {};
+const size_t hw_compat_2_2_len =3D G_N_ELEMENTS(hw_compat_2_2);
+
 static char *machine_get_accel(Object *obj, Error **errp)
 {
     MachineState *ms =3D MACHINE(obj);
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 02363962e0..045d7071d9 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -435,6 +435,101 @@ GlobalProperty pc_compat_2_3[] =3D {
 };
 const size_t pc_compat_2_3_len =3D G_N_ELEMENTS(pc_compat_2_3);
=20
+GlobalProperty pc_compat_2_2[] =3D {
+    PC_CPU_MODEL_IDS("2.2.0")
+    {
+        .driver =3D "kvm64" "-" TYPE_X86_CPU,
+        .property =3D "vme",
+        .value =3D "off",
+    },
+    {
+        .driver =3D "kvm32" "-" TYPE_X86_CPU,
+        .property =3D "vme",
+        .value =3D "off",
+    },
+    {
+        .driver =3D "Conroe" "-" TYPE_X86_CPU,
+        .property =3D "vme",
+        .value =3D "off",
+    },
+    {
+        .driver =3D "Penryn" "-" TYPE_X86_CPU,
+        .property =3D "vme",
+        .value =3D "off",
+    },
+    {
+        .driver =3D "Nehalem" "-" TYPE_X86_CPU,
+        .property =3D "vme",
+        .value =3D "off",
+    },
+    {
+        .driver =3D "Westmere" "-" TYPE_X86_CPU,
+        .property =3D "vme",
+        .value =3D "off",
+    },
+    {
+        .driver =3D "SandyBridge" "-" TYPE_X86_CPU,
+        .property =3D "vme",
+        .value =3D "off",
+    },
+    {
+        .driver =3D "Haswell" "-" TYPE_X86_CPU,
+        .property =3D "vme",
+        .value =3D "off",
+    },
+    {
+        .driver =3D "Broadwell" "-" TYPE_X86_CPU,
+        .property =3D "vme",
+        .value =3D "off",
+    },
+    {
+        .driver =3D "Opteron_G1" "-" TYPE_X86_CPU,
+        .property =3D "vme",
+        .value =3D "off",
+    },
+    {
+        .driver =3D "Opteron_G2" "-" TYPE_X86_CPU,
+        .property =3D "vme",
+        .value =3D "off",
+    },
+    {
+        .driver =3D "Opteron_G3" "-" TYPE_X86_CPU,
+        .property =3D "vme",
+        .value =3D "off",
+    },
+    {
+        .driver =3D "Opteron_G4" "-" TYPE_X86_CPU,
+        .property =3D "vme",
+        .value =3D "off",
+    },
+    {
+        .driver =3D "Opteron_G5" "-" TYPE_X86_CPU,
+        .property =3D "vme",
+        .value =3D "off",
+    },
+    {
+        .driver =3D "Haswell" "-" TYPE_X86_CPU,
+        .property =3D "f16c",
+        .value =3D "off",
+    },
+    {
+        .driver =3D "Haswell" "-" TYPE_X86_CPU,
+        .property =3D "rdrand",
+        .value =3D "off",
+    },
+    {
+        .driver =3D "Broadwell" "-" TYPE_X86_CPU,
+        .property =3D "f16c",
+        .value =3D "off",
+    },
+    {
+        .driver =3D "Broadwell" "-" TYPE_X86_CPU,
+        .property =3D "rdrand",
+        .value =3D "off",
+    },
+};
+const size_t pc_compat_2_2_len =3D G_N_ELEMENTS(pc_compat_2_2);
+
 void gsi_handler(void *opaque, int n, int level)
 {
     GSIState *s =3D opaque;
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index d06fdf2bb9..6c250e64fc 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -318,14 +318,14 @@ static void pc_compat_2_3_fn(MachineState *machine)
     }
 }
=20
-static void pc_compat_2_2(MachineState *machine)
+static void pc_compat_2_2_fn(MachineState *machine)
 {
     pc_compat_2_3_fn(machine);
 }
=20
 static void pc_compat_2_1(MachineState *machine)
 {
-    pc_compat_2_2(machine);
+    pc_compat_2_2_fn(machine);
     x86_cpu_change_kvm_default("svm", NULL);
 }
=20
@@ -578,18 +578,16 @@ DEFINE_I440FX_MACHINE(v2_3, "pc-i440fx-2.3", pc_com=
pat_2_3_fn,
 static void pc_i440fx_2_2_machine_options(MachineClass *m)
 {
     PCMachineClass *pcmc =3D PC_MACHINE_CLASS(m);
-    static GlobalProperty compat[] =3D {
-        PC_COMPAT_2_2
-    };
=20
     pc_i440fx_2_3_machine_options(m);
     m->hw_version =3D "2.2.0";
     m->default_machine_opts =3D "firmware=3Dbios-256k.bin,suppress-vmdes=
c=3Don";
-    compat_props_add(m->compat_props, compat, G_N_ELEMENTS(compat));
+    compat_props_add(m->compat_props, hw_compat_2_2, hw_compat_2_2_len);
+    compat_props_add(m->compat_props, pc_compat_2_2, pc_compat_2_2_len);
     pcmc->rsdp_in_ram =3D false;
 }
=20
-DEFINE_I440FX_MACHINE(v2_2, "pc-i440fx-2.2", pc_compat_2_2,
+DEFINE_I440FX_MACHINE(v2_2, "pc-i440fx-2.2", pc_compat_2_2_fn,
                       pc_i440fx_2_2_machine_options);
=20
 static void pc_i440fx_2_1_machine_options(MachineClass *m)
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 29f88f2372..2e71eb08e9 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4282,7 +4282,6 @@ DEFINE_SPAPR_MACHINE(2_3, "2.3", false);
 static void spapr_machine_2_2_class_options(MachineClass *mc)
 {
     static GlobalProperty compat[] =3D {
-        HW_COMPAT_2_2
         {
             .driver   =3D TYPE_SPAPR_PCI_HOST_BRIDGE,
             .property =3D "mem_win_size",
@@ -4291,6 +4290,7 @@ static void spapr_machine_2_2_class_options(Machine=
Class *mc)
     };
=20
     spapr_machine_2_3_class_options(mc);
+    compat_props_add(mc->compat_props, hw_compat_2_2, hw_compat_2_2_len)=
;
     compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
     mc->default_machine_opts =3D "modern-hotplug-events=3Doff,suppress-v=
mdesc=3Don";
 }
--=20
2.20.0
