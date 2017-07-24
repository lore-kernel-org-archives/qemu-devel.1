Received: from eggs.gnu.org ([2001:4830:134:3::10]:39635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dZWy2-00025U-IO
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 02:35:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dZWxz-0006ft-BA
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 02:35:46 -0400
Date: Mon, 24 Jul 2017 16:35:34 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170724063534.GM17228@umbus.fritz.box>
References: <1499274819-15607-1-git-send-email-clg@kaod.org>
	<1499274819-15607-15-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Cqq5NadOW2RfLMJ/"
Content-Disposition: inline
In-Reply-To: <1499274819-15607-15-git-send-email-clg@kaod.org>
Subject: Re: [Qemu-devel] [RFC PATCH 14/26] ppc/xive: add MMIO handlers to
 the XIVE interrupt presenter model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--Cqq5NadOW2RfLMJ/
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 05, 2017 at 07:13:27PM +0200, C=E9dric Le Goater wrote:
> The Thread Interrupt Management Area for the OS is mostly used to
> acknowledge interrupts and set the CPPR of the CPU.
>=20
> The TIMA is mapped at the same address for each CPU. 'current_cpu' is
> used to retrieve the targeted interrupt presenter object.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Am I right in thinking that this shoehorns the XIVE TIMA state into
the existing XICS ICP object.  That.. doesn't seem like a good idea.

> ---
>  hw/intc/xive-internal.h |   4 ++
>  hw/intc/xive.c          | 187 ++++++++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 191 insertions(+)
>=20
> diff --git a/hw/intc/xive-internal.h b/hw/intc/xive-internal.h
> index ba5e648a5258..5e8b78a1ea6a 100644
> --- a/hw/intc/xive-internal.h
> +++ b/hw/intc/xive-internal.h
> @@ -200,6 +200,10 @@ struct XIVE {
>      /* ESB and TIMA memory location */
>      hwaddr       vc_base;
>      MemoryRegion esb_iomem;
> +
> +    uint32_t     tm_shift;
> +    hwaddr       tm_base;
> +    MemoryRegion tm_iomem;
>  };
> =20
>  void xive_reset(void *dev);
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index c08a4f8efb58..82b2f0dcda0b 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -26,6 +26,180 @@
> =20
>  #include "xive-internal.h"
> =20
> +static uint8_t priority_to_ipb(uint8_t priority)
> +{
> +    return priority < XIVE_EQ_PRIORITY_COUNT ? 1 << (7 - priority) : 0;
> +}
> +
> +static uint64_t xive_icp_accept(XiveICPState *xicp)
> +{
> +    ICPState *icp =3D ICP(xicp);
> +    uint8_t nsr =3D xicp->tima_os[TM_NSR];
> +
> +    qemu_irq_lower(icp->output);
> +
> +    if (xicp->tima_os[TM_NSR] & TM_QW1_NSR_EO) {
> +        uint8_t cppr =3D xicp->tima_os[TM_PIPR];
> +
> +        xicp->tima_os[TM_CPPR] =3D cppr;
> +
> +        /* Reset the pending buffer bit */
> +        xicp->tima_os[TM_IPB] &=3D ~priority_to_ipb(cppr);
> +
> +        /* Drop Exception bit for OS */
> +        xicp->tima_os[TM_NSR] &=3D ~TM_QW1_NSR_EO;
> +    }
> +
> +    return (nsr << 8) | xicp->tima_os[TM_CPPR];
> +}
> +
> +static void xive_icp_set_cppr(XiveICPState *xicp, uint8_t cppr)
> +{
> +    if (cppr > XIVE_PRIORITY_MAX) {
> +        cppr =3D 0xff;
> +    }
> +
> +    xicp->tima_os[TM_CPPR] =3D cppr;
> +}
> +
> +/*
> + * Thread Interrupt Management Area MMIO
> + */
> +static uint64_t xive_tm_read_special(XiveICPState *icp, hwaddr offset,
> +                                     unsigned size)
> +{
> +    uint64_t ret =3D -1;
> +
> +    if (offset =3D=3D TM_SPC_ACK_OS_REG && size =3D=3D 2) {
> +        ret =3D xive_icp_accept(icp);
> +    } else {
> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid TIMA read @%"
> +                      HWADDR_PRIx" size %d\n", offset, size);
> +    }
> +
> +    return ret;
> +}
> +
> +static uint64_t xive_tm_read(void *opaque, hwaddr offset, unsigned size)
> +{
> +    PowerPCCPU *cpu =3D POWERPC_CPU(current_cpu);
> +    XiveICPState *icp =3D XIVE_ICP(cpu->intc);
> +    uint64_t ret =3D -1;
> +    int i;
> +
> +    if (offset >=3D TM_SPC_ACK_EBB) {
> +        return xive_tm_read_special(icp, offset, size);
> +    }
> +
> +    if (offset & TM_QW1_OS) {
> +        switch (size) {
> +        case 1:
> +        case 2:
> +        case 4:
> +        case 8:
> +            if (QEMU_IS_ALIGNED(offset, size)) {
> +                ret =3D 0;
> +                for (i =3D 0; i < size; i++) {
> +                    ret |=3D icp->tima[offset + i] << (8 * i);
> +                }
> +            } else {
> +                qemu_log_mask(LOG_GUEST_ERROR,
> +                              "XIVE: invalid TIMA read alignment @%"
> +                              HWADDR_PRIx" size %d\n", offset, size);
> +            }
> +            break;
> +        default:
> +            g_assert_not_reached();
> +        }
> +    } else {
> +        qemu_log_mask(LOG_UNIMP, "XIVE: does handle non-OS TIMA ring @%"
> +                      HWADDR_PRIx"\n", offset);
> +    }
> +
> +    return ret;
> +}
> +
> +static bool xive_tm_is_readonly(uint8_t index)
> +{
> +    /* Let's be optimistic and prepare ground for HV mode support */
> +    switch (index) {
> +    case TM_QW1_OS + TM_CPPR:
> +        return false;
> +    default:
> +        return true;
> +    }
> +}
> +
> +static void xive_tm_write_special(XiveICPState *xicp, hwaddr offset,
> +                                  uint64_t value, unsigned size)
> +{
> +    if (offset =3D=3D TM_SPC_SET_OS_PENDING && size =3D=3D 1) {
> +        xicp->tima_os[TM_IPB] |=3D priority_to_ipb(value & 0xff);
> +    } else {
> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid TIMA write @%"
> +                      HWADDR_PRIx" size %d\n", offset, size);
> +    }
> +
> +    /* TODO: support TM_SPC_ACK_OS_EL */
> +}
> +
> +static void xive_tm_write(void *opaque, hwaddr offset,
> +                           uint64_t value, unsigned size)
> +{
> +    PowerPCCPU *cpu =3D POWERPC_CPU(current_cpu);
> +    XiveICPState *icp =3D XIVE_ICP(cpu->intc);
> +    int i;
> +
> +    if (offset >=3D TM_SPC_ACK_EBB) {
> +        xive_tm_write_special(icp, offset, value, size);
> +        return;
> +    }
> +
> +    if (offset & TM_QW1_OS) {
> +        switch (size) {
> +        case 1:
> +            if (offset =3D=3D TM_QW1_OS + TM_CPPR) {
> +                xive_icp_set_cppr(icp, value & 0xff);
> +            }
> +            break;
> +        case 4:
> +        case 8:
> +            if (QEMU_IS_ALIGNED(offset, size)) {
> +                for (i =3D 0; i < size; i++) {
> +                    if (!xive_tm_is_readonly(offset + i)) {
> +                        icp->tima[offset + i] =3D (value >> (8 * i)) & 0=
xff;
> +                    }
> +                }
> +            } else {
> +                qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid TIMA write=
 @%"
> +                              HWADDR_PRIx" size %d\n", offset, size);
> +            }
> +            break;
> +        default:
> +            qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid TIMA write @%"
> +                          HWADDR_PRIx" size %d\n", offset, size);
> +        }
> +    } else {
> +        qemu_log_mask(LOG_UNIMP, "XIVE: does handle non-OS TIMA ring @%"
> +                      HWADDR_PRIx"\n", offset);
> +    }
> +}
> +
> +
> +static const MemoryRegionOps xive_tm_ops =3D {
> +    .read =3D xive_tm_read,
> +    .write =3D xive_tm_write,
> +    .endianness =3D DEVICE_BIG_ENDIAN,
> +    .valid =3D {
> +        .min_access_size =3D 1,
> +        .max_access_size =3D 8,
> +    },
> +    .impl =3D {
> +        .min_access_size =3D 1,
> +        .max_access_size =3D 8,
> +    },
> +};
> +
>  static void xive_icp_reset(ICPState *icp)
>  {
>      XiveICPState *xicp =3D XIVE_ICP(icp);
> @@ -453,6 +627,11 @@ static const TypeInfo xive_ics_info =3D {
>  #define P9_MMIO_BASE     0x006000000000000ull
>  #define P9_CHIP_BASE(id) (P9_MMIO_BASE | (0x40000000000ull * (uint64_t) =
(id)))
> =20
> +/* Thread Interrupt Management Area MMIO */
> +#define TM_BAR_DEFAULT   0x30203180000ull
> +#define TM_SHIFT         16
> +#define TM_BAR_SIZE      (XIVE_TM_RING_COUNT * (1 << TM_SHIFT))
> +
>  static uint64_t xive_esb_default_read(void *p, hwaddr offset, unsigned s=
ize)
>  {
>      qemu_log_mask(LOG_UNIMP, "%s: 0x%" HWADDR_PRIx " [%u]\n",
> @@ -541,6 +720,14 @@ static void xive_realize(DeviceState *dev, Error **e=
rrp)
>                            NULL, "xive.esb", VC_BAR_SIZE);
>      sysbus_init_mmio(SYS_BUS_DEVICE(dev), &x->esb_iomem);
> =20
> +    /* TM BAR. Same address for each chip */
> +    x->tm_base =3D (P9_MMIO_BASE | TM_BAR_DEFAULT);
> +    x->tm_shift =3D TM_SHIFT;
> +
> +    memory_region_init_io(&x->tm_iomem, OBJECT(x), &xive_tm_ops, x,
> +                          "xive.tm", TM_BAR_SIZE);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &x->tm_iomem);
> +
>      qemu_register_reset(xive_reset, dev);
>  }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Cqq5NadOW2RfLMJ/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAll1lTQACgkQbDjKyiDZ
s5JUcA//YY6YiZ7muJD2UYpFLVRGjlV4yBvss/mWwwre55TpZgrRbGv6fuAIA+bl
gaLsCR7K5vHydtiEOz69zOf8tfL38NidCdlaWWMAHzhdFjW/j35HCzsKy8rpxWC4
ZoVc4Nuw0rzQvNXk3QrRUyuR2LrqyBMkGCe7TdToA7B5+oGDGP2X7IwvbrN7n1ww
Ny91Dqo1n9AU9o7KcnCkLBPafWCaGdoWQohGwwFSTz8uwLAUIGoXmTFwOa0jzuS1
+3Pvhy/QfL5OCl45/GmNPtoJqfBEJwr4YTyNPcriH+ErUGNPVx7JvCmr+j8TjEsu
9LBLMY+PrErGGFppPlyJ9KW3rgwU7tArxxWpOJX+TSF7CyaDiRYctOdHsJfLtzrZ
tcl2jBHoT3udpffwsC+oGTDF9E6l9hzqqAXbZhUGy/M4U68yiuiWCZzxxlp8RU7S
sJ3If5LY7S8dPwhPGPa4nmPk52RHx3kmHGqtYBnsY/Fax2Hp0mUZxOSMYILQxJyU
5+In4ChWf3cQOtcg2nEGBZYEJ+MO4fz1Ze3pMQA3HqJ3A0KFLNVxdKGvMCXuwdEb
4e3PQRKM7VwJ9VldZeb8cIqj1Ik1j5WG5EigBsmdG1zQLkU+eIMJWkqk/8dzH4Wi
udpjn4lpgZnJQQ1SkSEuhZ2waO+GmM/UegE1EMlrq/qBH73UzyM=
=nnUZ
-----END PGP SIGNATURE-----

--Cqq5NadOW2RfLMJ/--
