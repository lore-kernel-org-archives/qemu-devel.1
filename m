Received: from eggs.gnu.org ([2001:4830:134:3::10]:55006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dvN48-0004vw-RO
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 08:28:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dvN3u-0003jn-V0
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 08:28:20 -0400
Received: from 8.mo179.mail-out.ovh.net ([46.105.75.26]:54164)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1dvN3u-0003jG-OS
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 08:28:06 -0400
Received: from player690.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 3F4C064D8F
	for <qemu-devel@nongnu.org>; Fri, 22 Sep 2017 14:28:05 +0200 (CEST)
References: <20170911171235.29331-1-clg@kaod.org>
	<20170911171235.29331-10-clg@kaod.org> <20170919073615.GN27153@umbus>
	<52f31e9e-f7de-ae27-a8a6-bd2f37666659@kaod.org>
	<20170922105855.GO4998@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <b28520f1-4431-8cf6-1709-5fad3889e6df@kaod.org>
Date: Fri, 22 Sep 2017 14:27:59 +0200
MIME-Version: 1.0
In-Reply-To: <20170922105855.GO4998@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v2 09/21] ppc/xive: extend the
 interrupt presenter model for XIVE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, Alexander Graf <agraf@suse.de>

On 09/22/2017 12:58 PM, David Gibson wrote:
> On Tue, Sep 19, 2017 at 09:28:45PM +0200, C=E9dric Le Goater wrote:
>> On 09/19/2017 09:36 AM, David Gibson wrote:
>>> On Mon, Sep 11, 2017 at 07:12:23PM +0200, C=E9dric Le Goater wrote:
>>>> The XIVE interrupt presenter exposes a set of Thread Interrupt
>>>> Management Areas, also called rings, one per different level of
>>>> privilege (four in all). This area is used to handle priority
>>>> management and interrupt acknowledgment among other things.
>>>>
>>>> We extend the ICPState object with a cache of the register data for
>>>> XIVE. The integration with the sPAPR machine is much easier and we
>>>> need a common framework to switch from one controller model to
>>>> another: XICS <-> XIVE.
>>>
>>> This sounds like an even worse idea than referencing the ICS state.
>>
>> ok ok.
>>
>>> The TIMA really needs to be managed by a different object than the IC=
P.
>>
>> like an array under the machine indexed by the cpu index ?=20
>=20
> Or individual TIMA objects which the cpus point to using their intc
> pointers.

ah ok. We really are splitting the two worlds.

C.
=20
>> at some point, we will need to :
>>
>>     PowerPCCPU *cpu =3D POWERPC_CPU(current_cpu);
>>     ICPState *icp =3D ICP(cpu->intc);
>>
>> and=20
>>
>>     icp =3D xics_icp_get(xive->ics->xics, target);
>>
>>
>> isn't the cpu->intc pointer  the best option to hold that information =
?=20
>> and it is migrated.
>=20
> No, it shouldn't be migrated.  It's set up during machine construction.
>=20
