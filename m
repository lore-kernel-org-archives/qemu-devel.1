Received: from eggs.gnu.org ([208.118.235.92]:44235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gfTKh-0004Wb-Ex
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 12:32:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gfTKb-0001fp-Mr
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 12:32:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47178)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gfTKY-0001dZ-E5
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 12:32:24 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri,  4 Jan 2019 21:30:31 +0400
Message-Id: <20190104173042.32714-18-marcandre.lureau@redhat.com>
In-Reply-To: <20190104173042.32714-1-marcandre.lureau@redhat.com>
References: <20190104173042.32714-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 17/28] compat: replace PC_COMPAT_2_3 &
 HW_COMPAT_2_3 macros
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

Use static arrays instead.  I decided to rename the conflicting
pc_compat_2_3() function with pc_compat_2_3_fn().

Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Acked-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/boards.h  |  3 ++
 include/hw/compat.h  | 39 --------------------
 include/hw/i386/pc.h | 88 ++------------------------------------------
 hw/core/machine.c    | 41 +++++++++++++++++++++
 hw/i386/pc.c         | 86 +++++++++++++++++++++++++++++++++++++++++++
 hw/i386/pc_piix.c    | 13 +++----
 hw/ppc/spapr.c       |  2 +-
 7 files changed, 139 insertions(+), 133 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index 254b7d8919..e7e3d2bc3c 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -321,4 +321,7 @@ extern const size_t hw_compat_2_5_len;
 extern GlobalProperty hw_compat_2_4[];
 extern const size_t hw_compat_2_4_len;
=20
+extern GlobalProperty hw_compat_2_3[];
+extern const size_t hw_compat_2_3_len;
+
 #endif
diff --git a/include/hw/compat.h b/include/hw/compat.h
index 05ff05e159..fbe64d5983 100644
--- a/include/hw/compat.h
+++ b/include/hw/compat.h
@@ -1,45 +1,6 @@
 #ifndef HW_COMPAT_H
 #define HW_COMPAT_H
=20
-#define HW_COMPAT_2_3 \
-    {\
-        .driver   =3D "virtio-blk-pci",\
-        .property =3D "any_layout",\
-        .value    =3D "off",\
-    },{\
-        .driver   =3D "virtio-balloon-pci",\
-        .property =3D "any_layout",\
-        .value    =3D "off",\
-    },{\
-        .driver   =3D "virtio-serial-pci",\
-        .property =3D "any_layout",\
-        .value    =3D "off",\
-    },{\
-        .driver   =3D "virtio-9p-pci",\
-        .property =3D "any_layout",\
-        .value    =3D "off",\
-    },{\
-        .driver   =3D "virtio-rng-pci",\
-        .property =3D "any_layout",\
-        .value    =3D "off",\
-    },{\
-        .driver   =3D TYPE_PCI_DEVICE,\
-        .property =3D "x-pcie-lnksta-dllla",\
-        .value    =3D "off",\
-    },{\
-        .driver   =3D "migration",\
-        .property =3D "send-configuration",\
-        .value    =3D "off",\
-    },{\
-        .driver   =3D "migration",\
-        .property =3D "send-section-footer",\
-        .value    =3D "off",\
-    },{\
-        .driver   =3D "migration",\
-        .property =3D "store-global-state",\
-        .value    =3D "off",\
-    },
-
 #define HW_COMPAT_2_2 \
     /* empty */
=20
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index a9045f6bea..def40cd545 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -327,6 +327,9 @@ extern const size_t pc_compat_2_5_len;
 extern GlobalProperty pc_compat_2_4[];
 extern const size_t pc_compat_2_4_len;
=20
+extern GlobalProperty pc_compat_2_3[];
+extern const size_t pc_compat_2_3_len;
+
 /* Helper for setting model-id for CPU models that changed model-id
  * depending on QEMU versions up to QEMU 2.4.
  */
@@ -347,91 +350,6 @@ extern const size_t pc_compat_2_4_len;
         .value    =3D "QEMU Virtual CPU version " v,\
     },
