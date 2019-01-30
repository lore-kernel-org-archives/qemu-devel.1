Received: from eggs.gnu.org ([209.51.188.92]:36168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1goe4C-0000TR-77
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 19:49:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1goe4B-0001gn-7n
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 19:49:24 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:48473)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1goe4A-0001G2-VO
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 19:49:23 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Tue, 29 Jan 2019 19:48:06 -0500
Message-Id: <20190130004811.27372-69-cota@braap.org>
In-Reply-To: <20190130004811.27372-1-cota@braap.org>
References: <20190130004811.27372-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH v6 68/73] xtensa: convert to
 cpu_has_work_with_iothread_lock
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

Soon we will call cpu_has_work without the BQL.

Cc: Max Filippov <jcmvbkbc@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/xtensa/cpu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index d4ca35e6cc..5f3b4a70b0 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -47,6 +47,8 @@ static bool xtensa_cpu_has_work(CPUState *cs)
 #ifndef CONFIG_USER_ONLY
     XtensaCPU *cpu = XTENSA_CPU(cs);
 
+    g_assert(qemu_mutex_iothread_locked());
+
     return !cpu->env.runstall && cpu->env.pending_irq_level;
 #else
     return true;
@@ -173,7 +175,7 @@ static void xtensa_cpu_class_init(ObjectClass *oc, void *data)
     cc->reset = xtensa_cpu_reset;
 
     cc->class_by_name = xtensa_cpu_class_by_name;
-    cc->has_work = xtensa_cpu_has_work;
+    cc->has_work_with_iothread_lock = xtensa_cpu_has_work;
     cc->do_interrupt = xtensa_cpu_do_interrupt;
     cc->cpu_exec_interrupt = xtensa_cpu_exec_interrupt;
     cc->dump_state = xtensa_cpu_dump_state;
-- 
2.17.1
