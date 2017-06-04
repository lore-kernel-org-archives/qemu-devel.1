Received: from eggs.gnu.org ([2001:4830:134:3::10]:50280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dHZRV-0007gr-JR
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 13:35:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dHZRR-0003HV-Dg
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 13:35:57 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:35884)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dHZRR-0003Gl-7p
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 13:35:53 -0400
Received: by mail-pg0-x243.google.com with SMTP id v18so3986008pgb.3
	for <qemu-devel@nongnu.org>; Sun, 04 Jun 2017 10:35:53 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Sun,  4 Jun 2017 10:34:29 -0700
Message-Id: <20170604173509.29684-30-rth@twiddle.net>
In-Reply-To: <20170604173509.29684-1-rth@twiddle.net>
References: <20170604173509.29684-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 29/69] target/s390x: Use unwind data for
 helper_lra
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

Fix saving exception_index around mmu_translate; eliminate a dead store.

Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/s390x/mem_helper.c | 6 +++---
 target/s390x/translate.c  | 1 -
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index a8c85c9..17d8257 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -1208,17 +1208,17 @@ uint64_t HELPER(lra)(CPUS390XState *env, uint64_t addr)
 {
     CPUState *cs = CPU(s390_env_get_cpu(env));
     uint32_t cc = 0;
-    int old_exc = cs->exception_index;
     uint64_t asc = env->psw.mask & PSW_MASK_ASC;
     uint64_t ret;
-    int flags;
+    int old_exc, flags;
 
     /* XXX incomplete - has more corner cases */
     if (!(env->psw.mask & PSW_MASK_64) && (addr >> 32)) {
+        cpu_restore_state(cs, GETPC());
         program_interrupt(env, PGM_SPECIAL_OP, 2);
     }
 
-    cs->exception_index = old_exc;
+    old_exc = cs->exception_index;
     if (mmu_translate(env, addr, 0, asc, &ret, &flags, true)) {
         cc = 3;
     }
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 7b9c111..141be22 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -2560,7 +2560,6 @@ static ExitStatus op_lctlg(DisasContext *s, DisasOps *o)
 static ExitStatus op_lra(DisasContext *s, DisasOps *o)
 {
     check_privileged(s);
-    potential_page_fault(s);
     gen_helper_lra(o->out, cpu_env, o->in2);
     set_cc_static(s);
     return NO_EXIT;
-- 
2.9.4
