Received: from eggs.gnu.org ([209.51.188.92]:44629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <akrowiak@linux.ibm.com>) id 1ghGhq-000842-Ha
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 11:27:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <akrowiak@linux.ibm.com>) id 1ghGhp-0006to-CQ
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 11:27:50 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39742)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <akrowiak@linux.ibm.com>)
	id 1ghGho-0006rt-3W
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 11:27:48 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	x09GOKvJ033325
	for <qemu-devel@nongnu.org>; Wed, 9 Jan 2019 11:27:46 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2pwjs4wq5w-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 09 Jan 2019 11:27:45 -0500
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <akrowiak@linux.ibm.com>;
	Wed, 9 Jan 2019 16:27:44 -0000
References: <1546963310-17024-1-git-send-email-akrowiak@linux.ibm.com>
	<5a7e9130-30d1-84ad-0737-5023b718b99c@redhat.com>
	<54bc1f9c-e997-cb1b-77cb-0dce478fafdc@linux.ibm.com>
	<d4599c55-2d71-e1e9-ec7a-cffbc7d06abe@redhat.com>
	<20190109123037.7f51888f.cohuck@redhat.com>
From: Tony Krowiak <akrowiak@linux.ibm.com>
Date: Wed, 9 Jan 2019 11:27:36 -0500
MIME-Version: 1.0
In-Reply-To: <20190109123037.7f51888f.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <fb665b3b-9bbf-e2bd-8618-b080d4c2453d@linux.ibm.com>
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
To: Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, borntraeger@de.ibm.com, pmorel@linux.ibm.com, alifm@linux.ibm.com, mjrosato@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.vnet.ibm.com, alex.williamson@redhat.com, peter.maydell@linaro.org, rth@twiddle.net, fiuczy@linux.ibm.com

