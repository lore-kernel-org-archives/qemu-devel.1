Received: from eggs.gnu.org ([209.51.188.92]:33693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gkTX9-0003A5-LV
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 07:46:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gkTX2-0007W6-Vr
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 07:46:00 -0500
Received: from 5.mo1.mail-out.ovh.net ([178.33.45.107]:40174)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gkTWv-0007LW-RA
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 07:45:54 -0500
Received: from player798.ha.ovh.net (unknown [10.109.160.54])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id 44CF4150557
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 13:45:47 +0100 (CET)
References: <154774526588.1208625.11295698301887807297.stgit@bahia.lan>
	<154774535838.1208625.13126682782876422159.stgit@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <692050c4-3f3f-2f5d-aa9b-5e7690aa4be8@kaod.org>
Date: Fri, 18 Jan 2019 13:45:26 +0100
MIME-Version: 1.0
In-Reply-To: <154774535838.1208625.13126682782876422159.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 14/19] spapr: Factor out setting of
 "phandle" DT property to sPAPR irq frontend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>, Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, Thomas Huth <thuth@redhat.com>

On 1/17/19 6:15 PM, Greg Kurz wrote:
> The setting of the "phandle" and "linux,phandle" properties of the
> interrupt controller node is duplicate code in XICS and XIVE. Move
> it to a new spapr_irq_dt_populate() function.
>=20
> Note that for XIVE, we set the "ibm,plat-res-int-priorities" machine
> property earlier so that the offset returned by fdt_add_subnode()
> can be safely returned to the caller.

Ah yes. This is a top level XIVE property but I don't think it belongs
to the machine.
=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/intc/spapr_xive.c        |   21 +++++++++------------
>  hw/intc/xics_spapr.c        |    7 +++----
>  hw/ppc/spapr.c              |    2 +-
>  hw/ppc/spapr_irq.c          |   17 +++++++++++++----
>  include/hw/ppc/spapr_irq.h  |    6 ++++--
>  include/hw/ppc/spapr_xive.h |    3 +--
>  include/hw/ppc/xics_spapr.h |    3 +--
>  7 files changed, 32 insertions(+), 27 deletions(-)
>=20
> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> index aab63cfd1178..e542ae59d7fd 100644
> --- a/hw/intc/spapr_xive.c
> +++ b/hw/intc/spapr_xive.c
> @@ -1411,8 +1411,7 @@ void spapr_xive_hcall_init(sPAPRMachineState *spa=
pr)
>      spapr_register_hypercall(H_INT_RESET, h_int_reset);
>  }
> =20
> -void spapr_dt_xive(sPAPRMachineState *spapr, uint32_t nr_servers, void=
 *fdt,
> -                   uint32_t phandle)
> +int spapr_dt_xive(sPAPRMachineState *spapr, uint32_t nr_servers, void =
*fdt)

I am sure this is the correct prototype. This one returning an error and=20
the phander looks better.

   int spapr_dt_xive(sPAPRMachineState *spapr, uint32_t nr_servers, void =
*fdt)
                      uint32_t *phandle)

But I won't make a fuss about it either.


Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

Thanks,

C.


