Received: from eggs.gnu.org ([2001:4830:134:3::10]:35956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eWB6I-0001Vc-0a
	for qemu-devel@nongnu.org; Mon, 01 Jan 2018 20:10:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eWB6E-00051l-Kv
	for qemu-devel@nongnu.org; Mon, 01 Jan 2018 20:10:41 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:59286)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eWB6E-00050Y-BR
	for qemu-devel@nongnu.org; Mon, 01 Jan 2018 20:10:38 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue,  2 Jan 2018 02:10:15 +0100
Message-Id: <20180102011032.30056-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH v5 00/17] target/m68k: supervisor mode (part 1)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <huth@tuxfamily.org>, Laurent Vivier <laurent@vivier.eu>

This series is the first series that will allow
to introduce supervisor mode and execute
privileged instructions.

Some of these patches are only cleanup:

  sync CC_OP before gen_jmp_tb()
  fix gen_get_ccr()
  softmmu cleanup
  add CPU_LOG_INT trace
  use insn_pc to generate instruction fault address
  move CCR/SR functions
  fix m68k_cpu_dump_state()

We also fix a problem with linux-user mode,
where the State Register is not updated with
the CCR value (found while testing "chk/chk2"
using signal()):

  correctly manage SR in context

We introduce some new non privileged instructions:

  add chk and chk2
  add move16

move16 is used by the kernel when it is compiled only for
68040 (it's a 68040 only instruction).

We add some trivial privileged instructions (most are empty):

  add cpush/cinv
  add reset
  implement fsave/frestore

And finally, we add the privileged instructions to
modify the state register, the Interrupt Stack
Pointer and the 680x0 stack frame formats:

  add 680x0 "move to SR" instruction
  add andi/ori/eori to SR/CCR
  add the Interrupt Stack Pointer
  manage 680x0 stack frames

The next series will introduce the MC68040 MMU.

Laurent Vivier (17):
  target-m68k: sync CC_OP before gen_jmp_tb()
  target/m68k: fix gen_get_ccr()
  linux-user,m68k: correctly manage SR in context
  target-m68k: use insn_pc to generate instruction fault address
  target/m68k: add CPU_LOG_INT trace
  target/m68k: manage 680x0 stack frames
  target/m68k: add chk and chk2
  target/m68k: add move16
  target/m68k: softmmu cleanup
  target/m68k: add cpush/cinv
  target/m68k: add reset
  target/m68k: implement fsave/frestore
  target/m68k: move CCR/SR functions
  target/m68k: add 680x0 "move to SR" instruction
  target/m68k: add andi/ori/eori to SR/CCR
  target/m68k: add the Interrupt Stack Pointer
  target/m68k: fix m68k_cpu_dump_state()

 linux-user/main.c       |   7 +
 linux-user/signal.c     |   7 +-
 target/m68k/cpu.c       |  15 +-
 target/m68k/cpu.h       |  83 ++++++-
 target/m68k/gdbstub.c   |   1 +
 target/m68k/helper.c    |  89 +++++++-
 target/m68k/helper.h    |   8 +-
 target/m68k/monitor.c   |   1 +
 target/m68k/op_helper.c | 270 ++++++++++++++++++++++-
 target/m68k/translate.c | 558 +++++++++++++++++++++++++++++++++++++++---------
 10 files changed, 921 insertions(+), 118 deletions(-)

-- 
2.14.3
