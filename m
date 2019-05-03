Received: from eggs.gnu.org ([209.51.188.92]:43957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hMYwf-0003x8-DM
	for qemu-devel@nongnu.org; Fri, 03 May 2019 10:13:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hMYwe-0002CR-02
	for qemu-devel@nongnu.org; Fri, 03 May 2019 10:13:49 -0400
References: <20190409102935.28292-1-shameerali.kolothum.thodi@huawei.com>
	<20190409102935.28292-9-shameerali.kolothum.thodi@huawei.com>
	<4f3df83f-8d45-09d0-ec9e-0ddf843fd3a4@redhat.com>
	<5FC3163CFD30C246ABAA99954A238FA83935D360@lhreml524-mbs.china.huawei.com>
	<5FC3163CFD30C246ABAA99954A238FA83F1B0B26@lhreml524-mbs.china.huawei.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <005dde0c-807d-5466-d5b7-971117564279@redhat.com>
Date: Fri, 3 May 2019 16:13:36 +0200
MIME-Version: 1.0
In-Reply-To: <5FC3163CFD30C246ABAA99954A238FA83F1B0B26@lhreml524-mbs.china.huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 8/8] hw/arm/boot: Expose the PC-DIMM
 nodes in the DT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>, "imammedo@redhat.com" <imammedo@redhat.com>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>, Linuxarm <linuxarm@huawei.com>, "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>, "sebastien.boeuf@intel.com" <sebastien.boeuf@intel.com>, "xuwei (O)" <xuwei5@huawei.com>

Hi Shameer,