=20
-#define PC_COMPAT_2_3 \
-    HW_COMPAT_2_3 \
-    PC_CPU_MODEL_IDS("2.3.0") \
-    {\
-        .driver   =3D TYPE_X86_CPU,\
-        .property =3D "arat",\
-        .value    =3D "off",\
-    },{\
-        .driver   =3D "qemu64" "-" TYPE_X86_CPU,\
-        .property =3D "min-level",\
-        .value    =3D stringify(4),\
-    },{\
-        .driver   =3D "kvm64" "-" TYPE_X86_CPU,\
-        .property =3D "min-level",\
-        .value    =3D stringify(5),\
-    },{\
-        .driver   =3D "pentium3" "-" TYPE_X86_CPU,\
-        .property =3D "min-level",\
-        .value    =3D stringify(2),\
-    },{\
-        .driver   =3D "n270" "-" TYPE_X86_CPU,\
-        .property =3D "min-level",\
-        .value    =3D stringify(5),\
-    },{\
-        .driver   =3D "Conroe" "-" TYPE_X86_CPU,\
-        .property =3D "min-level",\
-        .value    =3D stringify(4),\
-    },{\
-        .driver   =3D "Penryn" "-" TYPE_X86_CPU,\
-        .property =3D "min-level",\
-        .value    =3D stringify(4),\
-    },{\
-        .driver   =3D "Nehalem" "-" TYPE_X86_CPU,\
-        .property =3D "min-level",\
-        .value    =3D stringify(4),\
-    },{\
-        .driver   =3D "n270" "-" TYPE_X86_CPU,\
-        .property =3D "min-xlevel",\
-        .value    =3D stringify(0x8000000a),\
-    },{\
-        .driver   =3D "Penryn" "-" TYPE_X86_CPU,\
-        .property =3D "min-xlevel",\
-        .value    =3D stringify(0x8000000a),\
-    },{\
-        .driver   =3D "Conroe" "-" TYPE_X86_CPU,\
-        .property =3D "min-xlevel",\
-        .value    =3D stringify(0x8000000a),\
-    },{\
-        .driver   =3D "Nehalem" "-" TYPE_X86_CPU,\
-        .property =3D "min-xlevel",\
-        .value    =3D stringify(0x8000000a),\
-    },{\
-        .driver   =3D "Westmere" "-" TYPE_X86_CPU,\
-        .property =3D "min-xlevel",\
-        .value    =3D stringify(0x8000000a),\
-    },{\
-        .driver   =3D "SandyBridge" "-" TYPE_X86_CPU,\
-        .property =3D "min-xlevel",\
-        .value    =3D stringify(0x8000000a),\
-    },{\
-        .driver   =3D "IvyBridge" "-" TYPE_X86_CPU,\
-        .property =3D "min-xlevel",\
-        .value    =3D stringify(0x8000000a),\
-    },{\
-        .driver   =3D "Haswell" "-" TYPE_X86_CPU,\
-        .property =3D "min-xlevel",\
-        .value    =3D stringify(0x8000000a),\
-    },{\
-        .driver   =3D "Haswell-noTSX" "-" TYPE_X86_CPU,\
-        .property =3D "min-xlevel",\
-        .value    =3D stringify(0x8000000a),\
-    },{\
-        .driver   =3D "Broadwell" "-" TYPE_X86_CPU,\
-        .property =3D "min-xlevel",\
-        .value    =3D stringify(0x8000000a),\
-    },{\
-        .driver   =3D "Broadwell-noTSX" "-" TYPE_X86_CPU,\
-        .property =3D "min-xlevel",\
-        .value    =3D stringify(0x8000000a),\
-    },{\
-        .driver =3D TYPE_X86_CPU,\
-        .property =3D "kvm-no-smi-migration",\
-        .value    =3D "on",\
-    },
-
 #define PC_COMPAT_2_2 \
     HW_COMPAT_2_2 \
     PC_CPU_MODEL_IDS("2.2.0") \
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 1808900c3a..d37cdc3153 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -265,6 +265,47 @@ GlobalProperty hw_compat_2_4[] =3D {
 };
 const size_t hw_compat_2_4_len =3D G_N_ELEMENTS(hw_compat_2_4);
