Received: from eggs.gnu.org ([209.51.188.92]:59856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gtlvu-0003FY-HD
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 23:14:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gtlvr-0005BW-WD
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 23:14:02 -0500
Date: Wed, 13 Feb 2019 14:50:33 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190213035032.GC1884@umbus.fritz.box>
References: <154999583316.690774.15072605479770041782.stgit@bahia.lan>
	<154999585977.690774.12822496774363025882.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="a9msq94+WlNd0NRk"
Content-Disposition: inline
In-Reply-To: <154999585977.690774.12822496774363025882.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH v4 04/15] spapr: Expose the name of the
 interrupt controller node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, Thomas Huth <thuth@redhat.com>


--a9msq94+WlNd0NRk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 12, 2019 at 07:24:19PM +0100, Greg Kurz wrote:
> This will be needed by PHB hotplug in order to access the "phandle"
> property of the interrupt controller node.
>=20
> Reviewed-by: C=E9dric Le Goater <clg@kaod.org>
> Signed-off-by: Greg Kurz <groug@kaod.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
> v4: - folded some changes from patches 15, 16 and 17 of v3
>     - dropped useless helpers
> ---
>  hw/intc/spapr_xive.c        |    9 ++++-----
>  hw/intc/xics_spapr.c        |    2 +-
>  hw/ppc/spapr_irq.c          |   21 ++++++++++++++++++++-
>  include/hw/ppc/spapr_irq.h  |    1 +
>  include/hw/ppc/spapr_xive.h |    3 +++
>  include/hw/ppc/xics_spapr.h |    2 ++
>  6 files changed, 31 insertions(+), 7 deletions(-)
>=20
> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> index 815263ca72ab..f14e436ad4b9 100644
> --- a/hw/intc/spapr_xive.c
> +++ b/hw/intc/spapr_xive.c
> @@ -317,6 +317,9 @@ static void spapr_xive_realize(DeviceState *dev, Erro=
r **errp)
>      /* Map all regions */
>      spapr_xive_map_mmio(xive);
> =20
> +    xive->nodename =3D g_strdup_printf("interrupt-controller@%" PRIx64,
> +                           xive->tm_base + XIVE_TM_USER_PAGE * (1 << TM_=
SHIFT));
> +
>      qemu_register_reset(spapr_xive_reset, dev);
>  }
> =20
> @@ -1443,7 +1446,6 @@ void spapr_dt_xive(sPAPRMachineState *spapr, uint32=
_t nr_servers, void *fdt,
>          cpu_to_be32(7),    /* start */
>          cpu_to_be32(0xf8), /* count */
>      };
> -    gchar *nodename;
> =20
>      /* Thread Interrupt Management Area : User (ring 3) and OS (ring 2) =
*/
>      timas[0] =3D cpu_to_be64(xive->tm_base +
> @@ -1453,10 +1455,7 @@ void spapr_dt_xive(sPAPRMachineState *spapr, uint3=
2_t nr_servers, void *fdt,
>                             XIVE_TM_OS_PAGE * (1ull << TM_SHIFT));
>      timas[3] =3D cpu_to_be64(1ull << TM_SHIFT);
> =20
> -    nodename =3D g_strdup_printf("interrupt-controller@%" PRIx64,
> -                           xive->tm_base + XIVE_TM_USER_PAGE * (1 << TM_=
SHIFT));
> -    _FDT(node =3D fdt_add_subnode(fdt, 0, nodename));
> -    g_free(nodename);
> +    _FDT(node =3D fdt_add_subnode(fdt, 0, xive->nodename));
> =20
>      _FDT(fdt_setprop_string(fdt, node, "device_type", "power-ivpe"));
>      _FDT(fdt_setprop(fdt, node, "reg", timas, sizeof(timas)));
> diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
> index e2d8b3818336..53bda6661b2a 100644
> --- a/hw/intc/xics_spapr.c
> +++ b/hw/intc/xics_spapr.c
> @@ -254,7 +254,7 @@ void spapr_dt_xics(sPAPRMachineState *spapr, uint32_t=
 nr_servers, void *fdt,
>      };
>      int node;
> =20
> -    _FDT(node =3D fdt_add_subnode(fdt, 0, "interrupt-controller"));
> +    _FDT(node =3D fdt_add_subnode(fdt, 0, XICS_NODENAME));
> =20
>      _FDT(fdt_setprop_string(fdt, node, "device_type",
>                              "PowerPC-External-Interrupt-Presentation"));
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index 3fc34d7c8a43..b8d725e251ba 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -256,6 +256,11 @@ static void spapr_irq_reset_xics(sPAPRMachineState *=
spapr, Error **errp)
>      /* TODO: create the KVM XICS device */
>  }
> =20
> +static const char *spapr_irq_get_nodename_xics(sPAPRMachineState *spapr)
> +{
> +    return XICS_NODENAME;
> +}
> +
>  #define SPAPR_IRQ_XICS_NR_IRQS     0x1000
>  #define SPAPR_IRQ_XICS_NR_MSIS     \
>      (XICS_IRQ_BASE + SPAPR_IRQ_XICS_NR_IRQS - SPAPR_IRQ_MSI)
> @@ -276,6 +281,7 @@ sPAPRIrq spapr_irq_xics =3D {
>      .post_load   =3D spapr_irq_post_load_xics,
>      .reset       =3D spapr_irq_reset_xics,
>      .set_irq     =3D spapr_irq_set_irq_xics,
> +    .get_nodename =3D spapr_irq_get_nodename_xics,
>  };
> =20
>  /*
> @@ -415,6 +421,11 @@ static void spapr_irq_set_irq_xive(void *opaque, int=
 srcno, int val)
>      xive_source_set_irq(&spapr->xive->source, srcno, val);
>  }
> =20
> +static const char *spapr_irq_get_nodename_xive(sPAPRMachineState *spapr)
> +{
> +    return spapr->xive->nodename;
> +}
> +
>  /*
>   * XIVE uses the full IRQ number space. Set it to 8K to be compatible
>   * with XICS.
> @@ -438,6 +449,7 @@ sPAPRIrq spapr_irq_xive =3D {
>      .post_load   =3D spapr_irq_post_load_xive,
>      .reset       =3D spapr_irq_reset_xive,
>      .set_irq     =3D spapr_irq_set_irq_xive,
> +    .get_nodename =3D spapr_irq_get_nodename_xive,
>  };
> =20
>  /*
> @@ -585,6 +597,11 @@ static void spapr_irq_set_irq_dual(void *opaque, int=
 srcno, int val)
>      spapr_irq_current(spapr)->set_irq(spapr, srcno, val);
>  }
> =20
> +static const char *spapr_irq_get_nodename_dual(sPAPRMachineState *spapr)
> +{
> +    return spapr_irq_current(spapr)->get_nodename(spapr);
> +}
> +
>  /*
>   * Define values in sync with the XIVE and XICS backend
>   */
> @@ -615,7 +632,8 @@ sPAPRIrq spapr_irq_dual =3D {
>      .cpu_intc_create =3D spapr_irq_cpu_intc_create_dual,
>      .post_load   =3D spapr_irq_post_load_dual,
>      .reset       =3D spapr_irq_reset_dual,
> -    .set_irq     =3D spapr_irq_set_irq_dual
> +    .set_irq     =3D spapr_irq_set_irq_dual,
> +    .get_nodename =3D spapr_irq_get_nodename_dual,
>  };
> =20
>  /*
> @@ -751,4 +769,5 @@ sPAPRIrq spapr_irq_xics_legacy =3D {
>      .cpu_intc_create =3D spapr_irq_cpu_intc_create_xics,
>      .post_load   =3D spapr_irq_post_load_xics,
>      .set_irq     =3D spapr_irq_set_irq_xics,
> +    .get_nodename =3D spapr_irq_get_nodename_xics,
>  };
> diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
> index 0e6c65d55430..ad7127355441 100644
> --- a/include/hw/ppc/spapr_irq.h
> +++ b/include/hw/ppc/spapr_irq.h
> @@ -48,6 +48,7 @@ typedef struct sPAPRIrq {
>      int (*post_load)(sPAPRMachineState *spapr, int version_id);
>      void (*reset)(sPAPRMachineState *spapr, Error **errp);
>      void (*set_irq)(void *opaque, int srcno, int val);
> +    const char *(*get_nodename)(sPAPRMachineState *spapr);
>  } sPAPRIrq;
> =20
>  extern sPAPRIrq spapr_irq_xics;
> diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
> index 885ca169cb29..2c57a59a3f5b 100644
> --- a/include/hw/ppc/spapr_xive.h
> +++ b/include/hw/ppc/spapr_xive.h
> @@ -26,6 +26,9 @@ typedef struct sPAPRXive {
>      XiveENDSource end_source;
>      hwaddr        end_base;
> =20
> +    /* DT */
> +    gchar *nodename;
> +
>      /* Routing table */
>      XiveEAS       *eat;
>      uint32_t      nr_irqs;
> diff --git a/include/hw/ppc/xics_spapr.h b/include/hw/ppc/xics_spapr.h
> index b1ab27d022cf..b8d924baf437 100644
> --- a/include/hw/ppc/xics_spapr.h
> +++ b/include/hw/ppc/xics_spapr.h
> @@ -29,6 +29,8 @@
> =20
>  #include "hw/ppc/spapr.h"
> =20
> +#define XICS_NODENAME "interrupt-controller"
> +
>  void spapr_dt_xics(sPAPRMachineState *spapr, uint32_t nr_servers, void *=
fdt,
>                     uint32_t phandle);
>  int xics_kvm_init(sPAPRMachineState *spapr, Error **errp);
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--a9msq94+WlNd0NRk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxjlAgACgkQbDjKyiDZ
s5KIPw//TsZ4DzblAOac+lGP0vnr+pGCPfHxk/ZlWexd1uCB+p+QcP+nXiyqQXVX
+QJ1jtl/RkFhw7SQChVv5Z4bywDIE4PV77lcnMH4r3TR3gNhACbr44nYZ94RIzEi
mJwUnTIuQNTl6a43H+jWLe5yugKSNSEDYzBMNmRJvDX9B/gAlz01mHW0nWDNSD31
CAwwnxkznDL8NyE+gnnNDJolMmiIKSil/l2YKjAKbwG+AbwaeTJZ5PJZ4DEX0ZQV
YNdOHBffizANCeMTBeoTPu8/pyfZgN7FuvTTPkO1eCkfqT3PBLeAE/PV0tYLI2UU
+Q0GaltOISK4Chv04LqMjZ9v/rgVrQyhHlEdF/nwqjemckXBw3WqEkvjw0+DqTMT
vq1DJB3V/GQPNE5sqBKyG6YE2FveKaXU91vJo8cx3BKnoAF87Bf7IFnuQq6uloAn
tWZO/QUciHezPRHIKRiufESulNv3Gy9aOpfuJ6q6rxqUUM3t0+2y2ZZccVdM5/sm
MRbfJcTIak5fwK9NtYJc/VbVptiIk6JJ6KydeHCoJqSQ7vWiYEs9StbQrkrAEJnU
Hoot6HDl6xsaKAhU+2a5+SqYONQQHj+QsIvoZteNTXUuzYG/okASZpIKW3m9GfIX
B1GQLG8Q+k55xBOxFK0nRwchlvSEu2MMbhsvTPVNVX5NKH+ye5w=
=RZws
-----END PGP SIGNATURE-----

--a9msq94+WlNd0NRk--
