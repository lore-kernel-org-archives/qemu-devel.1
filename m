Received: from eggs.gnu.org ([2001:4830:134:3::10]:42905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnW4b-0000gf-AS
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 15:56:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnW4Y-0002RH-GL
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 15:56:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47172)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cnW4Y-0002Qj-AP
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 15:56:02 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon, 13 Mar 2017 14:55:25 -0500
Message-Id: <20170313195547.21466-9-eblake@redhat.com>
In-Reply-To: <20170313195547.21466-1-eblake@redhat.com>
References: <20170313195547.21466-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 08/30] trace: Fix parameter types in top
 level
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>

An upcoming patch will let the compiler warn us when we are silently
losing precision in traces; update the trace definitions to pass
through the full value at the callsite.  Some of the callers use
the variable-length target_ulong, which cannot portably be mentioned
in headers that are included from target-independent code; in those
cases, use casts to force a type that will work through varargs to
match the declaration already in trace-events.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 cpu-exec.c      | 6 +++---
 translate-all.c | 2 +-
 trace-events    | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/cpu-exec.c b/cpu-exec.c
index d04dd91..109f502 100644
--- a/cpu-exec.c
+++ b/cpu-exec.c
@@ -210,7 +210,7 @@ static void cpu_exec_nocache(CPUState *cpu, int max_cycles,
     tb_unlock();

     /* execute the generated code */
-    trace_exec_tb_nocache(tb, tb->pc);
+    trace_exec_tb_nocache(tb, (uintptr_t) tb->pc);
     cpu_tb_exec(cpu, tb);

     tb_lock();
@@ -240,7 +240,7 @@ static void cpu_exec_step(CPUState *cpu)

         cc->cpu_exec_enter(cpu);
         /* execute the generated code */
-        trace_exec_tb_nocache(tb, pc);
+        trace_exec_tb_nocache(tb, (uintptr_t) pc);
         cpu_tb_exec(cpu, tb);
         cc->cpu_exec_exit(cpu);

@@ -571,7 +571,7 @@ static inline void cpu_loop_exec_tb(CPUState *cpu, TranslationBlock *tb,
     uintptr_t ret;
     int32_t insns_left;

-    trace_exec_tb(tb, tb->pc);
+    trace_exec_tb(tb, (uintptr_t) tb->pc);
     ret = cpu_tb_exec(cpu, tb);
     tb = (TranslationBlock *)(ret & ~TB_EXIT_MASK);
     *tb_exit = ret & TB_EXIT_MASK;
diff --git a/translate-all.c b/translate-all.c
index 34480ae..68f31cd 100644
--- a/translate-all.c
+++ b/translate-all.c
@@ -1294,7 +1294,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     gen_intermediate_code(env, tb);
     tcg_ctx.cpu = NULL;

-    trace_translate_block(tb, tb->pc, tb->tc_ptr);
+    trace_translate_block(tb, (uintptr_t) tb->pc, tb->tc_ptr);

     /* generate machine code */
     tb->jmp_reset_offset[0] = TB_JMP_RESET_OFFSET_INVALID;
diff --git a/trace-events b/trace-events
index b07a09b..4f72cf2 100644
--- a/trace-events
+++ b/trace-events
@@ -42,7 +42,7 @@ qemu_system_shutdown_request(void) ""
 qemu_system_powerdown_request(void) ""

 # spice-qemu-char.c
-spice_vmc_write(ssize_t out, int len) "spice wrote %zd of requested %d"
+spice_vmc_write(ssize_t out, ssize_t len) "spice wrote %zd of requested %zd"
 spice_vmc_read(int bytes, int len) "spice read %d of requested %d"
 spice_vmc_register_interface(void *scd) "spice vmc registered interface %p"
 spice_vmc_unregister_interface(void *scd) "spice vmc unregistered interface %p"
-- 
2.9.3
