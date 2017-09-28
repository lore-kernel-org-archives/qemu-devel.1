Received: from eggs.gnu.org ([2001:4830:134:3::10]:45691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1dxU6k-0007B8-GU
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 04:23:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1dxU6h-00026B-Ak
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 04:23:46 -0400
Message-ID: <1506587002.25626.20.camel@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 28 Sep 2017 10:23:22 +0200
In-Reply-To: <98b6f737-a554-1c83-79f9-2c8021e1cf69@kaod.org>
References: <20170911171235.29331-1-clg@kaod.org>
	<20170919082020.GT27153@umbus> <20170919084618.GY27153@umbus>
	<98b6f737-a554-1c83-79f9-2c8021e1cf69@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v2 00/21] Guest exploitation of the
 XIVE interrupt controller (POWER9)
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

On Wed, 2017-09-20 at 14:33 +0200, C=C3=A9dric Le Goater wrote:
> > > I'm thinking maybe trying to support the CAS negotiation of interru=
pt
> > > controller from day 1 is warping the design.  A better approach mig=
ht
> > > be first to implement XIVE only when given a specific machine optio=
n -
> > > guest gets one or the other and can't negotiate.
>=20
> ok.=20
>=20
> CAS is not the most complex problem, we mostly need to share=20
> the ICSIRQState array and the source offset. migration from older
> machine is a problem. We are doomed to keep the existing XICS
> framework available.

I don't like sharing anything. I'd rather we had separate objects
alltogether. If needed we can implement CAS by doing a partition reboot
like pHyp does, at least initially, until we add ways to tear down and
rebuild objects.

The main issue is whether we can keep a consistent number space so the
DT doesn't have to be completely rebuilt. If it does, then reboot will
be the only practical option I'm afraid.

> > > That should allow a more natural XIVE design to emerge, *then* we c=
an
> > > look at what's necessary to make boot-time negotiation possible.
> >=20
> > Actually, it just occurred to me that we might be making life hard fo=
r
> > ourselves by trying to actually switch between full XICS and XIVE
> > models.  Coudln't we have new machine types always construct the XIVE
> > infrastructure,=20
>=20
> yes.
>=20
> > but then implement the XICS RTAS and hcalls in terms of the XIVE virt=
ual=20
> > hardware.

That's gross :-)

This is also exactly what KVM does with real XIVE HW and there's also
such an emulation in OPAL. I'd be weary of creating a 3rd one...

I'd much prefer if we managed to:

 - Split the source numbering from the various state tracking objects
so we can have that common

 - Either delay the creation to after CAS or tear down & re-create the
state tracking objects at CAS time.

> ok but migration will not be supported.
>=20
> > Since something more or less equivalent
> > has already been done in both OPAL and the host kernel, I'm guessing
> > this shouldn't be too hard at this point.

It would very much suck to have yet another one of these.

Also we need to understand how that would work in a KVM context, the
kernel will provide a "XICS" state even on top of XIVE unless we switch
the kernel object to native, but then the kernel will expect full
exploitation.

> Indeed that is how it is working currently on P9 kvm guests. hcalls are
> implemented on top of XIVE native.
>=20
> Thanks,
>=20
>=20
> C.