On 1/9/19 6:30 AM, Cornelia Huck wrote:
> On Tue, 8 Jan 2019 23:13:39 +0100
> David Hildenbrand <david@redhat.com> wrote:
> 
>> On 08.01.19 20:52, Tony Krowiak wrote:
>>> On 1/8/19 11:09 AM, David Hildenbrand wrote:
>>>> On 08.01.19 17:01, Tony Krowiak wrote:
>>>>> Introduces hot plug/unplug support for the vfio-ap device. Note that only one
>>>>> vfio-ap device can be attached to the ap-bus, so a vfio-ap device can only be
>>>>> hot plugged if the '-device vfio-ap,sysfsdev=$path_to_mdev' option is not
>>>>> specified on the QEMU command line.
>>>>>
>>>>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>>>>> Reviewed-by: Pierre Morel<pmorel@linux.ibm.com>
>>>>> Tested-by: Pierre Morel<pmorel@linux.ibm.com>
>>>>> ---
>>>>>    hw/s390x/ap-bridge.c | 12 +++++++++++-
>>>>>    hw/vfio/ap.c         |  2 +-
>>>>>    2 files changed, 12 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/hw/s390x/ap-bridge.c b/hw/s390x/ap-bridge.c
>>>>> index 3795d30dd7c9..25a03412fcb9 100644
>>>>> --- a/hw/s390x/ap-bridge.c
>>>>> +++ b/hw/s390x/ap-bridge.c
>>>>> @@ -39,6 +39,7 @@ static const TypeInfo ap_bus_info = {
>>>>>    void s390_init_ap(void)
>>>>>    {
>>>>>        DeviceState *dev;
>>>>> +    BusState *bus;
>>>>>    
>>>>>        /* If no AP instructions then no need for AP bridge */
>>>>>        if (!s390_has_feat(S390_FEAT_AP)) {
>>>>> @@ -52,13 +53,18 @@ void s390_init_ap(void)
>>>>>        qdev_init_nofail(dev);
>>>>>    
>>>>>        /* Create bus on bridge device */
>>>>> -    qbus_create(TYPE_AP_BUS, dev, TYPE_AP_BUS);
>>>>> +    bus = qbus_create(TYPE_AP_BUS, dev, TYPE_AP_BUS);
>>>>> +
>>>>> +    /* Enable hotplugging */
>>>>> +    qbus_set_hotplug_handler(bus, dev, &error_abort);
>>>>>     }
>>>>>    
>>>>>    static void ap_bridge_class_init(ObjectClass *oc, void *data)
>>>>>    {
>>>>>        DeviceClass *dc = DEVICE_CLASS(oc);
>>>>> +    HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(oc);
>>>>>    
>>>>> +    hc->unplug = qdev_simple_device_unplug_cb;
>>>>
>>>> confused, why is there no plug action?
>>>
>>> You will find this is the case for several devices that are hot
>>> pluggable.
>>
>> Usually missing hotplug handlers are an indication of legacy code ;)
>>
>>> The plug callback is invoked after the device is
>>> attached to the bus and after the device is realized. Not having
>>> a hot plug callback does not preclude hot plugging of a device.
>>
>> The hotplug handler is there to
>>
>> 1. Assign resources (e.g. ids etc)
>> 2. Notify the system (e.g. hotplug interrupt)
>>
>> In legacy code (e.g. PCI) such stuff is usually still located in the
>> realize function (where it doesn't belong anymore but factoring out is
>> hard ...)
>>
>> Looking at hw/vfio/ap.c:realize(), there isn't really anything in there.
>>
>> So I assume that
>>
>> 1. No resources have to be assigned (for vfio-ap, I guess the IDs and
>> such are implicit)
> 
> That's my understanding as well. The interesting stuff will be
> configured on kernel level before the device is even handed to QEMU for
> consumption.

The vfio-ap device represents a VFIO mdev device. AP resources - i.e.,
adapters, domains and control domains - are assigned to the mdev device
via its sysfs interfaces. This is all handled by the vfio_ap kernel
driver before a guest can use the mdev device. As part of vfio-ap device
realization, a file descriptor is opened on the mdev device. When the 
mdev device's fd is opened, a callback is invoked on the vfio_ap kernel
device driver. The device driver then updates the guest's AP matrix
configuration based on the configuration specified via the mdev
device's sysfs interfaces.

> 
> (Would be nice to hint at that in the patch description.)
> 
>> 2. No notification will happen. How will the guest know that a new AP
>> adapter is available?
> 
> My understanding is that hotplugging the matrix device will make the
> guest go from "no adapters/domains are available" to "some
> adapters/domains are available" (and unplug will do the reverse). I.e.,
> no hot(un)plugging of individual queues (which would need to be done on
> the kernel level, and is tricky IIRC.)
> 
> I'm not sure what the architectured options for notifying the guest are
> (I dimly recall some kind of "AP configuration has changed event").
> 
> IIRC, the Linux guest driver scans for new queues periodically. Does it
> even do that if no queues are available to start with?

The AP bus - in this case, running in the guest - does a periodic scan
for AP devices. The bus relies on an AP instruction that queries the
AP configuration information. When the guest's AP matrix is updated -
see description of mdev device fd open processing above - the query
will provide the newly configured AP matrix and the bus will create
the adapter and queue devices on the guest. Consequently, there is
nothing to do in a hot plug handler. If you'd like, I'd be more than
happy to include a hot plug handler that does some logging (or nothing
at all) so it doesn't look like legacy code ;)

> 
>>
>>> I presume the purpose of the callback is to provide an opportunity
>>> to do perform any additional processing that may be required to prepare
>>> the device for use. In the case of the vfio-ap device, there is nothing
>>> to do once the device is plugged.
>>
>> When removing the device, is it really a forced removal? ("simply rip it
>> out without telling the guest")

When the vfio-ap device is unrealized, the mdev device's file descriptor
is closed. When the fd is closed, a callback is invoked on the vfio_ap
kernel device driver. This callback clears the guest's AP matrix
configuration and resets all of the AP queues affected. When the AP
device scan is subsequently run by the AP bus on the guest, the AP
instruction for querying the AP configuration will indicate that there
are no AP devices configured. The bus will then remove the AP devices
from the sysfs for the guest.


> 
> I hope that severing the connection between QEMU and the host kernel
> for AP takes care of cleanup. It's all a bit confusing :(

I agree, the AP architecture is complicated and confusing. As I said
above, when the mdev device fd is closed, the vfio_ap kernel device
driver will reset all AP queues affected by the de-configuration.

> 
