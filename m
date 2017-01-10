Received: from eggs.gnu.org ([2001:4830:134:3::10]:50334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cQvGK-0003nz-2J
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 07:10:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cQvGF-0004m0-Lj
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 07:10:48 -0500
Received: from mail-wj0-x242.google.com ([2a00:1450:400c:c01::242]:33917)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cQvGF-0004k9-CN
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 07:10:43 -0500
Received: by mail-wj0-x242.google.com with SMTP id qs7so49756100wjc.1
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 04:10:42 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <cover.1484045952.git.vpalatin@chromium.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <14a7e2c0-cee4-5948-eb46-c745eae25a1f@redhat.com>
Date: Tue, 10 Jan 2017 13:10:38 +0100
MIME-Version: 1.0
In-Reply-To: <cover.1484045952.git.vpalatin@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 0/4] Add HAX support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vincent Palatin <vpalatin@chromium.org>, qemu-devel <qemu-devel@nongnu.org>
Cc: Yu Ning <yu.ning@linux.intel.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Stefan Weil <sw@weilnetz.de>, Marcelo Tosatti <mtosatti@redhat.com>

On 10/01/2017 11:59, Vincent Palatin wrote:
> I took a stab at trying to rebase/upstream the support for Intel HAXM.
> (Hardware Accelerated Execution Manager).
> Intel HAX is kernel-based hardware acceleration module for Windows and MacOSX.
> 
> Another copy of this patchset is available at:
> I have made another public copy there:
> git://github.com/vpalatin/qemu.git tags/hax-v6-pull-request
> 
> https://github.com/vpalatin/qemu/tree/hax-v6-pull-request
> 
> I have based my work on the last version of the source code I found:
> the emu-2.2-release branch in the external/qemu-android repository as used by
> the Android emulator.
> In patch 2/4, I have forward-ported the core HAX code from there.
> It has been modified to build and run along with the current code base.
> It has been simplifying by removing non-UG hardware support / Darwin support /
> Android-specific leftovers.
> 
> This code depends on the new unmapping mechanism and fixes in Intel HAX kernel
> module. They will publish soon a new version 6.1.0 of the HAX kernel module
> including the fixes once their QA cycle is completed.
> Thanks Yu Ning for making this happen.

Queued for 2.9, thanks!  Please keep an eye on the release notes at
http://wiki.qemu-project.org/ChangeLog/2.9 (nothing there yet).

Paolo

