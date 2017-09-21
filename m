Received: from eggs.gnu.org ([2001:4830:134:3::10]:45880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dvBAD-0004mC-Ls
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 19:45:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dvBA9-00026B-Db
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 19:45:49 -0400
Received: from mail-co1nam03on0052.outbound.protection.outlook.com
	([104.47.40.52]:27937
	helo=NAM03-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1dvBA9-000251-1m
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 19:45:45 -0400
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Thu, 21 Sep 2017 16:41:53 -0700
Message-ID: <985f362ba206a6e095eacb1719dfd738dba0673c.1506037164.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1506037164.git.alistair.francis@xilinx.com>
References: <cover.1506037164.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [RFC v2 2/2] netduino2: Specify the valid CPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, ehabkost@redhat.com, marcel@redhat.com, imammedo@redhat.com

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
---

RFC v2:
 - Use a NULL terminated list
 - Add the Cortex-M4 for testing


 hw/arm/netduino2.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/hw/arm/netduino2.c b/hw/arm/netduino2.c
index f936017d4a..391742ea11 100644
--- a/hw/arm/netduino2.c
+++ b/hw/arm/netduino2.c
@@ -34,18 +34,26 @@ static void netduino2_init(MachineState *machine)
     DeviceState *dev;
 
     dev = qdev_create(NULL, TYPE_STM32F205_SOC);
-    qdev_prop_set_string(dev, "cpu-type", ARM_CPU_TYPE_NAME("cortex-m3"));
+    qdev_prop_set_string(dev, "cpu-type", machine->cpu_type);
     object_property_set_bool(OBJECT(dev), true, "realized", &error_fatal);
 
     armv7m_load_kernel(ARM_CPU(first_cpu), machine->kernel_filename,
                        FLASH_SIZE);
 }
 
+const char *netduino_valid_cpus[] = { ARM_CPU_TYPE_NAME("cortex-m3"),
+                                      ARM_CPU_TYPE_NAME("cortex-m4"),
+                                      NULL
+                                    };
+
 static void netduino2_machine_init(MachineClass *mc)
 {
     mc->desc = "Netduino 2 Machine";
     mc->init = netduino2_init;
     mc->ignore_memory_transaction_failures = true;
+    mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-m3");
+
+    mc->valid_cpu_types = netduino_valid_cpus;
 }
 
 DEFINE_MACHINE("netduino2", netduino2_machine_init)
-- 
2.11.0
