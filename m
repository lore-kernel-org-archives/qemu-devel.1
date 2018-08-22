Received: from eggs.gnu.org ([2001:4830:134:3::10]:34833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fsOAX-0001qi-PO
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 04:07:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fsO1b-0000xV-CC
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 03:57:59 -0400
From: David Hildenbrand <david@redhat.com>
Date: Wed, 22 Aug 2018 09:57:42 +0200
Message-Id: <20180822075750.12399-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v1 0/8] s390x/tcg: instruction flags and AFP
 registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>

I wanted to add AFP-register control related checks for a long time.
However, doing these checks in each and every relevant handler is ugly.

As I will need similar checks for vector instructions (yes, I'm looking i=
nto
that but it might take some time), I decided to introduce per-instruction
flags, that allow to to check such "instruction properties" globally.
Tagging e.g. privileged instructions that way turns out quite nice.

Of course, while at it some fixes and cleanups.

David Hildenbrand (8):
  s390x/tcg: factor out and fix DATA exception injection
  s390x/tcg: store in the TB flags if AFP is enabled
  s390x/tcg: support flags for instructions
  s390x/tcg: add instruction flags for floating point instructions
  s390x/tcg: check for AFP-register, BFP and DFP data exceptions
  s390x/tcg: handle privileged instructions via flags
  s390x/tcg: fix FP register pair checks
  s390x/tcg: refactor specification checking

 target/s390x/cpu.h         |   9 +
 target/s390x/excp_helper.c |  28 +++
 target/s390x/fpu_helper.c  |  13 +-
 target/s390x/helper.h      |   1 +
 target/s390x/insn-data.def | 395 +++++++++++++++++++------------------
 target/s390x/tcg_s390x.h   |   2 +
 target/s390x/translate.c   | 197 ++++++++----------
 7 files changed, 320 insertions(+), 325 deletions(-)

--=20
2.17.1
