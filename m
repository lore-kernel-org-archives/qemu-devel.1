Received: from eggs.gnu.org ([2001:4830:134:3::10]:53751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gXCO9-0002OR-JI
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 16:49:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gXCO8-0006Mv-4P
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 16:49:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48842)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gXCO7-0006MF-Qw
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 16:49:52 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0C81E30014D1
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 21:49:51 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 13 Dec 2018 01:48:32 +0400
Message-Id: <20181212214850.29953-11-marcandre.lureau@redhat.com>
In-Reply-To: <20181212214850.29953-1-marcandre.lureau@redhat.com>
References: <20181212214850.29953-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 10/28] compat: replace PC_COMPAT_2_10 &
 HW_COMPAT_2_10 macros
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
 include/hw/compat.h        | 11 -----------
 include/hw/i386/pc.h       | 17 ++---------------
 hw/arm/virt.c              |  6 +-----
 hw/core/machine.c          | 13 +++++++++++++
 hw/i386/pc.c               | 17 +++++++++++++++++
 hw/i386/pc_piix.c          |  7 ++-----
 hw/i386/pc_q35.c           |  7 ++-----
 hw/ppc/spapr.c             |  6 +-----
 hw/s390x/s390-virtio-ccw.c |  6 +-----
 10 files changed, 42 insertions(+), 51 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index 59c3c4b75e..f701b66183 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -299,4 +299,7 @@ extern const size_t hw_compat_2_12_len;
 extern GlobalProperty hw_compat_2_11[];
 extern const size_t hw_compat_2_11_len;
=20
+extern GlobalProperty hw_compat_2_10[];
+extern const size_t hw_compat_2_10_len;
+
 #endif
diff --git a/include/hw/compat.h b/include/hw/compat.h
index cf389b4e85..f414786604 100644
--- a/include/hw/compat.h
+++ b/include/hw/compat.h
@@ -1,17 +1,6 @@
 #ifndef HW_COMPAT_H
 #define HW_COMPAT_H
