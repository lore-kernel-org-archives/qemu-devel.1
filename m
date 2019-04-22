Received: from eggs.gnu.org ([209.51.188.92]:40610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pavel.dovgaluk@gmail.com>) id 1hIX1R-0001RR-9b
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 07:22:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pavel.dovgaluk@gmail.com>) id 1hIX1O-0002gC-LR
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 07:22:04 -0400
Received: from mail.ispras.ru ([83.149.199.45]:47408)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pavel.dovgaluk@gmail.com>) id 1hIX1M-0002dX-EW
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 07:22:01 -0400
From: Pavel Dovgalyuk <pavel.dovgaluk@gmail.com>
Date: Mon, 22 Apr 2019 14:21:55 +0300
Message-ID: <155593211539.21079.18009501411293484959.stgit@pasha-Precision-3630-Tower>
In-Reply-To: <155593197705.21079.8238359471765771689.stgit@pasha-Precision-3630-Tower>
References: <155593197705.21079.8238359471765771689.stgit@pasha-Precision-3630-Tower>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH for-4.1 24/24] icount: clean up cpu_can_io
 before jumping to the next block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, war2jordan@live.com, crosthwaite.peter@gmail.com, boost.lists@gmail.com, artem.k.pisarenko@gmail.com, quintela@redhat.com, ciro.santilli@gmail.com, jasowang@redhat.com, mst@redhat.com, armbru@redhat.com, mreitz@redhat.com, maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru, kraxel@redhat.com, pavel.dovgaluk@ispras.ru, thomas.dullien@googlemail.com, pbonzini@redhat.com, alex.bennee@linaro.org, dgilbert@redhat.com, rth@twiddle.net

From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

Most of IO instructions can be executed only at the end of the block in
icount mode. Therefore translator can set cpu_can_io flag when translating
the last instruction.
But when the blocks are chained, then this flag is not reset and may
remain set at the beginning of the next block.
This patch resets the flag before "chaining" the translation blocks.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
---
 accel/tcg/tcg-runtime.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/accel/tcg/tcg-runtime.c b/accel/tcg/tcg-runtime.c
index d0d4484406..5871f5aba2 100644
--- a/accel/tcg/tcg-runtime.c
+++ b/accel/tcg/tcg-runtime.c
@@ -151,6 +151,8 @@ void *HELPER(lookup_tb_ptr)(CPUArchState *env)
     target_ulong cs_base, pc;
     uint32_t flags;
 
+    /* We are going to jump to the next block. can_do_io should be reset */
+    cpu->can_do_io = !use_icount;
     tb = tb_lookup__cpu_state(cpu, &pc, &cs_base, &flags, curr_cflags());
     if (tb == NULL) {
         return tcg_ctx->code_gen_epilogue;
