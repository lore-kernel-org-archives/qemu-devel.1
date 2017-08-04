Received: from eggs.gnu.org ([2001:4830:134:3::10]:59956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ddVPm-00047n-Pv
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 01:44:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ddVPj-0003h8-IC
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 01:44:50 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:37865)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1ddVPj-0003fq-DM
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 01:44:47 -0400
Received: by mail-pf0-x243.google.com with SMTP id p13so862179pfd.4
	for <qemu-devel@nongnu.org>; Thu, 03 Aug 2017 22:44:47 -0700 (PDT)
Received: from bigtime.twiddle.net (97-126-108-236.tukw.qwest.net.
	[97.126.108.236]) by smtp.gmail.com with ESMTPSA id
	o14sm1061063pfi.158.2017.08.03.22.44.45 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 03 Aug 2017 22:44:45 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Thu,  3 Aug 2017 22:44:21 -0700
Message-Id: <20170804054426.10590-19-rth@twiddle.net>
In-Reply-To: <20170804054426.10590-1-rth@twiddle.net>
References: <20170804054426.10590-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH for-2.11 18/23] tcg/arm: Extract INSN_NOP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

We'll want this for tcg_out_nop_fill.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 tcg/arm/tcg-target.inc.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/tcg/arm/tcg-target.inc.c b/tcg/arm/tcg-target.inc.c
index f40e87066f..78603a19db 100644
--- a/tcg/arm/tcg-target.inc.c
+++ b/tcg/arm/tcg-target.inc.c
@@ -160,8 +160,18 @@ typedef enum {
 
     INSN_DMB_ISH   = 0x5bf07ff5,
     INSN_DMB_MCR   = 0xba0f07ee,
+
+    /* Architected nop introduced in v6k.  */
+    /* ??? This is an MSR (imm) 0,0,0 insn.  Anyone know if this
+       also Just So Happened to do nothing on pre-v6k so that we
+       don't need to conditionalize it?  */
+    INSN_NOP_v6k   = 0xe320f000,
+    /* Otherwise the assembler uses mov r0,r0 */
+    INSN_NOP_v4    = (COND_AL << 28) | ARITH_MOV,
 } ARMInsn;
 
+#define INSN_NOP   (use_armv7_instructions ? INSN_NOP_v6k : INSN_NOP_v4)
+
 static const uint8_t tcg_cond_to_arm_cond[] = {
     [TCG_COND_EQ] = COND_EQ,
     [TCG_COND_NE] = COND_NE,
@@ -375,16 +385,7 @@ static inline void tcg_out_dat_reg(TCGContext *s,
 
 static inline void tcg_out_nop(TCGContext *s)
 {
-    if (use_armv7_instructions) {
-        /* Architected nop introduced in v6k.  */
-        /* ??? This is an MSR (imm) 0,0,0 insn.  Anyone know if this
-           also Just So Happened to do nothing on pre-v6k so that we
-           don't need to conditionalize it?  */
-        tcg_out32(s, 0xe320f000);
-    } else {
-        /* Prior to that the assembler uses mov r0, r0.  */
-        tcg_out_dat_reg(s, COND_AL, ARITH_MOV, 0, 0, 0, SHIFT_IMM_LSL(0));
-    }
+    tcg_out32(s, INSN_NOP);
 }
 
 static inline void tcg_out_mov_reg(TCGContext *s, int cond, int rd, int rm)
-- 
2.13.3
