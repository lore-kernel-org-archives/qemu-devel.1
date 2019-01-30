Received: from eggs.gnu.org ([209.51.188.92]:35750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1goe40-0000CR-W3
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 19:49:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1goe40-0001Tr-0L
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 19:49:12 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:55631)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1goe3y-000188-O7
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 19:49:10 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Tue, 29 Jan 2019 19:47:53 -0500
Message-Id: <20190130004811.27372-56-cota@braap.org>
In-Reply-To: <20190130004811.27372-1-cota@braap.org>
References: <20190130004811.27372-1-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v6 55/73] sparc: convert to
 cpu_interrupt_request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>

Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Artyom Tarasenko <atar4qemu@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 hw/sparc64/sparc64.c | 4 ++--
 target/sparc/cpu.c   | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/sparc64/sparc64.c b/hw/sparc64/sparc64.c
index 372bbd4f5b..58faeb111a 100644
--- a/hw/sparc64/sparc64.c
+++ b/hw/sparc64/sparc64.c
@@ -56,7 +56,7 @@ void cpu_check_irqs(CPUSPARCState *env)
     /* The bit corresponding to psrpil is (1<< psrpil), the next bit
        is (2 << psrpil). */
     if (pil < (2 << env->psrpil)) {
-        if (cs->interrupt_request & CPU_INTERRUPT_HARD) {
+        if (cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD) {
             trace_sparc64_cpu_check_irqs_reset_irq(env->interrupt_index);
             env->interrupt_index = 0;
             cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
@@ -87,7 +87,7 @@ void cpu_check_irqs(CPUSPARCState *env)
                 break;
             }
         }
-    } else if (cs->interrupt_request & CPU_INTERRUPT_HARD) {
+    } else if (cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD) {
         trace_sparc64_cpu_check_irqs_disabled(pil, env->pil_in, env->softint,
                                               env->interrupt_index);
         env->interrupt_index = 0;
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 4a4445bdf5..933fd8e954 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -708,7 +708,7 @@ static bool sparc_cpu_has_work(CPUState *cs)
     SPARCCPU *cpu = SPARC_CPU(cs);
     CPUSPARCState *env = &cpu->env;
 
-    return (cs->interrupt_request & CPU_INTERRUPT_HARD) &&
+    return (cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD) &&
            cpu_interrupts_enabled(env);
 }
 
-- 
2.17.1
