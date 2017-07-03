Received: from eggs.gnu.org ([2001:4830:134:3::10]:51866)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dS4Kd-00015R-Dv
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 12:36:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dS4KZ-0008G1-Do
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 12:36:15 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:32835)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dS4KZ-0008FF-3T
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 12:36:11 -0400
Received: by mail-wm0-x242.google.com with SMTP id j85so21516214wmj.0
	for <qemu-devel@nongnu.org>; Mon, 03 Jul 2017 09:36:10 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  3 Jul 2017 18:34:51 +0200
Message-Id: <1499099693-22903-21-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1499099693-22903-1-git-send-email-pbonzini@redhat.com>
References: <1499099693-22903-1-git-send-email-pbonzini@redhat.com>
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
 target/i386/bpt_helper.c | 32 +++++++++++++++++++++++---------
 target/i386/cpu.c        |  4 +++-
 target/i386/cpu.h        |  8 +++++++-
 target/i386/machine.c    |  5 +++--
 4 files changed, 36 insertions(+), 13 deletions(-)

diff --git a/target/i386/bpt_helper.c b/target/i386/bpt_helper.c
index b3efdc7..e0fa54c 100644
--- a/target/i386/bpt_helper.c
+++ b/target/i386/bpt_helper.c
@@ -215,10 +215,12 @@ void breakpoint_handler(CPUState *cs)
     if (cs->watchpoint_hit) {
         if (cs->watchpoint_hit->flags & BP_CPU) {
             cs->watchpoint_hit = NULL;
-            if (check_hw_breakpoints(env, false)) {
-                raise_exception(env, EXCP01_DB);
-            } else {
-                cpu_loop_exit_noexc(cs);
+            if (tcg_enabled()) {
+                if (check_hw_breakpoints(env, false)) {
+                    raise_exception(env, EXCP01_DB);
+                } else {
+                    cpu_loop_exit_noexc(cs);
+                }
             }
         }
     } else {
@@ -226,7 +228,9 @@ void breakpoint_handler(CPUState *cs)
             if (bp->pc == env->eip) {
                 if (bp->flags & BP_CPU) {
                     check_hw_breakpoints(env, true);
-                    raise_exception(env, EXCP01_DB);
+                    if (tcg_enabled()) {
+                        raise_exception(env, EXCP01_DB);
+                    }
                 }
                 break;
             }
@@ -241,7 +245,9 @@ void helper_single_step(CPUX86State *env)
     check_hw_breakpoints(env, true);
     env->dr[6] |= DR6_BS;
 #endif
-    raise_exception(env, EXCP01_DB);
+    if (tcg_enabled()) {
+        raise_exception(env, EXCP01_DB);
+    }
 }
 
 void helper_rechecking_single_step(CPUX86State *env)
@@ -282,7 +288,9 @@ void helper_set_dr(CPUX86State *env, int reg, target_ulong t0)
         cpu_x86_update_dr7(env, t0);
         return;
     }
-    raise_exception_err_ra(env, EXCP06_ILLOP, 0, GETPC());
+    if (tcg_enabled()) {
+        raise_exception_err_ra(env, EXCP06_ILLOP, 0, GETPC());
+    }
 #endif
 }
 
@@ -304,7 +312,11 @@ target_ulong helper_get_dr(CPUX86State *env, int reg)
             return env->dr[7];
         }
     }
-    raise_exception_err_ra(env, EXCP06_ILLOP, 0, GETPC());
+    if (tcg_enabled()) {
+        raise_exception_err_ra(env, EXCP06_ILLOP, 0, GETPC());
+    } else {
+        return 0;
+    }
 }
 
 /* Check if Port I/O is trapped by a breakpoint.  */
@@ -329,7 +341,9 @@ void helper_bpt_io(CPUX86State *env, uint32_t port,
     if (hit) {
         env->dr[6] = (env->dr[6] & ~0xf) | hit;
         env->eip = next_eip;
-        raise_exception(env, EXCP01_DB);
+        if (tcg_enabled()) {
+            raise_exception(env, EXCP01_DB);
+        }
     }
 #endif
 }
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
index 67a6091..27732ad 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -52,7 +52,9 @@
 
 #include "exec/cpu-defs.h"
 
+#ifdef CONFIG_TCG
 #include "fpu/softfloat.h"
+#endif
 
 #define R_EAX 0
 #define R_ECX 1
@@ -1598,7 +1600,11 @@ void update_fp_status(CPUX86State *env);
 
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
diff --git a/target/i386/machine.c b/target/i386/machine.c
index 53587ae..b78b36c 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -280,8 +280,9 @@ static int cpu_post_load(void *opaque, int version_id)
     for(i = 0; i < 8; i++) {
         env->fptags[i] = (env->fptag_vmstate >> i) & 1;
     }
-    update_fp_status(env);
-
+    if (tcg_enabled()) {
+        update_fp_status(env);
+    }
     cpu_breakpoint_remove_all(cs, BP_CPU);
     cpu_watchpoint_remove_all(cs, BP_CPU);
     {
-- 
1.8.3.1
