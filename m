Received: from eggs.gnu.org ([2001:4830:134:3::10]:42303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gUsMC-0001Pe-Af
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 07:02:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gUsM6-0006SP-At
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 07:02:16 -0500
Received: from mail.ispras.ru ([83.149.199.45]:60512)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gUsM5-0006FU-UE
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 07:02:10 -0500
From: Mikhail Abakumov <mikhail.abakumov@ispras.ru>
Date: Thu, 06 Dec 2018 15:01:54 +0300
Message-ID: <154409771441.5432.1285340295550689902.stgit@Misha-PC.lan02.inno>
In-Reply-To: <154409751316.5432.3325938832238028060.stgit@Misha-PC.lan02.inno>
References: <154409751316.5432.3325938832238028060.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v3 35/39] windbg: implement kd_api_read_msr and
 kd_api_write_msr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: sw@weilnetz.de, lprosek@redhat.com, dovgaluk@ispras.ru, rkagan@virtuozzo.com, pbonzini@redhat.com, den@openvz.org

Add sub functions for helper_wrmsr and helper_rdmsr: cpu_x86_write_msr
and cpu_x86_read_msr.

Signed-off-by: Mikhail Abakumov <mikhail.abakumov@ispras.ru>
Signed-off-by: Pavel Dovgalyuk <dovgaluk@ispras.ru>
---
 include/exec/windbgstub-utils.h |    2 ++
 target/i386/cpu.h               |    5 +++++
 target/i386/misc_helper.c       |   39 ++++++++++++++++++++++++++++-----------
 target/i386/windbgstub.c        |   30 ++++++++++++++++++++++++++++++
 windbgstub.c                    |    8 ++++++++
 5 files changed, 73 insertions(+), 11 deletions(-)

diff --git a/include/exec/windbgstub-utils.h b/include/exec/windbgstub-utils.h
index adfc9936f3..74e3b9a0da 100644
--- a/include/exec/windbgstub-utils.h
+++ b/include/exec/windbgstub-utils.h
@@ -81,6 +81,8 @@ void kd_api_write_io_space(CPUState *cs, PacketData *pd);
 void kd_api_read_physical_memory(CPUState *cs, PacketData *pd);
 void kd_api_write_physical_memory(CPUState *cs, PacketData *pd);
 void kd_api_get_version(CPUState *cs, PacketData *pd);
+void kd_api_read_msr(CPUState *cs, PacketData *pd);
+void kd_api_write_msr(CPUState *cs, PacketData *pd);
 void kd_api_clear_all_internal_breakpoints(CPUState *cs, PacketData *pd);
 void kd_api_get_context_ex(CPUState *cs, PacketData *pd);
 void kd_api_set_context_ex(CPUState *cs, PacketData *pd);
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 9c52d0cbeb..0f451d81bf 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1680,6 +1680,11 @@ void cpu_x86_update_cr3(CPUX86State *env, target_ulong new_cr3);
 void cpu_x86_update_cr4(CPUX86State *env, uint32_t new_cr4);
 void cpu_x86_update_dr7(CPUX86State *env, uint32_t new_dr7);
 
+#ifndef CONFIG_USER_ONLY
+void cpu_x86_write_msr(CPUX86State *env, uint64_t val);
+uint64_t cpu_x86_read_msr(CPUX86State *env);
+#endif
+
 /* hw/pc.c */
 uint64_t cpu_get_tsc(CPUX86State *env);
 
diff --git a/target/i386/misc_helper.c b/target/i386/misc_helper.c
index 6ae67cf885..1f9adb246d 100644
--- a/target/i386/misc_helper.c
+++ b/target/i386/misc_helper.c
@@ -228,15 +228,8 @@ void helper_rdmsr(CPUX86State *env)
 {
 }
 #else
-void helper_wrmsr(CPUX86State *env)
+void cpu_x86_write_msr(CPUX86State *env, uint64_t val)
 {
-    uint64_t val;
-
-    cpu_svm_check_intercept_param(env, SVM_EXIT_MSR, 1, GETPC());
-
-    val = ((uint32_t)env->regs[R_EAX]) |
-        ((uint64_t)((uint32_t)env->regs[R_EDX]) << 32);
-
     switch ((uint32_t)env->regs[R_ECX]) {
     case MSR_IA32_SYSENTER_CS:
         env->sysenter_cs = val & 0xffff;
@@ -386,11 +379,9 @@ void helper_wrmsr(CPUX86State *env)
         /* XXX: exception? */
         break;
     }
-
-    windbg_try_load();
 }
 
