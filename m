Received: from eggs.gnu.org ([2001:4830:134:3::10]:41701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dW12f-0002qj-0J
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 09:54:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dW12b-0001zb-2h
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 09:54:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44206)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dW12a-0001zA-QB
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 09:53:57 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Fri, 14 Jul 2017 15:52:15 +0200
Message-Id: <1500040339-119465-25-git-send-email-imammedo@redhat.com>
In-Reply-To: <1500040339-119465-1-git-send-email-imammedo@redhat.com>
References: <1500040339-119465-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 24/28] lm32: replace cpu_lm32_init() with
 cpu_generic_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Eduardo Habkost <ehabkost@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Michael Walle <michael@walle.cc>

it's just a wrapper, drop it and use cpu_generic_init() directly

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
CC: Michael Walle <michael@walle.cc>
---
 target/lm32/cpu.h     | 3 +--
 hw/lm32/lm32_boards.c | 4 ++--
 hw/lm32/milkymist.c   | 2 +-
 target/lm32/helper.c  | 5 -----
 4 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/target/lm32/cpu.h b/target/lm32/cpu.h
index 1d972cb..de265b5 100644
--- a/target/lm32/cpu.h
+++ b/target/lm32/cpu.h
@@ -238,7 +238,6 @@ static inline lm32_wp_t lm32_wp_type(uint32_t dc, int idx)
     return (dc >> (idx+1)*2) & 0x3;
 }
 
-LM32CPU *cpu_lm32_init(const char *cpu_model);
 /* you can call this signal handler from your SIGBUS and SIGSEGV
    signal handlers to inform the virtual CPU of exceptions. non zero
    is returned if the signal was handled by the virtual CPU.  */
@@ -256,7 +255,7 @@ void lm32_watchpoint_insert(CPULM32State *env, int index, target_ulong address,
 void lm32_watchpoint_remove(CPULM32State *env, int index);
 bool lm32_cpu_do_semihosting(CPUState *cs);
 
-#define cpu_init(cpu_model) CPU(cpu_lm32_init(cpu_model))
+#define cpu_init(cpu_model) cpu_generic_init(TYPE_LM32_CPU, cpu_model)
 
 #define cpu_list lm32_cpu_list
 #define cpu_signal_handler cpu_lm32_signal_handler
diff --git a/hw/lm32/lm32_boards.c b/hw/lm32/lm32_boards.c
index 8f0c307..eccf0ac 100644
--- a/hw/lm32/lm32_boards.c
+++ b/hw/lm32/lm32_boards.c
@@ -104,7 +104,7 @@ static void lm32_evr_init(MachineState *machine)
     if (cpu_model == NULL) {
         cpu_model = "lm32-full";
     }
-    cpu = cpu_lm32_init(cpu_model);
+    cpu = LM32_CPU(cpu_generic_init(TYPE_LM32_CPU, cpu_model));
     if (cpu == NULL) {
         fprintf(stderr, "qemu: unable to find CPU '%s'\n", cpu_model);
         exit(1);
@@ -205,7 +205,7 @@ static void lm32_uclinux_init(MachineState *machine)
     if (cpu_model == NULL) {
         cpu_model = "lm32-full";
     }
-    cpu = cpu_lm32_init(cpu_model);
+    cpu = LM32_CPU(cpu_generic_init(TYPE_LM32_CPU, cpu_model));
     if (cpu == NULL) {
         fprintf(stderr, "qemu: unable to find CPU '%s'\n", cpu_model);
         exit(1);
diff --git a/hw/lm32/milkymist.c b/hw/lm32/milkymist.c
index 5cae0f1..dffd879 100644
--- a/hw/lm32/milkymist.c
+++ b/hw/lm32/milkymist.c
@@ -111,7 +111,7 @@ milkymist_init(MachineState *machine)
     if (cpu_model == NULL) {
         cpu_model = "lm32-full";
     }
-    cpu = cpu_lm32_init(cpu_model);
+    cpu = LM32_CPU(cpu_generic_init(TYPE_LM32_CPU, cpu_model));
     if (cpu == NULL) {
         fprintf(stderr, "qemu: unable to find CPU '%s'\n", cpu_model);
         exit(1);
diff --git a/target/lm32/helper.c b/target/lm32/helper.c
index 891da18..929cc36 100644
--- a/target/lm32/helper.c
+++ b/target/lm32/helper.c
@@ -219,11 +219,6 @@ bool lm32_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
     return false;
 }
 
-LM32CPU *cpu_lm32_init(const char *cpu_model)
-{
-    return LM32_CPU(cpu_generic_init(TYPE_LM32_CPU, cpu_model));
-}
-
 /* Some soc ignores the MSB on the address bus. Thus creating a shadow memory
  * area. As a general rule, 0x00000000-0x7fffffff is cached, whereas
  * 0x80000000-0xffffffff is not cached and used to access IO devices. */
-- 
2.7.4
