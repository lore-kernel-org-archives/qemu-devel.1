Received: from eggs.gnu.org ([209.51.188.92]:56651)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1h2Kgk-0000kE-0F
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 13:57:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1h2Kgi-0008Sq-8S
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 13:57:45 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:37522)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1h2Kgh-0008QC-TT
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 13:57:44 -0500
Date: Fri, 8 Mar 2019 20:57:26 +0200
From: Yuval Shaia <yuval.shaia@oracle.com>
Message-ID: <20190308185725.GA3373@lap1>
References: <20190303203345.2472-1-yuval.shaia@oracle.com>
	<20190303203345.2472-5-yuval.shaia@oracle.com>
	<87r2bh9vae.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r2bh9vae.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH v4 4/9] {hmp,
 hw/pvrdma}: Expose device internals via monitor interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: dgilbert@redhat.com, marcel.apfelbaum@gmail.com, qemu-devel@nongnu.org

On Fri, Mar 08, 2019 at 05:37:45PM +0100, Markus Armbruster wrote:
> Yuval Shaia <yuval.shaia@oracle.com> writes:
> 
> > Allow interrogating device internals through HMP interface.
> > The exposed indicators can be used for troubleshooting by developers or
> > sysadmin.
> > There is no need to expose these attributes to a management system (e.x.
> > libvirt) because (1) most of them are not "device-management' related
> > info and (2) there is no guarantee the interface is stable.
> >
> > Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
> > ---
> >  hmp-commands-info.hx       | 14 ++++++++
> >  hmp.c                      | 27 +++++++++++++++
> >  hmp.h                      |  1 +
> >  hw/rdma/Makefile.objs      |  2 +-
> >  hw/rdma/rdma_backend.c     | 70 +++++++++++++++++++++++++++++---------
> >  hw/rdma/rdma_hmp.c         | 30 ++++++++++++++++
> >  hw/rdma/rdma_rm.c          | 60 ++++++++++++++++++++++++++++++++
> >  hw/rdma/rdma_rm.h          |  1 +
> >  hw/rdma/rdma_rm_defs.h     | 27 ++++++++++++++-
> >  hw/rdma/vmw/pvrdma.h       |  5 +++
> >  hw/rdma/vmw/pvrdma_main.c  | 21 ++++++++++++
> >  include/hw/rdma/rdma_hmp.h | 40 ++++++++++++++++++++++
> >  12 files changed, 279 insertions(+), 19 deletions(-)
> >  create mode 100644 hw/rdma/rdma_hmp.c
> >  create mode 100644 include/hw/rdma/rdma_hmp.h
> >
> > diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
> > index cbee8b944d..c59444c461 100644
> > --- a/hmp-commands-info.hx
> > +++ b/hmp-commands-info.hx
> > @@ -202,6 +202,20 @@ STEXI
> >  @item info pic
> >  @findex info pic
> >  Show PIC state.
> > +ETEXI
> > +
> > +    {
> > +        .name       = "rdma",
> > +        .args_type  = "",
> > +        .params     = "",
> > +        .help       = "show RDMA state",
> > +        .cmd        = hmp_info_rdma,
> > +    },
> > +
> > +STEXI
> > +@item info rdma
> > +@findex info rdma
> > +Show RDMA state.
> >  ETEXI
> >  
> >      {
> > diff --git a/hmp.c b/hmp.c
> > index 1e006eeb49..68511b2441 100644
> > --- a/hmp.c
> > +++ b/hmp.c
> > @@ -51,6 +51,7 @@
> >  #include "qemu/error-report.h"
> >  #include "exec/ramlist.h"
> >  #include "hw/intc/intc.h"
> > +#include "hw/rdma/rdma_hmp.h"
> >  #include "migration/snapshot.h"
> >  #include "migration/misc.h"
> >  
> > @@ -968,6 +969,32 @@ void hmp_info_pic(Monitor *mon, const QDict *qdict)
> >                                     hmp_info_pic_foreach, mon);
> >  }
> >  
> > +static int hmp_info_rdma_foreach(Object *obj, void *opaque)
> > +{
> > +    RdmaStatsProvider *rdma;
> > +    RdmaStatsProviderClass *k;
> > +    Monitor *mon = opaque;
> > +
> > +    if (object_dynamic_cast(obj, TYPE_RDMA_STATS_PROVIDER)) {
> > +        rdma = RDMA_STATS_PROVIDER(obj);
> > +        k = RDMA_STATS_PROVIDER_GET_CLASS(obj);
> > +        if (k->print_statistics) {
> > +            k->print_statistics(mon, rdma);
> > +        } else {
> > +            monitor_printf(mon, "RDMA statistics not available for %s.\n",
> > +                           object_get_typename(obj));
> > +        }
> > +    }
> > +
> > +    return 0;
> > +}
> > +
> > +void hmp_info_rdma(Monitor *mon, const QDict *qdict)
> > +{
> > +    object_child_foreach_recursive(object_get_root(),
> > +                                   hmp_info_rdma_foreach, mon);
> > +}
> > +
> >  void hmp_info_pci(Monitor *mon, const QDict *qdict)
> >  {
> >      PciInfoList *info_list, *info;
> > diff --git a/hmp.h b/hmp.h
> > index 5f1addcca2..666949afc3 100644
> > --- a/hmp.h
> > +++ b/hmp.h
> > @@ -36,6 +36,7 @@ void hmp_info_spice(Monitor *mon, const QDict *qdict);
> >  void hmp_info_balloon(Monitor *mon, const QDict *qdict);
> >  void hmp_info_irq(Monitor *mon, const QDict *qdict);
> >  void hmp_info_pic(Monitor *mon, const QDict *qdict);
> > +void hmp_info_rdma(Monitor *mon, const QDict *qdict);
> >  void hmp_info_pci(Monitor *mon, const QDict *qdict);
> >  void hmp_info_block_jobs(Monitor *mon, const QDict *qdict);
> >  void hmp_info_tpm(Monitor *mon, const QDict *qdict);
> 
> HMP stuff looks good to me.
> 
> > diff --git a/hw/rdma/Makefile.objs b/hw/rdma/Makefile.objs
> > index bd36cbf51c..dd59faff51 100644
> > --- a/hw/rdma/Makefile.objs
> > +++ b/hw/rdma/Makefile.objs
> > @@ -1,5 +1,5 @@
> >  ifeq ($(CONFIG_PVRDMA),y)
> > -obj-$(CONFIG_PCI) += rdma_utils.o rdma_backend.o rdma_rm.o
> > +obj-$(CONFIG_PCI) += rdma_utils.o rdma_backend.o rdma_rm.o rdma_hmp.o
> >  obj-$(CONFIG_PCI) += vmw/pvrdma_dev_ring.o vmw/pvrdma_cmd.o \
> >                       vmw/pvrdma_qp_ops.o vmw/pvrdma_main.o
> >  endif
> > diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
> > index 9679b842d1..bc2fefcf93 100644
> > --- a/hw/rdma/rdma_backend.c
> > +++ b/hw/rdma/rdma_backend.c
> 
> The changes to this file look like they're for gathering stats.  The
> patch would be much simpler to review had you kept the stats gathering
> separate.  I can only review the HMP / QOM part, and to do that, I have
> to identify what to ignore.
> 
> [...]
> > diff --git a/hw/rdma/rdma_hmp.c b/hw/rdma/rdma_hmp.c
> > new file mode 100644
> > index 0000000000..c5814473c5
> > --- /dev/null
> > +++ b/hw/rdma/rdma_hmp.c
> > @@ -0,0 +1,30 @@
> > +/*
> > + * RDMA device: Human Monitor interface
> 
> The file name and this comment are a bit akward.  Yes, you create
> TYPE_RDMA_STATS_PROVIDER for use in HMP info rdma, but there's
> absolutely nothing HMP-related in this file.  Same for rdma_hmp.h below.
> 
> Call them rdma_stats.c and rdma_stats.h?
> 
> > + *
> > + * Copyright (C) 2018 Oracle
> > + * Copyright (C) 2018 Red Hat Inc
> > + *
> > + * Authors:
> > + *     Yuval Shaia <yuval.shaia@oracle.com>
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> > + * See the COPYING file in the top-level directory.
> > + *
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "hw/rdma/rdma_hmp.h"
> > +#include "qemu/module.h"
> > +
> > +static const TypeInfo rdma_hmp_info = {
> > +    .name = TYPE_RDMA_STATS_PROVIDER,
> > +    .parent = TYPE_INTERFACE,
> > +    .class_size = sizeof(RdmaStatsProviderClass),
> > +};
> > +
> > +static void rdma_hmp_register_types(void)
> > +{
> > +    type_register_static(&rdma_hmp_info);
> > +}
> > +
> > +type_init(rdma_hmp_register_types)
> 
> Also rename _hmp_ to _stats_.
> 
> > diff --git a/hw/rdma/rdma_rm.c b/hw/rdma/rdma_rm.c
> > index 14580ca379..e019de1a14 100644
> > --- a/hw/rdma/rdma_rm.c
> > +++ b/hw/rdma/rdma_rm.c
> > @@ -16,6 +16,7 @@
> >  #include "qemu/osdep.h"
> >  #include "qapi/error.h"
> >  #include "cpu.h"
> > +#include "monitor/monitor.h"
> >  
> >  #include "trace.h"
> >  #include "rdma_utils.h"
> > @@ -26,6 +27,58 @@
> >  #define PG_DIR_SZ { TARGET_PAGE_SIZE / sizeof(__u64) }
> >  #define PG_TBL_SZ { TARGET_PAGE_SIZE / sizeof(__u64) }
> >  
> > +void rdma_dump_device_counters(Monitor *mon, RdmaDeviceResources *dev_res)
> > +{
> > +    monitor_printf(mon, "\ttx               : %" PRId64 "\n",
> > +                   dev_res->stats.tx);
> > +    monitor_printf(mon, "\ttx_len           : %" PRId64 "\n",
> > +                   dev_res->stats.tx_len);
> > +    monitor_printf(mon, "\ttx_err           : %" PRId64 "\n",
> > +                   dev_res->stats.tx_err);
> > +    monitor_printf(mon, "\trx_bufs          : %" PRId64 "\n",
> > +                   dev_res->stats.rx_bufs);
> > +    monitor_printf(mon, "\trx_bufs_len      : %" PRId64 "\n",
> > +                   dev_res->stats.rx_bufs_len);
> > +    monitor_printf(mon, "\trx_bufs_err      : %" PRId64 "\n",
> > +                   dev_res->stats.rx_bufs_err);
> > +    monitor_printf(mon, "\tcomps            : %" PRId64 "\n",
> > +                   dev_res->stats.completions);
> > +    monitor_printf(mon, "\tmissing_comps    : %" PRId32 "\n",
> > +                   dev_res->stats.missing_cqe);
> > +    monitor_printf(mon, "\tpoll_cq (bk)     : %" PRId64 "\n",
> > +                   dev_res->stats.poll_cq_from_bk);
> > +    monitor_printf(mon, "\tpoll_cq_ppoll_to : %" PRId64 "\n",
> > +                   dev_res->stats.poll_cq_ppoll_to);
> > +    monitor_printf(mon, "\tpoll_cq (fe)     : %" PRId64 "\n",
> > +                   dev_res->stats.poll_cq_from_guest);
> > +    monitor_printf(mon, "\tpoll_cq_empty    : %" PRId64 "\n",
> > +                   dev_res->stats.poll_cq_from_guest_empty);
> > +    monitor_printf(mon, "\tmad_tx           : %" PRId64 "\n",
> > +                   dev_res->stats.mad_tx);
> > +    monitor_printf(mon, "\tmad_tx_err       : %" PRId64 "\n",
> > +                   dev_res->stats.mad_tx_err);
> > +    monitor_printf(mon, "\tmad_rx           : %" PRId64 "\n",
> > +                   dev_res->stats.mad_rx);
> > +    monitor_printf(mon, "\tmad_rx_err       : %" PRId64 "\n",
> > +                   dev_res->stats.mad_rx_err);
> > +    monitor_printf(mon, "\tmad_rx_bufs      : %" PRId64 "\n",
> > +                   dev_res->stats.mad_rx_bufs);
> > +    monitor_printf(mon, "\tmad_rx_bufs_err  : %" PRId64 "\n",
> > +                   dev_res->stats.mad_rx_bufs_err);
> > +    monitor_printf(mon, "\tPDs              : %" PRId32 "\n",
> > +                   dev_res->pd_tbl.used);
> > +    monitor_printf(mon, "\tMRs              : %" PRId32 "\n",
> > +                   dev_res->mr_tbl.used);
> > +    monitor_printf(mon, "\tUCs              : %" PRId32 "\n",
> > +                   dev_res->uc_tbl.used);
> > +    monitor_printf(mon, "\tQPs              : %" PRId32 "\n",
> > +                   dev_res->qp_tbl.used);
> > +    monitor_printf(mon, "\tCQs              : %" PRId32 "\n",
> > +                   dev_res->cq_tbl.used);
> > +    monitor_printf(mon, "\tCEQ_CTXs         : %" PRId32 "\n",
> > +                   dev_res->cqe_ctx_tbl.used);
> > +}
> > +
> >  static inline void res_tbl_init(const char *name, RdmaRmResTbl *tbl,
> >                                  uint32_t tbl_sz, uint32_t res_sz)
> >  {
> > @@ -37,6 +90,7 @@ static inline void res_tbl_init(const char *name, RdmaRmResTbl *tbl,
> 
> More stats gathering, I think.
> 
> [...]
> > diff --git a/hw/rdma/rdma_rm.h b/hw/rdma/rdma_rm.h
> > index 9ec87d2667..a527d306f6 100644
> > --- a/hw/rdma/rdma_rm.h
> > +++ b/hw/rdma/rdma_rm.h
> > @@ -20,6 +20,7 @@
> >  #include "rdma_backend_defs.h"
> >  #include "rdma_rm_defs.h"
> >  
> > +void rdma_dump_device_counters(Monitor *mon, RdmaDeviceResources *dev_res);
> >  int rdma_rm_init(RdmaDeviceResources *dev_res, struct ibv_device_attr *dev_attr,
> >                   Error **errp);
> >  void rdma_rm_fini(RdmaDeviceResources *dev_res, RdmaBackendDev *backend_dev,
> > diff --git a/hw/rdma/rdma_rm_defs.h b/hw/rdma/rdma_rm_defs.h
> > index f0ee1f3072..4b8d704cfe 100644
> > --- a/hw/rdma/rdma_rm_defs.h
> > +++ b/hw/rdma/rdma_rm_defs.h
> 
> Still more stats gathering, I think.
> 
> [...]
> > diff --git a/hw/rdma/vmw/pvrdma_main.c b/hw/rdma/vmw/pvrdma_main.c
> > index b6061f4b6e..659331ac93 100644
> > --- a/hw/rdma/vmw/pvrdma_main.c
> > +++ b/hw/rdma/vmw/pvrdma_main.c
> > @@ -25,6 +25,8 @@
> >  #include "cpu.h"
> >  #include "trace.h"
> >  #include "sysemu/sysemu.h"
> > +#include "monitor/monitor.h"
> > +#include "hw/rdma/rdma_hmp.h"
> >  
> >  #include "../rdma_rm.h"
> >  #include "../rdma_backend.h"
> > @@ -55,6 +57,18 @@ static Property pvrdma_dev_properties[] = {
> >      DEFINE_PROP_END_OF_LIST(),
> >  };
> >  
> > +static void pvrdma_print_statistics(Monitor *mon, RdmaStatsProvider *obj)
> > +{
> > +    PVRDMADev *dev = PVRDMA_DEV(obj);
> > +    PCIDevice *pdev = PCI_DEVICE(dev);
> > +
> > +    monitor_printf(mon, "%s, %x.%x\n", pdev->name, PCI_SLOT(pdev->devfn),
> > +                   PCI_FUNC(pdev->devfn));
> > +    monitor_printf(mon, "\tcommands         : %" PRId64 "\n",
> > +                   dev->stats.commands);
> > +    rdma_dump_device_counters(mon, &dev->rdma_dev_res);
> > +}
> > +
> >  static void free_dev_ring(PCIDevice *pci_dev, PvrdmaRing *ring,
> >                            void *ring_state)
> >  {
> > @@ -394,6 +408,7 @@ static void pvrdma_regs_write(void *opaque, hwaddr addr, uint64_t val,
> 
> Still more stats gathering, I think.
> 
> [...]
> > @@ -631,6 +648,7 @@ static void pvrdma_class_init(ObjectClass *klass, void *data)
> >  {
> >      DeviceClass *dc = DEVICE_CLASS(klass);
> >      PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
> > +    RdmaStatsProviderClass *ir = RDMA_STATS_PROVIDER_CLASS(klass);
> >  
> >      k->realize = pvrdma_realize;
> >      k->exit = pvrdma_exit;
> > @@ -642,6 +660,8 @@ static void pvrdma_class_init(ObjectClass *klass, void *data)
> >      dc->desc = "RDMA Device";
> >      dc->props = pvrdma_dev_properties;
> >      set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
> > +
> > +    ir->print_statistics = pvrdma_print_statistics;
> >  }
> >  
> >  static const TypeInfo pvrdma_info = {
> > @@ -651,6 +671,7 @@ static const TypeInfo pvrdma_info = {
> >      .class_init = pvrdma_class_init,
> >      .interfaces = (InterfaceInfo[]) {
> >          { INTERFACE_CONVENTIONAL_PCI_DEVICE },
> > +        { TYPE_RDMA_STATS_PROVIDER },
> 
> We use INTERFACE_ rather than TYPE_ for some, but not all interfaces.
> You follow TYPE_INTERRUPT_STATS_PROVIDER precedence.  We suck.  Not your
> problem to solve.
> 
> >          { }
> >      }
> >  };
> > diff --git a/include/hw/rdma/rdma_hmp.h b/include/hw/rdma/rdma_hmp.h
> > new file mode 100644
> > index 0000000000..dd23f2bc84
> > --- /dev/null
> > +++ b/include/hw/rdma/rdma_hmp.h
> > @@ -0,0 +1,40 @@
> > +/*
> > + * RDMA device: Human Monitor interface
> > + *
> > + * Copyright (C) 2019 Oracle
> > + * Copyright (C) 2019 Red Hat Inc
> > + *
> > + * Authors:
> > + *     Yuval Shaia <yuval.shaia@oracle.com>
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> > + * See the COPYING file in the top-level directory.
> > + *
> > + */
> > +
> > +#ifndef RDMA_HMP_H
> > +#define RDMA_HMP_H
> > +
> > +#include "qom/object.h"
> > +
> > +#define TYPE_RDMA_STATS_PROVIDER "rdma"
> > +
> > +#define RDMA_STATS_PROVIDER_CLASS(klass) \
> > +    OBJECT_CLASS_CHECK(RdmaStatsProviderClass, (klass), \
> > +                       TYPE_RDMA_STATS_PROVIDER)
> > +#define RDMA_STATS_PROVIDER_GET_CLASS(obj) \
> > +    OBJECT_GET_CLASS(RdmaStatsProviderClass, (obj), \
> > +                     TYPE_RDMA_STATS_PROVIDER)
> > +#define RDMA_STATS_PROVIDER(obj) \
> > +    INTERFACE_CHECK(RdmaStatsProvider, (obj), \
> > +                    TYPE_RDMA_STATS_PROVIDER)
> > +
> > +typedef struct RdmaStatsProvider RdmaStatsProvider;
> > +
> > +typedef struct RdmaStatsProviderClass {
> > +    InterfaceClass parent;
> > +
> > +    void (*print_statistics)(Monitor *mon, RdmaStatsProvider *obj);
> > +} RdmaStatsProviderClass;
> > +
> > +#endif
> 
> I think using QOM to find the RDMA devices came out rather nicely.
> Thanks for giving it a try.
> 
> Please consider the renames I recommended.

Will do, it perfectly make sense.

> 
> Acked-by: Markus Armbruster <armbru@redhat.com>

Thanks.
