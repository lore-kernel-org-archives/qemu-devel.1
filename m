Received: from eggs.gnu.org ([2001:4830:134:3::10]:54324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1eRSJ3-0001tV-Rz
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 19:32:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1eRSIy-00070T-VP
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 19:32:21 -0500
Received: from mail-sn1nam01on0055.outbound.protection.outlook.com
	([104.47.32.55]:55104
	helo=NAM01-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1eRSIy-0006za-K5
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 19:32:16 -0500
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Tue, 19 Dec 2017 16:27:51 -0800
Message-ID: <3990744c54db75d6afd69964e05683cdab48bfc5.1513729519.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1513729519.git.alistair.francis@xilinx.com>
References: <cover.1513729519.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 1/5] netduino2: Specify the valid CPUs
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

Although the board only ever has a Cortex-M3 we mark the Cortex-M4 as
supported because the Netduino2 Plus supports the Cortex-M4 and the
Netduino2 Plus is similar to the Netduino2.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---

V3:
 - Add static property
V2:
 - Fixup allignment
RFC v2:
 - Use a NULL terminated list
 - Add the Cortex-M4 for testing


 hw/arm/netduino2.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/hw/arm/netduino2.c b/hw/arm/netduino2.c
index f936017d4a..111a1d0aba 100644
--- a/hw/arm/netduino2.c
+++ b/hw/arm/netduino2.c
@@ -34,18 +34,26 @@ static void netduino2_init(MachineState *machine)
     DeviceState *dev;
=20
     dev =3D qdev_create(NULL, TYPE_STM32F205_SOC);
-    qdev_prop_set_string(dev, "cpu-type", ARM_CPU_TYPE_NAME("cortex-m3"));
+    qdev_prop_set_string(dev, "cpu-type", machine->cpu_type);
     object_property_set_bool(OBJECT(dev), true, "realized", &error_fatal);
=20
     armv7m_load_kernel(ARM_CPU(first_cpu), machine->kernel_filename,
                        FLASH_SIZE);
 }
=20
+static const char *netduino_valid_cpus[] =3D {
+                                            ARM_CPU_TYPE_NAME("cortex-m3")=
,
+                                            ARM_CPU_TYPE_NAME("cortex-m4")=
,
+                                            NULL
+                                           };
+
 static void netduino2_machine_init(MachineClass *mc)
 {
     mc->desc =3D "Netduino 2 Machine";
     mc->init =3D netduino2_init;
     mc->ignore_memory_transaction_failures =3D true;
+    mc->default_cpu_type =3D ARM_CPU_TYPE_NAME("cortex-m3");
+    mc->valid_cpu_types =3D netduino_valid_cpus;
 }
=20
 DEFINE_MACHINE("netduino2", netduino2_machine_init)
--=20
2.14.1
