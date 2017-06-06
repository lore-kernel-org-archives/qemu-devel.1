Received: from eggs.gnu.org ([2001:4830:134:3::10]:35150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dILoy-0008Bn-DV
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 17:15:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dILov-0002bF-D8
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 17:15:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37167)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dILov-0002aI-49
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 17:15:21 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v56LDrYw090481
	for <qemu-devel@nongnu.org>; Tue, 6 Jun 2017 17:15:18 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ax3js98wk-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 06 Jun 2017 17:15:18 -0400
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 6 Jun 2017 17:15:17 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20170606083221.9299-8-david@gibson.dropbear.id.au>
References: <20170606083221.9299-1-david@gibson.dropbear.id.au>
	<20170606083221.9299-8-david@gibson.dropbear.id.au>
Date: Tue, 06 Jun 2017 16:15:07 -0500
Message-Id: <149678370702.2548.1127222253326443579@loki>
Subject: Re: [Qemu-devel] [PATCH 7/7] spapr: Change DRC attach & detach
 methods to functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: lvivier@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com, sursingh@redhat.com, groug@kaod.org

Quoting David Gibson (2017-06-06 03:32:21)
> DRC objects have attach & detach methods, but there's only one
> implementation.  Although there are some differences in its behaviour for
> different DRC types, the overall structure is the same, so while we might
> want different method implementations for some parts, we're unlikely to
> want them for the top-level functions.
> =

> So, replace them with direct function calls.
> =

> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>

> ---
>  hw/ppc/spapr.c             | 19 ++++++-------------
>  hw/ppc/spapr_drc.c         | 18 ++++++------------
>  hw/ppc/spapr_pci.c         |  9 +++------
>  include/hw/ppc/spapr_drc.h |  7 ++++---
>  4 files changed, 19 insertions(+), 34 deletions(-)
> =

> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index e8cecaf..37466df 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2533,7 +2533,6 @@ static void spapr_add_lmbs(DeviceState *dev, uint64=
_t addr_start, uint64_t size,
>                             Error **errp)
>  {
>      sPAPRDRConnector *drc;
> -    sPAPRDRConnectorClass *drck;
>      uint32_t nr_lmbs =3D size/SPAPR_MEMORY_BLOCK_SIZE;
>      int i, fdt_offset, fdt_size;
>      void *fdt;
> @@ -2548,10 +2547,10 @@ static void spapr_add_lmbs(DeviceState *dev, uint=
64_t addr_start, uint64_t size,
>          fdt_offset =3D spapr_populate_memory_node(fdt, node, addr,
>                                                  SPAPR_MEMORY_BLOCK_SIZE);
> =

> -        drck =3D SPAPR_DR_CONNECTOR_GET_CLASS(drc);
> -        drck->attach(drc, dev, fdt, fdt_offset, !dev->hotplugged, errp);
> +        spapr_drc_attach(drc, dev, fdt, fdt_offset, !dev->hotplugged, er=
rp);
>          addr +=3D SPAPR_MEMORY_BLOCK_SIZE;
>          if (!dev->hotplugged) {
> +            sPAPRDRConnectorClass *drck =3D SPAPR_DR_CONNECTOR_GET_CLASS=
(drc);
>              /* guests expect coldplugged LMBs to be pre-allocated */
>              drck->set_allocation_state(drc, SPAPR_DR_ALLOCATION_STATE_US=
ABLE);
>              drck->set_isolation_state(drc, SPAPR_DR_ISOLATION_STATE_UNIS=
OLATED);
> @@ -2564,7 +2563,6 @@ static void spapr_add_lmbs(DeviceState *dev, uint64=
_t addr_start, uint64_t size,
>          if (dedicated_hp_event_source) {
>              drc =3D spapr_drc_by_id(TYPE_SPAPR_DRC_LMB,
>                                    addr_start / SPAPR_MEMORY_BLOCK_SIZE);
> -            drck =3D SPAPR_DR_CONNECTOR_GET_CLASS(drc);
>              spapr_hotplug_req_add_by_count_indexed(SPAPR_DR_CONNECTOR_TY=
PE_LMB,
>                                                     nr_lmbs,
>                                                     spapr_drc_index(drc));
> @@ -2749,7 +2747,6 @@ static void spapr_memory_unplug_request(HotplugHand=
ler *hotplug_dev,
>      uint64_t addr_start, addr;
>      int i;
>      sPAPRDRConnector *drc;
> -    sPAPRDRConnectorClass *drck;
>      sPAPRDIMMState *ds;
> =

>      addr_start =3D object_property_get_int(OBJECT(dimm), PC_DIMM_ADDR_PR=
OP,
> @@ -2769,14 +2766,12 @@ static void spapr_memory_unplug_request(HotplugHa=
ndler *hotplug_dev,
>                                addr / SPAPR_MEMORY_BLOCK_SIZE);
>          g_assert(drc);
> =

> -        drck =3D SPAPR_DR_CONNECTOR_GET_CLASS(drc);
> -        drck->detach(drc, dev, errp);
> +        spapr_drc_detach(drc, dev, errp);
>          addr +=3D SPAPR_MEMORY_BLOCK_SIZE;
>      }
> =

>      drc =3D spapr_drc_by_id(TYPE_SPAPR_DRC_LMB,
>                            addr_start / SPAPR_MEMORY_BLOCK_SIZE);
> -    drck =3D SPAPR_DR_CONNECTOR_GET_CLASS(drc);
>      spapr_hotplug_req_remove_by_count_indexed(SPAPR_DR_CONNECTOR_TYPE_LM=
B,
>                                                nr_lmbs, spapr_drc_index(d=
rc));
>  out:
> @@ -2831,7 +2826,6 @@ void spapr_core_unplug_request(HotplugHandler *hotp=
lug_dev, DeviceState *dev,
>  {
>      int index;
>      sPAPRDRConnector *drc;
> -    sPAPRDRConnectorClass *drck;
>      Error *local_err =3D NULL;
>      CPUCore *cc =3D CPU_CORE(dev);
>      int smt =3D kvmppc_smt_threads();
> @@ -2849,8 +2843,7 @@ void spapr_core_unplug_request(HotplugHandler *hotp=
lug_dev, DeviceState *dev,
>      drc =3D spapr_drc_by_id(TYPE_SPAPR_DRC_CPU, index * smt);
>      g_assert(drc);
> =

> -    drck =3D SPAPR_DR_CONNECTOR_GET_CLASS(drc);
> -    drck->detach(drc, dev, &local_err);
> +    spapr_drc_detach(drc, dev, &local_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
>          return;
> @@ -2894,8 +2887,8 @@ static void spapr_core_plug(HotplugHandler *hotplug=
_dev, DeviceState *dev,
>      }
> =

>      if (drc) {
> -        sPAPRDRConnectorClass *drck =3D SPAPR_DR_CONNECTOR_GET_CLASS(drc=
);
> -        drck->attach(drc, dev, fdt, fdt_offset, !dev->hotplugged, &local=
_err);
> +        spapr_drc_attach(drc, dev, fdt, fdt_offset, !dev->hotplugged,
> +                         &local_err);
>          if (local_err) {
>              g_free(fdt);
>              error_propagate(errp, local_err);
> diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> index a4ece2e..c73fae0 100644
> --- a/hw/ppc/spapr_drc.c
> +++ b/hw/ppc/spapr_drc.c
> @@ -49,8 +49,6 @@ uint32_t spapr_drc_index(sPAPRDRConnector *drc)
>  static uint32_t set_isolation_state(sPAPRDRConnector *drc,
>                                      sPAPRDRIsolationState state)
>  {
> -    sPAPRDRConnectorClass *drck =3D SPAPR_DR_CONNECTOR_GET_CLASS(drc);
> -
>      trace_spapr_drc_set_isolation_state(spapr_drc_index(drc), state);
> =

>      /* if the guest is configuring a device attached to this DRC, we
> @@ -105,7 +103,7 @@ static uint32_t set_isolation_state(sPAPRDRConnector =
*drc,
>              uint32_t drc_index =3D spapr_drc_index(drc);
>              if (drc->configured) {
>                  trace_spapr_drc_set_isolation_state_finalizing(drc_index=
);
> -                drck->detach(drc, DEVICE(drc->dev), NULL);
> +                spapr_drc_detach(drc, DEVICE(drc->dev), NULL);
>              } else {
>                  trace_spapr_drc_set_isolation_state_deferring(drc_index);
>              }
> @@ -119,8 +117,6 @@ static uint32_t set_isolation_state(sPAPRDRConnector =
*drc,
>  static uint32_t set_allocation_state(sPAPRDRConnector *drc,
>                                       sPAPRDRAllocationState state)
>  {
> -    sPAPRDRConnectorClass *drck =3D SPAPR_DR_CONNECTOR_GET_CLASS(drc);
> -
>      trace_spapr_drc_set_allocation_state(spapr_drc_index(drc), state);
> =

>      if (state =3D=3D SPAPR_DR_ALLOCATION_STATE_USABLE) {
> @@ -151,7 +147,7 @@ static uint32_t set_allocation_state(sPAPRDRConnector=
 *drc,
>              drc->allocation_state =3D=3D SPAPR_DR_ALLOCATION_STATE_UNUSA=
BLE) {
>              uint32_t drc_index =3D spapr_drc_index(drc);
>              trace_spapr_drc_set_allocation_state_finalizing(drc_index);
> -            drck->detach(drc, DEVICE(drc->dev), NULL);
> +            spapr_drc_detach(drc, DEVICE(drc->dev), NULL);
>          } else if (drc->allocation_state =3D=3D SPAPR_DR_ALLOCATION_STAT=
E_USABLE) {
>              drc->awaiting_allocation =3D false;
>          }
> @@ -281,8 +277,8 @@ static void prop_get_fdt(Object *obj, Visitor *v, con=
st char *name,
>      } while (fdt_depth !=3D 0);
>  }
> =

> -static void attach(sPAPRDRConnector *drc, DeviceState *d, void *fdt,
> -                   int fdt_start_offset, bool coldplug, Error **errp)
> +void spapr_drc_attach(sPAPRDRConnector *drc, DeviceState *d, void *fdt,
> +                      int fdt_start_offset, bool coldplug, Error **errp)
>  {
>      trace_spapr_drc_attach(spapr_drc_index(drc));
> =

> @@ -333,7 +329,7 @@ static void attach(sPAPRDRConnector *drc, DeviceState=
 *d, void *fdt,
>                               NULL, 0, NULL);
>  }
> =

> -static void detach(sPAPRDRConnector *drc, DeviceState *d, Error **errp)
> +void spapr_drc_detach(sPAPRDRConnector *drc, DeviceState *d, Error **err=
p)
>  {
>      trace_spapr_drc_detach(spapr_drc_index(drc));
> =

> @@ -436,7 +432,7 @@ static void reset(DeviceState *d)
>           * force removal if we are
>           */
>          if (drc->awaiting_release) {
> -            drck->detach(drc, DEVICE(drc->dev), NULL);
> +            spapr_drc_detach(drc, DEVICE(drc->dev), NULL);
>          }
> =

>          /* non-PCI devices may be awaiting a transition to UNUSABLE */
> @@ -607,8 +603,6 @@ static void spapr_dr_connector_class_init(ObjectClass=
 *k, void *data)
>      dk->unrealize =3D unrealize;
>      drck->set_isolation_state =3D set_isolation_state;
>      drck->set_allocation_state =3D set_allocation_state;
> -    drck->attach =3D attach;
> -    drck->detach =3D detach;
>      drck->release_pending =3D release_pending;
>      drck->set_signalled =3D set_signalled;
>      /*
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index 967d7c3..46e736d 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -1349,7 +1349,6 @@ static void spapr_phb_add_pci_device(sPAPRDRConnect=
or *drc,
>                                       PCIDevice *pdev,
>                                       Error **errp)
>  {
> -    sPAPRDRConnectorClass *drck =3D SPAPR_DR_CONNECTOR_GET_CLASS(drc);
>      DeviceState *dev =3D DEVICE(pdev);
>      void *fdt =3D NULL;
>      int fdt_start_offset =3D 0, fdt_size;
> @@ -1361,8 +1360,8 @@ static void spapr_phb_add_pci_device(sPAPRDRConnect=
or *drc,
>          goto out;
>      }
> =

> -    drck->attach(drc, DEVICE(pdev),
> -                 fdt, fdt_start_offset, !dev->hotplugged, errp);
> +    spapr_drc_attach(drc, DEVICE(pdev),
> +                     fdt, fdt_start_offset, !dev->hotplugged, errp);
>  out:
>      if (*errp) {
>          g_free(fdt);
> @@ -1391,9 +1390,7 @@ static void spapr_phb_remove_pci_device(sPAPRDRConn=
ector *drc,
>                                          PCIDevice *pdev,
>                                          Error **errp)
>  {
> -    sPAPRDRConnectorClass *drck =3D SPAPR_DR_CONNECTOR_GET_CLASS(drc);
> -
> -    drck->detach(drc, DEVICE(pdev), errp);
> +    spapr_drc_detach(drc, DEVICE(pdev), errp);
>  }
> =

>  static sPAPRDRConnector *spapr_phb_get_pci_func_drc(sPAPRPHBState *phb,
> diff --git a/include/hw/ppc/spapr_drc.h b/include/hw/ppc/spapr_drc.h
> index 802c708..ec0256b 100644
> --- a/include/hw/ppc/spapr_drc.h
> +++ b/include/hw/ppc/spapr_drc.h
> @@ -225,9 +225,6 @@ typedef struct sPAPRDRConnectorClass {
>                                       sPAPRDRAllocationState state);
> =

>      /* QEMU interfaces for managing hotplug operations */
> -    void (*attach)(sPAPRDRConnector *drc, DeviceState *d, void *fdt,
> -                   int fdt_start_offset, bool coldplug, Error **errp);
> -    void (*detach)(sPAPRDRConnector *drc, DeviceState *d, Error **errp);
>      bool (*release_pending)(sPAPRDRConnector *drc);
>      void (*set_signalled)(sPAPRDRConnector *drc);
>  } sPAPRDRConnectorClass;
> @@ -243,4 +240,8 @@ sPAPRDRConnector *spapr_drc_by_id(const char *type, u=
int32_t id);
>  int spapr_drc_populate_dt(void *fdt, int fdt_offset, Object *owner,
>                            uint32_t drc_type_mask);
> =

> +void spapr_drc_attach(sPAPRDRConnector *drc, DeviceState *d, void *fdt,
> +                      int fdt_start_offset, bool coldplug, Error **errp);
> +void spapr_drc_detach(sPAPRDRConnector *drc, DeviceState *d, Error **err=
p);
> +
>  #endif /* HW_SPAPR_DRC_H */
> -- =

> 2.9.4
>=20
