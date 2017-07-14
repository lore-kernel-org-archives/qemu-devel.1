Received: from eggs.gnu.org ([2001:4830:134:3::10]:41583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dW12V-0002Xy-QJ
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 09:53:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dW12R-0001tF-U3
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 09:53:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50352)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dW12R-0001sN-NA
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 09:53:47 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Fri, 14 Jul 2017 15:52:10 +0200
Message-Id: <1500040339-119465-20-git-send-email-imammedo@redhat.com>
In-Reply-To: <1500040339-119465-1-git-send-email-imammedo@redhat.com>
References: <1500040339-119465-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 19/28] tricore: replace cpu_tricore_init() with
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
Cc: =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Eduardo Habkost <ehabkost@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

it's just a wrapper, drop it and use cpu_generic_init() directly

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
CC: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
---
 target/tricore/cpu.h           | 4 +---
 hw/tricore/tricore_testboard.c | 2 +-
 target/tricore/helper.c        | 5 -----
 3 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/target/tricore/cpu.h b/target/tricore/cpu.h
index a3493a1..bc53c40 100644
--- a/target/tricore/cpu.h
+++ b/target/tricore/cpu.h
@@ -411,9 +411,7 @@ static inline void cpu_get_tb_cpu_state(CPUTriCoreState *env, target_ulong *pc,
     *flags = 0;
 }
 
-TriCoreCPU *cpu_tricore_init(const char *cpu_model);
-
-#define cpu_init(cpu_model) CPU(cpu_tricore_init(cpu_model))
+#define cpu_init(cpu_model) cpu_generic_init(TYPE_TRICORE_CPU, cpu_model)
 
 
 /* helpers.c */
diff --git a/hw/tricore/tricore_testboard.c b/hw/tricore/tricore_testboard.c
index 8910bf0..599c508 100644
--- a/hw/tricore/tricore_testboard.c
+++ b/hw/tricore/tricore_testboard.c
@@ -74,7 +74,7 @@ static void tricore_testboard_init(MachineState *machine, int board_id)
     if (!machine->cpu_model) {
         machine->cpu_model = "tc1796";
     }
-    cpu = cpu_tricore_init(machine->cpu_model);
+    cpu = TRICORE_CPU(cpu_generic_init(TYPE_TRICORE_CPU, machine->cpu_model));
     if (!cpu) {
         error_report("Unable to find CPU definition");
         exit(1);
diff --git a/target/tricore/helper.c b/target/tricore/helper.c
index 3118905..378c2a4 100644
--- a/target/tricore/helper.c
+++ b/target/tricore/helper.c
@@ -78,11 +78,6 @@ int cpu_tricore_handle_mmu_fault(CPUState *cs, target_ulong address,
     return ret;
 }
 
-TriCoreCPU *cpu_tricore_init(const char *cpu_model)
-{
-    return TRICORE_CPU(cpu_generic_init(TYPE_TRICORE_CPU, cpu_model));
-}
-
 static void tricore_cpu_list_entry(gpointer data, gpointer user_data)
 {
     ObjectClass *oc = data;
-- 
2.7.4
