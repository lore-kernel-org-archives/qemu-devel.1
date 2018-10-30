Received: from eggs.gnu.org ([2001:4830:134:3::10]:37876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gHWCH-0002cH-Uj
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 11:44:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gHWCF-0001yN-SD
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 11:44:49 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:55997 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gHWCF-0001m6-BT
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 11:44:47 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Tue, 30 Oct 2018 16:44:09 +0100
Message-Id: <1540914249-3392-6-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1540914249-3392-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1540914249-3392-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v3 5/5] target/mips: Enable only tested modes
 for R5900
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Enable MIPS 032 user mode for R5900.

Expose to end-user only features that make sense and are appropriately
tested. In this case, enable only MIPS 032 user mode for R5900.

About defined(CONFIG_USER_ONLY), it is just because a reasonable
testing was not provided for system mode. Some reasonable
("acceptance") testing should be done, and made available
to others. A system image, kernel, and command line + plus
some relatively mild testing of system mode should suffice.

About !defined(TARGET_MIPS64), this is because O32 is the only
supported user-mode ABI for this CPU.

Reviewed-by: Stefan Markovic <smarkovic@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/translate_init.inc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/mips/translate_init.inc.c b/target/mips/translate_init.inc.c
index cab2003..d84c58e 100644
--- a/target/mips/translate_init.inc.c
+++ b/target/mips/translate_init.inc.c
@@ -410,6 +410,8 @@ const mips_def_t mips_defs[] =
         .insn_flags = CPU_MIPS32R5 | ASE_MSA,
         .mmu_type = MMU_TYPE_R4000,
     },
+#if defined(CONFIG_USER_ONLY)
+#if !defined(TARGET_MIPS64)
     {
         .name = "R5900",
         .CP0_PRid = 0x00002E00,
@@ -457,6 +459,8 @@ const mips_def_t mips_defs[] =
         .insn_flags = CPU_R5900 | ASE_MMI,
         .mmu_type = MMU_TYPE_R4000,
     },
+#endif
+#endif
     {
         /* A generic CPU supporting MIPS32 Release 6 ISA.
            FIXME: Support IEEE 754-2008 FP.
-- 
2.7.4
