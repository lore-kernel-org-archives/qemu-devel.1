Received: from eggs.gnu.org ([2001:4830:134:3::10]:57595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1eENP2-0003xa-Uz
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 17:40:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1eENP0-0007jk-R6
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 17:40:28 -0500
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Mon, 13 Nov 2017 14:36:10 -0800
Message-ID: <55c70157d3650022c60f73da5a4ab238aeddb467.1510612380.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1510612380.git.alistair.francis@xilinx.com>
References: <cover.1510612380.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v5 28/29] tcg: Replace fprintf(stderr,
 "*\n" with error_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, armbru@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Stefan Weil <sw@weilnetz.de>

Replace a large number of the fprintf(stderr, "*\n" calls with
error_report(). The functions were renamed with these commands and then
compiler issues where manually fixed.

find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Stefan Weil <sw@weilnetz.de>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
---

 cpus.c                   |  8 ++++----
 exec.c                   | 14 +++++++-------
 tcg/optimize.c           |  8 ++++----
 tcg/tcg.c                |  2 +-
 tcg/tcg.h                |  3 ++-
 tcg/tci.c                |  2 +-
 tcg/tci/tcg-target.inc.c |  4 ++--
 vl.c                     |  2 +-
 8 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/cpus.c b/cpus.c
index 114c29b6a0..d73df01659 100644
--- a/cpus.c
+++ b/cpus.c
@@ -258,7 +258,7 @@ int64_t cpu_get_icount_raw(void)
 
     if (cpu && cpu->running) {
         if (!cpu->can_do_io) {
-            fprintf(stderr, "Bad icount read\n");
+            error_report("Bad icount read");
             exit(1);
         }
         /* Take into account what has run */
@@ -1113,7 +1113,7 @@ static void *qemu_kvm_cpu_thread_fn(void *arg)
 
     r = kvm_init_vcpu(cpu);
     if (r < 0) {
-        fprintf(stderr, "kvm_init_vcpu failed: %s\n", strerror(-r));
+        error_report("kvm_init_vcpu failed: %s", strerror(-r));
         exit(1);
     }
 
@@ -1143,7 +1143,7 @@ static void *qemu_kvm_cpu_thread_fn(void *arg)
 static void *qemu_dummy_cpu_thread_fn(void *arg)
 {
 #ifdef _WIN32
-    fprintf(stderr, "qtest is not supported under Windows\n");
+    error_report("qtest is not supported under Windows");
     exit(1);
 #else
     CPUState *cpu = arg;
@@ -1527,7 +1527,7 @@ static void qemu_cpu_kick_thread(CPUState *cpu)
 #else /* _WIN32 */
     if (!qemu_cpu_is_self(cpu)) {
         if (!QueueUserAPC(dummy_apc_func, cpu->hThread, 0)) {
-            fprintf(stderr, "%s: QueueUserAPC failed with error %lu\n",
+            error_report("%s: QueueUserAPC failed with error %lu",
                     __func__, GetLastError());
             exit(1);
         }
diff --git a/exec.c b/exec.c
index 97a24a875e..59e0411d0e 100644
--- a/exec.c
+++ b/exec.c
@@ -1076,7 +1076,7 @@ static RAMBlock *qemu_get_ram_block(ram_addr_t addr)
         }
     }
 
-    fprintf(stderr, "Bad ram offset %" PRIx64 "\n", (uint64_t)addr);
+    error_report("Bad ram offset %" PRIx64 "", (uint64_t)addr);
     abort();
 
 found:
@@ -1689,7 +1689,7 @@ static ram_addr_t find_ram_offset(ram_addr_t size)
     }
 
     if (offset == RAM_ADDR_MAX) {
-        fprintf(stderr, "Failed to find gap of requested size: %" PRIu64 "\n",
+        error_report("Failed to find gap of requested size: %" PRIu64 "",
                 (uint64_t)size);
         abort();
     }
@@ -1719,8 +1719,8 @@ static void qemu_ram_setup_dump(void *addr, ram_addr_t size)
         ret = qemu_madvise(addr, size, QEMU_MADV_DONTDUMP);
         if (ret) {
             perror("qemu_madvise");
-            fprintf(stderr, "madvise doesn't support MADV_DONTDUMP, "
-                            "but dump_guest_core=off specified\n");
+            error_report("madvise doesn't support MADV_DONTDUMP, "
+                            "but dump_guest_core=off specified");
         }
     }
 }
@@ -1756,7 +1756,7 @@ void qemu_ram_set_idstr(RAMBlock *new_block, const char *name, DeviceState *dev)
     RAMBLOCK_FOREACH(block) {
         if (block != new_block &&
             !strcmp(block->idstr, new_block->idstr)) {
-            fprintf(stderr, "RAMBlock \"%s\" already registered, abort!\n",
+            error_report("RAMBlock \"%s\" already registered, abort!",
                     new_block->idstr);
             abort();
         }
@@ -2184,8 +2184,8 @@ void qemu_ram_remap(ram_addr_t addr, ram_addr_t length)
                                 flags, -1, 0);
                 }
                 if (area != vaddr) {
-                    fprintf(stderr, "Could not remap addr: "
-                            RAM_ADDR_FMT "@" RAM_ADDR_FMT "\n",
+                    error_report("Could not remap addr: "
+                            RAM_ADDR_FMT "@" RAM_ADDR_FMT "",
                             length, addr);
                     exit(1);
                 }
diff --git a/tcg/optimize.c b/tcg/optimize.c
index 438321c6cc..93bfaad556 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -122,8 +122,8 @@ static TCGOpcode op_to_mov(TCGOpcode op)
     case 64:
         return INDEX_op_mov_i64;
     default:
-        fprintf(stderr, "op_to_mov: unexpected return value of "
-                "function op_bits.\n");
+        error_report("op_to_mov: unexpected return value of "
+                "function op_bits.");
         tcg_abort();
     }
 }
@@ -136,8 +136,8 @@ static TCGOpcode op_to_movi(TCGOpcode op)
     case 64:
         return INDEX_op_movi_i64;
     default:
-        fprintf(stderr, "op_to_movi: unexpected return value of "
-                "function op_bits.\n");
+        error_report("op_to_movi: unexpected return value of "
+                "function op_bits.");
         tcg_abort();
     }
 }
