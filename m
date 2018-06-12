Received: from eggs.gnu.org ([2001:4830:134:3::10]:40630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1fSjmV-0005Vl-6c
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 09:56:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1fSjmR-0006br-Mw
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 09:56:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41616
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.ibm.com>)
	id 1fSjmR-0006bH-H5
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 09:56:15 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w5CDrWTU022829
	for <qemu-devel@nongnu.org>; Tue, 12 Jun 2018 09:56:14 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2jjff583jx-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 12 Jun 2018 09:56:14 -0400
Received: from localhost
	by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.ibm.com>;
	Tue, 12 Jun 2018 14:56:12 +0100
Reply-To: pmorel@linux.ibm.com
References: <20180509154822.23510-1-cohuck@redhat.com>
	<20180509154822.23510-3-cohuck@redhat.com>
	<c18f9b9f-da00-1a0b-8ef0-7ac223c73d1a@linux.ibm.com>
	<20180515181006.0cb1dfc2.cohuck@redhat.com>
	<a5d08fb7-d9c1-b230-fe0c-acebbda2ba65@linux.ibm.com>
	<20180522145208.310143ea.cohuck@redhat.com>
	<4e4001cc-540e-0f2b-bbd1-1f82ca594bb3@linux.ibm.com>
	<20180605151449.22aafbfc.cohuck@redhat.com>
	<e73038ff-fb2d-5865-8b84-e775990f3983@linux.ibm.com>
	<20180606142131.74ea2eb7.cohuck@redhat.com>
	<5b77ec9c-41b8-2e32-ce79-d9005b93fdd0@linux.ibm.com>
	<20180607115442.6a779ed9.cohuck@redhat.com>
	<86d57698-3ea7-a390-2217-07c6d41ca9ed@linux.ibm.com>
	<20180608142022.7dd6a658.cohuck@redhat.com>
	<d68340a2-bb1b-cef9-e394-f0d55983c0bb@linux.ibm.com>
	<20180608164514.2e8248f4.cohuck@redhat.com>
	<99ca65a2-ee33-6353-b6b7-aa4c07a34e2a@linux.ibm.com>
	<20180612115900.4aa319d1.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Tue, 12 Jun 2018 15:56:06 +0200
MIME-Version: 1.0
In-Reply-To: <20180612115900.4aa319d1.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <d5416c61-252a-5bb8-aebe-46d883e5822e@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC 2/2] vfio-ccw: support for halt/clear
 subchannel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, Dong Jia Shi <bjsdjshi@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org

