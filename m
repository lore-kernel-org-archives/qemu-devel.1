Received: from eggs.gnu.org ([2001:4830:134:3::10]:51154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fUlLR-0003Ia-Gn
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 00:00:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fUlLO-0002ai-Eq
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 00:00:45 -0400
Date: Mon, 18 Jun 2018 14:00:26 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180618040026.GT25461@umbus.fritz.box>
References: <20180615115303.31125-1-clg@kaod.org>
	<20180615115303.31125-3-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9r3HF47jptiQlX4s"
Content-Disposition: inline
In-Reply-To: <20180615115303.31125-3-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 2/3] spapr: remove unused spapr_irq routines
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


--9r3HF47jptiQlX4s
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 15, 2018 at 01:53:02PM +0200, C=E9dric Le Goater wrote:
> spapr_irq_alloc_block and spapr_irq_alloc() are now deprecated.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  include/hw/ppc/spapr.h |  4 ---
>  hw/ppc/spapr.c         | 80 +-------------------------------------------=
------
>  2 files changed, 1 insertion(+), 83 deletions(-)
>=20
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 6088f44c1b2a..49cda04b1493 100644
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
> index b1d19b328166..c464951747e3 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3840,84 +3840,6 @@ int spapr_irq_find(sPAPRMachineState *spapr, int n=
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
>  int spapr_irq_claim(sPAPRMachineState *spapr, int irq, int num, bool lsi,
>                      Error **errp)
>  {
> @@ -3934,7 +3856,7 @@ int spapr_irq_claim(sPAPRMachineState *spapr, int i=
rq, int num, bool lsi,
> =20
>      for (i =3D srcno; i < srcno + num; ++i) {
>          if (ICS_IRQ_FREE(ics, i)) {
> -            spapr_irq_set_lsi(spapr, i + ics->offset, lsi);
> +            ics_set_irq_type(ics, i, lsi);
>          } else {
>              error_setg(errp, "IRQ %d is not free", i + ics->offset);
>              ret =3D -1;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--9r3HF47jptiQlX4s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsnLloACgkQbDjKyiDZ
s5J+cg/8DQaczNKXqr0mKm3y2UEuIWCVg7uC4E2pE1zR/L1x5mURigRATk/nPrnm
3t5dDkpY9VZDA8nPD2xAxRjdT7SoJqISPT3V1mA+ffdzN0OeeFOf+CdOjfRMbY6W
bgOMgCvXtZPAd6yYGLkoD9mL0uSqnSim44qsFGS5Epl2bCB/xDvtVqyDWGnIp4GH
VjCNH0y8QZh+C6J9atIojgP/Nu8XWlNzpCIe6ZDg3DZ/7cOxBkHWYHwLkimk7H39
a7r+dZC7HAHkP+1qIsClxFeCYBn+foLSH7jltaiR5I+MJkjJAEkhO0VFAkxpLl+K
azTnDYnLHScco4yxd43r9ofWWQWBvxAVX0vMyfZ0UMM0lY2YMr0WUMVsIkf8XBoL
7sHgphSICGRnEGTki7OiZFlfoFKtv/WCEI/EIW6OqGMgVbWwFG0J3cnkCoSRTpX0
o7PARFPgTgmbhc4op6UZ4DAJap36jGHH4Hp+ZaECzsXMe/IvrLUbrqosnO7mSdde
BAUKrf9U7IsULwKfZjA8I7jwXxM/jNp8ByD5BHMsEQ9WG4SW97hF6UcbcwlgV0EQ
dsH+7Xhcjf0oLuZsM5QbQ9UeQf2y4p2Pmg4l7ifj7cXCzXvAotDcuAm7BZ5s6KL5
wVyz2b1eeJ41/luxnadlKr2Aj0bIJvenCzxF3zs3jozCCNmxe7Q=
=tZFs
-----END PGP SIGNATURE-----

--9r3HF47jptiQlX4s--
