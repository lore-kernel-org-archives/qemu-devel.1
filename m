Received: from eggs.gnu.org ([2001:4830:134:3::10]:41029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dnnUT-0008Qv-Sz
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:04:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dnnUS-00038W-KF
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:04:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51690)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dnnUS-00038L-EB
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:04:12 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri,  1 Sep 2017 12:03:08 -0300
Message-Id: <20170901150317.10380-21-ehabkost@redhat.com>
In-Reply-To: <20170901150317.10380-1-ehabkost@redhat.com>
References: <20170901150317.10380-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 20/29] tricore: replace cpu_tricore_init() with
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
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <1503592308-93913-17-git-send-email-imammedo@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/tricore/cpu.h           | 4 +---
 hw/tricore/tricore_testboard.c | 2 +-
 target/tricore/helper.c        | 5 -----
 3 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/target/tricore/cpu.h b/target/tricore/cpu.h
index a3493a123c..bc53c40774 100644
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
index 6c574231d5..3fcd8bb70e 100644
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
index 3118905eca..378c2a4a76 100644
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
2.13.5
