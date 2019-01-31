Received: from eggs.gnu.org ([209.51.188.92]:50324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1gpCE0-00064M-Cl
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 08:17:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1gpCDy-0003Ds-DT
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 08:17:48 -0500
Received: from mail.ispras.ru ([83.149.199.45]:52504)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1gpCDy-0003CI-4L
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 08:17:46 -0500
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Thu, 31 Jan 2019 16:17:44 +0300
Message-ID: <20190131131744.23264.80091.stgit@pasha-VirtualBox>
In-Reply-To: <20190131131520.23264.75724.stgit@pasha-VirtualBox>
References: <20190131131520.23264.75724.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v11 25/25] icount: clean up cpu_can_io before
 jumping to the next block
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
index d0d4484..5871f5a 100644
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
