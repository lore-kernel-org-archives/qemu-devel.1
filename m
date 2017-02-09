Received: from eggs.gnu.org ([2001:4830:134:3::10]:46761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cbepp-0007cV-LN
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 21:51:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cbepn-0006yh-R4
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 21:51:49 -0500
Date: Thu, 9 Feb 2017 13:24:09 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170209022409.GS17644@umbus.fritz.box>
References: <cover.1486436185.git.sam.bobroff@au1.ibm.com>
	<f04bb6a57aa50c7c75762e3479252f2ee3fa385a.1486436186.git.sam.bobroff@au1.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="JWOY2/vB4uO4FuME"
Content-Disposition: inline
In-Reply-To: <f04bb6a57aa50c7c75762e3479252f2ee3fa385a.1486436186.git.sam.bobroff@au1.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH 5/9] spapr: Only setup HTP if necessary.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sam Bobroff <sam.bobroff@au1.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--JWOY2/vB4uO4FuME
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 07, 2017 at 01:56:48PM +1100, Sam Bobroff wrote:
> Because KVM cannot support radix and hash modes concurrently, QEMU can
> avoid allocating a hash page table if KVM supports radix mode.
>=20
> Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>

This isn't quite right, it's doing the HPT handling based on whether
or not we *can* do RPT rather than whether we *are* doing RPT.

It'll mostly work for now, while only radix-on-radix and hash-on-hash
are supported, but that won't be true forever.

It will already be wrong if, for example, you tried to run a POWER8
TCG guest on a host that happened to be a POWER9 in radix mode.

> ---
>  hw/ppc/spapr.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index d629e2630c..1411e470c0 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1150,15 +1150,17 @@ static void ppc_spapr_reset(void)
>      /* Check for unknown sysbus devices */
>      foreach_dynamic_sysbus_device(find_unknown_sysbus_device, NULL);
> =20
> -    /* Allocate and/or reset the hash page table */
> -    spapr_reallocate_hpt(spapr,
> +    if (!kvmppc_has_cap_mmu_radix()) {
> +        /* Allocate and/or reset the hash page table */
> +        spapr_reallocate_hpt(spapr,
>                           spapr_hpt_shift_for_ramsize(machine->maxram_siz=
e),
>                           &error_fatal);
> =20
> -    /* Update the RMA size if necessary */
> -    if (spapr->vrma_adjust) {
> -        spapr->rma_size =3D kvmppc_rma_size(spapr_node0_size(),
> -                                          spapr->htab_shift);
> +        /* Update the RMA size if necessary */
> +        if (spapr->vrma_adjust) {
> +            spapr->rma_size =3D kvmppc_rma_size(spapr_node0_size(),
> +                                              spapr->htab_shift);
> +        }
>      }
> =20
>      qemu_devices_reset();

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--JWOY2/vB4uO4FuME
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYm9LJAAoJEGw4ysog2bOSTOAQALQBgFv+UNyirOsxJposJL6C
i+9x6LjBs+sYhF++PjKAT76Ijsh7DNhi2f466WLroUkd1/1Jz3dWa1ctlDCKUjOe
69tjOBc91KL/p2eyoVNg1X/1Hwu9Hq6auVRZt7Zxzq2L/h3XqtYFU/XqIRcRCZKK
iG/DKezO3XJsjN4FBZU7H0UZQdn5z2RE3g/zsVKqm2gBepMqDyns+TUNFoxawsrp
Hm6ljo7MupMIosPMDMOZUyHjCRDDh4e3UQxVNzevnnBhm6wEU5W/RFKvDnQFjKMM
f4/MHA7+nojvFBVBrL2itCgpfZbQQCwpgJ4ccvFBZnOk0JDltZtQ6ws1Nt9WjIxY
oNH3Pa7CdAnufpp1FV0fOp7AQGq/e+3T+q8WnWYYSD3YzrP4fK74p502Zk3sEwqK
hhTDoild1SuI/kvk6uR1oHbOV8Ofpss7q9C+XEnqqqR7/v4/nevVg+l9wVAI/wor
Mrj6bryK/US2H1wZgY46cVZ7E0z4Chlzn7APKDAZ9a+y9dsgA/MSoogToWtr4tuR
TFmSoN9JAsf5d/IXnBcxmGkBpDChX25gmJQQaKCUARRfr8Shyg3YdLIdDxfoR9uq
GsPQXKGfxtQ4OE43ps+bcHP0EWUhERPdEhLg81Aw8EQjBDSx/6rG3Xv7o30sOhQs
BFVBnyKsiLem2lP5zjj2
=9rj1
-----END PGP SIGNATURE-----

--JWOY2/vB4uO4FuME--
