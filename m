Received: from eggs.gnu.org ([2001:4830:134:3::10]:41003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dAtJa-0004Rz-9s
	for qemu-devel@nongnu.org; Wed, 17 May 2017 03:24:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dAtJY-0004Yl-Uc
	for qemu-devel@nongnu.org; Wed, 17 May 2017 03:24:10 -0400
Date: Wed, 17 May 2017 17:23:59 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170517072359.GP15596@umbus.fritz.box>
References: <1494992962-6929-1-git-send-email-bharata@linux.vnet.ibm.com>
	<1494992962-6929-6-git-send-email-bharata@linux.vnet.ibm.com>
	<20170517065933.GM15596@umbus.fritz.box>
	<20170517071821.GC3446@in.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="GIP5y49pbaVPin6k"
Content-Disposition: inline
In-Reply-To: <20170517071821.GC3446@in.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH v1 5/6] spapr: Unregister HPT savevm
 handlers for radix guests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bharata B Rao <bharata@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, sam.bobroff@au1.ibm.com, rnsastry@linux.vnet.ibm.com


--GIP5y49pbaVPin6k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 17, 2017 at 12:48:21PM +0530, Bharata B Rao wrote:
> On Wed, May 17, 2017 at 04:59:33PM +1000, David Gibson wrote:
> > On Wed, May 17, 2017 at 09:19:21AM +0530, Bharata B Rao wrote:
> > > HPT gets created by default and later when the guest turns out to be
> > > a radix guest, the HPT is destroyed when guest does H_REGISTER_PROC_T=
BL
> > > hcall.
> >=20
> > I don't think that's entirely accurate.  At least in some KVM
> > configurations, we assume radix first, and only allocate the HPT once
> > the guest confirms it is doing hash.
>=20
> Right, that statement is true for TCG radix guests, will rephrase
> it.

And may not remain true even for TCG radix guests.  Since for TCG mode
we don't actually need either an HPT or an RPT while the guest is in
real mode, I've suggested postponing HPT allocation to CAS time for
TCG as well; I think that will make for slightly fewer differeneces
between the KVM and TCG paths.

> > > Let HTAB savevm handlers registration and unregistration follow
> > > the same model so that we don't end up having unrequired HTAB savevm
> > > handlers for radix guests.
> > >=20
> > > This also ensures that HTAB savevm handlers seemlessly get destroyed =
and
> > > recreated like HTAB itself when hash guest reboots.
> > >=20
> > > Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
> > > ---
> > >  hw/ppc/spapr.c         | 15 +++++++++++++--
> > >  hw/ppc/spapr_hcall.c   |  1 +
> > >  include/hw/ppc/spapr.h |  2 ++
> > >  3 files changed, 16 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > > index 521eef1..05abfc1 100644
> > > --- a/hw/ppc/spapr.c
> > > +++ b/hw/ppc/spapr.c
> > > @@ -1237,6 +1237,7 @@ static void spapr_reallocate_hpt(sPAPRMachineSt=
ate *spapr, int shift,
> > > =20
> > >      /* Clean up any HPT info from a previous boot */
> > >      spapr_free_hpt(spapr);
> > > +    spapr_htab_savevm_unregister(spapr);
> >=20
> > I'd prefer that the unregister be folded into spapr_free_hpt().
> > Basically we want calls that create or remove the HPT and handle
> > everything - allocation/freeing if necessary, informing KVM if
> > necessary, and registering/deregistering the savevm handlers if
> > necesary.
> >=20
> > I think that will also remove the need for the trivial
> > spapr_htab_savevm_{un,}register() wrappers.
>=20
> Sure, will consolidate this in the next version.
>=20
> Regards,
> Bharata.
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--GIP5y49pbaVPin6k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZG/qPAAoJEGw4ysog2bOSjR8P+gMZQ5yENbY6pLZ/MZPAF5FW
6lIRT0CAFoIWOUrxa3QGT8ITu72SwOti/DUG6JL3YuPdefrLrUNIija/2p7J99ae
HeXoxK6xH+D+NV2+Fn31twapDqYrtnAoX7Q2iVjnhq/1Z7g8u71oMAoljHie3HFA
YmZ77VcaVBnjzEp4SM9w5bwRI3elB9YSlhMYkU9yYElXIIJb7YA3B3mZy9dv1su7
kHfS3wHW+U/lE9vB1ClqeZPTkxAKl+UUQm/LrtJCaUYYbI5hB0JABAtEBfofil28
NPEWET3DYIlVARBHPuIz2hBNHFog50w/j+Y32mPmwh59ut0g1k+hlOQ2rmhjeAWq
dO4BzN/xyZstryjKQ0s+7WeyspbBw3jUHxQQLLBscYmVuK2N0GF1ww+Z7l7XzjTK
A74juXrPUTlfPkh2njkDTVftferFNx8LbLPSoE0xNMGcuoG8XvrtXW5kI2ve2bk3
hcE6eLiMxCoDtxEmQJ+oh3N2wA/GFi/T8gVRNXWDRXt6rvCDdy/e5wPjtIvk0d8u
QZrV4c/pQpg6NVNUqb4XuaN6/cxf8gQI57b4YFzBcgqIaLNwnQG22MJ8NivLuWrC
ZqO8uz3Ho2U3tqAAA93QnpEnlWCJQylyr9gS3TDueUFNDpslwWDL8UzeVIEpLx10
6zvYx6VIxmKof7aIngj7
=qrcJ
-----END PGP SIGNATURE-----

--GIP5y49pbaVPin6k--
