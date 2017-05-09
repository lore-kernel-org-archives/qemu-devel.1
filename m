Received: from eggs.gnu.org ([2001:4830:134:3::10]:49116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d82cS-0007Lo-Ph
	for qemu-devel@nongnu.org; Tue, 09 May 2017 06:43:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d82cR-0000ET-Jr
	for qemu-devel@nongnu.org; Tue, 09 May 2017 06:43:52 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:36414)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1d82cR-0000EH-DP
	for qemu-devel@nongnu.org; Tue, 09 May 2017 06:43:51 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Tue,  9 May 2017 12:43:36 +0200
Message-Id: <20170509104336.11676-1-aurelien@aurel32.net>
Subject: [Qemu-devel] [PATCH RFC] target/s390x: improve SIGP to add SMP
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>

This patch adds *very rough* SMP support to the s390x target, and make
it possible to use MTTCG, when used with the various atomic patches
posted on the mailing list. I haven't done any advanced test, so there
is certainly more atomic issues to fix.

Anyway this patch is nothing more than a way to determine what needs to
be implemented in the SIGNAL PROCESSOR instruction to add SMP support,
and a basis for discussion about how to implement things. It should be
rewritten from scratch before reaching in an acceptable state.

It has been wrote mostly looking at the KVM code. Unfortunately I don't
think it's easy to share code between TCG and KVM because part of KVM
SIGP support is implemented on the host kernel side. Given I don't have
a lot of experience with MTTCG, my main question at this point is how to
determine when it is possible to directly interact with another CPU and
when run_on_cpu should be used instead. Any help or comments are
welcome.

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 target/s390x/cpu.h         |  2 ++
 target/s390x/misc_helper.c | 64 ++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 61 insertions(+), 5 deletions(-)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index fa244f1238..a4651de0d6 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -1057,6 +1057,7 @@ struct sysib_322 {
 #define SIGP_SET_PREFIX        0x0d
 #define SIGP_STORE_STATUS_ADDR 0x0e
 #define SIGP_SET_ARCH          0x12
+#define SIGP_SENSE_RUNNING     0x15
 #define SIGP_STORE_ADTL_STATUS 0x17
 
 /* SIGP condition codes */
@@ -1067,6 +1068,7 @@ struct sysib_322 {
 
 /* SIGP status bits */
 #define SIGP_STAT_EQUIPMENT_CHECK   0x80000000UL
+#define SIGP_STAT_NOT_RUNNING       0x00000400UL
 #define SIGP_STAT_INCORRECT_STATE   0x00000200UL
 #define SIGP_STAT_INVALID_PARAMETER 0x00000100UL
 #define SIGP_STAT_EXT_CALL_PENDING  0x00000080UL
diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
index 9178a3987f..5285c82783 100644
--- a/target/s390x/misc_helper.c
+++ b/target/s390x/misc_helper.c
@@ -516,36 +516,90 @@ uint32_t HELPER(sigp)(CPUS390XState *env, uint64_t order_code, uint32_t r1,
 
     /* Remember: Use "R1 or R1 + 1, whichever is the odd-numbered register"
        as parameter (input). Status (output) is always R1. */
+    uint64_t param = (r1 % 2) ? env->regs[r1] : env->regs[r1 + 1];
+
+    S390CPU *dst_cpu = s390_cpu_addr2state(cpu_addr);
+
+    if (dst_cpu == NULL) {
+        return SIGP_STAT_INVALID_PARAMETER;
+    }
+
+    qemu_mutex_lock_iothread();
 
     switch (order_code & SIGP_ORDER_MASK) {
     case SIGP_SET_ARCH:
+        cc = SIGP_CC_ORDER_CODE_ACCEPTED;
         /* switch arch */
         break;
     case SIGP_SENSE:
         /* enumerate CPU status */
         if (cpu_addr) {
             /* XXX implement when SMP comes */
-            return 3;
+            cc = SIGP_CC_NOT_OPERATIONAL;
+        } else {
+            env->regs[r1] &= 0xffffffff00000000ULL;
+            cc = SIGP_CC_STATUS_STORED;
         }
-        env->regs[r1] &= 0xffffffff00000000ULL;
-        cc = 1;
+        break;
+    case SIGP_INITIAL_CPU_RESET:
+        S390_CPU_GET_CLASS(dst_cpu)->initial_cpu_reset(CPU(dst_cpu));
+        cc = SIGP_CC_ORDER_CODE_ACCEPTED;
         break;
 #if !defined(CONFIG_USER_ONLY)
     case SIGP_RESTART:
+        /* the restart irq has to be delivered prior to any other pending irq */
+        do_restart_interrupt(&dst_cpu->env);
+        s390_cpu_set_state(CPU_STATE_OPERATING, dst_cpu);
+        qemu_cpu_kick(CPU(dst_cpu));
+        cc = SIGP_CC_ORDER_CODE_ACCEPTED;
+#if 0
         qemu_system_reset_request();
         cpu_loop_exit(CPU(s390_env_get_cpu(env)));
+#endif
         break;
     case SIGP_STOP:
-        qemu_system_shutdown_request();
-        cpu_loop_exit(CPU(s390_env_get_cpu(env)));
+        /* FIXME doesn't work */
+        if (s390_cpu_halt(dst_cpu) == 0) {
+            qemu_system_shutdown_request();
+        }
+        cpu_loop_exit(CPU(dst_cpu));
+        cc = SIGP_CC_ORDER_CODE_ACCEPTED;
+        break;
+    case SIGP_SET_PREFIX:
+        {
+            uint32_t addr = param & 0x7fffe000u;
+            if (!address_space_access_valid(&address_space_memory, addr,
+                                           sizeof(struct LowCore), false)) {
+                cc = SIGP_STAT_INVALID_PARAMETER;
+            } else if (s390_cpu_get_state(dst_cpu) != CPU_STATE_STOPPED) {
+                cc = SIGP_STAT_INCORRECT_STATE;
+            } else {
+                dst_cpu->env.psa = addr;
+                tlb_flush_page(CPU(dst_cpu), 0);
+                tlb_flush_page(CPU(dst_cpu), TARGET_PAGE_SIZE);
+                cc = SIGP_CC_ORDER_CODE_ACCEPTED;
+            }
+        }
         break;
 #endif
+    case SIGP_SENSE_RUNNING:
+        if (s390_cpu_get_state(dst_cpu) == CPU_STATE_OPERATING) {
+            cc = SIGP_CC_ORDER_CODE_ACCEPTED;
+        } else {
+            cc = SIGP_STAT_NOT_RUNNING;
+        }
+        break;
+    case SIGP_EXTERNAL_CALL:
+        cpu_inject_ext(dst_cpu, 0x1202, env->cpu_num, 0);
+        cc = SIGP_CC_ORDER_CODE_ACCEPTED;
+        break;
     default:
         /* unknown sigp */
         fprintf(stderr, "XXX unknown sigp: 0x%" PRIx64 "\n", order_code);
         cc = SIGP_CC_NOT_OPERATIONAL;
     }
 
+    qemu_mutex_unlock_iothread();
     return cc;
 }
 #endif
-- 
2.11.0
