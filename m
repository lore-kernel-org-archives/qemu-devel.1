Received: from eggs.gnu.org ([2001:4830:134:3::10]:55013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dD06y-00060K-FO
	for qemu-devel@nongnu.org; Mon, 22 May 2017 23:03:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dD06x-0003zo-Jo
	for qemu-devel@nongnu.org; Mon, 22 May 2017 23:03:52 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:36085)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dD06x-0003zh-Fo
	for qemu-devel@nongnu.org; Mon, 22 May 2017 23:03:51 -0400
Received: by mail-qt0-x242.google.com with SMTP id j13so20680092qta.3
	for <qemu-devel@nongnu.org>; Mon, 22 May 2017 20:03:51 -0700 (PDT)
Received: from bigtime.twiddle.net.com
	([2602:47:d954:1500:5e51:4fff:fe40:9c64])
	by smtp.gmail.com with ESMTPSA id
	s190sm12918805qkh.57.2017.05.22.20.03.49 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 22 May 2017 20:03:50 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Mon, 22 May 2017 20:03:09 -0700
Message-Id: <20170523030312.6360-29-rth@twiddle.net>
In-Reply-To: <20170523030312.6360-1-rth@twiddle.net>
References: <20170523030312.6360-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 28/31] target/s390x: Use unwind data for
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

Note that exception_index is not live during a TB,
so there is no point saving it around mmu_translate.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/s390x/mem_helper.c | 4 +---
 target/s390x/translate.c  | 1 -
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index 7f22bf0..81b27c0 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -1181,17 +1181,16 @@ uint64_t HELPER(lra)(CPUS390XState *env, uint64_t addr)
 {
     CPUState *cs = CPU(s390_env_get_cpu(env));
     uint32_t cc = 0;
-    int old_exc = cs->exception_index;
     uint64_t asc = env->psw.mask & PSW_MASK_ASC;
     uint64_t ret;
     int flags;
 
     /* XXX incomplete - has more corner cases */
     if (!(env->psw.mask & PSW_MASK_64) && (addr >> 32)) {
+        cpu_restore_state(cs, GETPC());
         program_interrupt(env, PGM_SPECIAL_OP, 2);
     }
 
-    cs->exception_index = old_exc;
     if (mmu_translate(env, addr, 0, asc, &ret, &flags, true)) {
         cc = 3;
     }
@@ -1200,7 +1199,6 @@ uint64_t HELPER(lra)(CPUS390XState *env, uint64_t addr)
     } else {
         ret |= addr & ~TARGET_PAGE_MASK;
     }
-    cs->exception_index = old_exc;
 
     env->cc_op = cc;
     return ret;
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 282fa27..3e4b397 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -2565,7 +2565,6 @@ static ExitStatus op_lctlg(DisasContext *s, DisasOps *o)
 static ExitStatus op_lra(DisasContext *s, DisasOps *o)
 {
     check_privileged(s);
-    potential_page_fault(s);
     gen_helper_lra(o->out, cpu_env, o->in2);
     set_cc_static(s);
     return NO_EXIT;
-- 
2.9.4
