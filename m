Received: from eggs.gnu.org ([209.51.188.92]:49744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gnZft-0003W1-CH
	for qemu-devel@nongnu.org; Sat, 26 Jan 2019 20:55:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gnZVG-00086m-V5
	for qemu-devel@nongnu.org; Sat, 26 Jan 2019 20:44:55 -0500
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:35962)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1gnZVG-00086N-O2
	for qemu-devel@nongnu.org; Sat, 26 Jan 2019 20:44:54 -0500
Received: by mail-lj1-x241.google.com with SMTP id g11-v6so11381522ljk.3
	for <qemu-devel@nongnu.org>; Sat, 26 Jan 2019 17:44:54 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Sat, 26 Jan 2019 17:44:40 -0800
Message-Id: <20190127014440.21789-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH] target/xtensa: drop function xtensa_timer_irq
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

It's a one-liner used in a single place, move its implementation there
and remove its declaration.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 hw/xtensa/pic_cpu.c | 7 +------
 target/xtensa/cpu.h | 1 -
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/hw/xtensa/pic_cpu.c b/hw/xtensa/pic_cpu.c
index 7e4c65e5ec30..f70684902628 100644
--- a/hw/xtensa/pic_cpu.c
+++ b/hw/xtensa/pic_cpu.c
@@ -77,18 +77,13 @@ static void xtensa_set_irq(void *opaque, int irq, int active)
     }
 }
 
-void xtensa_timer_irq(CPUXtensaState *env, uint32_t id, uint32_t active)
-{
-    qemu_set_irq(env->irq_inputs[env->config->timerint[id]], active);
-}
-
 static void xtensa_ccompare_cb(void *opaque)
 {
     XtensaCcompareTimer *ccompare = opaque;
     CPUXtensaState *env = ccompare->env;
     unsigned i = ccompare - env->ccompare;
 
-    xtensa_timer_irq(env, i, 1);
+    qemu_set_irq(env->irq_inputs[env->config->timerint[i]], 1);
 }
 
 void xtensa_irq_init(CPUXtensaState *env)
diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index bf6f9a09b62c..f579294822c3 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -570,7 +570,6 @@ void xtensa_sim_open_console(Chardev *chr);
 void check_interrupts(CPUXtensaState *s);
 void xtensa_irq_init(CPUXtensaState *env);
 void *xtensa_get_extint(CPUXtensaState *env, unsigned extint);
-void xtensa_timer_irq(CPUXtensaState *env, uint32_t id, uint32_t active);
 int cpu_xtensa_signal_handler(int host_signum, void *pinfo, void *puc);
 void xtensa_cpu_list(FILE *f, fprintf_function cpu_fprintf);
 void xtensa_sync_window_from_phys(CPUXtensaState *env);
-- 
2.11.0
