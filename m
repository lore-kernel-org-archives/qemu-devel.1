Received: from eggs.gnu.org ([2001:4830:134:3::10]:46711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <penberg@gmail.com>) id 1ema2E-0003QU-I1
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 02:02:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <penberg@gmail.com>) id 1ema2C-0007lJ-Db
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 02:02:18 -0500
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:42854)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <penberg@gmail.com>) id 1ema2C-0007ko-6I
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 02:02:16 -0500
Received: by mail-lf0-x244.google.com with SMTP id t204so96559lff.9
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 23:02:15 -0800 (PST)
Sender: Pekka Enberg <penberg@gmail.com>
From: Pekka Enberg <penberg@iki.fi>
Date: Fri, 16 Feb 2018 09:02:01 +0200
Message-Id: <20180216070201.4271-4-penberg@iki.fi>
In-Reply-To: <20180216070201.4271-1-penberg@iki.fi>
References: <20180216070201.4271-1-penberg@iki.fi>
Subject: [Qemu-devel] [PATCH v2 3/3] raspi: Add "raspi3" machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Pekka Enberg <penberg@iki.fi>

This patch adds a "raspi3" machine type, which can now be selected as
the machine to run on by users via the "-M" command line option to QEMU.

The machine type does *not* ignore memory transaction failures so we
likely need to add some dummy devices later when people run something
more complicated than what I'm using for testing.

Signed-off-by: Pekka Enberg <penberg@iki.fi>
---
 hw/arm/raspi.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index 66fe10e376..ff54f45e3e 100644
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
2.14.3
