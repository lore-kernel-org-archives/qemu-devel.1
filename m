Received: from eggs.gnu.org ([2001:4830:134:3::10]:59343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gDJFo-0004tR-R7
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 21:07:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gDJFk-0003Li-3z
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 21:07:04 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:50325)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gDJFj-00033y-Gy
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 21:06:59 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 18 Oct 2018 21:06:11 -0400
Message-Id: <20181019010625.25294-43-cota@braap.org>
In-Reply-To: <20181019010625.25294-1-cota@braap.org>
References: <20181019010625.25294-1-cota@braap.org>
Subject: [Qemu-devel] [RFC v3 42/56] sparc: convert to cpu_interrupt_request
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

Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Artyom Tarasenko <atar4qemu@gmail.com>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 hw/sparc64/sparc64.c | 19 +++++++++++++------
 target/sparc/cpu.c   |  2 +-
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/hw/sparc64/sparc64.c b/hw/sparc64/sparc64.c
index 372bbd4f5b..640c4b6a30 100644
--- a/hw/sparc64/sparc64.c
+++ b/hw/sparc64/sparc64.c
@@ -56,11 +56,13 @@ void cpu_check_irqs(CPUSPARCState *env)
     /* The bit corresponding to psrpil is (1<< psrpil), the next bit
        is (2 << psrpil). */
     if (pil < (2 << env->psrpil)) {
-        if (cs->interrupt_request & CPU_INTERRUPT_HARD) {
+        cpu_mutex_lock(cs);
+        if (cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD) {
             trace_sparc64_cpu_check_irqs_reset_irq(env->interrupt_index);
             env->interrupt_index = 0;
             cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
         }
+        cpu_mutex_unlock(cs);
         return;
     }
 
@@ -87,11 +89,16 @@ void cpu_check_irqs(CPUSPARCState *env)
                 break;
             }
         }
-    } else if (cs->interrupt_request & CPU_INTERRUPT_HARD) {
-        trace_sparc64_cpu_check_irqs_disabled(pil, env->pil_in, env->softint,
-                                              env->interrupt_index);
-        env->interrupt_index = 0;
-        cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
+    } else {
+        cpu_mutex_lock(cs);
+        if (cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD) {
+            trace_sparc64_cpu_check_irqs_disabled(pil, env->pil_in,
+                                                  env->softint,
+                                                  env->interrupt_index);
+            env->interrupt_index = 0;
+            cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
+        }
+        cpu_mutex_unlock(cs);
     }
 }
 
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 0f090ece54..88427283c1 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -709,7 +709,7 @@ static bool sparc_cpu_has_work(CPUState *cs)
     SPARCCPU *cpu = SPARC_CPU(cs);
     CPUSPARCState *env = &cpu->env;
 
-    return (cs->interrupt_request & CPU_INTERRUPT_HARD) &&
+    return (cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD) &&
            cpu_interrupts_enabled(env);
 }
 
-- 
2.17.1
