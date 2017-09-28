Received: from eggs.gnu.org ([2001:4830:134:3::10]:53223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dxfYb-0003XB-Qj
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 16:37:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dxfYX-0002yp-SY
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 16:37:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43778)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dxfYX-0002y0-Jd
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 16:37:13 -0400
From: David Hildenbrand <david@redhat.com>
Date: Thu, 28 Sep 2017 22:36:38 +0200
Message-Id: <20170928203708.9376-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 00/30] s390x: SMP for TCG
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, cohuck@redhat.com, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <richard.henderson@linaro.org>
List-ID: <qemu-devel.nongnu.org>

This series is based on a couple of other patches floating around on
the mailing list (e.g. cleanups and LAP). The fist patches of v1 have
been sent as a separate series.

As I am working on kvm-unit-tests for SIGP, I discovered some bugs that
have been fixed in this series.

======================================
I'll be on vacation until 15. October.
======================================

This series contains:
- properly implement local external interrupts for TCG. Take care of
  interrupt masks. Cleanup service interrupt handling.
- factor out KVM SIGP handling code into common code
- implement missing SIGP orders for TCG handled by the kernel for KVM
  (including STOP and RESTART interrupts)
- make TCG use the new SIGP code - experimental SMP support for s390x TCG
- refactor STFL(E) implementation for TCG
- bunch of cleanups

Basically all SIGP instructions are fully supported.

Thanks to Aurelien Jarno for the initital prototype and showcasing that
supporting experimental SMP code can be implemented quite easily.

CPU hotplug does still not work correctly.

v1 -> v2:
- "turn INTERRUPT_EXT into a mask"
-- fix one check (& vs |)
-- rename EXT_FLOATING to EXT_SERVICE
-- drop duplicate storing of interrupt parameters for queded ext irqa
- "s390x/tcg: cleanup service interrupt injectio"
-- added, as we don't have virtio irq anymore (for legacy transport)
- "s390x/tcg: rework checking for deliverable interrupts"
-- added, we actually check if interrupts are deliverable
- "s390x/tcg: take care of external interrupt subclasses"
-- properly check for the subclasses we implement
- "target/s390x: factor out handling of WAIT PSW into s390_handle_wait()"
-- renamed handle_wait() -> s390_handle_wait()
- "s390x/tcg: handle WAIT PSWs during interrupt injection"
-- any feedback if this is the right way to do it? needed for stop interrupts
- "target/s390x: interpret PSW_MASK_WAIT only for TCG"
-- identified while testing SIGP
- "s390x/kvm: pass ipb directly into handle_sigp()"
-- order parameters alphabetically
- "s390x/kvm: factor out storing of CPU status"
-- the rework/conversion has been integrated as a fix (Connys queue)
- "MAINTAINERS: use s390 KVM maintainers for target/s390x/sigp.c"
-- added as requested by Christian
- "s390x/tcg: implement STOP and RESET interrupts for TCG"
-- some change due to the way interrupts are handled after the rework
   for deliverable interrupts
- "s390x/cpumodel: allow to enable SENSE RUNNING STATUS for qemu"
-- added, because we implement SENSE RUNNING STATUS
- "target/s390x: special handling when starting a CPU with WAIT PSW"
-- identified while testing SIGP code


Based on: https://github.com/cohuck/qemu.git s390-next
Available on: https://github.com/davidhildenbrand/qemu.git s390x-queue

David Hildenbrand (30):
  s390x/tcg: turn INTERRUPT_EXT into a mask
  s390x/tcg: cleanup service interrupt injection
  s390x/tcg: injection of emergency signals and external calls
  s390x/tcg: rework checking for deliverable interrupts
  s390x/tcg: take care of external interrupt subclasses
  s390x/tcg: STOPPED cpus can never wake up
  s390x/tcg: a CPU cannot switch state due to an interrupt
  target/s390x: factor out handling of WAIT PSW into s390_handle_wait()
  s390x/tcg: handle WAIT PSWs during interrupt injection
  target/s390x: interpret PSW_MASK_WAIT only for TCG
  s390x/kvm: pass ipb directly into handle_sigp()
  s390x/kvm: generalize SIGP stop and restart interrupt injection
  s390x/kvm: factor out storing of CPU status
  s390x/kvm: factor out storing of adtl CPU status
  s390x/kvm: drop two debug prints
  s390x/kvm: factor out SIGP code into sigp.c
  MAINTAINERS: use s390 KVM maintainers for target/s390x/sigp.c
  s390x/kvm: factor out actual handling of STOP interrupts
  s390x/tcg: implement SIGP SENSE RUNNING STATUS
  s390x/tcg: implement SIGP SENSE
  s390x/tcg: implement SIGP EXTERNAL CALL
  s390x/tcg: implement SIGP EMERGENCY SIGNAL
  s390x/tcg: implement SIGP CONDITIONAL EMERGENCY SIGNAL
  s390x/tcg: implement STOP and RESET interrupts for TCG
  s390x/tcg: flush the tlb on SIGP SET PREFIX
  s390x/tcg: switch to new SIGP handling code
  s390x/cpumodel: allow to enable SENSE RUNNING STATUS for qemu
  s390x/tcg: unlock NMI
  s390x/tcg: refactor stfl(e) to use s390_get_feat_block()
  target/s390x: special handling when starting a CPU with WAIT PSW

 MAINTAINERS                |   1 +
 hw/s390x/s390-virtio-ccw.c |  11 +-
 target/s390x/Makefile.objs |   1 +
 target/s390x/cpu.c         |  35 ++--
 target/s390x/cpu.h         |  42 ++--
 target/s390x/cpu_models.c  |   1 +
 target/s390x/excp_helper.c | 116 +++++++----
 target/s390x/helper.c      | 132 ++++++++++--
 target/s390x/helper.h      |   2 +-
 target/s390x/internal.h    |  23 +-
 target/s390x/interrupt.c   | 172 ++++++++++++++-
 target/s390x/kvm-stub.c    |  13 +-
 target/s390x/kvm.c         | 491 +++----------------------------------------
 target/s390x/kvm_s390x.h   |   3 +-
 target/s390x/misc_helper.c | 109 ++++------
 target/s390x/sigp.c        | 508 +++++++++++++++++++++++++++++++++++++++++++++
 target/s390x/trace-events  |   4 +-
 target/s390x/translate.c   |  12 +-
 18 files changed, 1013 insertions(+), 663 deletions(-)
 create mode 100644 target/s390x/sigp.c

-- 
2.13.5
