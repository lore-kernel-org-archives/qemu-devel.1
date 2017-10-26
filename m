Received: from eggs.gnu.org ([2001:4830:134:3::10]:44901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e7ioZ-0005ud-8L
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 10:07:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e7ioU-0001cU-LX
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 10:07:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39124)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1e7ioU-0001bh-En
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 10:07:14 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 26 Oct 2017 16:04:02 +0200
Message-Id: <20171026140404.21948-38-ehabkost@redhat.com>
In-Reply-To: <20171026140404.21948-1-ehabkost@redhat.com>
References: <20171026140404.21948-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 37/39] mips: r4k: replace cpu_model with cpu_type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>

From: Igor Mammedov <imammedo@redhat.com>

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-Id: <1507211474-188400-41-git-send-email-imammedo@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/mips/mips_r4k.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/hw/mips/mips_r4k.c b/hw/mips/mips_r4k.c
index 1272d4ef9d..3bbb1827e1 100644
--- a/hw/mips/mips_r4k.c
+++ b/hw/mips/mips_r4k.c
@@ -163,7 +163,6 @@ static
 void mips_r4k_init(MachineState *machine)
 {
     ram_addr_t ram_size =3D machine->ram_size;
-    const char *cpu_model =3D machine->cpu_model;
     const char *kernel_filename =3D machine->kernel_filename;
     const char *kernel_cmdline =3D machine->kernel_cmdline;
     const char *initrd_filename =3D machine->initrd_filename;
@@ -186,14 +185,7 @@ void mips_r4k_init(MachineState *machine)
     int be;
=20
     /* init CPUs */
-    if (cpu_model =3D=3D NULL) {
-#ifdef TARGET_MIPS64
-        cpu_model =3D "R4000";
-#else
-        cpu_model =3D "24Kf";
-#endif
-    }
-    cpu =3D MIPS_CPU(cpu_generic_init(TYPE_MIPS_CPU, cpu_model));
+    cpu =3D MIPS_CPU(cpu_create(machine->cpu_type));
     env =3D &cpu->env;
=20
     reset_info =3D g_malloc0(sizeof(ResetData));
@@ -303,6 +295,12 @@ static void mips_machine_init(MachineClass *mc)
     mc->desc =3D "mips r4k platform";
     mc->init =3D mips_r4k_init;
     mc->block_default_type =3D IF_IDE;
+#ifdef TARGET_MIPS64
+    mc->default_cpu_type =3D MIPS_CPU_TYPE_NAME("R4000");
+#else
+    mc->default_cpu_type =3D MIPS_CPU_TYPE_NAME("24Kf");
+#endif
+
 }
=20
 DEFINE_MACHINE("mips", mips_machine_init)
--=20
2.13.6
