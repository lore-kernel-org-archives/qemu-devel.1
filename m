Received: from eggs.gnu.org ([2001:4830:134:3::10]:42100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cS86w-0001jr-SH
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 15:06:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cS86v-0005D6-MB
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 15:06:06 -0500
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Fri, 13 Jan 2017 12:05:55 -0800
Message-Id: <20170113200556.2574-4-rth@twiddle.net>
In-Reply-To: <20170113200556.2574-1-rth@twiddle.net>
References: <20170113200556.2574-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 3/4] tcg/aarch64: Fix addsub2 for 0+C
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-stable@nongnu.org

When al == xzr, we cannot use addi/subi because that encodes xsp.
Force a zero into the temp register for that (rare) case.

Cc: qemu-stable@nongnu.org
Signed-off-by: Richard Henderson <rth@twiddle.net>
Message-Id: <20161207180727.6286-2-rth@twiddle.net>
---
 tcg/aarch64/tcg-target.inc.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
index 585b0d6..deb5967 100644
--- a/tcg/aarch64/tcg-target.inc.c
+++ b/tcg/aarch64/tcg-target.inc.c
@@ -964,6 +964,15 @@ static inline void tcg_out_addsub2(TCGContext *s, int ext, TCGReg rl,
             insn = I3401_SUBSI;
             bl = -bl;
         }
+        if (unlikely(al == TCG_REG_XZR)) {
+            /* ??? We want to allow al to be zero for the benefit of
+               negation via subtraction.  However, that leaves open the
+               possibility of adding 0+const in the low part, and the
+               immediate add instructions encode XSP not XZR.  Don't try
+               anything more elaborate here than loading another zero.  */
+            al = TCG_REG_TMP;
+            tcg_out_movi(s, ext, al, 0);
+        }
         tcg_out_insn_3401(s, insn, ext, rl, al, bl);
     } else {
         tcg_out_insn_3502(s, sub ? I3502_SUBS : I3502_ADDS, ext, rl, al, bl);
-- 
2.9.3