On 05/03/19 15:35, Shameerali Kolothum Thodi wrote:
> 
> 
>> -----Original Message-----
>> From: Linuxarm [mailto:linuxarm-bounces@huawei.com] On Behalf Of
>> Shameerali Kolothum Thodi
>> Sent: 10 April 2019 09:49
>> To: Laszlo Ersek <lersek@redhat.com>; qemu-devel@nongnu.org;
>> qemu-arm@nongnu.org; eric.auger@redhat.com; imammedo@redhat.com
>> Cc: peter.maydell@linaro.org; sameo@linux.intel.com;
>> ard.biesheuvel@linaro.org; Linuxarm <linuxarm@huawei.com>;
>> shannon.zhaosl@gmail.com; sebastien.boeuf@intel.com; xuwei (O)
>> <xuwei5@huawei.com>
>> Subject: RE: [PATCH v4 8/8] hw/arm/boot: Expose the PC-DIMM nodes in the
>> DT
>>
>>
>>> -----Original Message-----
>>> From: Laszlo Ersek [mailto:lersek@redhat.com]
>>> Sent: 09 April 2019 16:09
>>> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>;
>>> qemu-devel@nongnu.org; qemu-arm@nongnu.org; eric.auger@redhat.com;
>>> imammedo@redhat.com
>>> Cc: peter.maydell@linaro.org; shannon.zhaosl@gmail.com;
>>> sameo@linux.intel.com; sebastien.boeuf@intel.com; xuwei (O)
>>> <xuwei5@huawei.com>; ard.biesheuvel@linaro.org; Linuxarm
>>> <linuxarm@huawei.com>
>>> Subject: Re: [PATCH v4 8/8] hw/arm/boot: Expose the PC-DIMM nodes in the
>>> DT
>>>
>>> On 04/09/19 12:29, Shameer Kolothum wrote:
>>>> This patch adds memory nodes corresponding to PC-DIMM regions.
>>>> This will enable support for cold plugged device memory for Guests
>>>> with DT boot.
>>>>
>>>> Signed-off-by: Shameer Kolothum
>> <shameerali.kolothum.thodi@huawei.com>
>>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>>> ---
>>>>  hw/arm/boot.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>>>>  1 file changed, 42 insertions(+)
>>>>
>>>> diff --git a/hw/arm/boot.c b/hw/arm/boot.c
>>>> index 8c840ba..150e1ed 100644
>>>> --- a/hw/arm/boot.c
>>>> +++ b/hw/arm/boot.c
>>>> @@ -19,6 +19,7 @@
>>>>  #include "sysemu/numa.h"
>>>>  #include "hw/boards.h"
>>>>  #include "hw/loader.h"
>>>> +#include "hw/mem/memory-device.h"
>>>>  #include "elf.h"
>>>>  #include "sysemu/device_tree.h"
>>>>  #include "qemu/config-file.h"
>>>> @@ -538,6 +539,41 @@ static void fdt_add_psci_node(void *fdt)
>>>>      qemu_fdt_setprop_cell(fdt, "/psci", "migrate", migrate_fn);
>>>>  }
>>>>
>>>> +static int fdt_add_hotpluggable_memory_nodes(void *fdt,
>>>> +                                             uint32_t acells,
>>> uint32_t scells) {
>>>> +    MemoryDeviceInfoList *info, *info_list = qmp_memory_device_list();
>>>> +    MemoryDeviceInfo *mi;
>>>> +    int ret = 0;
>>>> +
>>>> +    for (info = info_list; info != NULL; info = info->next) {
>>>> +        mi = info->value;
>>>> +        switch (mi->type) {
>>>> +        case MEMORY_DEVICE_INFO_KIND_DIMM:
>>>> +        {
>>>> +            PCDIMMDeviceInfo *di = mi->u.dimm.data;
>>>> +
>>>> +            ret = fdt_add_memory_node(fdt, acells, di->addr, scells,
>>>> +                                      di->size, di->node, true);
>>>> +            if (ret) {
>>>> +                fprintf(stderr,
>>>> +                        "couldn't add PCDIMM
>> /memory@%"PRIx64"
>>> node\n",
>>>> +                        di->addr);
>>>> +                goto out;
>>>> +            }
>>>> +            break;
>>>> +        }
>>>> +        default:
>>>> +            fprintf(stderr, "%s memory nodes are not yet supported\n",
>>>> +                    MemoryDeviceInfoKind_str(mi->type));
>>>> +            ret = -ENOENT;
>>>> +            goto out;
>>>> +        }
>>>> +    }
>>>> +out:
>>>> +    qapi_free_MemoryDeviceInfoList(info_list);
>>>> +    return ret;
>>>> +}
>>>> +
>>>>  int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
>>>>                   hwaddr addr_limit, AddressSpace *as)
>>>>  {
>>>> @@ -637,6 +673,12 @@ int arm_load_dtb(hwaddr addr, const struct
>>> arm_boot_info *binfo,
>>>>          }
>>>>      }
>>>>
>>>> +    rc = fdt_add_hotpluggable_memory_nodes(fdt, acells, scells);
>>>> +    if (rc < 0) {
>>>> +        fprintf(stderr, "couldn't add hotpluggable memory nodes\n");
>>>> +        goto fail;
>>>> +    }
>>>> +
>>>>      rc = fdt_path_offset(fdt, "/chosen");
>>>>      if (rc < 0) {
>>>>          qemu_fdt_add_subnode(fdt, "/chosen");
>>>>
>>>
>>>
>>> Given patches #7 and #8, as I understand them, the firmware cannot
>>> distinguish hotpluggable & present, from hotpluggable & absent. The
>> firmware
>>> can only skip both hotpluggable cases. That's fine in that the firmware will
>> hog
>>> neither type -- but is that OK for the OS as well, for both ACPI boot and DT
>>> boot?
>>
>> Right. This only handles the hotpluggable-and-present condition.
>>
>>> Consider in particular the "hotpluggable & present, ACPI boot" case.
>> Assuming
>>> we modify the firmware to skip "hotpluggable" altogether, the UEFI memmap
>>> will not include the range despite it being present at boot. Presumably, ACPI
>>> will refer to the range somehow, however. Will that not confuse the OS?
>>
>> From my testing so far, without patches #7 and #8(ie, no UEFI memmap entry),
>> ACPI boots fine. I think ACPI only relies on aml and SRAT.
>>
>>> When Igor raised this earlier, I suggested that hotpluggable-and-present
>>> should be added by the firmware, but also allocated immediately, as
>>> EfiBootServicesData type memory. This will prevent other drivers in the
>>> firmware from allocating AcpiNVS or Reserved chunks from the same memory
>>> range, the UEFI memmap will contain the range as EfiBootServicesData, and
>>> then the OS can release that allocation in one go early during boot.
>>
>> Ok. Agree that hotpluggable-and-present case it may make sense to make use
>> of
>> that memory rather than just hiding it altogether.
>>
>> On another note, Does hotpluggable-and-absent case make any valid use case
>> for
>> a DT boot? I am not sure how we can hot-add memory in the case of DT boot
>> later.
>> I have not verified the sysfs probe interface yet and there are discussions of
>> dropping
>> that interface altogether.
>>
>>> But this really has to be clarified from the Linux kernel's expectations. Please
>>> formalize all of the following cases:
>>
>> Sure. I will wait for suggestions here and work on it.
> 
> To continue the discussion on this, this is my proposal,
> 
> [...]

I didn't miss your last update, on 10 April. The reason I didn't respond
then was that, the table that you create here, needs to be approved by
Linux developers. In other words, the table should summarize how Linux
expects DT/ACPI to look, for the given use cases. It's not something
that I can comment on. The requirements come from Linux, and we should
attempt (in QEMU and the fw) to satisfy them.

If those use cases / requirements haven't been *designed* in Linux, in
the first place, then the discussion belongs even more on a kernel
development list. (I really can't say what Linux *should* expect, and
even if I had input on that, discussing it *just* on qemu-devel would be
futile.)

I mean, considering ACPI and the UEFI memmap at least, can we take
examples from the physical world (I guess x86 too)? What does Linux (and
maybe Windows) expect wrt. hotpluggable memory areas, in ACPI and in the
UEFI memmap?

I find it hard to believe that these are such use cases that we have to
*invent* now. It seems more likely that OSes already handle these use
cases, they have expectations, and we should *collect* them.

Thanks
Laszlo