On 12/06/2018 11:59, Cornelia Huck wrote:
> On Fri, 8 Jun 2018 17:51:27 +0200
> Pierre Morel <pmorel@linux.ibm.com> wrote:
>
>> On 08/06/2018 16:45, Cornelia Huck wrote:
>>> On Fri, 8 Jun 2018 15:13:28 +0200
>>> Halil Pasic <pasic@linux.ibm.com> wrote:
>>>  =20
>>>> On 06/08/2018 02:20 PM, Cornelia Huck wrote:
>>>>>>> My proposal is to do the same
>>>>>>> copying to scsw(r) again, which would mean we get a request with =
both
>>>>>>> the halt and the start bit set. The vfio code now needs to do a h=
sch
>>>>>>> (instead of a ssch). The real channel subsystem should figure thi=
s out,
>>>>>>> as we can't reliably check whether the start function has conclud=
ed
>>>>>>> already (there's always a race window).
>>>>>> This I do not agree scsw(r) is part of the driver.
>>>>>> The interface here is not a device interface anymore but a driver
>>>>>> interface.
>>>>>> SCSW is a status, it is at its place in QEMU device interface with=
 the
>>>>>> guest
>>>>>> but here pwrite() sends a command.
>>>>> Hm, I rather consider that "we write a status, and the backend figu=
res
>>>>> out what to do based on that status".
>>>>>      =20
>>>> The status of what? Kind of a target status?
>>>>
>>>> I think this approach is the source of lots of complications. For in=
stance
>>>> take xsch. How are we supposed to react to a guest xsch (in QEMU and
>>>> in the kernel module)? My guess is that the right thing to do is to =
issue
>>>> an xsch in the vfio-ccw kernel module on the passed through subchann=
el.
>>>> But there is no bit in fctl for cancel.
>>>>
>>>> Bottom line is: I'm not happy with the current design but I'm not su=
re
>>>> if it's practical to do something about it (i.e. change it radically=
).
>>> It might make sense to keep this for ssch, maybe reuse it for hsch/cs=
ch,
>> I do not think we need to change the interface radically but
>> I also do not thing we should extend it by using multiple commands
>> in a single syscall.
>>
>> Currently:
>>   =C2=A0 - only SSCH bit is used
>>   =C2=A0 - only the SSCH instruction is implemented
>>   =C2=A0 - all other bits, CSCH,HSCH produce an error when used alone
>>   =C2=A0=C2=A0=C2=A0 or are ignored in conjonction with SSCH
>>   =C2=A0=C2=A0 - there is no implementation using the other bits
>>   =C2=A0=C2=A0 - It is not specified in the documentation that multipl=
e commands
>>   =C2=A0=C2=A0=C2=A0=C2=A0 can be used.
> Looking at Documentation/s390/vfio-ccw.txt, it states that "scsw_area
> should be filled with the SCSW of the Virtual Subchannel". This seems
> to indicate that this is really intended to be a scsw... but I agree,
> it does lack details.
>
>> Looking at these, I think there is no trouble to modify the way
>> the Kernel interface is implemented without impact on current QEMU.
>>
>> But if we begin to allow ssch/hsch/csch in a single command
>> in a new implementation we will be stuck with it.
> Yes, we're currently still free to go in different directions; adding
> support for hsch/csch to the interface in the way I did would fix it.
> In any case, we need better documentation :/
>
>>> and think about something else for other things we want to handle
>> Yes we will need to have another interface, ioctl, or new region,
>> all possible, but really more complex.
>>
>>> (xsch, channel monitoring, the path handling stuff for which we alrea=
dy
>> We can use another region for getting up information on path handling
>> or monitoring, as does the patch IIRC.
>> This is not a problem.
> Not a problem, I agree (and yes, the patch did that).
>
> For xsch, I like Halil's suggestion of simply always setting cc 2.
>
> Channel monitoring is a difficult beast (need to pass through msch, mix
> of virtual and passthrough devices on the machine which have different
> semantics etc.) I put some of my concerns into
> https://wiki.qemu.org/ToDo/Channel_I/O_Passthrough; please add to that
> if you have further thoughts.
>
> We should keep those requirements in mind, even if we won't implement
> support for it right now.
>
>>> had a prototype etc.) It's probably not practical to do radical surge=
ry
>>> on the existing code.
>> There is no need for radical surgery, no change is required to older o=
r
>> current QEMU code.
>> My concern is to avoid a future implementation merging multiple comman=
ds
>> in a single syscall.
>> It is not only a problem of beauty of the interface,
>> using a status is for the up-stream, from device to program.
>> Using the same construct, same name and same location, to produce comm=
ands
>> for the down stream is misleading and source of incoherence.
> OK, I think I see your concern now.
>
> What happens on the real hardware is that we do a ssch etc. and this
> triggers a change that is visible in the scsw when we do a stsch.
>
> What happens here is that the guest doing a ssch triggers a change in
> our virtual scsw in QEMU (so far, so good); then we send this scsw to
> the vfio module, which looks at the scsw to figure out that it should
> do a ssch on the host. This works fine to figure out that a ssch needs
> to be done, and would also work for hsch and csch, but it is really a
> bit of reverse engineering, and it would probably fail for rsch
> (haven't thought about that yet). To parse the intention of doing a
> halt or clear out of the scsw_area, we need to rely (a) on user space
> doing the right thing, and (b) on us implementing the rules for which
> function can be initiated when correctly. If we treat fctl as a simple
> command field, we'll just do what user space asks of us directly.
>
> So, what are you proposing? Being more specific and stating that the
> scsw is not necessarily a real scsw, but merely a vehicle for sending a
> command? Or keeping it as it is now for ssch, and adding a second
> interface for hsch/csch (and maybe rsch, msch, ...)?
>


I said no radical surgery, but after thinking more about it...
I am not sure.

Let's explain this:

I see 2 ways to proceed but my favorite is definitively to introduce=20
versioning.


Way 1)

This was the way I first thought about.
We keep the existing IO Regionand structures, and are more
specific by stating that the io_region is a command region during write
entry and a status region during interrupt handling:
This allow us to use the 3 bits of the FCTL field of the SCSW to pass
commands to the kernel and stay backward compatible.
The FCTL field has 3 bits =3D> we can have 8 commands.

PRO: small change

CONTRA: This is still confusing, we do not really solve this
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unclarity problem since QEMU =
view / documentation and
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Linux view / documentation di=
ffer or we update QEMU.
 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Moreover this does not allow for l=
ong term extensions
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 and/or re-design.



Way 2)

We use the device VFIO versioning using the capability chain to advertise
a new interface.

This the preferred way, it is sane, allows for the userland backward
compatibility and allows to have a new command interface, extensible
for future use.

In this case we can extend the interface to be any kind we want
in a next version, pwrite with new io_region, mmap on new
IO regions, status region...

PRO: Extensible and also goes in the VFIO INFO extension direction
 =C2=A0=C2=A0=C2=A0=C2=A0 proposed by Alex

CONTRA: I see none outer more work to do (but is it a problem?)


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Extra argumentation for versioning support


Suppose a future implementation with 4 mapped regions like
the following:

- A Status region (RO updated as result of command and IRQ)

- A command region (WO where the user send its commands)
 =C2=A0 userland write here to trigger IO (quite as currently)

- A CCW program region (RW where the CCW chain is handled)
 =C2=A0 most handling done from userspace, last translations in kernel,
 =C2=A0 double buffering...

- A performance / measurement / statistics region (RO)
 =C2=A0 This is updated asynchronously by hardware and/or driver

This is purely theoretical and we do not need to do all at once
but if we want to extend the implementation without problems
and continue backward compatibility the versioning and capability
handling is a must.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D


Regards,

Pierre



--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
