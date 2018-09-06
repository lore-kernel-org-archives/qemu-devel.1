Received: from eggs.gnu.org ([2001:4830:134:3::10]:37197)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fxkze-0004rq-Qn
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 23:30:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fxkzc-0003aF-GJ
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 23:30:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59302 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fxkzc-0003ZK-1p
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 23:30:04 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu,  6 Sep 2018 07:29:44 +0400
Message-Id: <20180906032949.13753-2-marcandre.lureau@redhat.com>
In-Reply-To: <20180906032949.13753-1-marcandre.lureau@redhat.com>
References: <20180906032949.13753-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v11 1/6] hw/i386: add pc-i440fx-3.1 & pc-q35-3.1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, stefanb@linux.vnet.ibm.com, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

The following patch is going to add compatiblity parameters.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/hw/i386/pc.h |  5 ++++-
 hw/i386/pc_piix.c    | 15 ++++++++++++---
 hw/i386/pc_q35.c     | 13 +++++++++++--
 3 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 6894f37df1..09b0365a8e 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -294,7 +294,10 @@ int e820_add_entry(uint64_t, uint64_t, uint32_t);
 int e820_get_num_entries(void);
 bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
=20
-#define PC_COMPAT_2_12 \
+#define PC_COMPAT_3_0 \
+    HW_COMPAT_3_0
+
+#define PC_COMPAT_2_12                          \
     HW_COMPAT_2_12 \
     {\
         .driver   =3D TYPE_X86_CPU,\
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index dc09466b3e..7092d6d13f 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -428,21 +428,30 @@ static void pc_i440fx_machine_options(MachineClass =
*m)
     machine_class_allow_dynamic_sysbus_dev(m, TYPE_RAMFB_DEVICE);
 }
=20
-static void pc_i440fx_3_0_machine_options(MachineClass *m)
+static void pc_i440fx_3_1_machine_options(MachineClass *m)
 {
     pc_i440fx_machine_options(m);
     m->alias =3D "pc";
     m->is_default =3D 1;
 }
=20
+DEFINE_I440FX_MACHINE(v3_1, "pc-i440fx-3.1", NULL,
+                      pc_i440fx_3_1_machine_options);
+
+static void pc_i440fx_3_0_machine_options(MachineClass *m)
+{
+    pc_i440fx_3_1_machine_options(m);
+    m->is_default =3D 0;
+    m->alias =3D NULL;
+    SET_MACHINE_COMPAT(m, PC_COMPAT_3_0);
+}
+
 DEFINE_I440FX_MACHINE(v3_0, "pc-i440fx-3.0", NULL,
                       pc_i440fx_3_0_machine_options);
=20
 static void pc_i440fx_2_12_machine_options(MachineClass *m)
 {
     pc_i440fx_3_0_machine_options(m);
-    m->is_default =3D 0;
-    m->alias =3D NULL;
     SET_MACHINE_COMPAT(m, PC_COMPAT_2_12);
 }
=20
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 532241e3f8..4702bb13c4 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -311,19 +311,28 @@ static void pc_q35_machine_options(MachineClass *m)
     m->max_cpus =3D 288;
 }
=20
-static void pc_q35_3_0_machine_options(MachineClass *m)
+static void pc_q35_3_1_machine_options(MachineClass *m)
 {
     pc_q35_machine_options(m);
     m->alias =3D "q35";
 }
=20
+DEFINE_Q35_MACHINE(v3_1, "pc-q35-3.1", NULL,
+                   pc_q35_3_1_machine_options);
+
+static void pc_q35_3_0_machine_options(MachineClass *m)
+{
+    pc_q35_3_1_machine_options(m);
+    m->alias =3D NULL;
+    SET_MACHINE_COMPAT(m, PC_COMPAT_3_0);
+}
+
 DEFINE_Q35_MACHINE(v3_0, "pc-q35-3.0", NULL,
                     pc_q35_3_0_machine_options);
=20
 static void pc_q35_2_12_machine_options(MachineClass *m)
 {
     pc_q35_3_0_machine_options(m);
-    m->alias =3D NULL;
     SET_MACHINE_COMPAT(m, PC_COMPAT_2_12);
 }
=20
--=20
2.19.0.rc1
