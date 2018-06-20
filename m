Received: from eggs.gnu.org ([2001:4830:134:3::10]:37004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@mips.com>) id 1fVc0t-0000xu-UF
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:15:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Yongbok.Kim@mips.com>) id 1fVc0q-00005H-K8
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:15:03 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.150.225]:50551)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Yongbok.Kim@mips.com>)
	id 1fVc0q-0008T6-DF
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:15:00 -0400
From: Yongbok Kim <yongbok.kim@mips.com>
Date: Wed, 20 Jun 2018 13:06:15 +0100
Message-ID: <20180620120620.12806-31-yongbok.kim@mips.com>
In-Reply-To: <20180620120620.12806-1-yongbok.kim@mips.com>
References: <20180620120620.12806-1-yongbok.kim@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 30/35] hw/mips: Add basic nanoMIPS boot code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, Aleksandar.Markovic@mips.com, James.Hogan@mips.com, Paul.Burton@mips.com, Matthew.Fortune@mips.com, Stefan.Markovic@mips.com

From: Matthew Fortune <matthew.fortune@imgtec.com>

Added very very basic R7 boot code but this is hacked in
unconditionally currently.

Yongbok:
Fix to use right boot loader

Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
---
 hw/mips/mips_malta.c | 75 +++++++++++++++++++++++++++++++++++++++++++++++-----
 include/elf.h        |  1 +
 2 files changed, 70 insertions(+), 6 deletions(-)

diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index 494f84e..39f4c5b 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -619,6 +619,58 @@ static void network_init(PCIBus *pci_bus)
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
@@ -812,10 +864,16 @@ static int64_t load_kernel (void)
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
@@ -1093,8 +1151,13 @@ void mips_malta_init(MachineState *machine)
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
diff --git a/include/elf.h b/include/elf.h
index 934dbbd..2f9c2e2 100644
--- a/include/elf.h
+++ b/include/elf.h
@@ -121,6 +121,7 @@ typedef int64_t  Elf64_Sxword;
 
 #define EM_RISCV        243     /* RISC-V */
 
+#define EM_NANOMIPS     249     /* MIPS Tech nanoMIPS */
 /*
  * This is an interim value that we will use until the committee comes
  * up with a final number.
-- 
1.9.1
