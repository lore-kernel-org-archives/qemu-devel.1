Received: from eggs.gnu.org ([2001:4830:134:3::10]:35758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gV7BK-0001hP-8g
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 22:52:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gV7BF-0004pE-8P
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 22:52:02 -0500
Date: Fri, 7 Dec 2018 14:27:55 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181207032755.GA768@umbus.fritz.box>
References: <20181205232251.10446-1-clg@kaod.org>
	<20181205232251.10446-10-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zOhrINIRDRtNKIHr"
Content-Disposition: inline
In-Reply-To: <20181205232251.10446-10-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v6 09/37] ppc/xive: notify the CPU when the
 interrupt priority is more privileged
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>


--zOhrINIRDRtNKIHr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 06, 2018 at 12:22:23AM +0100, C=E9dric Le Goater wrote:
> After the event data was enqueued in the O/S Event Queue, the IVPE
> raises the bit corresponding to the priority of the pending interrupt
> in the register IBP (Interrupt Pending Buffer) to indicate there is an
> event pending in one of the 8 priority queues. The Pending Interrupt
> Priority Register (PIPR) is also updated using the IPB. This register
> represent the priority of the most favored pending notification.
>=20
> The PIPR is then compared to the the Current Processor Priority
> Register (CPPR). If it is more favored (numerically less than), the
> CPU interrupt line is raised and the EO bit of the Notification Source
> Register (NSR) is updated to notify the presence of an exception for
> the O/S. The check needs to be done whenever the PIPR or the CPPR are
> changed.
>=20
> The O/S acknowledges the interrupt with a special load in the Thread
> Interrupt Management Area. If the EO bit of the NSR is set, the CPPR
> takes the value of PIPR. The bit number in the IBP corresponding to
> the priority of the pending interrupt is reseted and so is the EO bit
> of the NSR.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/intc/xive.c | 94 +++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 93 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index 891542920683..0db77107ab15 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -22,9 +22,73 @@
>   * XIVE Thread Interrupt Management context
>   */
> =20
> +/* Convert a priority number to an Interrupt Pending Buffer (IPB)
> + * register, which indicates a pending interrupt at the priority
> + * corresponding to the bit number
> + */
> +static uint8_t priority_to_ipb(uint8_t priority)
> +{
> +    return priority > XIVE_PRIORITY_MAX ?
> +        0 : 1 << (XIVE_PRIORITY_MAX - priority);
> +}
> +
> +/* Convert an Interrupt Pending Buffer (IPB) register to a Pending
> + * Interrupt Priority Register (PIPR), which contains the priority of
> + * the most favored pending notification.
> + */
> +static uint8_t ipb_to_pipr(uint8_t ibp)
> +{
> +    return ibp ? clz32((uint32_t)ibp << 24) : 0xff;
> +}
> +
> +static void ipb_update(uint8_t *regs, uint8_t priority)
> +{
> +    regs[TM_IPB] |=3D priority_to_ipb(priority);
> +    regs[TM_PIPR] =3D ipb_to_pipr(regs[TM_IPB]);
> +}
> +
> +static uint8_t exception_mask(uint8_t ring)
> +{
> +    switch (ring) {
> +    case TM_QW1_OS:
> +        return TM_QW1_NSR_EO;
> +    default:
> +        g_assert_not_reached();
> +    }
> +}
> +
>  static uint64_t xive_tctx_accept(XiveTCTX *tctx, uint8_t ring)
>  {
> -    return 0;
> +    uint8_t *regs =3D &tctx->regs[ring];
> +    uint8_t nsr =3D regs[TM_NSR];
> +    uint8_t mask =3D exception_mask(ring);
> +
> +    qemu_irq_lower(tctx->output);
> +
> +    if (regs[TM_NSR] & mask) {
> +        uint8_t cppr =3D regs[TM_PIPR];
> +
> +        regs[TM_CPPR] =3D cppr;
> +
> +        /* Reset the pending buffer bit */
> +        regs[TM_IPB] &=3D ~priority_to_ipb(cppr);
> +        regs[TM_PIPR] =3D ipb_to_pipr(regs[TM_IPB]);
> +
> +        /* Drop Exception bit */
> +        regs[TM_NSR] &=3D ~mask;
> +    }
> +
> +    return (nsr << 8) | regs[TM_CPPR];
> +}
> +
> +static void xive_tctx_notify(XiveTCTX *tctx, uint8_t ring)
> +{
> +    uint8_t *regs =3D &tctx->regs[ring];
> +
> +    if (regs[TM_PIPR] < regs[TM_CPPR]) {
> +        regs[TM_NSR] |=3D exception_mask(ring);
> +        qemu_irq_raise(tctx->output);
> +    }
>  }
> =20
>  static void xive_tctx_set_cppr(XiveTCTX *tctx, uint8_t ring, uint8_t cpp=
r)
> @@ -34,6 +98,9 @@ static void xive_tctx_set_cppr(XiveTCTX *tctx, uint8_t =
ring, uint8_t cppr)
>      }
> =20
>      tctx->regs[ring + TM_CPPR] =3D cppr;
> +
> +    /* CPPR has changed, check if we need to raise a pending exception */
> +    xive_tctx_notify(tctx, ring);
>  }
> =20
>  /*
> @@ -189,6 +256,17 @@ static void xive_tm_set_os_cppr(XiveTCTX *tctx, hwad=
dr offset,
>      xive_tctx_set_cppr(tctx, TM_QW1_OS, value & 0xff);
>  }
> =20
> +/*
> + * Adjust the IPB to allow a CPU to process event queues of other
> + * priorities during one physical interrupt cycle.
> + */
> +static void xive_tm_set_os_pending(XiveTCTX *tctx, hwaddr offset,
> +                                   uint64_t value, unsigned size)
> +{
> +    ipb_update(&tctx->regs[TM_QW1_OS], value & 0xff);
> +    xive_tctx_notify(tctx, TM_QW1_OS);
> +}
> +
>  /*
>   * Define a mapping of "special" operations depending on the TIMA page
>   * offset and the size of the operation.
> @@ -211,6 +289,7 @@ static const XiveTmOp xive_tm_operations[] =3D {
> =20
>      /* MMIOs above 2K : special operations with side effects */
>      { XIVE_TM_OS_PAGE, TM_SPC_ACK_OS_REG,     2, NULL, xive_tm_ack_os_re=
g },
> +    { XIVE_TM_OS_PAGE, TM_SPC_SET_OS_PENDING, 1, xive_tm_set_os_pending,=
 NULL },
