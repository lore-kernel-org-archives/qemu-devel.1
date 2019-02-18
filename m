Received: from eggs.gnu.org ([209.51.188.92]:37729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gvi16-0003Xf-SG
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 07:27:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gvi14-0004ET-SD
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 07:27:24 -0500
From: David Hildenbrand <david@redhat.com>
Date: Mon, 18 Feb 2019 13:26:55 +0100
Message-Id: <20190218122710.23639-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 00/15] s390x/tcg: Implement floating-point
 extension facility
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>

This series is based on the patches currently on the list:
- [PATCH v2] softfloat: add float128_is_{normal,denormal}=E2=80=8B
- [PATCH v1] softfloat: Implement float128_to_uint32
- [PATCH v2] softfloat: Support float_round_to_odd more places

For the KVM folks, only the last patch is of interest.

The floating-point extension facility seems to be used often without
checking by user space. Vector instruction support seems to somewhat also
rely on it being available. Some parts are already implemented, others
not or are broken.

Fix some stuff in fpu code, add some FIXMEs to indicate what is definetly
missing and implement all BFP stuff needed for the floating-point extensi=
on
facility. Finally, enable it for TCG, adding it to the CPU model for the
4.0 compat machine.

This series also contains some refactorings needed for floating-point
vector instruction support.

v2 -> v3:
- "s390x/tcg: Implement XxC and checks for most FP instructions"
-- Use extract32() with constant arithmetic
- Use float_round_to_odd and get rid of the corresponding FIXMEs. Thanks
  Richard!

v1 -> v2:
- "s390x/tcg: Fix TEST DATA CLASS instructions"
-- Simplify + use marko
- "s390x/tcg: Prepare for IEEE-inexact-exception control (XxC)"
-- Fix some whitespace/newline issues
- "s390x/tcg: Handle SET FPC AND LOAD FPC 3-bit BFP rounding modes"
-- If FPE is not installed, also bail out on 3rd BFP bit
- "s390x/tcg: Implement XxC and checks for most FP instructions"
-- Use helper functions to simplify checks+mangling+unmangling
-- Take care of FPE facility state
-- Fix that XxC is actually bit 1, not bit 0
- "s390x/tcg: Prepare for IEEE-inexact-exception control (XxC)"
-- Also use new helper functions

David Hildenbrand (15):
  s390x/tcg: Fix TEST DATA CLASS instructions
  s390x/tcg: Fix rounding from float128 to uint64_t/uin32_t
  s390x/tcg: Factor out conversion of softfloat exceptions
  s390x/tcg: Fix parts of IEEE exception handling
  s390x/tcg: Hide IEEE underflows in some scenarios
  s390x/tcg: Refactor SET FPC AND SIGNAL handling
  s390x/tcg: Fix simulated-IEEE exceptions
  s390x/tcg: Handle SET FPC AND LOAD FPC 3-bit BFP rounding modes
  s390x/tcg: Check for exceptions in SET BFP ROUNDING MODE
  s390x/tcg: Refactor saving/restoring the bfp rounding mode
  s390x/tcg: Prepare for IEEE-inexact-exception control (XxC)
  s390x/tcg: Implement XxC and checks for most FP instructions
  s390x/tcg: Implement rounding mode and XxC for LOAD ROUNDED
  s390x/tcg: Handle all rounding modes overwritten by BFP instructions
  s390x: Add floating-point extension facility to "qemu" cpu model

 target/s390x/fpu_helper.c   | 541 ++++++++++++++++++++++--------------
 target/s390x/gen-features.c |   5 +
 target/s390x/helper.h       |   9 +-
 target/s390x/insn-data.def  |  12 +-
 target/s390x/internal.h     |   9 +
 target/s390x/translate.c    | 315 ++++++++++++++-------
 6 files changed, 572 insertions(+), 319 deletions(-)

--=20
2.17.2
