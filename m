Received: from eggs.gnu.org ([2001:4830:134:3::10]:46368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fVyIK-00074F-O6
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 08:02:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fVyIC-0007Vl-PV
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 08:02:32 -0400
Date: Thu, 21 Jun 2018 21:52:47 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180621115247.GA2009@umbus.fritz.box>
References: <20180618063606.2513-1-david@gibson.dropbear.id.au>
	<20180618063606.2513-9-david@gibson.dropbear.id.au>
	<f829daa0-c870-f835-2195-df795c0e47b9@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
Content-Disposition: inline
In-Reply-To: <f829daa0-c870-f835-2195-df795c0e47b9@kaod.org>
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
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: groug@kaod.org, abologna@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, aik@ozlabs.ru


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 21, 2018 at 09:01:27AM +0200, C=E9dric Le Goater wrote:
> On 06/18/2018 08:36 AM, David Gibson wrote:
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
> >
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
>=20
> you could check that elsewhere.

Um.. I'm not sure what you're getting at.

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
> > +    if ((pshift !=3D seg_pshift) && (pshift !=3D 24)) {
> > +        return false;
> > +    }

Note the stanza above, I'll refer to it below.

> > +
> > +    return true;
> > +}
>=20
> So, do we really need ppc_hash64_filter_pagesizes() to have a callback ?=
=20

I agree that it seems overly involved, but it was the best way I could
see to logically separate the TCG / softmmu specific logic from the
spapr specific logic.

> It seems that we only use the routine once in the patchset and that the
> only thing we need to check is 'maxshift'.

Not quite.  An earlier draft had this routine just take a max page
size and clamp accordingly.  But that failed when I wrote the code to
check against the KVM capabilities, because KVM also excludes some
other pagesize combinations.  That's what the stanza I point out above
is about

> Do you envision other usage of the routine ?

Not really, no.

>=20
> Thanks,
>=20
> C.
>=20
> > +static void cap_hpt_maxpagesize_cpu_apply(sPAPRMachineState *spapr,
> > +                                          PowerPCCPU *cpu,
> > +                                          uint8_t val, Error **errp)
> > +{
> > +    unsigned maxshift =3D val;
> > +
> > +    ppc_hash64_filter_pagesizes(cpu, spapr_pagesize_cb, &maxshift);
> > +}
> > +
> >  sPAPRCapabilityInfo capability_table[SPAPR_CAP_NUM] =3D {
> >      [SPAPR_CAP_HTM] =3D {
> >          .name =3D "htm",
> > @@ -401,6 +433,7 @@ sPAPRCapabilityInfo capability_table[SPAPR_CAP_NUM]=
 =3D {
> >          .set =3D spapr_cap_set_pagesize,
> >          .type =3D "int",
> >          .apply =3D cap_hpt_maxpagesize_apply,
> > +        .cpu_apply =3D cap_hpt_maxpagesize_cpu_apply,
> >      },
> >  };
> > =20
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsrkYwACgkQbDjKyiDZ
s5JmFw/9FQbnLyPnko6hnMMxEfC8VXNzrivTueN36t3p1zHMWD4Z8C5lugQ9G7Yg
/gIbnAK+KoqC99nuNlFtOQ9dkVZKP9L64VtCN5hJq5D0B7W28VceJh7MGK0PqyVM
nDeaACg/r1jlRP2dA4yWII2Tn0sXx5OZQ+mVdvTuwh2kC4Mn14HZGMILho3EbERI
jLB/XYlUAIhhnuByQKa/dO5IrWvSqEZhuDKofZnH/3vNMKrNRWDh93xE2imAaxbN
G/CPR5GoW/pTEkIiUGGqhYbN5l41qS+lOOXsmfgLh4zt5WitjgCg+LPEd2Rp6bmm
oP9EYi1epp+xgXWzIemg1EWuaoOEBAVDvADvcKnDFaB12HF9vW/6V/1Z5vfIPVL/
59ExCeab8dzEvob8EDCmk8MPnPrN4xZsyCC1nzy2nL/S9MNp7GccTB0+jzYHn0so
JRbrOjI9AKNodIhcZ2fCK9Kzv0TeLKEZ5TuEqk1eFvHF/obr6RDXxNj6xfkBirzN
SOOxz75AbDN6vKgJn7VBuTXRKg7aYeAvGQmQsKRNTJFK8gG6KeNLEPj9KCkIHT+H
F6mhDfN2KEfIgExf+uVWi6kazysm3A9SA9GeqzBWtPtLzHGobOUpcFIN7jYO+qcR
2cBm4EAZgAsqS2O6w7CotKJGFzda3auLASjbMzTKu3qnZl4UvfE=
=KRav
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--
