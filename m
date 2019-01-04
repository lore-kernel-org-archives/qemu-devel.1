Received: from eggs.gnu.org ([208.118.235.92]:43939)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gfTJr-0003aX-P3
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 12:31:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gfTJq-0001D0-J7
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 12:31:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34360)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gfTJq-0001CY-C3
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 12:31:38 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri,  4 Jan 2019 21:30:23 +0400
Message-Id: <20190104173042.32714-10-marcandre.lureau@redhat.com>
In-Reply-To: <20190104173042.32714-1-marcandre.lureau@redhat.com>
References: <20190104173042.32714-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 09/28] compat: replace PC_COMPAT_2_11 &
 HW_COMPAT_2_11 macros
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
 include/hw/i386/pc.h       | 13 ++-----------
 hw/arm/virt.c              |  5 +----
 hw/core/machine.c          | 21 +++++++++++++++++++++
 hw/i386/pc.c               | 13 +++++++++++++
 hw/i386/pc_piix.c          |  7 ++-----
 hw/i386/pc_q35.c           |  7 ++-----
 hw/ppc/spapr.c             |  5 +----
 hw/s390x/s390-virtio-ccw.c |  2 +-
 10 files changed, 46 insertions(+), 49 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index c6d828e73c..67202b5a2f 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -297,4 +297,7 @@ extern const size_t hw_compat_3_0_len;
 extern GlobalProperty hw_compat_2_12[];
 extern const size_t hw_compat_2_12_len;
=20
+extern GlobalProperty hw_compat_2_11[];
+extern const size_t hw_compat_2_11_len;
+
 #endif
diff --git a/include/hw/compat.h b/include/hw/compat.h
index 13242b831a..cf389b4e85 100644
--- a/include/hw/compat.h
+++ b/include/hw/compat.h
@@ -1,25 +1,6 @@
 #ifndef HW_COMPAT_H
 #define HW_COMPAT_H
