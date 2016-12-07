Received: from eggs.gnu.org ([2001:4830:134:3::10]:49012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cEgeJ-00036H-Ho
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 13:09:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cEgeG-0005Sr-C7
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 13:08:59 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:35480)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cEgeG-0005MP-6j
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 13:08:56 -0500
Received: by mail-qt0-f196.google.com with SMTP id m48so45630294qta.2
	for <qemu-devel@nongnu.org>; Wed, 07 Dec 2016 10:08:34 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Wed,  7 Dec 2016 10:07:26 -0800
Message-Id: <20161207180727.6286-2-rth@twiddle.net>
In-Reply-To: <20161207180727.6286-1-rth@twiddle.net>
References: <20161207180727.6286-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 1/2] tcg/aarch64: Fix addsub2 for 0+C
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, peter.maydell@linaro.org

When al == xzr, we cannot use addi/subi because that encodes xsp.
Force a zero into the temp register for that (rare) case.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 tcg/aarch64/tcg-target.inc.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
index 1939d35..6c68681 100644
--- a/tcg/aarch64/tcg-target.inc.c
+++ b/tcg/aarch64/tcg-target.inc.c
@@ -965,6 +965,15 @@ static inline void tcg_out_addsub2(TCGContext *s, int ext, TCGReg rl,
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
