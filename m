Received: from eggs.gnu.org ([2001:4830:134:3::10]:50550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fTH1p-0006vH-V8
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 21:26:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fTH1l-0005Fh-Vd
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 21:26:21 -0400
Date: Thu, 14 Jun 2018 11:26:10 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180614012610.GA3042@umbus.fritz.box>
References: <152882087494.112322.15549780953419438229.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
	<152882305541.114463.3137854902721347235.stgit@bahia.lan>
	<20180613004506.GM30690@umbus.fritz.box>
	<20180613101915.4cc9485b@bahia.lab.toulouse-stg.fr.ibm.com>
	<20180613120502.GO30690@umbus.fritz.box>
	<20180613162639.08d8cc17@bahia.lab.toulouse-stg.fr.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gBBFr7Ir9EOA20Yy"
Content-Disposition: inline
In-Reply-To: <20180613162639.08d8cc17@bahia.lab.toulouse-stg.fr.ibm.com>
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


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 13, 2018 at 04:26:39PM +0200, Greg Kurz wrote:
> On Wed, 13 Jun 2018 22:05:02 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Wed, Jun 13, 2018 at 10:19:15AM +0200, Greg Kurz wrote:
> > > On Wed, 13 Jun 2018 10:45:06 +1000
> > > David Gibson <david@gibson.dropbear.id.au> wrote:
> > >  =20
> > > > On Tue, Jun 12, 2018 at 07:04:15PM +0200, Greg Kurz wrote: =20
> > > > > Bits set in the PCR disable features of the processor. TCG curren=
tly
> > > > > doesn't implement that, ie, we always act like if PCR is all zero=
s.
> > > > >=20
> > > > > But it is still possible for the PCR to have a non-null value. Th=
is may
> > > > > confuse the guest.
> > > > >=20
> > > > > There are three distinct cases:
> > > > >=20
> > > > > 1) a powernv guest doing mtspr SPR_PCR
> > > > >=20
> > > > > 2) reset of a pseries guest if the max-cpu-compat machine propert=
y is set
> > > > >=20
> > > > > 3) CAS of a pseries guest
> > > > >=20
> > > > > This patch adds a ppc_store_pcr() helper that ensures we cannot p=
ut
> > > > > a non-null value in the PCR when using TCG. This helper also has
> > > > > error propagation support, so that each case listed above can be
> > > > > handled appropriately:
> > > > >=20
> > > > > 1) since the powernv machine is mostly used for OpenPOWER FW deve=
l,
> > > > >    we just print an error and let QEMU continue execution
> > > > >=20
> > > > > 2) an error is printed and QEMU exits, ie, same behaviour as when
> > > > >    KVM doesn't support the requested compat mode
> > > > >=20
> > > > > 3) an error is printed and QEMU reports H_HARDWARE to the guest
> > > > >=20
> > > > > Signed-off-by: Greg Kurz <groug@kaod.org>   =20
> > > >=20
> > > > I'm not really convinced this is a good idea.  Printing a (non fata=
l)
> > > > error if the guest attempts to write a non-zero value to the PCR
> > > > should be ok.  However, you're generating a fatal error if the mach=
ine
> > > > tries to set the PCR in TCG mode.  That could easily happen using,
> > > > e.g. the cap-htm flag on a TCG guest.  That would take TCG from mos=
tly
> > > > working, to refusing to run at all.
> > > >  =20
> > >=20
> > > I'm confused... I don't see anything related to HTM in TCG. Also we h=
ave
> > > the following in cap_htm_apply():
> > >=20
> > >     if (tcg_enabled()) {
> > >         error_setg(errp,
> > >                    "No Transactional Memory support in TCG, try cap-h=
tm=3Doff");
> > >=20
> > > I'm probably missing something... can you enlighten me ? =20
> >=20
> > Ok, so right now when cap-htm=3Doff we don't actually enforce that, we
> > just don't advertise it to the guest.  We probably _should_ enforce
> > that, and the way we'd do it is to set the appropriate bit in the
> > PCR.  That'll do the right thing for KVM (well, once we update KVM to
> > actually pass on the PCR value) but would break TCG in conjunction
> > with your patch above.
>=20
> Hmm... The granularity of the PCR bits is PowerISA versions, not individu=
al
> facilities AFAIK... or am I missing something again ?

Huh.. so.  In the 3.0 ISA, there are only ISA version bits.  But in
the 2.07 ISA, there are ISA version bits *and* a bit to control HTM.

I'm not quite sure what to make of that.  I kind of love the fact that
they incompatibly change the compatibility register.

> Anyway, with the current code, if we start the guest with:
>=20
> -machine accel=3Dtcg,max-cpu-compat=3Dpower8 -cpu POWER9
>=20
> We get this in the guest:
>=20
> # grep ^cpu /proc/cpuinfo=20
> cpu             : POWER8 (architected), altivec supported
>=20
> This is the expected result of the CAS negotiation, but
> the guest can still execute PowerISA 3.0 instructions
> that should cause an invalid instruction exception.

Right, this is a bug, albeit not a very high priority one.

> I agree this shouldn't cause QEMU to exit, but I guess we should
> at least leave the PCR to all zeroes, so that the guest view
> is consistent with what TGC does (ie, raw mode). And maybe an
> error message to indicate that the PCR is ignored in TCG... but
> since that could be guest triggered, and the user cannot do anything
> about it, I'm wondering if this should rather be a trace actually.
>=20
> Does it make sense for you ?

TBH, I don't care all that much.  There are a bunch of cases where TCG
doesn't behave quite right, most without warnings.  One more or less
doesn't make a huge difference.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlshxDIACgkQbDjKyiDZ
s5KBZw/+PVdp/dL/Xa5NvDd9ssm4EUvXafS1RDe8LQaruODba9uUw5Zh0bl7u7Ss
XBCxv96MaHnydgaG5pgQApkPNZIRyExcpB+qrCoPIpgsy2maJt6VfNEn0qH8j3AV
7jCmHkSXEpNMH9YZtFXWwrolqHq8dAq6Bid/s/V2J2yD2X0Ka08d6kuUSr/b/17I
Tut1QeIOuMph/C0QMtz/BFmSldw3wLtr5elYnQdBC3Jt1DlvYgEnhrEmtkChbTg1
va0kUocs9VFfKv0R25t9JegZ+BzYKpgtGnvOqFE/W0gxuN1OTd0vgvRFS6r5qrKH
5l6TidYKbBO10ND/MkksKG6A1Xu+Og+nC020oukn/mmV6gC52GPN6os+4SAGBT8N
kfwiBDvtDy9JMZ3Gud+dqJ+93ipYteb5rOyeW00ORqscV6DRSStDfX1fSb+E08hk
mpgtJZ57zV4pL8EjIo8eFNtCKYRcC8PfEI2K965Csy320KbQk2Db7YBgGJE+h3Ok
qmxLp+pGuRlF5C5TgPaGfp5W+aBDascrWoljkpLfXQ0/QXnN/74lp81W6pk+U3VO
i1cKe8JSD+mZb/Dir1rERFTb2G5FpG156ULNr3S2Qbz7r/8E0nNvpdkwRmzbKZcp
rr8hFltaZH0f7xQZZr6tXcvXWL/QJXwmgTDSycb9Bd6+8+i1rnA=
=VT+S
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--
