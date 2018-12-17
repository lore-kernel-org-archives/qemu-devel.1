Received: from eggs.gnu.org ([2001:4830:134:3::10]:37249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gYrwt-0001nN-NZ
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 07:24:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gYrwp-0004ws-N5
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 07:24:39 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Mon, 17 Dec 2018 12:23:56 +0000
Message-Id: <20181217122405.18732-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [RFC PATCH v2 0/9] target/ppc: convert VMX
 instructions to use TCG vector operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, richard.henderson@linaro.org, lvivier@redhat.com

This patchset is an attempt at trying to improve the VMX (Altivec) instruction
performance by making use of the new TCG vector operations where possible.

In order to use TCG vector operations, the registers must be accessible from cpu_env
whilst currently they are accessed via arrays of static TCG globals. Patches 1-3
are therefore mechanical patches which introduce access helpers for FPR, AVR and VSR
registers using the supplied TCGv_i64 parameter. Meanwhile patch 4 fixes a minor issue
spotted by Richard during review to ensure that AVR registers are not modified until
after exceptions are processing during register load.

Once this is done, patch 5 enables us to remove the static TCG global arrays and updates
the access helpers to read/write to the relevant fields in cpu_env directly.

Patches 6 and 7 perform the legwork required to enable VSX instructions to be converted
to use TCG vector operations in future by rearranging the FP, VMX and VSX registers into
a single aligned VSR register array (the scope of this patchset is VMX only).

The final patches 8 and 9 convert the VMX logical instructions and addition/subtraction
instructions respectively over to the TCG vector operations.

NOTE: there are a lot of instructions that cannot (yet) be optimised to use TCG vector
operations, however it struck me that there may be some potential for converting
saturating add/sub and cmp instructions if there were a mechanism to return a set of
flags indicating the result of the saturation/comparison.

Finally thanks to Richard for taking the time to answer some of my (mostly beginner)
questions related to TCG.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


v2:
- Rebase onto master
- Add comment explaining rationale for FPR helpers in description for patch 1
- Add R-B tags from Richard
- Add patch 3 to delay AVR register writeback as spotted by Richard
- Add patches 6 and 7 to merge FPR, VMX and VSX registers into the vsr array
  to facilitate conversion of VSX instructions to vector operations later
- Fix accidental bug whereby the conversion of get_vsr()/set_vsr() to access
  data from cpu_env was incorrectly squashed into patch 3
- Move set_fpr() further down in gen_fsqrts() and gen_frsqrtes() in patch 1


Mark Cave-Ayland (9):
  target/ppc: introduce get_fpr() and set_fpr() helpers for FP register
    access
  target/ppc: introduce get_avr64() and set_avr64() helpers for VMX
    register access
  target/ppc: introduce get_cpu_vsr{l,h}() and set_cpu_vsr{l,h}()
    helpers for VSR register access
  target/ppc: delay writeback of avr{l,h} during lvx instruction
  target/ppc: switch FPR, VMX and VSX helpers to access data directly
    from cpu_env
  target/ppc: merge ppc_vsr_t and ppc_avr_t union types
  target/ppc: move FP and VMX registers into aligned vsr register array
  target/ppc: convert VMX logical instructions to use vector operations
  target/ppc: convert vaddu[b,h,w,d] and vsubu[b,h,w,d] over to use
    vector operations

 linux-user/ppc/signal.c             |  24 +-
 target/ppc/arch_dump.c              |  12 +-
 target/ppc/cpu.h                    |  26 +-
 target/ppc/gdbstub.c                |   8 +-
 target/ppc/helper.h                 |   8 -
 target/ppc/int_helper.c             |  63 ++-
 target/ppc/internal.h               |  29 +-
 target/ppc/machine.c                |  72 +++-
 target/ppc/monitor.c                |   4 +-
 target/ppc/translate.c              |  74 ++--
 target/ppc/translate/dfp-impl.inc.c |   2 +-
 target/ppc/translate/fp-impl.inc.c  | 490 +++++++++++++++++-----
 target/ppc/translate/vmx-impl.inc.c | 186 ++++++---
 target/ppc/translate/vsx-impl.inc.c | 782 ++++++++++++++++++++++++++----------
 target/ppc/translate_init.inc.c     |  24 +-
 15 files changed, 1262 insertions(+), 542 deletions(-)

-- 
2.11.0
