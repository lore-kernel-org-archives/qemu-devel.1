Received: from eggs.gnu.org ([2001:4830:134:3::10]:58274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dvLLu-0006LQ-JF
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 06:38:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dvLLt-0000xT-AT
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 06:38:34 -0400
Date: Fri, 22 Sep 2017 20:33:50 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170922103350.GL4998@umbus.fritz.box>
References: <20170911171235.29331-1-clg@kaod.org>
	<20170919082020.GT27153@umbus> <20170919084618.GY27153@umbus>
	<98b6f737-a554-1c83-79f9-2c8021e1cf69@kaod.org>
	<20170921012508.GA4998@umbus.fritz.box>
	<53b4c971-920f-816b-59fb-f77a03663d81@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zH41lVBEV8cLJnCl"
Content-Disposition: inline
In-Reply-To: <53b4c971-920f-816b-59fb-f77a03663d81@kaod.org>
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
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, Alexander Graf <agraf@suse.de>


--zH41lVBEV8cLJnCl
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 21, 2017 at 04:18:33PM +0200, C=E9dric Le Goater wrote:
> On 09/21/2017 03:25 AM, David Gibson wrote:
> > On Wed, Sep 20, 2017 at 02:33:37PM +0200, C=E9dric Le Goater wrote:
> >> On 09/19/2017 10:46 AM, David Gibson wrote:
> >>> On Tue, Sep 19, 2017 at 06:20:20PM +1000, David Gibson wrote:
> >>>> On Mon, Sep 11, 2017 at 07:12:14PM +0200, C=E9dric Le Goater wrote:
> >>>>> On a POWER9 sPAPR machine, the Client Architecture Support (CAS)
> >>>>> negotiation process determines whether the guest operates with an
> >>>>> interrupt controller using the XICS legacy model, as found on POWER=
8,
> >>>>> or in XIVE exploitation mode, the newer POWER9 interrupt model. This
> >>>>> patchset is a proposal to add XIVE support in POWER9 sPAPR machine.
> >>>>>
> >>>>> Follows a model for the XIVE interrupt controller and support for t=
he
> >>>>> Hypervisor's calls which are used to configure the interrupt sources
> >>>>> and the event/notification queues of the guest. The last patch
> >>>>> integrates XIVE in the sPAPR machine.
> >>>>>
> >>>>> Code is here:
> >>>>
> >>>>
> >>>> An overall comment:
> >>>>
> >>>> I note in several replies here that I think the way XICS objects are
> >>>> re-used for XIVE is really ugly, and I think it will make future
> >>>> maintenance pretty painful.
> >>
> >> I agree. That was one way to identify what we need for migration=20
> >> compatibility and CAS reset.  =20
> >>
> >>>> I'm thinking maybe trying to support the CAS negotiation of interrupt
> >>>> controller from day 1 is warping the design.  A better approach might
> >>>> be first to implement XIVE only when given a specific machine option=
 -
> >>>> guest gets one or the other and can't negotiate.
> >>
> >> ok.=20
> >>
> >> CAS is not the most complex problem, we mostly need to share=20
> >> the ICSIRQState array and the source offset. migration from older
> >> machine is a problem.
> >=20
> > Uh.. what?  Migration from an older machine isn't a thing.  We can
> > migrate from an older qemu, but the machine type (and version) has to
> > be identical at each end.  That's *why* we keep around the older
> > machine types on newer qemus.
>=20
> yes. I am just wondering how I am going to handle a xics-only=20
> machine migrating to a xics/xive machine.=20

Won't ever happen.  Older machine types will always be xics, newer
machine type will always be xive (at least with POWER9).

> The xive machine option we are talking about will activate=20
> the xive interrupt mode and instantiate the objects behind it.=20
> So when we migrate from an older machine we will need to start=20
> the target machine with xive=3Doff. I guess that is OK.

Again, we *don't* migrate from an older machine.  Ever.  We only ever
migrate from an older qemu version to a newer qemu using the older
machine type.
>=20
> Thanks for the insights and the time to review the code,
>=20
> C.=20
>=20
> >> We are doomed to keep the existing XICS
> >> framework available.
> >>
> >>>> That should allow a more natural XIVE design to emerge, *then* we can
> >>>> look at what's necessary to make boot-time negotiation possible.
> >>>
> >>> Actually, it just occurred to me that we might be making life hard for
> >>> ourselves by trying to actually switch between full XICS and XIVE
> >>> models.  Coudln't we have new machine types always construct the XIVE
> >>> infrastructure,=20
> >>
> >> yes.
> >>
> >>> but then implement the XICS RTAS and hcalls in terms of the XIVE virt=
ual=20
> >>> hardware.
> >>
> >> ok but migration will not be supported.
> >=20
> > Right, this would only be for newer machine types, and you can never
> > migrate between different machine types.
> >=20
> >>> Since something more or less equivalent
> >>> has already been done in both OPAL and the host kernel, I'm guessing
> >>> this shouldn't be too hard at this point.
> >>
> >> Indeed that is how it is working currently on P9 kvm guests. hcalls are
> >> implemented on top of XIVE native.
> >>
> >> Thanks,
> >>
> >>
> >> C.
> >>
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--zH41lVBEV8cLJnCl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnE5w4ACgkQbDjKyiDZ
s5Ionw//bKJNk87K8lgEh2hciAfpR6Qg1hG9hiCAuL/b2XXuidGVBq7YT1nC8xJO
vD8VNqum+HP2Pbjj+/X9OQviMtK6q6EY21OPBUm3eXSk1yL+J19aMbavY1EcByW2
iUgtPE5aos0EsjLYZtdzHbB0b3bxvQjVT+hH2FjLVK3XYDC1U/8tjPV9EMcg/yDX
YQHAwwW2s9ALPzDcN/UcI6vFLXADX60zuf5VbM/HRCjH+hVVGquoAsYq7snNfmiV
AIQqloRSG49TWtzWKecz//E+wODyBYeN9UFOZTdt92P7i6jrrQIph/DpINgmRiAP
JrG9jgmUYaTjd4hq+VPSRHFpBMkYptGDLS1Ky6pW9/LY7K396WAAA6qBSWR7MZ9f
jtHXHSEvuT+vifNiebjJeVMPi9x0je8rCek10+Qz8vlM3na3NNCpNRjGhN+lucX/
ZBaUfymUK2l2a89wrsxDhvH0tYAf24tN7cN5jSfzNQTLTHCg9sKDbkK2hthklIzv
wbRdwfb3PemNM62oebCsFNSHFIBinQkrEa9EFHPz/4vlm6Ny3qANXptjvY659ocG
ObOnPcxF/ytVkwJQNaO9qz9+6gCZB9vEcARgX/xxaEOtQjgDpv+DG8UEko8v1Vid
dip45MaZMR/lMmDRgDY3t10NsnHJdCaLSIiX/mZ89uU+7we8dlA=
=rENy
-----END PGP SIGNATURE-----

--zH41lVBEV8cLJnCl--
