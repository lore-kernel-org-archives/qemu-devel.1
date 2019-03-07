Received: from eggs.gnu.org ([209.51.188.92]:48289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1h1xOf-00078d-It
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 13:05:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1h1xOe-0006E0-28
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 13:05:33 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Thu,  7 Mar 2019 18:05:13 +0000
Message-Id: <20190307180520.13868-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH v2 0/7] target/ppc: switch fpr/vsrl registers
 so all VSX registers are in host endian order
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

v2:
- Rebase onto master
- Rework patchset set based upon av64_offset()/vsr64_offset() as suggested by
  Richard, rather than using separate low/high accessors


Mark Cave-Ayland (7):
  target/ppc: introduce single fpr_offset() function
  target/ppc: introduce single vsrl_offset() function
  target/ppc: move Vsr* macros from internal.h to cpu.h
  target/ppc: introduce avr_full_offset() function
  target/ppc: improve avr64_offset() and use it to simplify
    get_avr64()/set_avr64()
  target/ppc: switch fpr/vsrl registers so all VSX registers are in host
    endian order
  target/ppc: introduce vsr64_offset() to simplify get_cpu_vsr{l,h}()
    and set_cpu_vsr{l,h}()

 target/ppc/cpu.h                    | 51 ++++++++++++++++++++++++++++++++++---
 target/ppc/internal.h               | 27 +++-----------------
 target/ppc/machine.c                |  8 +++---
 target/ppc/translate.c              | 20 +++------------
 target/ppc/translate/vmx-impl.inc.c | 27 ++++++++------------
 target/ppc/translate/vsx-impl.inc.c | 39 +++-------------------------
 6 files changed, 75 insertions(+), 97 deletions(-)

-- 
2.11.0
