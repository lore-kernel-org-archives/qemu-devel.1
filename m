Received: from eggs.gnu.org ([209.51.188.92]:37497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1goTnE-0007Ej-Ak
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 08:51:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1goTn8-0003ae-Br
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 08:51:12 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36514)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.ibm.com>)
	id 1goTn8-0003a9-1f
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 08:51:06 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x0TDnUjJ053429
	for <qemu-devel@nongnu.org>; Tue, 29 Jan 2019 08:51:04 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qaqv40s51-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 29 Jan 2019 08:51:03 -0500
Received: from localhost
	by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.ibm.com>;
	Tue, 29 Jan 2019 13:51:01 -0000
Reply-To: pmorel@linux.ibm.com
References: <20190121134249.16615-1-david@redhat.com>
	<20190121134249.16615-3-david@redhat.com>
	<20190123120539.3ca367f9.cohuck@redhat.com>
	<20190128122833.4613659a.cohuck@redhat.com>
	<3b9f7e27-5f3b-5a36-87ab-209942334e59@linux.ibm.com>
	<0c546fd4-28dd-6e62-8f9f-cd7894d36849@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Tue, 29 Jan 2019 14:50:56 +0100
MIME-Version: 1.0
In-Reply-To: <0c546fd4-28dd-6e62-8f9f-cd7894d36849@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <a904740f-66e5-0956-44e7-4c29a4552897@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
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
To: David Hildenbrand <david@redhat.com>, Collin Walling <walling@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>

On 29/01/2019 11:24, David Hildenbrand wrote:
>>>> I'm wondering what the architecture says regarding those events -- c=
an
>>>> someone with access to the documentation comment?
>>>
>>> Ping. Any comments from the IBM folks?

Hi,

Sorry to have wait so long.
At least Collin was faster.

>>>
>>
>>
>> So the idea here is that if we have a PCI device that is the process o=
f
>> being deconfigured and we are also in the middle of a reset, then let'=
s
>> accelerate deconfiguring of the PCI device during the reset. Makes sen=
se.

to me too.
However, how do we ensure that the guest got time to respond to the=20
first deconfigure request?

>>
>> Note:
>>
>> The callback function will deconfigure the the device and put it into
>> standby mode. However, a PCI device should only go into standby from t=
he
>> *disabled state* (which it could already be in due to the unplug
>> sequence), or from a *permanent error state* (something we should
>> hopefully never see -- this means something went seriously wrong with
>> the device).

Not completely exact, the CHSC event 0x304, on the initiative of the=20
host, force the "deconfigure state" from "configure state" generally,=20
whatever sub-state it has (enabled/disabled/error...).

>=20
> Right, this should already have been checked before setting up the time=
r.

Apropos timer, do we need a timer or wouldn't it be better to use a=20
delay / a timer + condition?

AFAIU we get out of the unplug without waiting for any answer from the=20
guest and we surely get the timer triggering after the reset has been don=
e.
That seems bad.


>=20
>>
>> Two things I'm concerned about:
>>
>> 1)
>>
>> What I would suggest is adding a check for the pbdev->state for
>> ZPCI_FS_DISABLED || ZPCI_FS_PERMANENT_ERROR. If it is in either of the=
se
>> states, then we're safe to deconfigure and put into standby. If the
>=20
> We setup a timer if !ZPCI_FS_STANDBY and !ZPCI_FS_RESERVED.
>=20
> So for
> - ZPCI_FS_DISABLED
> - ZPCI_FS_ENABLED
> - ZPCI_FS_BLOCKED
> - ZPCI_FS_ERROR
> - ZPCI_FS_PERMANENT_ERROR
>=20
> We setup a timer and simply go ahead and unplug the device when the
> timer expires ("forced unplug").

I agree only for ZPCI_FS_ENABLED why do we need to be smooth for other=20
states?
ZPCI_FS_DISABLED may be a candidate even I do not see the interrest but=20
other states of the device should issue a HP_EVENT_DECONFIGURE_REQUEST=20
and we do not need a timer (or any delay)

>=20
> Changing that behavior might be more invasive. Simply not unplugging in
> s390_pcihost_timer_cb() on some of these states would mean that somebod=
y
> issued a request and that requests is simply lost/ignored. Not sure if
> that is what we want. I think we need separate patches to change
> something like that. Especially
>=20
> 1. What happens if the device was in ZPCI_FS_DISABLED, the guest ignore=
s
> the unplug request and moves the device to ZPCI_FS_ENABLED before the
> timer expires? These are corner cases to consider.

+1, we must ensure to do the work inside the unplug CB.

>=20
> 2. Do we need a timer at all? Now that Patch #1 introduces
> unplug_requests, we are free to ignore requests from the user if the
> guest is not reacting. I would really favor getting rid of the timer
> completely. Was there a special reason why this was introduced?

Yes, to let a chance to the guest to smoothly relinquish the device.
(for example sync/clean the disk)
However I do not think it is right implemented.

>=20
> No other architecture (e.g. ACPI) uses such a timer. They use a simple
> flag to remember if a request is pending. I would really favor going
> into that direction.

I am not sure that the Intel architecture is a good example. :)

AFAIU they do not wait for the guest to have relinquish the device.
Or do they?
How long do they wait?

>=20
> @Christian do you think we need this "force remove after 30 seconds"
> timer thingy?
>=20
>> device is still in another state (such as enabled or blocked, etc) the=
n
>> we should allow the timer to resume and give the device some more time
>> before forcing an unplug. It's also probably not a good idea to try an=
d
>> deconfigure a device that might already be deconfigured (e.g. if it's
>> already in standby or reserved state). That might not happen though, b=
ut
>> it's good to cover our bases.
>>
>> A side thought: In addition to checking the states, what would happen =
if
>> you forced the timer to 0? Would the callback get called? Would that
>> just accelerate the already-in-progress unplug sequence?
>=20
> I guess so, but then action will be called asynchronously from the main
> loop when timers are run. Calling it synchronously during the reset
> makes in my point of view more sense.

To me too, (and during hot unplug too) but it has a sense only if we=20
wait some time between the demand to relinquish the device and the rip=20
off of the device.

Regards,
Pierre

--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
