Received: from eggs.gnu.org ([2001:4830:134:3::10]:60612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dYSDI-0004Ja-Ou
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 03:19:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dYSDH-0008S3-9k
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 03:19:04 -0400
Date: Fri, 21 Jul 2017 16:57:36 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170721065736.GD3717@umbus.fritz.box>
References: <1500612666-19521-1-git-send-email-bharata@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mSxgbZZZvrAyzONB"
Content-Disposition: inline
In-Reply-To: <1500612666-19521-1-git-send-email-bharata@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [FIX PATCH v2] spapr: Fix QEMU abort during memory
 unplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bharata B Rao <bharata@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, danielhb@linux.vnet.ibm.com


--mSxgbZZZvrAyzONB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 21, 2017 at 10:21:06AM +0530, Bharata B Rao wrote:
> Commit 0cffce56 (hw/ppc/spapr.c: adding pending_dimm_unplugs to
> sPAPRMachineState) introduced a new way to track pending LMBs of DIMM
> device that is marked for removal. Since this commit we can hit the
> assert in spapr_pending_dimm_unplugs_add() in the following situation:
>=20
> - DIMM device removal fails as the guest doesn't allow the removal.
> - Subsequent attempt to remove the same DIMM would hit the assert
>   as the corresponding sPAPRDIMMState is still part of the
>   pending_dimm_unplugs list.
>=20
> Fix this by removing the assert and conditionally adding the
> sPAPRDIMMState to pending_dimm_unplugs list only when it is not
> already present.
>=20
> Fixes: 0cffce56ae3501c5783d779f97993ce478acf856
> Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>

Applied to ppc-for-2.10.

> ---
> Changes in v2:
> - sPAPRDIMMState is now allocated within spapr_pending_dimm_unplugs_add()
>   itself (David Gibson)
> - spapr_recover_pending_dimm_state() should never return a NULL sPAPRDIMM=
State,
>   added an assert for the same.
>=20
>  hw/ppc/spapr.c | 37 +++++++++++++++++++++----------------
>  1 file changed, 21 insertions(+), 16 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 1cb09e7..2465b27 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2850,11 +2850,25 @@ static sPAPRDIMMState *spapr_pending_dimm_unplugs=
_find(sPAPRMachineState *s,
>      return dimm_state;
>  }
> =20
> -static void spapr_pending_dimm_unplugs_add(sPAPRMachineState *spapr,
> -                                           sPAPRDIMMState *dimm_state)
> +static sPAPRDIMMState *spapr_pending_dimm_unplugs_add(sPAPRMachineState =
*spapr,
> +                                                      uint32_t nr_lmbs,
> +                                                      PCDIMMDevice *dimm)
>  {
> -    g_assert(!spapr_pending_dimm_unplugs_find(spapr, dimm_state->dimm));
> -    QTAILQ_INSERT_HEAD(&spapr->pending_dimm_unplugs, dimm_state, next);
> +    sPAPRDIMMState *ds =3D NULL;
> +
> +    /*
> +     * If this request is for a DIMM whose removal had failed earlier
> +     * (due to guest's refusal to remove the LMBs), we would have this
> +     * dimm already in the pending_dimm_unplugs list. In that
> +     * case don't add again.
> +     */
> +    if (!spapr_pending_dimm_unplugs_find(spapr, dimm)) {
> +        ds =3D g_malloc0(sizeof(sPAPRDIMMState));
> +        ds->nr_lmbs =3D nr_lmbs;
> +        ds->dimm =3D dimm;
> +        QTAILQ_INSERT_HEAD(&spapr->pending_dimm_unplugs, ds, next);
> +    }
> +    return ds;
>  }
> =20
>  static void spapr_pending_dimm_unplugs_remove(sPAPRMachineState *spapr,
> @@ -2875,7 +2889,6 @@ static sPAPRDIMMState *spapr_recover_pending_dimm_s=
tate(sPAPRMachineState *ms,
>      uint32_t avail_lmbs =3D 0;
>      uint64_t addr_start, addr;
>      int i;
> -    sPAPRDIMMState *ds;
> =20
>      addr_start =3D object_property_get_int(OBJECT(dimm), PC_DIMM_ADDR_PR=
OP,
>                                           &error_abort);
> @@ -2891,11 +2904,7 @@ static sPAPRDIMMState *spapr_recover_pending_dimm_=
state(sPAPRMachineState *ms,
>          addr +=3D SPAPR_MEMORY_BLOCK_SIZE;
>      }
> =20
> -    ds =3D g_malloc0(sizeof(sPAPRDIMMState));
> -    ds->nr_lmbs =3D avail_lmbs;
> -    ds->dimm =3D dimm;
> -    spapr_pending_dimm_unplugs_add(ms, ds);
> -    return ds;
> +    return spapr_pending_dimm_unplugs_add(ms, avail_lmbs, dimm);
>  }
> =20
>  /* Callback to be called during DRC release. */
> @@ -2911,6 +2920,7 @@ void spapr_lmb_release(DeviceState *dev)
>       * during the unplug process. In this case recover it. */
>      if (ds =3D=3D NULL) {
>          ds =3D spapr_recover_pending_dimm_state(spapr, PC_DIMM(dev));
> +        g_assert(ds);
>          /* The DRC being examined by the caller at least must be counted=
 */
>          g_assert(ds->nr_lmbs);
>      }
> @@ -2942,18 +2952,13 @@ static void spapr_memory_unplug_request(HotplugHa=
ndler *hotplug_dev,
>      uint64_t addr_start, addr;
>      int i;
>      sPAPRDRConnector *drc;
> -    sPAPRDIMMState *ds;
> -
>      addr_start =3D object_property_get_uint(OBJECT(dimm), PC_DIMM_ADDR_P=
ROP,
>                                           &local_err);
>      if (local_err) {
>          goto out;
>      }
> =20
> -    ds =3D g_malloc0(sizeof(sPAPRDIMMState));
> -    ds->nr_lmbs =3D nr_lmbs;
> -    ds->dimm =3D dimm;
> -    spapr_pending_dimm_unplugs_add(spapr, ds);
> +    spapr_pending_dimm_unplugs_add(spapr, nr_lmbs, dimm);
> =20
>      addr =3D addr_start;
>      for (i =3D 0; i < nr_lmbs; i++) {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--mSxgbZZZvrAyzONB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAllxpeAACgkQbDjKyiDZ
s5J7PxAAl3F6IeQ8EE1WX9WKE2ggbYOaTRYWonXX/wmbIxLmU+6c6lQllUS0aaLv
LUtnJwsdkE7GjyN4/f8uDa/ZYGQ7sVcOvO0mWFLLrJVuAmbdXXckGFVuN8Carenb
RBCL9rwlXxBTbt3qrC8qAqfoFGLrJCBl/vMKjWSfhI5251mPj7Y9FjGzneu1DneK
+CTJzEn0yU+a4bkCGtTebhNdOe4qXNNM5Ff3W7js0MPHkzpGUinI++Do5lX48FBm
c6D9RhvxAsmX487EczWYZM/wQ3t9Iz3AqBYP1KqHphVtq6Lmd9JqJOLLMF2fwTPm
sdnt+lMmiKd1IGoNhLGxb6wkMeeZV3MIQPfMhron+1dND6lWQLC4XIRLLroHHuIO
3dcAr866ElidX3IHRfN0jelkBZ2NT3d/niDcUIPCMAG1zIY2swaCxofN/ere53Kf
6r53y6V3viTkpiA2Fq/pDVEKgmXK431ji2gNhhH0KQDPHG7sD/jjqkazAxjvA378
nfrsODxXvUuCyJ+1zeRoRRoqI22jAiDtlMoviW6xApACynzs5bOAs+1oksc9nhMJ
ekhRdqsu6/eIa1i+ZDo63KK42lyjStwI8R16Nb2OSrs8DUqK/E+ScZN4Y1aIQqQ8
ppcrvYZikUXsHlmoKIRBOo3/i2Gl9779gfgNn7qNBz6HgdKtAGg=
=vQ/g
-----END PGP SIGNATURE-----

--mSxgbZZZvrAyzONB--
