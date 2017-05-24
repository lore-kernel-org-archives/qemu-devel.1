Received: from eggs.gnu.org ([2001:4830:134:3::10]:45529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dDbsX-00027A-Ix
	for qemu-devel@nongnu.org; Wed, 24 May 2017 15:23:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dDbsW-0001kt-QA
	for qemu-devel@nongnu.org; Wed, 24 May 2017 15:23:29 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:35871)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dDbsW-0001k8-Ls
	for qemu-devel@nongnu.org; Wed, 24 May 2017 15:23:28 -0400
Received: by mail-qk0-x241.google.com with SMTP id y128so27718268qka.3
	for <qemu-devel@nongnu.org>; Wed, 24 May 2017 12:23:28 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Wed, 24 May 2017 12:22:41 -0700
Message-Id: <20170524192246.15905-29-rth@twiddle.net>
In-Reply-To: <20170524192246.15905-1-rth@twiddle.net>
References: <20170524192246.15905-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH v2 28/33] target/s390x: Use unwind data for
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
Cc: thuth@redhat.com, aurelien@aurel32.net

Fix saving exception_index around mmu_translate; eliminate a dead store.

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
