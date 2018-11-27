Received: from eggs.gnu.org ([2001:4830:134:3::10]:48250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gRZip-0005En-J1
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 04:32:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gRZio-0006ZT-NB
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 04:31:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:13729)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gRZio-0006ZJ-G4
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 04:31:58 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 27 Nov 2018 13:27:59 +0400
Message-Id: <20181127092801.21777-27-marcandre.lureau@redhat.com>
In-Reply-To: <20181127092801.21777-1-marcandre.lureau@redhat.com>
References: <20181127092801.21777-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-3.2 v4 26/28] hw/i386: add pc-i440fx-3.2 &
 pc-q35-3.2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: imammedo@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

The following patch is going to add compatiblity parameters for
qemu <=3D 3.1.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/hw/compat.h  |  3 +++
 include/hw/i386/pc.h |  3 +++
 hw/i386/pc_piix.c    | 15 ++++++++++++---
 hw/i386/pc_q35.c     | 13 +++++++++++--
 4 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/include/hw/compat.h b/include/hw/compat.h
index 6f4d5fc647..70958328fe 100644
--- a/include/hw/compat.h
+++ b/include/hw/compat.h
@@ -1,6 +1,9 @@
 #ifndef HW_COMPAT_H
 #define HW_COMPAT_H
=20
+#define HW_COMPAT_3_1 \
+    /* empty */
+
 #define HW_COMPAT_3_0 \
     /* empty */
=20
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 136fe497b6..c37d4333a0 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -294,6 +294,9 @@ int e820_add_entry(uint64_t, uint64_t, uint32_t);
 int e820_get_num_entries(void);
 bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
=20
+#define PC_COMPAT_3_1 \
+    HW_COMPAT_3_1
+
 #define PC_COMPAT_3_0 \
     HW_COMPAT_3_0 \
     {\
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 3cc92b8eec..a4dcadac37 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -428,21 +428,30 @@ static void pc_i440fx_machine_options(MachineClass =
*m)
     machine_class_allow_dynamic_sysbus_dev(m, TYPE_RAMFB_DEVICE);
 }
=20
-static void pc_i440fx_3_1_machine_options(MachineClass *m)
+static void pc_i440fx_3_2_machine_options(MachineClass *m)
 {
     pc_i440fx_machine_options(m);
     m->alias =3D "pc";
     m->is_default =3D 1;
 }
=20
+DEFINE_I440FX_MACHINE(v3_2, "pc-i440fx-3.2", NULL,
+                      pc_i440fx_3_2_machine_options);
+
+static void pc_i440fx_3_1_machine_options(MachineClass *m)
+{
+    pc_i440fx_3_2_machine_options(m);
+    m->is_default =3D 0;
+    m->alias =3D NULL;
+    SET_COMPAT(m, PC_COMPAT_3_1);
+}
+
 DEFINE_I440FX_MACHINE(v3_1, "pc-i440fx-3.1", NULL,
                       pc_i440fx_3_1_machine_options);
=20
 static void pc_i440fx_3_0_machine_options(MachineClass *m)
 {
     pc_i440fx_3_1_machine_options(m);
-    m->is_default =3D 0;
-    m->alias =3D NULL;
     SET_COMPAT(m, PC_COMPAT_3_0);
 }
=20
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 19e6ec6675..a990a22f87 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -311,19 +311,28 @@ static void pc_q35_machine_options(MachineClass *m)
     m->max_cpus =3D 288;
 }
=20
-static void pc_q35_3_1_machine_options(MachineClass *m)
+static void pc_q35_3_2_machine_options(MachineClass *m)
 {
     pc_q35_machine_options(m);
     m->alias =3D "q35";
 }
=20
+DEFINE_Q35_MACHINE(v3_2, "pc-q35-3.2", NULL,
+                   pc_q35_3_2_machine_options);
+
+static void pc_q35_3_1_machine_options(MachineClass *m)
+{
+    pc_q35_3_2_machine_options(m);
+    m->alias =3D NULL;
+    SET_COMPAT(m, PC_COMPAT_3_1);
+}
+
 DEFINE_Q35_MACHINE(v3_1, "pc-q35-3.1", NULL,
                    pc_q35_3_1_machine_options);
=20
 static void pc_q35_3_0_machine_options(MachineClass *m)
 {
     pc_q35_3_1_machine_options(m);
-    m->alias =3D NULL;
     SET_COMPAT(m, PC_COMPAT_3_0);
 }
=20
--=20
2.20.0.rc1
