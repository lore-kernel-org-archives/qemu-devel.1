Received: from eggs.gnu.org ([2001:4830:134:3::10]:52730)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fi1dT-0003kZ-2X
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 14:02:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fi1dO-0003Ib-79
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 14:02:11 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:55831 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fi1dN-0003GN-Rl
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 14:02:06 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Tue, 24 Jul 2018 19:31:48 +0200
Message-Id: <1532453527-22911-37-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1532453527-22911-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1532453527-22911-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v4 36/55] mips_malta: Add basic nanoMIPS boot
 code for MIPS' Malta
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

From: Matthew Fortune <matthew.fortune@mips.com>

Added very very basic nanoMIPS boot code but this is hacked in
unconditionally currently.

Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 hw/mips/mips_malta.c | 75 +++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 69 insertions(+), 6 deletions(-)

diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index 3467451..4bc9036 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -620,6 +620,58 @@ static void network_init(PCIBus *pci_bus)
      a2 - 32-bit address of the environment variables table
      a3 - RAM size in bytes
 */
+static void write_bootloader_nanomips(uint8_t *base, int64_t run_addr,
+                                      int64_t kernel_entry)
+{
+    uint16_t *p;
+
+    /* Small bootloader */
+    p = (uint16_t *)base;
+
+#define NM_HI1(VAL) (((VAL) >> 16) & 0x1f)
+#define NM_HI2(VAL) \
+            (((VAL) & 0xf000) | (((VAL) >> 19) & 0xffc) | (((VAL) >> 31) & 0x1))
+#define NM_LO(VAL)  ((VAL) & 0xfff)
+
+    stw_p(p++, 0x2800); stw_p(p++, 0x001c); /* bc to_here */
+    stw_p(p++, 0x8000); stw_p(p++, 0xc000); /* nop */
+    stw_p(p++, 0x8000); stw_p(p++, 0xc000); /* nop */
+    stw_p(p++, 0x8000); stw_p(p++, 0xc000); /* nop */
+    stw_p(p++, 0x8000); stw_p(p++, 0xc000); /* nop */
+    stw_p(p++, 0x8000); stw_p(p++, 0xc000); /* nop */
+    stw_p(p++, 0x8000); stw_p(p++, 0xc000); /* nop */
+    stw_p(p++, 0x8000); stw_p(p++, 0xc000); /* nop */
+
+    /* to_here: */
+    stw_p(p++, 0x0080); stw_p(p++, 0x0002); /* li a0,2 */
+    stw_p(p++, 0xe3a0 | NM_HI1(ENVP_ADDR - 64));
+    stw_p(p++, NM_HI2(ENVP_ADDR - 64));
+                                /* lui sp,%hi(ENVP_ADDR - 64) */
+    stw_p(p++, 0x83bd); stw_p(p++, NM_LO(ENVP_ADDR - 64));
+                                /* ori sp,sp,%lo(ENVP_ADDR - 64) */
+    stw_p(p++, 0xe0a0 | NM_HI1(ENVP_ADDR));
+    stw_p(p++, NM_HI2(ENVP_ADDR));
+                                /* lui a1,%hi(ENVP_ADDR) */
+    stw_p(p++, 0x80a5); stw_p(p++, NM_LO(ENVP_ADDR));
+                                /* ori a1,a1,%lo(ENVP_ADDR) */
+    stw_p(p++, 0xe0c0 | NM_HI1(ENVP_ADDR + 8));
+    stw_p(p++, NM_HI2(ENVP_ADDR + 8));
+                                /* lui a2,%hi(ENVP_ADDR + 8) */
+    stw_p(p++, 0x80c6); stw_p(p++, NM_LO(ENVP_ADDR + 8));
+                                /* ori a2,a2,%lo(ENVP_ADDR + 8) */
+    stw_p(p++, 0xe0e0 | NM_HI1(loaderparams.ram_low_size));
+    stw_p(p++, NM_HI2(loaderparams.ram_low_size));
+                                /* lui a3,%hi(loaderparams.ram_low_size) */
+    stw_p(p++, 0x80e7); stw_p(p++, NM_LO(loaderparams.ram_low_size));
+                                /* ori a3,a3,%lo(loaderparams.ram_low_size) */
+    stw_p(p++, 0xe320 | NM_HI1(kernel_entry));
+    stw_p(p++, NM_HI2(kernel_entry));
+                                /* lui t9,%hi(kernel_entry) */
+    stw_p(p++, 0x8339); stw_p(p++, NM_LO(kernel_entry));
+                                /* ori t9,t9,%lo(kernel_entry) */
+    stw_p(p++, 0x4bf9); stw_p(p++, 0x0000);
+                                /* jalrc   t8 */
+}
 
 static void write_bootloader(uint8_t *base, int64_t run_addr,
                              int64_t kernel_entry)
@@ -813,10 +865,16 @@ static int64_t load_kernel (void)
                            NULL, (uint64_t *)&kernel_entry, NULL,
                            (uint64_t *)&kernel_high, big_endian, EM_MIPS, 1, 0);
     if (kernel_size < 0) {
-        error_report("could not load kernel '%s': %s",
-                     loaderparams.kernel_filename,
-                     load_elf_strerror(kernel_size));
-        exit(1);
+        kernel_size = load_elf(loaderparams.kernel_filename,
+                    cpu_mips_kseg0_to_phys, NULL,
+                    (uint64_t *)&kernel_entry, NULL,
+                    (uint64_t *)&kernel_high, big_endian, EM_NANOMIPS, 1, 0);
+        if (kernel_size < 0) {
+            error_report("could not load kernel '%s': %s",
+                         loaderparams.kernel_filename,
+                         load_elf_strerror(kernel_size));
+            exit(1);
+        }
     }
 
     /* Check where the kernel has been linked */
@@ -1096,8 +1154,13 @@ void mips_malta_init(MachineState *machine)
         loaderparams.initrd_filename = initrd_filename;
         kernel_entry = load_kernel();
 
-        write_bootloader(memory_region_get_ram_ptr(bios),
-                         bootloader_run_addr, kernel_entry);
+        if (!cpu_supports_isa(machine->cpu_type, ISA_NANOMIPS32)) {
+            write_bootloader(memory_region_get_ram_ptr(bios),
+                             bootloader_run_addr, kernel_entry);
+        } else {
+            write_bootloader_nanomips(memory_region_get_ram_ptr(bios),
+                                      bootloader_run_addr, kernel_entry);
+        }
         if (kvm_enabled()) {
             /* Write the bootloader code @ the end of RAM, 1MB reserved */
             write_bootloader(memory_region_get_ram_ptr(ram_low_preio) +
-- 
2.7.4
