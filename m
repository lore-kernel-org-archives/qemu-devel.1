Received: from eggs.gnu.org ([2001:4830:134:3::10]:59150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eI1kE-0007fF-SQ
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 19:21:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eI1kD-0004p6-OP
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 19:21:26 -0500
Date: Fri, 24 Nov 2017 11:21:07 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171124002107.GI22454@umbus.fritz.box>
References: <20171120032420.9134-1-mdavidsaver@gmail.com>
	<20171120032420.9134-2-mdavidsaver@gmail.com>
	<20171122032852.GG2380@umbus.fritz.box>
	<791a1520-6f3b-f380-3029-a89cdd0fbff6@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="GlnCQLZWzqLRJED8"
Content-Disposition: inline
In-Reply-To: <791a1520-6f3b-f380-3029-a89cdd0fbff6@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 01/12] e500: add board config options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Davidsaver <mdavidsaver@gmail.com>
Cc: Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--GlnCQLZWzqLRJED8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2017 at 11:55:04AM -0600, Michael Davidsaver wrote:
> On 11/21/2017 09:28 PM, David Gibson wrote:
> > On Sun, Nov 19, 2017 at 09:24:09PM -0600, Michael Davidsaver wrote:
> >> allow board code to skip common NIC and guest image setup
> >> and configure decrementor frequency.
> >> Existing boards unchanged.
> >>
> >> Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
> >=20
> > So, it's spelled "decrementer".
> >=20
> > Other than that, the patch looks correct.  However having a big common
> > function for overall init with a pile of ad-hoc configuration
> > parameters is usually not a great way to go.  I think what we want
> > instead is to eliminate ppce500_init(), instead doing the setup logic
> > separately in each of the e500 machines.   The large common slabs of
> > code can be helpers in e500.c, but the overall logic - including most
> > of the things controlled by the current params - would be under the
> > individual machine's control.
>=20
> I agree that ppce500_init() is unwieldy, and am willing to spend some
> time on cleanup.  I'm just not sure what to do.
>=20
> I can see moving initialization of at least the serial, i2c, gpio, and
> possibly MPIC and PCI host bridge into the e500-ccsr class.
>=20
> I'm not sure what to do with all the device tree construction code in
> e500.c, which has a bunch of hard coded register offsets.  A comment
> here summarizes the problem nicely.

So, those aren't bad ideas for cleanups, but I'm not going to insist
on that before merging this stuff.  What I'm after is something
simpler.  At the moment the structure looks something like this:

	machine_init() {
		common_init(big pile of parameters);
	}

	common_init() {
		chunk1;
		if (param1)
			chunk2;
		chunk3;
		if (param2)
			chunk4;
		...
	}

What I would prefer is:

	machine_init1() {
		chunk1();
		chunk2(param1)
		chunk3(param3);
	}

	machine_init2() {
		chunk1();
		chunk3(param3);
		chunk4(param2);
	}

>=20
> > /* TODO: parameterize */
> > #define MPC8544_CCSRBAR_SIZE       0x00100000ULL
> > #define MPC8544_MPIC_REGS_OFFSET   0x40000ULL
>=20
> It seems desirable to avoid having these offsets appear in two different
> files, which could allow them to get out of sync.
>=20
> I had the idea of using an Interface to split up device tree
> construction, and was encouraged to find PnvXScomInterfaceClass which
> seems be a way of combining device tree construction in a device class.
> Is this the way to go?

At some point, quite likely (I've actually had thoughts on making
devicetree construction more convenient qemu wide, but haven't had
time to do much about it).

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--GlnCQLZWzqLRJED8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAloXZfMACgkQbDjKyiDZ
s5LvExAAonxYmzO1SaXMpdq3zpB705JN2ZLM8JuLU6+bgcyTZ77gSIE1bnMWmpkE
Cm+rGxCRXS9Nf2+0Yp8gktrgvyT4llkO0cRT+eaCPNIbJHS9xXwzA5+5sLSgMKUT
Dus2Z2keNVDu3BvP7LetnMzI/wlrtLfOh4tdDUKTWEAyvcmTQ4BDqTFfjJwc2nCJ
DhyyFBxcJNOWC4sYM0jCnXu5xCHsQadSgx0RUyNuZOkhPfiTyVSvnZpWjuNlok1l
n+mXP8JtrCBfzqcMa6fdHC9v++KrgePeHNZqxlc9X3atvv8goeqZbgthZBafr8kX
fsg5W8Gla2c41oIQNnXvzcflF1lWxu8FZGl+saO2OXgONjI35DObiOR4cGs9znRh
NbcahTgNJP4wRZe0ZHJ68HTfa/gAzPlwp4lkfauz1SlRSuAK4b0gEtjFnotqsWZW
1mdC3AdRyn8TRvslYyQgRs4AAVNmt2aSCofhFmqu78dZ7bYrt7+TH0ayxwDvu/XS
CvAxFmZSYCGJ5xdWjLDtvTJvXP6bzSXkq1z/wLXQORjibk7VDTXrRIdcEmzYOg8F
Q02R7e1znwtpMzVM89GXFQ2Jx1/upxsqs350ALqMerN1dsVV2Kb0pCFuhLKW63aU
ZhNSm6kci/tqejs7f8ClCUJAOdxaLAtZGRgro9urWWiFKxb8LO8=
=kBqO
-----END PGP SIGNATURE-----

--GlnCQLZWzqLRJED8--
