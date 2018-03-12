Received: from eggs.gnu.org ([2001:4830:134:3::10]:45193)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1evL9I-0001Wg-5O
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 06:57:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1evL9F-0004YU-18
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 06:57:48 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:43012)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1evL9E-0004Wu-R7
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 06:57:44 -0400
Received: by mail-wr0-x242.google.com with SMTP id o1so3439097wro.10
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 03:57:44 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171217204912.12420-1-f4bug@amsat.org>
	<20171217204912.12420-5-f4bug@amsat.org>
	<42aa5fe6-1cf0-4912-a773-72cc8950afb5@amsat.org>
	<20180312020236-mutt-send-email-mst@kernel.org>
	<20180312020346-mutt-send-email-mst@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <6681daf4-7f6d-3925-cddb-19352b5c2707@amsat.org>
Date: Mon, 12 Mar 2018 11:57:42 +0100
MIME-Version: 1.0
In-Reply-To: <20180312020346-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 4/4] hw/pci: remove obsolete
 PCIDevice->init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, qemu-devel@nongnu.org

On 03/12/2018 01:04 AM, Michael S. Tsirkin wrote:
> On Mon, Mar 12, 2018 at 02:03:17AM +0200, Michael S. Tsirkin wrote:
>> On Sun, Mar 11, 2018 at 04:46:52PM +0100, Philippe Mathieu-Daudé wrote:
>>> Hi Michael, Paolo.
>>>
>>> Now than all other PCI QOM'ification patches got applied, can you take
>>> this patch for 2.12?
>>>
>>> Thanks,
>>>
>>> Phil.
>>>
>>> On 12/17/2017 09:49 PM, Philippe Mathieu-Daudé wrote:
>>>> All PCI devices are now QOM'ified.
>>>>
>>>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>>> ---
>>>>  include/hw/pci/pci.h |  1 -
>>>>  hw/pci/pci.c         | 14 --------------
>>>>  2 files changed, 15 deletions(-)
>>>>
>>>> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
>>>> index 8d02a0a383..0f1ed64c2f 100644
>>>> --- a/include/hw/pci/pci.h
>>>> +++ b/include/hw/pci/pci.h
>>>> @@ -217,7 +217,6 @@ typedef struct PCIDeviceClass {
>>>>      DeviceClass parent_class;
>>>>  
>>>>      void (*realize)(PCIDevice *dev, Error **errp);
>>>> -    int (*init)(PCIDevice *dev);/* TODO convert to realize() and remove */
>>>>      PCIUnregisterFunc *exit;
>>>>      PCIConfigReadFunc *config_read;
>>>>      PCIConfigWriteFunc *config_write;
>>>> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>>>> index b2d139bd9a..cd25ab6f6b 100644
>>>> --- a/hw/pci/pci.c
>>>> +++ b/hw/pci/pci.c
>>>> @@ -2054,18 +2054,6 @@ static void pci_qdev_realize(DeviceState *qdev, Error **errp)
>>>>      }
>>>>  }
>>>>  
>>>> -static void pci_default_realize(PCIDevice *dev, Error **errp)
>>>> -{
>>>> -    PCIDeviceClass *pc = PCI_DEVICE_GET_CLASS(dev);
>>>> -
>>>> -    if (pc->init) {
>>>> -        if (pc->init(dev) < 0) {
>>>> -            error_setg(errp, "Device initialization failed");
>>>> -            return;
>>>> -        }
>>>> -    }
>>>> -}
>>>> -
>>>>  PCIDevice *pci_create_multifunction(PCIBus *bus, int devfn, bool multifunction,
>>>>                                      const char *name)
>>>>  {
>>>> @@ -2538,13 +2526,11 @@ MemoryRegion *pci_address_space_io(PCIDevice *dev)
>>>>  static void pci_device_class_init(ObjectClass *klass, void *data)
>>>>  {
>>>>      DeviceClass *k = DEVICE_CLASS(klass);
>>>> -    PCIDeviceClass *pc = PCI_DEVICE_CLASS(klass);
>>>>  
>>>>      k->realize = pci_qdev_realize;
>>>>      k->unrealize = pci_qdev_unrealize;
>>>>      k->bus_type = TYPE_PCI_BUS;
>>>>      k->props = pci_props;
>>>> -    pc->realize = pci_default_realize;
>>
>> How about we assert !init here?
>>
>> +	assert(!pc->init);
> 
> Oh sorry I missed the chunk that drops it completely.
> Will apply.

Thanks!

> 
>>>>  }
>>>>  
>>>>  static void pci_device_class_base_init(ObjectClass *klass, void *data)
>>>>
>>
>>
