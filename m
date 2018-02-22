Received: from eggs.gnu.org ([2001:4830:134:3::10]:38252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eosiU-0004gB-20
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:23:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eosiS-0001Z6-Ah
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:23:26 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46586)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eosiS-0001Ye-0w
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:23:24 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1eosiR-00020Z-2M
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 15:23:23 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Feb 2018 15:22:37 +0000
Message-Id: <20180222152307.7499-3-peter.maydell@linaro.org>
In-Reply-To: <20180222152307.7499-1-peter.maydell@linaro.org>
References: <20180222152307.7499-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 02/32] raspi: Add "raspi3" machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Pekka Enberg <penberg@iki.fi>

This patch adds a "raspi3" machine type, which can now be selected as
the machine to run on by users via the "-M" command line option to QEMU.

The machine type does *not* ignore memory transaction failures so we
likely need to add some dummy devices later when people run something
more complicated than what I'm using for testing.

Signed-off-by: Pekka Enberg <penberg@iki.fi>
[PMM: added #ifdef TARGET_AARCH64 so we don't provide the 64-bit
 board in the 32-bit only arm-softmmu build.]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/raspi.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index 93121c56bf..a37881433c 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -187,3 +187,26 @@ static void raspi2_machine_init(MachineClass *mc)
     mc->ignore_memory_transaction_failures = true;
 };
 DEFINE_MACHINE("raspi2", raspi2_machine_init)
+
+#ifdef TARGET_AARCH64
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
+#endif
-- 
2.16.1
