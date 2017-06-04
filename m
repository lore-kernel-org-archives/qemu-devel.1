Received: from eggs.gnu.org ([2001:4830:134:3::10]:50038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dHZR2-0007Jy-3f
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 13:35:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dHZR1-0002n1-5q
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 13:35:28 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:35862)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dHZR1-0002mk-0w
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 13:35:27 -0400
Received: by mail-pg0-x244.google.com with SMTP id v18so3985269pgb.3
	for <qemu-devel@nongnu.org>; Sun, 04 Jun 2017 10:35:26 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Sun,  4 Jun 2017 10:34:10 -0700
Message-Id: <20170604173509.29684-11-rth@twiddle.net>
In-Reply-To: <20170604173509.29684-1-rth@twiddle.net>
References: <20170604173509.29684-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 10/69] target/s390x: Use unwind data for
 helper_srst
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
 target/s390x/mem_helper.c | 3 ++-
 target/s390x/translate.c  | 1 -
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index 3e75cae..33d83e5 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -327,6 +327,7 @@ static inline uint64_t get_address_31fix(CPUS390XState *env, int reg)
 uint64_t HELPER(srst)(CPUS390XState *env, uint64_t r0, uint64_t end,
                       uint64_t str)
 {
+    uintptr_t ra = GETPC();
     uint32_t len;
     uint8_t v, c = r0;
 
@@ -344,7 +345,7 @@ uint64_t HELPER(srst)(CPUS390XState *env, uint64_t r0, uint64_t end,
             env->cc_op = 2;
             return end;
         }
-        v = cpu_ldub_data(env, str + len);
+        v = cpu_ldub_data_ra(env, str + len, ra);
         if (v == c) {
             /* Character found.  Set R1 to the location; R2 is unmodified.  */
             env->cc_op = 1;
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 34ccc22..cd33c51 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -3972,7 +3972,6 @@ static ExitStatus op_stmh(DisasContext *s, DisasOps *o)
 
 static ExitStatus op_srst(DisasContext *s, DisasOps *o)
 {
-    potential_page_fault(s);
     gen_helper_srst(o->in1, cpu_env, regs[0], o->in1, o->in2);
     set_cc_static(s);
     return_low128(o->in2);
-- 
2.9.4
