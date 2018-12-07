Received: from eggs.gnu.org ([2001:4830:134:3::10]:55352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gVBwZ-0002JW-F2
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 03:57:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gVBwT-00005C-5R
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 03:57:05 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Fri,  7 Dec 2018 08:56:29 +0000
Message-Id: <20181207085635.4291-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [RFC PATCH 0/6] target/ppc: convert VMX instructions
 to use TCG vector operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, richard.henderson@linaro.org

This patchset is an attempt at trying to improve the VMX (Altivec) instruction
performance by making use of the new TCG vector operations where possible.

In order to use TCG vector operations, the registers must be accessible from cpu_env
whilst currently they are accessed via arrays of static TCG globals. Patches 1-3
are therefore mechanical patches which introduce access helpers for FPR, AVR and VSR
registers using the supplied TCGv_i64 parameter.

Once this is done, patch 4 enables us to remove the static TCG global arrays and updates
the access helpers to read/write to the relevant fields in cpu_env directly.

The final patches 5 and 6 convert the VMX logical instructions and addition/subtraction
instructions respectively over to the TCG vector operations.

NOTE: there are a lot of instructions that cannot (yet) be optimised to use TCG vector
operations, however it struck me that there may be some potential for converting
saturating add/sub and cmp instructions if there were a mechanism to return a set of
flags indicating the result of the saturation/comparison.

Finally thanks to Richard for taking the time to answer some of my (mostly beginner)
questions related to TCG.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


Mark Cave-Ayland (6):
  target/ppc: introduce get_fpr() and set_fpr() helpers for FP register
    access
  target/ppc: introduce get_avr64() and set_avr64() helpers for VMX
    register access
  target/ppc: introduce get_cpu_vsr{l,h}() and set_cpu_vsr{l,h}()
    helpers for VSR register access
  target/ppc: switch FPR, VMX and VSX helpers to access data directly
    from cpu_env
  target/ppc: convert VMX logical instructions to use vector operations
  target/ppc: convert vaddu[b,h,w,d] and vsubu[b,h,w,d] over to use
    vector operations

 target/ppc/helper.h                 |   8 -
 target/ppc/int_helper.c             |   7 -
 target/ppc/translate.c              |  72 ++--
 target/ppc/translate/fp-impl.inc.c  | 492 ++++++++++++++++++-----
 target/ppc/translate/vmx-impl.inc.c | 182 ++++++---
 target/ppc/translate/vsx-impl.inc.c | 782 ++++++++++++++++++++++++++----------
 6 files changed, 1110 insertions(+), 433 deletions(-)

-- 
2.11.0
