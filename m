Received: from eggs.gnu.org ([208.118.235.92]:44141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gfTKN-0004C5-TA
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 12:32:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gfTKM-0001Xq-O1
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 12:32:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42378)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gfTKM-0001XN-GV
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 12:32:10 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri,  4 Jan 2019 21:30:29 +0400
Message-Id: <20190104173042.32714-16-marcandre.lureau@redhat.com>
In-Reply-To: <20190104173042.32714-1-marcandre.lureau@redhat.com>
References: <20190104173042.32714-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 15/28] compat: replace PC_COMPAT_2_5 &
 HW_COMPAT_2_5 macros
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
 include/hw/compat.h        | 24 ------------------------
 include/hw/i386/pc.h       |  4 ++--
 hw/core/machine.c          | 26 ++++++++++++++++++++++++++
 hw/i386/pc.c               |  3 +++
 hw/i386/pc_piix.c          |  6 ++----
 hw/i386/pc_q35.c           |  6 ++----
 hw/ppc/spapr.c             |  2 +-
 hw/s390x/s390-virtio-ccw.c |  6 +-----
 9 files changed, 40 insertions(+), 40 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index 1135ee23ac..0023b72b02 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -315,4 +315,7 @@ extern const size_t hw_compat_2_7_len;
 extern GlobalProperty hw_compat_2_6[];
 extern const size_t hw_compat_2_6_len;
=20
+extern GlobalProperty hw_compat_2_5[];
+extern const size_t hw_compat_2_5_len;
+
 #endif
diff --git a/include/hw/compat.h b/include/hw/compat.h
index c744233fb6..a6eced34c6 100644
--- a/include/hw/compat.h
+++ b/include/hw/compat.h
@@ -1,30 +1,6 @@
 #ifndef HW_COMPAT_H
 #define HW_COMPAT_H
