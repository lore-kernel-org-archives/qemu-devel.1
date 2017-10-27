Received: from eggs.gnu.org ([2001:4830:134:3::10]:33918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e85W5-0002V6-Gy
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 10:21:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e85W4-0008QO-IE
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 10:21:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32854)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1e85W4-0008Pn-9n
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 10:21:44 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 27 Oct 2017 16:20:35 +0200
Message-Id: <20171027142107.15542-8-ehabkost@redhat.com>
In-Reply-To: <20171027142107.15542-1-ehabkost@redhat.com>
References: <20171027142107.15542-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 07/39] lm32: lm32_boards: use generic
 cpu_model parsing
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
Acked-by: Michael Walle <michael@walle.cc>
Message-Id: <1507211474-188400-11-git-send-email-imammedo@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/lm32/lm32_boards.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/hw/lm32/lm32_boards.c b/hw/lm32/lm32_boards.c
index b0bb3ef58a..002d638edd 100644
--- a/hw/lm32/lm32_boards.c
+++ b/hw/lm32/lm32_boards.c
@@ -75,7 +75,6 @@ static void main_cpu_reset(void *opaque)
=20
 static void lm32_evr_init(MachineState *machine)
 {
-    const char *cpu_model =3D machine->cpu_model;
     const char *kernel_filename =3D machine->kernel_filename;
     LM32CPU *cpu;
     CPULM32State *env;
@@ -101,10 +100,7 @@ static void lm32_evr_init(MachineState *machine)
=20
     reset_info =3D g_malloc0(sizeof(ResetInfo));
=20
-    if (cpu_model =3D=3D NULL) {
-        cpu_model =3D "lm32-full";
-    }
-    cpu =3D LM32_CPU(cpu_generic_init(TYPE_LM32_CPU, cpu_model));
+    cpu =3D LM32_CPU(cpu_create(machine->cpu_type));
=20
     env =3D &cpu->env;
     reset_info->cpu =3D cpu;
@@ -163,7 +159,6 @@ static void lm32_evr_init(MachineState *machine)
=20
 static void lm32_uclinux_init(MachineState *machine)
 {
-    const char *cpu_model =3D machine->cpu_model;
     const char *kernel_filename =3D machine->kernel_filename;
     const char *kernel_cmdline =3D machine->kernel_cmdline;
     const char *initrd_filename =3D machine->initrd_filename;
@@ -198,10 +193,7 @@ static void lm32_uclinux_init(MachineState *machine)
=20
     reset_info =3D g_malloc0(sizeof(ResetInfo));
=20
-    if (cpu_model =3D=3D NULL) {
-        cpu_model =3D "lm32-full";
-    }
-    cpu =3D LM32_CPU(cpu_generic_init(TYPE_LM32_CPU, cpu_model));
+    cpu =3D LM32_CPU(cpu_create(machine->cpu_type));
=20
     env =3D &cpu->env;
     reset_info->cpu =3D cpu;
@@ -295,6 +287,7 @@ static void lm32_evr_class_init(ObjectClass *oc, void=
 *data)
     mc->desc =3D "LatticeMico32 EVR32 eval system";
     mc->init =3D lm32_evr_init;
     mc->is_default =3D 1;
+    mc->default_cpu_type =3D LM32_CPU_TYPE_NAME("lm32-full");
 }
=20
 static const TypeInfo lm32_evr_type =3D {
@@ -310,6 +303,7 @@ static void lm32_uclinux_class_init(ObjectClass *oc, =
void *data)
     mc->desc =3D "lm32 platform for uClinux and u-boot by Theobroma Syst=
ems";
     mc->init =3D lm32_uclinux_init;
     mc->is_default =3D 0;
+    mc->default_cpu_type =3D LM32_CPU_TYPE_NAME("lm32-full");
 }
=20
 static const TypeInfo lm32_uclinux_type =3D {
--=20
2.13.6
