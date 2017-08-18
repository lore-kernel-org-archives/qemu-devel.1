Received: from eggs.gnu.org ([2001:4830:134:3::10]:60831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dieDV-0004FO-PX
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 06:09:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dieDU-0000oj-PL
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 06:09:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:28835)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dieDU-0000oC-JA
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 06:09:24 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A831B5D5F4
	for <qemu-devel@nongnu.org>; Fri, 18 Aug 2017 10:09:23 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
	(dell-r430-03.lab.eng.brq.redhat.com [10.34.112.60])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2CD6F5D743
	for <qemu-devel@nongnu.org>; Fri, 18 Aug 2017 10:09:23 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
Date: Fri, 18 Aug 2017 12:08:53 +0200
Message-Id: <1503050939-227939-22-git-send-email-imammedo@redhat.com>
In-Reply-To: <1503050939-227939-1-git-send-email-imammedo@redhat.com>
References: <1503050939-227939-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.11 21/27] x86: replace cpu_x86_init()
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
 target/i386/cpu.h | 3 +--
 target/i386/cpu.c | 5 -----
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 0518673..525d35d 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1327,7 +1327,6 @@ int x86_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 void x86_cpu_exec_enter(CPUState *cpu);
 void x86_cpu_exec_exit(CPUState *cpu);
 
-X86CPU *cpu_x86_init(const char *cpu_model);
 void x86_cpu_list(FILE *f, fprintf_function cpu_fprintf);
 int cpu_x86_support_mca_broadcast(CPUX86State *env);
 
@@ -1507,7 +1506,7 @@ uint64_t cpu_get_tsc(CPUX86State *env);
 
 #define PHYS_ADDR_MASK MAKE_64BIT_MASK(0, TCG_PHYS_ADDR_BITS)
 
-#define cpu_init(cpu_model) CPU(cpu_x86_init(cpu_model))
+#define cpu_init(cpu_model) cpu_generic_init(TYPE_X86_CPU, cpu_model)
 
 #define cpu_signal_handler cpu_x86_signal_handler
 #define cpu_list x86_cpu_list
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index ac60c1a..217aade 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2522,11 +2522,6 @@ static gchar *x86_gdb_arch_name(CPUState *cs)
 #endif
 }
 
-X86CPU *cpu_x86_init(const char *cpu_model)
-{
-    return X86_CPU(cpu_generic_init(TYPE_X86_CPU, cpu_model));
-}
-
 static void x86_cpu_cpudef_class_init(ObjectClass *oc, void *data)
 {
     X86CPUDefinition *cpudef = data;
-- 
2.7.4
