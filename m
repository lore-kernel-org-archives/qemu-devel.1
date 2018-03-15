Received: from eggs.gnu.org ([2001:4830:134:3::10]:49969)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ewa7J-0000DH-Nv
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 17:08:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ewa7G-0007J4-HP
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 17:08:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39228 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1ewa7G-0007IZ-BJ
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 17:08:50 -0400
References: <20171026064635.7179-1-aik@ozlabs.ru>
	<13277057-669f-cd77-95f1-f0e54f7ae222@redhat.com>
	<7e694888-43ce-6653-92a0-c0b4c235d4ca@ozlabs.ru>
	<e6a81bdc-a961-d55f-85c4-55149c878988@redhat.com>
	<5ed185e2-c53a-0f82-a5f9-08e4918ad1b0@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <429ca11e-b521-57cc-c35b-2fb61024867d@redhat.com>
Date: Thu, 15 Mar 2018 17:08:48 -0400
MIME-Version: 1.0
In-Reply-To: <5ed185e2-c53a-0f82-a5f9-08e4918ad1b0@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu] fdc: Exit if ISA controller does not
 support DMA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, Markus Armbruster <armbru@redhat.com>



On 03/05/2018 05:15 AM, Thomas Huth wrote:
> On 08.12.2017 22:29, John Snow wrote:
>>
>> On 11/21/2017 09:48 PM, Alexey Kardashevskiy wrote:
>>> On 07/11/17 11:58, John Snow wrote:
>>>>
>>>>
>>>> On 10/26/2017 02:46 AM, Alexey Kardashevskiy wrote:
>>>>> A "powernv" machine type defines an ISA bus but it does not add any DMA
>>>>> controller to it so it is possible to hit assert(fdctrl->dma) by
>>>>> adding "-machine powernv -device isa-fdc".
>>>>>
>>>>> This replaces assert() with an error message.
>>>>>
>>>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>>>>> ---
> [...]
>>>>> diff --git a/hw/block/fdc.c b/hw/block/fdc.c
>>>>> index 67f78ac702..ed8b367572 100644
>>>>> --- a/hw/block/fdc.c
>>>>> +++ b/hw/block/fdc.c
>>>>> @@ -2700,7 +2700,10 @@ static void isabus_fdc_realize(DeviceState *dev, Error **errp)
>>>>>      fdctrl->dma_chann = isa->dma;
>>>>>      if (fdctrl->dma_chann != -1) {
>>>>>          fdctrl->dma = isa_get_dma(isa_bus_from_device(isadev), isa->dma);
>>>>> -        assert(fdctrl->dma);
>>>>> +        if (!fdctrl->dma) {
>>>>> +            error_setg(errp, "ISA controller does not support DMA, exiting");
>>>>> +            return;
>>>>> +        }
>>>>>      }
>>>>>  
>>>>>      qdev_set_legacy_instance_id(dev, isa->iobase, 2);
>>>>>
>>>>
>>>> I've been MIA for a little while, so I'm out of the loop -- but I am not
>>>> sure this is entirely the right way to fix this problem. I think it is
>>>> more the case that certain boards should not be able to ask for certain
>>>> types of devices, and we should prohibit e.g. powernv from being able to
>>>> ask for an ISA floppy disk controller.
>>>>
>>>> (It doesn't seem to have an ISA DMA controller by default, but I have no
>>>> idea if that means it can't EVER have one...)
>>>>
>>>> Papering over this by making it a soft error when we fail to execute
>>>> isa_get_dma and then assuming in retrospect it's because the machine
>>>> type we're on cannot have an ISA DMA controller seems a little
>>>> wrong-headed. It also leaves side-effects from isa_register_portio_list
>>>> and isa_init_irq, so we can't just bail here -- it's only marginally
>>>> better than the assert() it's doing.
>>>>
>>>> That said, I am not really sure what the right thing to do is ... I
>>>> suspect the "right thing" is to express the dependency that isa-fdc
>>>> requires an ISA DMA controller -- and maybe that check happens here when
>>>> isa_get_dma fails and we have to unwind the realize function, but we
>>>> need to do it gracefully.
>>>>
>>>> Give me a day to think about it, but I do want to make sure this is in
>>>> the next release.
>>>
>>> The day has passed, any news? :)
>>
>> *cough* It turns out that understanding the intricacies of FDC and ISA
>> is nobody's favorite thing to do.
>>
>> OK, so ehabkost pointed me to this:
>>
>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg496460.html
>>
>> Where we declare that DMA devices generally can't be created by the user
>> for the inverse of the reason we're seeing here: these devices need to
>> be created precisely once: not zero times, not twice, exactly once.
>>
>> So we made the ISA DMA devices themselves not user-creatable, so you are
>> indeed correct here that the absence of fdctrl->dma does more or less
>> mean that the current configuration "doesn't support DMA." ... but maybe
>> this won't always be true, and maybe some devices (TYPE_I82374?) are
>> user creatable, so let's make a "softer" error message:
>>
>> "No ISA DMA device present, can't create ISA FDC device."
>>
>> Then, on the other end, we need to unwind realize() gracefully, maybe we
>> can just shuffle up isa_get_dma() earlier so we don't have to unwind
>> anything if it comes back empty.
>>
>> Then I'll take the patch, because fixing this more properly I think will
>> take more time or effort than I have to spend on the FDC device.
> 
> The problem still persists ... was there ever a follow-up to this patch
> / discussion?
> 
>  Thomas
> 

No, I'll just stab at it during freeze. I can probably at least have it
fail gracefully, though what the "right" thing to do is still not
particularly clear to me as I don't really understand the platforms that
are failing.
