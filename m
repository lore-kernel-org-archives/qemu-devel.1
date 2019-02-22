Received: from eggs.gnu.org ([209.51.188.92]:55907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gxGEr-00007a-Ir
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 14:12:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gxGEe-0003OK-UP
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 14:11:53 -0500
References: <20190128110545.20644-1-shameerali.kolothum.thodi@huawei.com>
	<3a6bf5ea-5b48-18c2-8a2c-0ced777be816@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <892e3eb7-66f5-92a3-5891-de8665fc984a@redhat.com>
Date: Fri, 22 Feb 2019 20:11:29 +0100
MIME-Version: 1.0
In-Reply-To: <3a6bf5ea-5b48-18c2-8a2c-0ced777be816@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 0/4] ARM virt: ACPI memory hotplug
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>, Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>, shannon.zhaosl@gmail.com, peter.maydell@linaro.org, imammedo@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: xuwei5@huawei.com, linuxarm@huawei.com, Ard Biesheuvel <ard.biesheuvel@linaro.org>, "Leif Lindholm (Linaro address)" <leif.lindholm@linaro.org>

On 02/22/19 17:03, Auger Eric wrote:
> Hi Shameer,
> 
> On 1/28/19 12:05 PM, Shameer Kolothum wrote:
>> This series is an attempt to provide hotplug support to both
>> pc-dimm and nvdimm device memory on ARM virt platform. This is
>> based on Eric's recent works to support PCDIMM/NVDIMM device memory[1].
>> The kernel support for arm64 memory hot add was added only
>> recently by Robin[2] and hence the guest kernel should be => 5.0-rc1.
>>
>> This makes use of PL061 GPIO controller to sent related ACPI events
> s/sent/send
>> to the Guest. The only reference I could find with respect to the GPIO
>> pins usage is here[3] which says, "use PIN 3 for system_powerdown,
>> reserving PIN 0, 1, 2 for PCI hotplug, CPU hotplug and memory hotplug".
>> Hence Pin 2 is used for PCDIMM and pin 4 for NVDIMM.
>>
>> This is sanity tested on a HiSilicon ARM64 platform and appreciate
>> any further testing.
> 
> I did some testing on another platform and I got the exactly the same
> results as yours: PCDIMM hot plug works fine. Also after system_reset I
> still can see the slots.
> Hot-unplug is not supported though.
> For NVDIMM, hot-add works fine and and I can see the slots using ndctl
> on guest. But after system_reset, the guest does not boot properly.
> 
>>
>> This series can be applied on top of Eric's branch here[4]
>>
>> Test:
>> ------
>> Please use a Guest kernel image >5.0-rc1 with all the mem/nvdimm
>> hotplug related CONFIGs enabled.
>>
>> ./qemu-system-aarch64 \
>> -machine virt,gic-version=3,nvdimm \
>> -m 1G,maxmem=4G,slots=4 \
>> -cpu host \
>> -kernel Image \
>> -initrd rootfs-iperf.cpio \
>> -bios QEMU_EFI.fd \
>> -numa node,nodeid=0 \
>> -net none \
>> -nographic -enable-kvm \
>> -append "console=ttyAMA0 acpi=force earlycon=pl011,0x9000000"
>>
>> Enter Qemu monitor,
>> Add pc-dimm:
>> object_add memory-backend-ram,id=mem1,size=1G
>> device_add pc-dimm,id=dimm1,memdev=mem1
>>
>> Add nvdimm:
>> object_add memory-backend-ram,id=mem2,size=1G
>> device_add nvdimm,id=dimm2,memdev=mem2
>>
>> Known Issue:
>>
>> It is observed that hot adding nvdimm will results in guest reboot
>> failure. EDK2 fails to build the ACPI tables on reboot. Please find
>> below EDK2 log on Guest reboot after nvdimm hot-add,
>>
>> ProcessCmdAddChecksum: invalid checksum range in "etc/acpi/tables"
>> OnRootBridgesConnected: InstallAcpiTables: Protocol Error
>>
>> The root cause seems to be EDK2 ACPI table checksum failure
>> as NFIT table is getting updated on hot-add. This needs further
>> investigation.
> + Ard, Leif, Laszlo if they have any idea of what is missing/wrong.

Huh, very interesting; I usually don't expect my sanity checks to fire
in practice. :)

The message

  ProcessCmdAddChecksum: invalid checksum range in "etc/acpi/tables"

is logged by OVMF's and ArmVirtQemu's ACPI Platform DXE Driver when it
finds an invalid COMMAND_ADD_CHECKSUM command in QEMU's ACPI
linker/loader script.

Please see the command definition in QEMU's
"hw/acpi/bios-linker-loader.c". In particular, please refer to the
function bios_linker_loader_add_checksum(), which builds the command
structure, and documents the fields.

(You may also refer to QEMU_LOADER_ADD_CHECKSUM in file
"OvmfPkg/AcpiPlatformDxe/QemuLoader.h" in the edk2 source tree, for the
same information.)

The error message is logged if:
- the offset at which the checksum should be stored falls outside of the
size of the fw_cfg blob, or
- the range over which the checksum should be calculated falls outside
(at least in part) of the fw_cfg blob.

To me this suggests that QEMU generates an invalid COMMAND_ADD_CHECKSUM
command for the firmware.

... I've tried to skim the patches briefly. I think there must be an
error in the DSDT building logic that is only active on reboot if an
nvdimm module was hot-added before the reboot.

Thanks,
Laszlo


>> [1]https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg05740.html
>> [2]https://patchwork.kernel.org/patch/10724455/
>> [3]https://lists.gnu.org/archive/html/qemu-arm/2015-12/msg00095.html
>> [4]https://github.com/eauger/qemu/tree/v3.1.0-dimm-v5
>>
>> Shameer Kolothum (4):
>>   hw:acpi: Make ACPI IO address space configurable
>>   hw/arm/virt: Add GPIO based pcdimm hotplug ACPI event support
>>   hw/arm/virt: Enable pc-dimm hotplug support
>>   hw/arm/virt: Add nvdimm hotplug support
>>
>>  default-configs/arm-softmmu.mak  |   1 +
>>  hw/acpi/memory_hotplug.c         |  13 +++--
>>  hw/arm/virt-acpi-build.c         |  45 +++++++++++++++--
>>  hw/arm/virt.c                    | 105 ++++++++++++++++++++++++++++++++++++---
>>  hw/i386/acpi-build.c             |   3 +-
>>  include/hw/acpi/memory_hotplug.h |   6 ++-
>>  include/hw/arm/virt.h            |  15 ++++++
>>  7 files changed, 168 insertions(+), 20 deletions(-)
>>
