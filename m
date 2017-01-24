Received: from eggs.gnu.org ([2001:4830:134:3::10]:35206)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pavel.dovgaluk@ispras.ru>) id 1cVvLy-00068N-QV
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 02:17:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pavel.dovgaluk@ispras.ru>) id 1cVvLx-0005m5-Rb
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 02:17:18 -0500
Received: from mail.ispras.ru ([83.149.199.45]:38544)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pavel.dovgaluk@ispras.ru>) id 1cVvLx-0005ly-Kh
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 02:17:17 -0500
From: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Date: Tue, 24 Jan 2017 10:17:19 +0300
Message-ID: <20170124071719.4572.92155.stgit@PASHA-ISP>
In-Reply-To: <20170124071654.4572.41407.stgit@PASHA-ISP>
References: <20170124071654.4572.41407.stgit@PASHA-ISP>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v7 04/14] icount: exit cpu loop on expire
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

Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
---
 cpu-exec.c |   15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/cpu-exec.c b/cpu-exec.c
index 79a2167..e603da4 100644
--- a/cpu-exec.c
+++ b/cpu-exec.c
@@ -582,9 +582,6 @@ static inline void cpu_loop_exec_tb(CPUState *cpu, TranslationBlock *tb,
                 cpu_exec_nocache(cpu, insns_left, *last_tb, false);
                 align_clocks(sc, cpu);
             }
-            cpu->exception_index = EXCP_INTERRUPT;
-            *last_tb = NULL;
-            cpu_loop_exit(cpu);
         }
         break;
 #endif
@@ -638,6 +635,18 @@ int cpu_exec(CPUState *cpu)
 
             for(;;) {
                 cpu_handle_interrupt(cpu, &last_tb);
+                /* icount has expired, we need to break the execution loop.
+                   This check is needed before tb_find to make execution
+                   deterministic - tb_find may cause an exception
+                   while translating the code from non-mapped page. */
+                if (use_icount && ((cpu->icount_extra == 0
+                                    && cpu->icount_decr.u16.low == 0)
+                                || (int32_t)cpu->icount_decr.u32 < 0)) {
+                    if (cpu->exception_index == -1) {
+                        cpu->exception_index = EXCP_INTERRUPT;
+                    }
+                    cpu_loop_exit(cpu);
+                }
                 tb = tb_find(cpu, last_tb, tb_exit);
                 cpu_loop_exec_tb(cpu, tb, &last_tb, &tb_exit, &sc);
                 /* Try to align the host and virtual clocks
