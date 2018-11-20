Received: from eggs.gnu.org ([2001:4830:134:3::10]:52039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gP6P3-0005NJ-Li
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 08:49:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gP6P2-0002sO-Sl
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 08:49:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39360)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gP6P2-0002s0-Ll
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 08:49:20 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 20 Nov 2018 11:49:08 -0200
Message-Id: <20181120134908.8439-2-ehabkost@redhat.com>
In-Reply-To: <20181120134908.8439-1-ehabkost@redhat.com>
References: <20181120134908.8439-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/1] hw/i386: add pc-i440fx-3.1 & pc-q35-3.1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Roman Kagan <rkagan@virtuozzo.com>, Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

We have a couple of PC_COMPAT_3_0, so we should have 3.1 PC machines,
and update the 3.0 machines to make use of those.

Fixes a "Known issue" from https://wiki.qemu.org/Planning/3.1.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20181120132604.22854-1-marcandre.lureau@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/i386/pc_piix.c | 15 ++++++++++++---
 hw/i386/pc_q35.c  | 13 +++++++++++--
 2 files changed, 23 insertions(+), 5 deletions(-)

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
2.18.0.rc1.1.g3f1ff2140
