Received: from eggs.gnu.org ([209.51.188.92]:46646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1goYLR-0000vl-3I
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 13:42:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1goYLP-0006Ku-Ih
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 13:42:49 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48896)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.ibm.com>)
	id 1goYLN-0006JA-If
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 13:42:46 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x0TIcuh3028016
	for <qemu-devel@nongnu.org>; Tue, 29 Jan 2019 13:42:38 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qau1gc5j9-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 29 Jan 2019 13:42:37 -0500
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.ibm.com>;
	Tue, 29 Jan 2019 18:42:36 -0000
References: <20190121134249.16615-1-david@redhat.com>
	<20190121134249.16615-3-david@redhat.com>
	<20190123120539.3ca367f9.cohuck@redhat.com>
	<20190128122833.4613659a.cohuck@redhat.com>
	<3b9f7e27-5f3b-5a36-87ab-209942334e59@linux.ibm.com>
	<0c546fd4-28dd-6e62-8f9f-cd7894d36849@redhat.com>
	<a904740f-66e5-0956-44e7-4c29a4552897@linux.ibm.com>
	<accf8243-1100-117b-9bae-899537bf433c@redhat.com>
	<f9959c97-463e-9681-46ef-19ea728c2025@linux.ibm.com>
	<eecbc9c1-cae8-f5d6-32be-8bf71436ac2f@redhat.com>
From: Collin Walling <walling@linux.ibm.com>
Date: Tue, 29 Jan 2019 13:42:31 -0500
MIME-Version: 1.0
In-Reply-To: <eecbc9c1-cae8-f5d6-32be-8bf71436ac2f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <aa80eac9-ed9d-b6c2-0e71-eea157c3f23e@linux.ibm.com>
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
To: David Hildenbrand <david@redhat.com>, pmorel@linux.ibm.com, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>

