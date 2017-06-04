Received: from eggs.gnu.org ([2001:4830:134:3::10]:50308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dHZRW-0007i6-QB
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 13:35:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dHZRV-0003Lt-Nh
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 13:35:58 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:33380)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dHZRV-0003Kv-Cc
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 13:35:57 -0400
Received: by mail-pf0-x244.google.com with SMTP id f27so18146308pfe.0
	for <qemu-devel@nongnu.org>; Sun, 04 Jun 2017 10:35:57 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Sun,  4 Jun 2017 10:34:32 -0700
Message-Id: <20170604173509.29684-33-rth@twiddle.net>
In-Reply-To: <20170604173509.29684-1-rth@twiddle.net>
References: <20170604173509.29684-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 32/69] target/s390x: Fix EXECUTE with R1==0
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

The PoO specifies that when R1==0, no ORing into the insn
loaded from storage takes place.  Load a zero for this case.

Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/s390x/insn-data.def |  4 ++--
 target/s390x/translate.c   | 14 +++++++++++++-
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index cac0f51..3c3541c 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -327,9 +327,9 @@
     C(0xeb57, XIY,     SIY,   LD,  m1_8u, i2_8u, new, m1_8, xor, nz64)
 
 /* EXECUTE */
-    C(0x4400, EX,      RX_a,  Z,   r1_o, a2, 0, 0, ex, 0)
+    C(0x4400, EX,      RX_a,  Z,   0, a2, 0, 0, ex, 0)
 /* EXECUTE RELATIVE LONG */
-    C(0xc600, EXRL,    RIL_b, EE,  r1_o, ri2, 0, 0, ex, 0)
+    C(0xc600, EXRL,    RIL_b, EE,  0, ri2, 0, 0, ex, 0)
 
 /* EXTRACT ACCESS */
     C(0xb24f, EAR,     RRE,   Z,   0, 0, new, r1_32, ear, 0)
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 921a842..b7b4843 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -2159,15 +2159,27 @@ static ExitStatus op_ex(DisasContext *s, DisasOps *o)
        MVC inside of memcpy, which needs a helper call anyway.  So
        perhaps this doesn't bear thinking about any further.  */
 
+    int r1 = get_field(s->fields, r1);
     TCGv_i32 ilen;
+    TCGv_i64 v1;
 
     update_psw_addr(s);
     gen_op_calc_cc(s);
 
+    if (r1 == 0) {
+        v1 = tcg_const_i64(0);
+    } else {
+        v1 = regs[r1];
+    }
+
     ilen = tcg_const_i32(s->next_pc - s->pc);
-    gen_helper_ex(cpu_env, ilen, o->in1, o->in2);
+    gen_helper_ex(cpu_env, ilen, v1, o->in2);
     tcg_temp_free_i32(ilen);
 
+    if (r1 == 0) {
+        tcg_temp_free_i64(v1);
+    }
+
     return NO_EXIT;
 }
 
-- 
2.9.4
