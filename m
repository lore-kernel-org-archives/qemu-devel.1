Received: from eggs.gnu.org ([2001:4830:134:3::10]:60781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dieDT-0004BV-7r
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 06:09:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dieDR-0000me-KO
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 06:09:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54906)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dieDR-0000lG-Bn
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 06:09:21 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 75BC4356C9
	for <qemu-devel@nongnu.org>; Fri, 18 Aug 2017 10:09:20 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
	(dell-r430-03.lab.eng.brq.redhat.com [10.34.112.60])
	by smtp.corp.redhat.com (Postfix) with ESMTP id EF5CF5D743
	for <qemu-devel@nongnu.org>; Fri, 18 Aug 2017 10:09:19 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
Date: Fri, 18 Aug 2017 12:08:49 +0200
Message-Id: <1503050939-227939-18-git-send-email-imammedo@redhat.com>
In-Reply-To: <1503050939-227939-1-git-send-email-imammedo@redhat.com>
References: <1503050939-227939-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.11 17/27] tricore: replace
 cpu_tricore_init() with cpu_generic_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

it's just a wrapper, drop it and use cpu_generic_init() directly

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
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
index 6c57423..3fcd8bb 100644
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
