Received: from eggs.gnu.org ([2001:4830:134:3::10]:44737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eAGpU-0000Gi-T1
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 10:50:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eAGpU-0005Bg-0N
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 10:50:48 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:38120)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eAGpT-0005BH-P2
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 10:50:47 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu,  2 Nov 2017 14:51:13 +0000
Message-Id: <1509634273-29111-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH] cpu-exec: Exit exclusive region on longjmp
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
for exit-via-longjmp.

(For some reason this only reproduces for me with a clang
optimized build, not a gcc debug build.)

Fixes: ac03ee5331612e44beb393df2b578c951d27dc0d
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 accel/tcg/cpu-exec.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 4318441..ac316bb 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -256,9 +256,6 @@ void cpu_exec_step_atomic(CPUState *cpu)
         trace_exec_tb(tb, pc);
         cpu_tb_exec(cpu, tb);
         cc->cpu_exec_exit(cpu);
-        parallel_cpus = true;
-
-        end_exclusive();
     } else {
         /* We may have exited due to another problem here, so we need
          * to reset any tb_locks we may have taken but didn't release.
@@ -270,6 +267,9 @@ void cpu_exec_step_atomic(CPUState *cpu)
 #endif
         tb_lock_reset();
     }
+
+    parallel_cpus = true;
+    end_exclusive();
 }
 
 struct tb_desc {
-- 
2.7.4
