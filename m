Received: from eggs.gnu.org ([2001:4830:134:3::10]:56072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fEKFM-00027J-7i
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:50:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fEKFI-0001wo-OP
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:50:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41886 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fEKFG-0001qz-AC
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:50:26 -0400
Date: Thu, 3 May 2018 22:50:14 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1525376963-79623-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PATCH 00/67] include path cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, berrange@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org

At the moment during build we have multiple subdirectories of the source
tree on the search path for include files.  This includes source
directory itself, tcg and accel/tcg subdirectories, target-specific
source subdirectory and the include subdirectory.

The result is that there are many ways to include each
specific file, e.g. for a file in the include directory:

#include "dir/foo.h"
#include "include/dir/foo.h"

(We actually do both).

OTOH local headers can be included with
#include "foo.h"
#include "dir/foo.h"

There are also target-specific headers and they are even
trickier - e.g. try to guess which file does
#include "cpu.h"
pull in?  The answer actually depends on which target is built.

It is also quite easy to place an external header outside of
include/ as nothing will catch this misuse.

In an attempt to simplify this situation, this changes the build to look
for headers in a single directory under the source tree: include/
(generated files are still spread around a bit, this is left for another
patchset - and RFC of that I posted earlier).

This way, one can always find any header under include/
(and sometimes follow from there to another directory).

A nice side effect of this refactoring is that it makes it easy to
identify external headers which are not under include/.

I decided not to actually move any headers around -
instead I created small stub files using include_next
which pull in the original files.

This way we can move the headers gradually - in particular it is often
benefitial to split a header up with external parts under include and
internal ones with the source.

Note that it's already benefitial even in this form, since
- it's now easy to see there is an external header outside include
  that requires work
- reader can simply look at the header and immediately know
  where to look for it

Target specific files are pulled in using preprocessor which is still
tricky but arguably easier to understand than makefile tricks.

This patchset has patches of 3 types:
- general code cleanups - mostly pulling in
  internal headers using #include "foo.h"
  but also removing some unused includes where
  it was clear.
  I expect this part to be very uncontroversial.
- switching to preprocessor for target-specific headers
- adding include stubs for external headers that
  do not reside under include
- a final patch that drops include directories except include/

Please review, and comment.

