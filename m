Received: from eggs.gnu.org ([2001:4830:134:3::10]:45545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fBbHI-0004Ns-CK
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 03:25:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fBbHB-0000Gt-RH
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 03:25:16 -0400
Date: Thu, 26 Apr 2018 17:25:01 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180426072501.GK8800@umbus.fritz.box>
References: <20180419124331.3915-1-clg@kaod.org>
	<20180419124331.3915-8-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="73fGQZLCrFzENemP"
Content-Disposition: inline
In-Reply-To: <20180419124331.3915-8-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v3 07/35] spapr/xive: introduce the XIVE
 Event Queues
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


--73fGQZLCrFzENemP
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 19, 2018 at 02:43:03PM +0200, C=E9dric Le Goater wrote:
> The Event Queue Descriptor (EQD) table is an internal table of the
> XIVE routing sub-engine. It specifies on which Event Queue the event
> data should be posted when an exception occurs (later on pulled by the
> OS) and which Virtual Processor to notify.

Uhhh.. I thought the IVT said which queue and vp to notify, and the
EQD gave metadata for event queues.

> The Event Queue is a much
> more complex structure but we start with a simple model for the sPAPR
> machine.
>=20
> There is one XiveEQ per priority and these are stored under the XIVE
> virtualization presenter (sPAPRXiveNVT). EQs are simply indexed with :
>=20
>        (server << 3) | (priority & 0x7)
>=20
> This is not in the XIVE architecture but as the EQ index is never
> exposed to the guest, in the hcalls nor in the device tree, we are
> free to use what fits best the current model.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Is the EQD actually modifiable by a guest?  Or are the settings of the
EQs fixed by PAPR?

