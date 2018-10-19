Received: from eggs.gnu.org ([2001:4830:134:3::10]:59786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gDJGO-0005U6-Aj
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 21:07:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gDJGK-00042J-Sq
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 21:07:40 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:33717)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gDJGI-0003Hk-5E
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 21:07:35 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 18 Oct 2018 21:06:22 -0400
Message-Id: <20181019010625.25294-54-cota@braap.org>
In-Reply-To: <20181019010625.25294-1-cota@braap.org>
References: <20181019010625.25294-1-cota@braap.org>
Subject: [Qemu-devel] [RFC v3 53/56] xtensa: acquire the BQL in cpu_has_work
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>

Soon we will call cpu_has_work without the BQL.

Cc: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/xtensa/cpu.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index d4ca35e6cc..5cb881f89b 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -29,6 +29,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/main-loop.h"
 #include "qapi/error.h"
 #include "cpu.h"
 #include "qemu-common.h"
@@ -42,17 +43,34 @@ static void xtensa_cpu_set_pc(CPUState *cs, vaddr value)
     cpu->env.pc = value;
 }
 
-static bool xtensa_cpu_has_work(CPUState *cs)
+static bool xtensa_cpu_has_work_locked(CPUState *cs)
 {
 #ifndef CONFIG_USER_ONLY
     XtensaCPU *cpu = XTENSA_CPU(cs);
 
+    g_assert(qemu_mutex_iothread_locked());
+
     return !cpu->env.runstall && cpu->env.pending_irq_level;
 #else
     return true;
 #endif
 }
 
+static bool xtensa_cpu_has_work(CPUState *cs)
+{
+    if (!qemu_mutex_iothread_locked()) {
+        bool ret;
+
+        cpu_mutex_unlock(cs);
+        qemu_mutex_lock_iothread();
+        cpu_mutex_lock(cs);
+        ret = xtensa_cpu_has_work_locked(cs);
+        qemu_mutex_unlock_iothread();
+        return ret;
+    }
+    return xtensa_cpu_has_work_locked(cs);
+}
+
 /* CPUClass::reset() */
 static void xtensa_cpu_reset(CPUState *s)
 {
-- 
2.17.1
