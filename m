Received: from eggs.gnu.org ([2001:4830:134:3::10]:50687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eKH19-0005PD-BJ
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 00:04:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eKH17-0005bS-RN
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 00:04:11 -0500
Date: Thu, 30 Nov 2017 15:38:36 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171130043836.GB3023@umbus.fritz.box>
References: <20171123132955.1261-14-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="GrZJL/A7LJaW37J8"
Content-Disposition: inline
In-Reply-To: <20171123132955.1261-14-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 13/25] spapr: introduce the XIVE Event
 Queues
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


--GrZJL/A7LJaW37J8
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 23, 2017 at 02:29:43PM +0100, C=E9dric Le Goater wrote:
> The Event Queue Descriptor (EQD) table, also known as Event Notification
> Descriptor (END), is one of the internal tables the XIVE interrupt
> controller uses to redirect exception from event sources to CPU
> threads.
>=20
> The EQD specifies on which Event Queue the event data should be posted
> when an exception occurs (later on pulled by the OS) and which server
> (VPD in XIVE terminology) to notify. The Event Queue is a much more
> complex structure but we start with a simple model for the sPAPR
> machine.

Just to clarify my understanding a server / VPD in XIVE would
typically correspond to a cpu - either real or virtual, yes?

> There is one XiveEQ per priority and the model chooses to store them
> under the Xive Interrupt presenter model. It will be retrieved, just
> like for XICS, through the 'intc' object pointer of the CPU.
>=20
> The EQ indexing follows a simple pattern:
>=20
>        (server << 3) | (priority & 0x7)
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>  hw/intc/spapr_xive.c    | 56 +++++++++++++++++++++++++++++++++++++++++++=
++++++
>  hw/intc/xive-internal.h | 50 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 106 insertions(+)
>=20
> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> index 554b25e0884c..983317a6b3f6 100644
> --- a/hw/intc/spapr_xive.c
> +++ b/hw/intc/spapr_xive.c
> @@ -23,6 +23,7 @@
>  #include "sysemu/dma.h"
>  #include "monitor/monitor.h"
>  #include "hw/ppc/spapr_xive.h"
> +#include "hw/ppc/spapr.h"
>  #include "hw/ppc/xics.h"
> =20
>  #include "xive-internal.h"
> @@ -34,6 +35,8 @@ struct sPAPRXiveICP {
>      uint8_t   tima[TM_RING_COUNT * 0x10];
>      uint8_t   *tima_os;
>      qemu_irq  output;
> +
> +    XiveEQ    eqt[XIVE_PRIORITY_MAX + 1];
>  };
> =20
>  static uint64_t spapr_xive_icp_accept(sPAPRXiveICP *icp)
> @@ -183,6 +186,13 @@ static const MemoryRegionOps spapr_xive_tm_ops =3D {
>      },
>  };
> =20
> +static sPAPRXiveICP *spapr_xive_icp_get(sPAPRXive *xive, int server)
> +{
> +    PowerPCCPU *cpu =3D spapr_find_cpu(server);
> +
> +    return cpu ? SPAPR_XIVE_ICP(cpu->intc) : NULL;
> +}
> +
>  static void spapr_xive_irq(sPAPRXive *xive, int lisn)
>  {
> =20
> @@ -632,6 +642,8 @@ static void spapr_xive_icp_reset(void *dev)
>      sPAPRXiveICP *xicp =3D SPAPR_XIVE_ICP(dev);
> =20
>      memset(xicp->tima, 0, sizeof(xicp->tima));
> +
> +    memset(xicp->eqt, 0, sizeof(xicp->eqt));
>  }
> =20
>  static void spapr_xive_icp_realize(DeviceState *dev, Error **errp)
> @@ -683,6 +695,23 @@ static void spapr_xive_icp_init(Object *obj)
>      xicp->tima_os =3D &xicp->tima[TM_QW1_OS];
>  }
> =20
> +static const VMStateDescription vmstate_spapr_xive_icp_eq =3D {
> +    .name =3D TYPE_SPAPR_XIVE_ICP "/eq",
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .fields =3D (VMStateField []) {
> +        VMSTATE_UINT32(w0, XiveEQ),
> +        VMSTATE_UINT32(w1, XiveEQ),
> +        VMSTATE_UINT32(w2, XiveEQ),
> +        VMSTATE_UINT32(w3, XiveEQ),
> +        VMSTATE_UINT32(w4, XiveEQ),
> +        VMSTATE_UINT32(w5, XiveEQ),
> +        VMSTATE_UINT32(w6, XiveEQ),
> +        VMSTATE_UINT32(w7, XiveEQ),

Wow.  Super descriptive field names there, but I guess that's not your faul=
t.

> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
>  static bool vmstate_spapr_xive_icp_needed(void *opaque)
>  {
>      /* TODO check machine XIVE support */
> @@ -696,6 +725,8 @@ static const VMStateDescription vmstate_spapr_xive_ic=
p =3D {
>      .needed =3D vmstate_spapr_xive_icp_needed,
>      .fields =3D (VMStateField[]) {
>          VMSTATE_BUFFER(tima, sPAPRXiveICP),
> +        VMSTATE_STRUCT_ARRAY(eqt, sPAPRXiveICP, (XIVE_PRIORITY_MAX + 1),=
 1,
> +                             vmstate_spapr_xive_icp_eq, XiveEQ),
>          VMSTATE_END_OF_LIST()
>      },
>  };
> @@ -755,3 +786,28 @@ bool spapr_xive_irq_unset(sPAPRXive *xive, uint32_t =
lisn)
>      ive->w &=3D ~IVE_VALID;
>      return true;
>  }
> +
> +/*
> + * Use a simple indexing for the EQs.

Is this server+priority encoding architected anywhere?  Otherwise, why
not use separate parameters?

> + */
> +XiveEQ *spapr_xive_get_eq(sPAPRXive *xive, uint32_t eq_idx)
> +{
> +    int priority =3D eq_idx & 0x7;
> +    sPAPRXiveICP *xicp =3D spapr_xive_icp_get(xive, eq_idx >> 3);
> +
> +    return xicp ? &xicp->eqt[priority] : NULL;
> +}
> +
> +bool spapr_xive_eq_for_server(sPAPRXive *xive, uint32_t server,
> +                              uint8_t priority, uint32_t *out_eq_idx)
> +{
> +    if (priority > XIVE_PRIORITY_MAX) {
> +        return false;
> +    }
> +
> +    if (out_eq_idx) {
> +        *out_eq_idx =3D (server << 3) | (priority & 0x7);
> +    }
> +
> +    return true;
> +}
> diff --git a/hw/intc/xive-internal.h b/hw/intc/xive-internal.h
> index 7d329f203a9b..c3949671aa03 100644
> --- a/hw/intc/xive-internal.h
> +++ b/hw/intc/xive-internal.h
> @@ -131,9 +131,59 @@ typedef struct XiveIVE {
>  #define IVE_EQ_DATA     PPC_BITMASK(33, 63)      /* Data written to the =
EQ */
>  } XiveIVE;
> =20
> +/* EQ */
> +typedef struct XiveEQ {
> +        uint32_t        w0;
> +#define EQ_W0_VALID             PPC_BIT32(0)
> +#define EQ_W0_ENQUEUE           PPC_BIT32(1)
> +#define EQ_W0_UCOND_NOTIFY      PPC_BIT32(2)
> +#define EQ_W0_BACKLOG           PPC_BIT32(3)
> +#define EQ_W0_PRECL_ESC_CTL     PPC_BIT32(4)
> +#define EQ_W0_ESCALATE_CTL      PPC_BIT32(5)
> +#define EQ_W0_END_OF_INTR       PPC_BIT32(6)
> +#define EQ_W0_QSIZE             PPC_BITMASK32(12, 15)
> +#define EQ_W0_SW0               PPC_BIT32(16)
> +#define EQ_W0_FIRMWARE          EQ_W0_SW0 /* Owned by FW */
> +#define EQ_QSIZE_4K             0
> +#define EQ_QSIZE_64K            4
> +#define EQ_W0_HWDEP             PPC_BITMASK32(24, 31)
> +        uint32_t        w1;
> +#define EQ_W1_ESn               PPC_BITMASK32(0, 1)
> +#define EQ_W1_ESn_P             PPC_BIT32(0)
> +#define EQ_W1_ESn_Q             PPC_BIT32(1)
> +#define EQ_W1_ESe               PPC_BITMASK32(2, 3)
> +#define EQ_W1_ESe_P             PPC_BIT32(2)
> +#define EQ_W1_ESe_Q             PPC_BIT32(3)
> +#define EQ_W1_GENERATION        PPC_BIT32(9)
> +#define EQ_W1_PAGE_OFF          PPC_BITMASK32(10, 31)
> +        uint32_t        w2;
> +#define EQ_W2_MIGRATION_REG     PPC_BITMASK32(0, 3)
> +#define EQ_W2_OP_DESC_HI        PPC_BITMASK32(4, 31)
> +        uint32_t        w3;
> +#define EQ_W3_OP_DESC_LO        PPC_BITMASK32(0, 31)
> +        uint32_t        w4;
> +#define EQ_W4_ESC_EQ_BLOCK      PPC_BITMASK32(4, 7)
> +#define EQ_W4_ESC_EQ_INDEX      PPC_BITMASK32(8, 31)
> +        uint32_t        w5;
> +#define EQ_W5_ESC_EQ_DATA       PPC_BITMASK32(1, 31)
> +        uint32_t        w6;
> +#define EQ_W6_FORMAT_BIT        PPC_BIT32(8)
> +#define EQ_W6_NVT_BLOCK         PPC_BITMASK32(9, 12)
> +#define EQ_W6_NVT_INDEX         PPC_BITMASK32(13, 31)
> +        uint32_t        w7;
> +#define EQ_W7_F0_IGNORE         PPC_BIT32(0)
> +#define EQ_W7_F0_BLK_GROUPING   PPC_BIT32(1)
> +#define EQ_W7_F0_PRIORITY       PPC_BITMASK32(8, 15)
> +#define EQ_W7_F1_WAKEZ          PPC_BIT32(0)
> +#define EQ_W7_F1_LOG_SERVER_ID  PPC_BITMASK32(1, 31)
> +} XiveEQ;
> +
>  #define XIVE_PRIORITY_MAX  7
> =20
>  void spapr_xive_reset(void *dev);
>  XiveIVE *spapr_xive_get_ive(sPAPRXive *xive, uint32_t lisn);
> +XiveEQ *spapr_xive_get_eq(sPAPRXive *xive, uint32_t idx);
> +bool spapr_xive_eq_for_server(sPAPRXive *xive, uint32_t server, uint8_t =
prio,
> +                              uint32_t *out_eq_idx);
> =20
>  #endif /* _INTC_XIVE_INTERNAL_H */

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--GrZJL/A7LJaW37J8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlofi0wACgkQbDjKyiDZ
s5JZPhAApNuLZ+gjYrpkpAqniirf4f63uSfTw5hIpM7ktXIzAQjHRU0zEs0Qf2eo
lcYiLMOvkHxd1Itr3Gq2rdNNrMl5bsyRJ0vgKesQxCwqsmXx14gEh/c3RPsQ6T1+
xQ9Gs74mXPDuN9oMtxMkEd2YvyfhjwhniXc7Anx71/lXHaTdSaldC6jd4R3h27Sn
fXwuTGha80vbL02a+aGZ49bMVDiZAvvAim+FkJtLjRrBUhq/g05aScn0qm8oGcGb
lFJJ0kuE3F90ZWB0A7RJwFCL0BLkHNM7VYfcbNlZVmk+4i97dReTCfcOANdCzUSh
A5iKUkl51itgQoX+9TRPmQ2TnxwbNjIJbO8pXqtcOAzyhddix0kDrRBlGRLhiNZQ
Vb/AB0bwBxtinyiQXNHNRnGC9N7aSWgR59953z+SDsEJeSnon3NWV/5ip2tWHr9X
I5FLbqvJzLZYI8aFw4MH1VXU9woJh8KDBptUzu6xRI7d2ukpqdOSxx5YJPF8lc1O
rtb4VHgbE1Eswo4qp+6JGLDTlmyAIuLqsVwv6lYyL/SSkwWeQmJBsyaW5NSlHH6n
v/uAnOcSBNBVh7/1JXYctZ3vVxS85jGTyfjCBpvO/Q6tJ2MRmAuBvgEEB7JItGDW
bS0+nch5qr7jnRcnYIR4DIlNNx9GNygG/d9frMl1YY91zZeEF8s=
=5hyO
-----END PGP SIGNATURE-----

--GrZJL/A7LJaW37J8--
