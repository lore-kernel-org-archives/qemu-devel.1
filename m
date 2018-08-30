Received: from eggs.gnu.org ([2001:4830:134:3::10]:42099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fvM3Q-0008WO-Ve
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 08:28:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fvM3M-0000LQ-Vh
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 08:28:04 -0400
From: David Hildenbrand <david@redhat.com>
Date: Thu, 30 Aug 2018 14:27:47 +0200
Message-Id: <20180830122756.13991-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 0/9] s390x: instruction flags and AFP
 registers for TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>

I wanted to add AFP-register control related checks for a long time.
However, doing these checks in each and every relevant handler is ugly.

As I will need similar checks for vector instructions (yes, I'm looking i=
nto
that but it might take some time), I decided to introduce per-instruction
flags, that allow to to check such "instruction properties" globally.
Tagging e.g. privileged instructions that way turns out quite nice.

Of course, while at it some fixes and cleanups.

v1 -> v2:
- added "s390x: move tcg_s390_program_interrupt() into TCG code and ..."
- Some checkpatch changes lead to some false positives in the last two
  patches ... to work around them, I dropped some unnecessary parantheses=
.

David Hildenbrand (9):
  s390x: move tcg_s390_program_interrupt() into TCG code and mark it
    noreturn
  s390x/tcg: factor out and fix DATA exception injection
  s390x/tcg: store in the TB flags if AFP is enabled
  s390x/tcg: support flags for instructions
  s390x/tcg: add instruction flags for floating point instructions
  s390x/tcg: check for AFP-register, BFP and DFP data exceptions
  s390x/tcg: handle privileged instructions via flags
  s390x/tcg: fix FP register pair checks
  s390x/tcg: refactor specification checking

 target/s390x/cpu.h         |   9 +
 target/s390x/excp_helper.c |  36 ++++
 target/s390x/fpu_helper.c  |  13 +-
 target/s390x/helper.h      |   1 +
 target/s390x/insn-data.def | 395 +++++++++++++++++++------------------
 target/s390x/interrupt.c   |  15 +-
 target/s390x/kvm.c         |   3 +-
 target/s390x/tcg-stub.c    |  10 +
 target/s390x/tcg_s390x.h   |   4 +
 target/s390x/translate.c   | 197 ++++++++----------
 10 files changed, 343 insertions(+), 340 deletions(-)

--=20
2.17.1
