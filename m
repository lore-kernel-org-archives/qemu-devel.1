Received: from eggs.gnu.org ([209.51.188.92]:35482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1goe3i-0008MI-UH
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 19:48:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1goe3h-00016r-M9
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 19:48:54 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:51871)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1goe3g-0000tJ-VH
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 19:48:53 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Tue, 29 Jan 2019 19:47:25 -0500
Message-Id: <20190130004811.27372-28-cota@braap.org>
In-Reply-To: <20190130004811.27372-1-cota@braap.org>
References: <20190130004811.27372-1-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v6 27/73] xtensa: convert to cpu_halted
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>

Cc: Max Filippov <jcmvbkbc@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/xtensa/cpu.c        | 2 +-
 target/xtensa/exc_helper.c | 2 +-
 target/xtensa/helper.c     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index a54dbe4260..d4ca35e6cc 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -86,7 +86,7 @@ static void xtensa_cpu_reset(CPUState *s)
 
 #ifndef CONFIG_USER_ONLY
     reset_mmu(env);
-    s->halted = env->runstall;
+    cpu_halted_set(s, env->runstall);
 #endif
 }
 
diff --git a/target/xtensa/exc_helper.c b/target/xtensa/exc_helper.c
index 371a32ba5a..65031e6b65 100644
--- a/target/xtensa/exc_helper.c
+++ b/target/xtensa/exc_helper.c
@@ -116,7 +116,7 @@ void HELPER(waiti)(CPUXtensaState *env, uint32_t pc, uint32_t intlevel)
     }
 
     cpu = CPU(xtensa_env_get_cpu(env));
-    cpu->halted = 1;
+    cpu_halted_set(cpu, 1);
     HELPER(exception)(env, EXCP_HLT);
 }
 
diff --git a/target/xtensa/helper.c b/target/xtensa/helper.c
index 323c47a7fb..2ebbfc29bf 100644
--- a/target/xtensa/helper.c
+++ b/target/xtensa/helper.c
@@ -248,7 +248,7 @@ void xtensa_runstall(CPUXtensaState *env, bool runstall)
     CPUState *cpu = CPU(xtensa_env_get_cpu(env));
 
     env->runstall = runstall;
-    cpu->halted = runstall;
+    cpu_halted_set(cpu, runstall);
     if (runstall) {
         cpu_interrupt(cpu, CPU_INTERRUPT_HALT);
     } else {
-- 
2.17.1
