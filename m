Received: from eggs.gnu.org ([2001:4830:134:3::10]:57312)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1eOMK3-0006aT-Eu
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 06:32:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1eOMJw-0004Ku-25
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 06:32:35 -0500
From: gengdongjiu <gengdongjiu@huawei.com>
References: <1511807966-23936-1-git-send-email-gengdongjiu@huawei.com>
	<470c9df5-f2e8-974b-b37f-eff84a6f3d71@huawei.com>
Message-ID: <18906953-f464-d9f4-23b4-fd7118d45e2f@huawei.com>
Date: Mon, 11 Dec 2017 19:31:14 +0800
MIME-Version: 1.0
In-Reply-To: <470c9df5-f2e8-974b-b37f-eff84a6f3d71@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v13 00/12] Add ARMv8 RAS virtualization
 support in QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, Igor Mammedov <imammedo@redhat.com>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>, zhaoshenglong@huawei.com, James Morse <james.morse@arm.com>, lersek@redhat.com, Marc Zyngier <marc.zyngier@arm.com>, christoffer.dall@linaro.org, rth@twiddle.net, ehabkost@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.orgrth@twiddle.netehabkost@redhat.com, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, pbonzini@redhat.com, Linuxarm <linuxarm@huawei.com>, xuwei5@hisilicon.com

Hi maintainer,

  This patch set seems pending about one month, could you help review for them?  Thanks.

In this series, except the three patches in [1] are dependent on KVM implementation. Other patches does not depend on KVM/host,
because KVM/host has already supported them,  According to James Morse <james.morse@arm.com>'s agreement, when Qemu receives SIGBUS with MCE_MCEERR_AR, Qemu record
the CPER and inject a Synchronous-External-Abort; when Qemu receives SIGBUS with MCE_MCEERR_AO, Qemu record CPER and inject a GPIO IRQ. In my
current patch set, I already do that.

I plan to move the three patches in [1] out of this patch set, because it was a separate case, the three patches are used to set guest SError ESR,
which depend on KVM "return a Error" to Qemu, James has some concern about "KVM return error", so I plan to remove them from this patch set so that it does not block the whole patches review.
Thanks!

[1]:
[v13,05/12] linux-headers: sync against Linux v4.14-rc8
[v13,06/12] target-arm: kvm64: detect whether can set vsesr_el2
[v13,07/12] target-arm: handle SError interrupt exception from the guest OS


