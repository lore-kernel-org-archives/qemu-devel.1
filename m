Received: from eggs.gnu.org ([2001:4830:134:3::10]:38372)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1cjX6M-0006zh-2k
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 15:13:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1cjX6H-0003wM-QY
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 15:13:26 -0500
Date: Thu, 2 Mar 2017 21:13:19 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <CAFEAcA-G8_yOjmHBb9S+ErCoxSAje4gr1S0Y=FQjwCsxK+GYGw@mail.gmail.com>
Message-ID: <alpine.BSF.2.20.1703022107450.83701@zero.eik.bme.hu>
References: <cover.1488068248.git.balaton@eik.bme.hu>
	<c554a16417ef22dbc29919a2747801be5ed7fede.1488068248.git.balaton@eik.bme.hu>
	<CAFEAcA-G8_yOjmHBb9S+ErCoxSAje4gr1S0Y=FQjwCsxK+GYGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] [PATCH v2 05/14] sm501: Add emulation of chip
 connected via PCI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>

On Thu, 2 Mar 2017, Peter Maydell wrote:
> On 25 February 2017 at 18:31, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>> Only the display controller part is created automatically on PCI
>>
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>>
>> v2: Split off removing dependency on base address to separate patch
>>
>>  hw/display/sm501.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 52 insertions(+)
>>
>> diff --git a/hw/display/sm501.c b/hw/display/sm501.c
>> index 1cda127..d9219bd 100644
>> --- a/hw/display/sm501.c
>> +++ b/hw/display/sm501.c
>> @@ -31,6 +31,7 @@
>>  #include "ui/console.h"
>>  #include "hw/devices.h"
>>  #include "hw/sysbus.h"
>> +#include "hw/pci/pci.h"
>>  #include "qemu/range.h"
>>  #include "ui/pixel_ops.h"
>>  #include "exec/address-spaces.h"
>> @@ -1507,9 +1508,60 @@ static const TypeInfo sm501_sysbus_info = {
>>      .class_init    = sm501_sysbus_class_init,
>>  };
>>
>> +#define TYPE_PCI_SM501 "sm501"
>> +#define PCI_SM501(obj) OBJECT_CHECK(SM501PCIState, (obj), TYPE_PCI_SM501)
>> +
>> +typedef struct {
>> +    /*< private >*/
>> +    PCIDevice parent_obj;
>> +    /*< public >*/
>> +    SM501State state;
>> +    uint32_t vram_size;
>> +} SM501PCIState;
>> +
>> +static void sm501_realize_pci(PCIDevice *dev, Error **errp)
>> +{
>> +    SM501PCIState *s = PCI_SM501(dev);
>> +
>> +    sm501_init(&s->state, DEVICE(dev), s->vram_size);
>> +    pci_register_bar(dev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY,
>> +                     &s->state.local_mem_region);
>> +    pci_register_bar(dev, 1, PCI_BASE_ADDRESS_SPACE_MEMORY,
>> +                     &s->state.mmio_region);
>> +}
>> +
>> +static Property sm501_pci_properties[] = {
>> +    DEFINE_PROP_UINT32("vram-size", SM501PCIState, vram_size,
>> +                       64 * 1024 * 1024),
>
> Something needs to sanity check this value, because it's
> user settable in the PCI device. (In the sysbus version you
> can only create it from board code, and we can assume board
> code doesn't pass us silly values.)
>
> Or you could just hardcode the PCI device to always be 64MB,
> I guess :-)

Maybe a check could be added to get_local_mem_size_index(). What should it 
do for invalid values?

>> +    DEFINE_PROP_END_OF_LIST(),
>> +};
>> +
>> +static void sm501_pci_class_init(ObjectClass *klass, void *data)
>> +{
>> +    DeviceClass *dc = DEVICE_CLASS(klass);
>> +    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
>> +
>> +    k->realize = sm501_realize_pci;
>> +    k->vendor_id = 0x126f;
>> +    k->device_id = 0x0501;
>
> We could define some constants in include/hw/pci/pci_ids.h
> for these, I suppose.

Should I add that as well? Should it be in this or separate patch?

>> +    k->class_id = PCI_CLASS_DISPLAY_OTHER;
>> +    set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
>> +    dc->desc = "SM501 Display Controller";
>> +    dc->props = sm501_pci_properties;
>> +    dc->hotpluggable = false;
>
> This needs a reset and vmsd as well.

Why? OK reset makes sense but if this is only used in sh and I think that 
might have other devices that don't support migration then adding a vmsd 
here only achieves that if we ever change anything in the state the vmsd 
needs to be changed, compatibility ensured, etc. And that's for nothing if 
the sh machine cannot be migrated anyway. There seems to be a lot of 
boilerplate already, it may exceed the actual code at some point.

But I can add vmstate for sysbus version if you think it's needed, I just 
don't see the point.

>> +}
>> +
>> +static const TypeInfo sm501_pci_info = {
>> +    .name          = TYPE_PCI_SM501,
>> +    .parent        = TYPE_PCI_DEVICE,
>> +    .instance_size = sizeof(SM501PCIState),
>> +    .class_init    = sm501_pci_class_init,
>> +};
>> +
>>  static void sm501_register_types(void)
>>  {
>>      type_register_static(&sm501_sysbus_info);
>> +    type_register_static(&sm501_pci_info);
>>  }
>>
>>  type_init(sm501_register_types)
>> --
>> 2.7.4
>
> thanks
> -- PMM
>
>
