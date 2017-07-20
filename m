Received: from eggs.gnu.org ([2001:4830:134:3::10]:34628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dY20I-0002TF-BS
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 23:19:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dY20H-0002gw-9T
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 23:19:54 -0400
Date: Thu, 20 Jul 2017 13:09:50 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170720030950.GA3140@umbus.fritz.box>
References: <1500454449-29557-1-git-send-email-bharata@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Hch1Uz/zGPcHFdv8"
Content-Disposition: inline
In-Reply-To: <1500454449-29557-1-git-send-email-bharata@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [FIX PATCH] spapr: Fix QEMU abort during memory
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
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--Hch1Uz/zGPcHFdv8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 19, 2017 at 02:24:09PM +0530, Bharata B Rao wrote:
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

Sounds like a reasonable change based on the rationale above.
However, can you add a comment here explaining the situation in which
the entry already exists.

> ---
>  hw/ppc/spapr.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 1cb09e7..990bb2d 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2853,8 +2853,9 @@ static sPAPRDIMMState *spapr_pending_dimm_unplugs_f=
ind(sPAPRMachineState *s,
>  static void spapr_pending_dimm_unplugs_add(sPAPRMachineState *spapr,
>                                             sPAPRDIMMState *dimm_state)
>  {
> -    g_assert(!spapr_pending_dimm_unplugs_find(spapr, dimm_state->dimm));
> -    QTAILQ_INSERT_HEAD(&spapr->pending_dimm_unplugs, dimm_state, next);
> +    if (!spapr_pending_dimm_unplugs_find(spapr, dimm_state->dimm)) {
> +        QTAILQ_INSERT_HEAD(&spapr->pending_dimm_unplugs, dimm_state, nex=
t);
> +    }
>  }
> =20
>  static void spapr_pending_dimm_unplugs_remove(sPAPRMachineState *spapr,

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Hch1Uz/zGPcHFdv8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAllwHvsACgkQbDjKyiDZ
s5KeoA/9FnNN0NTJjgyxLsldWL1JTT+rGpWVuj8dy58ypUSTrjIKLZK+NGTdTwoy
PMBL0GeWeBosHyYFvQA7Vs40ozl+RRZMxdUDm2NOvl1itmXlXdIH4xU0i3X4etyZ
k/mzpFihz5Pgu5ouvKaFwdJdf9UXtNLMgIJ4eX7UKMyJsAotCYx6LJTOAA98xZh2
jQrWATMpCWBq9EJzkzEeY8cvibnIMGV0xqfk7X89BL5e080Cw95rGBnfXGbSQ1IG
oUlj4WZAoPNzvxOrHJYW8f3iGfMGMFfDQWCUfqnkHFxdKRDXS9kLCTIduNtGsNzf
kGag6Lf5MS4rKyg+7VJPXFOnZZnVZ72nZMgQ994Q6RItHzFA73N9oFrs9wJpw5tE
zLqLPZJjSjSl9D7ww1Ng84alHcU71ABpTtuwnyjkQisQaYbq9qr7G97IsXiHlJDb
IXsQKw1HelcnaNQS1KOMQ22R8Sbw4P+Lna4p5eCv9DgCh7xFHUqraAEkaM7SgSE7
P1AeEcscv+Ue0lTNG90jDVX+pFKZrxUXm5ePaF6IIXTXoVXezFCJ7e8HuSLCWM4K
hwLuxuxxCVeAv4aszVFaTRpSrsqvwIdUkLlpxqV/xm8ngWVD+937PS/xEZCXaie8
M9/zF7eXSB+Gl8kWsk6fuNMXki2lVTGf4O8Twwc4ZsYaok6+GHo=
=fNms
-----END PGP SIGNATURE-----

--Hch1Uz/zGPcHFdv8--
