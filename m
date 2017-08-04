Received: from eggs.gnu.org ([2001:4830:134:3::10]:59534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ddVPZ-0003rb-Bt
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 01:44:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ddVPW-0003Az-UC
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 01:44:37 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:37013)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1ddVPW-00038r-MN
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 01:44:34 -0400
Received: by mail-pg0-x243.google.com with SMTP id 83so821932pgb.4
	for <qemu-devel@nongnu.org>; Thu, 03 Aug 2017 22:44:34 -0700 (PDT)
Received: from bigtime.twiddle.net (97-126-108-236.tukw.qwest.net.
	[97.126.108.236]) by smtp.gmail.com with ESMTPSA id
	o14sm1061063pfi.158.2017.08.03.22.44.32 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 03 Aug 2017 22:44:32 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Thu,  3 Aug 2017 22:44:09 -0700
Message-Id: <20170804054426.10590-7-rth@twiddle.net>
In-Reply-To: <20170804054426.10590-1-rth@twiddle.net>
References: <20170804054426.10590-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH for-2.11 06/23] tcg/s390: Fix sign of
 patch_reloc addend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

We were passing in -2 instead of +2, but then ignoring
the actual contents of addend in the calculation.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 tcg/s390/tcg-target.inc.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/tcg/s390/tcg-target.inc.c b/tcg/s390/tcg-target.inc.c
index e007586315..59c0da0922 100644
--- a/tcg/s390/tcg-target.inc.c
+++ b/tcg/s390/tcg-target.inc.c
@@ -360,21 +360,22 @@ uint64_t s390_facilities;
 static void patch_reloc(tcg_insn_unit *code_ptr, int type,
                         intptr_t value, intptr_t addend)
 {
-    intptr_t pcrel2 = (tcg_insn_unit *)value - (code_ptr - 1);
-    tcg_debug_assert(addend == -2);
+    intptr_t pcrel2;
+
+    value += addend;
+    pcrel2 = (tcg_insn_unit *)value - code_ptr;
 
     switch (type) {
     case R_390_PC16DBL:
-        tcg_debug_assert(pcrel2 == (int16_t)pcrel2);
+        assert(pcrel2 == (int16_t)pcrel2);
         tcg_patch16(code_ptr, pcrel2);
         break;
     case R_390_PC32DBL:
-        tcg_debug_assert(pcrel2 == (int32_t)pcrel2);
+        assert(pcrel2 == (int32_t)pcrel2);
         tcg_patch32(code_ptr, pcrel2);
         break;
     default:
-        tcg_abort();
-        break;
+        g_assert_not_reached();
     }
 }
 
@@ -1270,11 +1271,11 @@ static void tgen_branch(TCGContext *s, int cc, TCGLabel *l)
         tgen_gotoi(s, cc, l->u.value_ptr);
     } else if (USE_LONG_BRANCHES) {
         tcg_out16(s, RIL_BRCL | (cc << 4));
-        tcg_out_reloc(s, s->code_ptr, R_390_PC32DBL, l, -2);
+        tcg_out_reloc(s, s->code_ptr, R_390_PC32DBL, l, 2);
         s->code_ptr += 2;
     } else {
         tcg_out16(s, RI_BRC | (cc << 4));
-        tcg_out_reloc(s, s->code_ptr, R_390_PC16DBL, l, -2);
+        tcg_out_reloc(s, s->code_ptr, R_390_PC16DBL, l, 2);
         s->code_ptr += 1;
     }
 }
@@ -1289,7 +1290,7 @@ static void tgen_compare_branch(TCGContext *s, S390Opcode opc, int cc,
     } else {
         /* We need to keep the offset unchanged for retranslation.  */
         off = s->code_ptr[1];
-        tcg_out_reloc(s, s->code_ptr + 1, R_390_PC16DBL, l, -2);
+        tcg_out_reloc(s, s->code_ptr + 1, R_390_PC16DBL, l, 2);
     }
 
     tcg_out16(s, (opc & 0xff00) | (r1 << 4) | r2);
@@ -1307,7 +1308,7 @@ static void tgen_compare_imm_branch(TCGContext *s, S390Opcode opc, int cc,
     } else {
         /* We need to keep the offset unchanged for retranslation.  */
         off = s->code_ptr[1];
-        tcg_out_reloc(s, s->code_ptr + 1, R_390_PC16DBL, l, -2);
+        tcg_out_reloc(s, s->code_ptr + 1, R_390_PC16DBL, l, 2);
     }
 
     tcg_out16(s, (opc & 0xff00) | (r1 << 4) | cc);
@@ -1571,7 +1572,7 @@ static void tcg_out_qemu_ld_slow_path(TCGContext *s, TCGLabelQemuLdst *lb)
     TCGMemOpIdx oi = lb->oi;
     TCGMemOp opc = get_memop(oi);
 
-    patch_reloc(lb->label_ptr[0], R_390_PC16DBL, (intptr_t)s->code_ptr, -2);
+    patch_reloc(lb->label_ptr[0], R_390_PC16DBL, (intptr_t)s->code_ptr, 2);
 
     tcg_out_mov(s, TCG_TYPE_PTR, TCG_REG_R2, TCG_AREG0);
     if (TARGET_LONG_BITS == 64) {
@@ -1592,7 +1593,7 @@ static void tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *lb)
     TCGMemOpIdx oi = lb->oi;
     TCGMemOp opc = get_memop(oi);
 
-    patch_reloc(lb->label_ptr[0], R_390_PC16DBL, (intptr_t)s->code_ptr, -2);
+    patch_reloc(lb->label_ptr[0], R_390_PC16DBL, (intptr_t)s->code_ptr, 2);
 
     tcg_out_mov(s, TCG_TYPE_PTR, TCG_REG_R2, TCG_AREG0);
     if (TARGET_LONG_BITS == 64) {
-- 
2.13.3
