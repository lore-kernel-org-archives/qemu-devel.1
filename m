Received: from eggs.gnu.org ([209.51.188.92]:40213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1goHB5-0003TM-CW
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 19:23:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1goGyX-0000QL-Lo
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 19:10:03 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59042
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.ibm.com>)
	id 1goGyX-0000Po-FN
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 19:10:01 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x0SNwuwi142052
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 19:09:59 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2qaa23ndhu-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 19:09:59 -0500
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.ibm.com>;
	Tue, 29 Jan 2019 00:09:59 -0000
References: <20190121134249.16615-1-david@redhat.com>
	<20190121134249.16615-3-david@redhat.com>
	<20190123120539.3ca367f9.cohuck@redhat.com>
	<20190128122833.4613659a.cohuck@redhat.com>
From: Collin Walling <walling@linux.ibm.com>
Date: Mon, 28 Jan 2019 19:09:54 -0500
MIME-Version: 1.0
In-Reply-To: <20190128122833.4613659a.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <3b9f7e27-5f3b-5a36-87ab-209942334e59@linux.ibm.com>
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v3 2/2] s390x/pci: Unplug
 remaining devices on pcihost reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Richard Henderson <rth@twiddle.net>

On 1/28/19 6:28 AM, Cornelia Huck wrote:
> On Wed, 23 Jan 2019 12:05:39 +0100
> Cornelia Huck <cohuck@redhat.com> wrote:
> 
>> On Mon, 21 Jan 2019 14:42:49 +0100
>> David Hildenbrand <david@redhat.com> wrote:
>>
>>> When resetting the guest we should unplug and remove all devices that
>>> are still pending. Otherwise the fresh guest will see devices that will
>>> suddenly vanish.
>>>
>>> Can be triggered e.g. via
>>> (hmp) device_add virtio-mouse-pci,id=test
>>> (hmp) stop
>>> (hmp) device_del test
>>> (hmp) system_reset
>>> (hmp) c
>>>
>>> The device will vanish after roughly 5 minutes. With this patch, the
>>> device will vanish on reboot (S390_RESET_EXTERNAL and S390_RESET_REIPL,
>>> which reset the pcihost bridge via qemu_devices_reset()). If we want
>>> these devices to vanish directly on any reset (S390_RESET_MODIFIED_CLEAR
>>> and S390_RESET_LOAD_NORMAL), we have to modify s390_machine_reset(). But
>>> I have the feeling that this should not be done for all reset types.
>>>
>>> This approach is similar to what's done for acpi PCI hotplug in
>>> acpi_pcihp_reset() -> acpi_pcihp_update() ->
>>> acpi_pcihp_update_hotplug_bus() -> acpi_pcihp_eject_slot().
>>>
>>> s390_pci_generate_plug_event()'s will still be generated, I guess this
>>> is not an issue (same thing could happen right now if the timer expires
>>> just after reset).
>>
>> I'm wondering what the architecture says regarding those events -- can
>> someone with access to the documentation comment?
> 
> Ping. Any comments from the IBM folks?
> 


So the idea here is that if we have a PCI device that is the process of 
being deconfigured and we are also in the middle of a reset, then let's 
accelerate deconfiguring of the PCI device during the reset. Makes sense.

Note:

The callback function will deconfigure the the device and put it into 
standby mode. However, a PCI device should only go into standby from the 
*disabled state* (which it could already be in due to the unplug 
sequence), or from a *permanent error state* (something we should 
hopefully never see -- this means something went seriously wrong with 
the device).

Two things I'm concerned about:

1)

What I would suggest is adding a check for the pbdev->state for 
ZPCI_FS_DISABLED || ZPCI_FS_PERMANENT_ERROR. If it is in either of these 
states, then we're safe to deconfigure and put into standby. If the 
device is still in another state (such as enabled or blocked, etc) then 
we should allow the timer to resume and give the device some more time 
before forcing an unplug. It's also probably not a good idea to try and 
deconfigure a device that might already be deconfigured (e.g. if it's 
already in standby or reserved state). That might not happen though, but 
it's good to cover our bases.

A side thought: In addition to checking the states, what would happen if 
you forced the timer to 0? Would the callback get called? Would that 
just accelerate the already-in-progress unplug sequence?

and 2)

I worry that the sclp might try to deconfigure a PCI device at the same 
time we force the callback in this patch. I noticed that the 
sclp_deconfigure function also checks on the release timer before 
unplugging. I think we should make sure the timer is properly stopped or 
canceled before the sclp tries to deconfigure and before this patch 
forces the callback, that way we hopefully won't try to do both at the 
same time.

something like

if (release_timer) {
	stop timer
	unplug
}

Your adjustments to the pcihost_unplug function in patch #1 would of 
course handle freeing the release timer later on.

>>
>>>
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>> ---
>>>   hw/s390x/s390-pci-bus.c | 8 ++++++++
>>>   1 file changed, 8 insertions(+)
>>>
>>> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
>>> index bc17a8cf65..b70ae25533 100644
>>> --- a/hw/s390x/s390-pci-bus.c
>>> +++ b/hw/s390x/s390-pci-bus.c
>>> @@ -1102,6 +1102,14 @@ static void s390_pcihost_reset(DeviceState *dev)
>>>   {
>>>       S390pciState *s = S390_PCI_HOST_BRIDGE(dev);
>>>       PCIBus *bus = s->parent_obj.bus;
>>> +    S390PCIBusDevice *pbdev, *next;
>>> +
>>> +    /* Unplug all pending devices that were requested to be released */
>>> +    QTAILQ_FOREACH_SAFE(pbdev, &s->zpci_devs, link, next) {
>>> +        if (pbdev->release_timer) {
>>> +            s390_pcihost_timer_cb(pbdev);
>>> +        }
>>> +    }
>>>   
>>>       s->bus_no = 0;
>>>       pci_for_each_device(bus, pci_bus_num(bus), s390_pci_enumerate_bridge, s);
>>
> 
