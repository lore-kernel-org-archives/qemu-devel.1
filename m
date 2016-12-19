Received: from eggs.gnu.org ([2001:4830:134:3::10]:54518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vpalatin@google.com>) id 1cJ0kB-0007it-CN
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 11:24:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vpalatin@google.com>) id 1cJ0kA-0000PI-1F
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 11:24:55 -0500
Received: from mail-wj0-x22b.google.com ([2a00:1450:400c:c01::22b]:35331)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <vpalatin@google.com>) id 1cJ0k9-0000Oa-Nh
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 11:24:53 -0500
Received: by mail-wj0-x22b.google.com with SMTP id v7so154246462wjy.2
	for <qemu-devel@nongnu.org>; Mon, 19 Dec 2016 08:24:53 -0800 (PST)
Sender: Vincent Palatin <vpalatin@google.com>
From: Vincent Palatin <vpalatin@chromium.org>
Date: Mon, 19 Dec 2016 17:24:41 +0100
Message-Id: <cover.1482164622.git.vpalatin@chromium.org>
Subject: [Qemu-devel] [PATCH v5 0/4] Add HAX support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Yu Ning <yu.ning@linux.intel.com>, Stefan Weil <sw@weilnetz.de>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Vincent Palatin <vpalatin@chromium.org>

I took a stab at trying to rebase/upstream the support for Intel HAXM.
(Hardware Accelerated Execution Manager).
Intel HAX is kernel-based hardware acceleration module for Windows and MacOSX.

I have based my work on the last version of the source code I found:
the emu-2.2-release branch in the external/qemu-android repository as used by
the Android emulator.
In patch 2/4, I have forward-ported the core HAX code from there.
It has been modified to build and run along with the current code base.
It has been simplifying by removing non-UG hardware support / Darwin support /
Android-specific leftovers.

Intel nicely fixed the 2 remaining issues on the kernel side:
- the spurious request  to emulate MMIO access in un-paged mode is no longer
  happening (as seen in iPXE).
- the kernel API now provides a way to remove a memory mapping, so we can
  do a proper MemoryListener implementation.
They will publish soon a new version 6.1.0 of the HAX kernel module including
the fixes once their QA cycle is completed.
Thanks Yu Ning for making this happen.

In patch 3/4, I have put the plumbing into the QEMU code base, I did some clean
up there and it is reasonably intrusive: i.e.
 Makefile.target           |  1 +
 configure                 | 18 ++++++++++
 cpus.c                    | 87 ++++++++++++++++++++++++++++++++++++++++++++++-
 exec.c                    | 16 +++++++++
 hw/intc/apic_common.c     |  3 +-
 include/qom/cpu.h         |  5 +++
 include/sysemu/hw_accel.h |  9 +++++
 qemu-options.hx           | 11 ++++++
 target-i386/Makefile.objs |  4 +++
 vl.c                      | 15 ++++++--
 10 files changed, 164 insertions(+), 5 deletions(-)

The patch 1/4 just extracts from KVM specific header the cpu_synchronize_
functions that HAX is also using.

The patch 4/4 is the Darwin support. This part is only lightly tested for now,
so it can be considered as 'experimental'.

I have tested the end result on a Windows 10 Pro machine (with UG support)
with the Intel HAXM module dev version and a large ChromiumOS x86_64 image to
exercise various code paths. It looks stable.
I also did a quick regression testing of the integration by running a Linux
build with KVM enabled.

Changes from v4 to v5:
- update HAX fastmmio API with the new MMIO to MMIO transfer.

Changes from v3 to v4:
- add RAM unmapping in the MemoryListener thanks to new API in HAX module 6.1.0
  and re-wrote the memory mappings management to deal with this.
- marked no longer used MMIO emulation as unsupported.
- clean-up a few left-overs from removed code.
- re-add an experimental version of the Darwin support.

Changes from v2 to v3:
- fix saving/restoring FPU registers as suggested by Paolo.
- fix Windows build on all targets as contributed by Stefan Weil.
- clean-up IO / MMIO emulation.
- more clean-up of emulation leftovers.

Changes from v1 to v2:
- fix all style issues in the original code to get it through checkpatch.pl.
- remove Darwin support, it was barely tested and not fully functional.
- remove the support for CPU without UG mode.
- fix most review comments

Vincent Palatin (4):
  kvm: move cpu synchronization code
  target-i386: Add Intel HAX files
  Plumb the HAXM-based hardware acceleration support
  hax: add Darwin support

 Makefile.target             |    1 +
 configure                   |   18 +
 cpus.c                      |   93 +++-
 exec.c                      |   16 +
 gdbstub.c                   |    1 +
 hax-stub.c                  |   39 ++
 hw/i386/kvm/apic.c          |    1 +
 hw/i386/kvmvapic.c          |    1 +
 hw/intc/apic_common.c       |    3 +-
 hw/misc/vmport.c            |    2 +-
 hw/ppc/pnv_xscom.c          |    2 +-
 hw/ppc/ppce500_spin.c       |    4 +-
 hw/ppc/spapr.c              |    2 +-
 hw/ppc/spapr_hcall.c        |    2 +-
 hw/s390x/s390-pci-inst.c    |    1 +
 include/qom/cpu.h           |    5 +
 include/sysemu/hax.h        |   56 +++
 include/sysemu/hw_accel.h   |   48 ++
 include/sysemu/kvm.h        |   23 -
 monitor.c                   |    2 +-
 qemu-options.hx             |   11 +
 qom/cpu.c                   |    2 +-
 target-arm/cpu.c            |    2 +-
 target-i386/Makefile.objs   |    7 +
 target-i386/hax-all.c       | 1155 +++++++++++++++++++++++++++++++++++++++++++
 target-i386/hax-darwin.c    |  316 ++++++++++++
 target-i386/hax-darwin.h    |   63 +++
 target-i386/hax-i386.h      |   94 ++++
 target-i386/hax-interface.h |  361 ++++++++++++++
 target-i386/hax-mem.c       |  271 ++++++++++
 target-i386/hax-windows.c   |  479 ++++++++++++++++++
 target-i386/hax-windows.h   |   89 ++++
 target-i386/helper.c        |    1 +
 target-i386/kvm.c           |    1 +
 target-ppc/mmu-hash64.c     |    2 +-
 target-ppc/translate_init.c |    2 +-
 target-s390x/gdbstub.c      |    1 +
 vl.c                        |   15 +-
 38 files changed, 3153 insertions(+), 39 deletions(-)
 create mode 100644 hax-stub.c
 create mode 100644 include/sysemu/hax.h
 create mode 100644 include/sysemu/hw_accel.h
 create mode 100644 target-i386/hax-all.c
 create mode 100644 target-i386/hax-darwin.c
 create mode 100644 target-i386/hax-darwin.h
 create mode 100644 target-i386/hax-i386.h
 create mode 100644 target-i386/hax-interface.h
 create mode 100644 target-i386/hax-mem.c
 create mode 100644 target-i386/hax-windows.c
 create mode 100644 target-i386/hax-windows.h

-- 
2.8.0.rc3.226.g39d4020
