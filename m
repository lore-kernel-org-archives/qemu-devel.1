Received: from eggs.gnu.org ([2001:4830:134:3::10]:59699)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cjWnL-00083H-2J
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 14:53:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cjWnK-0002Vz-7p
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 14:53:47 -0500
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:34528)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cjWnK-0002VZ-1w
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 14:53:46 -0500
Received: by mail-wr0-x231.google.com with SMTP id l37so60263338wrc.1
	for <qemu-devel@nongnu.org>; Thu, 02 Mar 2017 11:53:45 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu,  2 Mar 2017 19:53:34 +0000
Message-Id: <20170302195337.31558-9-alex.bennee@linaro.org>
In-Reply-To: <20170302195337.31558-1-alex.bennee@linaro.org>
References: <20170302195337.31558-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 08/11] target/xtensa: hold BQL for interrupt
 processing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, rth@twiddle.net, pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, mttcg@listserver.greensocs.com, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Max Filippov <jcmvbkbc@gmail.com>

Make sure we have the BQL held when processing interrupts.

Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/xtensa/helper.c    | 1 +
 target/xtensa/op_helper.c | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/target/xtensa/helper.c b/target/xtensa/helper.c
index c67d715c4b..bcd0b7738d 100644
--- a/target/xtensa/helper.c
+++ b/target/xtensa/helper.c
@@ -217,6 +217,7 @@ static void handle_interrupt(CPUXtensaState *env)
     }
 }
 
+/* Called from cpu_handle_interrupt with BQL held */
 void xtensa_cpu_do_interrupt(CPUState *cs)
 {
     XtensaCPU *cpu = XTENSA_CPU(cs);
diff --git a/target/xtensa/op_helper.c b/target/xtensa/op_helper.c
index af2723445d..519fbeddd6 100644
--- a/target/xtensa/op_helper.c
+++ b/target/xtensa/op_helper.c
@@ -26,6 +26,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/main-loop.h"
 #include "cpu.h"
 #include "exec/helper-proto.h"
 #include "qemu/host-utils.h"
@@ -381,7 +382,11 @@ void HELPER(waiti)(CPUXtensaState *env, uint32_t pc, uint32_t intlevel)
     env->pc = pc;
     env->sregs[PS] = (env->sregs[PS] & ~PS_INTLEVEL) |
         (intlevel << PS_INTLEVEL_SHIFT);
+
+    qemu_mutex_lock_iothread();
     check_interrupts(env);
+    qemu_mutex_unlock_iothread();
+
     if (env->pending_irq_level) {
         cpu_loop_exit(CPU(xtensa_env_get_cpu(env)));
         return;
@@ -426,7 +431,9 @@ void HELPER(update_ccompare)(CPUXtensaState *env, uint32_t i)
 
 void HELPER(check_interrupts)(CPUXtensaState *env)
 {
+    qemu_mutex_lock_iothread();
     check_interrupts(env);
+    qemu_mutex_unlock_iothread();
 }
 
 void HELPER(itlb_hit_test)(CPUXtensaState *env, uint32_t vaddr)
-- 
2.11.0
