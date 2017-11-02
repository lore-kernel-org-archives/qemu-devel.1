Received: from eggs.gnu.org ([2001:4830:134:3::10]:44249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eAISW-0002wZ-3h
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 12:35:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eAISV-0008Pn-6F
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 12:35:12 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:38130)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eAISU-0008Ks-Uw
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 12:35:11 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu,  2 Nov 2017 16:35:36 +0000
Message-Id: <1509640536-32160-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH v2] cpu-exec: Exit exclusive region on longjmp
 from step_atomic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>, "Emilio G . Cota" <cota@braap.org>

Commit ac03ee5331612e44be narrowed the scope of the exclusive
region so it only covers when we're executing the TB, not when
we're generating it. However it missed that there is more than
one execution path out of cpu_tb_exec -- if the atomic insn
causes an exception then the code will longjmp out, skipping
the code to end the exclusive region. This causes QEMU to hang
the next time the CPU calls start_exclusive(), waiting for
itself to exit the region.

Move the "end the region" code out to the end of the
function so that it is run for both normal exit and also
for exit-via-longjmp. We have to use a volatile bool flag
to decide whether we need to end the region, because we
can longjump out of the codegen as well as the execution.

(For some reason this only reproduces for me with a clang
optimized build, not a gcc debug build.)

Fixes: ac03ee5331612e44beb393df2b578c951d27dc0d
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Changes v1->v2: use a flag so we get the "longjump out of the
codegen" case right.

 accel/tcg/cpu-exec.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 4318441..61297f8 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -233,6 +233,8 @@ void cpu_exec_step_atomic(CPUState *cpu)
     uint32_t flags;
     uint32_t cflags = 1;
     uint32_t cf_mask = cflags & CF_HASH_MASK;
+    /* volatile because we modify it between setjmp and longjmp */
+    volatile bool in_exclusive_region = false;
 
     if (sigsetjmp(cpu->jmp_env, 0) == 0) {
         tb = tb_lookup__cpu_state(cpu, &pc, &cs_base, &flags, cf_mask);
@@ -251,14 +253,12 @@ void cpu_exec_step_atomic(CPUState *cpu)
 
         /* Since we got here, we know that parallel_cpus must be true.  */
         parallel_cpus = false;
+        in_exclusive_region = true;
         cc->cpu_exec_enter(cpu);
         /* execute the generated code */
         trace_exec_tb(tb, pc);
         cpu_tb_exec(cpu, tb);
         cc->cpu_exec_exit(cpu);
-        parallel_cpus = true;
-
-        end_exclusive();
     } else {
         /* We may have exited due to another problem here, so we need
          * to reset any tb_locks we may have taken but didn't release.
@@ -270,6 +270,15 @@ void cpu_exec_step_atomic(CPUState *cpu)
 #endif
         tb_lock_reset();
     }
+
+    if (in_exclusive_region) {
+        /* We might longjump out of either the codegen or the
+         * execution, so must make sure we only end the exclusive
+         * region if we started it.
+         */
+        parallel_cpus = true;
+        end_exclusive();
+    }
 }
 
 struct tb_desc {
-- 
2.7.4
