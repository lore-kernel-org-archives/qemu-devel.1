Received: from eggs.gnu.org ([2001:4830:134:3::10]:56904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1f6XiP-00077X-CC
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 04:36:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1f6XiL-0002Qe-B2
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 04:36:21 -0400
Received: from 7.mo2.mail-out.ovh.net ([188.165.48.182]:36079)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1f6XiL-0002PM-4Z
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 04:36:17 -0400
Received: from player773.ha.ovh.net (unknown [10.109.122.114])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 7D6EE12D578
	for <qemu-devel@nongnu.org>; Thu, 12 Apr 2018 10:36:15 +0200 (CEST)
References: <20171220050947.GC5981@umbus.fritz.box>
	<1513815126.2743.34.camel@kernel.crashing.org>
	<6768575f-27e0-1277-3e7e-56ec44298e6a@kaod.org>
	<1513896817.2743.63.camel@kernel.crashing.org>
	<683d0912-ad48-927c-8235-5358417be44c@kaod.org>
	<1516187433.31850.189.camel@kernel.crashing.org>
	<2226ed5e-f666-8060-2edd-998d2f5107ed@kaod.org>
	<1516224472.31850.193.camel@kernel.crashing.org>
	<20180211080831.GC11634@umbus.fritz.box>
	<1518389717.2312.245.camel@kernel.crashing.org>
	<20180412051653.GO9425@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <d5ed04f5-6b8e-6844-eadb-badfb7c6bd73@kaod.org>
Date: Thu, 12 Apr 2018 10:36:10 +0200
MIME-Version: 1.0
In-Reply-To: <20180412051653.GO9425@umbus.fritz.box>
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
To: David Gibson <david@gibson.dropbear.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>

On 04/12/2018 07:16 AM, David Gibson wrote:
> On Mon, Feb 12, 2018 at 09:55:17AM +1100, Benjamin Herrenschmidt wrote:
>> On Sun, 2018-02-11 at 19:08 +1100, David Gibson wrote:
>>> On Thu, Jan 18, 2018 at 08:27:52AM +1100, Benjamin Herrenschmidt wrot=
e:
>>>> On Wed, 2018-01-17 at 15:39 +0100, C=E9dric Le Goater wrote:
>>>>> Migration is a problem. We will need both backend QEMU objects to b=
e=20
>>>>> available anyhow if we want to migrate. So we are back to the curre=
nt=20
>>>>> solution creating both QEMU objects but we can try to defer some of=
 the=20
>>>>> KVM inits and create the KVM device on demand at CAS time.
>>>>
>>>> Do we have a way to migrate a piece of info from the machine *first*
>>>> that indicate what type of XICS/XIVE to instanciate ?
>>>
>>> Nope.  qemu migration doesn't work like that.  Yes, it should, and
>>> everyone knows it, but changing it is a really long term project.
>>
>> Well, we have a problem then. It looks like Qemu broken migration is
>> fundamentally incompatible with PAPR and CAS design...
>=20
> Hrm, the fit is very clunky certainly, but i think we can make it work.
>=20
>> I know we don't migrate the configuration, that's not exactly what I
>> had in mind tho... Can we have some piece of *data* from the machine b=
e
>> migrated first, and use it on the target to reconfigure the interrupt
>> controller before the stream arrives ?
>=20
> Sorta.. maybe.. but it would probably get really ugly if we don't
> preserve the usual way object lifetimes work.
>=20
>> Otherwise, we have indeed no much choice but the horrible wart of
>> creating both interrupt controllers with only one "active".
>=20
> I really think this is the way to go, warts and all.
>=20

Yes ... KVM makes it a little uglier.=20

A KVM_DEVICE_DESTROY device is needed to cleanup the VM and a=20
DISABLE_CAP to disconnect the vpcu from the current KVM XIVE/XICS=20
device. I have used an extra arg on ENABLE_CAP for the moment.   =20

At the QEMU level, we need to connect/reconnect at reset time to
handle possible changes in CAS, and at post_load.

Destroying the MemoryRegion is a bit problematic, I have not
found a common layout compatible with both the emulated mode=20
(std IO regions) and the KVM mode (ram device regions)

C.