=20
-#define HW_COMPAT_2_5 \
-    {\
-        .driver   =3D "isa-fdc",\
-        .property =3D "fallback",\
-        .value    =3D "144",\
-    },{\
-        .driver   =3D "pvscsi",\
-        .property =3D "x-old-pci-configuration",\
-        .value    =3D "on",\
-    },{\
-        .driver   =3D "pvscsi",\
-        .property =3D "x-disable-pcie",\
-        .value    =3D "on",\
-    },\
-    {\
-        .driver   =3D "vmxnet3",\
-        .property =3D "x-old-msi-offsets",\
-        .value    =3D "on",\
-    },{\
-        .driver   =3D "vmxnet3",\
-        .property =3D "x-disable-pcie",\
-        .value    =3D "on",\
-    },
-
 #define HW_COMPAT_2_4 \
     {\
         .driver   =3D "virtio-blk-device",\
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index ca62def2c9..9a32031f25 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -321,8 +321,8 @@ extern const size_t pc_compat_2_7_len;
 extern GlobalProperty pc_compat_2_6[];
 extern const size_t pc_compat_2_6_len;
=20
-#define PC_COMPAT_2_5 \
-    HW_COMPAT_2_5
+extern GlobalProperty pc_compat_2_5[];
+extern const size_t pc_compat_2_5_len;
=20
 /* Helper for setting model-id for CPU models that changed model-id
  * depending on QEMU versions up to QEMU 2.4.
diff --git a/hw/core/machine.c b/hw/core/machine.c
index e27b1b5c34..4d05501775 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -210,6 +210,32 @@ GlobalProperty hw_compat_2_6[] =3D {
 };
 const size_t hw_compat_2_6_len =3D G_N_ELEMENTS(hw_compat_2_6);
=20
+GlobalProperty hw_compat_2_5[] =3D {
+    {
+        .driver   =3D "isa-fdc",
+        .property =3D "fallback",
+        .value    =3D "144",
+    },{
+        .driver   =3D "pvscsi",
+        .property =3D "x-old-pci-configuration",
+        .value    =3D "on",
+    },{
+        .driver   =3D "pvscsi",
+        .property =3D "x-disable-pcie",
+        .value    =3D "on",
+    },
+    {
+        .driver   =3D "vmxnet3",
+        .property =3D "x-old-msi-offsets",
+        .value    =3D "on",
+    },{
+        .driver   =3D "vmxnet3",
+        .property =3D "x-disable-pcie",
+        .value    =3D "on",
+    },
+};
+const size_t hw_compat_2_5_len =3D G_N_ELEMENTS(hw_compat_2_5);
+
 static char *machine_get_accel(Object *obj, Error **errp)
 {
     MachineState *ms =3D MACHINE(obj);
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 6c8ff0e928..8eb69ff054 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -281,6 +281,9 @@ GlobalProperty pc_compat_2_6[] =3D {
 };
 const size_t pc_compat_2_6_len =3D G_N_ELEMENTS(pc_compat_2_6);
=20
+GlobalProperty pc_compat_2_5[] =3D {};
+const size_t pc_compat_2_5_len =3D G_N_ELEMENTS(pc_compat_2_5);
+
 void gsi_handler(void *opaque, int n, int level)
 {
     GSIState *s =3D opaque;
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 89e81a028a..3a31de7316 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -539,14 +539,12 @@ DEFINE_I440FX_MACHINE(v2_6, "pc-i440fx-2.6", NULL,
 static void pc_i440fx_2_5_machine_options(MachineClass *m)
 {
     PCMachineClass *pcmc =3D PC_MACHINE_CLASS(m);
-    static GlobalProperty compat[] =3D {
-        PC_COMPAT_2_5
-    };
=20
     pc_i440fx_2_6_machine_options(m);
     pcmc->save_tsc_khz =3D false;
     m->legacy_fw_cfg_order =3D 1;
-    compat_props_add(m->compat_props, compat, G_N_ELEMENTS(compat));
+    compat_props_add(m->compat_props, hw_compat_2_5, hw_compat_2_5_len);
+    compat_props_add(m->compat_props, pc_compat_2_5, pc_compat_2_5_len);
 }
=20
 DEFINE_I440FX_MACHINE(v2_5, "pc-i440fx-2.5", NULL,
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index efb70fb8af..418b8387d9 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -426,14 +426,12 @@ DEFINE_Q35_MACHINE(v2_6, "pc-q35-2.6", NULL,
 static void pc_q35_2_5_machine_options(MachineClass *m)
 {
     PCMachineClass *pcmc =3D PC_MACHINE_CLASS(m);
-    static GlobalProperty compat[] =3D {
-        PC_COMPAT_2_5
-    };
=20
     pc_q35_2_6_machine_options(m);
     pcmc->save_tsc_khz =3D false;
     m->legacy_fw_cfg_order =3D 1;
-    compat_props_add(m->compat_props, compat, G_N_ELEMENTS(compat));
+    compat_props_add(m->compat_props, hw_compat_2_5, hw_compat_2_5_len);
+    compat_props_add(m->compat_props, pc_compat_2_5, pc_compat_2_5_len);
 }
=20
 DEFINE_Q35_MACHINE(v2_5, "pc-q35-2.5", NULL,
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index eff015987d..6be74ae0c8 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4285,7 +4285,6 @@ static void spapr_machine_2_5_class_options(Machine=
Class *mc)
 {
     sPAPRMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
     static GlobalProperty compat[] =3D {
-        HW_COMPAT_2_5
         {
             .driver   =3D "spapr-vlan",
             .property =3D "use-rx-buffer-pools",
@@ -4295,6 +4294,7 @@ static void spapr_machine_2_5_class_options(Machine=
Class *mc)
=20
     spapr_machine_2_6_class_options(mc);
     smc->use_ohci_by_default =3D true;
+    compat_props_add(mc->compat_props, hw_compat_2_5, hw_compat_2_5_len)=
;
     compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
 }
=20
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 6137c97875..1ab53a1332 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -836,12 +836,8 @@ static void ccw_machine_2_5_instance_options(Machine=
State *machine)
=20
 static void ccw_machine_2_5_class_options(MachineClass *mc)
 {
-    static GlobalProperty compat[] =3D {
-        HW_COMPAT_2_5
-    };
-
     ccw_machine_2_6_class_options(mc);
-    compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
+    compat_props_add(mc->compat_props, hw_compat_2_5, hw_compat_2_5_len)=
;
 }
 DEFINE_CCW_MACHINE(2_5, "2.5", false);
=20
--=20
2.20.1.2.gb21ebb671b
