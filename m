Received: from eggs.gnu.org ([2001:4830:134:3::10]:36195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dg4ey-0001gH-9Y
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 03:47:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dg4eu-0003C5-D8
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 03:47:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45362)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dg4eu-0003Az-6n
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 03:47:04 -0400
From: David Hildenbrand <david@redhat.com>
Date: Fri, 11 Aug 2017 09:46:47 +0200
Message-Id: <20170811074652.31474-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH RFC 0/5] target/s390x: introduce internal.h and
 cleanup cpu.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: rth@twiddle.net, Aurelien Jarno <aurelien@aurel32.net>, thuth@redhat.com, cohuck@redhat.com, david@redhat.com, borntraeger@de.ibm.com

cpu.h is accessed outside of target/s390x. It should only contain
what is expected to be accessed outside of this folder. Therefore, create
internal.h and move a lot to that file.

While doing that, I noticed that a lot of function prototypes not
available with CONFIG_USER_ONLY are not protected by CONFIG_USER_ONLY.

As these CONFIG_USER_ONLY are in general ugly, I decided to minimize
them to the bare minimum :]. Do we care? I dropped it wherever possible.

My compiler doesn't bail out, so let's see what the bot says.

There is still a lot to clean up (e.g. do we want kvm-stub.c ?). This is
the first step.

David Hildenbrand (5):
  target/s390x: introduce internal.h
  target/s390x: move a couple of functions to cpu.c
  s390x: avoid calling kvm_ functions outside of target/s390x/
  target/s390x: remove all CONFIG_KVM from cpu.h
  target/s390x: cleanup cpu.h

 hw/s390x/s390-virtio-ccw.c |   4 +-
 target/s390x/arch_dump.c   |   1 +
 target/s390x/cc_helper.c   |   1 +
 target/s390x/cpu.c         |  87 ++++++
 target/s390x/cpu.h         | 759 +++++----------------------------------------
 target/s390x/cpu_models.c  |   1 +
 target/s390x/diag.c        |   1 +
 target/s390x/excp_helper.c |   1 +
 target/s390x/fpu_helper.c  |   1 +
 target/s390x/gdbstub.c     |   1 +
 target/s390x/helper.c      |   1 +
 target/s390x/int_helper.c  |   1 +
 target/s390x/internal.h    | 612 ++++++++++++++++++++++++++++++++++++
 target/s390x/interrupt.c   |   1 +
 target/s390x/ioinst.c      |   1 +
 target/s390x/kvm.c         |   1 +
 target/s390x/machine.c     |   1 +
 target/s390x/mem_helper.c  |   1 +
 target/s390x/misc_helper.c |   1 +
 target/s390x/mmu_helper.c  |   1 +
 target/s390x/translate.c   |   1 +
 21 files changed, 787 insertions(+), 692 deletions(-)
 create mode 100644 target/s390x/internal.h

-- 
2.9.4
