Received: from eggs.gnu.org ([2001:4830:134:3::10]:33546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dIOss-0002Pd-Md
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 20:31:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dIOsq-0001qM-KD
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 20:31:38 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:33032)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dIOsq-0001qC-GM
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 20:31:36 -0400
Received: by mail-qt0-x243.google.com with SMTP id w1so26595183qtg.0
	for <qemu-devel@nongnu.org>; Tue, 06 Jun 2017 17:31:36 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue,  6 Jun 2017 17:30:17 -0700
Message-Id: <20170607003119.14778-9-rth@twiddle.net>
In-Reply-To: <20170607003119.14778-1-rth@twiddle.net>
References: <20170607003119.14778-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL v2 08/70] target/s390x: Use unwind data for
 helper_clc
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

Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/s390x/mem_helper.c | 29 +++++++++++++++++------------
 target/s390x/translate.c  |  1 -
 2 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index 78a9ac1..50689bb 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -233,32 +233,37 @@ void HELPER(mvc)(CPUS390XState *env, uint32_t l, uint64_t dest, uint64_t src)
 }
 
 /* compare unsigned byte arrays */
-uint32_t HELPER(clc)(CPUS390XState *env, uint32_t l, uint64_t s1, uint64_t s2)
+static uint32_t do_helper_clc(CPUS390XState *env, uint32_t l, uint64_t s1,
+                              uint64_t s2, uintptr_t ra)
 {
-    int i;
-    unsigned char x, y;
-    uint32_t cc;
+    uint32_t i;
+    uint32_t cc = 0;
 
     HELPER_LOG("%s l %d s1 %" PRIx64 " s2 %" PRIx64 "\n",
                __func__, l, s1, s2);
+
     for (i = 0; i <= l; i++) {
-        x = cpu_ldub_data(env, s1 + i);
-        y = cpu_ldub_data(env, s2 + i);
+        uint8_t x = cpu_ldub_data_ra(env, s1 + i, ra);
+        uint8_t y = cpu_ldub_data_ra(env, s2 + i, ra);
         HELPER_LOG("%02x (%c)/%02x (%c) ", x, x, y, y);
         if (x < y) {
             cc = 1;
-            goto done;
+            break;
         } else if (x > y) {
             cc = 2;
-            goto done;
+            break;
         }
     }
-    cc = 0;
- done:
+
     HELPER_LOG("\n");
     return cc;
 }
 
+uint32_t HELPER(clc)(CPUS390XState *env, uint32_t l, uint64_t s1, uint64_t s2)
+{
+    return do_helper_clc(env, l, s1, s2, GETPC());
+}
+
 /* compare logical under mask */
 uint32_t HELPER(clm)(CPUS390XState *env, uint32_t r1, uint32_t mask,
                      uint64_t addr)
@@ -1237,8 +1242,8 @@ uint32_t HELPER(ex)(CPUS390XState *env, uint32_t cc, uint64_t v1,
                               get_address(env, 0, b2, d2), 0);
             break;
         case 0x500:
-            cc = helper_clc(env, l, get_address(env, 0, b1, d1),
-                            get_address(env, 0, b2, d2));
+            cc = do_helper_clc(env, l, get_address(env, 0, b1, d1),
+                               get_address(env, 0, b2, d2), 0);
             break;
         case 0x600:
             cc = do_helper_oc(env, l, get_address(env, 0, b1, d1),
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index a9502cc..c47b818 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -1906,7 +1906,6 @@ static ExitStatus op_clc(DisasContext *s, DisasOps *o)
         tcg_gen_qemu_ld64(cc_dst, o->in2, get_mem_index(s));
         break;
     default:
-        potential_page_fault(s);
         vl = tcg_const_i32(l);
         gen_helper_clc(cc_op, cpu_env, vl, o->addr1, o->in2);
         tcg_temp_free_i32(vl);
-- 
2.9.4