> ---
>=20
>  Changes since v2 :
>=20
>  - introduced the XiveFabric interface
>=20
>  hw/intc/spapr_xive.c        | 31 +++++++++++++++++---
>  hw/intc/xive.c              | 71 +++++++++++++++++++++++++++++++++++++++=
++++++
>  include/hw/ppc/spapr_xive.h |  7 +++++
>  include/hw/ppc/xive.h       |  8 +++++
>  include/hw/ppc/xive_regs.h  | 48 ++++++++++++++++++++++++++++++
>  5 files changed, 161 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> index f07832bf0a00..d0d5a7d7f969 100644
> --- a/hw/intc/spapr_xive.c
> +++ b/hw/intc/spapr_xive.c
> @@ -27,15 +27,30 @@ void spapr_xive_pic_print_info(sPAPRXive *xive, Monit=
or *mon)
>      monitor_printf(mon, "IVE Table\n");
>      for (i =3D 0; i < xive->nr_irqs; i++) {
>          XiveIVE *ive =3D &xive->ivt[i];
> +        uint32_t eq_idx;
> =20
>          if (!(ive->w & IVE_VALID)) {
>              continue;
>          }
> =20
> -        monitor_printf(mon, "  %4x %s %08x %08x\n", i,
> -                       ive->w & IVE_MASKED ? "M" : " ",
> -                       (int) GETFIELD(IVE_EQ_INDEX, ive->w),
> -                       (int) GETFIELD(IVE_EQ_DATA, ive->w));
> +        eq_idx =3D GETFIELD(IVE_EQ_INDEX, ive->w);
> +
> +        monitor_printf(mon, "  %6x %s eqidx:%03d ", i,
> +                       ive->w & IVE_MASKED ? "M" : " ", eq_idx);
> +
> +        if (!(ive->w & IVE_MASKED)) {
> +            XiveEQ *eq;
> +
> +            eq =3D xive_fabric_get_eq(XIVE_FABRIC(xive), eq_idx);
> +            if (eq && (eq->w0 & EQ_W0_VALID)) {
> +                xive_eq_pic_print_info(eq, mon);
> +                monitor_printf(mon, " data:%08x",
> +                               (int) GETFIELD(IVE_EQ_DATA, ive->w));
> +            } else {
> +                monitor_printf(mon, "no eq ?!");
> +            }
> +        }
> +        monitor_printf(mon, "\n");
>      }
>  }
> =20
> @@ -128,6 +143,13 @@ static XiveNVT *spapr_xive_get_nvt(XiveFabric *xf, u=
int32_t server)
>      return cpu ? XIVE_NVT(cpu->intc) : NULL;
>  }
> =20
> +static XiveEQ *spapr_xive_get_eq(XiveFabric *xf, uint32_t eq_idx)
> +{
> +    XiveNVT *nvt =3D xive_fabric_get_nvt(xf, SPAPR_XIVE_EQ_SERVER(eq_idx=
));
> +
> +    return xive_nvt_eq_get(nvt, SPAPR_XIVE_EQ_PRIO(eq_idx));
> +}
> +
>  static const VMStateDescription vmstate_spapr_xive_ive =3D {
>      .name =3D TYPE_SPAPR_XIVE "/ive",
>      .version_id =3D 1,
> @@ -168,6 +190,7 @@ static void spapr_xive_class_init(ObjectClass *klass,=
 void *data)
> =20
>      xfc->get_ive =3D spapr_xive_get_ive;
>      xfc->get_nvt =3D spapr_xive_get_nvt;
> +    xfc->get_eq =3D spapr_xive_get_eq;
>  }
> =20
>  static const TypeInfo spapr_xive_info =3D {
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index 5691bb9474e4..2ab37fde80e8 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -19,6 +19,47 @@
>  #include "hw/ppc/xive_regs.h"
> =20
>  /*
> + * XiveEQ helpers
> + */
> +
> +XiveEQ *xive_nvt_eq_get(XiveNVT *nvt, uint8_t priority)
> +{
> +    if (!nvt || priority > XIVE_PRIORITY_MAX) {
> +        return NULL;
> +    }
> +    return &nvt->eqt[priority];
> +}
> +
> +void xive_eq_reset(XiveEQ *eq)
> +{
> +    memset(eq, 0, sizeof(*eq));
> +
> +    /* switch off the escalation and notification ESBs */
> +    eq->w1 =3D EQ_W1_ESe_Q | EQ_W1_ESn_Q;
> +}
> +
> +void xive_eq_pic_print_info(XiveEQ *eq, Monitor *mon)
> +{
> +    uint64_t qaddr_base =3D (((uint64_t)(eq->w2 & 0x0fffffff)) << 32) | =
eq->w3;
> +    uint32_t qindex =3D GETFIELD(EQ_W1_PAGE_OFF, eq->w1);
> +    uint32_t qgen =3D GETFIELD(EQ_W1_GENERATION, eq->w1);
> +    uint32_t qsize =3D GETFIELD(EQ_W0_QSIZE, eq->w0);
> +    uint32_t qentries =3D 1 << (qsize + 10);
> +
> +    uint32_t server =3D GETFIELD(EQ_W6_NVT_INDEX, eq->w6);
> +    uint8_t priority =3D GETFIELD(EQ_W7_F0_PRIORITY, eq->w7);
> +
> +    monitor_printf(mon, "%c%c%c%c%c prio:%d server:%03d eq:@%08"PRIx64
> +                   "% 6d/%5d ^%d",
> +                   eq->w0 & EQ_W0_VALID ? 'v' : '-',
> +                   eq->w0 & EQ_W0_ENQUEUE ? 'q' : '-',
> +                   eq->w0 & EQ_W0_UCOND_NOTIFY ? 'n' : '-',
> +                   eq->w0 & EQ_W0_BACKLOG ? 'b' : '-',
> +                   eq->w0 & EQ_W0_ESCALATE_CTL ? 'e' : '-',
> +                   priority, server, qaddr_base, qindex, qentries, qgen);
> +}
> +
> +/*
>   * XIVE Interrupt Presenter
>   */
> =20
> @@ -210,8 +251,12 @@ void xive_nvt_pic_print_info(XiveNVT *nvt, Monitor *=
mon)
>  static void xive_nvt_reset(void *dev)
>  {
>      XiveNVT *nvt =3D XIVE_NVT(dev);
> +    int i;
> =20
>      memset(nvt->regs, 0, sizeof(nvt->regs));
> +    for (i =3D 0; i < ARRAY_SIZE(nvt->eqt); i++) {
> +        xive_eq_reset(&nvt->eqt[i]);
> +    }

Hrm.  Having the EQs "owned" by the NVT makes things simple for PAPR.
But won't that break down for the powernv case?

>  }
> =20
>  static void xive_nvt_realize(DeviceState *dev, Error **errp)
> @@ -259,12 +304,31 @@ static void xive_nvt_init(Object *obj)
>      nvt->ring_os =3D &nvt->regs[TM_QW1_OS];
>  }
> =20
> +static const VMStateDescription vmstate_xive_nvt_eq =3D {
> +    .name =3D TYPE_XIVE_NVT "/eq",
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
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
>  static const VMStateDescription vmstate_xive_nvt =3D {
>      .name =3D TYPE_XIVE_NVT,
>      .version_id =3D 1,
>      .minimum_version_id =3D 1,
>      .fields =3D (VMStateField[]) {
>          VMSTATE_BUFFER(regs, XiveNVT),
> +        VMSTATE_STRUCT_ARRAY(eqt, XiveNVT, (XIVE_PRIORITY_MAX + 1), 1,
> +                             vmstate_xive_nvt_eq, XiveEQ),
>          VMSTATE_END_OF_LIST()
>      },
>  };
> @@ -305,6 +369,13 @@ XiveNVT *xive_fabric_get_nvt(XiveFabric *xf, uint32_=
t server)
>      return xfc->get_nvt(xf, server);
>  }
> =20
> +XiveEQ *xive_fabric_get_eq(XiveFabric *xf, uint32_t eq_idx)
> +{
> +   XiveFabricClass *xfc =3D XIVE_FABRIC_GET_CLASS(xf);
> +
> +   return xfc->get_eq(xf, eq_idx);
> +}
> +
>  static void xive_fabric_route(XiveFabric *xf, int lisn)
>  {
> =20
> diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
> index 25d78eec884d..7cb3561aa3d3 100644
> --- a/include/hw/ppc/spapr_xive.h
> +++ b/include/hw/ppc/spapr_xive.h
> @@ -36,4 +36,11 @@ bool spapr_xive_irq_enable(sPAPRXive *xive, uint32_t l=
isn, bool lsi);
>  bool spapr_xive_irq_disable(sPAPRXive *xive, uint32_t lisn);
>  void spapr_xive_pic_print_info(sPAPRXive *xive, Monitor *mon);
> =20
> +/*
> + * sPAPR encoding of EQ indexes
> + */
> +#define SPAPR_XIVE_EQ_INDEX(server, prio)  (((server) << 3) | ((prio) & =
0x7))
> +#define SPAPR_XIVE_EQ_SERVER(eq_idx) ((eq_idx) >> 3)
> +#define SPAPR_XIVE_EQ_PRIO(eq_idx)   ((eq_idx) & 0x7)
> +
>  #endif /* PPC_SPAPR_XIVE_H */
> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
> index 1a2da610d91c..6cc02638c677 100644
> --- a/include/hw/ppc/xive.h
> +++ b/include/hw/ppc/xive.h
> @@ -176,12 +176,18 @@ typedef struct XiveNVT {
> =20
>      /* Shortcuts to rings */
>      uint8_t   *ring_os;
> +
> +    XiveEQ    eqt[XIVE_PRIORITY_MAX + 1];
>  } XiveNVT;
> =20
>  extern const MemoryRegionOps xive_tm_user_ops;
>  extern const MemoryRegionOps xive_tm_os_ops;
> =20
>  void xive_nvt_pic_print_info(XiveNVT *nvt, Monitor *mon);
> +XiveEQ *xive_nvt_eq_get(XiveNVT *nvt, uint8_t priority);
> +
> +void xive_eq_reset(XiveEQ *eq);
> +void xive_eq_pic_print_info(XiveEQ *eq, Monitor *mon);
> =20
>  /*
>   * XIVE Fabric
> @@ -205,9 +211,11 @@ typedef struct XiveFabricClass {
> =20
>      XiveIVE *(*get_ive)(XiveFabric *xf, uint32_t lisn);
>      XiveNVT *(*get_nvt)(XiveFabric *xf, uint32_t server);
> +    XiveEQ  *(*get_eq)(XiveFabric *xf, uint32_t eq_idx);
>  } XiveFabricClass;
> =20
>  XiveIVE *xive_fabric_get_ive(XiveFabric *xf, uint32_t lisn);
>  XiveNVT *xive_fabric_get_nvt(XiveFabric *xf, uint32_t server);
> +XiveEQ  *xive_fabric_get_eq(XiveFabric *xf, uint32_t eq_idx);
> =20
>  #endif /* PPC_XIVE_H */
> diff --git a/include/hw/ppc/xive_regs.h b/include/hw/ppc/xive_regs.h
> index f2e2a1ac8f6e..bcc44e766db9 100644
> --- a/include/hw/ppc/xive_regs.h
> +++ b/include/hw/ppc/xive_regs.h
> @@ -112,6 +112,54 @@ typedef struct XiveIVE {
>  #define IVE_EQ_DATA     PPC_BITMASK(33, 63)      /* Data written to the =
EQ */
>  } XiveIVE;
> =20
> +/* EQ */
> +typedef struct XiveEQ {
> +        uint32_t        w0;
> +#define EQ_W0_VALID             PPC_BIT32(0) /* "v" bit */
> +#define EQ_W0_ENQUEUE           PPC_BIT32(1) /* "q" bit */
> +#define EQ_W0_UCOND_NOTIFY      PPC_BIT32(2) /* "n" bit */
> +#define EQ_W0_BACKLOG           PPC_BIT32(3) /* "b" bit */
> +#define EQ_W0_PRECL_ESC_CTL     PPC_BIT32(4) /* "p" bit */
> +#define EQ_W0_ESCALATE_CTL      PPC_BIT32(5) /* "e" bit */
> +#define EQ_W0_UNCOND_ESCALATE   PPC_BIT32(6) /* "u" bit - DD2.0 */
> +#define EQ_W0_SILENT_ESCALATE   PPC_BIT32(7) /* "s" bit - DD2.0 */
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
>  #endif /* _INTC_XIVE_INTERNAL_H */

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--73fGQZLCrFzENemP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrhfssACgkQbDjKyiDZ
s5IhqxAAjZqHzOzQ4wDXJbGu8EZyDBzSoGSvqGiTT1E/5gQ5hgF/ZlIFWP/q5UW0
YT9v+KacG8Xo4ZGmag4iqFZL1xARK3sFDAsxpO3pxQjyeFfRm8eNivdiFl0+wmKq
iBp7aVicQBJDpsV5+iXPlrUqLaHMN0nVSOyI1r4JoTG+Y1S3daoONEXH86SvHoWB
X85BJPFBMAWpIrUaNuwht3V9qpHju+GEylxdpFEsCvR+UyoeXeeOTnwqJsDi1DRu
ggljUodunPVjtSmp6Lak26PsaxWCuqV4NKD7zDGqFjfmbhOe/Cg+S/Hi86gsymb9
p7ijjoPM4KZ1vIywKwI3F5QBPrnLbY4aXRoS39JQaEcxs0sropGW++eC7/V0hzN9
32FzPHQSQIHXXLiC6XWMgLmg/+rjelAcKuqpPb8Hit4hrnSMZt2RADJNDOWD+9FI
866BUGiqZSjSWzDgZe2vgbwhGk/FgpdQ1bMcaeHTFbNjV03/8D7oFTm1ZlMM0H1v
Ep00u0X3ZLFf7oHVgoh4e23D/lXJq7K2OEqcq3yWEhMl8l+26KAUtM8gkMsxFkAv
kpBeWcUuxAp7jFAinOI3owSIGxGICF6U2yz0R8oiczpa9vlhfz61hcQ0SvYuC37F
cHO+lbm/tL5daiWxUdaVNAqrR+wZ1HCKIpSWD2iEUqv1LxFg18w=
=wtFh
-----END PGP SIGNATURE-----

--73fGQZLCrFzENemP--
