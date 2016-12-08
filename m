Received: from eggs.gnu.org ([2001:4830:134:3::10]:59970)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yu.ning@linux.intel.com>) id 1cEv5t-0005ls-7x
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 04:34:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yu.ning@linux.intel.com>) id 1cEv5p-0002YG-7D
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 04:34:25 -0500
Received: from mga03.intel.com ([134.134.136.65]:54029)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yu.ning@linux.intel.com>)
	id 1cEv5o-0002Wz-TB
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 04:34:21 -0500
References: <cover.1479381090.git.vpalatin@chromium.org>
From: Yu Ning <yu.ning@linux.intel.com>
Message-ID: <f228cb95-de64-5dc3-f761-390f20675541@linux.intel.com>
Date: Thu, 8 Dec 2016 17:34:32 +0800
MIME-Version: 1.0
In-Reply-To: <cover.1479381090.git.vpalatin@chromium.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 0/3] Add HAX support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vincent Palatin <vpalatin@chromium.org>, qemu-devel <qemu-devel@nongnu.org>

As a HAXM developer at Intel, I just want to come out and show our 
support for Vincent's upstreaming effort. We'd love to see HAXM support 
code land in upstream QEMU, and will do what is necessary to make that 
happen.

We've been working on the issues that Vincent raised and have made some 
progress - see below.

Regards,
Yu

On 11/17/2016 7:13 PM, Vincent Palatin wrote:
> I took a stab at trying to rebase/upstream the support for Intel HAXM.
> (Hardware Accelerated Execution Manager).
> Intel HAX is kernel-based hardware acceleration module for Windows and MacOSX.
>
> I have based my work on the last version of the source code I found:
> the emu-2.2-release branch in the external/qemu-android repository as used by
> the Android emulator.
> In patch 2/3, I have forward-ported the core HAX code from there.
> It has been modified to build and run along with the current code base.
> It has been simplifying by removing non-UG hardware support / Darwin support /
> Android-specific leftovers.
>
> CAVEAT: this patchset is still RFC because in addition of potentially containing
> a few outdated constructs and a questionable mess in qemu_cpu_kick_thread(),
> there are 2 unsolved issues:
> - in rare cases, the HAX kernel module asks us to emulate a MMIO access rather
>    than just using the 'fast MMIO' path. This path is still not implemented (as
>    it was in the original patch). It's unclear why/when this is happening
>    (eg you can run a full linux image without hitting it but the default iPXE
>    option ROM is hitting it in the Intel network driver).

This is now resolved, thanks to Vincent's help with debugging. The next 
HAXM driver release will include the fix.

> - the MemoryListener implementation cannot remove a memory mapping (e.g. for
>    digging the VGA 'hole' in the lowmem). This shortcoming breaks the std vga
>    implementation but in the current HAX module API, I don't see any (documented)
>    way of implementing this.

The current HAXM driver does not support removing a memory mapping. We 
just got that implemented this week, but testing has revealed another 
MMIO bug, which we are trying to fix.

>
> In patch 3/3, I have put the plumbing into the QEMU code base, I did some clean
> up there and it is reasonably intrusive: i.e.
>   Makefile.target           |  1 +
>   configure                 | 18 ++++++++++
>   cpus.c                    | 87 ++++++++++++++++++++++++++++++++++++++++++++++-
>   exec.c                    | 16 +++++++++
>   hw/intc/apic_common.c     |  3 +-
>   include/qom/cpu.h         |  5 +++
>   include/sysemu/hw_accel.h |  9 +++++
>   qemu-options.hx           | 11 ++++++
>   target-i386/Makefile.objs |  4 +++
>   vl.c                      | 15 ++++++--
>   10 files changed, 164 insertions(+), 5 deletions(-)
>
> The patch 1/3 just extracts from KVM specific header the cpu_synchronize_
> functions that HAX is also using.
>
> I have tested the end result on a Windows 10 Pro machine (with UG support)
> with the Intel HAXM module 6.0.4 and a large ChromiumOS x86_64 image to
> exercise various code paths. It looks stable.
> I also did a quick regression testing of the integration by running a Linux
> build with KVM enabled.
> Just running 'qemu-system-x86_64 -enable-hax' is broken due to the caveats
> described above.
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
> Vincent Palatin (3):
>    kvm: move cpu synchronization code
>    target-i386: Add Intel HAX files
>    Plumb the HAXM-based hardware acceleration support
>
>   Makefile.target             |    1 +
>   configure                   |   18 +
>   cpus.c                      |   88 ++-
>   exec.c                      |   16 +
>   gdbstub.c                   |    1 +
>   hax-stub.c                  |   39 ++
>   hw/i386/kvm/apic.c          |    1 +
>   hw/i386/kvmvapic.c          |    1 +
>   hw/intc/apic_common.c       |    3 +-
>   hw/misc/vmport.c            |    2 +-
>   hw/ppc/pnv_xscom.c          |    2 +-
>   hw/ppc/ppce500_spin.c       |    4 +-
>   hw/ppc/spapr.c              |    2 +-
>   hw/ppc/spapr_hcall.c        |    2 +-
>   hw/s390x/s390-pci-inst.c    |    1 +
>   include/qom/cpu.h           |    5 +
>   include/sysemu/hax.h        |   56 ++
>   include/sysemu/hw_accel.h   |   48 ++
>   include/sysemu/kvm.h        |   23 -
>   monitor.c                   |    2 +-
>   qemu-options.hx             |   11 +
>   qom/cpu.c                   |    2 +-
>   target-arm/cpu.c            |    2 +-
>   target-i386/Makefile.objs   |    4 +
>   target-i386/hax-all.c       | 1250 +++++++++++++++++++++++++++++++++++++++++++
>   target-i386/hax-i386.h      |   85 +++
>   target-i386/hax-interface.h |  357 ++++++++++++
>   target-i386/hax-slot.c      |  333 ++++++++++++
>   target-i386/hax-slot.h      |   58 ++
>   target-i386/hax-windows.c   |  489 +++++++++++++++++
>   target-i386/hax-windows.h   |   89 +++
>   target-i386/helper.c        |    1 +
>   target-i386/kvm.c           |    1 +
>   target-ppc/mmu-hash64.c     |    2 +-
>   target-ppc/translate_init.c |    2 +-
>   target-s390x/gdbstub.c      |    1 +
>   vl.c                        |   15 +-
>   37 files changed, 2978 insertions(+), 39 deletions(-)
>   create mode 100644 hax-stub.c
>   create mode 100644 include/sysemu/hax.h
>   create mode 100644 include/sysemu/hw_accel.h
>   create mode 100644 target-i386/hax-all.c
>   create mode 100644 target-i386/hax-i386.h
>   create mode 100644 target-i386/hax-interface.h
>   create mode 100644 target-i386/hax-slot.c
>   create mode 100644 target-i386/hax-slot.h
>   create mode 100644 target-i386/hax-windows.c
>   create mode 100644 target-i386/hax-windows.h
>
