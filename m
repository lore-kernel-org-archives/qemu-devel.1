Received: from eggs.gnu.org ([2001:4830:134:3::10]:50238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dHZRP-0007dD-CQ
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 13:35:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dHZRO-0003FR-JQ
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 13:35:51 -0400
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:33422)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dHZRO-0003F5-DA
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 13:35:50 -0400
Received: by mail-pg0-x241.google.com with SMTP id s62so7256128pgc.0
	for <qemu-devel@nongnu.org>; Sun, 04 Jun 2017 10:35:50 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Sun,  4 Jun 2017 10:34:27 -0700
Message-Id: <20170604173509.29684-28-rth@twiddle.net>
In-Reply-To: <20170604173509.29684-1-rth@twiddle.net>
References: <20170604173509.29684-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 27/69] target/s390x: Use unwind data for
 helper_testblock
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
 target/s390x/mem_helper.c | 3 +++
 target/s390x/translate.c  | 1 -
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index b64c04e..7df2e53 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -939,6 +939,7 @@ void HELPER(stctl)(CPUS390XState *env, uint32_t r1, uint64_t a2, uint32_t r3)
 
 uint32_t HELPER(testblock)(CPUS390XState *env, uint64_t real_addr)
 {
+    uintptr_t ra = GETPC();
     CPUState *cs = CPU(s390_env_get_cpu(env));
     uint64_t abs_addr;
     int i;
@@ -947,12 +948,14 @@ uint32_t HELPER(testblock)(CPUS390XState *env, uint64_t real_addr)
     abs_addr = mmu_real2abs(env, real_addr) & TARGET_PAGE_MASK;
     if (!address_space_access_valid(&address_space_memory, abs_addr,
                                     TARGET_PAGE_SIZE, true)) {
+        cpu_restore_state(cs, ra);
         program_interrupt(env, PGM_ADDRESSING, 4);
         return 1;
     }
 
     /* Check low-address protection */
     if ((env->cregs[0] & CR0_LOWPROT) && real_addr < 0x2000) {
+        cpu_restore_state(cs, ra);
         program_interrupt(env, PGM_PROTECTION, 4);
         return 1;
     }
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 669da89..cd017ce 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -4042,7 +4042,6 @@ static ExitStatus op_tcxb(DisasContext *s, DisasOps *o)
 static ExitStatus op_testblock(DisasContext *s, DisasOps *o)
 {
     check_privileged(s);
-    potential_page_fault(s);
     gen_helper_testblock(cc_op, cpu_env, o->in2);
     set_cc_static(s);
     return NO_EXIT;
-- 
2.9.4
