Received: from eggs.gnu.org ([2001:4830:134:3::10]:59677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cjWnJ-0007zC-Ne
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 14:53:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cjWnI-0002V2-EC
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 14:53:45 -0500
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:38724)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cjWnI-0002U0-90
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 14:53:44 -0500
Received: by mail-wm0-x229.google.com with SMTP id t193so101595wmt.1
	for <qemu-devel@nongnu.org>; Thu, 02 Mar 2017 11:53:44 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu,  2 Mar 2017 19:53:32 +0000
Message-Id: <20170302195337.31558-7-alex.bennee@linaro.org>
In-Reply-To: <20170302195337.31558-1-alex.bennee@linaro.org>
References: <20170302195337.31558-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 06/11] sparc/sparc64: grab BQL before
 calling cpu_check_irqs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, rth@twiddle.net, pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, mttcg@listserver.greensocs.com, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>

IRQ modification is part of device emulation and should be done while
the BQL is held to prevent races when MTTCG is enabled. This adds
assertions in the hw emulation layer and wraps the calls from helpers
in the BQL.

Reported-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 hw/sparc/sun4m.c            |  3 +++
 hw/sparc64/sparc64.c        |  3 +++
 target/sparc/int64_helper.c |  3 +++
 target/sparc/win_helper.c   | 11 +++++++++++
 4 files changed, 20 insertions(+)

diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index 61416a6426..873cd7df9a 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -142,6 +142,9 @@ void cpu_check_irqs(CPUSPARCState *env)
 {
     CPUState *cs;
 
+    /* We should be holding the BQL before we mess with IRQs */
+    g_assert(qemu_mutex_iothread_locked());
+
     if (env->pil_in && (env->interrupt_index == 0 ||
                         (env->interrupt_index & ~15) == TT_EXTINT)) {
         unsigned int i;
diff --git a/hw/sparc64/sparc64.c b/hw/sparc64/sparc64.c
index b3d219c769..4e4fdab065 100644
--- a/hw/sparc64/sparc64.c
+++ b/hw/sparc64/sparc64.c
@@ -55,6 +55,9 @@ void cpu_check_irqs(CPUSPARCState *env)
     uint32_t pil = env->pil_in |
                   (env->softint & ~(SOFTINT_TIMER | SOFTINT_STIMER));
 
+    /* We should be holding the BQL before we mess with IRQs */
+    g_assert(qemu_mutex_iothread_locked());
+
     /* TT_IVEC has a higher priority (16) than TT_EXTINT (31..17) */
     if (env->ivec_status & 0x20) {
         return;
diff --git a/target/sparc/int64_helper.c b/target/sparc/int64_helper.c
index 605747c93c..f942973c22 100644
--- a/target/sparc/int64_helper.c
+++ b/target/sparc/int64_helper.c
@@ -18,6 +18,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/main-loop.h"
 #include "cpu.h"
 #include "exec/helper-proto.h"
 #include "exec/log.h"
@@ -208,7 +209,9 @@ static bool do_modify_softint(CPUSPARCState *env, uint32_t value)
         env->softint = value;
 #if !defined(CONFIG_USER_ONLY)
         if (cpu_interrupts_enabled(env)) {
+            qemu_mutex_lock_iothread();
             cpu_check_irqs(env);
+            qemu_mutex_unlock_iothread();
         }
 #endif
         return true;
diff --git a/target/sparc/win_helper.c b/target/sparc/win_helper.c
index 71b3dd37e8..b387b026d8 100644
--- a/target/sparc/win_helper.c
+++ b/target/sparc/win_helper.c
@@ -18,6 +18,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/main-loop.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "exec/helper-proto.h"
@@ -86,7 +87,9 @@ void cpu_put_psr(CPUSPARCState *env, target_ulong val)
 {
     cpu_put_psr_raw(env, val);
 #if ((!defined(TARGET_SPARC64)) && !defined(CONFIG_USER_ONLY))
+    qemu_mutex_lock_iothread();
     cpu_check_irqs(env);
+    qemu_mutex_unlock_iothread();
 #endif
 }
 
@@ -368,7 +371,9 @@ void helper_wrpstate(CPUSPARCState *env, target_ulong new_state)
 
 #if !defined(CONFIG_USER_ONLY)
     if (cpu_interrupts_enabled(env)) {
+        qemu_mutex_lock_iothread();
         cpu_check_irqs(env);
+        qemu_mutex_unlock_iothread();
     }
 #endif
 }
@@ -381,7 +386,9 @@ void helper_wrpil(CPUSPARCState *env, target_ulong new_pil)
     env->psrpil = new_pil;
 
     if (cpu_interrupts_enabled(env)) {
+        qemu_mutex_lock_iothread();
         cpu_check_irqs(env);
+        qemu_mutex_unlock_iothread();
     }
 #endif
 }
@@ -408,7 +415,9 @@ void helper_done(CPUSPARCState *env)
 
 #if !defined(CONFIG_USER_ONLY)
     if (cpu_interrupts_enabled(env)) {
+        qemu_mutex_lock_iothread();
         cpu_check_irqs(env);
+        qemu_mutex_unlock_iothread();
     }
 #endif
 }
@@ -435,7 +444,9 @@ void helper_retry(CPUSPARCState *env)
 
 #if !defined(CONFIG_USER_ONLY)
     if (cpu_interrupts_enabled(env)) {
+        qemu_mutex_lock_iothread();
         cpu_check_irqs(env);
+        qemu_mutex_unlock_iothread();
     }
 #endif
 }
-- 
2.11.0
