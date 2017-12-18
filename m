Received: from eggs.gnu.org ([2001:4830:134:3::10]:45052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1eQjmv-0002jm-MC
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 20:00:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1eQjms-0004Rx-Jf
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 20:00:13 -0500
Message-ID: <1513558781.2533.0.camel@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 18 Dec 2017 11:59:41 +1100
In-Reply-To: <0876c4bd-676f-276d-3cf6-aef4a2a562e5@kaod.org>
References: <20171209084338.29395-1-clg@kaod.org>
	<20171209084338.29395-4-clg@kaod.org>
	<0876c4bd-676f-276d-3cf6-aef4a2a562e5@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
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
To: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>

On Thu, 2017-12-14 at 16:24 +0100, C=C3=A9dric Le Goater wrote:
> The API between the source and the IVRE is extremely simple :
>=20
>   static void spapr_xive_irq(sPAPRXive *xive, int lisn)
>=20
> The IVRE then scans its IVT, finds the EQ, and moves on to the=20
> presenter.

In HW it's an MMIO store between the two units (from the source to the
IVRE notification port). I wonder in the long run if we should model
that the same way...

> So, we can keep the IVRE engine (sPAPRXive) attached directly to=20
> the machine like we have today, this is good, and introduce multiple=20
> XIVE source objects. The sPAPR machine would have :=20
>=20
>  - one for the IPIs [ 0 - nr_servers ]
>  - one generic for the devices [ 4096 -  ]
>  - one for each phb ?=20
>=20
> The source address in the overall ESB MMIO region would be calculated=20
> from the offset of the source IRQ numbers in the IRQ number space.=20
> The offset could very well be hardcoded for each device. I don't see=20
> any XICS compatibility problems as we are sharing correctly the IRQ=20
> number space already.
>=20
>=20
> I am starting this discussion because the support for XIVE in the=20
> QEMU PowerNV machine will need multiple sources, just like for=20
> POWER8. PnvXive will be a bit different because the IVRE tables=20
> (IVT and EQDT) are in the virtual machine memory. Most of the settings=20
> are done in the VM. The QEMU PowerNV machine will still have to=20
> implement the triggering and the routing logic using the guest tables.=20
