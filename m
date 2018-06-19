Received: from eggs.gnu.org ([2001:4830:134:3::10]:46152)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5iM-0001xr-Tc
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:45:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5iL-00007c-Kr
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:45:46 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 18 Jun 2018 20:42:11 -0500
Message-Id: <20180619014319.28272-46-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
References: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 045/113] arm/translate-a64: treat DISAS_UPDATE
 as variant of DISAS_EXIT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Victor Kamensky <kamensky@cisco.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

From: Victor Kamensky <kamensky@cisco.com>

In OE project 4.15 linux kernel boot hang was observed under
single cpu aarch64 qemu. Kernel code was in a loop waiting for
vtimer arrival, spinning in TC generated blocks, while interrupt
was pending unprocessed. This happened because when qemu tried to
handle vtimer interrupt target had interrupts disabled, as
result flag indicating TCG exit, cpu->icount_decr.u16.high,
was cleared but arm_cpu_exec_interrupt function did not call
arm_cpu_do_interrupt to process interrupt. Later when target
reenabled interrupts, it happened without exit into main loop, so
following code that waited for result of interrupt execution
run in infinite loop.

To solve the problem instructions that operate on CPU sys state
(i.e enable/disable interrupt), and marked as DISAS_UPDATE,
should be considered as DISAS_EXIT variant, and should be
forced to exit back to main loop so qemu will have a chance
processing pending CPU state updates, including pending
interrupts.

This change brings consistency with how DISAS_UPDATE is treated
in aarch32 case.

CC: Peter Maydell <peter.maydell@linaro.org>
CC: Alex Bennée <alex.bennee@linaro.org>
CC: qemu-stable@nongnu.org
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Victor Kamensky <kamensky@cisco.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 1521526368-1996-1-git-send-email-kamensky@cisco.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit a75a52d62418dafe462be4fe30485501d1010bb9)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 target/arm/translate-a64.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 625ef2dfd2..c38109146f 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -11384,12 +11384,12 @@ static void aarch64_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
         case DISAS_UPDATE:
             gen_a64_set_pc_im(dc->pc);
             /* fall through */
-        case DISAS_JUMP:
-            tcg_gen_lookup_and_goto_ptr();
-            break;
         case DISAS_EXIT:
             tcg_gen_exit_tb(0);
             break;
+        case DISAS_JUMP:
+            tcg_gen_lookup_and_goto_ptr();
+            break;
         case DISAS_NORETURN:
         case DISAS_SWI:
             break;
-- 
2.11.0