On 1/29/19 1:20 PM, David Hildenbrand wrote:
> On 29.01.19 17:50, Pierre Morel wrote:
>> On 29/01/2019 16:11, David Hildenbrand wrote:
>>> On 29.01.19 14:50, Pierre Morel wrote:
>>>> On 29/01/2019 11:24, David Hildenbrand wrote:
>>>>>>>> I'm wondering what the architecture says regarding those events -- can
>>>>>>>> someone with access to the documentation comment?
>>>>>>>
>>>>>>> Ping. Any comments from the IBM folks?
>>>>
>>>> Hi,
>>>>
>>>> Sorry to have wait so long.
>>>> At least Collin was faster.
>>>>
>>>>>>>
>>>>>>
>>>>>>
>>>>>> So the idea here is that if we have a PCI device that is the process of
>>>>>> being deconfigured and we are also in the middle of a reset, then let's
>>>>>> accelerate deconfiguring of the PCI device during the reset. Makes sense.
>>>>
>>>> to me too.
>>>> However, how do we ensure that the guest got time to respond to the
>>>> first deconfigure request?
>>>
>>> 30 seconds, then the reboot. On a reboot, I don't see why we should give
>>> a guest more time. "It's dead", rip out the card as the guest refused to
>>> hand it back. (maybe it crashed! but after a reboot the guest state is
>>> reset and baught back to life)
>>
>> I agree that 30 seconds is way enough,
>> also agree that in most cases the guest is dead.
>>
>>
>>>
>>>>
>>>>>>
>>>>>> Note:
>>>>>>
>>>>>> The callback function will deconfigure the the device and put it into
>>>>>> standby mode. However, a PCI device should only go into standby from the
>>>>>> *disabled state* (which it could already be in due to the unplug
>>>>>> sequence), or from a *permanent error state* (something we should
>>>>>> hopefully never see -- this means something went seriously wrong with
>>>>>> the device).
>>>>
>>>> Not completely exact, the CHSC event 0x304, on the initiative of the
>>>> host, force the "deconfigure state" from "configure state" generally,
>>>> whatever sub-state it has (enabled/disabled/error...).
>>>>
>>>>>
>>>>> Right, this should already have been checked before setting up the timer.
>>>>
>>>> Apropos timer, do we need a timer or wouldn't it be better to use a
>>>> delay / a timer + condition?
>>>
>>> I don't think we need a timer at all.
>>
>> Yes, if it is possible to wait synchronously 30s it seems good to me.
> 
> I mean, we don't have to wait 30 seconds at all.
> 
> 1. We send a request to the guest
> 2. It responds (after some seconds), letting go of the zPCI device
> 3. We unplug the device
> 
> 1. We send a request to the guest
> 2. Guest does not respond, request keeps pending forever
> 3. On reboot, unplug the device
> 
> This is how x86/ACPI handles it.
> 
>>
>>>
>>>>
>>>> AFAIU we get out of the unplug without waiting for any answer from the
>>>> guest and we surely get the timer triggering after the reset has been done.
>>>> That seems bad.
>>>
>>> This is the case right now, correct.
>>>
>>>>
>>>>
>>>>>
>>>>>>
>>>>>> Two things I'm concerned about:
>>>>>>
>>>>>> 1)
>>>>>>
>>>>>> What I would suggest is adding a check for the pbdev->state for
>>>>>> ZPCI_FS_DISABLED || ZPCI_FS_PERMANENT_ERROR. If it is in either of these
>>>>>> states, then we're safe to deconfigure and put into standby. If the
>>>>>
>>>>> We setup a timer if !ZPCI_FS_STANDBY and !ZPCI_FS_RESERVED.
>>>>>
>>>>> So for
>>>>> - ZPCI_FS_DISABLED
>>>>> - ZPCI_FS_ENABLED
>>>>> - ZPCI_FS_BLOCKED
>>>>> - ZPCI_FS_ERROR
>>>>> - ZPCI_FS_PERMANENT_ERROR
>>>>>
>>>>> We setup a timer and simply go ahead and unplug the device when the
>>>>> timer expires ("forced unplug").
>>>>
>>>> I agree only for ZPCI_FS_ENABLED why do we need to be smooth for other
>>>> states?
>>>> ZPCI_FS_DISABLED may be a candidate even I do not see the interrest but
>>>> other states of the device should issue a HP_EVENT_DECONFIGURE_REQUEST
>>>> and we do not need a timer (or any delay)
>>>
>>> You can always expect that your guest driver is dead.
>>
>> hum, the device is dead.
>> May be the guest got hit too if the driver is not right written.
>>
>>>
>>>>
>>>>>
>>>>> Changing that behavior might be more invasive. Simply not unplugging in
>>>>> s390_pcihost_timer_cb() on some of these states would mean that somebody
>>>>> issued a request and that requests is simply lost/ignored. Not sure if
>>>>> that is what we want. I think we need separate patches to change
>>>>> something like that. Especially
>>>>>
>>>>> 1. What happens if the device was in ZPCI_FS_DISABLED, the guest ignores
>>>>> the unplug request and moves the device to ZPCI_FS_ENABLED before the
>>>>> timer expires? These are corner cases to consider.
>>>>
>>>> +1, we must ensure to do the work inside the unplug CB.
>>>>
>>>>>
>>>>> 2. Do we need a timer at all? Now that Patch #1 introduces
>>>>> unplug_requests, we are free to ignore requests from the user if the
>>>>> guest is not reacting. I would really favor getting rid of the timer
>>>>> completely. Was there a special reason why this was introduced?
>>>>
>>>> Yes, to let a chance to the guest to smoothly relinquish the device.
>>>> (for example sync/clean the disk)
>>>> However I do not think it is right implemented.
>>>>
>>>>>
>>>>> No other architecture (e.g. ACPI) uses such a timer. They use a simple
>>>>> flag to remember if a request is pending. I would really favor going
>>>>> into that direction.
>>>>
>>>> I am not sure that the Intel architecture is a good example. :)
>>>
>>> Right, we all learned that zPCI did it better. (sorry ;) )
>>
>> Well I really think so.
>> It is designed with several guest in parallel and shared devices.
>>
>> In such an architecture, ripping of a device from a guest may have interest.
>> One good thing would be that the software of the guest handle it :)
> 
> That is indeed true, but I think such a forced removal also works on
> x86. Theoretically. ("physically rip out the card"). See below.
> 
>>
>>>
>>>>
>>>> AFAIU they do not wait for the guest to have relinquish the device.
>>>> Or do they?
>>>> How long do they wait?
>>>
>>> They wait for ever. And I guess we should do the same thing. If the
>>> guest driver is broken (and this is really a rare scenario!) we would
>>> not get the device back. Which is perfectly fine in my point of view. In
>>> all other scenarios I guess the guest will simply respond in a timely
>>> manner. And ripping out stuff from the guest always feels wrong. (yes
>>> the channel subsystem works like that, but here we actually have a choice)
>>>
>>> If we reboot, we can unplug the device. Otherwise, let's keep it simply
>>> and don't use a timer.
>>>
>>> Thanks!
>>>

This makes more sense to me. If something goes wrong with unplugging a device,
and we use a timeout for forcefully unplug the device... it will never be
apparent to the guest or user that something went wrong in the first place!

>>
>> AFAIK We have no plan to operate on pools of PCI devices so for me I 
>> have no objection to keep it simple:
> 
> Especially one note:
> 
> There seems to be demand for a so called "forced PCI removal" also on
> other architectures. However, this would than rather most probably be
> modeled on top of what we have right now.
> 
> E.g. instead of "device_del XXX" which would request the guest to let go
> of the device, there could be something like "device_del XXX,forced=true".
> 
> E.g. ask the guest. If it does not respond after some time, force remove
> it. This is basically the timer, but managed by a different level, of
> software. And you can than actually decide if you want to do eventually
> harm to the guest OS.
> 
> Are there any other objects of getting rid of the timer?
> 
> Conny could pick up patch #1 once you get an ACK. I would send more
> patches to drop the timer and rework this patch.
> 
> Thanks Pierre!
> 
>>
>> Regards,
>> Pierre
>>
>>
>>
> 
> 

David, Pierre: good discussion.

I'm in favor of dropping the timer, especially with the notes and examples 
above. I think the PCI code will look a lot cleaner / easier-to-maintain 
without it as well.

-- 
Respectfully,
- Collin Walling