On 2017/11/28 2:39, Dongjiu Geng wrote:
> From: gengdongjiu <gengdongjiu@huawei.com>
>
> In the ARMv8 platform, the CPU error type are synchronous external
> abort(SEA) and SError Interrupt (SEI). If guest happen exception,
> sometimes  guest itself do the recovery is better, because host
> does not know guest's detailed info. For example, if a guest
> user-space application happen exception, guest can kill this
> application, but host can not do that.
>
> For the ARMv8 SEA/SEI, KVM or host kernel will deliver SIGBUS or
> use other interface to notify user space. After user space gets
> the notification, it will record the CPER to guest GHES buffer
> for guest and inject a exception or IRQ to KVM.
>
> In the current implement, if the SIGBUS is BUS_MCEERR_AR, we will
> treat it as synchronous exception, and use ARMv8 SEA notification type
> to notify guest after recording CPER for guest; If the SIGBUS is
> BUS_MCEERR_AO, we will treat it as asynchronous exception, and use
> GPIO-Signal to notify guest after recording CPER for guest.
>
> If KVM wants userspace to do the recovery for the SError, it will return a error
> status to Qemu. Then Qemu will specify the guest ESR value and inject a virtual
> SError.
>
> This series patches have three parts:
> 1. Generate APEI/GHES table and record CPER for guest in runtime.
> 2. Handle the SIGBUS signal, record the CPER and fill into guest memory,
>    then according to SIGBUS type(BUS_MCEERR_AR or BUS_MCEERR_AO), using
>    different ACPI notification type to notify guest.
> 3. Specify guest SError ESR value and inject a virtual SError
>
> Whole solution was suggested by James(james.morse@arm.com); inject RAS SEA abort and specify guest ESR
> in user space are suggested by Marc(marc.zyngier@arm.com), APEI part solution is suggested by
> Laszlo(lersek@redhat.com). Shown some discussion in [1].
>
>
> This series patches have already tested on ARM64 platform with RAS feature enabled:
> Show the APEI part verification result in [2]
> Show the BUS_MCEERR_AR and BUS_MCEERR_AO SIGBUS handling verification result in [3]
> Show Qemu set guest ESR and inject virtual SError verification result in [4]
>
> ---
> Change since v12:
> 1. Address Paolo's comments to move HWPoisonPage definition to accel/kvm/kvm-all.c
> 2. Only call kvm_cpu_synchronize_state() when get the BUS_MCEERR_AR signal
> 3. Only add and enable GPIO-Signal and ARMv8 SEA two hardware error sources
> 4. Address Michael's comments to not sync SPDX from Linux kernel header file
>
> Change since v11:
> Address James's comments(james.morse@arm.com)
> 1. Check whether KVM has the capability to to set ESR instead of detecting host CPU RAS capability
> 2. For SIGBUS_MCEERR_AR SIGBUS, use Synchronous-External-Abort(SEA) notification type
>    for SIGBUS_MCEERR_AO SIGBUS, use GPIO-Signal notification
>
>
> Address Shannon's comments(for ACPI part):
> 1. Unify hest_ghes.c and hest_ghes.h license declaration
> 2. Remove unnecessary including "qmp-commands.h" in hest_ghes.c
> 3. Unconditionally add guest APEI table based on James's comments(james.morse@arm.com)
> 4. Add a option to virt machine for migration compatibility. On new virt machine it's on
>    by default while off for old ones, we enabled it since 2.10
> 5. Refer to the ACPI spec version which introduces Hardware Error Notification first time
> 6. Add ACPI_HEST_NOTIFY_RESERVED notification type
>
> Address Igor's comments(for ACPI part):
> 1. Add doc patch first which will describe how it's supposed to work between QEMU/firmware/guest
>    OS with expected flows.
> 2. Move APEI diagrams into doc/spec patch
> 3. Remove redundant g_malloc in ghes_record_cper()
> 4. Use build_append_int_noprefix() API to compose whole error status block and whole APEI table,
>    and try to get rid of most structures in patch 1, as they will be left unused after that
> 5. Reuse something like https://github.com/imammedo/qemu/commit/3d2fd6d13a3ea298d2ee814835495ce6241d085c
>    to build GAS
> 6. Remove much offsetof() in the function
> 7. Build independent tables first and only then build dependent tables passing to it pointers
>    to previously build table if necessary.
> 8. Redefine macro GHES_ACPI_HEST_NOTIFY_RESERVED to ACPI_HEST_ERROR_SOURCE_COUNT to avoid confusion
>
>
> Address Peter Maydell's comments
> 1. linux-headers is done as a patch of their own created using scripts/update-linux-headers.sh run against a
>    mainline kernel tree
> 2. Tested whether this patchset builds OK on aarch32
> 3. Abstract Hwpoison page adding code  out properly into a cpu-independent source file from target/i386/kvm.c,
>    such as kvm-all.c
> 4. Add doc-comment formatted documentation comment for new globally-visible function prototype in a header
>
> ---
> [1]:
> https://lkml.org/lkml/2017/2/27/246
> https://patchwork.kernel.org/patch/9633105/
> https://patchwork.kernel.org/patch/9925227/
>
> [2]:
> Note: the UEFI(QEMU_EFI.fd) is needed if guest want to use ACPI table.
>
> After guest boot up, dump the APEI table, then can see the initialized table
> (1) # iasl -p ./HEST -d /sys/firmware/acpi/tables/HEST
> (2) # cat HEST.dsl
>     /*
>      * Intel ACPI Component Architecture
>      * AML/ASL+ Disassembler version 20170728 (64-bit version)
>      * Copyright (c) 2000 - 2017 Intel Corporation
>      *
>      * Disassembly of /sys/firmware/acpi/tables/HEST, Mon Sep  5 07:59:17 2016
>      *
>      * ACPI Data Table [HEST]
>      *
>      * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue
>      */
>
>     ..................................................................................
>     [308h 0776   2]                Subtable Type : 000A [Generic Hardware Error Source V2]
>     [30Ah 0778   2]                    Source Id : 0008
>     [30Ch 0780   2]            Related Source Id : FFFF
>     [30Eh 0782   1]                     Reserved : 00
>     [30Fh 0783   1]                      Enabled : 01
>     [310h 0784   4]       Records To Preallocate : 00000001
>     [314h 0788   4]      Max Sections Per Record : 00000001
>     [318h 0792   4]          Max Raw Data Length : 00001000
>
>     [31Ch 0796  12]         Error Status Address : [Generic Address Structure]
>     [31Ch 0796   1]                     Space ID : 00 [SystemMemory]
>     [31Dh 0797   1]                    Bit Width : 40
>     [31Eh 0798   1]                   Bit Offset : 00
>     [31Fh 0799   1]         Encoded Access Width : 04 [QWord Access:64]
>     [320h 0800   8]                      Address : 00000000785D0040
>
>     [328h 0808  28]                       Notify : [Hardware Error Notification Structure]
>     [328h 0808   1]                  Notify Type : 08 [SEA]
>     [329h 0809   1]                Notify Length : 1C
>     [32Ah 0810   2]   Configuration Write Enable : 0000
>     [32Ch 0812   4]                 PollInterval : 00000000
>     [330h 0816   4]                       Vector : 00000000
>     [334h 0820   4]      Polling Threshold Value : 00000000
>     [338h 0824   4]     Polling Threshold Window : 00000000
>     [33Ch 0828   4]        Error Threshold Value : 00000000
>     [340h 0832   4]       Error Threshold Window : 00000000
>
>     [344h 0836   4]    Error Status Block Length : 00001000
>     [348h 0840  12]            Read Ack Register : [Generic Address Structure]
>     [348h 0840   1]                     Space ID : 00 [SystemMemory]
>     [349h 0841   1]                    Bit Width : 40
>     [34Ah 0842   1]                   Bit Offset : 00
>     [34Bh 0843   1]         Encoded Access Width : 04 [QWord Access:64]
>     [34Ch 0844   8]                      Address : 00000000785D0098
>
>     [354h 0852   8]            Read Ack Preserve : 00000000FFFFFFFE
>     [35Ch 0860   8]               Read Ack Write : 0000000000000001
>
>     .....................................................................................
>
> (3) After a synchronous external abort(SEA) happen, Qemu receive a SIGBUS and
>     filled the CPER into guest GHES memory.  For example, according to above table,
>     the address that contains the physical address of a block of memory that holds
>     the error status data for this abort is 0x00000000785D0040
> (4) the address for SEA notification error source is 0x785d80b0
>     (qemu) xp /1 0x00000000785D0040
>     00000000785d0040: 0x785d80b0
>
> (5) check the content of generic error status block and generic error data entry
>     (qemu) xp /100x 0x785d80b0
>     00000000785d80b0: 0x00000001 0x00000000 0x00000000 0x00000098
>     00000000785d80c0: 0x00000000 0xa5bc1114 0x4ede6f64 0x833e63b8
>     00000000785d80d0: 0xb1837ced 0x00000000 0x00000300 0x00000050
>     00000000785d80e0: 0x00000000 0x00000000 0x00000000 0x00000000
>     00000000785d80f0: 0x00000000 0x00000000 0x00000000 0x00000000
>     00000000785d8100: 0x00000000 0x00000000 0x00000000 0x00004002
> (6) check the OSPM's ACK value(for example SEA)
>     /* Before OSPM acknowledges the error, check the ACK value */
>     (qemu) xp /1 0x00000000785D0098
>     00000000785d00f0: 0x00000000
>
>     /* After OSPM acknowledges the error, check the ACK value, it change to 1 from 0 */
>     (qemu) xp /1 0x00000000785D0098
>     00000000785d00f0: 0x00000001
>
> [2] host memory error hander deliver "BUS_MCEERR_AO" to Qemu, Qemu record the
>     guest CPER and notify guest by IRQ, then guest do the recovery.
>
> [ 4895.040340] {2}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 7
> [ 4895.367779] {2}[Hardware Error]: event severity: recoverable
> [ 4896.536868] {2}[Hardware Error]:  Error 0, type: recoverable
> [ 4896.753032] {2}[Hardware Error]:   section_type: memory error
> [ 4896.969088] {2}[Hardware Error]:   physical_address: 0x0000000040a08000
> [ 4897.211532] {2}[Hardware Error]:   error_type: 3, multi-bit ECC
> [ 4900.666650] Memory failure: 0x40600: already hardware poisoned
> [ 4902.744432] Memory failure: 0x40a08: Killing mca-recover:42 due to hardware memory corruption
> [ 4903.448544] Memory failure: 0x40a08: recovery action for dirty LRU page: RecoVered
>
> [3] KVM deliver "BUS_MCEERR_AR" to Qemu, Qemu record the guest CPER and inject
>     synchronous external abort to notify guest, then guest do the recovery.
>
> [ 1552.516170] Synchronous External Abort: synchronous external abort (0x92000410) at 0x000000003751c6b4
> [ 1553.074073] {1}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 8
> [ 1553.081654] {1}[Hardware Error]: event severity: recoverable
> [ 1554.034191] {1}[Hardware Error]:  Error 0, type: recoverable
> [ 1554.037934] {1}[Hardware Error]:   section_type: memory error
> [ 1554.513261] {1}[Hardware Error]:   physical_address: 0x0000000040fa6000
> [ 1554.513944] {1}[Hardware Error]:   error_type: 3, multi-bit ECC
> [ 1555.041451] Memory failure: 0x40fa6: Killing mca-recover:1296 due to hardware memory corruption
> [ 1555.373116] Memory failure: 0x40fa6: recovery action for dirty LRU page: Recovered
>
> [4] Qemu set guest ESR and inject virtual SError test result:
>
> KVM return Error status to Qemu, Qemu set the guest ESR and inject virtual SError.
> As shown below, the ESR value 0xbe000c11 is set by Qemu
>
> Bad mode in Error handler detected, code 0xbe000c11 -- SError
> CPU: 0 PID: 539 Comm: devmem Tainted: G      D         4.1.0+ #20
> Hardware name: linux,dummy-virt (DT)
> task: ffffffc019aad600 ti: ffffffc008134000 task.ti: ffffffc008134000
> PC is at 0x405cc0
> LR is at 0x40ce80
> pc : [<0000000000405cc0>] lr : [<000000000040ce80>] pstate: 60000000
> sp : ffffffc008137ff0
> x29: 0000007fd9e80790 x28: 0000000000000000
> x27: 00000000000000ad x26: 000000000049c000
> x25: 000000000048904b x24: 000000000049c000
> x23: 0000000040600000 x22: 0000007fd9e808d0
> x21: 0000000000000002 x20: 0000000000000000
> x19: 0000000000000020 x18: 0000000000000000
> x17: 0000000000405cc0 x16: 000000000049c698
> x15: 0000000000005798 x14: 0000007f93875f1c
> x13: 0000007f93a8ccb0 x12: 0000000000000137
> x11: 0000000000000000 x10: 0000000000000000
> x9 : 0000000000000000 x8 : 00000000000000de
> x7 : 0000000000000000 x6 : 0000000000002000
> x5 : 0000000040600000 x4 : 0000000000000003
> x3 : 0000000000000001 x2 : 00000000000f123b
> x1 : 0000000000000008 x0 : 000000000047a048
>
>
> Dongjiu Geng (12):
>   ACPI: add related GHES structures and macros definition
>   ACPI: Add APEI GHES table generation and CPER record support
>   docs: APEI GHES generation description
>   ACPI: enable APEI GHES in the configure file and build it
>   linux-headers: sync against Linux v4.14-rc8
>   target-arm: kvm64: detect whether can set vsesr_el2
>   target-arm: handle SError interrupt exception from the guest OS
>   target-arm: kvm64: inject synchronous External Abort
>   Move related hwpoison page function to accel/kvm/ folder
>   ARM: ACPI: Add _E04 for hardware error device
>   hw/arm/virt: Add RAS platform version for migration
>   target-arm: kvm64: handle SIGBUS signal from kernel or KVM
>
>  accel/kvm/kvm-all.c             |  34 ++++
>  default-configs/arm-softmmu.mak |   1 +
>  docs/specs/acpi_hest_ghes.txt   |  96 +++++++++++
>  hw/acpi/Makefile.objs           |   1 +
>  hw/acpi/aml-build.c             |   2 +
>  hw/acpi/hest_ghes.c             | 358 ++++++++++++++++++++++++++++++++++++++++
>  hw/arm/virt-acpi-build.c        |  43 ++++-
>  hw/arm/virt.c                   |  22 +++
>  include/exec/ram_addr.h         |   5 +
>  include/hw/acpi/acpi-defs.h     |  49 ++++++
>  include/hw/acpi/aml-build.h     |   1 +
>  include/hw/acpi/hest_ghes.h     |  83 ++++++++++
>  include/hw/arm/virt.h           |   1 +
>  include/sysemu/kvm.h            |   2 +-
>  include/sysemu/sysemu.h         |   3 +
>  linux-headers/linux/kvm.h       |   3 +
>  target/arm/internals.h          |   4 +
>  target/arm/kvm.c                |   5 +
>  target/arm/kvm32.c              |   6 +
>  target/arm/kvm64.c              | 138 ++++++++++++++++
>  target/arm/kvm_arm.h            |   8 +
>  target/i386/kvm.c               |  33 ----
>  vl.c                            |  12 ++
>  23 files changed, 875 insertions(+), 35 deletions(-)
>  create mode 100644 docs/specs/acpi_hest_ghes.txt
>  create mode 100644 hw/acpi/hest_ghes.c
>  create mode 100644 include/hw/acpi/hest_ghes.h
>
