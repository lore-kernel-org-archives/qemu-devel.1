Received: from eggs.gnu.org ([2001:4830:134:3::10]:35321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <akrowiak@linux.ibm.com>) id 1g7MRI-0007FD-6S
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 11:18:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <akrowiak@linux.ibm.com>) id 1g7MRD-0002th-3O
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 11:18:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56366
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <akrowiak@linux.ibm.com>)
	id 1g7MRC-0002rj-PR
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 11:18:14 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w92FEuue033757
	for <qemu-devel@nongnu.org>; Tue, 2 Oct 2018 11:18:11 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2mv8a8gkak-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 02 Oct 2018 11:18:11 -0400
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <akrowiak@linux.ibm.com>;
	Tue, 2 Oct 2018 09:18:10 -0600
From: Tony Krowiak <akrowiak@linux.ibm.com>
References: <20180926225440.6204-1-akrowiak@linux.vnet.ibm.com>
	<20180926225440.6204-5-akrowiak@linux.vnet.ibm.com>
	<6ae10841-43af-f37f-450e-7dcb4cc75747@redhat.com>
	<20180927145240.7f8aba31.cohuck@redhat.com>
	<8a1b11b2-2145-d4fa-7415-8dc57402bdbe@linux.ibm.com>
Date: Tue, 2 Oct 2018 11:18:01 -0400
MIME-Version: 1.0
In-Reply-To: <8a1b11b2-2145-d4fa-7415-8dc57402bdbe@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <9afe3867-3a0e-8fe4-aa23-9b49a8e547fe@linux.ibm.com>
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
To: Halil Pasic <pasic@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: mjrosato@linux.vnet.ibm.com, Tony Krowiak <akrowiak@linux.vnet.ibm.com>, fiuczy@linux.ibm.com, eskultet@redhat.com, qemu-s390x@nongnu.org, heiko.carstens@de.ibm.com, david@redhat.com, pmorel@linux.vnet.ibm.com, qemu-devel@nongnu.org, agraf@suse.de, borntraeger@de.ibm.com, alex.williamson@redhat.com, pasic@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, schwidefsky@de.ibm.com, mimu@linux.ibm.com, bjsdjshi@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, eric.auger@redhat.com, rth@twiddle.net

On 09/28/2018 08:51 AM, Halil Pasic wrote:
> 
> 
> On 09/27/2018 02:52 PM, Cornelia Huck wrote:
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
> 
> Yes, we definitively discussed this before. And yes, it is a copy-paste
> error.
> 
> 
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
> 
> I was under impression that this is how inheritance/subtyping is done in
> QEMU. Was probably added for the sake of interface completeness.
> 
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
>>
>> Same here, I think.
>>
> 
> I don't think the qom utility/casting macros will ever be used. I'm
> fine with removing what is not needed.
> 
> Regards,
> Halil

Per Thomas's suggestions and Connie's concurrence, I am going to remove
the macros as well as the structures they reference. The ap_bridge.h
will be relegated to defining the bridge and bus types and serve as a
container for AP bridge and bus definitions that might be needed in the
future.

> 
>   
> 
