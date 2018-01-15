Received: from eggs.gnu.org ([2001:4830:134:3::10]:50006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1eb1tx-0007B8-IS
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 05:22:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1eb1tr-0001yd-Ky
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 05:22:01 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60680
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.vnet.ibm.com>)
	id 1eb1tr-0001yE-FZ
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 05:21:55 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0FAJEFI125360
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 05:21:54 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2fgrx4v4q0-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 05:21:54 -0500
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.vnet.ibm.com>;
	Mon, 15 Jan 2018 10:21:52 -0000
References: <20180111030421.31418-1-bjsdjshi@linux.vnet.ibm.com>
	<20180111115422.201987ee.cohuck@redhat.com>
	<20180115085741.GB12499@bjsdjshi@linux.vnet.ibm.com>
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Date: Mon, 15 Jan 2018 11:21:47 +0100
MIME-Version: 1.0
In-Reply-To: <20180115085741.GB12499@bjsdjshi@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <bd035cc2-1859-91da-9051-660caec6ac0f@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 0/3] vfio: ccw: basic channel path
 event handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, borntraeger@de.ibm.com, pasic@linux.vnet.ibm.com

On 15/01/2018 09:57, Dong Jia Shi wrote:
> * Cornelia Huck <cohuck@redhat.com> [2018-01-11 11:54:22 +0100]:
>
>> On Thu, 11 Jan 2018 04:04:18 +0100
>> Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:
>>
>>> Hi Folks,
>>>
>>> Background
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>
>>> Some days ago, we had a discussion on the topic of channel path virtu=
alization.
>>> Ref:
>>> Subject: [PATCH 0/3] Channel Path realted CRW generation
>>> Message-Id: <20170727015418.85407-1-bjsdjshi@linux.vnet.ibm.com>
>>> URL: https://lists.nongnu.org/archive/html/qemu-devel/2017-07/msg0841=
4.html
>>>
>>> Indeed that thread is not short and discussed many aspects in a
>>> non-concentrated manner. The parts those are most valuable to me are:
>>> 1. a re-modelling for channel path is surely the best offer, but is n=
ot
>>>     possible to have in the near future.
>>> 2. to enhance the path related functionalities, using PNO and PNOM mi=
ght
>>>     be something we can do for now. This may be something that I coul=
d improve
>>>     without model related arguments.
>>>
>>> So here I have this series targeting to add basic channel path event =
handling
>>> for vfio-ccw -- no touch of the channel path modelling in both the ke=
rnel and
>>> the QEMU side, but find a way to sync path status change to guest laz=
ily using
>>> SCSW_FLAGS_MASK_PNO and pmcw->pnom.  In short, I want to enhance path=
 related
>>> stuff (to be more specific: sync up path status to the guest) on a be=
st effort
>>> basis, which means in a way that won't get us invloed to do channel p=
ath
>>> re-modelling.
>> The guest should also get the updated PIM/PAM/POM, shouldn't it?
>>
> Yes. The following values will be updated for the guest:
> PMCW:
>    - PIM/PAM/POM
>    - PNOM
>    - CHPIDs
> SCSW
>    - PNOM bit
>
> See vfio_ccw_update_schib in patch #4 of the QEMU series.
>
>>> What benifit can we get from this? The administrator of a virtual mac=
hine can
>>> get uptodate (in some extent) status of the current using channel pat=
hs, so
>>> he/she can monitor paths status and get path problem noticed timely (=
see the
>>> example below).
>>>
>>> I think we can start a new round discussion based on this series. So =
reviewers
>>> can give their comments based on some code, and then we can decide if=
 this is
>>> we want or not.
>>>
>>> As flagged with RFC, the intention of this series is to show what I h=
ave for
>>> now, and what could the code look like in general. Thus I can get som=
e early
>>> feedbacks. I would expect to see opinions on:
>>> - is the target (mentioned above) of this series welcomed or not.
>> It certainly makes sense to have a way to get an updated schib.
>>
> :)

I think so too, if the guest's administrator wants to be able to do=20
something.

But I would like to see something about path virtualization.
Having more accurate information on hardware without virtualization is a
big handicap for migration and hotplug.

Regards,

Pierre


--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
