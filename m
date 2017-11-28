Received: from eggs.gnu.org ([2001:4830:134:3::10]:58363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eJcbw-00014Q-6s
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 04:55:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eJcbt-0003fC-3Z
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 04:55:28 -0500
Date: Tue, 28 Nov 2017 16:45:53 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171128054553.GO11775@umbus.fritz.box>
References: <20171123132955.1261-1-clg@kaod.org>
	<20171123132955.1261-10-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="U+NfgObvpQT1Q9Yq"
Content-Disposition: inline
In-Reply-To: <20171123132955.1261-10-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 09/25] spapr: introduce handlers for XIVE
 interrupt sources
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


--U+NfgObvpQT1Q9Yq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 23, 2017 at 02:29:39PM +0100, C=E9dric Le Goater wrote:
> These are very similar to the XICS handlers in a simpler form. They make
> use of a status array for the LSI interrupts. The spapr_xive_irq() routine
> in charge of triggering the CPU interrupt line will be filled later on.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Is the status word you add here architected as part of the XIVE spec,
or purely internal / implementation specific?

> ---
>  hw/intc/spapr_xive.c        | 55 +++++++++++++++++++++++++++++++++++++++=
++++--
>  include/hw/ppc/spapr_xive.h | 14 +++++++++++-
>  2 files changed, 66 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> index b2fc3007c85f..66c533fb1d78 100644
> --- a/hw/intc/spapr_xive.c
> +++ b/hw/intc/spapr_xive.c
> @@ -26,6 +26,47 @@
> =20
>  #include "xive-internal.h"
> =20
> +static void spapr_xive_irq(sPAPRXive *xive, int lisn)
> +{
> +
> +}
> +
> +/*
> + * XIVE Interrupt Source
> + */
> +static void spapr_xive_source_set_irq_msi(sPAPRXive *xive, int lisn, int=
 val)
> +{
> +    if (val) {
> +        spapr_xive_irq(xive, lisn);
> +    }
> +}
> +
> +static void spapr_xive_source_set_irq_lsi(sPAPRXive *xive, int lisn, int=
 val)
> +{
> +    if (val) {
> +        xive->status[lisn] |=3D XIVE_STATUS_ASSERTED;
> +    } else {
> +        xive->status[lisn] &=3D ~XIVE_STATUS_ASSERTED;
> +    }
> +
> +    if (xive->status[lisn] & XIVE_STATUS_ASSERTED &&
> +        !(xive->status[lisn] & XIVE_STATUS_SENT)) {
> +        xive->status[lisn] |=3D XIVE_STATUS_SENT;
> +        spapr_xive_irq(xive, lisn);
> +    }
> +}
> +
> +static void spapr_xive_source_set_irq(void *opaque, int lisn, int val)
> +{
> +    sPAPRXive *xive =3D SPAPR_XIVE(opaque);
> +
> +    if (spapr_xive_irq_is_lsi(xive, lisn)) {
> +        spapr_xive_source_set_irq_lsi(xive, lisn, val);
> +    } else {
> +        spapr_xive_source_set_irq_msi(xive, lisn, val);
> +    }
> +}
> +
>  /*
>   * Main XIVE object
>   */
> @@ -41,7 +82,8 @@ void spapr_xive_pic_print_info(sPAPRXive *xive, Monitor=
 *mon)
>              continue;
>          }
> =20
> -        monitor_printf(mon, "  %4x %s %08x %08x\n", i,
> +        monitor_printf(mon, "  %4x %s %s %08x %08x\n", i,
> +                       spapr_xive_irq_is_lsi(xive, i) ? "LSI" : "MSI",
>                         ive->w & IVE_MASKED ? "M" : " ",
>                         (int) GETFIELD(IVE_EQ_INDEX, ive->w),
>                         (int) GETFIELD(IVE_EQ_DATA, ive->w));
> @@ -53,6 +95,8 @@ void spapr_xive_reset(void *dev)
>      sPAPRXive *xive =3D SPAPR_XIVE(dev);
>      int i;
> =20
> +    /* Do not clear IRQs status */
> +
>      /* Mask all valid IVEs in the IRQ number space. */
>      for (i =3D 0; i < xive->nr_irqs; i++) {
>          XiveIVE *ive =3D &xive->ivt[i];
> @@ -71,6 +115,11 @@ static void spapr_xive_realize(DeviceState *dev, Erro=
r **errp)
>          return;
>      }
> =20
> +    /* QEMU IRQs */
> +    xive->qirqs =3D qemu_allocate_irqs(spapr_xive_source_set_irq, xive,
> +                                     xive->nr_irqs);
> +    xive->status =3D g_malloc0(xive->nr_irqs);
> +
>      /* Allocate the IVT (Interrupt Virtualization Table) */
>      xive->ivt =3D g_malloc0(xive->nr_irqs * sizeof(XiveIVE));
> =20
> @@ -102,6 +151,7 @@ static const VMStateDescription vmstate_spapr_xive =
=3D {
>          VMSTATE_UINT32_EQUAL(nr_irqs, sPAPRXive, NULL),
>          VMSTATE_STRUCT_VARRAY_UINT32_ALLOC(ivt, sPAPRXive, nr_irqs, 1,
>                                             vmstate_spapr_xive_ive, XiveI=
VE),
> +        VMSTATE_VBUFFER_UINT32(status, sPAPRXive, 1, NULL, nr_irqs),
>          VMSTATE_END_OF_LIST()
>      },
>  };
> @@ -140,7 +190,7 @@ XiveIVE *spapr_xive_get_ive(sPAPRXive *xive, uint32_t=
 lisn)