=20
-#define HW_COMPAT_2_10 \
-    {\
-        .driver   =3D "virtio-mouse-device",\
-        .property =3D "wheel-axis",\
-        .value    =3D "false",\
-    },{\
-        .driver   =3D "virtio-tablet-device",\
-        .property =3D "wheel-axis",\
-        .value    =3D "false",\
-    },
-
 #define HW_COMPAT_2_9 \
     {\
         .driver   =3D "pci-bridge",\
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index f0f7e76a3e..d77843a711 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -306,21 +306,8 @@ extern const size_t pc_compat_2_12_len;
 extern GlobalProperty pc_compat_2_11[];
 extern const size_t pc_compat_2_11_len;
=20
-#define PC_COMPAT_2_10 \
-    HW_COMPAT_2_10 \
-    {\
-        .driver   =3D TYPE_X86_CPU,\
-        .property =3D "x-hv-max-vps",\
-        .value    =3D "0x40",\
-    },{\
-        .driver   =3D "i440FX-pcihost",\
-        .property =3D "x-pci-hole64-fix",\
-        .value    =3D "off",\
-    },{\
-        .driver   =3D "q35-pcihost",\
-        .property =3D "x-pci-hole64-fix",\
-        .value    =3D "off",\
-    },
+extern GlobalProperty pc_compat_2_10[];
+extern const size_t pc_compat_2_10_len;
=20
 #define PC_COMPAT_2_9 \
     HW_COMPAT_2_9 \
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 13d9a3e4b7..f0c9929c18 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1909,12 +1909,8 @@ DEFINE_VIRT_MACHINE(2, 11)
=20
 static void virt_machine_2_10_options(MachineClass *mc)
 {
-    static GlobalProperty compat[] =3D {
-        HW_COMPAT_2_10
-    };
-
     virt_machine_2_11_options(mc);
-    compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
+    compat_props_add(mc->compat_props, hw_compat_2_10, hw_compat_2_10_le=
n);
     /* before 2.11 we never faulted accesses to bad addresses */
     mc->ignore_memory_transaction_failures =3D true;
 }
diff --git a/hw/core/machine.c b/hw/core/machine.c
index e8f715542a..7ab83bf4e2 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -78,6 +78,19 @@ GlobalProperty hw_compat_2_11[] =3D {
 };
 const size_t hw_compat_2_11_len =3D G_N_ELEMENTS(hw_compat_2_11);
=20
+GlobalProperty hw_compat_2_10[] =3D {
+    {
+        .driver   =3D "virtio-mouse-device",
+        .property =3D "wheel-axis",
+        .value    =3D "false",
+    },{
+        .driver   =3D "virtio-tablet-device",
+        .property =3D "wheel-axis",
+        .value    =3D "false",
+    },
+};
+const size_t hw_compat_2_10_len =3D G_N_ELEMENTS(hw_compat_2_10);
+
 static char *machine_get_accel(Object *obj, Error **errp)
 {
     MachineState *ms =3D MACHINE(obj);
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 72d718f2ea..34d3cf9b30 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -163,6 +163,23 @@ GlobalProperty pc_compat_2_11[] =3D {
 };
 const size_t pc_compat_2_11_len =3D G_N_ELEMENTS(pc_compat_2_11);
=20
+GlobalProperty pc_compat_2_10[] =3D {
+    {
+        .driver   =3D TYPE_X86_CPU,
+        .property =3D "x-hv-max-vps",
+        .value    =3D "0x40",
+    },{
+        .driver   =3D "i440FX-pcihost",
+        .property =3D "x-pci-hole64-fix",
+        .value    =3D "off",
+    },{
+        .driver   =3D "q35-pcihost",
+        .property =3D "x-pci-hole64-fix",
+        .value    =3D "off",
+    },
+};
+const size_t pc_compat_2_10_len =3D G_N_ELEMENTS(pc_compat_2_10);
+
 void gsi_handler(void *opaque, int n, int level)
 {
     GSIState *s =3D opaque;
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 32daebc05e..d3e795de20 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -482,12 +482,9 @@ DEFINE_I440FX_MACHINE(v2_11, "pc-i440fx-2.11", NULL,
=20
 static void pc_i440fx_2_10_machine_options(MachineClass *m)
 {
-    static GlobalProperty compat[] =3D {
-        PC_COMPAT_2_10
-    };
-
     pc_i440fx_2_11_machine_options(m);
-    compat_props_add(m->compat_props, compat, G_N_ELEMENTS(compat));
+    compat_props_add(m->compat_props, hw_compat_2_10, hw_compat_2_10_len=
);
+    compat_props_add(m->compat_props, pc_compat_2_10, pc_compat_2_10_len=
);
     m->auto_enable_numa_with_memhp =3D false;
 }
=20
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index bc195b8c58..8d708cd163 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -366,12 +366,9 @@ DEFINE_Q35_MACHINE(v2_11, "pc-q35-2.11", NULL,
=20
 static void pc_q35_2_10_machine_options(MachineClass *m)
 {
-    static GlobalProperty compat[] =3D {
-        PC_COMPAT_2_10
-    };
-
     pc_q35_2_11_machine_options(m);
-    compat_props_add(m->compat_props, compat, G_N_ELEMENTS(compat));
+    compat_props_add(m->compat_props, hw_compat_2_10, hw_compat_2_10_len=
);
+    compat_props_add(m->compat_props, pc_compat_2_10, pc_compat_2_10_len=
);
     m->numa_auto_assign_ram =3D numa_legacy_auto_assign_ram;
     m->auto_enable_numa_with_memhp =3D false;
 }
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 88e2c8df71..10e91d857c 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4054,12 +4054,8 @@ DEFINE_SPAPR_MACHINE(2_11, "2.11", false);
=20
 static void spapr_machine_2_10_class_options(MachineClass *mc)
 {
-    static GlobalProperty compat[] =3D {
-        HW_COMPAT_2_10
-    };
-
     spapr_machine_2_11_class_options(mc);
-    compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
+    compat_props_add(mc->compat_props, hw_compat_2_10, hw_compat_2_10_le=
n);
 }
=20
 DEFINE_SPAPR_MACHINE(2_10, "2.10", false);
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 385102c5d9..5c6e3ee165 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -721,12 +721,8 @@ static void ccw_machine_2_10_instance_options(Machin=
eState *machine)
=20
 static void ccw_machine_2_10_class_options(MachineClass *mc)
 {
-    static GlobalProperty compat[] =3D {
-        HW_COMPAT_2_10
-    };
-
     ccw_machine_2_11_class_options(mc);
-    compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
+    compat_props_add(mc->compat_props, hw_compat_2_10, hw_compat_2_10_le=
n);
 }
 DEFINE_CCW_MACHINE(2_10, "2.10", false);
=20
--=20
2.20.0
