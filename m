Received: from eggs.gnu.org ([209.51.188.92]:45644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gnwPk-0004zY-6B
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 21:12:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gnwN8-0005dG-A7
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 21:10:02 -0500
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:37993)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1gnwN8-0005cn-3N
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 21:10:02 -0500
Received: by mail-lf1-x142.google.com with SMTP id a8so10674368lfk.5
	for <qemu-devel@nongnu.org>; Sun, 27 Jan 2019 18:10:02 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Sun, 27 Jan 2019 18:09:34 -0800
Message-Id: <20190128020937.22775-2-jcmvbkbc@gmail.com>
In-Reply-To: <20190128020937.22775-1-jcmvbkbc@gmail.com>
References: <20190128020937.22775-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 1/4] target/xtensa: expose core runstall as an
 IRQ line
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>

Runstall signal looks very much like a level-triggered IRQ line. Provide
xtensa_get_runstall function that returns runstall IRQ.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 hw/xtensa/pic_cpu.c | 12 ++++++++++++
 target/xtensa/cpu.h |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/hw/xtensa/pic_cpu.c b/hw/xtensa/pic_cpu.c
index 077f4ad53d6d..a8939f5e58d0 100644
--- a/hw/xtensa/pic_cpu.c
+++ b/hw/xtensa/pic_cpu.c
@@ -86,6 +86,12 @@ static void xtensa_ccompare_cb(void *opaque)
     qemu_set_irq(env->irq_inputs[env->config->timerint[i]], 1);
 }
 
+static void xtensa_set_runstall(void *opaque, int irq, int active)
+{
+    CPUXtensaState *env = opaque;
+    xtensa_runstall(env, active);
+}
+
 void xtensa_irq_init(CPUXtensaState *env)
 {
     unsigned i;
@@ -106,9 +112,15 @@ void xtensa_irq_init(CPUXtensaState *env)
 
         env->ext_irq_inputs[i] = env->irq_inputs[irq];
     }
+    env->runstall_irq = qemu_allocate_irq(xtensa_set_runstall, env, 0);
 }
 
 qemu_irq *xtensa_get_extints(CPUXtensaState *env)
 {
     return env->ext_irq_inputs;
 }
+
+qemu_irq xtensa_get_runstall(CPUXtensaState *env)
+{
+    return env->runstall_irq;
+}
diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index 176af8a53cf0..b665bfc0068a 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -485,6 +485,7 @@ typedef struct CPUXtensaState {
     int pending_irq_level; /* level of last raised IRQ */
     qemu_irq *irq_inputs;
     qemu_irq ext_irq_inputs[MAX_NINTERRUPT];
+    qemu_irq runstall_irq;
     XtensaCcompareTimer ccompare[MAX_NCCOMPARE];
     uint64_t time_base;
     uint64_t ccount_time;
@@ -571,6 +572,7 @@ void xtensa_sim_open_console(Chardev *chr);
 void check_interrupts(CPUXtensaState *s);
 void xtensa_irq_init(CPUXtensaState *env);
 qemu_irq *xtensa_get_extints(CPUXtensaState *env);
+qemu_irq xtensa_get_runstall(CPUXtensaState *env);
 int cpu_xtensa_signal_handler(int host_signum, void *pinfo, void *puc);
 void xtensa_cpu_list(FILE *f, fprintf_function cpu_fprintf);
 void xtensa_sync_window_from_phys(CPUXtensaState *env);
-- 
2.11.0
