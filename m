Received: from eggs.gnu.org ([2001:4830:134:3::10]:48404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1cJ6J7-0004b9-NU
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 17:21:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1cJ6J6-00078g-6b
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 17:21:21 -0500
MIME-Version: 1.0
In-Reply-To: <1481625384-15077-1-git-send-email-peter.maydell@linaro.org>
References: <1481625384-15077-1-git-send-email-peter.maydell@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 19 Dec 2016 14:20:45 -0800
Message-ID: <CAKmqyKNy=NeOPJs7C+3LgyCGMoy6W9gAhz5M5BgJ7t9YwTLA4g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH 00/23] arm: Add virtualization to GICv3,
 and enable EL2 on 64-bit CPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Andrew Jones <drjones@redhat.com>, Christoffer Dall <christoffer.dall@linaro.org>, Patch Tracking <patches@linaro.org>

On Tue, Dec 13, 2016 at 2:36 AM, Peter Maydell <peter.maydell@linaro.org> wrote:
> This patchset adds support for the Virtualization extensions to QEMU's
> GICv3 emulation. This was the last missing piece that was stopping
> us from turning on the EL2 support in the CPU model, so the patchset
> also adds support for enabling it all on the virt board via the
> '-machine virtualization=on' option.
>
> The result works well enough to allow booting a KVM outer guest kernel
> and then running QEMU + an inner guest under KVM inside it. The outer
> guest KVM also passes the kvm-unit-tests GIC tests.
>
> Patches 1-7 have already appeared on list, and 1-5 + 7 have been
> reviewed. The rest are new.
>
> As per mailing list discussion, there is a new CPU property
> for enabling EL2 which defaults to 'true' (named 'has_el2' to
> parallel the existing 'has_el3'). There is also a board property
> on 'virt' which defaults to 'false' (named 'virtualization' to
> parallel the existing 'secure'). The only other 64-bit board
> is the ZynqMP -- this patchset makes it always set has_el2 to false,
> so no change in behaviour. (I imagine the Xilinx folk will want to
> enable it at some point.)
>
> There is no property on the GIC device object to enable virtualization,
> because this only affects the CPU interface, which in real hardware
> is part of the CPU itself and which in QEMU we enable and configure
> via a close coupling between the cpuif code and the CPU code.
>
> These patches include changes to the reported device tree info
> to (a) report the GICv3 maintenance IRQ binding and (b) report
> use of SMC as the PSCI conduit. I haven't tried to make the
> equivalent changes to the ACPI tables because Drew said on
> Monday that he had a cleanup to make in that area, which would
> change all that code anyway. I'm guessing there'll be a v2 of
> this series, so we can fix that dependency up properly then.
>
> The new state in the GICv3 for the virtualization should not
> cause a migration compat break because we put it in a subsection
> which is only sent if virtualization is enabled.
>
> Unfortunately to enable EL2 on the 32-bit CPU models we need
> to do this all over again for the GICv2 emulation :-)
>
> Git branch for this:
>  https://git.linaro.org/people/peter.maydell/qemu-arm.git gicv3-virt

Hey Peter,

If I manually enable EL2 and EL3 for the Xilinx EP108 board I can
replicate a full hardware flow from ATF -> u-boot -> Linux.

Unfortunately Linux doesn't get too far as I get the error below. This
is further then it was getting before though, so I'm still including
this:

Tested-by: Alistair Francis <alistair.francis@xilinx.com>