>      return lisn < xive->nr_irqs ? &xive->ivt[lisn] : NULL;
>  }
> =20
> -bool spapr_xive_irq_set(sPAPRXive *xive, uint32_t lisn)
> +bool spapr_xive_irq_set(sPAPRXive *xive, uint32_t lisn, bool lsi)
>  {
>      XiveIVE *ive =3D spapr_xive_get_ive(xive, lisn);
> =20
> @@ -149,6 +199,7 @@ bool spapr_xive_irq_set(sPAPRXive *xive, uint32_t lis=
n)
>      }
> =20
>      ive->w |=3D IVE_VALID;
> +    xive->status[lisn] |=3D lsi ? XIVE_STATUS_LSI : 0;

How does a hardware XIVE know which irqs are LSI and which are MSI?

>      return true;
>  }
> =20
> diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
> index 795b3f4ded7c..6a799cdaba66 100644
> --- a/include/hw/ppc/spapr_xive.h
> +++ b/include/hw/ppc/spapr_xive.h
> @@ -33,11 +33,23 @@ struct sPAPRXive {
>      /* Properties */
>      uint32_t     nr_irqs;
> =20
> +     /* IRQ */
> +    qemu_irq     *qirqs;
> +#define XIVE_STATUS_LSI                0x1
> +#define XIVE_STATUS_ASSERTED           0x2
> +#define XIVE_STATUS_SENT               0x4
> +    uint8_t      *status;
> +
>      /* XIVE internal tables */
>      XiveIVE      *ivt;
>  };
> =20
> -bool spapr_xive_irq_set(sPAPRXive *xive, uint32_t lisn);
> +static inline bool spapr_xive_irq_is_lsi(sPAPRXive *xive, int lisn)
> +{
> +    return xive->status[lisn] & XIVE_STATUS_LSI;
> +}
> +
> +bool spapr_xive_irq_set(sPAPRXive *xive, uint32_t lisn, bool lsi);
>  bool spapr_xive_irq_unset(sPAPRXive *xive, uint32_t lisn);
>  void spapr_xive_pic_print_info(sPAPRXive *xive, Monitor *mon);
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--U+NfgObvpQT1Q9Yq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAloc+BEACgkQbDjKyiDZ
s5KVkhAAn0CjRMwIjS1dq25XbP7c4Kb+blBqG8wTiA6lLKnPD1LOBtPKxk3fr5X+
4NZCsOWf3SuXZdByrjXiZnYGt3ZqDpmkM6fCbM9H8FZnxBl74l85aZBqJ6iF2Nlz
KgVl/Db8kEoBCWPI09lRFgqbj6ZkzKIIk2d0SFk9h5+2Z/jhOm9NZFk7ARzo+Dnw
LacL+OoLVdxwzNQBQT6lsnW3AeangqaILwcu38zLh6h5RuWJWkXjW/VjNeYxhA5V
pIh+z1Ok3VxBJBGEOoXvXYFuqi4Tzxw5sYSRaYDtKFNQM0ZitBna5pZTGIzgCKLL
7gDwDzdRa2TPqnAtc/JwqJ4TyhxOfQazVrEr11v5HXtAOMtHni5qWhOYWDJiU4Mn
OyYWyWKYMmTv51nZC4UAHWvgtmNY/B+Es+XXUJNaY8m6TO7P7uxwmD6TFJQA4KCe
glsDuDhrfyAj6t9P0WpMIST0YxhIL4FVmvlt09z+bg9QjyDeirCCZmQcnLiyK2vb
0oRuDi+Zs5Kd1mFKgT0gwF2v8x0V1OJsd5a1X2T3XWUyDiyOkjr7JvTDhPcqyebp
9RLzoBYjrOjFo56A0FWa3GG8cGNB8CRYQvjM+XGMByE4WGs6PP5PpSEGjF5cN5yn
s+XkqjM9RSdGN7/P7gbjefgn2OBcnNiQWY6v6TzNDaYVhpyIanM=
=yuZf
-----END PGP SIGNATURE-----

--U+NfgObvpQT1Q9Yq--
