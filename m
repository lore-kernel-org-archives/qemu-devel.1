Received: from eggs.gnu.org ([2001:4830:134:3::10]:45304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dDbsA-0001k8-Uj
	for qemu-devel@nongnu.org; Wed, 24 May 2017 15:23:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dDbs9-00011b-R2
	for qemu-devel@nongnu.org; Wed, 24 May 2017 15:23:06 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:32998)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dDbs9-00011N-MV
	for qemu-devel@nongnu.org; Wed, 24 May 2017 15:23:05 -0400
Received: by mail-qk0-x241.google.com with SMTP id o85so27687320qkh.0
	for <qemu-devel@nongnu.org>; Wed, 24 May 2017 12:23:05 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Wed, 24 May 2017 12:22:23 -0700
Message-Id: <20170524192246.15905-11-rth@twiddle.net>
In-Reply-To: <20170524192246.15905-1-rth@twiddle.net>
References: <20170524192246.15905-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH v2 10/33] target/s390x: Use unwind data for
 helper_clst
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
 target/s390x/mem_helper.c | 5 +++--
 target/s390x/translate.c  | 1 -
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index 33d83e5..af2801e 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -362,6 +362,7 @@ uint64_t HELPER(srst)(CPUS390XState *env, uint64_t r0, uint64_t end,
 /* unsigned string compare (c is string terminator) */
 uint64_t HELPER(clst)(CPUS390XState *env, uint64_t c, uint64_t s1, uint64_t s2)
 {
+    uintptr_t ra = GETPC();
     uint32_t len;
 
     c = c & 0xff;
@@ -371,8 +372,8 @@ uint64_t HELPER(clst)(CPUS390XState *env, uint64_t c, uint64_t s1, uint64_t s2)
     /* Lest we fail to service interrupts in a timely manner, limit the
        amount of work we're willing to do.  For now, let's cap at 8k.  */
     for (len = 0; len < 0x2000; ++len) {
-        uint8_t v1 = cpu_ldub_data(env, s1 + len);
-        uint8_t v2 = cpu_ldub_data(env, s2 + len);
+        uint8_t v1 = cpu_ldub_data_ra(env, s1 + len, ra);
+        uint8_t v2 = cpu_ldub_data_ra(env, s2 + len, ra);
         if (v1 == v2) {
             if (v1 == c) {
                 /* Equal.  CC=0, and don't advance the registers.  */
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index cd33c51..a24e288 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -1937,7 +1937,6 @@ static ExitStatus op_clm(DisasContext *s, DisasOps *o)
 
 static ExitStatus op_clst(DisasContext *s, DisasOps *o)
 {
-    potential_page_fault(s);
     gen_helper_clst(o->in1, cpu_env, regs[0], o->in1, o->in2);
     set_cc_static(s);
     return_low128(o->in2);
-- 
2.9.4
