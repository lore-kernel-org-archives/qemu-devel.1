Received: from eggs.gnu.org ([209.51.188.92]:50864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <akrowiak@linux.ibm.com>) id 1ggxQW-0007AB-I5
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 14:52:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <akrowiak@linux.ibm.com>) id 1ggxQV-0006p9-Hx
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 14:52:40 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48242
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <akrowiak@linux.ibm.com>)
	id 1ggxQV-0006oK-8t
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 14:52:39 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	x08JYX2X061164
	for <qemu-devel@nongnu.org>; Tue, 8 Jan 2019 14:52:38 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2pvy9hh4eh-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 08 Jan 2019 14:52:38 -0500
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <akrowiak@linux.ibm.com>;
	Tue, 8 Jan 2019 19:52:37 -0000
References: <1546963310-17024-1-git-send-email-akrowiak@linux.ibm.com>
	<5a7e9130-30d1-84ad-0737-5023b718b99c@redhat.com>
From: Tony Krowiak <akrowiak@linux.ibm.com>
Date: Tue, 8 Jan 2019 14:52:32 -0500
MIME-Version: 1.0
In-Reply-To: <5a7e9130-30d1-84ad-0737-5023b718b99c@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <54bc1f9c-e997-cb1b-77cb-0dce478fafdc@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] s390x/vfio-ap: Implement hot plug/unplug
 of vfio-ap device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, borntraeger@de.ibm.com, cohuck@redhat.com, pmorel@linux.ibm.com, alifm@linux.ibm.com, mjrosato@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.vnet.ibm.com, alex.williamson@redhat.com, peter.maydell@linaro.org, rth@twiddle.net, fiuczy@linux.ibm.com

On 1/8/19 11:09 AM, David Hildenbrand wrote:
> On 08.01.19 17:01, Tony Krowiak wrote:
>> Introduces hot plug/unplug support for the vfio-ap device. Note that only one
>> vfio-ap device can be attached to the ap-bus, so a vfio-ap device can only be
>> hot plugged if the '-device vfio-ap,sysfsdev=$path_to_mdev' option is not
>> specified on the QEMU command line.
>>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>> Reviewed-by: Pierre Morel<pmorel@linux.ibm.com>
>> Tested-by: Pierre Morel<pmorel@linux.ibm.com>
>> ---
>>   hw/s390x/ap-bridge.c | 12 +++++++++++-
>>   hw/vfio/ap.c         |  2 +-
>>   2 files changed, 12 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/s390x/ap-bridge.c b/hw/s390x/ap-bridge.c
>> index 3795d30dd7c9..25a03412fcb9 100644
>> --- a/hw/s390x/ap-bridge.c
>> +++ b/hw/s390x/ap-bridge.c
>> @@ -39,6 +39,7 @@ static const TypeInfo ap_bus_info = {
>>   void s390_init_ap(void)
>>   {
>>       DeviceState *dev;
>> +    BusState *bus;
>>   
>>       /* If no AP instructions then no need for AP bridge */
>>       if (!s390_has_feat(S390_FEAT_AP)) {
>> @@ -52,13 +53,18 @@ void s390_init_ap(void)
>>       qdev_init_nofail(dev);
>>   
>>       /* Create bus on bridge device */
>> -    qbus_create(TYPE_AP_BUS, dev, TYPE_AP_BUS);
>> +    bus = qbus_create(TYPE_AP_BUS, dev, TYPE_AP_BUS);
>> +
>> +    /* Enable hotplugging */
>> +    qbus_set_hotplug_handler(bus, dev, &error_abort);
>>    }
>>   
>>   static void ap_bridge_class_init(ObjectClass *oc, void *data)
>>   {
>>       DeviceClass *dc = DEVICE_CLASS(oc);
>> +    HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(oc);
>>   
>> +    hc->unplug = qdev_simple_device_unplug_cb;
> 
> confused, why is there no plug action?

You will find this is the case for several devices that are hot
pluggable. The plug callback is invoked after the device is
attached to the bus and after the device is realized. Not having
a hot plug callback does not preclude hot plugging of a device.
I presume the purpose of the callback is to provide an opportunity
to do perform any additional processing that may be required to prepare
the device for use. In the case of the vfio-ap device, there is nothing
to do once the device is plugged.


> 
>>       set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
>>   }
>>   
>> @@ -67,6 +73,10 @@ static const TypeInfo ap_bridge_info = {
>>       .parent        = TYPE_SYS_BUS_DEVICE,
>>       .instance_size = 0,
>>       .class_init    = ap_bridge_class_init,
>> +    .interfaces = (InterfaceInfo[]) {
>> +        { TYPE_HOTPLUG_HANDLER },
>> +        { }
>> +    }
>>   };
>>   
>>   static void ap_register(void)
>> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
>> index 6166ccd47a4a..d8b79ebe53ae 100644
>> --- a/hw/vfio/ap.c
>> +++ b/hw/vfio/ap.c
>> @@ -169,7 +169,7 @@ static void vfio_ap_class_init(ObjectClass *klass, void *data)
>>       set_bit(DEVICE_CATEGORY_MISC, dc->categories);
>>       dc->realize = vfio_ap_realize;
>>       dc->unrealize = vfio_ap_unrealize;
>> -    dc->hotpluggable = false;
>> +    dc->hotpluggable = true;
>>       dc->reset = vfio_ap_reset;
>>       dc->bus_type = TYPE_AP_BUS;
>>   }
>>
> 
> 
