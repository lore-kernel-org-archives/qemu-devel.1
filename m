Received: from eggs.gnu.org ([2001:4830:134:3::10]:54755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dD06Z-0005bz-32
	for qemu-devel@nongnu.org; Mon, 22 May 2017 23:03:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dD06Y-0003jg-5m
	for qemu-devel@nongnu.org; Mon, 22 May 2017 23:03:27 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:33127)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dD06Y-0003jL-1j
	for qemu-devel@nongnu.org; Mon, 22 May 2017 23:03:26 -0400
Received: by mail-qt0-x242.google.com with SMTP id a46so20683521qte.0
	for <qemu-devel@nongnu.org>; Mon, 22 May 2017 20:03:25 -0700 (PDT)
Received: from bigtime.twiddle.net.com
	([2602:47:d954:1500:5e51:4fff:fe40:9c64])
	by smtp.gmail.com with ESMTPSA id
	s190sm12918805qkh.57.2017.05.22.20.03.24 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 22 May 2017 20:03:24 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Mon, 22 May 2017 20:02:47 -0700
Message-Id: <20170523030312.6360-7-rth@twiddle.net>
In-Reply-To: <20170523030312.6360-1-rth@twiddle.net>
References: <20170523030312.6360-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 06/31] target/s390x: Use unwind data for
 helper_mvc
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
 target/s390x/mem_helper.c | 19 ++++++++++---------
 target/s390x/translate.c  |  1 -
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index e75c2de0..0295485 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -91,7 +91,7 @@ static void fast_memset(CPUS390XState *env, uint64_t dest, uint8_t byte,
 }
 
 static void fast_memmove(CPUS390XState *env, uint64_t dest, uint64_t src,
-                         uint32_t l)
+                         uint32_t l, uintptr_t ra)
 {
     int mmu_idx = cpu_mmu_index(env, false);
 
@@ -110,7 +110,7 @@ static void fast_memmove(CPUS390XState *env, uint64_t dest, uint64_t src,
             /* We failed to get access to one or both whole pages. The next
                read or write access will likely fill the QEMU TLB for the
                next iteration.  */
-            cpu_stb_data(env, dest, cpu_ldub_data(env, src));
+            cpu_stb_data_ra(env, dest, cpu_ldub_data_ra(env, src, ra), ra);
             src++;
             dest++;
             l--;
@@ -187,27 +187,28 @@ uint32_t HELPER(oc)(CPUS390XState *env, uint32_t l, uint64_t dest,
 /* memmove */
 void HELPER(mvc)(CPUS390XState *env, uint32_t l, uint64_t dest, uint64_t src)
 {
-    int i = 0;
+    uintptr_t ra = GETPC();
+    uint32_t i;
 
     HELPER_LOG("%s l %d dest %" PRIx64 " src %" PRIx64 "\n",
                __func__, l, dest, src);
 
     /* mvc with source pointing to the byte after the destination is the
        same as memset with the first source byte */
-    if (dest == (src + 1)) {
-        fast_memset(env, dest, cpu_ldub_data(env, src), l + 1, 0);
+    if (dest == src + 1) {
+        fast_memset(env, dest, cpu_ldub_data_ra(env, src, ra), l + 1, ra);
         return;
     }
 
     /* mvc and memmove do not behave the same when areas overlap! */
-    if ((dest < src) || (src + l < dest)) {
-        fast_memmove(env, dest, src, l + 1);
+    if (dest < src || src + l < dest) {
+        fast_memmove(env, dest, src, l + 1, ra);
         return;
     }
 
     /* slow version with byte accesses which always work */
     for (i = 0; i <= l; i++) {
-        cpu_stb_data(env, dest + i, cpu_ldub_data(env, src + i));
+        cpu_stb_data_ra(env, dest + i, cpu_ldub_data_ra(env, src + i, ra), ra);
     }
 }
 
@@ -373,7 +374,7 @@ void HELPER(mvpg)(CPUS390XState *env, uint64_t r0, uint64_t r1, uint64_t r2)
 {
     /* XXX missing r0 handling */
     env->cc_op = 0;
-    fast_memmove(env, r1, r2, TARGET_PAGE_SIZE);
+    fast_memmove(env, r1, r2, TARGET_PAGE_SIZE, 0);
 }
 
 /* string copy (c is string terminator) */
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 6a51d56..66f3cd6 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -2871,7 +2871,6 @@ static ExitStatus op_movx(DisasContext *s, DisasOps *o)
 static ExitStatus op_mvc(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 l = tcg_const_i32(get_field(s->fields, l1));
-    potential_page_fault(s);
     gen_helper_mvc(cpu_env, l, o->addr1, o->in2);
     tcg_temp_free_i32(l);
     return NO_EXIT;
-- 
2.9.4
