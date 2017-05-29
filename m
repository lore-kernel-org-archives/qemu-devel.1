Received: from eggs.gnu.org ([2001:4830:134:3::10]:38778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dFQHb-0006Tn-Ge
	for qemu-devel@nongnu.org; Mon, 29 May 2017 15:24:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dFQHa-00073p-5r
	for qemu-devel@nongnu.org; Mon, 29 May 2017 15:24:51 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:42834)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dFQHZ-00071x-VF
	for qemu-devel@nongnu.org; Mon, 29 May 2017 15:24:50 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Mon, 29 May 2017 21:24:11 +0200
Message-Id: <20170529192440.5990-1-aurelien@aurel32.net>
Subject: [Qemu-devel] [PATCH v2 00/29] target/s390x: fix,
 improve and implement some more instructions
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

This patchset tries to improve the s390x emulation by fixing and
improving some instructions. It implement some more instructions, from
the zArchitecture base and from the Extended-Translation Facility 2. The
last patch updates the maximum TCG CPU to z800, as the ETF2 and
Long-Displacement Facility are now both fully implemented.

This patch series is based on the s390x unwind and execute patches
from Richard Henderson and the qemu cpu_models patch from Thomas Huth.
It includes feedback from both.

v1 -> v2:
 - add a patch to improve IPTE
 - implement local-TLB-clearing in IPTE
 - use tcg_gen_atomic_xchg_i32 in TEST AND SET
 - use gen_op_movi_cc in TEST ADDRESSING MODE
 - use helper_atomic_ldo_be_mmu in LOAD PAIR FROM QUADWORD
 - use helper_atomic_sto_be_mmu in STORE PAIR TO QUADWORD
 - add a patch to implement COMPARE AND SIGNAL
 - rename dest and src into src1 and src3 and check that r1 & r3 are even
   in COMPARE LOGICAL LONG EXTENDED
 - check that r1 & r2 are even in COMPARE LOGICAL LONG
 - check that r1 & r3 are even in COMPARE LOGICAL LONG UNICODE
 - move the adj_len_to_page patch before MVCL/MVCLE changes and simplify
   the expression a bit
 - fix indentation in MOVE LONG UNICODE
 - rebase the cpu model upgrade to z800 onto the qemu cpu_models patch
   from Thomas Huth and use s390_find_cpu_def to get the z800 model.

Aurelien Jarno (29):
  target/s390x: remove dead code in translate.c
  target/s390x: remove some Linux assumptions from IPTE
  target/s390x: implement local-TLB-clearing in IPTE
  target/s390x: implement TEST AND SET
  target/s390x: implement TEST ADDRESSING MODE
  target/s390x: implement PACK
  target/s390x: implement LOAD PAIR FROM QUADWORD
  target/s390x: implement STORE PAIR TO QUADWORD
  target/s390x: implement COMPARE AND SIGNAL
  target/s390x: implement MOVE INVERSE
  target/s390x: implement MOVE NUMERICS
  target/s390x: implement MOVE WITH OFFSET
  target/s390x: implement MOVE ZONES
  target/s390x: improve 24-bit and 31-bit addresses read
  target/s390x: improve 24-bit and 31-bit addresses write
  target/s390x: improve 24-bit and 31-bit lengths read/write
  target/s390x: fix COMPARE LOGICAL LONG EXTENDED
  target/s390x: implement COMPARE LOGICAL LONG
  target/s390x: fix adj_len_to_page
  target/s390x: improve MOVE LONG and MOVE LONG EXTENDED
  target/s390x: implement COMPARE LOGICAL LONG UNICODE
  target/s390x: implement MOVE LONG UNICODE
  target/s390x: implement PACK ASCII
  target/s390x: implement PACK UNICODE
  target/s390x: implement UNPACK ASCII
  target/s390x: implement UNPACK UNICODE
  target/s390x: implement TEST DECIMAL
  target/s390x: implement TRANSLATE ONE/TWO TO ONE/TWO
  target/s390x: update maximum TCG model to z800

 target/s390x/cpu.h         |   2 +
 target/s390x/cpu_models.c  |  12 +-
 target/s390x/fpu_helper.c  |  27 ++
 target/s390x/helper.h      |  21 +-
 target/s390x/insn-data.def |  57 ++++
 target/s390x/mem_helper.c  | 747 +++++++++++++++++++++++++++++++++++++--------
 target/s390x/misc_helper.c |   4 +-
 target/s390x/mmu_helper.c  |   4 +-
 target/s390x/translate.c   | 318 +++++++++++++++++--
 9 files changed, 1036 insertions(+), 156 deletions(-)

-- 
2.11.0
