Received: from eggs.gnu.org ([2001:4830:134:3::10]:54407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1eRSJD-000204-03
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 19:32:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1eRSJ8-00075H-7h
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 19:32:31 -0500
Received: from mail-sn1nam02on0082.outbound.protection.outlook.com
	([104.47.36.82]:48984
	helo=NAM02-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1eRSJ7-00074t-Vj
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 19:32:26 -0500
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Tue, 19 Dec 2017 16:27:59 -0800
Message-ID: <2ac3cbb3f44c35bf061c0c14a2955a4f8884b30b.1513729519.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1513729519.git.alistair.francis@xilinx.com>
References: <cover.1513729519.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 4/5] xlnx-zcu102: Specify the valid CPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, ehabkost@redhat.com, marcel@redhat.com, imammedo@redhat.com, f4bug@amsat.org

List all possible valid CPU options.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---

An implementation for single CPU machines is still being discussed. A
solution proposed by Eduardo is this:

1) Change the default on TYPE_MACHINE to:
     mc->valid_cpu_types =3D { TYPE_CPU, NULL };

   This will keep the existing behavior for all boards.

2) mc->valid_cpu_types=3DNULL be interpreted as "no CPU model
   except the default is accepted" or "-cpu is not accepted" in
   machine_run_board_init() (I prefer the former, but both
   options would be correct)

3) Boards like xlnx_zynqmp could then just do this:

   static void xxx_class_init(...) {
       mc->default_cpu_type =3D MY_CPU_TYPE;
       /* Reason: XXX_init() is hardcoded to MY_CPU_TYPE */
       mc->valid_cpu_types =3D NULL;
   }
V4:
 - Remove spaces
V3:
 - Make variable static
V2:
 - Don't use the users -cpu
 - Fixup allignment

 hw/arm/xlnx-zcu102.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/hw/arm/xlnx-zcu102.c b/hw/arm/xlnx-zcu102.c
index b126cf148b..08b5c28a3a 100644
--- a/hw/arm/xlnx-zcu102.c
+++ b/hw/arm/xlnx-zcu102.c
@@ -184,6 +184,11 @@ static void xlnx_zynqmp_init(XlnxZCU102 *s, MachineSta=
te *machine)
     arm_load_kernel(s->soc.boot_cpu_ptr, &xlnx_zcu102_binfo);
 }
=20
+static const char *xlnx_zynqmp_valid_cpus[] =3D {
+    ARM_CPU_TYPE_NAME("cortex-a53"),
+    NULL
+};
+
 static void xlnx_ep108_init(MachineState *machine)
 {
     XlnxZCU102 *s =3D EP108_MACHINE(machine);
@@ -216,6 +221,12 @@ static void xlnx_ep108_machine_class_init(ObjectClass =
*oc, void *data)
     mc->ignore_memory_transaction_failures =3D true;
     mc->max_cpus =3D XLNX_ZYNQMP_NUM_APU_CPUS + XLNX_ZYNQMP_NUM_RPU_CPUS;
     mc->default_cpus =3D XLNX_ZYNQMP_NUM_APU_CPUS;
+    mc->default_cpu_type =3D ARM_CPU_TYPE_NAME("cortex-a53");
+    /* The ZynqMP SoC is always a Cortex-A53. We add this here to give
+     * users a sane error if they specify a different CPU, but we never
+     * use their CPU choice.
+     */
+    mc->valid_cpu_types =3D xlnx_zynqmp_valid_cpus;
 }
=20
 static const TypeInfo xlnx_ep108_machine_init_typeinfo =3D {
@@ -274,6 +285,12 @@ static void xlnx_zcu102_machine_class_init(ObjectClass=
 *oc, void *data)
     mc->ignore_memory_transaction_failures =3D true;
     mc->max_cpus =3D XLNX_ZYNQMP_NUM_APU_CPUS + XLNX_ZYNQMP_NUM_RPU_CPUS;
     mc->default_cpus =3D XLNX_ZYNQMP_NUM_APU_CPUS;
+    mc->default_cpu_type =3D ARM_CPU_TYPE_NAME("cortex-a53");
+    /* The ZynqMP SoC is always a Cortex-A53. We add this here to give
+     * users a sane error if they specify a different CPU, but we never
+     * use their CPU choice.
+     */
+    mc->valid_cpu_types =3D xlnx_zynqmp_valid_cpus;
 }
=20
 static const TypeInfo xlnx_zcu102_machine_init_typeinfo =3D {
--=20
2.14.1
