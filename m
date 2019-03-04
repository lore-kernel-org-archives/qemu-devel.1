Received: from eggs.gnu.org ([209.51.188.92]:44641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1h0sAp-00005I-Qb
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:18:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1h0sAk-0001HY-AE
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:18:45 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:34597)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1h0sAj-0000zn-RT
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:18:42 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Mon,  4 Mar 2019 13:17:27 -0500
Message-Id: <20190304181813.8075-28-cota@braap.org>
In-Reply-To: <20190304181813.8075-1-cota@braap.org>
References: <20190304181813.8075-1-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v7 27/73] xtensa: convert to cpu_halted
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Max Filippov <jcmvbkbc@gmail.com>

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
index 4a1f7aef5d..ee4b803be8 100644
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
index f4867a9b56..58876a7622 100644
--- a/target/xtensa/helper.c
+++ b/target/xtensa/helper.c
@@ -318,7 +318,7 @@ void xtensa_runstall(CPUXtensaState *env, bool runstall)
     CPUState *cpu = CPU(xtensa_env_get_cpu(env));
 
     env->runstall = runstall;
-    cpu->halted = runstall;
+    cpu_halted_set(cpu, runstall);
     if (runstall) {
         cpu_interrupt(cpu, CPU_INTERRUPT_HALT);
     } else {
-- 
2.17.1
