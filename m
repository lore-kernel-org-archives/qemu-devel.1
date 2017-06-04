Received: from eggs.gnu.org ([2001:4830:134:3::10]:50070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dHZR6-0007Ld-1j
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 13:35:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dHZR5-0002rI-7e
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 13:35:32 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:36339)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dHZR5-0002qJ-2o
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 13:35:31 -0400
Received: by mail-pf0-x241.google.com with SMTP id n23so18100591pfb.3
	for <qemu-devel@nongnu.org>; Sun, 04 Jun 2017 10:35:30 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Sun,  4 Jun 2017 10:34:13 -0700
Message-Id: <20170604173509.29684-14-rth@twiddle.net>
In-Reply-To: <20170604173509.29684-1-rth@twiddle.net>
References: <20170604173509.29684-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 13/69] target/s390x: Use unwind data for
 helper_mvst
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
 target/s390x/mem_helper.c | 5 +++--
 target/s390x/translate.c  | 1 -
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index 1c36a47..e4bfc6e 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -409,6 +409,7 @@ uint32_t HELPER(mvpg)(CPUS390XState *env, uint64_t r0, uint64_t r1, uint64_t r2)
 /* string copy (c is string terminator) */
 uint64_t HELPER(mvst)(CPUS390XState *env, uint64_t c, uint64_t d, uint64_t s)
 {
+    uintptr_t ra = GETPC();
     uint32_t len;
 
     c = c & 0xff;
@@ -418,8 +419,8 @@ uint64_t HELPER(mvst)(CPUS390XState *env, uint64_t c, uint64_t d, uint64_t s)
     /* Lest we fail to service interrupts in a timely manner, limit the
        amount of work we're willing to do.  For now, let's cap at 8k.  */
     for (len = 0; len < 0x2000; ++len) {
-        uint8_t v = cpu_ldub_data(env, s + len);
-        cpu_stb_data(env, d + len, v);
+        uint8_t v = cpu_ldub_data_ra(env, s + len, ra);
+        cpu_stb_data_ra(env, d + len, v, ra);
         if (v == c) {
             /* Complete.  Set CC=1 and advance R1.  */
             env->cc_op = 1;
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index f55f10a..86e5567 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -2923,7 +2923,6 @@ static ExitStatus op_mvpg(DisasContext *s, DisasOps *o)
 
 static ExitStatus op_mvst(DisasContext *s, DisasOps *o)
 {
-    potential_page_fault(s);
     gen_helper_mvst(o->in1, cpu_env, regs[0], o->in1, o->in2);
     set_cc_static(s);
     return_low128(o->in2);
-- 
2.9.4
