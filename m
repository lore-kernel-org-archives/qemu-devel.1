Received: from eggs.gnu.org ([2001:4830:134:3::10]:50323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ctXh4-0000Wm-UR
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 06:52:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ctXh3-00069J-UY
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 06:52:43 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48981)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ctXh3-00062x-Nl
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 06:52:41 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 Mar 2017 11:52:30 +0100
Message-Id: <1490871151-29029-2-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1490871151-29029-1-git-send-email-peter.maydell@linaro.org>
References: <1490871151-29029-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH v2 for-2.9 1/2] tcg/sparc: Zero extend data
 argument to store helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

The C store helper functions take the data argument as a uint8_t,
uint16_t, etc depending on the store size. The SPARC calling
convention requires that data types smaller than the register
size must be extended by the caller. We weren't doing this,
which meant that if QEMU was compiled with optimizations enabled
we could end up storing incorrect values to guest memory.
(In particular the i386 guest BIOS would crash on startup.)

Add code to the trampolines that call the store helpers to
do the zero extension as required.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
v1->v2: fix incorrect argument order to emit_extend() for
sparc32 codepath; switch on op & MO_SIZE rather than just op.
---
 tcg/sparc/tcg-target.inc.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/tcg/sparc/tcg-target.inc.c b/tcg/sparc/tcg-target.inc.c
index d1f4c0d..ab34039 100644
--- a/tcg/sparc/tcg-target.inc.c
+++ b/tcg/sparc/tcg-target.inc.c
@@ -843,6 +843,29 @@ static void tcg_out_mb(TCGContext *s, TCGArg a0)
 static tcg_insn_unit *qemu_ld_trampoline[16];
 static tcg_insn_unit *qemu_st_trampoline[16];
 
+static void emit_extend(TCGContext *s, TCGReg r, int op)
+{
+    /* Emit zero extend of 8, 16 or 32 bit data as
+     * required by the MO_* value op; do nothing for 64 bit.
+     */
+    switch (op & MO_SIZE) {
+    case MO_8:
+        tcg_out_arithi(s, r, r, 0xff, ARITH_AND);
+        break;
+    case MO_16:
+        tcg_out_arithi(s, r, r, 16, SHIFT_SLL);
+        tcg_out_arithi(s, r, r, 16, SHIFT_SRL);
+        break;
+    case MO_32:
+        if (SPARC64) {
+            tcg_out_arith(s, r, r, 0, SHIFT_SRL);
+        }
+        break;
+    case MO_64:
+        break;
+    }
+}
+
 static void build_trampolines(TCGContext *s)
 {
     static void * const qemu_ld_helpers[16] = {
@@ -910,6 +933,7 @@ static void build_trampolines(TCGContext *s)
         qemu_st_trampoline[i] = s->code_ptr;
 
         if (SPARC64) {
+            emit_extend(s, TCG_REG_O2, i);
             ra = TCG_REG_O4;
         } else {
             ra = TCG_REG_O1;
@@ -925,6 +949,7 @@ static void build_trampolines(TCGContext *s)
                 tcg_out_arithi(s, ra, ra + 1, 32, SHIFT_SRLX);
                 ra += 2;
             } else {
+                emit_extend(s, ra, i);
                 ra += 1;
             }
             /* Skip the oi argument.  */
-- 
2.7.4
