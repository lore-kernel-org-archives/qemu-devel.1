Received: from eggs.gnu.org ([2001:4830:134:3::10]:57791)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1el8Fx-0004PV-RA
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 02:10:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1el8Ft-0002Hz-0a
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 02:10:29 -0500
Received: from 14.mo7.mail-out.ovh.net ([178.33.251.19]:55082)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1el8Fs-0002BA-Pe
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 02:10:24 -0500
Received: from player697.ha.ovh.net (gw6.ovh.net [213.251.189.206])
	by mo7.mail-out.ovh.net (Postfix) with ESMTP id 3B7F98D37F
	for <qemu-devel@nongnu.org>; Mon, 12 Feb 2018 08:10:16 +0100 (CET)
References: <20171209084338.29395-1-clg@kaod.org>
	<20171209084338.29395-3-clg@kaod.org>
	<20171220050947.GC5981@umbus.fritz.box>
	<1513815126.2743.34.camel@kernel.crashing.org>
	<6768575f-27e0-1277-3e7e-56ec44298e6a@kaod.org>
	<1513896817.2743.63.camel@kernel.crashing.org>
	<683d0912-ad48-927c-8235-5358417be44c@kaod.org>
	<1516187433.31850.189.camel@kernel.crashing.org>
	<2226ed5e-f666-8060-2edd-998d2f5107ed@kaod.org>
	<1516224472.31850.193.camel@kernel.crashing.org>
	<20180211080831.GC11634@umbus.fritz.box>
	<1518389717.2312.245.camel@kernel.crashing.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <41f02d59-660e-3dc1-f51c-065fb62ecbf9@kaod.org>
Date: Mon, 12 Feb 2018 08:10:10 +0100
MIME-Version: 1.0
In-Reply-To: <1518389717.2312.245.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>

On 02/11/2018 11:55 PM, Benjamin Herrenschmidt wrote:
> On Sun, 2018-02-11 at 19:08 +1100, David Gibson wrote:
>> On Thu, Jan 18, 2018 at 08:27:52AM +1100, Benjamin Herrenschmidt wrote=
:
>>> On Wed, 2018-01-17 at 15:39 +0100, C=C3=A9dric Le Goater wrote:
>>>> Migration is a problem. We will need both backend QEMU objects to be=
=20
>>>> available anyhow if we want to migrate. So we are back to the curren=
t=20
>>>> solution creating both QEMU objects but we can try to defer some of =
the=20
>>>> KVM inits and create the KVM device on demand at CAS time.
>>>
>>> Do we have a way to migrate a piece of info from the machine *first*
>>> that indicate what type of XICS/XIVE to instanciate ?
>>
>> Nope.  qemu migration doesn't work like that.  Yes, it should, and
>> everyone knows it, but changing it is a really long term project.
>=20
> Well, we have a problem then. It looks like Qemu broken migration is
> fundamentally incompatible with PAPR and CAS design...
>=20
> I know we don't migrate the configuration, that's not exactly what I
> had in mind tho... Can we have some piece of *data* from the machine be
> migrated first, and use it on the target to reconfigure the interrupt
> controller before the stream arrives ?
>=20
> Otherwise, we have indeed no much choice but the horrible wart of
> creating both interrupt controllers with only one "active".

Well, both QEMU model objects would be created, yes, but one only KVM=20
associated device. It's a bit ugly from a QEMU point of view because =20
the KVM initialization is deferred at reset but, in the pratice, it=20
results in a couple of calls to :=20

  - disconnect the VCPU from the KVM interrupt device
  - destroy the previous KVM interrupt device (new ioctl)
  - create the new KVM interrupt device
  - reconnect the VCPU to the KVM interrupt device

I don't think it will be a major problem.

What I am unease with currently, is how to share the same XIVE objects=20
when under KVM and when not. The only difference is in the nature of
the MMIO region and the qemu_irq handler. Work in progress.

And we have four interrupt modes to support : XICS-KVM, XICS, XIVE-KVM,=20
XIVE.   =20

Thanks,

C.=20
=20

>>>> The next problem is the ICP object that currently needs the KVM devi=
ce=20
>>>> fd to connect the vcpus ... So, we will need to change that also.=20
>>>> That is probably the biggest problem today. We need a way to disconn=
ect=20
>>>> the vpcu from the KVM device and see how we can defer the connection=
.
>>>> I need to make sure this is possible, I can check that without XIVE
>>>
>>> Ben.
>>>
>>
>>
