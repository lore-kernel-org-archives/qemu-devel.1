Received: from eggs.gnu.org ([2001:4830:134:3::10]:47531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1diH0b-0006Nc-40
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 05:22:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1diH0X-00009H-W4
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 05:22:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:23768)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1diH0X-00008j-PE
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 05:22:29 -0400
From: David Hildenbrand <david@redhat.com>
Date: Thu, 17 Aug 2017 11:22:15 +0200
Message-Id: <20170817092225.4264-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 for-2.11 00/10] target/s390x: cleanup cpu.h
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
internal.h and move a lot to that file. In addition, introduce
kvm-stub.c and kvm_390x.h for kvm specific functions.

Let's see what compilers think about this version.

RFC -> v1:
- (hopefully) fixed a compile error
- move some functions from cpu.h to the only c file they are used in
- move kvm function and stubs to kvm_s390x.h and kvm-stub.c
- smaller requested style fixes


David Hildenbrand (10):
  target/s390x: move cc_name() to cc_helper.c
  target/s390x: move cpu_mmu_idx_to_asc() to excp_helper.c
  target/s390x: move psw_key_valid() to mem_helper.c
  target/s390x: move s390_do_cpu_reset() to diag.c
  target/s390x: move get_per_in_range() to misc_helper.c
  target/s390x: introduce internal.h
  target/s390x: move a couple of functions to cpu.c
  s390x: avoid calling kvm_ functions outside of target/s390x/
  s390x/kvm: move KVM declarations and stubs to separate files
  target/s390x: cleanup cpu.h

 hw/s390x/s390-virtio-ccw.c |   4 +-
 target/s390x/Makefile.objs |   1 +
 target/s390x/arch_dump.c   |   1 +
 target/s390x/cc_helper.c   |  49 +++
 target/s390x/cpu.c         |  87 ++++++
 target/s390x/cpu.h         | 761 +++++----------------------------------------
 target/s390x/cpu_models.c  |   1 +
 target/s390x/diag.c        |   8 +
 target/s390x/excp_helper.c |  15 +
 target/s390x/fpu_helper.c  |   1 +
 target/s390x/gdbstub.c     |   1 +
 target/s390x/helper.c      |   1 +
 target/s390x/int_helper.c  |   1 +
 target/s390x/internal.h    | 391 +++++++++++++++++++++++
 target/s390x/interrupt.c   |   1 +
 target/s390x/ioinst.c      |   1 +
 target/s390x/kvm-stub.c    | 111 +++++++
 target/s390x/kvm.c         |   1 +
 target/s390x/kvm_s390x.h   |  51 +++
 target/s390x/machine.c     |   1 +
 target/s390x/mem_helper.c  |  12 +
 target/s390x/misc_helper.c |  12 +
 target/s390x/mmu_helper.c  |   1 +
 target/s390x/translate.c   |   1 +
 24 files changed, 820 insertions(+), 694 deletions(-)
 create mode 100644 target/s390x/internal.h
 create mode 100644 target/s390x/kvm-stub.c
 create mode 100644 target/s390x/kvm_s390x.h

-- 
2.9.4
