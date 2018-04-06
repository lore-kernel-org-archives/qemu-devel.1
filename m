Received: from eggs.gnu.org ([2001:4830:134:3::10]:38239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1f4QBX-0000Yu-Bf
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 08:09:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1f4QBS-00056o-OK
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 08:09:39 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54860)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1f4QBS-00056H-Fh
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 08:09:34 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w36C7YTJ015783
	for <qemu-devel@nongnu.org>; Fri, 6 Apr 2018 08:09:33 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2h67xh1vuw-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 06 Apr 2018 08:09:32 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Fri, 6 Apr 2018 13:09:29 +0100
References: <1521156300-19296-1-git-send-email-akrowiak@linux.vnet.ibm.com>
	<1521156300-19296-7-git-send-email-akrowiak@linux.vnet.ibm.com>
	<4d76348b-e1de-7d92-3434-5213d092c6d0@redhat.com>
	<ab945ab4-ee17-815b-2a59-b7608ff32eb6@linux.vnet.ibm.com>
	<0b957a5c-1a87-7952-292d-f65052bb6c5a@linux.vnet.ibm.com>
	<20180403113619.54ff1e18.cohuck@redhat.com>
	<dd4fceac-818f-14a2-62b4-94ae73e21796@linux.vnet.ibm.com>
	<ee3b89cf-c260-361f-3eb6-71371bbe827f@linux.vnet.ibm.com>
	<20180406104024.51e9e826.cohuck@redhat.com>
	<0244b89c-e8c4-72a1-9b25-d69341ec721d@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Fri, 6 Apr 2018 14:09:24 +0200
MIME-Version: 1.0
In-Reply-To: <0244b89c-e8c4-72a1-9b25-d69341ec721d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Message-Id: <e5b5f06e-7007-1398-25c4-f37c2db5de79@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 6/7] s390x/kvm: handle AP instruction
 interception
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: mjrosato@linux.vnet.ibm.com, peter.maydell@linaro.org, Tony Krowiak <akrowiak@linux.vnet.ibm.com>, eskultet@redhat.com, qemu-s390x@nongnu.org, heiko.carstens@de.ibm.com, alifm@linux.vnet.ibm.com, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org, agraf@suse.de, borntraeger@de.ibm.com, alex.williamson@redhat.com, jjherne@linux.vnet.ibm.com, schwidefsky@de.ibm.com, pbonzini@redhat.com, bjsdjshi@linux.vnet.ibm.com, eric.auger@redhat.com, rth@twiddle.net



On 04/06/2018 11:11 AM, David Hildenbrand wrote:
> On 06.04.2018 10:40, Cornelia Huck wrote:
>> On Thu, 5 Apr 2018 19:17:47 +0200
>> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
>>
>>> On 04/05/2018 06:38 PM, Tony Krowiak wrote:
>>>>> Hard=C2=A0to=C2=A0really=C2=A0give=C2=A0good=C2=A0advice=C2=A0witho=
ut=C2=A0access=C2=A0to=C2=A0the=C2=A0documentation,=C2=A0but:
>>>>> -=C2=A0If=C2=A0we=C2=A0tell=C2=A0the=C2=A0guest=C2=A0that=C2=A0the=C2=
=A0feature=C2=A0is=C2=A0available,=C2=A0but=C2=A0it=C2=A0does=C2=A0not
>>>>> =C2=A0=C2=A0=C2=A0get=C2=A0any=C2=A0cards=C2=A0to=C2=A0use,=C2=A0re=
turning=C2=A0an=C2=A0empty=C2=A0matrix=C2=A0makes=C2=A0the=C2=A0most=C2=A0=
sense
>>>>> =C2=A0=C2=A0=C2=A0to=C2=A0me.
>>>>> -=C2=A0I=C2=A0would=C2=A0not=C2=A0tie=C2=A0starting=C2=A0the=C2=A0g=
uest=C2=A0to=C2=A0the=C2=A0presence=C2=A0of=C2=A0a=C2=A0vfio-ap
>>>>> =C2=A0=C2=A0=C2=A0device.=C2=A0Having=C2=A0the=C2=A0feature=C2=A0av=
ailable=C2=A0in=C2=A0theory=C2=A0but=C2=A0without=C2=A0any
>>>>> =C2=A0=C2=A0=C2=A0devices=C2=A0actually=C2=A0being=C2=A0usable=C2=A0=
by=C2=A0the=C2=A0guest=C2=A0does=C2=A0not=C2=A0really=C2=A0sound
>>>>> =C2=A0=C2=A0=C2=A0wrong=C2=A0(can=C2=A0we=C2=A0hotplug=C2=A0this=C2=
=A0later?) =20
>>>> For this phase of development, it is my opinion that introducing AP =
instruction
>>>> interception=C2=A0handlers=C2=A0is=C2=A0superfluous=C2=A0for=C2=A0th=
e=C2=A0following=C2=A0reasons:
>>>>
>>>> 1. Interception handling was introduced solely to ensure an operatio=
n exception=C2=A0would
>>>> =C2=A0=C2=A0 not be injected into the guest when CPU model feature f=
or AP (i.e., ap=3Don)
>>>> =C2=A0=C2=A0 is specified but a VFIO AP device (i.e., -device vfio-a=
p,sysfsdev=3D$path)
>>>> =C2=A0=C2=A0=C2=A0is=C2=A0not.
>>>>
>>>> 2. The implementation of guest dedicated crypto adapters uses AP ins=
truction
>>>> =C2=A0=C2=A0=C2=A0interpretation=C2=A0to=C2=A0virtualize=C2=A0AP=C2=A0=
devices=C2=A0for=C2=A0a=C2=A0guest.=C2=A0As=C2=A0such,=C2=A0the=C2=A0NQAP=
,
>>>> =C2=A0=C2=A0=C2=A0DQAP=C2=A0and=C2=A0most=C2=A0variants=C2=A0of=C2=A0=
the=C2=A0PQAP=C2=A0instructions=C2=A0will=C2=A0not=C2=A0be
>>>> =C2=A0=C2=A0=C2=A0intercepted.
>>>>
>>>> 3. Hot plugging AP devices is not being supported for this phase of =
development.
>>>>
>>>> It is my opinion that introducing these interception handlers at thi=
s time=C2=A0is
>>>> unnecessary=C2=A0and=C2=A0risks=C2=A0opening=C2=A0a=C2=A0can=C2=A0of=
=C2=A0worms=C2=A0that=C2=A0would=C2=A0be
>>>> better dealt with in a subsequent phase. For that reason and the rea=
sons stated
>>>> above,=C2=A0I=C2=A0think=C2=A0the=C2=A0better=C2=A0option=C2=A0is=C2=
=A0to=C2=A0terminate=C2=A0starting=C2=A0the=C2=A0guest=C2=A0if=C2=A0the
>>>> CPU=C2=A0model=C2=A0feature=C2=A0for=C2=A0AP=C2=A0is=C2=A0enabled=C2=
=A0but=C2=A0an=C2=A0AP=C2=A0device=C2=A0is=C2=A0not=C2=A0defined=C2=A0for=
=C2=A0the
>>>> guest. This restriction, of course, will be removed when hot plug is=
 implemented
