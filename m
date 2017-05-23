Received: from eggs.gnu.org ([2001:4830:134:3::10]:54991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dD06w-0005y1-3r
	for qemu-devel@nongnu.org; Mon, 22 May 2017 23:03:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dD06v-0003zG-AO
	for qemu-devel@nongnu.org; Mon, 22 May 2017 23:03:50 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:34209)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dD06v-0003zC-6N
	for qemu-devel@nongnu.org; Mon, 22 May 2017 23:03:49 -0400
Received: by mail-qt0-x241.google.com with SMTP id l39so20704308qtb.1
	for <qemu-devel@nongnu.org>; Mon, 22 May 2017 20:03:49 -0700 (PDT)
Received: from bigtime.twiddle.net.com
	([2602:47:d954:1500:5e51:4fff:fe40:9c64])
	by smtp.gmail.com with ESMTPSA id
	s190sm12918805qkh.57.2017.05.22.20.03.47 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 22 May 2017 20:03:47 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Mon, 22 May 2017 20:03:07 -0700
Message-Id: <20170523030312.6360-27-rth@twiddle.net>
In-Reply-To: <20170523030312.6360-1-rth@twiddle.net>
References: <20170523030312.6360-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 26/31] target/s390x: Use unwind data for
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

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/s390x/mem_helper.c | 3 +++
 target/s390x/translate.c  | 1 -
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index 1e31bd3..a874f8a 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -912,6 +912,7 @@ void HELPER(stctl)(CPUS390XState *env, uint32_t r1, uint64_t a2, uint32_t r3)
 
 uint32_t HELPER(testblock)(CPUS390XState *env, uint64_t real_addr)
 {
+    uintptr_t ra = GETPC();
     CPUState *cs = CPU(s390_env_get_cpu(env));
     uint64_t abs_addr;
     int i;
@@ -920,12 +921,14 @@ uint32_t HELPER(testblock)(CPUS390XState *env, uint64_t real_addr)
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
index 3a2151f..694e099 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -4047,7 +4047,6 @@ static ExitStatus op_tcxb(DisasContext *s, DisasOps *o)
 static ExitStatus op_testblock(DisasContext *s, DisasOps *o)
 {
     check_privileged(s);
-    potential_page_fault(s);
     gen_helper_testblock(cc_op, cpu_env, o->in2);
     set_cc_static(s);
     return NO_EXIT;
-- 
2.9.4
