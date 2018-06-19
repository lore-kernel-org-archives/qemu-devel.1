Received: from eggs.gnu.org ([2001:4830:134:3::10]:35794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fV4gE-000400-O7
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 20:39:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fV4gD-0003GS-KU
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 20:39:30 -0400
Date: Tue, 19 Jun 2018 10:39:17 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180619003917.GM25461@umbus.fritz.box>
References: <20180618173402.23405-1-clg@kaod.org>
	<20180618173402.23405-3-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="KHHg66sM3ACL179N"
Content-Disposition: inline
In-Reply-To: <20180618173402.23405-3-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v2 2/3] spapr: remove unused spapr_irq
 routines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--KHHg66sM3ACL179N
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 18, 2018 at 07:34:01PM +0200, C=E9dric Le Goater wrote:
> spapr_irq_alloc_block and spapr_irq_alloc() are now deprecated.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

Applied to ppc-for-3.0, thanks.

> ---
>  include/hw/ppc/spapr.h |  4 ---
>  hw/ppc/spapr.c         | 80 +-------------------------------------------=
------
>  2 files changed, 1 insertion(+), 83 deletions(-)
>=20
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 15f771acc892..9decc66a1915 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -772,10 +772,6 @@ int spapr_get_vcpu_id(PowerPCCPU *cpu);
>  void spapr_set_vcpu_id(PowerPCCPU *cpu, int cpu_index, Error **errp);
>  PowerPCCPU *spapr_find_cpu(int vcpu_id);
> =20
> -int spapr_irq_alloc(sPAPRMachineState *spapr, int irq_hint, bool lsi,
> -                    Error **errp);
> -int spapr_irq_alloc_block(sPAPRMachineState *spapr, int num, bool lsi,
> -                          bool align, Error **errp);
>  int spapr_irq_find(sPAPRMachineState *spapr, int num, bool align,
>                     Error **errp);
>  #define spapr_irq_findone(spapr, errp) spapr_irq_find(spapr, 1, false, e=
rrp)
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 1fa398111111..2b6d17056012 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3846,84 +3846,6 @@ int spapr_irq_find(sPAPRMachineState *spapr, int n=
um, bool align, Error **errp)
>      return first + ics->offset;
>  }
> =20
> -/*
> - * Allocate the IRQ number and set the IRQ type, LSI or MSI
> - */
> -static void spapr_irq_set_lsi(sPAPRMachineState *spapr, int irq, bool ls=
i)
> -{
> -    ics_set_irq_type(spapr->ics, irq - spapr->ics->offset, lsi);
> -}
> -
> -int spapr_irq_alloc(sPAPRMachineState *spapr, int irq_hint, bool lsi,
> -                    Error **errp)
> -{
> -    ICSState *ics =3D spapr->ics;
> -    int irq;
> -
> -    assert(ics);
> -
> -    if (irq_hint) {
> -        if (!ICS_IRQ_FREE(ics, irq_hint - ics->offset)) {
> -            error_setg(errp, "can't allocate IRQ %d: already in use", ir=
q_hint);
> -            return -1;
> -        }
> -        irq =3D irq_hint;
> -    } else {
> -        irq =3D ics_find_free_block(ics, 1, 1);
> -        if (irq < 0) {
> -            error_setg(errp, "can't allocate IRQ: no IRQ left");
> -            return -1;
> -        }
> -        irq +=3D ics->offset;
> -    }
> -
> -    spapr_irq_set_lsi(spapr, irq, lsi);
> -    trace_spapr_irq_alloc(irq);
> -
> -    return irq;
> -}
> -
> -/*
> - * Allocate block of consecutive IRQs, and return the number of the firs=
t IRQ in
> - * the block. If align=3D=3Dtrue, aligns the first IRQ number to num.
> - */
> -int spapr_irq_alloc_block(sPAPRMachineState *spapr, int num, bool lsi,
> -                          bool align, Error **errp)
> -{
> -    ICSState *ics =3D spapr->ics;
> -    int i, first =3D -1;
> -
> -    assert(ics);
> -
> -    /*
> -     * MSIMesage::data is used for storing VIRQ so
> -     * it has to be aligned to num to support multiple
> -     * MSI vectors. MSI-X is not affected by this.
> -     * The hint is used for the first IRQ, the rest should
> -     * be allocated continuously.
> -     */
> -    if (align) {
> -        assert((num =3D=3D 1) || (num =3D=3D 2) || (num =3D=3D 4) ||
> -               (num =3D=3D 8) || (num =3D=3D 16) || (num =3D=3D 32));
> -        first =3D ics_find_free_block(ics, num, num);
> -    } else {
> -        first =3D ics_find_free_block(ics, num, 1);
> -    }
> -    if (first < 0) {
> -        error_setg(errp, "can't find a free %d-IRQ block", num);
> -        return -1;
> -    }
> -
> -    first +=3D ics->offset;
> -    for (i =3D first; i < first + num; ++i) {
> -        spapr_irq_set_lsi(spapr, i, lsi);
> -    }
> -
> -    trace_spapr_irq_alloc_block(first, num, lsi, align);
> -
> -    return first;
> -}
> -
>  int spapr_irq_claim(sPAPRMachineState *spapr, int irq, bool lsi, Error *=
*errp)
>  {
>      ICSState *ics =3D spapr->ics;
> @@ -3940,7 +3862,7 @@ int spapr_irq_claim(sPAPRMachineState *spapr, int i=
rq, bool lsi, Error **errp)
>          return -1;
>      }
> =20
> -    spapr_irq_set_lsi(spapr, irq, lsi);
> +    ics_set_irq_type(ics, irq - ics->offset, lsi);
>      return 0;
>  }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--KHHg66sM3ACL179N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsoULUACgkQbDjKyiDZ
s5JMAhAAmQHzRzk89mgOhQckiCTP030Viys3NPoNAE7Dtmd/8XlIA6asSSIpZtty
JstmHGljbAueUbRwTFb8X1Xo6r1ZH5bmk1wsDRvP5DVqZm/JqDxDisAhAvBarbCs
YzJMraLg7AhYAI3CeQY6Td/qT65Reax8NPtH3d8CghzaeRzmH6zcmjKiZpHYyqqm
MkV9V21hVHPYQzX6b2K9OnDhxtddqAsxYT6oIKbNX6FuCKP3u2krRZSB9wRSxzCc
6ICGS78352tcbxjXPqzZZW1AIp0iqXpImg9kJ3b2V4daZr70sK1O0nz/B69BbGWF
0KNw4pd0q+hf32tIUSVU2WpOR+Qmku19eLmflbkd1sdfswD/ptevsAhhvoJnRvv9
KI4YJVthbk5m5pli5M5s7uUyPkrpv66jlF+OhwXu+1RP3pSaukurGzLu4wfpo86U
73oy7/n/njzDPiZusF2DvhADvk6csCTRRxF6b1j0d4QTuhG3uVRGySXcagM99l2B
bsUSxsQslMJb9bgPwVy0q4PKohE6EoPJEVnnccLCrw0Y+d+ADrD0G9KoSyr/ie7e
K7pIcnA2uqAupJ3OxQkZZsCMGoht4OIOKLGuKsY/apV8ZMtQSzN9b/+MRWIAiWTa
JRuVsRcj1eVQlo61YNaNk/PK2Y9le7XyCo/6Z2OLHhk/zIB2tI4=
=qpGR
-----END PGP SIGNATURE-----

--KHHg66sM3ACL179N--
