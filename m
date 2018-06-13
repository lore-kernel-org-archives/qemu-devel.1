Received: from eggs.gnu.org ([2001:4830:134:3::10]:38477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fT4WY-0004D2-Uw
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 08:05:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fT4WU-000071-By
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 08:05:14 -0400
Date: Wed, 13 Jun 2018 22:05:02 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180613120502.GO30690@umbus.fritz.box>
References: <152882087494.112322.15549780953419438229.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
	<152882305541.114463.3137854902721347235.stgit@bahia.lan>
	<20180613004506.GM30690@umbus.fritz.box>
	<20180613101915.4cc9485b@bahia.lab.toulouse-stg.fr.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tbBCmy51UvWhYeBI"
Content-Disposition: inline
In-Reply-To: <20180613101915.4cc9485b@bahia.lab.toulouse-stg.fr.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 3/3] target/ppc: filter out non-zero PCR
 values when using TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--tbBCmy51UvWhYeBI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 13, 2018 at 10:19:15AM +0200, Greg Kurz wrote:
> On Wed, 13 Jun 2018 10:45:06 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Tue, Jun 12, 2018 at 07:04:15PM +0200, Greg Kurz wrote:
> > > Bits set in the PCR disable features of the processor. TCG currently
> > > doesn't implement that, ie, we always act like if PCR is all zeros.
> > >=20
> > > But it is still possible for the PCR to have a non-null value. This m=
ay
> > > confuse the guest.
> > >=20
> > > There are three distinct cases:
> > >=20
> > > 1) a powernv guest doing mtspr SPR_PCR
> > >=20
> > > 2) reset of a pseries guest if the max-cpu-compat machine property is=
 set
> > >=20
> > > 3) CAS of a pseries guest
> > >=20
> > > This patch adds a ppc_store_pcr() helper that ensures we cannot put
> > > a non-null value in the PCR when using TCG. This helper also has
> > > error propagation support, so that each case listed above can be
> > > handled appropriately:
> > >=20
> > > 1) since the powernv machine is mostly used for OpenPOWER FW devel,
> > >    we just print an error and let QEMU continue execution
> > >=20
> > > 2) an error is printed and QEMU exits, ie, same behaviour as when
> > >    KVM doesn't support the requested compat mode
> > >=20
> > > 3) an error is printed and QEMU reports H_HARDWARE to the guest
> > >=20
> > > Signed-off-by: Greg Kurz <groug@kaod.org> =20
> >=20
> > I'm not really convinced this is a good idea.  Printing a (non fatal)
> > error if the guest attempts to write a non-zero value to the PCR
> > should be ok.  However, you're generating a fatal error if the machine
> > tries to set the PCR in TCG mode.  That could easily happen using,
> > e.g. the cap-htm flag on a TCG guest.  That would take TCG from mostly
> > working, to refusing to run at all.
> >=20
>=20
> I'm confused... I don't see anything related to HTM in TCG. Also we have
> the following in cap_htm_apply():
>=20
>     if (tcg_enabled()) {
>         error_setg(errp,
>                    "No Transactional Memory support in TCG, try cap-htm=
=3Doff");
>=20
> I'm probably missing something... can you enlighten me ?

Ok, so right now when cap-htm=3Doff we don't actually enforce that, we
just don't advertise it to the guest.  We probably _should_ enforce
that, and the way we'd do it is to set the appropriate bit in the
PCR.  That'll do the right thing for KVM (well, once we update KVM to
actually pass on the PCR value) but would break TCG in conjunction
with your patch above.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--tbBCmy51UvWhYeBI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlshCG0ACgkQbDjKyiDZ
s5J3GRAA4Orwrt6a7ICCeuOii1QOHwPqnQPupuCYNUx/ENSKpMuZTsYtGzJZ43V3
EPzCM6VywiPIWsDEx89d9bim5C20No9IgMvuoMsBxAM29f5++O/BrPEJJbWLuuCr
RMYSIMLWFEjSXUWzMd/gqI90BtugFZkyTuaf6lftv5PpAGW5ToFc4H/LX1n2YdLP
tOstJUlB8r1tilJ7C/5EPVXLI5i2CxRa0MVX4OPByqucN/w2YrXUggvrdlqpevHF
SEVR5+9zXpR5jDjylp0E+R6rBk+7tDEEFLJDkpynryzSUi+Uk+Oy4tEzrE/D3fEy
sLndiX45x2YjYhvlpsXFmTZUh5jeo1gSZh4Mf69iKC2u7VaVL1qFEBQetethCF8K
eyrFYUKENCMHdzW7+9M9bA1bzd+PlCepfqxxAxYkzQUWiV5msLSsoduOhHSpozQx
CocF8VVBjUKktlIsg0/9mYRQer4IXa4dbkv7ym0iC6E4qEWBfr1tkTFH9pbjo22Z
FESQ+UZWluqzvfc070sI/s0a/KeESTIgpy8RhwBj2cp5JNt+W7C2EyoOqODNHTC3
ZowZ3UXd4a0BLpHG/JuDTDVgP3qOn+g590PzJ5Ob0YzNcsDyBwaL4s4ohMVCW/8/
d61wuI6fplrRJBoPS8WYPpc6Agdx3jVxXu0AeT6/5UJsKYKagXE=
=EHBf
-----END PGP SIGNATURE-----

--tbBCmy51UvWhYeBI--
