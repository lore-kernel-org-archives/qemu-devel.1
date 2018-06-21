Received: from eggs.gnu.org ([2001:4830:134:3::10]:50062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fW06O-0008V4-CS
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 09:58:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fW06M-0001TI-VJ
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 09:58:20 -0400
Date: Thu, 21 Jun 2018 23:58:10 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180621135810.GC2009@umbus.fritz.box>
References: <20180618063606.2513-1-david@gibson.dropbear.id.au>
	<20180618063606.2513-9-david@gibson.dropbear.id.au>
	<f829daa0-c870-f835-2195-df795c0e47b9@kaod.org>
	<20180621115247.GA2009@umbus.fritz.box>
	<471b50ee-8f18-9fcc-10c7-8f5bca8c8cd3@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="V88s5gaDVPzZ0KCq"
Content-Disposition: inline
In-Reply-To: <471b50ee-8f18-9fcc-10c7-8f5bca8c8cd3@kaod.org>
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


--V88s5gaDVPzZ0KCq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 21, 2018 at 02:50:32PM +0200, C=E9dric Le Goater wrote:
> On 06/21/2018 01:52 PM, David Gibson wrote:
> > On Thu, Jun 21, 2018 at 09:01:27AM +0200, C=E9dric Le Goater wrote:
> >> On 06/18/2018 08:36 AM, David Gibson wrote:
> >>> KVM HV has some limitations (deriving from the hardware) that mean no=
t all
> >>> host-cpu supported pagesizes may be usable in the guest.  At present =
this
> >>> means that KVM guests and TCG guests may see different available page=
 sizes
> >>> even if they notionally have the same vcpu model.  This is confusing =
and
> >>> also prevents migration between TCG and KVM.
> >>>
> >>> This patch makes the environment consistent by always allowing the sa=
me set
> >>> of pagesizes.  Since we can't remove the KVM limitations, we do this =
by
> >>> always applying the same limitations it has, even to TCG guests.
> >>>
> >>> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> >>>
> >>> ---
> >>>  hw/ppc/spapr_caps.c | 33 +++++++++++++++++++++++++++++++++
> >>>  1 file changed, 33 insertions(+)
> >>>
> >>> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> >>> index 9fc739b3f5..0584c7c6ab 100644
> >>> --- a/hw/ppc/spapr_caps.c
> >>> +++ b/hw/ppc/spapr_caps.c
> >>> @@ -334,6 +334,38 @@ static void cap_hpt_maxpagesize_apply(sPAPRMachi=
neState *spapr,
> >>>      spapr_check_pagesize(spapr, qemu_getrampagesize(), errp);
> >>>  }
> >>> =20
> >>> +static bool spapr_pagesize_cb(void *opaque, uint32_t seg_pshift, uin=
t32_t pshift)
> >>> +{
> >>> +    unsigned maxshift =3D *((unsigned *)opaque);
> >>> +
> >>> +    assert(pshift >=3D seg_pshift);
> >>
> >> you could check that elsewhere.
> >=20
> > Um.. I'm not sure what you're getting at.
>=20
> you could put the assert in ppc_hash64_filter_pagesizes(), that is where
> the parameters are coming from.

Yes.. but it's here that we're relying on that fact.  That's kind of
the point with assert()s.

>=20
> >>> +    /* Don't allow the guest to use pages bigger than the configured
> >>> +     * maximum size */
> >>> +    if (pshift > maxshift) {
> >>> +        return false;
> >>> +    }
> >>> +
> >>> +    /* For whatever reason, KVM doesn't allow multiple pagesizes
> >>> +     * within a segment, *except* for the case of 16M pages in a 4k =
or
> >>> +     * 64k segment.  Always exclude other cases, so that TCG and KVM
> >>> +     * guests see a consistent environment */
> >>> +    if ((pshift !=3D seg_pshift) && (pshift !=3D 24)) {
> >>> +        return false;
> >>> +    }
> >=20
> > Note the stanza above, I'll refer to it below.
>=20
> ok.
>=20
> >=20
> >>> +
> >>> +    return true;
> >>> +}
> >>
> >> So, do we really need ppc_hash64_filter_pagesizes() to have a callback=
 ?=20
> >=20
> > I agree that it seems overly involved, but it was the best way I could
> > see to logically separate the TCG / softmmu specific logic from the
> > spapr specific logic.
>=20
> ok. I agree then.
>=20
> Reviewed-by: C=E9dric Le Goater <clg@kaod.org>
>=20
> Thanks,
>=20
> C.
>=20
> >> It seems that we only use the routine once in the patchset and that the
> >> only thing we need to check is 'maxshift'.
> >=20
> > Not quite.  An earlier draft had this routine just take a max page
> > size and clamp accordingly.  But that failed when I wrote the code to
> > check against the KVM capabilities, because KVM also excludes some
> > other pagesize combinations.  That's what the stanza I point out above
> > is about
> >=20
> >> Do you envision other usage of the routine ?
> >=20
> > Not really, no.
> >=20
> >>
> >> Thanks,
> >>
> >> C.
> >>
> >>> +static void cap_hpt_maxpagesize_cpu_apply(sPAPRMachineState *spapr,
> >>> +                                          PowerPCCPU *cpu,
> >>> +                                          uint8_t val, Error **errp)
> >>> +{
> >>> +    unsigned maxshift =3D val;
> >>> +
> >>> +    ppc_hash64_filter_pagesizes(cpu, spapr_pagesize_cb, &maxshift);
> >>> +}
> >>> +
> >>>  sPAPRCapabilityInfo capability_table[SPAPR_CAP_NUM] =3D {
> >>>      [SPAPR_CAP_HTM] =3D {
> >>>          .name =3D "htm",
> >>> @@ -401,6 +433,7 @@ sPAPRCapabilityInfo capability_table[SPAPR_CAP_NU=
M] =3D {
> >>>          .set =3D spapr_cap_set_pagesize,
> >>>          .type =3D "int",
> >>>          .apply =3D cap_hpt_maxpagesize_apply,
> >>> +        .cpu_apply =3D cap_hpt_maxpagesize_cpu_apply,
> >>>      },
> >>>  };
> >>> =20
> >>>
> >>
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--V88s5gaDVPzZ0KCq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsrrvAACgkQbDjKyiDZ
s5JXhBAAwPcn4MGV6rjfac9MthZ9varZVMtDxJq937Pved8eEiwAn3WZv1fd8XYL
shjeWPFWTAF/dcQaCzAlbJ1ojJtb1Y69B/Ls1Y1HqHlO6HCT8D4vx2DmR129vSrp
RV9TYUj+2FRpaJ71IBREZK8pdDwA5uEYiDYBbFzhvl3r/0hrnajiys3ntCnPZGv+
LuARmgLeRTJCyJYDf9k0bsrshSd6/C5nBj8bxreFKM8kXK0Ltltct7ozpoXTV8Iv
IIMIs4COz/OK2vEsMz1nkJAPCZKz/sC/FsOFTfRlwMWWcmpvahxYDhOUaFCwEXlh
q4sa36lit6nm8teIuXi+Key9v4/eARuxXKbxFnkxzd3hkeNR6iOCxLFHq7X/YIrZ
oGw6ycVn+NhP9kyyZraBNNiJgObiEhbvkAZkaS4tSuNnWF9V6RC9/JmvZEvAb9/f
ipkTJ4J0Ua0xLsdWJX6V1Zsh7dJIQsCnWEyV7DJBu3lksuyovPMSRsJOaijSoJe1
jweAWoz/WEjBjexZS5bgEVSxkmlhUvhjuOc7P3ELKpZWX71hlYMrOKYl9z0y7zWd
LrPi3UmOP7TPA5VFwGM09qGIaq4IsVcRrpJ7ErUb3EeToYt4iaS+9GyNLZ3dvegx
yzjK87UAOWPjUBTc4x72iizyT11ke6glEY7g+sMmcoaUVgXmgZo=
=QYfK
-----END PGP SIGNATURE-----

--V88s5gaDVPzZ0KCq--