[       24547.770] Detected VIPT I-cache on CPU1
[       24667.370] CPU features: SANITY CHECK: Unexpected variation in
SYS_CNTFRQ_EL0. Boot CPU: 0x00000005f5e100, CPU1: 0x00000003b9aca0
[       24769.210] Unsupported CPU feature variation.
[       25004.700] ------------[ cut here ]------------
[       25016.880] WARNING: at
/proj/petalinux/petalinux-v2016.2_0609_2/petalinux-v2016.2-final/components/linux-kernel/xlnx-4.4/arch/arm64/kernel/cpufeature.c:578
[       25052.590] Modules linked in:
[       25069.260]
[       25167.520] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 4.4.0 #2
[       25178.040] Hardware name: ZynqMP EP108 (DT)
[       25230.380] task: ffffffc0328c2280 ti: ffffffc0328c8000
task.ti: ffffffc0328c8000
[       25259.620] PC is at update_cpu_features+0x3a4/0x3b4
[       25273.900] LR is at update_cpu_features+0x3a4/0x3b4
[       25283.850] pc : [<ffffffc00008c500>] lr : [<ffffffc00008c500>]
pstate: 600003c5
[       25289.440] sp : ffffffc0328cbf80
[       25319.600] x29: ffffffc0328cbf80 x28: 0000000000000000
[       25332.960] x27: ffffffc000081050 x26: 0000000001c7b000
[       25344.260] x25: 0000000001c78000 x24: 0000000000000000
[       25355.700] x23: 0000000000000000 x22: ffffffc001c21190
[       25367.180] x21: ffffffc037fa44d0 x20: 0000000000000001
[       25378.440] x19: ffffffc001c1d000 x18: 00000000410fd034
[       25389.660] x17: 0000000003010066 x16: 0000000002101110
[       25400.920] x15: 0000000013112111 x14: 203a55504320746f
[       25412.180] x13: 6f42202e304c455f x12: 515246544e435f53
[       25423.440] x11: ffffffc001bb2000 x10: ffffffc001c23000
[       25444.920] x9 : 0000000000000000 x8 : ffffffc001c252a0
[       25456.710] x7 : 0000000000000000 x6 : 0000000000000015
[       25467.920] x5 : 000000000008bc0e x4 : 0000000000000000
[       25479.060] x3 : 0000000000000000 x2 : 0000000000000077
[       25490.010] x1 : 00000000000003c0 x0 : 0000000000000022
[       25495.030]
[       26235.260] ---[ end trace 21587db8a41df80a ]---
[       26314.660] Call trace:
[       26339.500] [<ffffffc00008c500>] update_cpu_features+0x3a4/0x3b4
[       26398.300] [<ffffffc00008bc20>] cpuinfo_store_cpu+0x44/0x4c
[       26408.860] [<ffffffc00008cf78>] secondary_start_kernel+0xc8/0x140
[       26487.690] [<000000000008103c>] 0x8103c
[       27185.930] CPU1: Booted secondary processor [410fd034]


Thanks,

Alistair


>
>
> thanks
> -- PMM
>
> Peter Maydell (23):
>   target-arm: Log AArch64 exception returns
>   hw/intc/arm_gicv3: Remove incorrect usage of fieldoffset
>   hw/intc/arm_gicv3: Don't signal Pending+Active interrupts to CPU
>   hw/arm/virt: add 2.9 machine type
>   hw/arm/virt: Merge VirtBoardInfo and VirtMachineState
>   hw/arm/virt: Rename 'vbi' variables to 'vms'
>   hw/arm/virt: Don't incorrectly claim architectural timer to be
>     edge-triggered
>   hw/intc/arm_gicv3: Add external IRQ lines for VIRQ and VFIQ
>   hw/intc/arm_gic: Add external IRQ lines for VIRQ and VFIQ
>   target-arm: Expose output GPIO line for VCPU maintenance interrupt
>   hw/arm/virt: Wire VIRQ, VFIQ, maintenance irq lines from GIC to CPU
>   target-arm: Add ARMCPU fields for GIC CPU i/f config
>   hw/intc/gicv3: Add defines for ICH system register fields
>   hw/intc/gicv3: Add data fields for virtualization support
>   hw/intc/arm_gicv3: Add accessors for ICH_ system registers
>   hw/intc/arm_gicv3: Implement ICV_ registers which are just accessors
>   hw/intc/arm_gicv3: Implement ICV_ HPPIR, DIR and RPR registers
>   hw/intc/arm_gicv3: Implement ICV_ registers EOIR and IAR
>   hw/intc/arm_gicv3: Implement gicv3_cpuif_virt_update()
>   hw/intc/arm_gicv3: Implement EL2 traps for CPU i/f regs
>   hw/arm/virt: Support using SMC for PSCI
>   target-arm: Enable EL2 feature bit on A53 and A57
>   hw/arm/virt: Add board property to enable EL2
>
>  hw/intc/gicv3_internal.h           |   79 +++
>  include/hw/arm/virt.h              |    2 +
>  include/hw/compat.h                |    3 +
>  include/hw/intc/arm_gic_common.h   |    2 +
>  include/hw/intc/arm_gicv3_common.h |   21 +
>  target-arm/cpu.h                   |    9 +
>  hw/arm/virt.c                      |  696 +++++++++++--------
>  hw/arm/xlnx-zynqmp.c               |    2 +
>  hw/intc/arm_gic_common.c           |    6 +
>  hw/intc/arm_gicv3.c                |    5 +
>  hw/intc/arm_gicv3_common.c         |   31 +
>  hw/intc/arm_gicv3_cpuif.c          | 1336 +++++++++++++++++++++++++++++++++++-
>  target-arm/cpu.c                   |   15 +
>  target-arm/cpu64.c                 |    8 +
>  target-arm/op_helper.c             |    9 +
>  hw/intc/trace-events               |   33 +
>  16 files changed, 1925 insertions(+), 332 deletions(-)
>
> --
> 2.7.4
>
>
