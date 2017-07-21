Received: from eggs.gnu.org ([2001:4830:134:3::10]:51558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dYN0W-0002NP-GW
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 21:45:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dYN0S-0007rw-Iz
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 21:45:32 -0400
Date: Fri, 21 Jul 2017 11:45:13 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170721014513.GB3717@umbus.fritz.box>
References: <1500523879-23860-1-git-send-email-bharata@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OwLcNYc0lM97+oe1"
Content-Disposition: inline
In-Reply-To: <1500523879-23860-1-git-send-email-bharata@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [FIX PATCH v1] spapr: Fix QEMU abort during memory
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


--OwLcNYc0lM97+oe1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 20, 2017 at 09:41:19AM +0530, Bharata B Rao wrote:
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
> ---
> Changes in v1:
> - Added comment (David Gibson)
> - Ensured we free sPAPRDIMMState when corresonding entry already
>   exists (Daniel Henrique Barboza)
>=20
> Daniel had shown another alternative, we can switch over to that
> if preferred.
>=20
>  hw/ppc/spapr.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 1cb09e7..c6091e2 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2853,8 +2853,17 @@ static sPAPRDIMMState *spapr_pending_dimm_unplugs_=
find(sPAPRMachineState *s,
>  static void spapr_pending_dimm_unplugs_add(sPAPRMachineState *spapr,
>                                             sPAPRDIMMState *dimm_state)
>  {
> -    g_assert(!spapr_pending_dimm_unplugs_find(spapr, dimm_state->dimm));
> -    QTAILQ_INSERT_HEAD(&spapr->pending_dimm_unplugs, dimm_state, next);
> +    /*
> +     * If this request is for a DIMM whose removal had failed earlier
> +     * (due to guest's refusal to remove the LMBs), we would have this
> +     * dimm_state already in the pending_dimm_unplugs list. In that
> +     * case don't add again.
> +     */
> +    if (!spapr_pending_dimm_unplugs_find(spapr, dimm_state->dimm)) {
> +        QTAILQ_INSERT_HEAD(&spapr->pending_dimm_unplugs, dimm_state, nex=
t);
> +    } else {
> +        g_free(dimm_state);

This is dangerous.  You're freeing a pointer passed in by the caller
under conditions that the caller can't know, so it can't know if it
has a valid pointer afterwards or not.

It so happens that we don't use the pointer again from the caller in
spapr_memory_unplug_request() and I suspect this situation can't
occur for the call in spapr_recover_pending_dimm_state().  Still,
that's way more subtle that I'm comfortable with.

I think the way to handle this is to change unplugs_add() so that it
takes the relevant fields of the DIMMState rather than a pre-allocated
structure.  It will then return either an existing state if available
or a newly allocated and indexed one otherwise.

> +    }
>  }
> =20
>  static void spapr_pending_dimm_unplugs_remove(sPAPRMachineState *spapr,

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--OwLcNYc0lM97+oe1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAllxXKYACgkQbDjKyiDZ
s5KNUQ/9Ht48qn9uwgLYPTSkEf2m46OHpZ654oCFTeKyJe+Hy9OLMNSuGWwi565q
6Ss/cd3ewFkR1wPGFs2BrX1kNrF4SozRztGfUemfc81zQidMByiE2YaNz4d8O2UO
NPRgSqcJsfIwrO8P5XSHU6FKVk3jj7wHMJYQLrKP7QLXPXLXJML/EaxRGBxEwZnw
y8g6YONc5An6BVma/CloQ21gArG3vcs/2PkkFzBXU/7y6VQEfRweDFRjxluA2vJF
LK+wNjALOCOLuAwSEjgmomcS/5tgCL2zp5KlSv40P2QtK2Sj4o+gD5mcVxnhQUKC
N+W4stFC8CbRWskF/8sX+SdYq7CNWGxjnGNAVBAViKZwQlexq0w4wIaQgQzHJAdM
XYbldYYmjFXDaj3VwaA8NmwKdMfcV56HuNLfiGl1SgWHhj0C2dkjWhBljUJTPUn2
YHLytOidp/wbPwIFosMdVXIhGcXtbdxOssOIvMUqZIN1Het2AlskbhYYG5ifsB/R
bWHASES8rYIojjUs4Fm7q84jk6IPdIeBqTxTiSdIhwyFKjZdldxgoE3uUL10OSv6
7oq8lAQU6k1kwN0hkheH/ZbhlX1kyT9sNIDTt/Kju+FfJI5GxT2tBJ9r6JQ3hduJ
Io5RgZhyOmHcbvNQUvmX2yJDI/o6hAYjs8XPgACwlJ+UjAGEYSM=
=ZcVH
-----END PGP SIGNATURE-----

--OwLcNYc0lM97+oe1--