diff --git a/tcg/tcg.c b/tcg/tcg.c
index c22f1c4441..ca5d841c23 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1035,7 +1035,7 @@ static void tcg_temp_free_internal(TCGTemp *ts)
 #if defined(CONFIG_DEBUG_TCG)
     s->temps_in_use--;
     if (s->temps_in_use < 0) {
-        fprintf(stderr, "More temporaries freed than allocated!\n");
+        error_report("More temporaries freed than allocated!");
     }
 #endif
 
diff --git a/tcg/tcg.h b/tcg/tcg.h
index cb7b329876..eadad66f7d 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -29,6 +29,7 @@
 #include "cpu.h"
 #include "exec/tb-context.h"
 #include "qemu/bitops.h"
+#include "qemu/error-report.h"
 #include "tcg-mo.h"
 #include "tcg-target.h"
 
@@ -948,7 +949,7 @@ typedef struct TCGTargetOpDef {
 
 #define tcg_abort() \
 do {\
-    fprintf(stderr, "%s:%d: tcg fatal error\n", __FILE__, __LINE__);\
+    error_report("%s:%d: tcg fatal error", __FILE__, __LINE__);\
     abort();\
 } while (0)
 
diff --git a/tcg/tci.c b/tcg/tci.c
index 63f2cd54ab..6c851d3450 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -35,7 +35,7 @@
 /* Marker for missing code. */
 #define TODO() \
     do { \
-        fprintf(stderr, "TODO %s:%u: %s()\n", \
+        error_report("TODO %s:%u: %s()", \
                 __FILE__, __LINE__, __func__); \
         tcg_abort(); \
     } while (0)
diff --git a/tcg/tci/tcg-target.inc.c b/tcg/tci/tcg-target.inc.c
index 913c3802a3..2f4b56d3ba 100644
--- a/tcg/tci/tcg-target.inc.c
+++ b/tcg/tci/tcg-target.inc.c
@@ -29,7 +29,7 @@
 /* Marker for missing code. */
 #define TODO() \
     do { \
-        fprintf(stderr, "TODO %s:%u: %s()\n", \
+        error_report("TODO %s:%u: %s()", \
                 __FILE__, __LINE__, __func__); \
         tcg_abort(); \
     } while (0)
@@ -403,7 +403,7 @@ static const char *target_parse_constraint(TCGArgConstraint *ct,
 void tci_disas(uint8_t opc)
 {
     const TCGOpDef *def = &tcg_op_defs[opc];
-    fprintf(stderr, "TCG %s %u, %u, %u\n",
+    error_report("TCG %s %u, %u, %u",
             def->name, def->nb_oargs, def->nb_iargs, def->nb_cargs);
 }
 #endif
diff --git a/vl.c b/vl.c
index ec299099ff..985760b76b 100644
--- a/vl.c
+++ b/vl.c
@@ -2232,7 +2232,7 @@ static DisplayType select_display(const char *p)
         display_opengl = 1;
         display = DT_EGL;
 #else
-        fprintf(stderr, "egl support is disabled\n");
+        error_report("egl support is disabled");
         exit(1);
 #endif
     } else if (strstart(p, "curses", &opts)) {
-- 
2.14.1
