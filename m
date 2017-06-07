Received: from eggs.gnu.org ([2001:4830:134:3::10]:33785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dIOtA-0002g9-WC
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 20:31:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dIOt8-0001yn-41
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 20:31:56 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:33047)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dIOt8-0001ya-0J
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 20:31:54 -0400
Received: by mail-qt0-x241.google.com with SMTP id w1so26595652qtg.0
	for <qemu-devel@nongnu.org>; Tue, 06 Jun 2017 17:31:53 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue,  6 Jun 2017 17:30:31 -0700
Message-Id: <20170607003119.14778-23-rth@twiddle.net>
In-Reply-To: <20170607003119.14778-1-rth@twiddle.net>
References: <20170607003119.14778-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL v2 22/70] target/s390x: Use unwind data for
 helper_tre
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

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/s390x/mem_helper.c | 15 ++++++++-------
 target/s390x/translate.c  |  1 -
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index b37a963..fd6dbf7 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -744,9 +744,11 @@ void HELPER(tr)(CPUS390XState *env, uint32_t len, uint64_t array,
 uint64_t HELPER(tre)(CPUS390XState *env, uint64_t array,
                      uint64_t len, uint64_t trans)
 {
+    uintptr_t ra = GETPC();
     uint8_t end = env->regs[0] & 0xff;
     uint64_t l = len;
     uint64_t i;
+    uint32_t cc = 0;
 
     if (!(env->psw.mask & PSW_MASK_64)) {
         array &= 0x7fffffff;
@@ -757,25 +759,24 @@ uint64_t HELPER(tre)(CPUS390XState *env, uint64_t array,
        amount of work we're willing to do.  For now, let's cap at 8k.  */
     if (l > 0x2000) {
         l = 0x2000;
-        env->cc_op = 3;
-    } else {
-        env->cc_op = 0;
+        cc = 3;
     }
 
     for (i = 0; i < l; i++) {
         uint8_t byte, new_byte;
 
-        byte = cpu_ldub_data(env, array + i);
+        byte = cpu_ldub_data_ra(env, array + i, ra);
 
         if (byte == end) {
-            env->cc_op = 1;
+            cc = 1;
             break;
         }
 
-        new_byte = cpu_ldub_data(env, trans + byte);
-        cpu_stb_data(env, array + i, new_byte);
+        new_byte = cpu_ldub_data_ra(env, trans + byte, ra);
+        cpu_stb_data_ra(env, array + i, new_byte, ra);
     }
 
+    env->cc_op = cc;
     env->retxl = len - i;
     return array + i;
 }
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index e4da94d..d42896f 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -4078,7 +4078,6 @@ static ExitStatus op_tr(DisasContext *s, DisasOps *o)
 
 static ExitStatus op_tre(DisasContext *s, DisasOps *o)
 {
-    potential_page_fault(s);
     gen_helper_tre(o->out, cpu_env, o->out, o->out2, o->in2);
     return_low128(o->out2);
     set_cc_static(s);
-- 
2.9.4