=20
+GlobalProperty hw_compat_2_3[] =3D {
+    {
+        .driver   =3D "virtio-blk-pci",
+        .property =3D "any_layout",
+        .value    =3D "off",
+    },{
+        .driver   =3D "virtio-balloon-pci",
+        .property =3D "any_layout",
+        .value    =3D "off",
+    },{
+        .driver   =3D "virtio-serial-pci",
+        .property =3D "any_layout",
+        .value    =3D "off",
+    },{
+        .driver   =3D "virtio-9p-pci",
+        .property =3D "any_layout",
+        .value    =3D "off",
+    },{
+        .driver   =3D "virtio-rng-pci",
+        .property =3D "any_layout",
+        .value    =3D "off",
+    },{
+        .driver   =3D TYPE_PCI_DEVICE,
+        .property =3D "x-pcie-lnksta-dllla",
+        .value    =3D "off",
+    },{
+        .driver   =3D "migration",
+        .property =3D "send-configuration",
+        .value    =3D "off",
+    },{
+        .driver   =3D "migration",
+        .property =3D "send-section-footer",
+        .value    =3D "off",
+    },{
+        .driver   =3D "migration",
+        .property =3D "store-global-state",
+        .value    =3D "off",
+    },
+};
+const size_t hw_compat_2_3_len =3D G_N_ELEMENTS(hw_compat_2_3);
+
 static char *machine_get_accel(Object *obj, Error **errp)
 {
     MachineState *ms =3D MACHINE(obj);
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index cc14cb42d5..1f6d7809ce 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -355,6 +355,92 @@ GlobalProperty pc_compat_2_4[] =3D {
 };
 const size_t pc_compat_2_4_len =3D G_N_ELEMENTS(pc_compat_2_4);
=20
+GlobalProperty pc_compat_2_3[] =3D {
+    PC_CPU_MODEL_IDS("2.3.0")
+    {
+        .driver   =3D TYPE_X86_CPU,
+        .property =3D "arat",
+        .value    =3D "off",
+    },{
+        .driver   =3D "qemu64" "-" TYPE_X86_CPU,
+        .property =3D "min-level",
+        .value    =3D stringify(4),
+    },{
+        .driver   =3D "kvm64" "-" TYPE_X86_CPU,
+        .property =3D "min-level",
+        .value    =3D stringify(5),
+    },{
+        .driver   =3D "pentium3" "-" TYPE_X86_CPU,
+        .property =3D "min-level",
+        .value    =3D stringify(2),
+    },{
+        .driver   =3D "n270" "-" TYPE_X86_CPU,
+        .property =3D "min-level",
+        .value    =3D stringify(5),
+    },{
+        .driver   =3D "Conroe" "-" TYPE_X86_CPU,
+        .property =3D "min-level",
+        .value    =3D stringify(4),
+    },{
+        .driver   =3D "Penryn" "-" TYPE_X86_CPU,
+        .property =3D "min-level",
+        .value    =3D stringify(4),
+    },{
+        .driver   =3D "Nehalem" "-" TYPE_X86_CPU,
+        .property =3D "min-level",
+        .value    =3D stringify(4),
+    },{
+        .driver   =3D "n270" "-" TYPE_X86_CPU,
+        .property =3D "min-xlevel",
+        .value    =3D stringify(0x8000000a),
+    },{
+        .driver   =3D "Penryn" "-" TYPE_X86_CPU,
+        .property =3D "min-xlevel",
+        .value    =3D stringify(0x8000000a),
+    },{
+        .driver   =3D "Conroe" "-" TYPE_X86_CPU,
+        .property =3D "min-xlevel",
+        .value    =3D stringify(0x8000000a),
+    },{
+        .driver   =3D "Nehalem" "-" TYPE_X86_CPU,
+        .property =3D "min-xlevel",
+        .value    =3D stringify(0x8000000a),
+    },{
+        .driver   =3D "Westmere" "-" TYPE_X86_CPU,
+        .property =3D "min-xlevel",
+        .value    =3D stringify(0x8000000a),
+    },{
+        .driver   =3D "SandyBridge" "-" TYPE_X86_CPU,
+        .property =3D "min-xlevel",
+        .value    =3D stringify(0x8000000a),
+    },{
+        .driver   =3D "IvyBridge" "-" TYPE_X86_CPU,
+        .property =3D "min-xlevel",
+        .value    =3D stringify(0x8000000a),
+    },{
+        .driver   =3D "Haswell" "-" TYPE_X86_CPU,
+        .property =3D "min-xlevel",
+        .value    =3D stringify(0x8000000a),
+    },{
+        .driver   =3D "Haswell-noTSX" "-" TYPE_X86_CPU,
+        .property =3D "min-xlevel",
+        .value    =3D stringify(0x8000000a),
+    },{
+        .driver   =3D "Broadwell" "-" TYPE_X86_CPU,
+        .property =3D "min-xlevel",
+        .value    =3D stringify(0x8000000a),
+    },{
+        .driver   =3D "Broadwell-noTSX" "-" TYPE_X86_CPU,
+        .property =3D "min-xlevel",
+        .value    =3D stringify(0x8000000a),
+    },{
+        .driver =3D TYPE_X86_CPU,
+        .property =3D "kvm-no-smi-migration",
+        .value    =3D "on",
+    },
+};
+const size_t pc_compat_2_3_len =3D G_N_ELEMENTS(pc_compat_2_3);
+
 void gsi_handler(void *opaque, int n, int level)
 {
     GSIState *s =3D opaque;
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 125ab600ef..5b03f9ef80 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -310,7 +310,7 @@ static void pc_init1(MachineState *machine,
  * HW_COMPAT_*, PC_COMPAT_*, or * pc_*_machine_options().
  */
=20
-static void pc_compat_2_3(MachineState *machine)
+static void pc_compat_2_3_fn(MachineState *machine)
 {
     PCMachineState *pcms =3D PC_MACHINE(machine);
     if (kvm_enabled()) {
@@ -320,7 +320,7 @@ static void pc_compat_2_3(MachineState *machine)
=20
 static void pc_compat_2_2(MachineState *machine)
 {
-    pc_compat_2_3(machine);
+    pc_compat_2_3_fn(machine);
 }
=20
 static void pc_compat_2_1(MachineState *machine)
@@ -566,16 +566,13 @@ DEFINE_I440FX_MACHINE(v2_4, "pc-i440fx-2.4", NULL,
=20
 static void pc_i440fx_2_3_machine_options(MachineClass *m)
 {
-    static GlobalProperty compat[] =3D {
-        PC_COMPAT_2_3
-    };
-
     pc_i440fx_2_4_machine_options(m);
     m->hw_version =3D "2.3.0";
-    compat_props_add(m->compat_props, compat, G_N_ELEMENTS(compat));
+    compat_props_add(m->compat_props, hw_compat_2_3, hw_compat_2_3_len);
+    compat_props_add(m->compat_props, pc_compat_2_3, pc_compat_2_3_len);
 }
=20
-DEFINE_I440FX_MACHINE(v2_3, "pc-i440fx-2.3", pc_compat_2_3,
+DEFINE_I440FX_MACHINE(v2_3, "pc-i440fx-2.3", pc_compat_2_3_fn,
                       pc_i440fx_2_3_machine_options);
=20
 static void pc_i440fx_2_2_machine_options(MachineClass *m)
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index a42cb49109..b99ed19baf 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4322,7 +4322,6 @@ DEFINE_SPAPR_MACHINE(2_4, "2.4", false);
 static void spapr_machine_2_3_class_options(MachineClass *mc)
 {
     static GlobalProperty compat[] =3D {
-        HW_COMPAT_2_3
         {
             .driver   =3D "spapr-pci-host-bridge",
             .property =3D "dynamic-reconfiguration",
@@ -4330,6 +4329,7 @@ static void spapr_machine_2_3_class_options(Machine=
Class *mc)
         },
     };
     spapr_machine_2_4_class_options(mc);
+    compat_props_add(mc->compat_props, hw_compat_2_3, hw_compat_2_3_len)=
;
     compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
 }
 DEFINE_SPAPR_MACHINE(2_3, "2.3", false);
--=20
2.20.1.2.gb21ebb671b
