Received: from eggs.gnu.org ([209.51.188.92]:35805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1goe41-0000Ex-RV
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 19:49:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1goe40-0001VI-UY
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 19:49:13 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:33085)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1goe40-000189-N5
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 19:49:12 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Tue, 29 Jan 2019 19:47:54 -0500
Message-Id: <20190130004811.27372-57-cota@braap.org>
In-Reply-To: <20190130004811.27372-1-cota@braap.org>
References: <20190130004811.27372-1-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v6 56/73] openrisc: convert to
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
Cc: Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Stafford Horne <shorne@gmail.com>

Cc: Stafford Horne <shorne@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 hw/openrisc/cputimer.c | 2 +-
 target/openrisc/cpu.c  | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/openrisc/cputimer.c b/hw/openrisc/cputimer.c
index 850f88761c..739404e4f5 100644
--- a/hw/openrisc/cputimer.c
+++ b/hw/openrisc/cputimer.c
@@ -102,7 +102,7 @@ static void openrisc_timer_cb(void *opaque)
         CPUState *cs = CPU(cpu);
 
         cpu->env.ttmr |= TTMR_IP;
-        cs->interrupt_request |= CPU_INTERRUPT_TIMER;
+        cpu_interrupt_request_or(cs, CPU_INTERRUPT_TIMER);
     }
 
     switch (cpu->env.ttmr & TTMR_M) {
diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index fb7cb5c507..cdbc9353b7 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -32,8 +32,8 @@ static void openrisc_cpu_set_pc(CPUState *cs, vaddr value)
 
 static bool openrisc_cpu_has_work(CPUState *cs)
 {
-    return cs->interrupt_request & (CPU_INTERRUPT_HARD |
-                                    CPU_INTERRUPT_TIMER);
+    return cpu_interrupt_request(cs) & (CPU_INTERRUPT_HARD |
+                                        CPU_INTERRUPT_TIMER);
 }
 
 static void openrisc_disas_set_info(CPUState *cpu, disassemble_info *info)
-- 
2.17.1
