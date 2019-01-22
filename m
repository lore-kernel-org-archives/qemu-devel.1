Received: from eggs.gnu.org ([209.51.188.92]:46814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gm4W5-0003Cu-Du
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 17:27:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gm4IK-0006jk-GM
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 17:13:21 -0500
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:42114)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1gm4IK-0006j0-8u
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 17:13:20 -0500
Received: by mail-lj1-x244.google.com with SMTP id l15-v6so99574lja.9
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 14:13:20 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Tue, 22 Jan 2019 14:12:56 -0800
Message-Id: <20190122221256.20883-3-jcmvbkbc@gmail.com>
In-Reply-To: <20190122221256.20883-1-jcmvbkbc@gmail.com>
References: <20190122221256.20883-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 2/2] hw/xtensa: xtfpga: use core frequency
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>

XTFPGA board FPGA peripheral exposes hard-coded 10MHz frequency
regardless of the actual used core frequency. Expose actual core
frequency instead.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 hw/xtensa/xtfpga.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
index d3afdfc247a7..7379b3fff427 100644
--- a/hw/xtensa/xtfpga.c
+++ b/hw/xtensa/xtfpga.c
@@ -61,6 +61,7 @@ typedef struct XtfpgaBoardDesc {
 
 typedef struct XtfpgaFpgaState {
     MemoryRegion iomem;
+    uint32_t freq;
     uint32_t leds;
     uint32_t switches;
 } XtfpgaFpgaState;
@@ -83,7 +84,7 @@ static uint64_t xtfpga_fpga_read(void *opaque, hwaddr addr,
         return 0x09272011;
 
     case 0x4: /*processor clock frequency, Hz*/
-        return 10000000;
+        return s->freq;
 
     case 0x8: /*LEDs (off = 0, on = 1)*/
         return s->leds;
@@ -119,13 +120,14 @@ static const MemoryRegionOps xtfpga_fpga_ops = {
 };
 
 static XtfpgaFpgaState *xtfpga_fpga_init(MemoryRegion *address_space,
-        hwaddr base)
+                                         hwaddr base, uint32_t freq)
 {
     XtfpgaFpgaState *s = g_malloc(sizeof(XtfpgaFpgaState));
 
     memory_region_init_io(&s->iomem, NULL, &xtfpga_fpga_ops, s,
-            "xtfpga.fpga", 0x10000);
+                          "xtfpga.fpga", 0x10000);
     memory_region_add_subregion(address_space, base, &s->iomem);
+    s->freq = freq;
     xtfpga_fpga_reset(s);
     qemu_register_reset(xtfpga_fpga_reset, s);
     return s;
@@ -231,6 +233,7 @@ static void xtfpga_init(const XtfpgaBoardDesc *board, MachineState *machine)
     const char *dtb_filename = qemu_opt_get(machine_opts, "dtb");
     const char *initrd_filename = qemu_opt_get(machine_opts, "initrd");
     const unsigned system_io_size = 224 * MiB;
+    uint32_t freq = 10000000;
     int n;
 
     for (n = 0; n < smp_cpus; n++) {
@@ -240,6 +243,7 @@ static void xtfpga_init(const XtfpgaBoardDesc *board, MachineState *machine)
         cenv = &cpu->env;
         if (!env) {
             env = cenv;
+            freq = env->config->clock_freq_khz * 1000;
         }
 
         cenv->sregs[PRID] = n;
@@ -277,7 +281,7 @@ static void xtfpga_init(const XtfpgaBoardDesc *board, MachineState *machine)
                                  system_io, 0, system_io_size);
         memory_region_add_subregion(system_memory, board->io[1], io);
     }
-    xtfpga_fpga_init(system_io, 0x0d020000);
+    xtfpga_fpga_init(system_io, 0x0d020000, freq);
     if (nd_table[0].used) {
         xtfpga_net_init(system_io, 0x0d030000, 0x0d030400, 0x0d800000,
                 xtensa_get_extint(env, 1), nd_table);
-- 
2.11.0