> In patch 3/4, I have put the plumbing into the QEMU code base, I did some clean
> up there and it is reasonably intrusive: i.e.
>  Makefile.target           |  1 +
>  configure                 | 18 ++++++++++++
>  cpus.c                    | 74 ++++++++++++++++++++++++++++++++++++++++++++++-
>  hw/intc/apic_common.c     |  3 +-
>  include/qom/cpu.h         |  5 ++++
>  include/sysemu/hw_accel.h |  9 ++++++
>  qemu-options.hx           | 11 +++++++
>  target/i386/Makefile.objs |  4 +++
>  util/qemu-thread-win32.c  |  4 +--
>  vl.c                      | 15 ++++++++--
>  10 files changed, 137 insertions(+), 7 deletions(-)
> 
> The patch 1/4 just extracts from KVM specific header the cpu_synchronize_
> functions that HAX is also using.
> 
> The patch 4/4 is the Darwin support. This part is only lightly tested for now,
> so it can be considered as 'experimental'.
> 
> I have tested the end result on a Windows 10 Pro machine (with UG support)
> with the Intel HAXM module dev version and a large ChromiumOS x86_64 image to
> exercise various code paths. It looks stable.
> I also did a quick regression testing of the integration by running a Linux
> build with KVM enabled.
> 
> Changes from v5 to v6:
> - rebase against new upstream target directories changes
> - rebase on top of Paolo's ramblock-notifier patch and use the new API.
> - adjust qemu_cpu_kick according to Paolo's suggestions / use QueueUserApc.
> 
> Changes from v4 to v5:
> - update HAX fastmmio API with the new MMIO to MMIO transfer.
> 
> Changes from v3 to v4:
> - add RAM unmapping in the MemoryListener thanks to new API in HAX module 6.1.0
>   and re-wrote the memory mappings management to deal with this.
> - marked no longer used MMIO emulation as unsupported.
> - clean-up a few left-overs from removed code.
> - re-add an experimental version of the Darwin support.
> 
> Changes from v2 to v3:
> - fix saving/restoring FPU registers as suggested by Paolo.
> - fix Windows build on all targets as contributed by Stefan Weil.
> - clean-up IO / MMIO emulation.
> - more clean-up of emulation leftovers.
> 
> Changes from v1 to v2:
> - fix all style issues in the original code to get it through checkpatch.pl.
> - remove Darwin support, it was barely tested and not fully functional.
> - remove the support for CPU without UG mode.
> - fix most review comments
> 
> Vincent Palatin (4):
>   kvm: move cpu synchronization code
>   target/i386: Add Intel HAX files
>   Plumb the HAXM-based hardware acceleration support
>   hax: add Darwin support
> 
>  Makefile.target             |    1 +
>  configure                   |   18 +
>  cpus.c                      |   79 ++-
>  gdbstub.c                   |    1 +
>  hax-stub.c                  |   39 ++
>  hw/i386/kvm/apic.c          |    1 +
>  hw/i386/kvmvapic.c          |    1 +
>  hw/intc/apic_common.c       |    3 +-
>  hw/misc/vmport.c            |    2 +-
>  hw/ppc/pnv_xscom.c          |    2 +-
>  hw/ppc/ppce500_spin.c       |    4 +-
>  hw/ppc/spapr.c              |    2 +-
>  hw/ppc/spapr_hcall.c        |    2 +-
>  hw/s390x/s390-pci-inst.c    |    1 +
>  include/qom/cpu.h           |    5 +
>  include/sysemu/hax.h        |   56 +++
>  include/sysemu/hw_accel.h   |   48 ++
>  include/sysemu/kvm.h        |   23 -
>  monitor.c                   |    2 +-
>  qemu-options.hx             |   11 +
>  qom/cpu.c                   |    2 +-
>  target/arm/cpu.c            |    2 +-
>  target/i386/Makefile.objs   |    7 +
>  target/i386/hax-all.c       | 1155 +++++++++++++++++++++++++++++++++++++++++++
>  target/i386/hax-darwin.c    |  316 ++++++++++++
>  target/i386/hax-darwin.h    |   63 +++
>  target/i386/hax-i386.h      |   94 ++++
>  target/i386/hax-interface.h |  361 ++++++++++++++
>  target/i386/hax-mem.c       |  289 +++++++++++
>  target/i386/hax-windows.c   |  479 ++++++++++++++++++
>  target/i386/hax-windows.h   |   89 ++++
>  target/i386/helper.c        |    1 +
>  target/i386/kvm.c           |    1 +
>  target/ppc/mmu-hash64.c     |    2 +-
>  target/ppc/translate_init.c |    2 +-
>  target/s390x/gdbstub.c      |    1 +
>  util/qemu-thread-win32.c    |    4 +-
>  vl.c                        |   15 +-
>  38 files changed, 3143 insertions(+), 41 deletions(-)
>  create mode 100644 hax-stub.c
>  create mode 100644 include/sysemu/hax.h
>  create mode 100644 include/sysemu/hw_accel.h
>  create mode 100644 target/i386/hax-all.c
>  create mode 100644 target/i386/hax-darwin.c
>  create mode 100644 target/i386/hax-darwin.h
>  create mode 100644 target/i386/hax-i386.h
>  create mode 100644 target/i386/hax-interface.h
>  create mode 100644 target/i386/hax-mem.c
>  create mode 100644 target/i386/hax-windows.c
>  create mode 100644 target/i386/hax-windows.h
> 
