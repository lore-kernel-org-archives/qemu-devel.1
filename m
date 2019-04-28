Received: from eggs.gnu.org ([209.51.188.92]:58697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hKl0p-000603-C0
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 10:42:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hKl0o-000554-Aq
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 10:42:39 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Sun, 28 Apr 2019 15:38:31 +0100
Message-Id: <20190428143845.11810-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 00/14] target/ppc: remove getVSR()/putVSR() and
 further tidy-up
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net, gkurz@kaod.org

With the conversion of PPC VSX registers to host endian during the 4.0 development
cycle, the VSX helpers getVSR() and putVSR() which were used to convert between big
endian and host endian (and are currently just a no-op) can now be removed. This
eliminates an extra copy for each VSX source and destination register at runtime.

Patches 1-3 do the elimination work on a per-file basis and switch VSX register
accesses to be via pointers rather than on copies managed using getVSR()/putVSR().

After this patches 4-12 change the VSX registers to be passed to helpers via pointers
rather than register number so that the decode of the vector register pointers occurs
at translation time instead of at runtime. This matches how VMX instructions are
currently decoded.

Finally patches 13 and 14 perform some additional tidy-up around decoding registers
at translation time instead of runtime for VSX_REST_DC and VSX_FMADD.

Greg: I've added you as CC since you managed to find a bug in my last series. This
one is much more mechanical, but if you are able to confirm this doesn't introduce
any regressions in your test images then that would be great.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


Mark Cave-Ayland (14):
  target/ppc: remove getVSR()/putVSR() from fpu_helper.c
  target/ppc: remove getVSR()/putVSR() from mem_helper.c
  target/ppc: remove getVSR()/putVSR() from int_helper.c
  target/ppc: introduce GEN_VSX_HELPER_X3 macro to fpu_helper.c
  target/ppc: introduce GEN_VSX_HELPER_X2 macro to fpu_helper.c
  target/ppc: introduce GEN_VSX_HELPER_X2_AB macro to fpu_helper.c
  target/ppc: introduce GEN_VSX_HELPER_X1 macro to fpu_helper.c
  target/ppc: introduce GEN_VSX_HELPER_R3 macro to fpu_helper.c
  target/ppc: introduce GEN_VSX_HELPER_R2 macro to fpu_helper.c
  target/ppc: introduce GEN_VSX_HELPER_R2_AB macro to fpu_helper.c
  target/ppc: decode target register in VSX_VECTOR_LOAD_STORE_LENGTH at
    translation time
  target/ppc: decode target register in VSX_EXTRACT_INSERT at
    translation time
  target/ppc: improve VSX_TEST_DC with new generator macros
  target/ppc: improve VSX_FMADD with new GEN_VSX_HELPER_VSX_MADD macro

 target/ppc/fpu_helper.c             | 745 +++++++++++++++---------------------
 target/ppc/helper.h                 | 344 +++++++++--------
 target/ppc/int_helper.c             |  24 +-
 target/ppc/internal.h               |  12 -
 target/ppc/mem_helper.c             |  22 +-
 target/ppc/translate/vsx-impl.inc.c | 523 ++++++++++++++++---------
 6 files changed, 842 insertions(+), 828 deletions(-)

-- 
2.11.0
