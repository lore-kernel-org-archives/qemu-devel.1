Received: from eggs.gnu.org ([2001:4830:134:3::10]:49352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1f4NPW-000519-Td
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 05:12:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1f4NPE-0007Oc-Gg
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 05:11:54 -0400
References: <1521156300-19296-1-git-send-email-akrowiak@linux.vnet.ibm.com>
	<1521156300-19296-7-git-send-email-akrowiak@linux.vnet.ibm.com>
	<4d76348b-e1de-7d92-3434-5213d092c6d0@redhat.com>
	<ab945ab4-ee17-815b-2a59-b7608ff32eb6@linux.vnet.ibm.com>
	<0b957a5c-1a87-7952-292d-f65052bb6c5a@linux.vnet.ibm.com>
	<20180403113619.54ff1e18.cohuck@redhat.com>
	<dd4fceac-818f-14a2-62b4-94ae73e21796@linux.vnet.ibm.com>
	<ee3b89cf-c260-361f-3eb6-71371bbe827f@linux.vnet.ibm.com>
	<20180406104024.51e9e826.cohuck@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <0244b89c-e8c4-72a1-9b25-d69341ec721d@redhat.com>
Date: Fri, 6 Apr 2018 11:11:26 +0200
MIME-Version: 1.0
In-Reply-To: <20180406104024.51e9e826.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, mjrosato@linux.vnet.ibm.com, alex.williamson@redhat.com, eskultet@redhat.com, peter.maydell@linaro.org, Pierre Morel <pmorel@linux.vnet.ibm.com>, alifm@linux.vnet.ibm.com, heiko.carstens@de.ibm.com, qemu-devel@nongnu.org, agraf@suse.de, borntraeger@de.ibm.com, qemu-s390x@nongnu.org, jjherne@linux.vnet.ibm.com, schwidefsky@de.ibm.com, pbonzini@redhat.com, bjsdjshi@linux.vnet.ibm.com, eric.auger@redhat.com, rth@twiddle.net

On 06.04.2018 10:40, Cornelia Huck wrote:
> On Thu, 5 Apr 2018 19:17:47 +0200
> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
>=20
>> On 04/05/2018 06:38 PM, Tony Krowiak wrote:
>>>> Hard=C2=A0to=C2=A0really=C2=A0give=C2=A0good=C2=A0advice=C2=A0withou=
t=C2=A0access=C2=A0to=C2=A0the=C2=A0documentation,=C2=A0but:
>>>> -=C2=A0If=C2=A0we=C2=A0tell=C2=A0the=C2=A0guest=C2=A0that=C2=A0the=C2=
=A0feature=C2=A0is=C2=A0available,=C2=A0but=C2=A0it=C2=A0does=C2=A0not
>>>> =C2=A0=C2=A0=C2=A0get=C2=A0any=C2=A0cards=C2=A0to=C2=A0use,=C2=A0ret=
urning=C2=A0an=C2=A0empty=C2=A0matrix=C2=A0makes=C2=A0the=C2=A0most=C2=A0=
sense
>>>> =C2=A0=C2=A0=C2=A0to=C2=A0me.
>>>> -=C2=A0I=C2=A0would=C2=A0not=C2=A0tie=C2=A0starting=C2=A0the=C2=A0gu=
est=C2=A0to=C2=A0the=C2=A0presence=C2=A0of=C2=A0a=C2=A0vfio-ap
>>>> =C2=A0=C2=A0=C2=A0device.=C2=A0Having=C2=A0the=C2=A0feature=C2=A0ava=
ilable=C2=A0in=C2=A0theory=C2=A0but=C2=A0without=C2=A0any
>>>> =C2=A0=C2=A0=C2=A0devices=C2=A0actually=C2=A0being=C2=A0usable=C2=A0=
by=C2=A0the=C2=A0guest=C2=A0does=C2=A0not=C2=A0really=C2=A0sound
>>>> =C2=A0=C2=A0=C2=A0wrong=C2=A0(can=C2=A0we=C2=A0hotplug=C2=A0this=C2=A0=
later?) =20
>>> For this phase of development, it is my opinion that introducing AP i=
nstruction
>>> interception=C2=A0handlers=C2=A0is=C2=A0superfluous=C2=A0for=C2=A0the=
=C2=A0following=C2=A0reasons:
>>>
>>> 1. Interception handling was introduced solely to ensure an operation=
 exception=C2=A0would
>>> =C2=A0=C2=A0 not be injected into the guest when CPU model feature fo=
r AP (i.e., ap=3Don)
>>> =C2=A0=C2=A0 is specified but a VFIO AP device (i.e., -device vfio-ap=
,sysfsdev=3D$path)
>>> =C2=A0=C2=A0=C2=A0is=C2=A0not.
>>>
>>> 2. The implementation of guest dedicated crypto adapters uses AP inst=
ruction
>>> =C2=A0=C2=A0=C2=A0interpretation=C2=A0to=C2=A0virtualize=C2=A0AP=C2=A0=
devices=C2=A0for=C2=A0a=C2=A0guest.=C2=A0As=C2=A0such,=C2=A0the=C2=A0NQAP=
,
>>> =C2=A0=C2=A0=C2=A0DQAP=C2=A0and=C2=A0most=C2=A0variants=C2=A0of=C2=A0=
the=C2=A0PQAP=C2=A0instructions=C2=A0will=C2=A0not=C2=A0be
>>> =C2=A0=C2=A0=C2=A0intercepted.
>>>
>>> 3. Hot plugging AP devices is not being supported for this phase of d=
evelopment.
>>>
>>> It is my opinion that introducing these interception handlers at this=
 time=C2=A0is
>>> unnecessary=C2=A0and=C2=A0risks=C2=A0opening=C2=A0a=C2=A0can=C2=A0of=C2=
=A0worms=C2=A0that=C2=A0would=C2=A0be
>>> better dealt with in a subsequent phase. For that reason and the reas=
ons stated
>>> above,=C2=A0I=C2=A0think=C2=A0the=C2=A0better=C2=A0option=C2=A0is=C2=A0=
to=C2=A0terminate=C2=A0starting=C2=A0the=C2=A0guest=C2=A0if=C2=A0the
>>> CPU=C2=A0model=C2=A0feature=C2=A0for=C2=A0AP=C2=A0is=C2=A0enabled=C2=A0=
but=C2=A0an=C2=A0AP=C2=A0device=C2=A0is=C2=A0not=C2=A0defined=C2=A0for=C2=
=A0the
>>> guest. This restriction, of course, will be removed when hot plug is =
implemented
>>> in=C2=A0a=C2=A0subsequent=C2=A0development=C2=A0phase. =20
>>
>> I second that! I agree that having ap instructions but not having the
>> possibility to actually do AP crypto is probably not what the user wan=
ts.
>> Preventing such a guest form starting (with a nice message) sounds rea=
sonable
>> to me.
>=20
> One problem I have with that is that it feels backwards to me.
>=20
> The situation "you cannot add this device unless $FEATURE is present"
> is quite common and thus easily understood. Now, this would introduce
> the situation "you cannot present $FEATURE unless this device is also
> present, and that right at the start". I'm not sure how you are
> supposed to correlate a cpu feature with the existence of a device.

I agree. Don't make things harder than they are. This smells like "cpu
feature can only be provided if another magical QEMU command line option
is present". Don't do that.

Is it really that hard to implement a very simple interception handler
that says t all instructions "yeah, I'm alive, but no, nothing to see her=
e".

>=20
>> I agree with Connie, the approach 'hold the line' (until future hotplu=
gs)
>> is the most reasonable thing to do *in the long run*. But I think it's=
 better
>> to limit ourselves to the simplest case for now, I don't see any probl=
ems
>> with doing the hotplug support later.
>=20
> Yes, having to add handlers that add very little benefit sucks, I
> agree. But I fear if we add the "feature needs device" dependency, we
> open another can of worms, including the question what happens if we
> want to support hotplug in the future (I'm not altogether sure how to
> handle the whole checking from qemu).
>=20
> Making sure that we have both the feature and the device when using a
> management software (e.g. libvirt) makes a lot of sense (and is
> probably also easier to implement), but it won't help us with the issue
> of the interception handlers, unfortunately.
>=20

I agree.


--=20

Thanks,

David / dhildenb
