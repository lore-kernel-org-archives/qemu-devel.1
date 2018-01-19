Received: from eggs.gnu.org ([2001:4830:134:3::10]:34628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1ecZ2f-0002yd-IJ
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 10:57:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1ecZ2d-0006AK-3w
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 10:57:21 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:49819 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1ecZ2c-0005hp-Sy
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 10:57:19 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Fri, 19 Jan 2018 16:56:28 +0100
Message-Id: <1516377391-25945-5-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1516377391-25945-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1516377391-25945-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH 4/7] hw/mips_int: hold BQL for all interrupt
 requests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, Fam Zheng <famz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Richard Henderson <rth@twiddle.net>, Riku Voipio <riku.voipio@iki.fi>, Yongbok Kim <yongbok.kim@mips.com>, Aleksandar Markovic <aleksandar.markovic@mips.com>, Goran Ferenc <goran.ferenc@mips.com>, Miodrag Dinic <miodrag.dinic@mips.com>, Petar Jovanovic <petar.jovanovic@mips.com>

From: Miodrag Dinic <miodrag.dinic@mips.com>

Make sure BQL is held for all interrupt requests.

For MTTCG-enabled configurations, handling soft and hard interrupts
between vCPUs must be properly locked. By acquiring BQL, make sure
all paths triggering an IRQ are synchronized.

Signed-off-by: Miodrag Dinic <miodrag.dinic@mips.com>
Signed-off-by: Aleksandar Markovic <aleksandar.markovic@mips.com>
---
 hw/mips/mips_int.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/hw/mips/mips_int.c b/hw/mips/mips_int.c
index 48192d2..5ddeb15 100644
--- a/hw/mips/mips_int.c
+++ b/hw/mips/mips_int.c
@@ -21,6 +21,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/main-loop.h"
 #include "hw/hw.h"
 #include "hw/mips/cpudevs.h"
 #include "cpu.h"
@@ -32,10 +33,17 @@ static void cpu_mips_irq_request(void *opaque, int irq, int level)
     MIPSCPU *cpu = opaque;
     CPUMIPSState *env = &cpu->env;
     CPUState *cs = CPU(cpu);
+    bool locked = false;
 
     if (irq < 0 || irq > 7)
         return;
 
+    /* Make sure locking works even if BQL is already held by the caller */
+    if (!qemu_mutex_iothread_locked()) {
+        locked = true;
+        qemu_mutex_lock_iothread();
+    }
+
     if (level) {
         env->CP0_Cause |= 1 << (irq + CP0Ca_IP);
 
@@ -56,6 +64,10 @@ static void cpu_mips_irq_request(void *opaque, int irq, int level)
     } else {
         cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
     }
+
+    if (locked) {
+        qemu_mutex_unlock_iothread();
+    }
 }
 
 void cpu_mips_irq_init_cpu(MIPSCPU *cpu)
-- 
2.7.4
