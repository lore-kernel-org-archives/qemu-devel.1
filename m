Received: from eggs.gnu.org ([2001:4830:134:3::10]:50831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fW09c-0002SH-Mi
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 10:01:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fW09Z-0003au-Kc
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 10:01:40 -0400
Date: Fri, 22 Jun 2018 00:01:13 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180621140113.GA612@umbus.fritz.box>
References: <20180618063606.2513-1-david@gibson.dropbear.id.au>
	<20180618063606.2513-9-david@gibson.dropbear.id.au>
	<20180621142419.5c6d2ce2@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="d6Gm4EdcadzBjdND"
Content-Disposition: inline
In-Reply-To: <20180621142419.5c6d2ce2@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH 8/9] spapr: Limit available pagesizes to
 provide a consistent guest environment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: abologna@redhat.com, clg@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, aik@ozlabs.ru


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 21, 2018 at 02:24:19PM +0200, Greg Kurz wrote:
> On Mon, 18 Jun 2018 16:36:05 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > KVM HV has some limitations (deriving from the hardware) that mean not =
all
> > host-cpu supported pagesizes may be usable in the guest.  At present th=
is
> > means that KVM guests and TCG guests may see different available page s=
izes
> > even if they notionally have the same vcpu model.  This is confusing and
> > also prevents migration between TCG and KVM.
> >=20
> > This patch makes the environment consistent by always allowing the same=
 set
> > of pagesizes.  Since we can't remove the KVM limitations, we do this by
> > always applying the same limitations it has, even to TCG guests.
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> >  hw/ppc/spapr_caps.c | 33 +++++++++++++++++++++++++++++++++
> >  1 file changed, 33 insertions(+)
> >=20
> > diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> > index 9fc739b3f5..0584c7c6ab 100644
> > --- a/hw/ppc/spapr_caps.c
> > +++ b/hw/ppc/spapr_caps.c
> > @@ -334,6 +334,38 @@ static void cap_hpt_maxpagesize_apply(sPAPRMachine=
State *spapr,
> >      spapr_check_pagesize(spapr, qemu_getrampagesize(), errp);
> >  }
> > =20
> > +static bool spapr_pagesize_cb(void *opaque, uint32_t seg_pshift, uint3=
2_t pshift)
> > +{
> > +    unsigned maxshift =3D *((unsigned *)opaque);
> > +
> > +    assert(pshift >=3D seg_pshift);
> > +
> > +    /* Don't allow the guest to use pages bigger than the configured
> > +     * maximum size */
> > +    if (pshift > maxshift) {
> > +        return false;
> > +    }
> > +
> > +    /* For whatever reason, KVM doesn't allow multiple pagesizes
> > +     * within a segment, *except* for the case of 16M pages in a 4k or
> > +     * 64k segment.  Always exclude other cases, so that TCG and KVM
> > +     * guests see a consistent environment */
>=20
> Unless I'm missing something, I don't see how we could get "other cases"
> with TCG, at least with the current content of ppc_hash64_opts_POWER7.

You're missing something.  hash64_opts_POWER7 includes 64k pages in a
segment with base page size of 4k.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsrr6kACgkQbDjKyiDZ
s5LC0g/9H0RQSOWleC3LybaOhnDiEU+rKsa/EoODqXLJT97X4ZQvVFiBmLDeLI07
zmJJrmT1oigR6XNNGXKX+6LvB8Uxu4U/Vor5HC0wWbKKt0rBvo7Bpt4wzJezUJTr
RZ1CZXISKhKNaR+abpcNGGZgnWH0DAryx6lTwP2tzNw4DbNAr8kCtq7F8eD0AjNj
VxQw+HQW7scXsxuJE6DpajZidKwMtn8A/6j+bekfKotjlpkVdkeD/CbUSseX0TLp
fUVXrNRdJ74qYwMsb2uVxFK3rHowIwLrbHch87wQlnclzJFjtGA8e0A9/3+6CbYb
SM0g8hBHkyRjY6C2z+Z3CqKcCOrcwJzAqyxPcRQFpnkBEtyeY82iMVbtz6KTc8Tf
vSn5SeaxMLqHMRmoXs0S1KOVN7lEKSKlFKrOAv4KQ/bj2AFW1CDOW5HKiZc51wMj
aeCt5PY9dGfBCpwq0RQV28O/TsMycIdhdvTXsXZOzAxGFdBynWQ0XqSVUOrXCP9f
QO3gw4xVOy6Ug/y/mJxhQ1GmQ5aRdwpgAynassdOb71ycTJxkf5LzLqTtxF6PXCt
BpHdEAZuChrxbObNgXguWTpP3PL2FBTaSHPnWK8Vu6mFd1YcREke+tNFdx8MyMOu
3SUAHF/a+j9z3TOZbG+KvS72S6URaGqIpjFTrGev4bGiPSWXTt8=
=FGSb
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--
