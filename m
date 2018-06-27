Received: from eggs.gnu.org ([2001:4830:134:3::10]:48687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fYFCI-0007Kz-Q9
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 14:29:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fYFCG-0000nf-Hy
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 14:29:42 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:47457 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fYFCG-0000km-B2
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 14:29:40 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Wed, 27 Jun 2018 20:29:05 +0200
Message-Id: <1530124149-3900-6-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1530124149-3900-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1530124149-3900-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL v2 5/9] target/mips: Raise a RI when given fs is
 n/a from CTC1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

From: Yongbok Kim <yongbok.kim@mips.com>

Fix to raise a Reserved Instruction exception when given fs is not
available from CTC1.

Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
Reviewed-by: Aleksandar Markovic <aleksandar.markovic@mips.com>
Signed-off-by: Aleksandar Markovic <aleksandar.markovic@mips.com>
---
 target/mips/op_helper.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
index 9025f42..41d3634 100644
--- a/target/mips/op_helper.c
+++ b/target/mips/op_helper.c
@@ -2627,6 +2627,9 @@ void helper_ctc1(CPUMIPSState *env, target_ulong arg1, uint32_t fs, uint32_t rt)
                (env->active_fpu.fcr31 & ~(env->active_fpu.fcr31_rw_bitmask));
         break;
     default:
+        if (env->insn_flags & ISA_MIPS32R6) {
+            do_raise_exception(env, EXCP_RI, GETPC());
+        }
         return;
     }
     restore_fp_status(env);
-- 
2.7.4
