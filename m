Received: from eggs.gnu.org ([2001:4830:134:3::10]:40621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dEMbZ-0000mD-Iw
	for qemu-devel@nongnu.org; Fri, 26 May 2017 17:17:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dEMbY-0008O1-J1
	for qemu-devel@nongnu.org; Fri, 26 May 2017 17:17:05 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:34671)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dEMbY-0008Nx-EX
	for qemu-devel@nongnu.org; Fri, 26 May 2017 17:17:04 -0400
Received: by mail-qt0-x241.google.com with SMTP id l39so2852863qtb.1
	for <qemu-devel@nongnu.org>; Fri, 26 May 2017 14:17:04 -0700 (PDT)
Received: from bigtime.twiddle.net.com
	([2602:47:d954:1500:5e51:4fff:fe40:9c64])
	by smtp.gmail.com with ESMTPSA id
	u19sm1262380qtc.64.2017.05.26.14.17.02 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 26 May 2017 14:17:03 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Fri, 26 May 2017 14:16:28 -0700
Message-Id: <20170526211638.32301-17-rth@twiddle.net>
In-Reply-To: <20170526211638.32301-1-rth@twiddle.net>
References: <20170526211638.32301-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH v7 16/26] tcg/arm: Clarify tcg_out_bx for arm4
 host
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

In theory this would re-enable usage of QEMU on an armv4 host.
Whether this is worthwhile is debatable -- we've been unconditionally
issuing the armv5t BX instruction in the prologue since 2011 without
complaint.  Possibly we should simply require an armv6 host.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 tcg/arm/tcg-target.inc.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/tcg/arm/tcg-target.inc.c b/tcg/arm/tcg-target.inc.c
index e75a6d4..590c57d 100644
--- a/tcg/arm/tcg-target.inc.c
+++ b/tcg/arm/tcg-target.inc.c
@@ -329,11 +329,6 @@ static const uint8_t tcg_cond_to_arm_cond[] = {
     [TCG_COND_GTU] = COND_HI,
 };
 
-static inline void tcg_out_bx(TCGContext *s, int cond, int rn)
-{
-    tcg_out32(s, (cond << 28) | 0x012fff10 | rn);
-}
-
 static inline void tcg_out_b(TCGContext *s, int cond, int32_t offset)
 {
     tcg_out32(s, (cond << 28) | 0x0a000000 |
@@ -402,6 +397,18 @@ static inline void tcg_out_mov_reg(TCGContext *s, int cond, int rd, int rm)
     }
 }
 
+static inline void tcg_out_bx(TCGContext *s, int cond, TCGReg rn)
+{
+    /* Unless the C portion of QEMU is compiled as thumb, we don't
+       actually need true BX semantics; merely a branch to an address
+       held in a register.  */
+    if (use_armv5t_instructions) {
+        tcg_out32(s, (cond << 28) | 0x012fff10 | rn);
+    } else {
+        tcg_out_mov_reg(s, cond, TCG_REG_PC, rn);
+    }
+}
+
 static inline void tcg_out_dat_imm(TCGContext *s,
                 int cond, int opc, int rd, int rn, int im)
 {
@@ -977,7 +984,7 @@ static inline void tcg_out_st8(TCGContext *s, int cond,
  * with the code buffer limited to 16MB we wouldn't need the long case.
  * But we also use it for the tail-call to the qemu_ld/st helpers, which does.
  */
-static inline void tcg_out_goto(TCGContext *s, int cond, tcg_insn_unit *addr)
+static void tcg_out_goto(TCGContext *s, int cond, tcg_insn_unit *addr)
 {
     intptr_t addri = (intptr_t)addr;
     ptrdiff_t disp = tcg_pcrel_diff(s, addr);
@@ -987,15 +994,9 @@ static inline void tcg_out_goto(TCGContext *s, int cond, tcg_insn_unit *addr)
         return;
     }
 
+    assert(use_armv5t_instructions || (addri & 1) == 0);
     tcg_out_movi32(s, cond, TCG_REG_TMP, addri);
-    if (use_armv5t_instructions) {
-        tcg_out_bx(s, cond, TCG_REG_TMP);
-    } else {
-        if (addri & 1) {
-            tcg_abort();
-        }
-        tcg_out_mov_reg(s, cond, TCG_REG_PC, TCG_REG_TMP);
-    }
+    tcg_out_bx(s, cond, TCG_REG_TMP);
 }
 
 /* The call case is mostly used for helpers - so it's not unreasonable
-- 
2.9.4
