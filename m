Received: from eggs.gnu.org ([209.51.188.92]:45469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1h0UqB-0004vm-4e
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 12:23:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1h0UqA-0001qN-2t
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 12:23:55 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Sun,  3 Mar 2019 17:23:35 +0000
Message-Id: <20190303172343.13406-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 0/8] target/ppc: switch fpr/vsrl registers so
 all VSX registers are in host endian order
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, richard.henderson@linaro.org

After some investigation into Andrew's report of corruption in his ppc64le
tests at https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg07234.html, I
discovered the underlying cause was that the first 32 VSX registers are not
stored in host endian order.

This is something that Richard and I had discussed before, but missed that with
VSX if you have source registers from different register sets then even logical
operations will give you the wrong result.

Rather than revert 7b8fe477e1 "target/ppc: convert VSX logical operations to
vector operations" let's keep the use of the accelerated vector instructions,
and instead fix the real problem which is to switch the first 32 VSX registers
to host endian order matching the VMX registers.

Patches 1-5 aim to consolidate the offset calculations for both CPUPPCState
and the associated _ptr() functions into one single place.

With this preliminary work complete, patch 6 switches the first 32 registers
into host endian order without too much difficulty.

Finally now that all VSX registers are stored in the same way, the vsr offset
functions and get_cpu_vsrh()/get_cpu_vsrl() can be simplified accordingly.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


Mark Cave-Ayland (8):
  target/ppc: introduce single fpr_offset() function
  target/ppc: introduce single vsrl_offset() function
  target/ppc: move Vsr* macros from internal.h to cpu.h
  target/ppc: introduce avrh_offset() and avrl_offset() functions
  target/ppc: introduce avr_offset() function
  target/ppc: switch fpr/vsrl registers so all VSX registers are in host
    endian order
  target/ppc: introduce vsrh_offset() function
  target/ppc: simplify get_cpu_vsrh() and get_cpu_vsrl() functions

 target/ppc/cpu.h                    | 56 +++++++++++++++++++++++++++++++++++--
 target/ppc/internal.h               | 27 +++---------------
 target/ppc/machine.c                |  8 +++---
 target/ppc/translate.c              | 28 ++++++++-----------
 target/ppc/translate/vmx-impl.inc.c | 27 ++++++++----------
 target/ppc/translate/vsx-impl.inc.c | 39 +++-----------------------
 6 files changed, 88 insertions(+), 97 deletions(-)

-- 
2.11.0
