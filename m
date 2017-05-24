Received: from eggs.gnu.org ([2001:4830:134:3::10]:45411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dDbsK-0001xL-U6
	for qemu-devel@nongnu.org; Wed, 24 May 2017 15:23:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dDbsK-0001Iz-0q
	for qemu-devel@nongnu.org; Wed, 24 May 2017 15:23:16 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:35854)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dDbsJ-0001IL-TG
	for qemu-devel@nongnu.org; Wed, 24 May 2017 15:23:15 -0400
Received: by mail-qk0-x242.google.com with SMTP id y128so27717678qka.3
	for <qemu-devel@nongnu.org>; Wed, 24 May 2017 12:23:15 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Wed, 24 May 2017 12:22:31 -0700
Message-Id: <20170524192246.15905-19-rth@twiddle.net>
In-Reply-To: <20170524192246.15905-1-rth@twiddle.net>
References: <20170524192246.15905-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH v2 18/33] target/s390x: Use unwind data for
 helper_cksm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, aurelien@aurel32.net

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/s390x/mem_helper.c | 11 ++++++-----
 target/s390x/translate.c  |  1 -
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index f5a3044..d4ee364 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -633,6 +633,7 @@ uint32_t HELPER(clcle)(CPUS390XState *env, uint32_t r1, uint64_t a2,
 uint64_t HELPER(cksm)(CPUS390XState *env, uint64_t r1,
                       uint64_t src, uint64_t src_len)
 {
+    uintptr_t ra = GETPC();
     uint64_t max_len, len;
     uint64_t cksm = (uint32_t)r1;
 
@@ -642,21 +643,21 @@ uint64_t HELPER(cksm)(CPUS390XState *env, uint64_t r1,
 
     /* Process full words as available.  */
     for (len = 0; len + 4 <= max_len; len += 4, src += 4) {
-        cksm += (uint32_t)cpu_ldl_data(env, src);
+        cksm += (uint32_t)cpu_ldl_data_ra(env, src, ra);
     }
 
     switch (max_len - len) {
     case 1:
-        cksm += cpu_ldub_data(env, src) << 24;
+        cksm += cpu_ldub_data_ra(env, src, ra) << 24;
         len += 1;
         break;
     case 2:
-        cksm += cpu_lduw_data(env, src) << 16;
+        cksm += cpu_lduw_data_ra(env, src, ra) << 16;
         len += 2;
         break;
     case 3:
-        cksm += cpu_lduw_data(env, src) << 16;
-        cksm += cpu_ldub_data(env, src + 2) << 8;
+        cksm += cpu_lduw_data_ra(env, src, ra) << 16;
+        cksm += cpu_ldub_data_ra(env, src + 2, ra) << 8;
         len += 3;
         break;
     }
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 9270067..76910bc 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -1866,7 +1866,6 @@ static ExitStatus op_cksm(DisasContext *s, DisasOps *o)
     int r2 = get_field(s->fields, r2);
     TCGv_i64 len = tcg_temp_new_i64();
 
-    potential_page_fault(s);
     gen_helper_cksm(len, cpu_env, o->in1, o->in2, regs[r2 + 1]);
     set_cc_static(s);
     return_low128(o->out);
-- 
2.9.4
