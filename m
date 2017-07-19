Received: from eggs.gnu.org ([2001:4830:134:3::10]:34577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1dXgRd-0007NX-Ue
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 00:18:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1dXgRZ-0008L9-V5
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 00:18:41 -0400
Message-ID: <1500437897.3350.17.camel@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 19 Jul 2017 14:18:17 +1000
In-Reply-To: <20170719040150.GU3140@umbus.fritz.box>
References: <1499274819-15607-1-git-send-email-clg@kaod.org>
	<1499274819-15607-5-git-send-email-clg@kaod.org>
	<20170719030849.GQ3140@umbus.fritz.box>
	<1500436617.3350.9.camel@kernel.crashing.org>
	<20170719040150.GU3140@umbus.fritz.box>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 04/26] ppc/xive: introduce a skeleton
 for the XIVE interrupt controller model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On Wed, 2017-07-19 at 14:01 +1000, David Gibson wrote:
> On Wed, Jul 19, 2017 at 01:56:57PM +1000, Benjamin Herrenschmidt wrote:
> > On Wed, 2017-07-19 at 13:08 +1000, David Gibson wrote:
> > > On Wed, Jul 05, 2017 at 07:13:17PM +0200, C=C3=A9dric Le Goater wro=
te:
> > > > Let's provide an empty shell for the XIVE controller model with a
> > > > couple of attributes for the IRQ number allocator. The latter is
> > > > largely inspired by OPAL which allocates IPI IRQ numbers from the
> > > > bottom of the IRQ number space and allocates the HW IRQ numbers f=
rom
> > > > the top.
> > > >=20
> > > > The number of IPIs is simply deduced from the max number of CPUs =
the
> > > > guest supports and we provision a arbitrary number of HW irqs.
> > > >=20
> > > > The XIVE object is kept private because it will hold internal tab=
les
> > > > which do not need to be exposed to sPAPR.
> >=20
> > It does have an MMIO presence though... more than one even. There's t=
he
> > TIMA (per-HW thread control area) and there's the per-interrupt MMIO
> > space which are exposed to the guest. There's also the per-queue
> > MMIO control area too.
>=20
> Ok.  Always?  Or just on powernv?
>=20
> If it only has an MMIO presence on powernv, then the "core" xive
> object should probably be TYPE_DEVICE, with the powernv specific
> device being a SysBusDevice which incorporates the core xive device
> inside it.

No the ones above are on PAPR. PowerNV has even more :-)

The TIMA (thread management area) is the MMIO area through which
you control the current CPU priority etc...

It's designed in HW to "know" which core/thread is accessing it (it's
at a fixed address) and respond appropriately based on that and which
virtual CPU has been activated on that core/thread.

It's part of what allows XIVE to deliver interrupts without any HV
calls.

Cheers,
Ben.
