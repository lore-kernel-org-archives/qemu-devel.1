Received: from eggs.gnu.org ([2001:4830:134:3::10]:58956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dIp4u-0001Yu-1m
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 00:29:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dIp4s-0002ud-SW
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 00:29:48 -0400
Date: Thu, 8 Jun 2017 14:21:58 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170608042158.GZ13397@umbus.fritz.box>
References: <1496230005-12265-1-git-send-email-bharata@linux.vnet.ibm.com>
	<1496230005-12265-2-git-send-email-bharata@linux.vnet.ibm.com>
	<20170601045448.GB13397@umbus.fritz.box>
	<20170607075332.GC27525@in.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="w2Ze1fp8mKggy7lw"
Content-Disposition: inline
In-Reply-To: <20170607075332.GC27525@in.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v4 1/2] spapr: Add a "no HPT" encoding to
 HTAB migration stream
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bharata B Rao <bharata@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, sam.bobroff@au1.ibm.com, rnsastry@linux.vnet.ibm.com, sjitindarsingh@gmail.com


--w2Ze1fp8mKggy7lw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 07, 2017 at 01:23:32PM +0530, Bharata B Rao wrote:
> On Thu, Jun 01, 2017 at 02:54:48PM +1000, David Gibson wrote:
> > On Wed, May 31, 2017 at 04:56:44PM +0530, Bharata B Rao wrote:
> > > Add a "no HPT" encoding (using value -1) to the HTAB migration
> > > stream (in the place of HPT size) when the guest doesn't allocate HPT.
> > > This will help the target side to match target HPT with the source HPT
> > > and thus enable successful migration.
> > >=20
> > > A few more fixes to enable TCG migration to work correctly are also
> > > included in this commit:
> > >=20
> > > - HTAB savevm handlers have a few asserts on kvm_enabled() when
> > >   spapr->htab !=3D 0. Convert these into conditional checks as it is =
now
> > >   possible to have no HTAB with TCG radix guests.
> > > - htab_save_setup() asserts for kvm_enabled() when spapr->htab !=3D 0.
> > >   Remove this as we can't assert this for TCG radix guests.
> > >=20
> > > Suggested-by: David Gibson <david@gibson.dropbear.id.au>
> > >               [no HPT encoding suggestion]
> > > Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
> >=20
> > Looks basically ok, but there are still some details to address.
> >=20
> > > ---
> > >  hw/ppc/spapr.c | 31 +++++++++++++++++--------------
> > >  1 file changed, 17 insertions(+), 14 deletions(-)
> > >=20
> > > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > > index ab3aab1..b589ed4 100644
> > > --- a/hw/ppc/spapr.c
> > > +++ b/hw/ppc/spapr.c
> > > @@ -1559,17 +1559,18 @@ static int htab_save_setup(QEMUFile *f, void =
*opaque)
> > >  {
> > >      sPAPRMachineState *spapr =3D opaque;
> > > =20
> > > -    /* "Iteration" header */
> > > -    qemu_put_be32(f, spapr->htab_shift);
> > > +    /* "Iteration" header: no-HPT or HPT size encoding */
> > > +    if (!spapr->htab_shift) {
> > > +        qemu_put_be32(f, -1);
> >=20
> > We're already using htab_shift =3D=3D 0 to represent no HPT in the runt=
ime
> > structure; we might as well do the same on the wire.  As a bonus it
> > slightly simplifies the logic here.
>=20
> Non-zero value of iteration header (which is htab_shift) results in
> htab_load() at the target to reallocate HTAB.

Yeah.. but you can change that, right.  Have htab_load() remove the
HPT instead, if section_hdr =3D=3D 0.

Older qemus that don't understand that certainly weren't going to be
able to take an incoming RPT guest anyway.

> zero value of iteration header is used by htab_save_iterate() and
> htab_save_complete() to tell htab_load() not to freshly allocate HTAB
> at the target.

But that makes no sense anyway.  How the destination goes about
allocating or not allocating the HPT shouldn't be the choice of the
source.  Since the source doesn't know what the destination has
already allocated, it can't possibly know if it's of a matching size,
likewise if the destination doesn't get a size, it can't know if the
current size is correct.

> Hence we can't use 0 value to mean no-HPT.

I really think we can..

> I have addressed the rest of the comments on asserts by ensuring that
> those code paths are taken only when HPT is present. v5 has those
> changes.
>=20
> Regards,
> Bharata.
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--w2Ze1fp8mKggy7lw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZONDlAAoJEGw4ysog2bOS3DoP/3o87RDcgzpfoucJVgeq/t4I
iD7UfExmu0BKxJ7qyR0Gzo786wfOKuG3N2r+YHhETIV0XFhp6B5bk18edbSLgzDY
2Hong8fTmnSaTWykWcYjfQ9VU7kw1RazPRWX9Zontietngpl+Fj/rgfCKrf48g3/
edBjJB1OAapYp5e9qCaPvU6UNhqa20HtGBzL9EIEc+wMAPD8zrS5knKcM8CCTUku
xnU8MpgtaB833HKhH2M/UcPXY41bnbwdkg/ddJRjJiZsKP9oPMp36Ss7SHbkOnnB
lYvc3EK4snT3sTLtD2Wy3xHlrBdJvZjMV2tZo4bwRt8tjae7S+tYrm3E+Ss9Uf+5
zaP6wzAAjXIjlBjuDSG7LpXKGivH01u1yZpt0aaL4gF1UecUV+UZh6fKe6HaOpSY
vXA6WUMabEBlHTzJP+0PghYa5QCUMmVavZdGYdwb5tdthflgcTRRVP5gAc9J+uJf
AMVytc3JT8Aiqwfsz4V3MwNi6AJZ8RarVaBbqIqZH47PRccyEyKDjb2tNSuYG1BE
z+tVWSHkjwm/r8KVqhrCNyE6YQr+L0HBGKlvJQpKYf259uXqHXs/vRURvjgvUGIx
ydOBGI5VUYYa26Ocy8ELFZ3LXc9rjIpqJExiM2AkaBmTOjZbUy2FvO1Pc8neQ8Xl
S382bYxYK31K/AATCXfh
=Fcq9
-----END PGP SIGNATURE-----

--w2Ze1fp8mKggy7lw--
