Received: from eggs.gnu.org ([2001:4830:134:3::10]:43061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1g8RaT-0007ap-06
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 11:00:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1g8RaM-0001oL-TP
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 11:00:16 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Fri,  5 Oct 2018 17:00:01 +0200
Message-Id: <1538751601-7433-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] target/s390x/excp_helper: Remove DPRINTF()
 macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org

Debug macros that are disabled by default should be avoided (since the
code bit-rots quite easily). Thus turn these debug prints into proper
qemu_log_mask(CPU_LOG_xxx, ...) statements instead. The DPRINTF statements
in do_[ext|io|mchk]_interrupt can even be removed completely since we can
log the information in a central place, s390_cpu_do_interrupt, instead.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/s390x/excp_helper.c | 48 +++++++++++-----------------------------------
 1 file changed, 11 insertions(+), 37 deletions(-)

diff --git a/target/s390x/excp_helper.c b/target/s390x/excp_helper.c
index f0ce60c..b803e04 100644
--- a/target/s390x/excp_helper.c
+++ b/target/s390x/excp_helper.c
@@ -31,23 +31,6 @@
 #include "hw/s390x/s390_flic.h"
 #endif
 
-/* #define DEBUG_S390 */
-/* #define DEBUG_S390_STDOUT */
-
-#ifdef DEBUG_S390
-#ifdef DEBUG_S390_STDOUT
-#define DPRINTF(fmt, ...) \
-    do { fprintf(stderr, fmt, ## __VA_ARGS__); \
-         if (qemu_log_separate()) { qemu_log(fmt, ##__VA_ARGS__); } } while (0)
-#else
-#define DPRINTF(fmt, ...) \
-    do { qemu_log(fmt, ## __VA_ARGS__); } while (0)
-#endif
-#else
-#define DPRINTF(fmt, ...) \
-    do { } while (0)
-#endif
-
 #if defined(CONFIG_USER_ONLY)
 
 void s390_cpu_do_interrupt(CPUState *cs)
@@ -92,8 +75,8 @@ int s390_cpu_handle_mmu_fault(CPUState *cs, vaddr orig_vaddr, int size,
     uint64_t asc;
     int prot;
 
-    DPRINTF("%s: address 0x%" VADDR_PRIx " rw %d mmu_idx %d\n",
-            __func__, orig_vaddr, rw, mmu_idx);
+    qemu_log_mask(CPU_LOG_MMU, "%s: addr 0x%" VADDR_PRIx " rw %d mmu_idx %d\n",
+                  __func__, orig_vaddr, rw, mmu_idx);
 
     vaddr = orig_vaddr;
 
@@ -122,8 +105,9 @@ int s390_cpu_handle_mmu_fault(CPUState *cs, vaddr orig_vaddr, int size,
     if (!address_space_access_valid(&address_space_memory, raddr,
                                     TARGET_PAGE_SIZE, rw,
                                     MEMTXATTRS_UNSPECIFIED)) {
-        DPRINTF("%s: raddr %" PRIx64 " > ram_size %" PRIx64 "\n", __func__,
-                (uint64_t)raddr, (uint64_t)ram_size);
+        qemu_log_mask(CPU_LOG_MMU,
+                      "%s: raddr %" PRIx64 " > ram_size %" PRIx64 "\n",
+                      __func__, (uint64_t)raddr, (uint64_t)ram_size);
         trigger_pgm_exception(env, PGM_ADDRESSING, ILEN_AUTO);
         return 1;
     }
@@ -181,8 +165,10 @@ static void do_program_interrupt(CPUS390XState *env)
         break;
     }
 
-    qemu_log_mask(CPU_LOG_INT, "%s: code=0x%x ilen=%d\n",
-                  __func__, env->int_pgm_code, ilen);
+    qemu_log_mask(CPU_LOG_INT,
+                  "%s: code=0x%x ilen=%d psw: %" PRIx64 " %" PRIx64 "\n",
+                  __func__, env->int_pgm_code, ilen, env->psw.mask,
+                  env->psw.addr);
 
     lowcore = cpu_map_lowcore(env);
 
@@ -204,10 +190,6 @@ static void do_program_interrupt(CPUS390XState *env)
 
     cpu_unmap_lowcore(lowcore);
 
-    DPRINTF("%s: %x %x %" PRIx64 " %" PRIx64 "\n", __func__,
-            env->int_pgm_code, ilen, env->psw.mask,
-            env->psw.addr);
-
     load_psw(env, mask, addr);
 }
 
@@ -298,9 +280,6 @@ static void do_ext_interrupt(CPUS390XState *env)
 
     cpu_unmap_lowcore(lowcore);
 
-    DPRINTF("%s: %" PRIx64 " %" PRIx64 "\n", __func__,
-            env->psw.mask, env->psw.addr);
-
     load_psw(env, mask, addr);
 }
 
@@ -329,8 +308,6 @@ static void do_io_interrupt(CPUS390XState *env)
     cpu_unmap_lowcore(lowcore);
     g_free(io);
 
-    DPRINTF("%s: %" PRIx64 " %" PRIx64 "\n", __func__, env->psw.mask,
-            env->psw.addr);
     load_psw(env, mask, addr);
 }
 
@@ -372,9 +349,6 @@ static void do_mchk_interrupt(CPUS390XState *env)
 
     cpu_unmap_lowcore(lowcore);
 
-    DPRINTF("%s: %" PRIx64 " %" PRIx64 "\n", __func__,
-            env->psw.mask, env->psw.addr);
-
     load_psw(env, mask, addr);
 }
 
@@ -385,8 +359,8 @@ void s390_cpu_do_interrupt(CPUState *cs)
     CPUS390XState *env = &cpu->env;
     bool stopped = false;
 
-    qemu_log_mask(CPU_LOG_INT, "%s: %d at pc=%" PRIx64 "\n",
-                  __func__, cs->exception_index, env->psw.addr);
+    qemu_log_mask(CPU_LOG_INT, "%s: %d at psw=%" PRIx64 ":%" PRIx64 "\n",
+                  __func__, cs->exception_index, env->psw.mask, env->psw.addr);
 
 try_deliver:
     /* handle machine checks */
-- 
1.8.3.1
