Received: from eggs.gnu.org ([2001:4830:134:3::10]:50637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <penberg@gmail.com>) id 1ejf7E-0001si-G1
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 00:51:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <penberg@gmail.com>) id 1ejf7D-0000Qd-Lk
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 00:51:24 -0500
Sender: Pekka Enberg <penberg@gmail.com>
From: Pekka Enberg <penberg@iki.fi>
Date: Thu,  8 Feb 2018 07:50:39 +0200
Message-Id: <20180208055039.24666-4-penberg@iki.fi>
In-Reply-To: <20180208055039.24666-1-penberg@iki.fi>
References: <20180208055039.24666-1-penberg@iki.fi>
Subject: [Qemu-devel] [PATCH v1 3/3] raspi: Add "raspi3" machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, Pekka Enberg <penberg@iki.fi>

This patch adds a "raspi3" machine type, which can now be selected as
the machine to run on by users via the "-M" command line option to QEMU.

The machine type does *not* ignore memory transaction failures so we
likely need to add some dummy devices later when people run something
more complicated than what I'm using for testing.

Signed-off-by: Pekka Enberg <penberg@iki.fi>
---
 hw/arm/raspi.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index 66fe10e376..048ff23a51 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -187,3 +187,24 @@ static void raspi2_machine_init(MachineClass *mc)
     mc->ignore_memory_transaction_failures = true;
 };
 DEFINE_MACHINE("raspi2", raspi2_machine_init)
+
+static void raspi3_init(MachineState *machine)
+{
+    raspi_init(machine, 3);
+}
+
+static void raspi3_machine_init(MachineClass *mc)
+{
+    mc->desc = "Raspberry Pi 3";
+    mc->init = raspi3_init;
+    mc->block_default_type = IF_SD;
+    mc->no_parallel = 1;
+    mc->no_floppy = 1;
+    mc->no_cdrom = 1;
+    mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a53");
+    mc->max_cpus = BCM2836_NCPUS;
+    mc->min_cpus = BCM2836_NCPUS;
+    mc->default_cpus = BCM2836_NCPUS;
+    mc->default_ram_size = 1024 * 1024 * 1024;
+}
+DEFINE_MACHINE("raspi3", raspi3_machine_init)
-- 
2.14.3
