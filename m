Received: from eggs.gnu.org ([2001:4830:134:3::10]:35807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gXSO5-0003zu-9L
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:54:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gXSO4-00073q-3y
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:54:53 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:53506)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gXSO3-0006zA-Ry
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:54:52 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1gXSNy-0007FP-Vg
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 14:54:46 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Dec 2018 14:54:10 +0000
Message-Id: <20181213145445.17935-3-peter.maydell@linaro.org>
In-Reply-To: <20181213145445.17935-1-peter.maydell@linaro.org>
References: <20181213145445.17935-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 02/37] Allow AArch64 processors to boot from a
 kernel placed over 4GB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Ricardo Perez Blanco <ricardo.perez_blanco@nokia.com>

Architecturally, it's possible for an AArch64 machine to have
all of its RAM over the 4GB mark, but our kernel/initrd loading
code in boot.c assumes that the upper half of the addresses
to load these images to is always zero. Write the whole 64 bit
address into the bootloader code fragment, not just the low half.

Note that, currently, none of the existing QEMU machines have
their main memory over 4GBs, so this was not a user-visible bug.

Signed-off-by: Ricardo Perez Blanco <ricardo.perez_blanco@nokia.com>
[PMM: revised commit message and tweaked some long lines]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/boot.c | 35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index 586baa9b647..94fce128028 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -63,8 +63,10 @@ typedef enum {
     FIXUP_TERMINATOR,   /* end of insns */
     FIXUP_BOARDID,      /* overwrite with board ID number */
     FIXUP_BOARD_SETUP,  /* overwrite with board specific setup code address */
-    FIXUP_ARGPTR,       /* overwrite with pointer to kernel args */
-    FIXUP_ENTRYPOINT,   /* overwrite with kernel entry point */
+    FIXUP_ARGPTR_LO,    /* overwrite with pointer to kernel args */
+    FIXUP_ARGPTR_HI,    /* overwrite with pointer to kernel args (high half) */
+    FIXUP_ENTRYPOINT_LO, /* overwrite with kernel entry point */
+    FIXUP_ENTRYPOINT_HI, /* overwrite with kernel entry point (high half) */
     FIXUP_GIC_CPU_IF,   /* overwrite with GIC CPU interface address */
     FIXUP_BOOTREG,      /* overwrite with boot register address */
     FIXUP_DSB,          /* overwrite with correct DSB insn for cpu */
@@ -83,10 +85,10 @@ static const ARMInsnFixup bootloader_aarch64[] = {
     { 0xaa1f03e3 }, /* mov x3, xzr */
     { 0x58000084 }, /* ldr x4, entry ; Load the lower 32-bits of kernel entry */
     { 0xd61f0080 }, /* br x4      ; Jump to the kernel entry point */
-    { 0, FIXUP_ARGPTR }, /* arg: .word @DTB Lower 32-bits */
-    { 0 }, /* .word @DTB Higher 32-bits */
-    { 0, FIXUP_ENTRYPOINT }, /* entry: .word @Kernel Entry Lower 32-bits */
-    { 0 }, /* .word @Kernel Entry Higher 32-bits */
+    { 0, FIXUP_ARGPTR_LO }, /* arg: .word @DTB Lower 32-bits */
+    { 0, FIXUP_ARGPTR_HI}, /* .word @DTB Higher 32-bits */
+    { 0, FIXUP_ENTRYPOINT_LO }, /* entry: .word @Kernel Entry Lower 32-bits */
+    { 0, FIXUP_ENTRYPOINT_HI }, /* .word @Kernel Entry Higher 32-bits */
     { 0, FIXUP_TERMINATOR }
 };
 
@@ -106,8 +108,8 @@ static const ARMInsnFixup bootloader[] = {
     { 0xe59f2004 }, /* ldr     r2, [pc, #4] */
     { 0xe59ff004 }, /* ldr     pc, [pc, #4] */
     { 0, FIXUP_BOARDID },
-    { 0, FIXUP_ARGPTR },
-    { 0, FIXUP_ENTRYPOINT },
+    { 0, FIXUP_ARGPTR_LO },
+    { 0, FIXUP_ENTRYPOINT_LO },
     { 0, FIXUP_TERMINATOR }
 };
 
@@ -174,8 +176,10 @@ static void write_bootloader(const char *name, hwaddr addr,
             break;
         case FIXUP_BOARDID:
         case FIXUP_BOARD_SETUP:
-        case FIXUP_ARGPTR:
-        case FIXUP_ENTRYPOINT:
+        case FIXUP_ARGPTR_LO:
+        case FIXUP_ARGPTR_HI:
+        case FIXUP_ENTRYPOINT_LO:
+        case FIXUP_ENTRYPOINT_HI:
         case FIXUP_GIC_CPU_IF:
         case FIXUP_BOOTREG:
         case FIXUP_DSB:
@@ -1152,9 +1156,13 @@ void arm_load_kernel(ARMCPU *cpu, struct arm_boot_info *info)
             /* Place the DTB after the initrd in memory with alignment. */
             info->dtb_start = QEMU_ALIGN_UP(info->initrd_start + initrd_size,
                                            align);
-            fixupcontext[FIXUP_ARGPTR] = info->dtb_start;
+            fixupcontext[FIXUP_ARGPTR_LO] = info->dtb_start;
+            fixupcontext[FIXUP_ARGPTR_HI] = info->dtb_start >> 32;
         } else {
-            fixupcontext[FIXUP_ARGPTR] = info->loader_start + KERNEL_ARGS_ADDR;
+            fixupcontext[FIXUP_ARGPTR_LO] =
+                info->loader_start + KERNEL_ARGS_ADDR;
+            fixupcontext[FIXUP_ARGPTR_HI] =
+                (info->loader_start + KERNEL_ARGS_ADDR) >> 32;
             if (info->ram_size >= (1ULL << 32)) {
                 error_report("RAM size must be less than 4GB to boot"
                              " Linux kernel using ATAGS (try passing a device tree"
@@ -1162,7 +1170,8 @@ void arm_load_kernel(ARMCPU *cpu, struct arm_boot_info *info)
                 exit(1);
             }
         }
-        fixupcontext[FIXUP_ENTRYPOINT] = entry;
+        fixupcontext[FIXUP_ENTRYPOINT_LO] = entry;
+        fixupcontext[FIXUP_ENTRYPOINT_HI] = entry >> 32;
 
         write_bootloader("bootloader", info->loader_start,
                          primary_loader, fixupcontext, as);
-- 
2.19.2
