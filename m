Received: from eggs.gnu.org ([2001:4830:134:3::10]:37008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1f99CG-0005eH-8u
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 09:02:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1f99C5-0002sO-Vq
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 09:01:56 -0400
Received: from 10.mo69.mail-out.ovh.net ([46.105.73.241]:58264)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1f99Bm-0002hx-3Y
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 09:01:45 -0400
Received: from player792.ha.ovh.net (unknown [10.109.105.122])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id 6701113AF3
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 15:01:24 +0200 (CEST)
References: <6768575f-27e0-1277-3e7e-56ec44298e6a@kaod.org>
	<1513896817.2743.63.camel@kernel.crashing.org>
	<683d0912-ad48-927c-8235-5358417be44c@kaod.org>
	<1516187433.31850.189.camel@kernel.crashing.org>
	<2226ed5e-f666-8060-2edd-998d2f5107ed@kaod.org>
	<1516224472.31850.193.camel@kernel.crashing.org>
	<20180211080831.GC11634@umbus.fritz.box>
	<1518389717.2312.245.camel@kernel.crashing.org>
	<20180412051653.GO9425@umbus.fritz.box>
	<d5ed04f5-6b8e-6844-eadb-badfb7c6bd73@kaod.org>
	<20180416042914.GD20551@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <a5c8b965-779e-cc4a-5545-1e1b649f880e@kaod.org>
Date: Thu, 19 Apr 2018 15:01:18 +0200
MIME-Version: 1.0
In-Reply-To: <20180416042914.GD20551@umbus.fritz.box>
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

On 04/16/2018 06:29 AM, David Gibson wrote:
> On Thu, Apr 12, 2018 at 10:36:10AM +0200, C=E9dric Le Goater wrote:
>> On 04/12/2018 07:16 AM, David Gibson wrote:
>>> On Mon, Feb 12, 2018 at 09:55:17AM +1100, Benjamin Herrenschmidt wrot=
e:
>>>> On Sun, 2018-02-11 at 19:08 +1100, David Gibson wrote:
>>>>> On Thu, Jan 18, 2018 at 08:27:52AM +1100, Benjamin Herrenschmidt wr=
ote:
>>>>>> On Wed, 2018-01-17 at 15:39 +0100, C=E9dric Le Goater wrote:
>>>>>>> Migration is a problem. We will need both backend QEMU objects to=
 be=20
>>>>>>> available anyhow if we want to migrate. So we are back to the cur=
rent=20
>>>>>>> solution creating both QEMU objects but we can try to defer some =
of the=20
>>>>>>> KVM inits and create the KVM device on demand at CAS time.
>>>>>>
>>>>>> Do we have a way to migrate a piece of info from the machine *firs=
t*
>>>>>> that indicate what type of XICS/XIVE to instanciate ?
>>>>>
>>>>> Nope.  qemu migration doesn't work like that.  Yes, it should, and
>>>>> everyone knows it, but changing it is a really long term project.
>>>>
>>>> Well, we have a problem then. It looks like Qemu broken migration is
>>>> fundamentally incompatible with PAPR and CAS design...
>>>
>>> Hrm, the fit is very clunky certainly, but i think we can make it wor=
k.
>>>
>>>> I know we don't migrate the configuration, that's not exactly what I
>>>> had in mind tho... Can we have some piece of *data* from the machine=
 be
>>>> migrated first, and use it on the target to reconfigure the interrup=
t
>>>> controller before the stream arrives ?
>>>
>>> Sorta.. maybe.. but it would probably get really ugly if we don't
>>> preserve the usual way object lifetimes work.
>>>
>>>> Otherwise, we have indeed no much choice but the horrible wart of
>>>> creating both interrupt controllers with only one "active".
>>>
>>> I really think this is the way to go, warts and all.
>>>
>>
>> Yes ... KVM makes it a little uglier.=20
>>
>> A KVM_DEVICE_DESTROY device is needed to cleanup the VM and a=20
>> DISABLE_CAP to disconnect the vpcu from the current KVM XIVE/XICS=20
>> device. I have used an extra arg on ENABLE_CAP for the moment.   =20
>>
>> At the QEMU level, we need to connect/reconnect at reset time to
>> handle possible changes in CAS, and at post_load.
>=20
> Right.

v3 uses the same 'reset' function to setup the interrupts at machine=20
reset time and at post_load. Keep that in mind. May be we should have=20
distinct routines.
=20
>=20
>> Destroying the MemoryRegion is a bit problematic, I have not
>> found a common layout compatible with both the emulated mode=20
>> (std IO regions) and the KVM mode (ram device regions)
>=20
> That sounds awkward, I guess we'll discuss the details of this later.

I have fixed that in v3.

> Btw, a secondary advantage of starting off with XIVE only under a
> different machine type is that we can declare that one not to be
> migration stable until we're ready.  So we can merge something that's
> ok to experiment with, but reserve the right to incompatibly change
> the migration format until we're confident we're ready and can merge
> it into the "stable" machine type.

Reseting KVM devices is not the most complex feature to support but=20
it seems to have an impact on migration. So we might need the=20
non-migratable machine type to fix that. Let's see how v3 is welcomed
or not.
 =20
=20
Thanks,

C.