Michael S. Tsirkin (67):
  block: use local path for local headers
  crypto: use local path for local headers
  hppa: use local path for local headers
  s390x: drop an unused include
  migration: drop an unused include, add a used one
  trace: use local path for local headers
  display: use local path for local headers
  ide: use local path for local headers
  ioapic: fix up includes
  e1000e: use local path for local headers
  rocker: drop an unused include
  ppc: use local path for local headers
  vhost-scsi: drop an unused include
  sd: fix up include
  usb: use local path for local headers
  migration: use local path for local headers
  colo: use local path for local headers
  qga: use local path for local headers
  xtensa: relative include for parent directory
  tests: relative include for child directory
  trace: use local path for local headers
  ui: use local path for local headers
  slirp: add include directory headers
  net: add include directory headers
  arch_init: sort architectures
  cpu: replace command line flags with preprocessor
  replication: add include directory header
  9pfs: add include directory headers
  fsdev: add include directory headers
  audio: add include directory header
  target/cris: add include directory header
  ui: add include directory header
  hw/net: add include directory header
  hw/ppc: add include directory headers
  hw/usb: add include directory header
  migration: add include directory headers
  tcg: add include directory headers
  helper: replace command line flags with preprocessor
  target: replace command line flags with preprocessor
  trace: add include directory headers
  tcg-pool.inc.c: replace command line flags with preprocessor
  tcg: use include "tcg.h" consistently
  translate-all: add include directory header
  tcg-ldst.inc.c: replace command line flags with preprocessor
  tcg: add include directory headers
  cpu-qom: add include directory headers
  tcg-op: use include "tcg.h" consistently
  virtio-pci: add include directory header
  kvm_XXX: add include directory headers
  hmp: add include directory header
  hyperv: add include directory header
  target/arm: add include directory headers
  target/ppc: add include directory headers
  amd_iommu: add include directory header
  amd_iommu: add include directory header
  tcg: use include "tcg-gvec-desc.h.h" consistently
  kvm: use include "kvm_i386.h" consistently
  target/riscv: add include directory header
  hw/ppc: add target headers explicitly
  hw/s390x: add include directory headers
  hw/net: add include directory header
  kvm: use include "kvm_ppc.h" consistently
  hw/s390x: use target headers explicitly
  target/s390x: add include directory header
  tcg: use include "translate-all.h" consistently
  linux-user: add include directory header
  make: simplify source include path

 configure                                          |  3 +-
 crypto/block-luks.h                                |  2 +-
 crypto/block-qcow.h                                |  2 +-
 crypto/ivgen-essiv.h                               |  2 +-
 crypto/ivgen-plain.h                               |  2 +-
 crypto/ivgen-plain64.h                             |  2 +-
 hw/hppa/hppa_sys.h                                 |  2 +-
 include/arm-powerctl.h                             |  1 +
 include/audio/audio.h                              |  1 +
 include/cpu.h                                      |  2 +
 include/exec/helper.h                              |  2 +
 include/exec/translator.h                          |  2 +-
 include/fsdev/9p-iov-marshal.h                     |  1 +
 include/fsdev/file-op-9p.h                         |  1 +
 include/fsdev/qemu-fsdev.h                         |  1 +
 include/hmp.h                                      |  1 +
 include/hw/9pfs/9p-proxy.h                         |  1 +
 include/hw/9pfs/virtio-9p.h                        |  1 +
 include/hw/i386/amd_iommu.h                        |  1 +
 include/hw/net/fsl_etsec/etsec.h                   |  1 +
 include/hw/net/pcnet.h                             |  1 +
 include/hw/ppc/e500-ccsr.h                         |  1 +
 include/hw/ppc/mac.h                               |  1 +
 include/hw/s390x/ccw-device.h                      |  1 +
 include/hw/s390x/ipl.h                             |  1 +
 include/hw/s390x/s390-pci-bus.h                    |  1 +
 include/hw/s390x/s390-pci-inst.h                   |  1 +
 include/hw/s390x/s390-virtio-hcall.h               |  1 +
 include/hw/s390x/sclp.h                            |  3 +-
 include/hw/s390x/virtio-ccw.h                      |  1 +
 include/hw/usb/hcd-ehci.h                          |  1 +
 include/hw/virtio/virtio-pci.h                     |  1 +
 include/kvm_arm.h                                  |  1 +
 include/kvm_i386.h                                 |  1 +
 include/kvm_mips.h                                 |  1 +
 include/kvm_ppc.h                                  |  1 +
 include/kvm_s390x.h                                |  1 +
 include/linux-user/syscall_defs.h                  |  1 +
 include/migration/migration.h                      |  1 +
 include/migration/postcopy-ram.h                   |  1 +
 include/migration/qemu-file.h                      |  1 +
 include/migration/vmstate.h                        |  4 +-
 include/net/hub.h                                  |  1 +
 include/replication.h                              |  1 +
 include/slirp/ip6.h                                |  1 +
 include/slirp/libslirp.h                           |  1 +
 include/slirp/slirp.h                              |  1 +
 include/target-dir.h                               | 63 ++++++++++++++++++++++
 include/target/alpha/cpu-qom.h                     |  1 +
 include/target/arm/cpu-qom.h                       |  1 +
 include/target/arm/cpu.h                           |  1 +
 include/target/arm/idau.h                          |  1 +
 include/target/cris/cpu-qom.h                      |  1 +
 include/target/cris/opcode-cris.h                  |  1 +
 include/target/hppa/cpu-qom.h                      |  1 +
 include/target/i386/cpu-qom.h                      |  1 +
 include/target/i386/cpu.h                          |  1 +
 include/target/i386/hyperv.h                       |  1 +
 include/target/lm32/cpu-qom.h                      |  1 +
 include/target/m68k/cpu-qom.h                      |  1 +
 include/target/microblaze/cpu-qom.h                |  1 +
 include/target/mips/cpu-qom.h                      |  1 +
 include/target/ppc/cpu-models.h                    |  1 +
 include/target/ppc/cpu-qom.h                       |  1 +
 include/target/ppc/cpu.h                           |  1 +
 include/target/ppc/helper_regs.h                   |  1 +
 include/target/ppc/mmu-book3s-v3.h                 |  1 +
 include/target/ppc/mmu-hash64.h                    |  1 +
 include/target/riscv/cpu.h                         |  1 +
 include/target/s390x/cpu-qom.h                     |  1 +
 include/target/s390x/cpu_models.h                  |  1 +
 include/target/sh4/cpu-qom.h                       |  1 +
 include/target/sparc/cpu-qom.h                     |  1 +
 include/target/tricore/cpu-qom.h                   |  1 +
 include/target/unicore32/cpu-qom.h                 |  1 +
 include/target/xtensa/cpu-qom.h                    |  1 +
 include/tcg-gvec-desc.h                            |  1 +
 include/tcg-mo.h                                   |  1 +
 include/tcg-op-gvec.h                              |  1 +
 include/tcg-op.h                                   |  1 +
 include/tcg-runtime.h                              |  1 +
 include/tcg.h                                      |  1 +
 include/tcg/tcg-gvec-desc.h                        |  1 +
 include/trace/mem-internal.h                       |  1 +
 include/trace/mem.h                                |  1 +
 include/translate-all.h                            |  1 +
 include/ui/vnc.h                                   |  1 +
 trace/control.h                                    |  2 +-
 trace/mem.h                                        |  2 +-
 accel/stubs/tcg-stub.c                             |  2 +-
 accel/tcg/cputlb.c                                 |  2 +-
 accel/tcg/tcg-runtime-gvec.c                       |  2 +-
 accel/tcg/translator.c                             |  4 +-
 arch_init.c                                        | 16 +++---
 block/crypto.c                                     |  2 +-
 block/nbd.c                                        |  2 +-
 block/qcow.c                                       |  2 +-
 block/qcow2-bitmap.c                               |  2 +-
 block/qcow2-cluster.c                              |  2 +-
 block/qcow2-refcount.c                             |  2 +-
 block/qcow2-snapshot.c                             |  2 +-
 block/qcow2.c                                      |  4 +-
 block/vhdx-endian.c                                |  2 +-
 block/vhdx-log.c                                   |  2 +-
 block/vhdx.c                                       |  2 +-
 crypto/block-luks.c                                |  2 +-
 crypto/block-qcow.c                                |  2 +-
 crypto/block.c                                     |  6 +--
 crypto/cipher.c                                    |  6 +--
 crypto/ivgen-essiv.c                               |  2 +-
 crypto/ivgen-plain.c                               |  2 +-
 crypto/ivgen-plain64.c                             |  2 +-
 crypto/ivgen.c                                     |  8 +--
 crypto/tlscreds.c                                  |  2 +-
 crypto/tlscredsanon.c                              |  2 +-
 crypto/tlscredsx509.c                              |  2 +-
 disas/tci.c                                        |  2 +-
 hw/display/bcm2835_fb.c                            |  2 +-
 hw/hppa/machine.c                                  |  2 +-
 hw/i386/kvm/apic.c                                 |  2 +-
 hw/i386/kvmvapic.c                                 |  2 +-
 hw/ide/ahci-allwinner.c                            |  2 +-
 hw/ide/ahci.c                                      |  2 +-
 hw/ide/ich.c                                       |  2 +-
 hw/intc/ioapic.c                                   |  3 +-
 hw/net/e1000e.c                                    |  2 +-
 hw/net/rocker/rocker_fp.c                          |  1 -
 hw/ppc/ppc440_uc.c                                 |  2 +-
 hw/ppc/sam460ex.c                                  |  4 +-
 hw/ppc/spapr.c                                     |  6 +--
 hw/ppc/spapr_caps.c                                |  2 +-
 hw/ppc/spapr_cpu_core.c                            |  2 +-
 hw/ppc/spapr_hcall.c                               |  4 +-
 hw/s390x/s390-virtio-ccw.c                         |  2 +-
 hw/scsi/vhost-scsi-common.c                        |  1 -
 hw/sd/milkymist-memcard.c                          |  2 +-
 hw/usb/desc-msos.c                                 |  2 +-
 hw/usb/desc.c                                      |  2 +-
 hw/usb/dev-audio.c                                 |  2 +-
 hw/usb/dev-bluetooth.c                             |  2 +-
 hw/usb/dev-hid.c                                   |  2 +-
 hw/usb/dev-hub.c                                   |  2 +-
 hw/usb/dev-mtp.c                                   |  2 +-
 hw/usb/dev-network.c                               |  2 +-
 hw/usb/dev-serial.c                                |  2 +-
 hw/usb/dev-smartcard-reader.c                      |  2 +-
 hw/usb/dev-storage.c                               |  2 +-
 hw/usb/dev-uas.c                                   |  2 +-
 hw/usb/dev-wacom.c                                 |  2 +-
 include/tcg-ldst.inc.c                             |  1 +
 include/tcg-pool.inc.c                             |  1 +
 migration/block-dirty-bitmap.c                     |  2 +-
 migration/page_cache.c                             |  2 +-
 migration/ram.c                                    |  4 +-
 migration/savevm.c                                 |  1 +
 migration/vmstate.c                                |  2 +-
 net/colo-compare.c                                 |  2 +-
 net/colo.c                                         |  2 +-
 net/filter-rewriter.c                              |  2 +-
 qga/channel-posix.c                                |  2 +-
 qga/channel-win32.c                                |  4 +-
 qga/commands-posix.c                               |  2 +-
 qga/commands-win32.c                               |  2 +-
 qga/commands.c                                     |  2 +-
 qga/guest-agent-command-state.c                    |  2 +-
 qga/main.c                                         |  4 +-
 qga/vss-win32.c                                    |  2 +-
 target/xtensa/core-dc232b/xtensa-modules.inc.c     |  4 +-
 target/xtensa/core-dc233c/xtensa-modules.inc.c     |  4 +-
 target/xtensa/core-de212/xtensa-modules.inc.c      |  4 +-
 target/xtensa/core-fsf/xtensa-modules.inc.c        |  4 +-
 .../core-sample_controller/xtensa-modules.inc.c    |  4 +-
 target/xtensa/op_helper.c                          |  2 +-
 tcg/tcg-common.c                                   |  2 +-
 tcg/tci.c                                          |  2 +-
 tests/migration-test.c                             |  2 +-
 tests/pkix_asn1_tab.c                              |  2 +-
 trace/qmp.c                                        |  2 +-
 ui/gtk.c                                           |  2 +-
 ui/input-keymap.c                                  |  2 +-
 ui/input-legacy.c                                  |  2 +-
 ui/spice-input.c                                   |  2 +-
 Makefile.target                                    |  2 +-
 183 files changed, 276 insertions(+), 133 deletions(-)
 create mode 100644 include/arm-powerctl.h
 create mode 100644 include/audio/audio.h
 create mode 100644 include/cpu.h
 create mode 100644 include/exec/helper.h
 create mode 100644 include/fsdev/9p-iov-marshal.h
 create mode 100644 include/fsdev/file-op-9p.h
 create mode 100644 include/fsdev/qemu-fsdev.h
 create mode 100644 include/hmp.h
 create mode 100644 include/hw/9pfs/9p-proxy.h
 create mode 100644 include/hw/9pfs/virtio-9p.h
 create mode 100644 include/hw/i386/amd_iommu.h
 create mode 100644 include/hw/net/fsl_etsec/etsec.h
 create mode 100644 include/hw/net/pcnet.h
 create mode 100644 include/hw/ppc/e500-ccsr.h
 create mode 100644 include/hw/ppc/mac.h
 create mode 100644 include/hw/s390x/ccw-device.h
 create mode 100644 include/hw/s390x/ipl.h
 create mode 100644 include/hw/s390x/s390-pci-bus.h
 create mode 100644 include/hw/s390x/s390-pci-inst.h
 create mode 100644 include/hw/s390x/s390-virtio-hcall.h
 create mode 100644 include/hw/s390x/virtio-ccw.h
 create mode 100644 include/hw/usb/hcd-ehci.h
 create mode 100644 include/hw/virtio/virtio-pci.h
 create mode 100644 include/kvm_arm.h
 create mode 100644 include/kvm_i386.h
 create mode 100644 include/kvm_mips.h
 create mode 100644 include/kvm_ppc.h
 create mode 100644 include/kvm_s390x.h
 create mode 100644 include/linux-user/syscall_defs.h
 create mode 100644 include/migration/migration.h
 create mode 100644 include/migration/postcopy-ram.h
 create mode 100644 include/migration/qemu-file.h
 create mode 100644 include/net/hub.h
 create mode 100644 include/replication.h
 create mode 100644 include/slirp/ip6.h
 create mode 100644 include/slirp/libslirp.h
 create mode 100644 include/slirp/slirp.h
 create mode 100644 include/target-dir.h
 create mode 100644 include/target/alpha/cpu-qom.h
 create mode 100644 include/target/arm/cpu-qom.h
 create mode 100644 include/target/arm/cpu.h
 create mode 100644 include/target/arm/idau.h
 create mode 100644 include/target/cris/cpu-qom.h
 create mode 100644 include/target/cris/opcode-cris.h
 create mode 100644 include/target/hppa/cpu-qom.h
 create mode 100644 include/target/i386/cpu-qom.h
 create mode 100644 include/target/i386/cpu.h
 create mode 100644 include/target/i386/hyperv.h
 create mode 100644 include/target/lm32/cpu-qom.h
 create mode 100644 include/target/m68k/cpu-qom.h
 create mode 100644 include/target/microblaze/cpu-qom.h
 create mode 100644 include/target/mips/cpu-qom.h
 create mode 100644 include/target/ppc/cpu-models.h
 create mode 100644 include/target/ppc/cpu-qom.h
 create mode 100644 include/target/ppc/cpu.h
 create mode 100644 include/target/ppc/helper_regs.h
 create mode 100644 include/target/ppc/mmu-book3s-v3.h
 create mode 100644 include/target/ppc/mmu-hash64.h
 create mode 100644 include/target/riscv/cpu.h
 create mode 100644 include/target/s390x/cpu-qom.h
 create mode 100644 include/target/s390x/cpu_models.h
 create mode 100644 include/target/sh4/cpu-qom.h
 create mode 100644 include/target/sparc/cpu-qom.h
 create mode 100644 include/target/tricore/cpu-qom.h
 create mode 100644 include/target/unicore32/cpu-qom.h
 create mode 100644 include/target/xtensa/cpu-qom.h
 create mode 100644 include/tcg-gvec-desc.h
 create mode 100644 include/tcg-mo.h
 create mode 100644 include/tcg-op-gvec.h
 create mode 100644 include/tcg-op.h
 create mode 100644 include/tcg-runtime.h
 create mode 100644 include/tcg.h
 create mode 100644 include/tcg/tcg-gvec-desc.h
 create mode 100644 include/trace/mem-internal.h
 create mode 100644 include/trace/mem.h
 create mode 100644 include/translate-all.h
 create mode 100644 include/ui/vnc.h
 create mode 100644 include/tcg-ldst.inc.c
 create mode 100644 include/tcg-pool.inc.c

-- 
MST
