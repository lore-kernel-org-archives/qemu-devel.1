Received: from eggs.gnu.org ([2001:4830:134:3::10]:49203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1difh6-0001pO-OK
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 07:44:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1difh2-00076i-S6
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 07:44:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47622)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1difh2-00076T-IA
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 07:44:00 -0400
From: David Hildenbrand <david@redhat.com>
Date: Fri, 18 Aug 2017 13:43:35 +0200
Message-Id: <20170818114353.13455-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v3 for-2.11 00/18] target/s390x: cleanup cpu.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: rth@twiddle.net, Aurelien Jarno <aurelien@aurel32.net>, thuth@redhat.com, cohuck@redhat.com, david@redhat.com, borntraeger@de.ibm.com, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

... now featuring even more cleanups.

cpu.h is accessed outside of target/s390x. It should only contain
what is expected to be accessed outside of this folder. Therefore, create
internal.h and move a lot to that file. In addition, introduce
kvm-stub.c and kvm_390x.h for kvm specific functions.

Hopefully I haven't messed anything up. This now also compiles with
--disable-tcg.

v1 -> v2:
- Smaller style fixes.
- avoid CONFIG_KVM for "struct kvm_s390_irq" by using forward declaration.
- added a bunch of additional cleanup patches to remove as much dependency
  to kvm as possible for now. cpu.h will not include sysemu/kvm.h anymore.
- move cc_name() to helper.c instead of cc_helper.c (to fix --disable-tcg)

RFC -> v1:
- (hopefully) fixed a compile error
- move some functions from cpu.h to the only c file they are used in
- move kvm function and stubs to kvm_s390x.h and kvm-stub.c
- smaller requested style fixes


David Hildenbrand (18):
  s390x/kvm: drop KVMState parameter from s390_get_memslot_count()
  s390x/kvm: drop KVMState parameter from kvm_s390_set_mem_limit()
  target/s390x: simplify ri_allowed()
  target/s390x: simplify gs_allowed()
  target/s390x: no need to pass kvm_state to savevm_gtod handlers
  s390x/cpumodel: factor out determination of default model name
  s390x: drop inclusion of sysemu/kvm.h from some files
  target/s390x: move gtod_*() declarations to s390-virtio.h
  target/s390x: move cc_name() to helper.c
  target/s390x: move cpu_mmu_idx_to_asc() to excp_helper.c
  target/s390x: move psw_key_valid() to mem_helper.c
  target/s390x: move s390_do_cpu_reset() to diag.c
  target/s390x: move get_per_in_range() to misc_helper.c
  target/s390x: introduce internal.h
  target/s390x: move a couple of functions to cpu.c
  s390x: avoid calling kvm_ functions outside of target/s390x/
  s390x/kvm: move KVM declarations and stubs to separate files
  target/s390x: cleanup cpu.h

 hw/intc/s390_flic_kvm.c      |   1 +
 hw/s390x/s390-stattrib-kvm.c |   1 +
 hw/s390x/s390-stattrib.c     |   2 +-
 hw/s390x/s390-virtio-ccw.c   |  23 +-
 hw/s390x/s390-virtio.c       |   7 +-
 hw/s390x/s390-virtio.h       |   2 +
 hw/s390x/sclp.c              |   3 +-
 hw/s390x/sclpcpu.c           |   1 -
 include/hw/s390x/css.h       |   1 +
 target/s390x/Makefile.objs   |   1 +
 target/s390x/arch_dump.c     |   2 +-
 target/s390x/cc_helper.c     |   1 +
 target/s390x/cpu.c           |  89 +++++
 target/s390x/cpu.h           | 759 ++++---------------------------------------
 target/s390x/cpu_models.c    |  11 +
 target/s390x/diag.c          |   8 +
 target/s390x/excp_helper.c   |  15 +
 target/s390x/fpu_helper.c    |   1 +
 target/s390x/gdbstub.c       |   1 +
 target/s390x/helper.c        |  49 +++
 target/s390x/int_helper.c    |   1 +
 target/s390x/internal.h      | 391 ++++++++++++++++++++++
 target/s390x/interrupt.c     |   2 +
 target/s390x/ioinst.c        |   1 +
 target/s390x/kvm-stub.c      | 111 +++++++
 target/s390x/kvm.c           |  18 +-
 target/s390x/kvm_s390x.h     |  47 +++
 target/s390x/machine.c       |   2 +
 target/s390x/mem_helper.c    |  12 +
 target/s390x/misc_helper.c   |  12 +
 target/s390x/mmu_helper.c    |   2 +
 target/s390x/translate.c     |   1 +
 32 files changed, 849 insertions(+), 729 deletions(-)
 create mode 100644 target/s390x/internal.h
 create mode 100644 target/s390x/kvm-stub.c
 create mode 100644 target/s390x/kvm_s390x.h

-- 
2.9.4
