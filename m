Received: from eggs.gnu.org ([2001:4830:134:3::10]:49487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ezlDc-0008O1-8a
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 11:37:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ezlCY-0002R5-5k
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 11:36:32 -0400
Received: from mail-qk0-x231.google.com ([2607:f8b0:400d:c09::231]:39592)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ezlCX-0002QU-W5
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 11:35:26 -0400
Received: by mail-qk0-x231.google.com with SMTP id j73so15963110qke.6
	for <qemu-devel@nongnu.org>; Sat, 24 Mar 2018 08:35:25 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180216134516.6269-1-peter.maydell@linaro.org>
	<20180216134516.6269-2-peter.maydell@linaro.org>
	<20180216172841.2ec69b8a@redhat.com>
	<98a92185-d5e0-48fd-79a7-1c77260c9aca@amsat.org>
	<2d4874be-fec4-39bb-9df5-bb53f17d1d74@redhat.com>
	<20180220142319.2c959f83@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <fadf8f9f-acd1-6a47-086d-01590400104e@amsat.org>
Date: Sat, 24 Mar 2018 12:35:22 -0300
MIME-Version: 1.0
In-Reply-To: <20180220142319.2c959f83@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/2] hw/sysbus.h: New sysbus_init_child()
 helper function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, patches@linaro.org

Hi,

On 02/20/2018 10:23 AM, Igor Mammedov wrote:
> On Tue, 20 Feb 2018 13:13:49 +0100
> Paolo Bonzini <pbonzini@redhat.com> wrote:
> 
>> On 16/02/2018 18:40, Philippe Mathieu-Daudé wrote:
>>> we can keep object_initialize() when no parent,
>>> and add object_initialize_child(, const char *childname, Object *parent)
>>> 'parent' last because all previous args are child-related.
>>>   
>>>>  
>>>>> +    qdev_set_parent_bus(DEVICE(child), sysbus_get_default());  
>>>> and then assuming we don't create sysbus devices, nor should be able to,
>>>> which are not attached to sysbus_get_default() this one can go sysbus' instance_init()  
>>> good idea.
>>>   
> [...]
> 
>> I'm not sure about moving qdev_set_parent_bus to instance_init().  It
>> would be a bit different from other buses and possibly confusing.
> That's what this series sort of does, i.e. creating a type/class
> specific helper(s). Which becomes confusing as number of helpers
> increases (frankly it's just 2 different approaches to code i.e.
> functional vs OOM).
> 
> It could be better to keep single QOM API and let SYSBUS base class
> instance_init() to do all implicit initialization that must be done
> for inherited classes.

What is the consensus on this series once 2.12 gets released?

> Yes, it will be different from other devices with buses but
> users won't really care (there is no other buss to assign to),
> for them it will look like a typical bus-less device and it
> would be less error-prone to code.
> 
>  
>> Potentially there could be a "hierarchy" of *_initialize_child
>> functions, adding or removing arguments as needed for the specific kind
>> of bus:
>>
>> 	/* adds qdev_set_parent_bus */
>> 	device_initialize_child(Object *parent, const char *childname,
>> 				BusState *bus, void *data, size_t size,
>> 				const char *typename);
>> 	/* uses sysbus_get_default() */
>> 	sysbus_initialize_child(Object *parent, const char *childname,
>> 				void *data, size_t size,
>> 				const char *typename);
> 
> 
>> 	/* initializes "addr" property too */
>> 	pci_initialize_child(Object *parent, const char *childname,
>> 			     BusState *bus, int addr,
>> 			     void *data, size_t size,
>> 			     const char *typename);
> PCI could also incorporate PCI specific bus setting/
> verification logic inside of base class.
> 
> It could allow us to drop bus assigning magic in qdev_device_add(),
> bringing it closer to simple QOM object handling, with specifics
> abstracted by respective TYPE implementations.
> Maybe we would be able to unify -device with -object in the end.

Thanks,

Phil.
