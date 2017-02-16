Received: from eggs.gnu.org ([2001:4830:134:3::10]:56308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ceP2c-0008Jm-F9
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 11:36:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ceP2b-0007fy-Jh
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 11:36:22 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Feb 2017 16:35:57 +0000
Message-Id: <1487262963-11519-8-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1487262963-11519-1-git-send-email-peter.maydell@linaro.org>
References: <1487262963-11519-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 07/13] armv7m: Remove unused
 armv7m_nvic_acknowledge_irq() return value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Having armv7m_nvic_acknowledge_irq() return the new value of
env->v7m.exception and its one caller assign the return value
back to env->v7m.exception is pointless. Just make the return
type void instead.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/cpu.h      | 2 +-
 hw/intc/armv7m_nvic.c | 4 +---
 target/arm/helper.c   | 2 +-
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 53299fa..ab46c0c 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1351,7 +1351,7 @@ static inline bool armv7m_nvic_can_take_pending_exception(void *opaque)
 }
 #endif
 void armv7m_nvic_set_pending(void *opaque, int irq);
-int armv7m_nvic_acknowledge_irq(void *opaque);
+void armv7m_nvic_acknowledge_irq(void *opaque);
 void armv7m_nvic_complete_irq(void *opaque, int irq);
 
 /* Interface for defining coprocessor registers.
diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index d9b9a43..010bf92 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -412,7 +412,7 @@ void armv7m_nvic_set_pending(void *opaque, int irq)
 }
 
 /* Make pending IRQ active.  */
-int armv7m_nvic_acknowledge_irq(void *opaque)
+void armv7m_nvic_acknowledge_irq(void *opaque)
 {
     NVICState *s = (NVICState *)opaque;
     CPUARMState *env = &s->cpu->env;
@@ -439,8 +439,6 @@ int armv7m_nvic_acknowledge_irq(void *opaque)
     env->v7m.exception = s->vectpending;
 
     nvic_irq_update(s);
-
-    return env->v7m.exception;
 }
 
 void armv7m_nvic_complete_irq(void *opaque, int irq)
diff --git a/target/arm/helper.c b/target/arm/helper.c
index bac1718..050d8df 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6141,7 +6141,7 @@ void arm_v7m_cpu_do_interrupt(CPUState *cs)
         armv7m_nvic_set_pending(env->nvic, ARMV7M_EXCP_DEBUG);
         return;
     case EXCP_IRQ:
-        env->v7m.exception = armv7m_nvic_acknowledge_irq(env->nvic);
+        armv7m_nvic_acknowledge_irq(env->nvic);
         break;
     case EXCP_EXCEPTION_EXIT:
         do_v7m_exception_exit(env);
-- 
2.7.4
