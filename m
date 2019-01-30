Received: from eggs.gnu.org ([209.51.188.92]:35313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1goe3a-0008GO-Tp
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 19:48:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1goe3Z-0000zk-SB
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 19:48:46 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:59567)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1goe3Z-0000pM-Nm
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 19:48:45 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Tue, 29 Jan 2019 19:47:24 -0500
Message-Id: <20190130004811.27372-27-cota@braap.org>
In-Reply-To: <20190130004811.27372-1-cota@braap.org>
References: <20190130004811.27372-1-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v6 26/73] sparc: convert to cpu_halted
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Fabien Chouteau <chouteau@adacore.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>

Cc: Fabien Chouteau <chouteau@adacore.com>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Artyom Tarasenko <atar4qemu@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 hw/sparc/leon3.c      | 2 +-
 hw/sparc/sun4m.c      | 8 ++++----
 hw/sparc64/sparc64.c  | 4 ++--
 target/sparc/helper.c | 2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index fa98ab8177..0746001f91 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -61,7 +61,7 @@ static void main_cpu_reset(void *opaque)
 
     cpu_reset(cpu);
 
-    cpu->halted = 0;
+    cpu_halted_set(cpu, 0);
     env->pc     = s->entry;
     env->npc    = s->entry + 4;
     env->regbase[6] = s->sp;
diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index 709ee37e08..ddcc8d8c4f 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -167,7 +167,7 @@ static void cpu_kick_irq(SPARCCPU *cpu)
     CPUSPARCState *env = &cpu->env;
     CPUState *cs = CPU(cpu);
 
-    cs->halted = 0;
+    cpu_halted_set(cs, 0);
     cpu_check_irqs(env);
     qemu_cpu_kick(cs);
 }
@@ -198,7 +198,7 @@ static void main_cpu_reset(void *opaque)
     CPUState *cs = CPU(cpu);
 
     cpu_reset(cs);
-    cs->halted = 0;
+    cpu_halted_set(cs, 0);
 }
 
 static void secondary_cpu_reset(void *opaque)
@@ -207,7 +207,7 @@ static void secondary_cpu_reset(void *opaque)
     CPUState *cs = CPU(cpu);
 
     cpu_reset(cs);
-    cs->halted = 1;
+    cpu_halted_set(cs, 1);
 }
 
 static void cpu_halt_signal(void *opaque, int irq, int level)
@@ -825,7 +825,7 @@ static void cpu_devinit(const char *cpu_type, unsigned int id,
     } else {
         qemu_register_reset(secondary_cpu_reset, cpu);
         cs = CPU(cpu);
-        cs->halted = 1;
+        cpu_halted_set(cs, 1);
     }
     *cpu_irqs = qemu_allocate_irqs(cpu_set_irq, cpu, MAX_PILS);
     env->prom_addr = prom_addr;
diff --git a/hw/sparc64/sparc64.c b/hw/sparc64/sparc64.c
index 408388945e..372bbd4f5b 100644
--- a/hw/sparc64/sparc64.c
+++ b/hw/sparc64/sparc64.c
@@ -100,7 +100,7 @@ static void cpu_kick_irq(SPARCCPU *cpu)
     CPUState *cs = CPU(cpu);
     CPUSPARCState *env = &cpu->env;
 
-    cs->halted = 0;
+    cpu_halted_set(cs, 0);
     cpu_check_irqs(env);
     qemu_cpu_kick(cs);
 }
@@ -115,7 +115,7 @@ void sparc64_cpu_set_ivec_irq(void *opaque, int irq, int level)
         if (!(env->ivec_status & 0x20)) {
             trace_sparc64_cpu_ivec_raise_irq(irq);
             cs = CPU(cpu);
-            cs->halted = 0;
+            cpu_halted_set(cs, 0);
             env->interrupt_index = TT_IVEC;
             env->ivec_status |= 0x20;
             env->ivec_data[0] = (0x1f << 6) | irq;
diff --git a/target/sparc/helper.c b/target/sparc/helper.c
index 46232788c8..dd00cf7cac 100644
--- a/target/sparc/helper.c
+++ b/target/sparc/helper.c
@@ -245,7 +245,7 @@ void helper_power_down(CPUSPARCState *env)
 {
     CPUState *cs = CPU(sparc_env_get_cpu(env));
 
-    cs->halted = 1;
+    cpu_halted_set(cs, 1);
     cs->exception_index = EXCP_HLT;
     env->pc = env->npc;
     env->npc = env->pc + 4;
-- 
2.17.1
