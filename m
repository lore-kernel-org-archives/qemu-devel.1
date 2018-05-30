Received: from eggs.gnu.org ([2001:4830:134:3::10]:48575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fO2xU-0001I1-LB
	for qemu-devel@nongnu.org; Wed, 30 May 2018 11:24:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fO2xT-0005Ji-C9
	for qemu-devel@nongnu.org; Wed, 30 May 2018 11:24:16 -0400
References: <20180516152026.2920-1-shameerali.kolothum.thodi@huawei.com>
	<f365f305-175c-db54-677d-6f66719b24cd@redhat.com>
	<5FC3163CFD30C246ABAA99954A238FA8386F1799@FRAEML521-MBX.china.huawei.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <03cc41b1-cc2e-d272-ccbc-460dfc051e78@redhat.com>
Date: Wed, 30 May 2018 17:24:06 +0200
MIME-Version: 1.0
In-Reply-To: <5FC3163CFD30C246ABAA99954A238FA8386F1799@FRAEML521-MBX.china.huawei.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v2 0/6] hw/arm: Add support for
 non-contiguous iova regions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
Cc: "drjones@redhat.com" <drjones@redhat.com>, "imammedo@redhat.com" <imammedo@redhat.com>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, Zhaoshenglong <zhaoshenglong@huawei.com>, Jonathan Cameron <jonathan.cameron@huawei.com>, Linuxarm <linuxarm@huawei.com>

Hi Shameer;

On 05/30/2018 04:39 PM, Shameerali Kolothum Thodi wrote:
> Hi Eric,
> 
>> -----Original Message-----
>> From: Auger Eric [mailto:eric.auger@redhat.com]
>> Sent: Monday, May 28, 2018 3:22 PM
>> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>;
>> qemu-devel@nongnu.org; qemu-arm@nongnu.org
>> Cc: drjones@redhat.com; imammedo@redhat.com; peter.maydell@linaro.org;
>> alex.williamson@redhat.com; Zhaoshenglong <zhaoshenglong@huawei.com>;
>> Jonathan Cameron <jonathan.cameron@huawei.com>; Linuxarm
>> <linuxarm@huawei.com>
>> Subject: Re: [RFC v2 0/6] hw/arm: Add support for non-contiguous iova regions
>>
>> Hi Shameer,
>>
>> On 05/16/2018 05:20 PM, Shameer Kolothum wrote:
>>> When the kernel reports valid iova ranges as non-contiguous,
>>> memory should be allocated to Guest in such a way that
>>> reserved regions(holes) are not visible by Guest.
>>>
>>> This series retrieves the valid iova ranges based on the new
>>> proposed VFIO interface for kernel [1]. It then populates the
>>> first 1GB ram as a non-pluggable dimm and rest as a pc-dimm if
>>> the valid iova ranges are non-contiguous.
>>
>> Some general comments:
> 
> Thanks for going through this series.
> 
>> - what are your plans with respect to VFIO device hot-plug handling?
>> IIUC, at the moment, any collision between reserved regions induces by
>> hot-plugged devices are not detected/handled. I understand mem hotplug
>> is not supported on aarch64. Would you simply reject the vfio device
>> hotplug.
> 
> As per the new kernel changes, the _attach_group() will fail if the device 
> reserved regions conflicts with any existing dma mappings of the VM. 
> So my understanding is that, host kernel will in effect reject any hot-plug
> device that has a reserved region conflicting with dma mappings.

Oh you're right, as the whole guest RAM space may be dma mapped, this
should be detected.
> 
>> - IIUC any reserved window colliding with [4000000, 1GB] cold-plug RAM
>> segment is show-stopper. How was this 1GB size chosen exactly?
> 
> Yes, any reserved window in that region might prevent the Guest from booting
> with UEFI as the current solution will move the base start address . I think this is
> because the EDK2 UEFI expects the base to start at 0x4000000[1]. I am not sure
> why this is required by the UEFI as without the "-bios" option, the Guest can be
> booted as long as base addr < 4GB.
> 
>> - Currently you create a single PC-DIMM node whereas several ones may be
>> possible & necessary? Do you plan to support multiple PC-DIMMS node?
> 
> Yes, that is correct. This is mainly to keep it simple and with the expectation that
> the valid host iova regions may not be that fragmented. I can look into extent this
> to support multiple pc-dimms if there is an immediate requirement to do so.
>  
>> - I have started looking at RAM extension on machvirt. I think adding
>> support of PC-DIMMS through the qemu cmd line is something that we need
>> to work on, in paralell.
> 
> Ok. Do you have more info that you can share on this? Please let me know.
not really. We just plan to support more than 255GB RAM and support this
through PC-DIMM. Some of your patches can be reused I think.

Thanks

Eric
> 
> Thanks,
> Shameer
> 
> [1] https://github.com/tianocore/edk2/blob/master/ArmVirtPkg/ArmVirtQemu.dsc#L133
> 
>> Thanks
>>
>> Eric
>>>
>>> Patch #3 of this series is loosely based on an earlier attempt
>>> by Kwangwoo Lee to add hotplug/pc-dimm support to arm64[2]
>>>
>>> RFC v1[3] --> RFCv2
>>>  -Based on new VFIO kernel interface
>>>  -Part of Mem modelled as pc-dimm
>>>  -Rebased to qemu 2.12.0
>>>
>>> [1] https://lkml.org/lkml/2018/4/18/293
>>> [2] https://lists.gnu.org/archive/html/qemu-devel/2016-07/msg04600.html
>>> [3] https://lists.gnu.org/archive/html/qemu-devel/2017-11/msg02412.html
>>>
>>> Shameer Kolothum (6):
>>>   hw/vfio: Retrieve valid iova ranges from kernel
>>>   hw/arm/virt: Enable dynamic generation of guest RAM memory regions
>>>   hw/arm/virt: Add pc-dimm mem hotplug framework
>>>   hw/arm: Changes required to accommodate non-contiguous DT mem nodes
>>>   hw/arm: ACPI SRAT changes to accommodate non-contiguous mem
>>>   hw/arm: Populate non-contiguous memory regions
>>>
>>>  default-configs/aarch64-softmmu.mak |   1 +
>>>  hw/arm/boot.c                       |  91 ++++++---
>>>  hw/arm/virt-acpi-build.c            |  24 ++-
>>>  hw/arm/virt.c                       | 367
>> +++++++++++++++++++++++++++++++++++-
>>>  hw/vfio/common.c                    | 108 ++++++++++-
>>>  include/hw/arm/arm.h                |  12 ++
>>>  include/hw/arm/virt.h               |   3 +
>>>  include/hw/vfio/vfio-common.h       |   7 +
>>>  linux-headers/linux/vfio.h          |  23 +++
>>>  9 files changed, 589 insertions(+), 47 deletions(-)
>>>
