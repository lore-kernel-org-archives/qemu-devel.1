Received: from eggs.gnu.org ([2001:4830:134:3::10]:52366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dPtkK-0006q3-5h
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 12:53:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dPtgn-0006CB-Jg
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 12:50:12 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37355)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dPtgn-00066m-Ax
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 12:50:09 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Jun 2017 17:49:58 +0100
Message-Id: <1498582198-6649-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH] linux-user: Put PPC AT_IGNOREPPC auxv entries
 in the right place
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Laurent Vivier <laurent@vivier.eu>, Richard Henderson <rth@twiddle.net>, Riku Voipio <riku.voipio@iki.fi>

The 32-bit PPC auxv is a bit complicated because in the
mists of time it used to be 16-aligned rather than directly
after the environment. Older glibc versions had code to
try to probe for whether it needed alignment or not:
https://sourceware.org/git/?p=glibc.git;a=blob;f=sysdeps/unix/sysv/linux/powerpc/dl-sysdep.c;hb=e84eabb3871c9b39e59323bf3f6b98c2ca9d1cd0
and the kernel has code which puts some magic entries at
the bottom to ensure that the alignment probe fails:
http://elixir.free-electrons.com/linux/latest/source/arch/powerpc/include/asm/elf.h#L158

QEMU has similar code too, but it was broken by commit
7c4ee5bcc82e64, which changed elfload.c from filling in
the auxv starting at the highest address and working down
to starting at the lowest address and working up. This
means that the ARCH_DLINFO hook must now be invoked first
rather than last, and the entries in it for PPC must
be reversed so that the magic AT_IGNOREPPC entries come
at the lowest address in the auxv as they should.

The effect of this was that if running a guest binary that
used an old glibc with the alignment probing the guest ld.so
code would segfault if the size of the guest environment and
argv happened to put the auxv at an address that triggered
the alignment code in the guest glibc.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 linux-user/elfload.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index ce77317..2a902f7 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -802,14 +802,15 @@ static uint32_t get_elf_hwcap2(void)
 #define ARCH_DLINFO                                     \
     do {                                                \
         PowerPCCPU *cpu = POWERPC_CPU(thread_cpu);              \
-        NEW_AUX_ENT(AT_DCACHEBSIZE, cpu->env.dcache_line_size); \
-        NEW_AUX_ENT(AT_ICACHEBSIZE, cpu->env.icache_line_size); \
-        NEW_AUX_ENT(AT_UCACHEBSIZE, 0);                 \
         /*                                              \
-         * Now handle glibc compatibility.              \
+         * Handle glibc compatibility: these magic entries must \
+         * be at the lowest addresses in the final auxv.        \
          */                                             \
         NEW_AUX_ENT(AT_IGNOREPPC, AT_IGNOREPPC);        \
         NEW_AUX_ENT(AT_IGNOREPPC, AT_IGNOREPPC);        \
+        NEW_AUX_ENT(AT_DCACHEBSIZE, cpu->env.dcache_line_size); \
+        NEW_AUX_ENT(AT_ICACHEBSIZE, cpu->env.icache_line_size); \
+        NEW_AUX_ENT(AT_UCACHEBSIZE, 0);                 \
     } while (0)
 
 static inline void init_thread(struct target_pt_regs *_regs, struct image_info *infop)
@@ -1760,6 +1761,13 @@ static abi_ulong create_elf_tables(abi_ulong p, int argc, int envc,
     } while(0)
 
     /* There must be exactly DLINFO_ITEMS entries here.  */
+#ifdef ARCH_DLINFO
+    /*
+     * ARCH_DLINFO must come first so platform specific code can enforce
+     * special alignment requirements on the AUXV if necessary (eg. PPC).
+     */
+    ARCH_DLINFO;
+#endif
     NEW_AUX_ENT(AT_PHDR, (abi_ulong)(info->load_addr + exec->e_phoff));
     NEW_AUX_ENT(AT_PHENT, (abi_ulong)(sizeof (struct elf_phdr)));
     NEW_AUX_ENT(AT_PHNUM, (abi_ulong)(exec->e_phnum));
@@ -1782,13 +1790,6 @@ static abi_ulong create_elf_tables(abi_ulong p, int argc, int envc,
     if (u_platform) {
         NEW_AUX_ENT(AT_PLATFORM, u_platform);
     }
-#ifdef ARCH_DLINFO
-    /*
-     * ARCH_DLINFO must come last so platform specific code can enforce
-     * special alignment requirements on the AUXV if necessary (eg. PPC).
-     */
-    ARCH_DLINFO;
-#endif
     NEW_AUX_ENT (AT_NULL, 0);
 #undef NEW_AUX_ENT
 
-- 
2.7.4
