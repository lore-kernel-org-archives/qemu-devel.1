Received: from eggs.gnu.org ([2001:4830:134:3::10]:47795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1fRJfv-0001OE-P3
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 11:51:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1fRJfq-00012h-S4
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 11:51:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42240
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.ibm.com>)
	id 1fRJfq-00012P-Ln
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 11:51:34 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w58FdQTm071409
	for <qemu-devel@nongnu.org>; Fri, 8 Jun 2018 11:51:33 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2jftad837p-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 08 Jun 2018 11:51:33 -0400
Received: from localhost
	by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.ibm.com>;
	Fri, 8 Jun 2018 16:51:31 +0100
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
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Fri, 8 Jun 2018 17:51:27 +0200
MIME-Version: 1.0
In-Reply-To: <20180608164514.2e8248f4.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <99ca65a2-ee33-6353-b6b7-aa4c07a34e2a@linux.ibm.com>
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
To: Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
Cc: Dong Jia Shi <bjsdjshi@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org

On 08/06/2018 16:45, Cornelia Huck wrote:
> On Fri, 8 Jun 2018 15:13:28 +0200
> Halil Pasic <pasic@linux.ibm.com> wrote:
>
>> On 06/08/2018 02:20 PM, Cornelia Huck wrote:
>>>>> My proposal is to do the same
>>>>> copying to scsw(r) again, which would mean we get a request with bo=
th
>>>>> the halt and the start bit set. The vfio code now needs to do a hsc=
h
>>>>> (instead of a ssch). The real channel subsystem should figure this =
out,
>>>>> as we can't reliably check whether the start function has concluded
>>>>> already (there's always a race window).
>>>> This I do not agree scsw(r) is part of the driver.
>>>> The interface here is not a device interface anymore but a driver
>>>> interface.
>>>> SCSW is a status, it is at its place in QEMU device interface with t=
he
>>>> guest
>>>> but here pwrite() sends a command.
>>> Hm, I rather consider that "we write a status, and the backend figure=
s
>>> out what to do based on that status".
>>>   =20
>> The status of what? Kind of a target status?
>>
>> I think this approach is the source of lots of complications. For inst=
ance
>> take xsch. How are we supposed to react to a guest xsch (in QEMU and
>> in the kernel module)? My guess is that the right thing to do is to is=
sue
>> an xsch in the vfio-ccw kernel module on the passed through subchannel.
>> But there is no bit in fctl for cancel.
>>
>> Bottom line is: I'm not happy with the current design but I'm not sure
>> if it's practical to do something about it (i.e. change it radically).
> It might make sense to keep this for ssch, maybe reuse it for hsch/csch=
,

I do not think we need to change the interface radically but
I also do not thing we should extend it by using multiple commands
in a single syscall.

Currently:
 =C2=A0 - only SSCH bit is used
 =C2=A0 - only the SSCH instruction is implemented
 =C2=A0 - all other bits, CSCH,HSCH produce an error when used alone
 =C2=A0=C2=A0=C2=A0 or are ignored in conjonction with SSCH
 =C2=A0=C2=A0 - there is no implementation using the other bits
 =C2=A0=C2=A0 - It is not specified in the documentation that multiple co=
mmands
 =C2=A0=C2=A0=C2=A0=C2=A0 can be used.

Looking at these, I think there is no trouble to modify the way
the Kernel interface is implemented without impact on current QEMU.

But if we begin to allow ssch/hsch/csch in a single command
in a new implementation we will be stuck with it.

> and think about something else for other things we want to handle

Yes we will need to have another interface, ioctl, or new region,
all possible, but really more complex.

> (xsch, channel monitoring, the path handling stuff for which we already

We can use another region for getting up information on path handling
or monitoring, as does the patch IIRC.
This is not a problem.

> had a prototype etc.) It's probably not practical to do radical surgery
> on the existing code.

There is no need for radical surgery, no change is required to older or
current QEMU code.
My concern is to avoid a future implementation merging multiple commands
in a single syscall.
It is not only a problem of beauty of the interface,
using a status is for the up-stream, from device to program.
Using the same construct, same name and same location, to produce command=
s
for the down stream is misleading and source of incoherence.

Sorry to have insisted so much but it seems so obvious to me.
May be I missed something.


Regards,
Pierre

>
> [Speaking of which: Is there any current effort on the path handling
> things?]
>

--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
