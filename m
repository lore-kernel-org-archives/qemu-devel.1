Received: from eggs.gnu.org ([2001:4830:134:3::10]:48442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eAXX6-00029v-QQ
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 04:40:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eAXX5-0002TU-Lm
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 04:40:56 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:53477)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eAXX5-0002SC-FN
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 04:40:55 -0400
Received: by mail-wr0-x243.google.com with SMTP id u40so1800660wrf.10
	for <qemu-devel@nongnu.org>; Fri, 03 Nov 2017 01:40:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  3 Nov 2017 09:40:46 +0100
Message-Id: <20171103084046.12821-4-richard.henderson@linaro.org>
In-Reply-To: <20171103084046.12821-1-richard.henderson@linaro.org>
References: <20171103084046.12821-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 3/3] cpu-exec: Exit exclusive region on longjmp
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
Cc: peter.maydell@linaro.org

From: Peter Maydell <peter.maydell@linaro.org>

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

Reviewed-by: Emilio G. Cota <cota@braap.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Fixes: ac03ee5331612e44beb393df2b578c951d27dc0d
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <1509640536-32160-1-git-send-email-peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cpu-exec.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 4318441e4c..61297f8f4a 100644
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
2.13.6
