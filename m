Received: from eggs.gnu.org ([2001:4830:134:3::10]:59419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gDJFx-00050C-01
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 21:07:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gDJFl-0003Ny-4O
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 21:07:09 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:39031)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gDJFk-00036E-FH
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 21:07:00 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 18 Oct 2018 21:06:21 -0400
Message-Id: <20181019010625.25294-53-cota@braap.org>
In-Reply-To: <20181019010625.25294-1-cota@braap.org>
References: <20181019010625.25294-1-cota@braap.org>
Subject: [Qemu-devel] [RFC v3 52/56] sparc: acquire the BQL in cpu_has_work
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>

Soon we will call cpu_has_work without the BQL.

Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Artyom Tarasenko <atar4qemu@gmail.com>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/sparc/cpu.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 88427283c1..854c1733c8 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -18,6 +18,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/main-loop.h"
 #include "qapi/error.h"
 #include "cpu.h"
 #include "qemu/error-report.h"
@@ -704,15 +705,30 @@ static void sparc_cpu_synchronize_from_tb(CPUState *cs, TranslationBlock *tb)
     cpu->env.npc = tb->cs_base;
 }
 
-static bool sparc_cpu_has_work(CPUState *cs)
+static bool sparc_cpu_has_work_locked(CPUState *cs)
 {
     SPARCCPU *cpu = SPARC_CPU(cs);
     CPUSPARCState *env = &cpu->env;
 
+    g_assert(qemu_mutex_iothread_locked());
+
     return (cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD) &&
            cpu_interrupts_enabled(env);
 }
 
+static bool sparc_cpu_has_work(CPUState *cs)
+{
+    if (!qemu_mutex_iothread_locked()) {
+        bool ret;
+
+        qemu_mutex_lock_iothread();
+        ret = sparc_cpu_has_work_locked(cs);
+        qemu_mutex_unlock_iothread();
+        return ret;
+    }
+    return sparc_cpu_has_work_locked(cs);
+}
+
 static char *sparc_cpu_type_name(const char *cpu_model)
 {
     char *name = g_strdup_printf(SPARC_CPU_TYPE_NAME("%s"), cpu_model);
-- 
2.17.1
