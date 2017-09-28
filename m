Received: from eggs.gnu.org ([2001:4830:134:3::10]:49067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1dxUCO-00016B-IS
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 04:29:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1dxUCN-0005Ta-LY
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 04:29:36 -0400
Message-ID: <1506587342.25626.26.camel@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 28 Sep 2017 10:29:02 +0200
In-Reply-To: <771e897f-f304-3616-2e9c-e582f556b914@kaod.org>
References: <20170911171235.29331-1-clg@kaod.org>
	<20170911171235.29331-8-clg@kaod.org> <20170919025747.GM27153@umbus>
	<771e897f-f304-3616-2e9c-e582f556b914@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v2 07/21] ppc/xive: add MMIO handlers
 for the XIVE interrupt sources
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>, Alexander Graf <agraf@suse.de>

On Wed, 2017-09-20 at 15:05 +0200, C=C3=A9dric Le Goater wrote:
> > > +/*
> > > + * XIVE Interrupt Source MMIOs
> > > + */
> > > +static uint64_t spapr_xive_esb_read(void *opaque, hwaddr addr, uns=
igned size)
> > > +{
> > > +    sPAPRXive *xive =3D SPAPR_XIVE(opaque);
> > > +    uint32_t offset =3D addr & 0xF00;
> > > +    uint32_t srcno =3D addr >> xive->esb_shift;
> > > +    XiveIVE *ive;
> > > +    uint64_t ret =3D -1;
> > > +
> > > +    ive =3D spapr_xive_get_ive(xive, srcno);
> > > +    if (!ive || !(ive->w & IVE_VALID))  {
> > > +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid LISN %d\n", =
srcno);
> > > +        goto out;
> >=20
> > Since there's a whole (4k) page for each source, I wonder if we shoul=
d
> > actually map each one as a separate MMIO region to allow us to tweak
> > the mappings more flexibly
>=20
> yes we could have a subregion for each source. In that case,=20
> we should also handle IVE_VALID properly. That will require=20
> a specific XIVE allocator which was difficult to do while
> keeping the compatibility with XICS for migration and CAS.

That will be a serious bloat with lots of interrupts. We also cannot
possibly have a KVM mm region per interrupt or even a vma.

I'm thinking of some kind of /dev/xive (or some other KVM or irqfd
orignated fd) that allows you to mmap a single big region whose content
is demand-faulted and invalidated by the kernel to map the various
interrupts.

So that it looks like a single VMA (and KVM memory block).

Ben.

> C.
>=20
>=20
