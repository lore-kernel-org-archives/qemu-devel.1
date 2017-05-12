Received: from eggs.gnu.org ([2001:4830:134:3::10]:47817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d94R4-0005fB-MK
	for qemu-devel@nongnu.org; Fri, 12 May 2017 02:52:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d94R0-0006nU-Iq
	for qemu-devel@nongnu.org; Fri, 12 May 2017 02:52:22 -0400
Date: Fri, 12 May 2017 16:12:24 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170512061224.GH12908@umbus.fritz.box>
References: <20170505204746.14116-1-danielhb@linux.vnet.ibm.com>
	<20170505204746.14116-5-danielhb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wayzTnRSUXKNfBqd"
Content-Disposition: inline
In-Reply-To: <20170505204746.14116-5-danielhb@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v9 4/6] hw/ppc/spapr.c: migrate
 pending_dimm_unplugs of spapr state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, mdroth@linux.vnet.ibm.com


--wayzTnRSUXKNfBqd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 05, 2017 at 05:47:44PM -0300, Daniel Henrique Barboza wrote:
> To allow for a DIMM unplug event to resume its work if a migration
> occurs in the middle of it, this patch migrates the non-empty
> pending_dimm_unplugs QTAILQ that stores the DIMM information
> that the spapr_lmb_release() callback uses.
>=20
> It was considered an apprach where the DIMM states would be restored
> on the post-_load after a migration. The problem is that there is
> no way of knowing, from the sPAPRMachineState, if a given DIMM is going
> through an unplug process and the callback needs the updated DIMM State.
>=20
> We could migrate a flag indicating that there is an unplug event going
> on for a certain DIMM, fetching this information from the start of the
> spapr_del_lmbs call. But this would also require a scan on post_load to
> figure out how many nr_lmbs are left. At this point we can just
> migrate the nr_lmbs information as well, given that it is being calculated
> at spapr_del_lmbs already, and spare a scanning/discovery in the
> post-load. All that we need is inside the sPAPRDIMMState structure
> that is added to the pending_dimm_unplugs queue at the start of the
> spapr_del_lmbs, so it's convenient to just migrated this queue it if it's
> not empty.
>=20
> Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>

NACK.

As I believe I suggested previously, you can reconstruct this state on
the receiving side by doing a full scan of the DIMM and LMB DRC states.

> ---
>  hw/ppc/spapr.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index e190eb9..30f0b7b 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1437,6 +1437,36 @@ static bool version_before_3(void *opaque, int ver=
sion_id)
>      return version_id < 3;
>  }
> =20
> +static bool spapr_pending_dimm_unplugs_needed(void *opaque)
> +{
> +    sPAPRMachineState *spapr =3D (sPAPRMachineState *)opaque;
> +    return !QTAILQ_EMPTY(&spapr->pending_dimm_unplugs);
> +}
> +
> +static const VMStateDescription vmstate_spapr_dimmstate =3D {
> +    .name =3D "spapr_dimm_state",
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_UINT64(addr, sPAPRDIMMState),
> +        VMSTATE_UINT32(nr_lmbs, sPAPRDIMMState),
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
> +static const VMStateDescription vmstate_spapr_pending_dimm_unplugs =3D {
> +    .name =3D "spapr_pending_dimm_unplugs",
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .needed =3D spapr_pending_dimm_unplugs_needed,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_QTAILQ_V(pending_dimm_unplugs, sPAPRMachineState, 1,
> +                         vmstate_spapr_dimmstate, sPAPRDIMMState,
> +                         next),
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
>  static bool spapr_ov5_cas_needed(void *opaque)
>  {
>      sPAPRMachineState *spapr =3D opaque;
> @@ -1535,6 +1565,7 @@ static const VMStateDescription vmstate_spapr =3D {
>      .subsections =3D (const VMStateDescription*[]) {
>          &vmstate_spapr_ov5_cas,
>          &vmstate_spapr_patb_entry,
> +        &vmstate_spapr_pending_dimm_unplugs,
>          NULL
>      }
>  };

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--wayzTnRSUXKNfBqd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZFVJIAAoJEGw4ysog2bOSBhEP+gL4tKuD9c3xUIrw8zkF6ZN2
xqYKmLYyNXc4s7HEajLVz5+ayg2UB6hCTWjMLHstLnc5MmgggtdNnePRE12W8Cfb
gXaoAXpIxpFsKa0xgXFbmHGjCbb5sycUQnT2H8jhPcTNTvwNZ5xx9PtBUnKyD9St
nWE2hhipQGbbiRJk2pyCv4hqss+EgjXlJUQrJ5hZBlr5W4y9RMYrHZGH04+BiUz2
TRSxo7B4hZSOlpXO+D/+0Ql06uXX4V5VaG4HC1Baoal0bgljcF3F99gBYQ92dqY7
xj9042pTbp+i87OTfOaGQ6CCcE1UW2AfL7tSBQj/x8qArSMseU4QwMLASiTT4V5C
v8Daw2hbDaKbaqKi166csbMZLUyiWzw0Nek6lRSXLuSohulKO8rVQRe/DFCmAlAr
H+HStdqqeWN2NRlc/POh3h7whPxBxtl913SDu8diLMMsQU5ISQ04KOTerUOBDAK7
PamH4X8CX8jl/4rIkoD/1QYsvcIj2EzZD/vJvGlephWvlYTOhmZlW+n7EGz80XVT
BXQ7wzg5PPHB1CKn1PeZh2r64SeuiSTy9cGOuV/MWuyrkRT9qD1n7tbkJYnTOPqf
VFIJmdoj+QEZl4EVSE3K0C1PC2ZVi1kDrCftsXzmPmX3TtrrFL4jtpHX8vH2PbWw
g7mLHySat1A1L5f7aUm2
=vO6t
-----END PGP SIGNATURE-----

--wayzTnRSUXKNfBqd--
