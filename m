Received: from eggs.gnu.org ([2001:4830:134:3::10]:60815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dieDU-0004Du-RV
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 06:09:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dieDT-0000oD-Ue
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 06:09:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54952)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dieDT-0000nY-OQ
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 06:09:23 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D73DC3680F
	for <qemu-devel@nongnu.org>; Fri, 18 Aug 2017 10:09:22 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
	(dell-r430-03.lab.eng.brq.redhat.com [10.34.112.60])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5D4CF66D62
	for <qemu-devel@nongnu.org>; Fri, 18 Aug 2017 10:09:22 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
Date: Fri, 18 Aug 2017 12:08:52 +0200
Message-Id: <1503050939-227939-21-git-send-email-imammedo@redhat.com>
In-Reply-To: <1503050939-227939-1-git-send-email-imammedo@redhat.com>
References: <1503050939-227939-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.11 20/27] cris: replace cpu_cris_init()
 with cpu_generic_init()
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
 target/cris/cpu.h    | 3 +--
 hw/cris/axis_dev88.c | 2 +-
 target/cris/cpu.c    | 5 -----
 3 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/target/cris/cpu.h b/target/cris/cpu.h
index 920e1c3..5d822de 100644
--- a/target/cris/cpu.h
+++ b/target/cris/cpu.h
@@ -216,7 +216,6 @@ int crisv10_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
 int cris_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
 int cris_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 
-CRISCPU *cpu_cris_init(const char *cpu_model);
 /* you can call this signal handler from your SIGBUS and SIGSEGV
    signal handlers to inform the virtual CPU of exceptions. non zero
    is returned if the signal was handled by the virtual CPU.  */
@@ -268,7 +267,7 @@ enum {
 #define TARGET_PHYS_ADDR_SPACE_BITS 32
 #define TARGET_VIRT_ADDR_SPACE_BITS 32
 
-#define cpu_init(cpu_model) CPU(cpu_cris_init(cpu_model))
+#define cpu_init(cpu_model) cpu_generic_init(TYPE_CRIS_CPU, cpu_model)
 
 #define cpu_signal_handler cpu_cris_signal_handler
 
diff --git a/hw/cris/axis_dev88.c b/hw/cris/axis_dev88.c
index 80674f6..5eb552b 100644
--- a/hw/cris/axis_dev88.c
+++ b/hw/cris/axis_dev88.c
@@ -271,7 +271,7 @@ void axisdev88_init(MachineState *machine)
     if (cpu_model == NULL) {
         cpu_model = "crisv32";
     }
-    cpu = cpu_cris_init(cpu_model);
+    cpu = CRIS_CPU(cpu_generic_init(TYPE_CRIS_CPU, cpu_model));
     env = &cpu->env;
 
     /* allocate RAM */
diff --git a/target/cris/cpu.c b/target/cris/cpu.c
index 5f766f0..ceebfed 100644
--- a/target/cris/cpu.c
+++ b/target/cris/cpu.c
@@ -89,11 +89,6 @@ static ObjectClass *cris_cpu_class_by_name(const char *cpu_model)
     return oc;
 }
 
-CRISCPU *cpu_cris_init(const char *cpu_model)
-{
-    return CRIS_CPU(cpu_generic_init(TYPE_CRIS_CPU, cpu_model));
-}
-
 /* Sort alphabetically by VR. */
 static gint cris_cpu_list_compare(gconstpointer a, gconstpointer b)
 {
-- 
2.7.4
