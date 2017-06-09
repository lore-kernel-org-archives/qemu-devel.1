Received: from eggs.gnu.org ([2001:4830:134:3::10]:49990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dJKnb-0000aA-PO
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 10:22:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dJKna-00013X-RQ
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 10:22:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47478)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dJKna-00012y-L8
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 10:22:02 -0400
From: David Hildenbrand <david@redhat.com>
Date: Fri,  9 Jun 2017 16:21:54 +0200
Message-Id: <20170609142156.18767-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 0/2] PGM injection fix/rework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: rth@twiddle.net, agraf@suse.de, Aurelien Jarno <aurelien@aurel32.net>, thuth@redhat.com, david@redhat.com

We have various places where we inject suppressing PGM exceptions,
but don't forward the PSW. Let's fix that by detecting whether to
forward the PSW using the interception code.

We can now get rid of ILEN_LATER/ILEN_LATER_INC and replace it by
ILEN_AUTO, to automatically detect the instruction length using the
current PSW.

ILEN_AUTO is also used with program_interrupt(), so let's add it at the
right place.

To correctly identify nullifying PER events (and also that the guest can
identify them), we have to set the PER flag PER_CODE_EVENT_NULLIFICATION
accordingly.

This e.g. fixes TB (TEST BLOCK) program interrupts in Thomas' interception
handler kvm-unit-test.

David Hildenbrand (2):
  target/s390x: correctly indicate PER nullification
  target/s390x: rework PGM interrupt psw.addr handling

 target/s390x/cpu.h         |  7 ++-----
 target/s390x/helper.c      | 46 +++++++++++++++++++++++++++++++++++-----------
 target/s390x/misc_helper.c | 22 +++++++++-------------
 target/s390x/mmu_helper.c  |  6 +++---
 target/s390x/translate.c   |  3 +--
 5 files changed, 50 insertions(+), 34 deletions(-)

-- 
2.9.3
