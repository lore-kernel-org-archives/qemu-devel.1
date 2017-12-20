Received: from eggs.gnu.org ([2001:4830:134:3::10]:50241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eRinJ-0008U2-Q3
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 13:08:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eRinG-00051C-Nb
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 13:08:41 -0500
Received: from 6.mo177.mail-out.ovh.net ([46.105.51.249]:45788)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eRinG-0004yc-Fz
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 13:08:38 -0500
Received: from player779.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id 0E5A9916AB
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 19:08:35 +0100 (CET)
References: <20171209084338.29395-1-clg@kaod.org>
	<20171209084338.29395-4-clg@kaod.org>
	<20171220052225.GE5981@umbus.fritz.box>
	<b30dd81e-f09b-ffaf-450e-7a7d465a8eea@kaod.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <5480c358-54f7-901d-70d4-3e936668b0e4@kaod.org>
Date: Wed, 20 Dec 2017 19:08:27 +0100
MIME-Version: 1.0
In-Reply-To: <b30dd81e-f09b-ffaf-450e-7a7d465a8eea@kaod.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 03/19] spapr: introduce the XIVE
 interrupt sources
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Greg Kurz <groug@kaod.org>

On 12/20/2017 08:54 AM, C=E9dric Le Goater wrote:
> On 12/20/2017 06:22 AM, David Gibson wrote:
>> On Sat, Dec 09, 2017 at 09:43:22AM +0100, C=E9dric Le Goater wrote:
>>> Each XIVE interrupt source is associated with a two bit state machine
>>> called an Event State Buffer (ESB) : the first bit "P" means that an
>>> interrupt is "pending" and waiting for an EOI and the bit "Q" (queued=
)
>>> means a new interrupt was triggered while another was still pending.
>>>
>>> When an event is triggered, the associated interrupt state bits are
>>> fetched and modified and forwarded to the virtualization engine of th=
e
>>> controller doing the routing. These can also be controlled by MMIO, t=
o
>>> trigger events or turn off the sources for instance. See code for mor=
e
>>> details on the states and transitions.
>>>
>>> The MMIO space for the ESBs is 512GB large on the bare-metal system
>>> (PowerNV) and the BAR depends on the chip id. In our model for the
>>> sPAPR machine, we choose to only map the sub-region for the
>>> provisioned IRQ numbers and to use the mapping address of chip 0 of a
>>> real system.
>>
>> I think we probably want a device property to make the virtualized
>> base address arbitrary.  It's fine for it to default to the chip 0
>> base, but that'll make it easier to adapt if we need to later on.
>=20
> yes. We can add a "bar" property for this purpose like for some of=20
> the pnv models
>=20
>> As noted in the followup messages, I think you're going to want to
>> move this stuff from the current xive object into a "block of sources"
>> object.

I have (re)introduced a XiveSource object. Only a single instance, and=20
under the sPAPRXive object (because it is easier to create). Adding a=20
source list should not be too problematic if needed.=20

So the XiveSource is generic and I hope to be able to do the same for=20
the presenter.=20

Just like for XICS, I am also adding a :

	typedef struct XiveFabricClass {
	    InterfaceClass parent;
	    void (*notify)(XiveFabric *xive, int lisn);
	} XiveFabricClass;

which we can use for both the pnv and pseries machines, but the fabric=20
is not the machine itself, it is the Xive routing engine, an object=20
below.

C.
