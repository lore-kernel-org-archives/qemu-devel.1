Received: from eggs.gnu.org ([2001:4830:134:3::10]:49604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pavel.dovgaluk@ispras.ru>) id 1cWjFt-0003E5-4d
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 07:34:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pavel.dovgaluk@ispras.ru>) id 1cWjFs-0004z6-7N
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 07:34:21 -0500
Received: from mail.ispras.ru ([83.149.199.45]:42486)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pavel.dovgaluk@ispras.ru>) id 1cWjFs-0004yy-1F
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 07:34:20 -0500
From: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Date: Thu, 26 Jan 2017 15:34:23 +0300
Message-ID: <20170126123423.5412.2388.stgit@PASHA-ISP>
In-Reply-To: <20170126123411.5412.44769.stgit@PASHA-ISP>
References: <20170126123411.5412.44769.stgit@PASHA-ISP>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v8 2/9] icount: exit cpu loop on expire
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, mst@redhat.com, jasowang@redhat.com, quintela@redhat.com, dovgaluk@ispras.ru, kraxel@redhat.com, pbonzini@redhat.com

This patch adds check to break cpu loop when icount expires without
setting the TB_EXIT_ICOUNT_EXPIRED flag. It happens when there is no
available translated blocks and all instructions were executed.
In icount replay mode unnecessary tb_find will be called (which may
cause an exception) and execution will be non-deterministic.

v8: refactored loop exit code and moved it to separate function

Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
---
 cpu-exec.c |   24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/cpu-exec.c b/cpu-exec.c
index fa08c73..f9b8ec8 100644
--- a/cpu-exec.c
+++ b/cpu-exec.c
@@ -523,9 +523,25 @@ static inline void cpu_handle_interrupt(CPUState *cpu,
             *last_tb = NULL;
         }
     }
-    if (unlikely(atomic_read(&cpu->exit_request) || replay_has_interrupt())) {
+}
+
+
+static void cpu_check_loop_exit(CPUState *cpu)
+{
+    if (unlikely(atomic_read(&cpu->exit_request)
+        /* icount has expired, we need to break the execution loop.
+           This check is needed before tb_find to make execution
+           deterministic - tb_find may cause an exception
+           while translating the code from non-mapped page. */
+        || (use_icount && ((cpu->icount_extra == 0
+                        && cpu->icount_decr.u16.low == 0)
+                    || (int32_t)cpu->icount_decr.u32 < 0)))) {
         atomic_set(&cpu->exit_request, 0);
-        cpu->exception_index = EXCP_INTERRUPT;
+        /* If there is an exception that wasn't replayed yet,
+           don't change exception_index. */
+        if (cpu->exception_index == -1) {
+            cpu->exception_index = EXCP_INTERRUPT;
+        }
         cpu_loop_exit(cpu);
     }
 }
@@ -578,9 +594,6 @@ static inline void cpu_loop_exec_tb(CPUState *cpu, TranslationBlock *tb,
                 cpu_exec_nocache(cpu, insns_left, *last_tb, false);
                 align_clocks(sc, cpu);
             }
-            cpu->exception_index = EXCP_INTERRUPT;
-            *last_tb = NULL;
-            cpu_loop_exit(cpu);
         }
         break;
 #endif
@@ -634,6 +647,7 @@ int cpu_exec(CPUState *cpu)
 
             for(;;) {
                 cpu_handle_interrupt(cpu, &last_tb);
+                cpu_check_loop_exit(cpu);
                 tb = tb_find(cpu, last_tb, tb_exit);
                 cpu_loop_exec_tb(cpu, tb, &last_tb, &tb_exit, &sc);
                 /* Try to align the host and virtual clocks
