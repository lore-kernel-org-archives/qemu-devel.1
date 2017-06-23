Received: from eggs.gnu.org ([2001:4830:134:3::10]:60240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dORMM-0001f0-J7
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:23:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dORML-0007vE-D0
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:23:02 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:34566)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dORML-0007v4-9X
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:23:01 -0400
Received: by mail-qk0-x241.google.com with SMTP id 91so968867qkq.1
	for <qemu-devel@nongnu.org>; Fri, 23 Jun 2017 09:23:01 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Fri, 23 Jun 2017 09:22:37 -0700
Message-Id: <20170623162241.8964-12-rth@twiddle.net>
In-Reply-To: <20170623162241.8964-1-rth@twiddle.net>
References: <20170623162241.8964-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 11/15] target/s390x: Finish implementing ETF2-ENH
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

Missed the proper alignment in TRTO/TRTT, and ignoring the M3
field for all TRXX insns without ETF2-ENH.

Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/s390x/mem_helper.c | 11 ++++++++++-
 target/s390x/translate.c  |  5 +++--
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index 6125725..a0a805c 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -1265,13 +1265,22 @@ uint32_t HELPER(trXX)(CPUS390XState *env, uint32_t r1, uint32_t r2,
     uintptr_t ra = GETPC();
     int dsize = (sizes & 1) ? 1 : 2;
     int ssize = (sizes & 2) ? 1 : 2;
-    uint64_t tbl = get_address(env, 1) & ~7;
+    uint64_t tbl = get_address(env, 1);
     uint64_t dst = get_address(env, r1);
     uint64_t len = get_length(env, r1 + 1);
     uint64_t src = get_address(env, r2);
     uint32_t cc = 3;
     int i;
 
+    /* The lower address bits of TBL are ignored.  For TROO, TROT, it's
+       the low 3 bits (double-word aligned).  For TRTO, TRTT, it's either
+       the low 12 bits (4K, without ETF2-ENH) or 3 bits (with ETF2-ENH).  */
+    if (ssize == 2 && !s390_has_feat(S390_FEAT_ETF2_ENH)) {
+        tbl &= -4096;
+    } else {
+        tbl &= -8;
+    }
+
     check_alignment(env, len, ssize, ra);
 
     /* Lest we fail to service interrupts in a timely manner, */
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 72af76d..a3414c0 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -4356,8 +4356,9 @@ static ExitStatus op_trXX(DisasContext *s, DisasOps *o)
     TCGv_i32 tst = tcg_temp_new_i32();
     int m3 = get_field(s->fields, m3);
 
-    /* XXX: the C bit in M3 should be considered as 0 when the
-       ETF2-enhancement facility is not installed.  */
+    if (!s390_has_feat(S390_FEAT_ETF2_ENH)) {
+        m3 = 0;
+    }
     if (m3 & 1) {
         tcg_gen_movi_i32(tst, -1);
     } else {
-- 
2.9.4
