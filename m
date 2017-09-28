Received: from eggs.gnu.org ([2001:4830:134:3::10]:44601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1dxU1k-00068E-0t
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 04:18:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1dxU1g-0007un-0s
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 04:18:36 -0400
Message-ID: <1506586686.25626.16.camel@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 28 Sep 2017 10:18:06 +0200
In-Reply-To: <13fdab3c-6af7-780a-ad1e-9ea64a5d660c@kaod.org>
References: <20170911171235.29331-1-clg@kaod.org>
	<20170911171235.29331-15-clg@kaod.org> <20170919075506.GR27153@umbus>
	<13fdab3c-6af7-780a-ad1e-9ea64a5d660c@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v2 14/21] ppc/xive: add support for the
 SET_OS_PENDING command
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

On Wed, 2017-09-20 at 11:47 +0200, C=C3=A9dric Le Goater wrote:
> > > @@ -162,7 +162,14 @@ static bool spapr_xive_tm_is_readonly(uint8_t =
index)
> > >   static void spapr_xive_tm_write_special(ICPState *icp, hwaddr off=
set,
> > >                                     uint64_t value, unsigned size)
> > >   {
> > > -    /* TODO: support TM_SPC_SET_OS_PENDING */
> > > +    if (offset =3D=3D TM_SPC_SET_OS_PENDING && size =3D=3D 1) {
> > > +        icp->tima_os[TM_IPB] |=3D priority_to_ipb(value & 0xff);
> > > +        icp->tima_os[TM_PIPR] =3D ipb_to_pipr(icp->tima_os[TM_IPB]=
);
> >=20
> > This only lets the cpu raise bits in the IPB, never clear them.> Is t=
hat right? =20
>=20
> The clear is done when the OS acks the interrupt.
>=20
> > I don't see how you'd implement the handling of multiple
> > priorities without being able to clear bits here.
>=20
> I am not sure how this command should be used from the OS.=20
> Currently, I only see KVM handling it in the XICS/XIVE glue.
> I need to take a closer look.

It's a way to avoid the SW replay on EOI.

IE, assume you have 2 interrupts in the queue. You take the exception,
ack the first one, process it etc...

Then you EOI, the HW won't send a second notification. You need to look
at the queue and continue consuming until it's empty.

Today Linux checks the queue on EOI and use a SW mechanism to
synthetize a new pseudo-external interrupt.

This MMIO command would allow the OS to instead set back the
corresponding priority bit to 1 in the IPB and cause the HW to re-emit
the interrupt instead of SW.

Linux doesn't use this today because DD1 didn't support it for the HV
level, but other OSes might and we also might use it when we do groups,
thus allowing redistribution.

Cheers,
Ben.
