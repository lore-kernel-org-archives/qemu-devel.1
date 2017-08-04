Received: from eggs.gnu.org ([2001:4830:134:3::10]:59950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ddVPm-00047g-O0
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 01:44:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ddVPl-0003lj-Ii
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 01:44:50 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:34756)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1ddVPl-0003k2-DJ
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 01:44:49 -0400
Received: by mail-pf0-x242.google.com with SMTP id t86so870351pfe.1
	for <qemu-devel@nongnu.org>; Thu, 03 Aug 2017 22:44:49 -0700 (PDT)
Received: from bigtime.twiddle.net (97-126-108-236.tukw.qwest.net.
	[97.126.108.236]) by smtp.gmail.com with ESMTPSA id
	o14sm1061063pfi.158.2017.08.03.22.44.47 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 03 Aug 2017 22:44:47 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Thu,  3 Aug 2017 22:44:23 -0700
Message-Id: <20170804054426.10590-21-rth@twiddle.net>
In-Reply-To: <20170804054426.10590-1-rth@twiddle.net>
References: <20170804054426.10590-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH for-2.11 20/23] tcg/arm: Use constant pool for
 call
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 tcg/arm/tcg-target.inc.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/tcg/arm/tcg-target.inc.c b/tcg/arm/tcg-target.inc.c
index 2736022d5a..db46aea38c 100644
--- a/tcg/arm/tcg-target.inc.c
+++ b/tcg/arm/tcg-target.inc.c
@@ -1054,10 +1054,7 @@ static void tcg_out_goto(TCGContext *s, int cond, tcg_insn_unit *addr)
         tcg_out_b(s, cond, disp);
         return;
     }
-
-    assert(use_armv5t_instructions || (addri & 1) == 0);
-    tcg_out_movi32(s, cond, TCG_REG_TMP, addri);
-    tcg_out_bx(s, cond, TCG_REG_TMP);
+    tcg_out_movi_pool(s, cond, TCG_REG_PC, addri);
 }
 
 /* The call case is mostly used for helpers - so it's not unreasonable
@@ -1081,9 +1078,9 @@ static void tcg_out_call(TCGContext *s, tcg_insn_unit *addr)
         tcg_out_movi32(s, COND_AL, TCG_REG_TMP, addri);
         tcg_out_blx(s, COND_AL, TCG_REG_TMP);
     } else {
+        /* ??? Know that movi_pool emits exactly 2 insns.  */
         tcg_out_dat_imm(s, COND_AL, ARITH_ADD, TCG_REG_R14, TCG_REG_PC, 4);
-        tcg_out_ld32_12(s, COND_AL, TCG_REG_PC, TCG_REG_PC, -4);
-        tcg_out32(s, addri);
+        tcg_out_movi_pool(s, COND_AL, TCG_REG_PC, addri);
     }
 }
 
-- 
2.13.3
