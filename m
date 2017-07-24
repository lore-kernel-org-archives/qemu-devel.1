Received: from eggs.gnu.org ([2001:4830:134:3::10]:42937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dZaEa-00015t-Ci
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 06:05:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dZaEW-00078B-3v
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 06:05:04 -0400
Date: Mon, 24 Jul 2017 20:03:14 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170724100314.GP17228@umbus.fritz.box>
References: <1499274819-15607-1-git-send-email-clg@kaod.org>
	<1499274819-15607-5-git-send-email-clg@kaod.org>
	<20170719030849.GQ3140@umbus.fritz.box>
	<1500436938.3350.11.camel@kernel.crashing.org>
	<20170721075015.GE3717@umbus.fritz.box>
	<1500625291.10674.22.camel@kernel.crashing.org>
	<20170724032853.GB17228@umbus.fritz.box>
	<1500872645.10674.52.camel@kernel.crashing.org>
	<20170724053827.GI17228@umbus.fritz.box>
	<1500880826.10674.66.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hHiQ9nAwW5IGN2dL"
Content-Disposition: inline
In-Reply-To: <1500880826.10674.66.camel@kernel.crashing.org>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--hHiQ9nAwW5IGN2dL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 24, 2017 at 05:20:26PM +1000, Benjamin Herrenschmidt wrote:
> On Mon, 2017-07-24 at 15:38 +1000, David Gibson wrote:
> >=20
> > Can we assign our logical numbers sparsely, or will that cause other
> > problems?
>=20
> The main issue is that they probably needs to be the same between XICS
> and XIVE because by the time we get the CAS call to chose between XICS
> and XIVE, we have already handed out interrupts and constructed the DT,
> no ? Unless we do a real CAS reboot...

A real CAS reboot probably isn't unreasonable for this case.

I definitely think we need to go one way or the other - either fully
unify the irq mapping between xics and xive, or fully separate them.

> Otherwise, there's no reason they can't be sparse no.
>=20
> > Note that for PAPR we also have the question of finding logical
> > interrupts for legacy PAPR VIO devices.
>=20
> We just make them another range ? With KVM legacy today, I just use the
> generic interrupt facility for those. So when you do the ioctl to
> "trigger" one, I just do an MMIO to the corresponding page and the
> interrupt magically shows up wherever the guest is running the target
> vcpu. In fact, I'd like to add a way to mmap that page into qemu so
> that qemu can triggers them without an ioctl.

Ok.

> The guest doesn't care, from the guest perspective they are interrupts
> coming from the DT, so they are like PCI etc...

Ok.

> > > We can fix the number of "generic" interrupts given to a guest. The
> > > only requirements from a PAPR perspective is that there should be at
> > > least as many as there are possible threads in the guest so they can =
be
> > > used as IPIs.
> >=20
> > Ok.  If we can do things sparsely, allocating these well away from the
> > hw interrupts would make things easier.
> >=20
> > > But we may need more for other things. We can make this a machine
> > > parameter with a default value of something like 4096. If we call N
> > > that number of extra generic interrupts, then the number of generic
> > > interrutps would be #possible-vcpu's + N, or something like that.
> >=20
> > That seems reasonable.
> >=20
> > > > > But it's fundamentally an allocator that sits in the hypervisor, =
so in
> > > > > our case, I would say in the spapr "component" of XIVE, rather th=
an the
> > > > > XIVE HW model itself.
> > > >=20
> > > > Maybe..
> > >=20
> > > You are right in that a mapping is a better term than an allocator
> > > here.
> > >=20
> > > > > Now what Cedric did, because XIVE is very complex and we need som=
ething
> > > > > for PAPR quickly, is not a complete HW model, but a somewhat simp=
lified
> > > > > one that only handles what PAPR exposes. So in that case where the
> > > > > allocator sits is a bit of a TBD...
> > > >=20
> > > > Hm, ok.  My concern here is that "dynamic" allocation of irqs at the
> > > > machine type level needs extreme caution, or the irqs may not be
> > > > stable which will generally break migration.
> > >=20
> > > Yes you are right. We should probably create a more "static" scheme.
> >=20
> > Sounds like we're in violent agreement.
>=20
> Yup :)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--hHiQ9nAwW5IGN2dL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAll1xd8ACgkQbDjKyiDZ
s5Jc3hAAjk5Dlepz3kx6xshdlTAznmiSzPZTGdtgWAp95POUDY5NTUsPqz9CrSm4
/P5nq6gyxVEUv7+UNgyYnpYh0CA0o06LVLXqNKlaUBQ1Xgx8Z5Q4Wr5a2gSySZCT
4VHQkGK4JGWsrOgjAn20jwgZ4bBrxUrjhjEK8Ol2mofNoEYM8w2VCCI5Hr1Ias93
TMCTtbhW7ERxtteSgEkQAzqv0DdziKGOj5wcGxVcFbMEkgYB05jPZTrEbuSiPn4x
aMX/dWWveLuJt4pCN52VkUt7aZJBSX1UQsu0ohBDs9K3sl4ZlCrpN3q3Vw1aEIFI
FCPnm8efPPSd4J8Gfak0PR2BCPsJLb9DIq7ER4lGE/Mf7A82/neoLDCJfG2QvYyw
rABki1eDMH67CM+AZLkWsUMqpHVvo7dPRXFXvg20/GywotCkVpnNv/jRxzJCl78u
ADPhEXWQOzHEqP8rjlbZTi88l3KyQfXzhkZan24KDsU/iW0pT0CYUnHMgQ0CFatG
HATLKIDwqmjtKQEhRp2nfwZgErtdIW6iO7X03PJ8Xd+5C+pOaFBRv3/6xbP+vSUD
O4R8ClAJGjN9R9fhVL938DRU0bhv8LqT7WWTeIbHgCqd7g1Q9zbnXCuxtt4ngJjS
R/t1FeGd2ggCC7nsQzvA5vnsyEr39++ZfnyP0aBO8z00exKeaAU=
=uTBz
-----END PGP SIGNATURE-----

--hHiQ9nAwW5IGN2dL--
