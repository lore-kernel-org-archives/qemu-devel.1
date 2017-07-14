Received: from eggs.gnu.org ([2001:4830:134:3::10]:41643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dW12Z-0002ha-SY
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 09:53:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dW12Z-0001yj-5M
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 09:53:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52160)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dW12Y-0001yO-Vz
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 09:53:55 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Fri, 14 Jul 2017 15:52:14 +0200
Message-Id: <1500040339-119465-24-git-send-email-imammedo@redhat.com>
In-Reply-To: <1500040339-119465-1-git-send-email-imammedo@redhat.com>
References: <1500040339-119465-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 23/28] x86: replace cpu_x86_init() with
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
Cc: =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Eduardo Habkost <ehabkost@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

it's just a wrapper, drop it and use cpu_generic_init() directly

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
CC: Paolo Bonzini <pbonzini@redhat.com>
CC: Richard Henderson <rth@twiddle.net>
CC: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.h | 3 +--
 target/i386/cpu.c | 5 -----
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 7a228af..6631e7b 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1326,7 +1326,6 @@ int x86_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 void x86_cpu_exec_enter(CPUState *cpu);
 void x86_cpu_exec_exit(CPUState *cpu);
 
-X86CPU *cpu_x86_init(const char *cpu_model);
 void x86_cpu_list(FILE *f, fprintf_function cpu_fprintf);
 int cpu_x86_support_mca_broadcast(CPUX86State *env);
 
@@ -1506,7 +1505,7 @@ uint64_t cpu_get_tsc(CPUX86State *env);
 
 #define PHYS_ADDR_MASK MAKE_64BIT_MASK(0, TCG_PHYS_ADDR_BITS)
 
-#define cpu_init(cpu_model) CPU(cpu_x86_init(cpu_model))
+#define cpu_init(cpu_model) cpu_generic_init(TYPE_X86_CPU, cpu_model)
 
 #define cpu_signal_handler cpu_x86_signal_handler
 #define cpu_list x86_cpu_list
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 91d3684..1bcf208 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2485,11 +2485,6 @@ static gchar *x86_gdb_arch_name(CPUState *cs)
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
