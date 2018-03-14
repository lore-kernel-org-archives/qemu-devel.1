Received: from eggs.gnu.org ([2001:4830:134:3::10]:33986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <James.Cowgill@mips.com>) id 1ew8Li-0000AT-9i
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 11:29:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <James.Cowgill@mips.com>) id 1ew8Le-0003KF-BL
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 11:29:54 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.150.224]:53283)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <James.Cowgill@mips.com>)
	id 1ew8Le-0003Ho-5X
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 11:29:50 -0400
From: James Cowgill <james.cowgill@mips.com>
Date: Wed, 14 Mar 2018 14:20:18 +0000
Message-ID: <20180314142018.13612-1-james.cowgill@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] linux-user: implement HWCAP bits on MIPS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>
Cc: James Cowgill <james.cowgill@mips.com>

Add support for the two currently defined HWCAP bits on MIPS - R6 and
MSA.

Buglink: https://bugs.launchpad.net/qemu/+bug/1754372
Signed-off-by: James Cowgill <james.cowgill@mips.com>
---
 linux-user/elfload.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 5fc130cc20..747b0ed10b 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -950,6 +950,30 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUMIPSState *e
 #define USE_ELF_CORE_DUMP
 #define ELF_EXEC_PAGESIZE        4096
 
+/* See arch/mips/include/uapi/hwcap.h.  */
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
2.16.2
