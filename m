Received: from eggs.gnu.org ([2001:4830:134:3::10]:60741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1f6XnS-0002UT-AD
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 04:41:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1f6XnO-0006SL-9i
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 04:41:34 -0400
Received: from 1.mo2.mail-out.ovh.net ([46.105.63.121]:54257)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1f6XnO-0006Ql-2N
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 04:41:30 -0400
Received: from player773.ha.ovh.net (unknown [10.109.122.73])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 2C0E812D89F
	for <qemu-devel@nongnu.org>; Thu, 12 Apr 2018 10:41:26 +0200 (CEST)
References: <20171209084338.29395-1-clg@kaod.org>
	<20171209084338.29395-3-clg@kaod.org>
	<20171220050947.GC5981@umbus.fritz.box>
	<1513815126.2743.34.camel@kernel.crashing.org>
	<6768575f-27e0-1277-3e7e-56ec44298e6a@kaod.org>
	<1513896817.2743.63.camel@kernel.crashing.org>
	<683d0912-ad48-927c-8235-5358417be44c@kaod.org>
	<20180412051031.GM9425@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <81703ef0-ca2e-5f57-2a11-b2656f8906d7@kaod.org>
Date: Thu, 12 Apr 2018 10:41:21 +0200
MIME-Version: 1.0
In-Reply-To: <20180412051031.GM9425@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 02/19] spapr: introduce a skeleton for
 the XIVE interrupt controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>

On 04/12/2018 07:10 AM, David Gibson wrote:
> On Wed, Jan 17, 2018 at 10:18:43AM +0100, C=E9dric Le Goater wrote:
>>>>> Also, have we decided how the process of switching between XICS and
>>>>> XIVE will work vs. CAS ?=20
>>>>
>>>> That's how it is described in the architecture. The current choice i=
s
>>>> to create both XICS and XIVE objects and choose at CAS which one to
>>>> use. It relies today on the capability of the pseries machine to=20
>>>> allocate IRQ numbers for both interrupt controller backends. These
>>>> patches have been merged in QEMU.
>>>>
>>>> A change of interrupt mode results in a reset. The device tree is=20
>>>> populated accordingly and the ICPs are switched for the model in=20
>>>> use.=20
>>>
>>> For KVM we need to only instanciate one of them though.
>>
>> Hmm,
>>
>> How would we handle a guest rebooting on a kernel without XIVE support=
 ?=20
>> Are you suggesting to create the XICS or XIVE device in the CAS negoti=
ation=20
>> process ? So, the machine would not have any interrupt controller befo=
re=20
>> CAS. That seems really late to me. grub uses the console for instance.=
=20
>>
>> I think it should prepare for both options, start in XIVE legacy mode,=
=20
>> which is XICS, then possibly switch to XIVE exploitation mode.
>=20
> I think for our first draft we should have XIVE and XICS based
> platforms as separate machine types (or a machine option, I guess).

OK. This is my current choice for KVM.=20

Emulated mode is rather simple to handle, and this is why I have =20
kept the reset after CAS if there is a change in the interrupt mode.=20
=20
> We do want to allow this to be autonegotiated, but I feel like
> emphasising that at the beginning is causing unnatural design
> decisions in the XIVE model itself.

Yes. This is mostly a KVM problem which also has impacts on XICS=20
of course ...

C. =20
=20
>>
>>>>> And how that will interact with KVM ?
>>>>
>>>> I expect we will do the same, which is to create two KVM devices to=20
>>>> be able to handle both interrupt controller backends depending on th=
e=20
>>>> mode negotiated by the guest. =20
>>>
>>> That will be an ungodly mess, I'd rather we only instanciate the righ=
t
>>> one.
>>
>> It's rather transparent currently in the emulated version. There are t=
wo=20
>> sets of objects in QEMU, switching is done in CAS. KVM support should =
not=20
>> change anything in that area.=20
>>
>> I expect the 'xive-kvm' object to get/set states for migration, just l=
ike=20
>> for XICS and to setup the ESB+TIMA memory regions, which is new.=20
>>
>> C.=20
>> =20
>>>>> I was
>>>>> thinking the kernel would implement a different KVM device type, ie
>>>>> the "emulated XICS" would remain KVM_DEV_TYPE_XICS and XIVE would b=
e
>>>>> KVM_DEV_TYPE_XIVE.
>>>>
>>>> yes. it makes sense. The new device will have a lot in common with t=
he=20
>>>> KVM_DEV_TYPE_XICS using kvm_xive_ops.
>>>
>>> Ben.
>>>
>>
>=20