>>>> in=C2=A0a=C2=A0subsequent=C2=A0development=C2=A0phase. =20
>>>
>>> I second that! I agree that having ap instructions but not having the
>>> possibility to actually do AP crypto is probably not what the user wa=
nts.
>>> Preventing such a guest form starting (with a nice message) sounds re=
asonable
>>> to me.
>>
>> One problem I have with that is that it feels backwards to me.
>>
>> The situation "you cannot add this device unless $FEATURE is present"
>> is quite common and thus easily understood. Now, this would introduce
>> the situation "you cannot present $FEATURE unless this device is also
>> present, and that right at the start". I'm not sure how you are
>> supposed to correlate a cpu feature with the existence of a device.


I think it can be done straightforward and with less LOC than interceptio=
n
and emulation of 'nothing to see here' requires.

>=20
> I agree. Don't make things harder than they are. This smells like "cpu
> feature can only be provided if another magical QEMU command line optio=
n
> is present". Don't do that.

Yes it is conceptually ugly. I'm 100% with you. That's why it should go
away soon. From the practicality perspective however I would even argue t=
hat it's
helpful to the user: tells 'oops you have forgotten something'. IMHO
it's a shortcut of type make the problem smaller. Regarding what is
harder and what is easier: the author is probably the most fit to decide
that. If it is harder, it makes no sense, as this is all about cutting
corners.

>=20
> Is it really that hard to implement a very simple interception handler
> that says t all instructions "yeah, I'm alive, but no, nothing to see h=
ere".
>=20

I find it somewhat difficult to reason about what is static and what is
dynamic in the AP architecture. To put something together that seems to
work should be relatively easy. I could even say, I hope Tony tested the
no device case with v3 and it apparently seemed to work -- as I don't see
any does not work disclaimer. But getting all the stuff correct is IMHO
a bit more of a challenge.

>>
>>> I agree with Connie, the approach 'hold the line' (until future hotpl=
ugs)
>>> is the most reasonable thing to do *in the long run*. But I think it'=
s better
>>> to limit ourselves to the simplest case for now, I don't see any prob=
lems
>>> with doing the hotplug support later.
>>
>> Yes, having to add handlers that add very little benefit sucks, I
>> agree. But I fear if we add the "feature needs device" dependency, we
>> open another can of worms, including the question what happens if we
>> want to support hotplug in the future (I'm not altogether sure how to
>> handle the whole checking from qemu).
>>

We do want hotplug in the future AFAIK. The idea was to just remove the
limitation when everything is in place.

Regarding the implementation, the idea was to use=20
qemu_add_machine_init_done_notifier and  only catch both of the following=
 true
* the cpu model has ap=3Don
* on the ap bus (I think it would be nice to have a bus with max_dev =3D =
1)
  there is no device

When hotplug becomes available for vfio-ap we would just remove that code.
For me it seemed legit. We have a precedence for not really complete stuf=
f
with vfio-ccw. So if it was OK to defer the stuff that was deferred there=
,
I think, ap=3Don suddenly working without the strange device should be OK=
 too.

>> Making sure that we have both the feature and the device when using a
>> management software (e.g. libvirt) makes a lot of sense (and is
>> probably also easier to implement), but it won't help us with the issu=
e
>> of the interception handlers, unfortunately.
>>

I disagree. Conceptually hotplug of vfio-ap is perfectly legit. So doing
something like this in management software sounds wrong. The idea here
is cutting corners in order to have something that works reasonably well
but with a couple of well defined limitations sooner.

Regards,
Halil