=20
-#define HW_COMPAT_2_11 \
-    {\
-        .driver   =3D "hpet",\
-        .property =3D "hpet-offset-saved",\
-        .value    =3D "false",\
-    },{\
-        .driver   =3D "virtio-blk-pci",\
-        .property =3D "vectors",\
-        .value    =3D "2",\
-    },{\
-        .driver   =3D "vhost-user-blk-pci",\
-        .property =3D "vectors",\
-        .value    =3D "2",\
-    },{\
-        .driver   =3D "e1000",\
-        .property =3D "migrate_tso_props",\
-        .value    =3D "off",\
-    },
-
 #define HW_COMPAT_2_10 \
     {\
         .driver   =3D "virtio-mouse-device",\
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 91cb3283f0..f0f7e76a3e 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -303,17 +303,8 @@ extern const size_t pc_compat_3_0_len;
 extern GlobalProperty pc_compat_2_12[];
 extern const size_t pc_compat_2_12_len;
=20
-#define PC_COMPAT_2_11 \
-    HW_COMPAT_2_11 \
-    {\
-        .driver   =3D TYPE_X86_CPU,\
-        .property =3D "x-migrate-smi-count",\
-        .value    =3D "off",\
-    },{\
-        .driver   =3D "Skylake-Server" "-" TYPE_X86_CPU,\
-        .property =3D "clflushopt",\
-        .value    =3D "off",\
-    },
+extern GlobalProperty pc_compat_2_11[];
+extern const size_t pc_compat_2_11_len;
=20
 #define PC_COMPAT_2_10 \
     HW_COMPAT_2_10 \
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 228ee63d99..548b6efa93 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1900,12 +1900,9 @@ DEFINE_VIRT_MACHINE(2, 12)
 static void virt_machine_2_11_options(MachineClass *mc)
 {
     VirtMachineClass *vmc =3D VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
-    static GlobalProperty compat[] =3D {
-        HW_COMPAT_2_11
-    };
=20
     virt_machine_2_12_options(mc);
-    compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
+    compat_props_add(mc->compat_props, hw_compat_2_11, hw_compat_2_11_le=
n);
     vmc->smbios_old_sys_ver =3D true;
 }
 DEFINE_VIRT_MACHINE(2, 11)
diff --git a/hw/core/machine.c b/hw/core/machine.c
index ae94f5e4ca..41f37ee4d4 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -67,6 +67,27 @@ GlobalProperty hw_compat_2_12[] =3D {
 };
 const size_t hw_compat_2_12_len =3D G_N_ELEMENTS(hw_compat_2_12);
=20
+GlobalProperty hw_compat_2_11[] =3D {
+    {
+        .driver   =3D "hpet",
+        .property =3D "hpet-offset-saved",
+        .value    =3D "false",
+    },{
+        .driver   =3D "virtio-blk-pci",
+        .property =3D "vectors",
+        .value    =3D "2",
+    },{
+        .driver   =3D "vhost-user-blk-pci",
+        .property =3D "vectors",
+        .value    =3D "2",
+    },{
+        .driver   =3D "e1000",
+        .property =3D "migrate_tso_props",
+        .value    =3D "off",
+    },
+};
+const size_t hw_compat_2_11_len =3D G_N_ELEMENTS(hw_compat_2_11);
+
 static char *machine_get_accel(Object *obj, Error **errp)
 {
     MachineState *ms =3D MACHINE(obj);
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 031602a005..563ba90202 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -156,6 +156,19 @@ GlobalProperty pc_compat_2_12[] =3D {
 };
 const size_t pc_compat_2_12_len =3D G_N_ELEMENTS(pc_compat_2_12);
=20
+GlobalProperty pc_compat_2_11[] =3D {
+    {
+        .driver   =3D TYPE_X86_CPU,
+        .property =3D "x-migrate-smi-count",
+        .value    =3D "off",
+    },{
+        .driver   =3D "Skylake-Server" "-" TYPE_X86_CPU,
+        .property =3D "clflushopt",
+        .value    =3D "off",
+    },
+};
+const size_t pc_compat_2_11_len =3D G_N_ELEMENTS(pc_compat_2_11);
+
 void gsi_handler(void *opaque, int n, int level)
 {
     GSIState *s =3D opaque;
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index fd3906cda6..aeb51a2772 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -472,12 +472,9 @@ DEFINE_I440FX_MACHINE(v2_12, "pc-i440fx-2.12", NULL,
=20
 static void pc_i440fx_2_11_machine_options(MachineClass *m)
 {
-    static GlobalProperty compat[] =3D {
-        PC_COMPAT_2_11
-    };
-
     pc_i440fx_2_12_machine_options(m);
-    compat_props_add(m->compat_props, compat, G_N_ELEMENTS(compat));
+    compat_props_add(m->compat_props, hw_compat_2_11, hw_compat_2_11_len=
);
+    compat_props_add(m->compat_props, pc_compat_2_11, pc_compat_2_11_len=
);
 }
=20
 DEFINE_I440FX_MACHINE(v2_11, "pc-i440fx-2.11", NULL,
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 7928f703d0..fd3187003a 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -356,14 +356,11 @@ DEFINE_Q35_MACHINE(v2_12, "pc-q35-2.12", NULL,
 static void pc_q35_2_11_machine_options(MachineClass *m)
 {
     PCMachineClass *pcmc =3D PC_MACHINE_CLASS(m);
-    static GlobalProperty compat[] =3D {
-        PC_COMPAT_2_11
-    };
-
=20
     pc_q35_2_12_machine_options(m);
     pcmc->default_nic_model =3D "e1000";
-    compat_props_add(m->compat_props, compat, G_N_ELEMENTS(compat));
+    compat_props_add(m->compat_props, hw_compat_2_11, hw_compat_2_11_len=
);
+    compat_props_add(m->compat_props, pc_compat_2_11, pc_compat_2_11_len=
);
 }
=20
 DEFINE_Q35_MACHINE(v2_11, "pc-q35-2.11", NULL,
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index f1fe455c71..9afa22fd13 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4099,13 +4099,10 @@ DEFINE_SPAPR_MACHINE(2_12_sxxm, "2.12-sxxm", fals=
e);
 static void spapr_machine_2_11_class_options(MachineClass *mc)
 {
     sPAPRMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
-    static GlobalProperty compat[] =3D {
-        HW_COMPAT_2_11
-    };
=20
     spapr_machine_2_12_class_options(mc);
     smc->default_caps.caps[SPAPR_CAP_HTM] =3D SPAPR_CAP_ON;
-    compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
+    compat_props_add(mc->compat_props, hw_compat_2_11, hw_compat_2_11_le=
n);
 }
=20
 DEFINE_SPAPR_MACHINE(2_11, "2.11", false);
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index ce22a9d511..74623becaf 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -713,7 +713,6 @@ static void ccw_machine_2_11_instance_options(Machine=
State *machine)
 static void ccw_machine_2_11_class_options(MachineClass *mc)
 {
     static GlobalProperty compat[] =3D {
-        HW_COMPAT_2_11
         {
             .driver   =3D TYPE_SCLP_EVENT_FACILITY,
             .property =3D "allow_all_mask_sizes",
@@ -722,6 +721,7 @@ static void ccw_machine_2_11_class_options(MachineCla=
ss *mc)
     };
=20
     ccw_machine_2_12_class_options(mc);
+    compat_props_add(mc->compat_props, hw_compat_2_11, hw_compat_2_11_le=
n);
     compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
 }
 DEFINE_CCW_MACHINE(2_11, "2.11", false);
--=20
2.20.1.2.gb21ebb671b