-void helper_rdmsr(CPUX86State *env)
+uint64_t cpu_x86_read_msr(CPUX86State *env)
 {
     uint64_t val;
 
@@ -537,6 +528,32 @@ void helper_rdmsr(CPUX86State *env)
         val = 0;
         break;
     }
+
+    return val;
+}
+
+void helper_wrmsr(CPUX86State *env)
+{
+    uint64_t val;
+
+    cpu_svm_check_intercept_param(env, SVM_EXIT_MSR, 1, GETPC());
+
+    val = ((uint32_t)env->regs[R_EAX]) |
+        ((uint64_t)((uint32_t)env->regs[R_EDX]) << 32);
+
+    cpu_x86_write_msr(env, val);
+
+    windbg_try_load();
+}
+
+void helper_rdmsr(CPUX86State *env)
+{
+    uint64_t val;
+
+    cpu_svm_check_intercept_param(env, SVM_EXIT_MSR, 0, GETPC());
+
+    val = cpu_x86_read_msr(env);
+
     env->regs[R_EAX] = (uint32_t)(val);
     env->regs[R_EDX] = (uint32_t)(val >> 32);
 }
diff --git a/target/i386/windbgstub.c b/target/i386/windbgstub.c
index 9e84027f19..ccc7bc3035 100644
--- a/target/i386/windbgstub.c
+++ b/target/i386/windbgstub.c
@@ -1083,6 +1083,36 @@ void kd_api_set_context_ex(CPUState *cs, PacketData *pd)
     stl_p(&ctx->BytesCopied, len);
 }
 
+void kd_api_read_msr(CPUState *cs, PacketData *pd)
+{
+#ifndef CONFIG_USER_ONLY
+    DBGKD_READ_WRITE_MSR *m64c = &pd->m64.u.ReadWriteMsr;
+    X86CPU *cpu = X86_CPU(cs);
+    CPUX86State *env = &cpu->env;
+    uint64_t val = cpu_x86_read_msr(env);
+
+    stq_p(&val, val);
+
+    m64c->DataValueLow = val;
+    m64c->DataValueHigh = val >> 32;
+    pd->m64.ReturnStatus = STATUS_SUCCESS;
+#endif /* !CONFIG_USER_ONLY */
+}
+
+void kd_api_write_msr(CPUState *cs, PacketData *pd)
+{
+#ifndef CONFIG_USER_ONLY
+    DBGKD_READ_WRITE_MSR *m64c = &pd->m64.u.ReadWriteMsr;
+    X86CPU *cpu = X86_CPU(cs);
+    CPUX86State *env = &cpu->env;
+    uint64_t val = m64c->DataValueLow | ((uint64_t) m64c->DataValueHigh) << 32;
+
+    cpu_x86_write_msr(env, ldq_p(&val));
+
+    pd->m64.ReturnStatus = STATUS_SUCCESS;
+#endif /* !CONFIG_USER_ONLY */
+}
+
 void kd_api_get_version(CPUState *cs, PacketData *pd)
 {
     DBGKD_GET_VERSION64 *kdver = (DBGKD_GET_VERSION64 *) (PTR(pd->m64) + 0x10);
diff --git a/windbgstub.c b/windbgstub.c
index 366856bc81..109a52b663 100644
--- a/windbgstub.c
+++ b/windbgstub.c
@@ -216,6 +216,14 @@ static void windbg_process_manipulate_packet(WindbgState *state)
         kd_api_get_version(cs, data);
         break;
 
+    case DbgKdReadMachineSpecificRegister:
+        kd_api_read_msr(cs, data);
+        break;
+
+    case DbgKdWriteMachineSpecificRegister:
+        kd_api_write_msr(cs, data);
+        break;
+
     case DbgKdClearAllInternalBreakpointsApi:
         kd_api_clear_all_internal_breakpoints(cs, data);
         return;
