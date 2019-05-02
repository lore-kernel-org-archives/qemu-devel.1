Received: from eggs.gnu.org ([209.51.188.92]:38233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hMCPw-0007qe-Jq
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:10:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hMCPv-0005wM-CI
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:10:32 -0400
From: David Hildenbrand <david@redhat.com>
Date: Thu,  2 May 2019 16:09:39 +0200
Message-Id: <20190502141019.6385-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 00/40] s390x/tcg: Vector Instruction Support
 Part 2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>

This is the second part of vector instruction support for s390x. It is
based on the series by Richard:
    [PATCH v2 00/29] tcg vector improvements

Part 1: Vector Support Instructions
Part 2: Vector Integer Instructions
Part 3: Vector String Instructions
Part 4: Vector Floating-Point Instructions

The current state can be found at (kept updated):
    https://github.com/davidhildenbrand/qemu/tree/vx

With the current state I can boot Linux kernel + user space compiled with
SIMD support. This allows to boot distributions compiled exclusively for
z13, requiring SIMD support. Also, it is now possible to build a complete
kernel using rpmbuild as quite some issues have been sorted out.

In this part, all Vector Integer Instructions introduced with the
"Vector Facility" are added. Some instructions part of the Vector Extensi=
on
Facilities are also added.

v2 -> v3:
- Use new vector helpers tcg_gen_gvec_abs(), tcg_gen_gvec_shl() and frien=
ds
  and tcg_gen_gvec_shlv() and friends.
v1 -> v2:
- Many suggestions and fixes as outlined by Richard H.
-- Mostly avoid oom helpers for 128-bit add/sub variants
-- New vector helpers are not considered for now

David Hildenbrand (40):
  s390x/tcg: Implement VECTOR ADD
  s390x/tcg: Implement VECTOR ADD COMPUTE CARRY
  s390x/tcg: Implement VECTOR ADD WITH CARRY
  s390x/tcg: Implement VECTOR ADD WITH CARRY COMPUTE CARRY
  s390x/tcg: Implement VECTOR AND (WITH COMPLEMENT)
  s390x/tcg: Implement VECTOR AVERAGE
  s390x/tcg: Implement VECTOR AVERAGE LOGICAL
  s390x/tcg: Implement VECTOR CHECKSUM
  s390x/tcg: Implement VECTOR ELEMENT COMPARE *
  s390x/tcg: Implement VECTOR COMPARE *
  s390x/tcg: Implement VECTOR COUNT LEADING ZEROS
  s390x/tcg: Implement VECTOR COUNT TRAILING ZEROS
  s390x/tcg: Implement VECTOR EXCLUSIVE OR
  s390x/tcg: Implement VECTOR GALOIS FIELD MULTIPLY SUM (AND ACCUMULATE)
  s390x/tcg: Implement VECTOR LOAD COMPLEMENT
  s390x/tcg: Implement VECTOR LOAD POSITIVE
  s390x/tcg: Implement VECTOR (MAXIMUM|MINIMUM) (LOGICAL)
  s390x/tcg: Implement VECTOR MULTIPLY AND ADD *
  s390x/tcg: Implement VECTOR MULTIPLY *
  s390x/tcg: Implement VECTOR NAND
  s390x/tcg: Implement VECTOR NOR
  s390x/tcg: Implement VECTOR NOT EXCLUSIVE OR
  s390x/tcg: Implement VECTOR OR
  s390x/tcg: Implement VECTOR OR WITH COMPLEMENT
  s390x/tcg: Implement VECTOR POPULATION COUNT
  s390x/tcg: Implement VECTOR ELEMENT ROTATE LEFT LOGICAL
  s390x/tcg: Implement VECTOR ELEMENT ROTATE AND INSERT UNDER MASK
  s390x/tcg: Implement VECTOR ELEMENT SHIFT
  s390x/tcg: Implement VECTOR SHIFT LEFT (BY BYTE)
  s390x/tcg: Implement VECTOR SHIFT LEFT DOUBLE BY BYTE
  s390x/tcg: Implement VECTOR SHIFT RIGHT ARITHMETIC
  s390x/tcg: Implement VECTOR SHIFT RIGHT LOGICAL *
  s390x/tcg: Implement VECTOR SUBTRACT
  s390x/tcg: Implement VECTOR SUBTRACT COMPUTE BORROW INDICATION
  s390x/tcg: Implement VECTOR SUBTRACT WITH BORROW INDICATION
  s390x/tcg: Implement VECTOR SUBTRACT WITH BORROW COMPUTE BORROW
    INDICATION
  s390x/tcg: Implement VECTOR SUM ACROSS DOUBLEWORD
  s390x/tcg: Implement VECTOR SUM ACROSS QUADWORD
  s390x/tcg: Implement VECTOR SUM ACROSS WORD
  s390x/tcg: Implement VECTOR TEST UNDER MASK

 target/s390x/Makefile.objs      |    2 +-
 target/s390x/cc_helper.c        |   17 +
 target/s390x/helper.c           |    1 +
 target/s390x/helper.h           |   66 ++
 target/s390x/insn-data.def      |  137 +++
 target/s390x/internal.h         |    1 +
 target/s390x/translate.c        |    2 +
 target/s390x/translate_vx.inc.c | 1416 +++++++++++++++++++++++++++++++
 target/s390x/vec_int_helper.c   |  603 +++++++++++++
 9 files changed, 2244 insertions(+), 1 deletion(-)
 create mode 100644 target/s390x/vec_int_helper.c

--=20
2.20.1
