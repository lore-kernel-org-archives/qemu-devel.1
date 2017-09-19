Received: from eggs.gnu.org ([2001:4830:134:3::10]:51292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1duFtZ-0001HF-Hp
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 06:36:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1duFtT-0002rm-9i
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 06:36:49 -0400
Date: Tue, 19 Sep 2017 17:53:00 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170919075300.GQ27153@umbus>
References: <20170911171235.29331-1-clg@kaod.org>
	<20170911171235.29331-14-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8RsyD0KswhpoK73Z"
Content-Disposition: inline
In-Reply-To: <20170911171235.29331-14-clg@kaod.org>
Subject: Re: [Qemu-devel] [RFC PATCH v2 13/21] ppc/xive: handle interrupt
 acknowledgment by the O/S
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, Alexander Graf <agraf@suse.de>


--8RsyD0KswhpoK73Z
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 11, 2017 at 07:12:27PM +0200, C=E9dric Le Goater wrote:
> When an O/S Exception is raised, the O/S acknowledges the interrupt
> with a special read in the TIMA. If the EO bit of the Notification
> Source Register (NSR) is set (and it should), the Current Processor
> Priority Register (CPPR) takes the value of the Pending Interrupt
> Priority Register (PIPR), which contains the priority of the most
> favored pending notification. The bit number corresponding to the
> priority of the pending interrupt is reseted in the Interrupt Pending
> Buffer (IPB) and so is the EO bit of the NSR.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>  hw/intc/spapr_xive.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> index e5d4b723b7e0..ad3ff91b13ea 100644
> --- a/hw/intc/spapr_xive.c
> +++ b/hw/intc/spapr_xive.c
> @@ -50,7 +50,24 @@ static uint8_t ipb_to_pipr(uint8_t ibp)
> =20
>  static uint64_t spapr_xive_icp_accept(ICPState *icp)
>  {
> -    return 0;
> +    uint8_t nsr =3D icp->tima_os[TM_NSR];
> +
> +    qemu_irq_lower(icp->output);

Ah, here's the lower.  This should not be in a different patch from
the matching raise.  Plus, this doesn't seem right.  Shouldn't this
recheck the CPPR against the PIPR, in case a higher priority irq has
been delivered since the one the cpu is acking.

> +    if (icp->tima_os[TM_NSR] & TM_QW1_NSR_EO) {
> +        uint8_t cppr =3D icp->tima_os[TM_PIPR];
> +
> +        icp->tima_os[TM_CPPR] =3D cppr;
> +
> +        /* Reset the pending buffer bit */
> +        icp->tima_os[TM_IPB] &=3D ~priority_to_ipb(cppr);
> +        icp->tima_os[TM_PIPR] =3D ipb_to_pipr(icp->tima_os[TM_IPB]);
> +
> +        /* Drop Exception bit for OS */
> +        icp->tima_os[TM_NSR] &=3D ~TM_QW1_NSR_EO;
> +    }
> +
> +    return (nsr << 8) | icp->tima_os[TM_CPPR];
>  }
> =20
>  static void spapr_xive_icp_notify(ICPState *icp)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--8RsyD0KswhpoK73Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnAzNsACgkQbDjKyiDZ
s5KG4BAAoNJI8LwvsSYGCMvYzW+HtFACKoK9BaxedzHOnFha0K9LzdfIBPHJdwSA
kH1rhmZTEGoaQI3aBaeit5VgGXI+UOjbNeGvZDoBHF1cQdp4NOoGRh97lSmPmSQK
uFjsbCnqoMcH3ztkdHBn+SwHAX7SfaTrrYs+zaY/ycNjk+A6Fn+iVz9hMZptY+W8
PM8adlUAL65En+EDP+rlv2hLELQ89FPDBx451AT4VoT8h971E1ShgYzAPYu0qpVE
oNn0GaUCTF+aAZ3QHpUnpYfxAVbwSd20+rWSROXf0QUB1k/pypsCBYbJU930q+k1
GV+mnCkjeWGKZygIQbPfQAjn4P1spgCUaqrB+6f5ptaVzjqsz4pPj90/mb1tVf6g
qmInc8gg4E55N7zybc1LQXxqpUpSlV2muvO8A/hbe3GeWd5aPkGE0vogiQphnOI3
F0gmLRb+5/A0oQPv2/Dj830fQ0xih6GB/Zy0Y2Lgg48vio0YA2YF/VQn1isdfvnk
npmocmJHGStpT+AzWipCzRigZsq3piHqvtPFdGeSVaKMm8QFBrJqMk3k3KqvVydn
TuCLFR4FxUuBBAb/p7OW4If5gCQHmnD5XQoi1T4B4qTZWq05JY3IvRz7aK6NlTun
hsfzrDfnGzE2s9yhQTCnPTRwKhfB8HPUwSASPKzOlGPXGAi1PtE=
=m1/T
-----END PGP SIGNATURE-----

--8RsyD0KswhpoK73Z--