>  {
>      sPAPRXive *xive =3D spapr->xive;
>      int node;
> @@ -1439,6 +1438,13 @@ void spapr_dt_xive(sPAPRMachineState *spapr, uin=
t32_t nr_servers, void *fdt,
>      };
>      gchar *nodename;
> =20
> +    /*
> +     * The "ibm,plat-res-int-priorities" property defines the priority
> +     * ranges reserved by the hypervisor
> +     */
> +    _FDT(fdt_setprop(fdt, 0, "ibm,plat-res-int-priorities",
> +                     plat_res_int_priorities, sizeof(plat_res_int_prio=
rities)));
> +
>      /* Thread Interrupt Management Area : User (ring 3) and OS (ring 2=
) */
>      timas[0] =3D cpu_to_be64(xive->tm_base +
>                             XIVE_TM_USER_PAGE * (1ull << TM_SHIFT));
> @@ -1465,14 +1471,5 @@ void spapr_dt_xive(sPAPRMachineState *spapr, uin=
t32_t nr_servers, void *fdt,
>      _FDT(fdt_setprop(fdt, node, "interrupt-controller", NULL, 0));
>      _FDT(fdt_setprop_cell(fdt, node, "#interrupt-cells", 2));
> =20
> -    /* For SLOF */
> -    _FDT(fdt_setprop_cell(fdt, node, "linux,phandle", phandle));
> -    _FDT(fdt_setprop_cell(fdt, node, "phandle", phandle));
> -
> -    /*
> -     * The "ibm,plat-res-int-priorities" property defines the priority
> -     * ranges reserved by the hypervisor
> -     */
> -    _FDT(fdt_setprop(fdt, 0, "ibm,plat-res-int-priorities",
> -                     plat_res_int_priorities, sizeof(plat_res_int_prio=
rities)));
> +    return node;
>  }
> diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
> index de6cc15b6474..375cb883c86d 100644
> --- a/hw/intc/xics_spapr.c
> +++ b/hw/intc/xics_spapr.c
> @@ -245,8 +245,7 @@ void xics_spapr_init(sPAPRMachineState *spapr)
>      spapr_register_hypercall(H_IPOLL, h_ipoll);
>  }
> =20
> -void spapr_dt_xics(sPAPRMachineState *spapr, uint32_t nr_servers, void=
 *fdt,
> -                   uint32_t phandle)
> +int spapr_dt_xics(sPAPRMachineState *spapr, uint32_t nr_servers, void =
*fdt)
>  {
>      uint32_t interrupt_server_ranges_prop[] =3D {
>          0, cpu_to_be32(nr_servers),
> @@ -263,6 +262,6 @@ void spapr_dt_xics(sPAPRMachineState *spapr, uint32=
_t nr_servers, void *fdt,
>                       interrupt_server_ranges_prop,
>                       sizeof(interrupt_server_ranges_prop)));
>      _FDT(fdt_setprop_cell(fdt, node, "#interrupt-cells", 2));
> -    _FDT(fdt_setprop_cell(fdt, node, "linux,phandle", phandle));
> -    _FDT(fdt_setprop_cell(fdt, node, "phandle", phandle));
> +
> +    return node;
>  }
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 2c8d0c0e149c..135136b4cf5f 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1275,7 +1275,7 @@ static void *spapr_build_fdt(sPAPRMachineState *s=
papr,
>      _FDT(fdt_setprop_cell(fdt, 0, "#size-cells", 2));
> =20
>      /* /interrupt controller */
> -    spapr->irq->dt_populate(spapr, spapr_max_server_number(spapr), fdt=
,
> +    spapr_irq_dt_populate(spapr, spapr_max_server_number(spapr), fdt,
>                            PHANDLE_INTC);
> =20
>      ret =3D spapr_populate_memory(spapr, fdt);
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index 396dd09bdbe0..b3e0713428ed 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -11,6 +11,7 @@
>  #include "qemu/log.h"
>  #include "qemu/error-report.h"
>  #include "qapi/error.h"
> +#include "hw/ppc/fdt.h"
>  #include "hw/ppc/spapr.h"
>  #include "hw/ppc/spapr_xive.h"
>  #include "hw/ppc/xics.h"
> @@ -536,11 +537,10 @@ static void spapr_irq_print_info_dual(sPAPRMachin=
eState *spapr, Monitor *mon)
>      spapr_irq_current(spapr)->print_info(spapr, mon);
>  }
> =20
> -static void spapr_irq_dt_populate_dual(sPAPRMachineState *spapr,
> -                                       uint32_t nr_servers, void *fdt,
> -                                       uint32_t phandle)
> +static int spapr_irq_dt_populate_dual(sPAPRMachineState *spapr,
> +                                      uint32_t nr_servers, void *fdt)
>  {
> -    spapr_irq_current(spapr)->dt_populate(spapr, nr_servers, fdt, phan=
dle);
> +    return spapr_irq_current(spapr)->dt_populate(spapr, nr_servers, fd=
t);
>  }
> =20
>  static void spapr_irq_cpu_intc_create_dual(sPAPRMachineState *spapr,
> @@ -671,6 +671,15 @@ void spapr_irq_reset(sPAPRMachineState *spapr, Err=
or **errp)
>      }
>  }
> =20
> +void spapr_irq_dt_populate(sPAPRMachineState *spapr, uint32_t nr_serve=
rs,
> +                           void *fdt, uint32_t phandle)
> +{
> +    int node =3D spapr->irq->dt_populate(spapr, nr_servers, fdt);
> +
> +    _FDT(fdt_setprop_cell(fdt, node, "linux,phandle", phandle));
> +    _FDT(fdt_setprop_cell(fdt, node, "phandle", phandle));
> +}
> +
>  /*
>   * XICS legacy routines - to deprecate one day
>   */
> diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
> index 42b325eb51ba..dfed6b7e9976 100644
> --- a/include/hw/ppc/spapr_irq.h
> +++ b/include/hw/ppc/spapr_irq.h
> @@ -41,8 +41,8 @@ typedef struct sPAPRIrq {
>      void (*free)(sPAPRMachineState *spapr, int irq, int num);
>      qemu_irq (*qirq)(sPAPRMachineState *spapr, int irq);
>      void (*print_info)(sPAPRMachineState *spapr, Monitor *mon);
> -    void (*dt_populate)(sPAPRMachineState *spapr, uint32_t nr_servers,
> -                        void *fdt, uint32_t phandle);
> +    int (*dt_populate)(sPAPRMachineState *spapr, uint32_t nr_servers,
> +                       void *fdt);
>      void (*cpu_intc_create)(sPAPRMachineState *spapr, PowerPCCPU *cpu,
>                              Error **errp);
>      int (*post_load)(sPAPRMachineState *spapr, int version_id);
> @@ -63,6 +63,8 @@ void spapr_irq_free(sPAPRMachineState *spapr, int irq=
, int num);
>  qemu_irq spapr_qirq(sPAPRMachineState *spapr, int irq);
>  int spapr_irq_post_load(sPAPRMachineState *spapr, int version_id);
>  void spapr_irq_reset(sPAPRMachineState *spapr, Error **errp);
> +void spapr_irq_dt_populate(sPAPRMachineState *spapr, uint32_t nr_serve=
rs,
> +                           void *fdt, uint32_t phandle);
> =20
>  /*
>   * XICS legacy routines
> diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
> index f8854a4a6a18..29dafead9ba0 100644
> --- a/include/hw/ppc/spapr_xive.h
> +++ b/include/hw/ppc/spapr_xive.h
> @@ -44,8 +44,7 @@ void spapr_xive_pic_print_info(sPAPRXive *xive, Monit=
or *mon);
>  typedef struct sPAPRMachineState sPAPRMachineState;
> =20
>  void spapr_xive_hcall_init(sPAPRMachineState *spapr);
> -void spapr_dt_xive(sPAPRMachineState *spapr, uint32_t nr_servers, void=
 *fdt,
> -                   uint32_t phandle);
> +int spapr_dt_xive(sPAPRMachineState *spapr, uint32_t nr_servers, void =
*fdt);
>  void spapr_xive_set_tctx_os_cam(XiveTCTX *tctx);
>  void spapr_xive_mmio_set_enabled(sPAPRXive *xive, bool enable);
> =20
> diff --git a/include/hw/ppc/xics_spapr.h b/include/hw/ppc/xics_spapr.h
> index b1ab27d022cf..9f51f8621f75 100644
> --- a/include/hw/ppc/xics_spapr.h
> +++ b/include/hw/ppc/xics_spapr.h
> @@ -29,8 +29,7 @@
> =20
>  #include "hw/ppc/spapr.h"
> =20
> -void spapr_dt_xics(sPAPRMachineState *spapr, uint32_t nr_servers, void=
 *fdt,
> -                   uint32_t phandle);
> +int spapr_dt_xics(sPAPRMachineState *spapr, uint32_t nr_servers, void =
*fdt);
>  int xics_kvm_init(sPAPRMachineState *spapr, Error **errp);
>  void xics_spapr_init(sPAPRMachineState *spapr);
> =20
>=20
