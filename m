Received: from eggs.gnu.org ([2001:4830:134:3::10]:58306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e5Vsm-00020h-GL
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 07:54:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e5Vsi-0002hk-Jc
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 07:54:32 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri, 20 Oct 2017 13:53:32 +0200
Message-Id: <20171020115418.2050-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/46] more s390x patches for 2.11
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, Cornelia Huck <cohuck@redhat.com>

The following changes since commit e67277f8f32d56c64c7993163f41bb4338aec5=
66:

  Merge remote-tracking branch 'remotes/stefanberger/tags/pull-tpm-2017-1=
0-19-1' into staging (2017-10-20 10:49:55 +0100)

are available in the git repository at:

  git://github.com/cohuck/qemu tags/s390x-20171020

for you to fetch changes up to 2bcf018340cbf233f7145e643fc1bb367f23fd90:

  s390x/tcg: low-address protection support (2017-10-20 13:32:10 +0200)

----------------------------------------------------------------
The last big chunk of s390x changes:
- (experimental) smp support under tcg
- provide the virtio-input devices for virtio-ccw
- improve error handling in the css code
- enable some simple virtio tests for s390x
- low-address protection in tcg
- some more cleanups and fixes

----------------------------------------------------------------

Cornelia Huck (2):
  s390x/MAINTAINERS: add mailing list
  s390x/event-facility: variable-length event masks

David Hildenbrand (31):
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
  accel/tcg: allow to invalidate a write TLB entry immediately
  s390x/tcg: low-address protection support

Eric Blake (1):
  libqtest: Add qtest_[v]startf()

Farhan Ali (1):
  virtio-ccw: Add the virtio-input devices for CCW bus

Halil Pasic (7):
  s390x/css: be more consistent if broken beyond repair
  s390x/css: IO instr handler ending control
  s390x: improve error handling for SSCH and RSCH
  s390x: refactor error handling for XSCH handler
  s390x: refactor error handling for CSCH handler
  s390x: refactor error handling for HSCH handler
  s390x: refactor error handling for MSCH handler

Igor Mammedov (2):
  s390x: fix cpu object referrence leak in s390x_new_cpu()
  s390x: move s390x_new_cpu() into board code

Marc-Andr=C3=A9 Lureau (1):
  S390: use g_new() family of functions

Thomas Huth (1):
  tests: Enable the very simple virtio tests on s390x, too

 MAINTAINERS                       |   7 +
 accel/tcg/cputlb.c                |   5 +-
 accel/tcg/softmmu_template.h      |   4 +-
 hw/s390x/css.c                    | 173 ++++---------
 hw/s390x/event-facility.c         |  35 ++-
 hw/s390x/s390-ccw.c               |  11 +-
 hw/s390x/s390-pci-bus.c           |   4 +-
 hw/s390x/s390-virtio-ccw.c        |  32 ++-
 hw/s390x/virtio-ccw.c             | 100 ++++++++
 hw/s390x/virtio-ccw.h             |  22 ++
 hw/vfio/ccw.c                     |  28 ++-
 include/exec/cpu-all.h            |   3 +
 include/hw/s390x/css.h            |  47 +++-
 include/hw/s390x/event-facility.h |  20 +-
 include/hw/s390x/s390-ccw.h       |   2 +-
 target/s390x/Makefile.objs        |   1 +
 target/s390x/cpu.c                |  35 +--
 target/s390x/cpu.h                |  43 ++--
 target/s390x/cpu_models.c         |  13 +-
 target/s390x/diag.c               |   2 +-
 target/s390x/excp_helper.c        | 119 +++++----
 target/s390x/helper.c             | 152 +++++++++---
 target/s390x/helper.h             |   2 +-
 target/s390x/insn-data.def        |   2 +-
 target/s390x/internal.h           |  23 +-
 target/s390x/interrupt.c          | 172 ++++++++++++-
 target/s390x/ioinst.c             | 136 ++--------
 target/s390x/kvm-stub.c           |  13 +-
 target/s390x/kvm.c                | 491 ++------------------------------=
----
 target/s390x/kvm_s390x.h          |   3 +-
 target/s390x/mem_helper.c         |   8 -
 target/s390x/misc_helper.c        | 109 +++-----
 target/s390x/mmu_helper.c         |  96 ++++---
 target/s390x/sigp.c               | 508 ++++++++++++++++++++++++++++++++=
++++++
 target/s390x/trace-events         |   4 +-
 target/s390x/translate.c          |  12 +-
 tests/Makefile.include            |   9 +-
 tests/boot-order-test.c           |  11 +-
 tests/boot-serial-test.c          |  12 +-
 tests/endianness-test.c           |  33 +--
 tests/ipmi-bt-test.c              |  11 +-
 tests/libqtest.c                  |  22 ++
 tests/libqtest.h                  |  25 ++
 tests/m25p80-test.c               |   9 +-
 tests/pnv-xscom-test.c            |  16 +-
 tests/prom-env-test.c             |  13 +-
 tests/tco-test.c                  |  10 +-
 tests/test-filter-mirror.c        |  14 +-
 tests/test-filter-redirector.c    |  56 ++---
 tests/virtio-balloon-test.c       |   8 +-
 tests/virtio-blk-test.c           |   5 +-
 tests/virtio-console-test.c       |  19 +-
 tests/virtio-serial-test.c        |  10 +-
 tests/vmgenid-test.c              |  29 +--
 54 files changed, 1581 insertions(+), 1168 deletions(-)
 create mode 100644 target/s390x/sigp.c

--=20
2.13.6
