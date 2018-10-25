Received: from eggs.gnu.org ([2001:4830:134:3::10]:40307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFjKi-0006hj-TU
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:22:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFjKX-0000J4-Vp
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:21:59 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:38281)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gFjKV-0008Vq-Uu
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:21:57 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 25 Oct 2018 13:20:31 -0400
Message-Id: <20181025172057.20414-23-cota@braap.org>
In-Reply-To: <20181025172057.20414-1-cota@braap.org>
References: <20181025172057.20414-1-cota@braap.org>
Subject: [Qemu-devel] [RFC 22/48] cpu: hook plugin vcpu events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, =?UTF-8?q?Llu=C3=ADs=20Vilanova?= <vilanova@ac.upc.edu>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 cpus.c    | 10 ++++++++++
 exec.c    |  2 ++
 qom/cpu.c |  2 ++
 3 files changed, 14 insertions(+)

diff --git a/cpus.c b/cpus.c
index 28e39f045a..3efe89354d 100644
--- a/cpus.c
+++ b/cpus.c
@@ -43,6 +43,7 @@
 #include "exec/exec-all.h"
 
 #include "qemu/thread.h"
+#include "qemu/plugin.h"
 #include "sysemu/cpus.h"
 #include "sysemu/qtest.h"
 #include "qemu/main-loop.h"
@@ -1322,12 +1323,21 @@ static void qemu_tcg_rr_wait_io_event(CPUState *cpu)
 
 static void qemu_wait_io_event(CPUState *cpu)
 {
+    bool asleep = false;
+
     g_assert(cpu_mutex_locked(cpu));
     g_assert(!qemu_mutex_iothread_locked());
 
     while (cpu_thread_is_idle(cpu)) {
+        if (!asleep) {
+            asleep = true;
+            qemu_plugin_vcpu_idle_cb(cpu);
+        }
         qemu_cond_wait(&cpu->halt_cond, &cpu->lock);
     }
+    if (asleep) {
+        qemu_plugin_vcpu_resume_cb(cpu);
+    }
 
 #ifdef _WIN32
     /* Eat dummy APC queued by qemu_cpu_kick_thread.  */
diff --git a/exec.c b/exec.c
index cd171adb93..71fc76f55e 100644
--- a/exec.c
+++ b/exec.c
@@ -967,6 +967,8 @@ void cpu_exec_realizefn(CPUState *cpu, Error **errp)
     }
     tlb_init(cpu);
 
+    qemu_plugin_vcpu_init_hook(cpu);
+
 #ifndef CONFIG_USER_ONLY
     if (qdev_get_vmsd(DEVICE(cpu)) == NULL) {
         vmstate_register(NULL, cpu->cpu_index, &vmstate_cpu_common, cpu);
diff --git a/qom/cpu.c b/qom/cpu.c
index d1e6ecae03..062817c03b 100644
--- a/qom/cpu.c
+++ b/qom/cpu.c
@@ -32,6 +32,7 @@
 #include "hw/boards.h"
 #include "hw/qdev-properties.h"
 #include "trace-root.h"
+#include "qemu/plugin.h"
 
 CPUInterruptHandler cpu_interrupt_handler;
 
@@ -353,6 +354,7 @@ static void cpu_common_unrealizefn(DeviceState *dev, Error **errp)
     CPUState *cpu = CPU(dev);
     /* NOTE: latest generic point before the cpu is fully unrealized */
     trace_fini_vcpu(cpu);
+    qemu_plugin_vcpu_exit_hook(cpu);
     cpu_exec_unrealizefn(cpu);
 }
 
-- 
2.17.1
