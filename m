Received: from eggs.gnu.org ([2001:4830:134:3::10]:38069)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dtyUz-0007wo-JZ
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 12:02:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dtyUr-0008Li-OS
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 12:02:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47404)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dtyUr-0008LP-Fk
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 12:02:09 -0400
From: David Hildenbrand <david@redhat.com>
Date: Mon, 18 Sep 2017 18:00:10 +0200
Message-Id: <20170918160012.4317-26-david@redhat.com>
In-Reply-To: <20170918160012.4317-1-david@redhat.com>
References: <20170918160012.4317-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 25/27] s390x/tcg: switch to new SIGP
 handling code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, thuth@redhat.com, cohuck@redhat.com, david@redhat.com, borntraeger@de.ibm.com, Alexander Graf <agraf@suse.de>, Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Matthew Rosato <mjrosato@linux.vnet.ibm.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

This effectively enables experimental SMP support. Floating interrupts are
still a mess, so allow it but print a big warning. There also seems
to be a problem with CPU hotplug (after the main loop started).

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c |  4 +---
 target/s390x/helper.h      |  2 +-
 target/s390x/misc_helper.c | 42 ++++++------------------------------------
 target/s390x/translate.c   |  5 +++--
 4 files changed, 11 insertions(+), 42 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 49c1ab29ed..732feb9cff 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -65,9 +65,7 @@ static void s390_init_cpus(MachineState *machine)
         machine->cpu_model = s390_default_cpu_model_name();
     }
     if (tcg_enabled() && max_cpus > 1) {
-        error_report("Number of SMP CPUs requested (%d) exceeds max CPUs "
-                     "supported by TCG (1) on s390x", max_cpus);
-        exit(1);
+        error_report("WARNING: SMP support on s390x is experimental!");
     }
 
     /* initialize possible_cpus */
diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 4b0290774e..a0e4bfb850 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -138,7 +138,7 @@ DEF_HELPER_FLAGS_3(sske, TCG_CALL_NO_RWG, void, env, i64, i64)
 DEF_HELPER_FLAGS_2(rrbe, TCG_CALL_NO_RWG, i32, env, i64)
 DEF_HELPER_4(mvcs, i32, env, i64, i64, i64)
 DEF_HELPER_4(mvcp, i32, env, i64, i64, i64)
-DEF_HELPER_4(sigp, i32, env, i64, i32, i64)
+DEF_HELPER_4(sigp, i32, env, i64, i32, i32)
 DEF_HELPER_FLAGS_2(sacf, TCG_CALL_NO_WG, void, env, i64)
 DEF_HELPER_FLAGS_4(idte, TCG_CALL_NO_RWG, void, env, i64, i64, i32)
 DEF_HELPER_FLAGS_4(ipte, TCG_CALL_NO_RWG, void, env, i64, i64, i32)
diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
index 293fc8428a..1e4d3c8526 100644
--- a/target/s390x/misc_helper.c
+++ b/target/s390x/misc_helper.c
@@ -319,44 +319,14 @@ uint32_t HELPER(stsi)(CPUS390XState *env, uint64_t a0,
 }
 
 uint32_t HELPER(sigp)(CPUS390XState *env, uint64_t order_code, uint32_t r1,
-                      uint64_t cpu_addr)
+                      uint32_t r3)
 {
-    int cc = SIGP_CC_ORDER_CODE_ACCEPTED;
+    int cc;
 
-    HELPER_LOG("%s: %016" PRIx64 " %08x %016" PRIx64 "\n",
-               __func__, order_code, r1, cpu_addr);
-
-    /* Remember: Use "R1 or R1 + 1, whichever is the odd-numbered register"
-       as parameter (input). Status (output) is always R1. */
-
-    switch (order_code & SIGP_ORDER_MASK) {
-    case SIGP_SET_ARCH:
-        /* switch arch */
-        break;
-    case SIGP_SENSE:
-        /* enumerate CPU status */
-        if (cpu_addr) {
-            /* XXX implement when SMP comes */
-            return 3;
-        }
-        env->regs[r1] &= 0xffffffff00000000ULL;
-        cc = 1;
-        break;
-#if !defined(CONFIG_USER_ONLY)
-    case SIGP_RESTART:
-        qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
-        cpu_loop_exit(CPU(s390_env_get_cpu(env)));
-        break;
-    case SIGP_STOP:
-        qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
-        cpu_loop_exit(CPU(s390_env_get_cpu(env)));
-        break;
-#endif
-    default:
-        /* unknown sigp */
-        fprintf(stderr, "XXX unknown sigp: 0x%" PRIx64 "\n", order_code);
-        cc = SIGP_CC_NOT_OPERATIONAL;
-    }
+    /* TODO: needed to inject interrupts  - push further down */
+    qemu_mutex_lock_iothread();
+    cc = handle_sigp(env, order_code & SIGP_ORDER_MASK, r1, r3);
+    qemu_mutex_unlock_iothread();
 
     return cc;
 }
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 5abd34fb34..abf2feb7aa 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -3658,11 +3658,12 @@ static ExitStatus op_servc(DisasContext *s, DisasOps *o)
 static ExitStatus op_sigp(DisasContext *s, DisasOps *o)
 {
     TCGv_i32 r1 = tcg_const_i32(get_field(s->fields, r1));
+    TCGv_i32 r3 = tcg_const_i32(get_field(s->fields, r3));
     check_privileged(s);
-    potential_page_fault(s);
-    gen_helper_sigp(cc_op, cpu_env, o->in2, r1, o->in1);
+    gen_helper_sigp(cc_op, cpu_env, o->in2, r1, r3);
     set_cc_static(s);
     tcg_temp_free_i32(r1);
+    tcg_temp_free_i32(r3);
     return NO_EXIT;
 }
 #endif
-- 
2.13.5
