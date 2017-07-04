Received: from eggs.gnu.org ([2001:4830:134:3::10]:35800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dSLlP-0006zf-0t
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 07:13:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dSLlL-000229-4k
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 07:13:02 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:34439)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dSLlK-00021X-Ua
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 07:12:59 -0400
Received: by mail-wr0-x242.google.com with SMTP id k67so46853801wrc.1
	for <qemu-devel@nongnu.org>; Tue, 04 Jul 2017 04:12:58 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  4 Jul 2017 13:12:13 +0200
Message-Id: <1499166735-39360-21-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1499166735-39360-1-git-send-email-pbonzini@redhat.com>
References: <1499166735-39360-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 20/22] target/i386: add the tcg_enabled() in
 target/i386/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: rth@twiddle.net, thuth@redhat.com, anthony.xu@intel.com, berrange@redhat.com, a.rigo@virtualopensystems.com, yang.zhong@intel.com

From: Yang Zhong <yang.zhong@intel.com>

Add the tcg_enabled() where the x86 target needs to disable
TCG-specific code.

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
	v2: do not touch bpt_helper.c, adjust caller in machine.c [Richard]

 target/i386/cpu.c     |  4 +++-
 target/i386/cpu.h     |  8 +++++++-
 target/i386/helper.c  |  2 +-
 target/i386/machine.c | 10 +++++-----
 4 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 642519a..c571772 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -4040,8 +4040,10 @@ static void x86_cpu_common_class_init(ObjectClass *oc, void *data)
     cc->class_by_name = x86_cpu_class_by_name;
     cc->parse_features = x86_cpu_parse_featurestr;
     cc->has_work = x86_cpu_has_work;
+#ifdef CONFIG_TCG
     cc->do_interrupt = x86_cpu_do_interrupt;
     cc->cpu_exec_interrupt = x86_cpu_exec_interrupt;
+#endif
     cc->dump_state = x86_cpu_dump_state;
     cc->get_crash_info = x86_cpu_get_crash_info;
     cc->set_pc = x86_cpu_set_pc;
@@ -4070,7 +4072,7 @@ static void x86_cpu_common_class_init(ObjectClass *oc, void *data)
     cc->gdb_core_xml_file = "i386-32bit.xml";
     cc->gdb_num_core_regs = 41;
 #endif
-#ifndef CONFIG_USER_ONLY
+#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
     cc->debug_excp_handler = breakpoint_handler;
 #endif
     cc->cpu_exec_enter = x86_cpu_exec_enter;
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 66a363f..cef7dbe 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -52,7 +52,9 @@
 
 #include "exec/cpu-defs.h"
 
+#ifdef CONFIG_TCG
 #include "fpu/softfloat.h"
+#endif
 
 #define R_EAX 0
 #define R_ECX 1
@@ -1597,7 +1599,11 @@ uint32_t cpu_cc_compute_all(CPUX86State *env1, int op);
 
 static inline uint32_t cpu_compute_eflags(CPUX86State *env)
 {
-    return env->eflags | cpu_cc_compute_all(env, CC_OP) | (env->df & DF_MASK);
+    uint32_t eflags = env->eflags;
+    if (tcg_enabled()) {
+        eflags |= cpu_cc_compute_all(env, CC_OP) | (env->df & DF_MASK);
+    }
+    return eflags;
 }
 
 /* NOTE: the translator must set DisasContext.cc_op to CC_OP_EFLAGS
diff --git a/target/i386/helper.c b/target/i386/helper.c
index bcf9b22..f63eb3d 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -990,7 +990,7 @@ void cpu_report_tpr_access(CPUX86State *env, TPRAccess access)
         env->tpr_access_type = access;
 
         cpu_interrupt(cs, CPU_INTERRUPT_TPR);
-    } else {
+    } else if (tcg_enabled()) {
         cpu_restore_state(cs, cs->mem_io_pc);
 
         apic_handle_tpr_access_report(cpu->apic_state, env->eip, access);
diff --git a/target/i386/machine.c b/target/i386/machine.c
index e0417fe..eab3372 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -281,16 +281,16 @@ static int cpu_post_load(void *opaque, int version_id)
         env->fptags[i] = (env->fptag_vmstate >> i) & 1;
     }
     if (tcg_enabled()) {
+        target_ulong dr7;
         update_fp_status(env);
         update_mxcsr_status(env);
-    }
 
-    cpu_breakpoint_remove_all(cs, BP_CPU);
-    cpu_watchpoint_remove_all(cs, BP_CPU);
-    {
+        cpu_breakpoint_remove_all(cs, BP_CPU);
+        cpu_watchpoint_remove_all(cs, BP_CPU);
+
         /* Indicate all breakpoints disabled, as they are, then
            let the helper re-enable them.  */
-        target_ulong dr7 = env->dr[7];
+        dr7 = env->dr[7];
         env->dr[7] = dr7 & ~(DR7_GLOBAL_BP_MASK | DR7_LOCAL_BP_MASK);
         cpu_x86_update_dr7(env, dr7);
     }
-- 
1.8.3.1
