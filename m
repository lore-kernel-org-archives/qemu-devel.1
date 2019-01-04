Received: from eggs.gnu.org ([208.118.235.92]:43860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gfTJk-0003Ry-Hx
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 12:31:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gfTJj-00017V-3C
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 12:31:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39658)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gfTJi-00015B-OQ
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 12:31:30 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri,  4 Jan 2019 21:30:21 +0400
Message-Id: <20190104173042.32714-8-marcandre.lureau@redhat.com>
In-Reply-To: <20190104173042.32714-1-marcandre.lureau@redhat.com>
References: <20190104173042.32714-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 07/28] compat: replace PC_COMPAT_3_0 &
 HW_COMPAT_3_0 macros
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
 include/hw/compat.h        |  3 ---
 include/hw/i386/pc.h       | 17 ++---------------
 hw/arm/virt.c              |  6 +-----
 hw/core/machine.c          |  3 +++
 hw/i386/pc.c               | 17 +++++++++++++++++
 hw/i386/pc_piix.c          |  7 ++-----
 hw/i386/pc_q35.c           |  7 ++-----
 hw/ppc/spapr.c             |  5 +----
 hw/s390x/s390-virtio-ccw.c |  5 +----
 10 files changed, 32 insertions(+), 41 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index b9a5c2d087..aaa57f1f6b 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -291,4 +291,7 @@ struct MachineState {
 extern GlobalProperty hw_compat_3_1[];
 extern const size_t hw_compat_3_1_len;
=20
+extern GlobalProperty hw_compat_3_0[];
+extern const size_t hw_compat_3_0_len;
+
 #endif
diff --git a/include/hw/compat.h b/include/hw/compat.h
index 6f4d5fc647..c08f4040bb 100644
--- a/include/hw/compat.h
+++ b/include/hw/compat.h
@@ -1,9 +1,6 @@
 #ifndef HW_COMPAT_H
 #define HW_COMPAT_H
=20
-#define HW_COMPAT_3_0 \
-    /* empty */
-
 #define HW_COMPAT_2_12 \
     {\
         .driver   =3D "migration",\
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index dd1d6fd0f3..197131ff9a 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -297,21 +297,8 @@ bool e820_get_entry(int, uint32_t, uint64_t *, uint6=
4_t *);
 extern GlobalProperty pc_compat_3_1[];
 extern const size_t pc_compat_3_1_len;
=20
-#define PC_COMPAT_3_0 \
-    HW_COMPAT_3_0 \
-    {\
-        .driver   =3D TYPE_X86_CPU,\
-        .property =3D "x-hv-synic-kvm-only",\
-        .value    =3D "on",\
-    },{\
-        .driver   =3D "Skylake-Server" "-" TYPE_X86_CPU,\
-        .property =3D "pku",\
-        .value    =3D "off",\
-    },{\
-        .driver   =3D "Skylake-Server-IBRS" "-" TYPE_X86_CPU,\
-        .property =3D "pku",\
-        .value    =3D "off",\
-    },
+extern GlobalProperty pc_compat_3_0[];
+extern const size_t pc_compat_3_0_len;
=20
 #define PC_COMPAT_2_12 \
     HW_COMPAT_2_12 \
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index ebd5f306e4..5c541ec55e 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1881,12 +1881,8 @@ DEFINE_VIRT_MACHINE(3, 1)
=20
 static void virt_machine_3_0_options(MachineClass *mc)
 {
-    static GlobalProperty compat[] =3D {
-        HW_COMPAT_3_0
-    };
-
     virt_machine_3_1_options(mc);
-    compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
+    compat_props_add(mc->compat_props, hw_compat_3_0, hw_compat_3_0_len)=
;
 }
 DEFINE_VIRT_MACHINE(3, 0)
=20
diff --git a/hw/core/machine.c b/hw/core/machine.c
index d6204967c3..f00f6381d2 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -35,6 +35,9 @@ GlobalProperty hw_compat_3_1[] =3D {
 };
 const size_t hw_compat_3_1_len =3D G_N_ELEMENTS(hw_compat_3_1);
=20
+GlobalProperty hw_compat_3_0[] =3D {};
+const size_t hw_compat_3_0_len =3D G_N_ELEMENTS(hw_compat_3_0);
+
 static char *machine_get_accel(Object *obj, Error **errp)
 {
     MachineState *ms =3D MACHINE(obj);
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 33d09a832a..b5799985a1 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -118,6 +118,23 @@ GlobalProperty pc_compat_3_1[] =3D {
 };
 const size_t pc_compat_3_1_len =3D G_N_ELEMENTS(pc_compat_3_1);
=20
+GlobalProperty pc_compat_3_0[] =3D {
+    {
+        .driver   =3D TYPE_X86_CPU,
+        .property =3D "x-hv-synic-kvm-only",
+        .value    =3D "on",
+    },{
+        .driver   =3D "Skylake-Server" "-" TYPE_X86_CPU,
+        .property =3D "pku",
+        .value    =3D "off",
+    },{
+        .driver   =3D "Skylake-Server-IBRS" "-" TYPE_X86_CPU,
+        .property =3D "pku",
+        .value    =3D "off",
+    },
+};
+const size_t pc_compat_3_0_len =3D G_N_ELEMENTS(pc_compat_3_0);
+
 void gsi_handler(void *opaque, int n, int level)
 {
     GSIState *s =3D opaque;
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index c938437627..cc8b249ccc 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -452,12 +452,9 @@ DEFINE_I440FX_MACHINE(v3_1, "pc-i440fx-3.1", NULL,
=20
 static void pc_i440fx_3_0_machine_options(MachineClass *m)
 {
-    static GlobalProperty compat[] =3D {
-        PC_COMPAT_3_0
-    };
-
     pc_i440fx_3_1_machine_options(m);
-    compat_props_add(m->compat_props, compat, G_N_ELEMENTS(compat));
+    compat_props_add(m->compat_props, hw_compat_3_0, hw_compat_3_0_len);
+    compat_props_add(m->compat_props, pc_compat_3_0, pc_compat_3_0_len);
 }
=20
 DEFINE_I440FX_MACHINE(v3_0, "pc-i440fx-3.0", NULL,
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index fad3d6da17..39378ee1cd 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -335,12 +335,9 @@ DEFINE_Q35_MACHINE(v3_1, "pc-q35-3.1", NULL,
=20
 static void pc_q35_3_0_machine_options(MachineClass *m)
 {
-    static GlobalProperty compat[] =3D {
-        PC_COMPAT_3_0
-    };
-
     pc_q35_3_1_machine_options(m);
-    compat_props_add(m->compat_props, compat, G_N_ELEMENTS(compat));
+    compat_props_add(m->compat_props, hw_compat_3_0, hw_compat_3_0_len);
+    compat_props_add(m->compat_props, pc_compat_3_0, pc_compat_3_0_len);
 }
=20
 DEFINE_Q35_MACHINE(v3_0, "pc-q35-3.0", NULL,
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index f04135fffd..8a99e4d9b8 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4037,12 +4037,9 @@ DEFINE_SPAPR_MACHINE(3_1, "3.1", false);
 static void spapr_machine_3_0_class_options(MachineClass *mc)
 {
     sPAPRMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
-    static GlobalProperty compat[] =3D {
-        HW_COMPAT_3_0
-    };
=20
     spapr_machine_3_1_class_options(mc);
-    compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
+    compat_props_add(mc->compat_props, hw_compat_3_0, hw_compat_3_0_len)=
;
=20
     smc->legacy_irq_allocation =3D true;
     smc->irq =3D &spapr_irq_xics_legacy;
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 5e8b48e75b..e54e6f6dd0 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -680,13 +680,10 @@ static void ccw_machine_3_0_instance_options(Machin=
eState *machine)
 static void ccw_machine_3_0_class_options(MachineClass *mc)
 {
     S390CcwMachineClass *s390mc =3D S390_MACHINE_CLASS(mc);
-    static GlobalProperty compat[] =3D {
-        HW_COMPAT_3_0
-    };
=20
     s390mc->hpage_1m_allowed =3D false;
     ccw_machine_3_1_class_options(mc);
-    compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
+    compat_props_add(mc->compat_props, hw_compat_3_0, hw_compat_3_0_len)=
;
 }
 DEFINE_CCW_MACHINE(3_0, "3.0", false);
=20
--=20
2.20.1.2.gb21ebb671b
