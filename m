Received: from eggs.gnu.org ([2001:4830:134:3::10]:42819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1da1LY-0002jY-8M
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 11:02:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1da1LT-0002dr-Fm
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 11:02:04 -0400
Received: from 7.mo179.mail-out.ovh.net ([46.105.61.94]:48092)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1da1LT-0002dN-9P
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 11:01:59 -0400
Received: from player168.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 51601592A3
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 17:01:54 +0200 (CEST)
References: <1499274819-15607-1-git-send-email-clg@kaod.org>
	<1499274819-15607-15-git-send-email-clg@kaod.org>
	<20170724063534.GM17228@umbus.fritz.box>
	<fa7a0b3f-89d5-b1ef-238d-0bda41beee9f@kaod.org>
	<20170725042027.GC8978@umbus.fritz.box>
	<1d7d50ee-7559-2e6b-4ed0-741d810052d0@kaod.org>
	<20170725132129.GH8978@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <e579aef2-d8b3-180a-5250-2016060a6a05@kaod.org>
Date: Tue, 25 Jul 2017 17:01:48 +0200
MIME-Version: 1.0
In-Reply-To: <20170725132129.GH8978@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 14/26] ppc/xive: add MMIO handlers to
 the XIVE interrupt presenter model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 07/25/2017 03:21 PM, David Gibson wrote:
> On Tue, Jul 25, 2017 at 11:08:46AM +0200, C=E9dric Le Goater wrote:
>> On 07/25/2017 06:20 AM, David Gibson wrote:
>>> On Mon, Jul 24, 2017 at 04:44:00PM +0200, C=E9dric Le Goater wrote:
>>>> On 07/24/2017 08:35 AM, David Gibson wrote:
>>>>> On Wed, Jul 05, 2017 at 07:13:27PM +0200, C=E9dric Le Goater wrote:
>>>>>> The Thread Interrupt Management Area for the OS is mostly used to
>>>>>> acknowledge interrupts and set the CPPR of the CPU.
>>>>>>
>>>>>> The TIMA is mapped at the same address for each CPU. 'current_cpu'=
 is
>>>>>> used to retrieve the targeted interrupt presenter object.
>>>>>>
>>>>>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>>>>>
>>>>> Am I right in thinking that this shoehorns the XIVE TIMA state into
>>>>> the existing XICS ICP object.  That.. doesn't seem like a good idea=
.
>>>>
>>>> The TIMA memory region is under the XIVE object because it is=20
>>>> unique for the system. The lookup of the ICP is simply done using=20
>>>> 'current_cpu'. The TIMA state is under the ICPState, yes, but this=20
>>>> model does not seem incorrect to me as this state contains the=20
>>>> interrupt information presented to a CPU.
>>>
>>> Yeah, that's not the point I'm making.  My point is that the TIMA
>>> state isn't really the same as xics ICP state.  You're squeezing one
>>> into the other in a pretty ugly way.
>>
>> yes, well, we need to have compatible objects between the XICS and XIV=
E=20
>> mode because of the CAS negotiation. for migration compatibility, it i=
s=20
>> much easier to extend existing objects. This approach I am taking toda=
y.
>=20
> Yeah, I really don't think this approach is workable.
>=20
> Roughly speaking, you're keeping the same structures between xics and
> xive, but with mostly different code.  I can't see any way that's not
> going to be horribly fragile, with any update to xics OR xive
> requiring enormous caution not to break the other.
>=20
> I really think we have to go one of two ways:
>=20
> 1) Abstract the notion of interrupt source and interrupt presenter, so
> we can use a truly common model between xics and xive.
>=20
> Given the differences between the two, I don't know this is even
> possible.
>=20
> 2) Separate the objects entirely.  ICPs are entirely separate from
> TIMAs, like wise ICSes and xive interrupt sources.
>=20
> I think this is probably the way to go.  To make this work with CAS
> switching will require different methods, but I don't think it's
> impossible.
>
> For example, we could (on the new machine type) create both xics ICSes
> and ICPs and xive sources and TIMAs.  We'd have a (migrated) flag in
> the machine saying which is currently active.  All the objects would
> hang around, but only the active ones would do anything.

ok. There is still the question of sharing the IRQ numbers unless we=20
find away to allocate them after the CAS negotiation.=20

I will take a look at KVM support now before reworking the patchset.

Thanks,

C.

> Now obviously that means we'd be migrating a bunch of redundant state,
> but I still think it's preferable to a Frankenstinian fusion of
> xics-ish and xive-ish state.  I think there's a good chance we can
> improve on the basic idea to remove most or all of that redundant
> state.
>=20
