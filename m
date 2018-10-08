Received: from eggs.gnu.org ([2001:4830:134:3::10]:54954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1g9WQq-0001vc-Gh
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 10:22:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1g9WQn-0006Jh-2h
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 10:22:48 -0400
References: <20180926225440.6204-1-akrowiak@linux.vnet.ibm.com>
	<20180926225440.6204-5-akrowiak@linux.vnet.ibm.com>
	<6ae10841-43af-f37f-450e-7dcb4cc75747@redhat.com>
	<20180927145240.7f8aba31.cohuck@redhat.com>
	<ee677383-b23c-61a0-f622-807532563650@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <635820eb-dcb2-9bf1-a3da-641c7e659e9b@redhat.com>
Date: Mon, 8 Oct 2018 16:22:27 +0200
MIME-Version: 1.0
In-Reply-To: <ee677383-b23c-61a0-f622-807532563650@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v9 4/6] s390x/ap: base Adjunct
 Processor (AP) object model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tony Krowiak <akrowiak@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, qemu-devel@nongnu.org, pmorel@linux.vnet.ibm.com, fiuczy@linux.ibm.com, eskultet@redhat.com, agraf@suse.de, borntraeger@de.ibm.com, jjherne@linux.vnet.ibm.com, mimu@linux.ibm.com, heiko.carstens@de.ibm.com, eric.auger@redhat.com, alex.williamson@redhat.com, bjsdjshi@linux.vnet.ibm.com, rth@twiddle.net, mjrosato@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, qemu-s390x@nongnu.org, schwidefsky@de.ibm.com

On 08/10/2018 16:20, Tony Krowiak wrote:
> On 09/27/2018 08:52 AM, Cornelia Huck wrote:
>> On Thu, 27 Sep 2018 14:29:01 +0200
>> Thomas Huth <thuth@redhat.com> wrote:
>>
>>> On 2018-09-27 00:54, Tony Krowiak wrote:
>>>> From: Tony Krowiak <akrowiak@linux.ibm.com>
>>>>
>>>> Introduces the base object model for virtualizing AP devices.
>>>>
>>>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>>>> ---
>>
>>>> +typedef struct APBridge {
>>>> +    SysBusDevice sysbus_dev;
>>>> +    bool css_dev_path;
>>>
>>> What is this css_dev_path variable good for? I don't see it used in any
>>> of the other patches?
>>> If you don't need it, I think you could get rid of this struct completely?
>>
>> Huh, now I remember complaining about it before. Looks like a
>> copy-and-paste from the css bridge; that variable is used for compat
>> handling there (and should be ditched here).
>>
>>>
>>>> +} APBridge;
>>>> +
>>>> +#define TYPE_AP_BRIDGE "ap-bridge"
>>>> +#define AP_BRIDGE(obj) \
>>>> +    OBJECT_CHECK(APBridge, (obj), TYPE_AP_BRIDGE)
>>>> +
>>>> +typedef struct APBus {
>>>> +    BusState parent_obj;
>>>> +} APBus;
>>>> +
>>>> +#define TYPE_AP_BUS "ap-bus"
>>>> +#define AP_BUS(obj) \
>>>> +     OBJECT_CHECK(APBus, (obj), TYPE_AP_BUS)
>>>
>>> I think you could also get rid of AP_BRIDGE(), AP_BUS() and maybe even
>>> struct APBus.
>>
>> If there's nothing interesting to put in these inherited structures,
>> probably yes.
>>
>>>
>>>> +void s390_init_ap(void);
>>>> +
>>>> +#endif
>>>> diff --git a/include/hw/s390x/ap-device.h b/include/hw/s390x/ap-device.h
>>>> new file mode 100644
>>>> index 000000000000..693df90cc041
>>>> --- /dev/null
>>>> +++ b/include/hw/s390x/ap-device.h
>>>> @@ -0,0 +1,38 @@
>>>> +/*
>>>> + * Adjunct Processor (AP) matrix device interfaces
>>>> + *
>>>> + * Copyright 2018 IBM Corp.
>>>> + * Author(s): Tony Krowiak <akrowiak@linux.vnet.ibm.com>
>>>> + *
>>>> + * This work is licensed under the terms of the GNU GPL, version 2 or (at
>>>> + * your option) any later version. See the COPYING file in the top-level
>>>> + * directory.
>>>> + */
>>>> +#ifndef HW_S390X_AP_DEVICE_H
>>>> +#define HW_S390X_AP_DEVICE_H
>>>> +
>>>> +#define AP_DEVICE_TYPE       "ap-device"
>>>> +
>>>> +typedef struct APDevice {
>>>> +    DeviceState parent_obj;
>>>> +} APDevice;
>>>> +
>>>> +typedef struct APDeviceClass {
>>>> +    DeviceClass parent_class;
>>>> +} APDeviceClass;
>>>> +
>>>> +static inline APDevice *to_ap_dev(DeviceState *dev)
>>>> +{
>>>> +    return container_of(dev, APDevice, parent_obj);
>>>> +}
>>>> +
>>>> +#define AP_DEVICE(obj) \
>>>> +    OBJECT_CHECK(APDevice, (obj), AP_DEVICE_TYPE)
>>>> +
>>>> +#define AP_DEVICE_GET_CLASS(obj) \
>>>> +    OBJECT_GET_CLASS(APDeviceClass, (obj), AP_DEVICE_TYPE)
>>>> +
>>>> +#define AP_DEVICE_CLASS(klass) \
>>>> +    OBJECT_CLASS_CHECK(APDeviceClass, (klass), AP_DEVICE_TYPE)
>>>
>>> Do you really need any of these definitions except AP_DEVICE_TYPE ?
> 
> Yes, we need AP_DEVICE(obj) and struct APDevice; they are both used in
> patch 5/6. We can probably get rid of AP_DEVICE_GET_CLASS(obj) and
> AP_DEVICE_CLASS(klass), but aren't those typically included in all
> QOM definitions?

Yes, we usually add all of them although only some might actually be
used. (adding a new device usually looks like filling out a template)

-- 

Thanks,

David / dhildenb
