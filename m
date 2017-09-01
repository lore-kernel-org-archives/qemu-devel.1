Received: from eggs.gnu.org ([2001:4830:134:3::10]:41151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dnnUf-00007u-36
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:04:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dnnUa-0003BB-FY
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:04:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48374)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dnnUa-0003Ai-9T
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:04:20 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri,  1 Sep 2017 12:03:12 -0300
Message-Id: <20170901150317.10380-25-ehabkost@redhat.com>
In-Reply-To: <20170901150317.10380-1-ehabkost@redhat.com>
References: <20170901150317.10380-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 24/29] x86: replace cpu_x86_init() with
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
Message-Id: <1503592308-93913-21-git-send-email-imammedo@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.h | 3 +--
 target/i386/cpu.c | 5 -----
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 051867399b..525d35d836 100644
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
index 6617e01a72..f81576d11d 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2686,11 +2686,6 @@ static gchar *x86_gdb_arch_name(CPUState *cs)
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
2.13.5
