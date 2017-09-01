Received: from eggs.gnu.org ([2001:4830:134:3::10]:41194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dnnUj-0000E7-Ho
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:04:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dnnUd-0003C7-6U
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:04:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47688)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dnnUc-0003Bp-UB
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:04:23 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri,  1 Sep 2017 12:03:13 -0300
Message-Id: <20170901150317.10380-26-ehabkost@redhat.com>
In-Reply-To: <20170901150317.10380-1-ehabkost@redhat.com>
References: <20170901150317.10380-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 25/29] lm32: replace cpu_lm32_init() with
 cpu_generic_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>

From: Igor Mammedov <imammedo@redhat.com>

it's just a wrapper, drop it and use cpu_generic_init() directly

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Acked-by: Michael Walle <michael@walle.cc>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <1503592308-93913-22-git-send-email-imammedo@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/lm32/cpu.h     | 3 +--
 hw/lm32/lm32_boards.c | 4 ++--
 hw/lm32/milkymist.c   | 2 +-
 target/lm32/helper.c  | 5 -----
 4 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/target/lm32/cpu.h b/target/lm32/cpu.h
index 1d972cb26b..de265b50d1 100644
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
index 8f0c3079d6..eccf0ac5a1 100644
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
index 5cae0f19dd..dffd8797bb 100644
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
index 891da18c30..929cc36c14 100644
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
2.13.5
