Received: from eggs.gnu.org ([2001:4830:134:3::10]:35046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d8WJy-0003DW-3S
	for qemu-devel@nongnu.org; Wed, 10 May 2017 14:26:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d8WJx-0000Fq-25
	for qemu-devel@nongnu.org; Wed, 10 May 2017 14:26:46 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:48670)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1d8WJw-0000FT-Rs
	for qemu-devel@nongnu.org; Wed, 10 May 2017 14:26:44 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Wed, 10 May 2017 20:26:21 +0200
Message-Id: <20170510182636.17791-1-aurelien@aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 00/15] target/sh4: misc fixes,
 cleanup and optimizations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>

This patch series try to improve the SH4 target by using the (more or
less) recently introduced TCG features. It also fixes some issues spot
when writting the patches (linking of TB with different flags, SH4-A
specific instructions allowed on SH4) and correctly trap unaligned
accesses.

v3:
- Use extr instead of extrh/extrl in gen_store_fpr64, as suggested by
  Richard Henderson
- Use cpu_loop_exit_restore instead of cpu_loop_exit/cpu_restore_state
  in superh_cpu_do_unaligned_access
- Add a patch to convert the remaining cpu_loop_exit/cpu_restore_state
  to cpu_loop_exit_restore
- Add Reviewed-by entries

v2:
- Add some comments in the struct DisasContext declaration, as suggested
  by Philippe Mathieu-Daudé


Aurelien Jarno (15):
  target/sh4: split ctx->flags into ctx->tbflags and ctx->envflags
  target/sh4: get rid of DELAY_SLOT_CLEARME
  target/sh4: do not include DELAY_SLOT_TRUE in the TB state
  target/sh4: move DELAY_SLOT_TRUE flag into a separate global
  target/sh4: fix BS_STOP exit
  target/sh4: fix BS_EXCP exit
  target/sh4: only save flags state at the end of the TB
  target/sh4: fold ctx->bstate = BS_BRANCH into gen_conditional_jump
  target/sh4: optimize gen_store_fpr64
  target/sh4: optimize gen_write_sr using extract op
  target/sh4: generate fences for SH4
  target/sh4: implement tas.b using atomic helper
  target/sh4: movua.l is an SH4-A only instruction
  target/sh4: trap unaligned accesses
  target/sh4: use cpu_loop_exit_restore

 target/sh4/cpu.c       |   1 +
 target/sh4/cpu.h       |  18 ++-
 target/sh4/helper.c    |   4 +-
 target/sh4/op_helper.c |  26 ++--
 target/sh4/translate.c | 322 +++++++++++++++++++++++--------------------------
 5 files changed, 181 insertions(+), 190 deletions(-)

-- 
2.11.0
