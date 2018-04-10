Received: from eggs.gnu.org ([2001:4830:134:3::10]:36365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1f5vis-0007vA-3h
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 12:02:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1f5vin-0002ME-7s
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 12:02:18 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:55049)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1f5vim-0002L3-Uw
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 12:02:13 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue, 10 Apr 2018 18:01:42 +0200
Message-Id: <20180410160142.21096-4-laurent@vivier.eu>
In-Reply-To: <20180410160142.21096-1-laurent@vivier.eu>
References: <20180410160142.21096-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL v2 3/3] linux-user: implement HWCAP bits on MIPS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>, James Cowgill <james.cowgill@mips.com>

From: James Cowgill <james.cowgill@mips.com>

Add support for the two currently defined HWCAP bits on MIPS - R6 and
MSA.

Buglink: https://bugs.launchpad.net/qemu/+bug/1754372
Signed-off-by: James Cowgill <james.cowgill@mips.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20180315151348.6451-1-james.cowgill@mips.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/elfload.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 23e34957f9..c77ed1bb01 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -882,6 +882,30 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUMIPSState *e
 #define USE_ELF_CORE_DUMP
 #define ELF_EXEC_PAGESIZE        4096
 
+/* See arch/mips/include/uapi/asm/hwcap.h.  */
+enum {
+    HWCAP_MIPS_R6           = (1 << 0),
+    HWCAP_MIPS_MSA          = (1 << 1),
+};
+
+#define ELF_HWCAP get_elf_hwcap()
+
+static uint32_t get_elf_hwcap(void)
+{
+    MIPSCPU *cpu = MIPS_CPU(thread_cpu);
+    uint32_t hwcaps = 0;
+
+#define GET_FEATURE(flag, hwcap) \
+    do { if (cpu->env.insn_flags & (flag)) { hwcaps |= hwcap; } } while (0)
+
+    GET_FEATURE(ISA_MIPS32R6 | ISA_MIPS64R6, HWCAP_MIPS_R6);
+    GET_FEATURE(ASE_MSA, HWCAP_MIPS_MSA);
+
+#undef GET_FEATURE
+
+    return hwcaps;
+}
+
 #endif /* TARGET_MIPS */
 
 #ifdef TARGET_MICROBLAZE
-- 
2.14.3
