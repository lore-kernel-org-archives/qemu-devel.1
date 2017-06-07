Received: from eggs.gnu.org ([2001:4830:134:3::10]:34370)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dIOto-0003Un-LC
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 20:32:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dIOtn-0002FY-Im
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 20:32:36 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:34083)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dIOtn-0002FQ-F0
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 20:32:35 -0400
Received: by mail-qt0-x243.google.com with SMTP id o21so22863055qtb.1
	for <qemu-devel@nongnu.org>; Tue, 06 Jun 2017 17:32:35 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue,  6 Jun 2017 17:31:03 -0700
Message-Id: <20170607003119.14778-55-rth@twiddle.net>
In-Reply-To: <20170607003119.14778-1-rth@twiddle.net>
References: <20170607003119.14778-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL v2 54/70] target/s390x: fix COMPARE LOGICAL LONG
 EXTENDED
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, aurelien@aurel32.net

From: Aurelien Jarno <aurelien@aurel32.net>

There are multiple issues with the COMPARE LOGICAL LONG EXTENDED
instruction:
- The test between the two operands is inverted, leading to an inversion
  of the cc values 1 and 2.
- The address and length of an operand continue to be decreased after
  reaching the end of this operand. These values are then wrong write
  back to the registers.
- We should limit the amount of bytes to process, so that interrupts can
  be served correctly.

At the same time rename dest into src1 and src into src3 to match the
operand names and make the code less confusing.

Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
Message-Id: <20170531220129.27724-18-aurelien@aurel32.net>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/s390x/mem_helper.c | 54 ++++++++++++++++++++++++++++++++---------------
 target/s390x/translate.c  | 20 +++++++++++++-----
 2 files changed, 52 insertions(+), 22 deletions(-)

diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index 83c32c4..e30020c 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -666,35 +666,55 @@ uint32_t HELPER(clcle)(CPUS390XState *env, uint32_t r1, uint64_t a2,
                        uint32_t r3)
 {
     uintptr_t ra = GETPC();
-    uint64_t destlen = get_length(env, r1 + 1);
-    uint64_t dest = get_address(env, r1);
-    uint64_t srclen = get_length(env, r3 + 1);
-    uint64_t src = get_address(env, r3);
+    uint64_t src1len = get_length(env, r1 + 1);
+    uint64_t src1 = get_address(env, r1);
+    uint64_t src3len = get_length(env, r3 + 1);
+    uint64_t src3 = get_address(env, r3);
     uint8_t pad = a2 & 0xff;
+    uint64_t len = MAX(src1len, src3len);
     uint32_t cc = 0;
 
-    if (!(destlen || srclen)) {
+    if (!len) {
         return cc;
     }
 
-    if (srclen > destlen) {
-        srclen = destlen;
+    /* Lest we fail to service interrupts in a timely manner, limit the
+       amount of work we're willing to do.  For now, let's cap at 8k.  */
+    if (len > 0x2000) {
+        len = 0x2000;
+        cc = 3;
     }
 
-    for (; destlen || srclen; src++, dest++, destlen--, srclen--) {
-        uint8_t v1 = srclen ? cpu_ldub_data_ra(env, src, ra) : pad;
-        uint8_t v2 = destlen ? cpu_ldub_data_ra(env, dest, ra) : pad;
-        if (v1 != v2) {
-            cc = (v1 < v2) ? 1 : 2;
+    for (; len; len--) {
+        uint8_t v1 = pad;
+        uint8_t v3 = pad;
+
+        if (src1len) {
+            v1 = cpu_ldub_data_ra(env, src1, ra);
+        }
+        if (src3len) {
+            v3 = cpu_ldub_data_ra(env, src3, ra);
+        }
+
+        if (v1 != v3) {
+            cc = (v1 < v3) ? 1 : 2;
             break;
         }
+
+        if (src1len) {
+            src1++;
+            src1len--;
+        }
+        if (src3len) {
+            src3++;
+            src3len--;
+        }
     }
 
-    set_length(env, r1 + 1, destlen);
-    /* can't use srclen here, we trunc'ed it */
-    set_length(env, r3 + 1, env->regs[r3 + 1] - src - env->regs[r3]);
-    set_address(env, r1, dest);
-    set_address(env, r3, src);
+    set_length(env, r1 + 1, src1len);
+    set_length(env, r3 + 1, src3len);
+    set_address(env, r1, src1);
+    set_address(env, r3, src3);
 
     return cc;
 }
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index a21de09..ecd0a91 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -1922,11 +1922,21 @@ static ExitStatus op_clc(DisasContext *s, DisasOps *o)
 
 static ExitStatus op_clcle(DisasContext *s, DisasOps *o)
 {
-    TCGv_i32 r1 = tcg_const_i32(get_field(s->fields, r1));
-    TCGv_i32 r3 = tcg_const_i32(get_field(s->fields, r3));
-    gen_helper_clcle(cc_op, cpu_env, r1, o->in2, r3);
-    tcg_temp_free_i32(r1);
-    tcg_temp_free_i32(r3);
+    int r1 = get_field(s->fields, r1);
+    int r3 = get_field(s->fields, r3);
+    TCGv_i32 t1, t3;
+
+    /* r1 and r3 must be even.  */
+    if (r1 & 1 || r3 & 1) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return EXIT_NORETURN;
+    }
+
+    t1 = tcg_const_i32(r1);
+    t3 = tcg_const_i32(r3);
+    gen_helper_clcle(cc_op, cpu_env, t1, o->in2, t3);
+    tcg_temp_free_i32(t1);
+    tcg_temp_free_i32(t3);
     set_cc_static(s);
     return NO_EXIT;
 }
-- 
2.9.4