>  };
> =20
>  static const XiveTmOp *xive_tm_find_op(hwaddr offset, unsigned size, boo=
l write)
> @@ -387,6 +466,13 @@ static void xive_tctx_reset(void *dev)
>      tctx->regs[TM_QW1_OS + TM_LSMFB] =3D 0xFF;
>      tctx->regs[TM_QW1_OS + TM_ACK_CNT] =3D 0xFF;
>      tctx->regs[TM_QW1_OS + TM_AGE] =3D 0xFF;
> +
> +    /*
> +     * Initialize PIPR to 0xFF to avoid phantom interrupts when the
> +     * CPPR is first set.
> +     */
> +    tctx->regs[TM_QW1_OS + TM_PIPR] =3D
> +        ipb_to_pipr(tctx->regs[TM_QW1_OS + TM_IPB]);
>  }
> =20
>  static void xive_tctx_realize(DeviceState *dev, Error **errp)
> @@ -1187,9 +1273,15 @@ static void xive_presenter_notify(XiveRouter *xrtr=
, uint8_t format,
>      found =3D xive_presenter_match(xrtr, format, nvt_blk, nvt_idx, cam_i=
gnore,
>                                   priority, logic_serv, &match);
>      if (found) {
> +        ipb_update(&match.tctx->regs[match.ring], priority);
> +        xive_tctx_notify(match.tctx, match.ring);
>          return;
>      }
> =20
> +    /* Record the IPB in the associated NVT structure */
> +    ipb_update((uint8_t *) &nvt.w4, priority);
> +    xive_router_write_nvt(xrtr, nvt_blk, nvt_idx, &nvt, 4);
> +
>      /* If no matching NVT is dispatched on a HW thread :
>       * - update the NVT structure if backlog is activated
>       * - escalate (ESe PQ bits and EAS in w4-5) if escalation is

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--zOhrINIRDRtNKIHr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwJ6LsACgkQbDjKyiDZ
s5KADxAAmHGQ55kq2Q5dwbk4kWLZRoSBl0UrdgtcPgvHQNAyxKyspqLviT+YNbhJ
Pis09TTisp3eNX+suzTlADuAbd0LVdvmaGhYgXYODaIAnWT3eGug5TgaG9gpYIOz
oxpUfasbDigg5I1oChIR9MyuSlP9+uSm6M/7I3YSJzakR+0oQZoYR1MvoNtpsVgZ
HbFC6jnQ04ycsh47WFT2w2jTOSrMarTl8zNeCfMEfeFPzXyCukOKMT/yMbGFtP9P
xBvvPJGhdX7XiwwZkMtgyQyJG26YOA/iReOZXbOsd7lxVJzzKhhHxJTqhM4zsm7S
jNsEYfJqsikuXp+s0/bNjCDXThC0fIfRSt+Et9SoCkCCHtIKMkqAJX/tnM2zNCWV
ENnRzb2ziEdfSGWK9ispcRKrhoAoNB2ndV6GfZytQ9QrLBj6SUBRqRkrVTe/vtZ2
ONw2M+G5bY21x/fhTc6hOGAoUtdObhbWLmH85Kyx41K+NunC8Dbub4ugxOPPDNx1
YBEQCL81RO807ysmb8GgRpVnLOzPJGUsk/MZjeWNCjKXZzHtj+p63EF+apQIrIaL
xGBvd1+KF/LO77hZ38rt57cFmhFw0T+fdN8aRp6nbSOP0OZMNmbfmSGOM3tAW0zE
EWbBPli9sI7mxsZpmAH3i//2XA2DTSX90J0ji8v+VzFPA1eBFVg=
=DWrG
-----END PGP SIGNATURE-----

--zOhrINIRDRtNKIHr--
