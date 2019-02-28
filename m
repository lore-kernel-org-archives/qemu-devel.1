Received: from eggs.gnu.org ([209.51.188.92]:39203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gzHZc-0006NO-8f
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 04:01:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gzHZV-00085y-Nn
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 04:01:48 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:42152)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1gzHZV-00085q-C7
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 04:01:41 -0500
Date: Thu, 28 Feb 2019 11:01:30 +0200
From: Yuval Shaia <yuval.shaia@oracle.com>
Message-ID: <20190228090129.GA5576@lap1>
References: <20190227140629.1569-1-yuval.shaia@oracle.com>
	<20190227140629.1569-5-yuval.shaia@oracle.com>
	<152bf41f-8eea-d112-77d3-cd334c5bb4f7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <152bf41f-8eea-d112-77d3-cd334c5bb4f7@gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 4/9] {monitor,
 hw/pvrdma}: Expose device internals via monitor interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: dgilbert@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org

On Thu, Feb 28, 2019 at 10:35:38AM +0200, Marcel Apfelbaum wrote:
> Hi Yuval,
>=20
> On 2/27/19 4:06 PM, Yuval Shaia wrote:
> > Allow interrogating device internals through HMP interface.
> > The exposed indicators can be used for troubleshooting by developers =
or
> > sysadmin.
> > There is no need to expose these attributes to a management system (e=
.x.
> > libvirt) because (1) most of them are not "device-management' related
> > info and (2) there is no guarantee the interface is stable.
> >=20
> > Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
> > ---
> >   hmp-commands-info.hx      | 16 ++++++++
> >   hw/rdma/rdma_backend.c    | 70 ++++++++++++++++++++++++++---------
> >   hw/rdma/rdma_rm.c         |  7 ++++
> >   hw/rdma/rdma_rm_defs.h    | 27 +++++++++++++-
> >   hw/rdma/vmw/pvrdma.h      |  5 +++
> >   hw/rdma/vmw/pvrdma_hmp.h  | 21 +++++++++++
> >   hw/rdma/vmw/pvrdma_main.c | 77 ++++++++++++++++++++++++++++++++++++=
+++
> >   monitor.c                 | 10 +++++
> >   8 files changed, 215 insertions(+), 18 deletions(-)
> >   create mode 100644 hw/rdma/vmw/pvrdma_hmp.h
> >=20
> > diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
> > index cbee8b944d..9153c33974 100644
> > --- a/hmp-commands-info.hx
> > +++ b/hmp-commands-info.hx
> > @@ -524,6 +524,22 @@ STEXI
> >   Show CPU statistics.
> >   ETEXI
> > +#if defined(CONFIG_PVRDMA)
> > +    {
> > +        .name       =3D "pvrdmacounters",
> > +        .args_type  =3D "",
> > +        .params     =3D "",
> > +        .help       =3D "show pvrdma device counters",
> > +        .cmd        =3D hmp_info_pvrdmacounters,
> > +    },
> > +
> > +STEXI
> > +@item info pvrdmacounters
> > +@findex info pvrdmacounters
> > +Show pvrdma device counters.
> > +ETEXI
> > +#endif
> > +
> >   #if defined(CONFIG_SLIRP)
> >       {
> >           .name       =3D "usernet",
> > diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
> > index 9679b842d1..bc2fefcf93 100644
> > --- a/hw/rdma/rdma_backend.c
> > +++ b/hw/rdma/rdma_backend.c
> > @@ -64,9 +64,9 @@ static inline void complete_work(enum ibv_wc_status=
 status, uint32_t vendor_err,
> >       comp_handler(ctx, &wc);
> >   }
> > -static void rdma_poll_cq(RdmaDeviceResources *rdma_dev_res, struct i=
bv_cq *ibcq)
> > +static int rdma_poll_cq(RdmaDeviceResources *rdma_dev_res, struct ib=
v_cq *ibcq)
> >   {
> > -    int i, ne;
> > +    int i, ne, total_ne =3D 0;
> >       BackendCtx *bctx;
> >       struct ibv_wc wc[2];
> > @@ -89,12 +89,18 @@ static void rdma_poll_cq(RdmaDeviceResources *rdm=
a_dev_res, struct ibv_cq *ibcq)
> >               rdma_rm_dealloc_cqe_ctx(rdma_dev_res, wc[i].wr_id);
> >               g_free(bctx);
> >           }
> > +        total_ne +=3D ne;
> >       } while (ne > 0);
> > +    atomic_sub(&rdma_dev_res->stats.missing_cqe, total_ne);
> >       qemu_mutex_unlock(&rdma_dev_res->lock);
> >       if (ne < 0) {
> >           rdma_error_report("ibv_poll_cq fail, rc=3D%d, errno=3D%d", =
ne, errno);
> >       }
> > +
> > +    rdma_dev_res->stats.completions +=3D total_ne;
> > +
> > +    return total_ne;
> >   }
> >   static void *comp_handler_thread(void *arg)
> > @@ -122,6 +128,9 @@ static void *comp_handler_thread(void *arg)
> >       while (backend_dev->comp_thread.run) {
> >           do {
> >               rc =3D qemu_poll_ns(pfds, 1, THR_POLL_TO * (int64_t)SCA=
LE_MS);
> > +            if (!rc) {
> > +                backend_dev->rdma_dev_res->stats.poll_cq_ppoll_to++;
> > +            }
> >           } while (!rc && backend_dev->comp_thread.run);
> >           if (backend_dev->comp_thread.run) {
> > @@ -138,6 +147,7 @@ static void *comp_handler_thread(void *arg)
> >                                     errno);
> >               }
> > +            backend_dev->rdma_dev_res->stats.poll_cq_from_bk++;
> >               rdma_poll_cq(backend_dev->rdma_dev_res, ev_cq);
> >               ibv_ack_cq_events(ev_cq, 1);
> > @@ -271,7 +281,13 @@ int rdma_backend_query_port(RdmaBackendDev *back=
end_dev,
> >   void rdma_backend_poll_cq(RdmaDeviceResources *rdma_dev_res, RdmaBa=
ckendCQ *cq)
> >   {
> > -    rdma_poll_cq(rdma_dev_res, cq->ibcq);
> > +    int polled;
> > +
> > +    rdma_dev_res->stats.poll_cq_from_guest++;
> > +    polled =3D rdma_poll_cq(rdma_dev_res, cq->ibcq);
> > +    if (!polled) {
> > +        rdma_dev_res->stats.poll_cq_from_guest_empty++;
> > +    }
> >   }
> >   static GHashTable *ah_hash;
> > @@ -333,7 +349,7 @@ static void ah_cache_init(void)
> >   static int build_host_sge_array(RdmaDeviceResources *rdma_dev_res,
> >                                   struct ibv_sge *dsge, struct ibv_sg=
e *ssge,
> > -                                uint8_t num_sge)
> > +                                uint8_t num_sge, uint64_t *total_len=
gth)
> >   {
> >       RdmaRmMR *mr;
> >       int ssge_idx;
> > @@ -349,6 +365,8 @@ static int build_host_sge_array(RdmaDeviceResourc=
es *rdma_dev_res,
> >           dsge->length =3D ssge[ssge_idx].length;
> >           dsge->lkey =3D rdma_backend_mr_lkey(&mr->backend_mr);
> > +        *total_length +=3D dsge->length;
> > +
> >           dsge++;
> >       }
> > @@ -445,8 +463,10 @@ void rdma_backend_post_send(RdmaBackendDev *back=
end_dev,
> >               rc =3D mad_send(backend_dev, sgid_idx, sgid, sge, num_s=
ge);
> >               if (rc) {
> >                   complete_work(IBV_WC_GENERAL_ERR, VENDOR_ERR_MAD_SE=
ND, ctx);
> > +                backend_dev->rdma_dev_res->stats.mad_tx_err++;
> >               } else {
> >                   complete_work(IBV_WC_SUCCESS, 0, ctx);
> > +                backend_dev->rdma_dev_res->stats.mad_tx++;
> >               }
> >           }
> >           return;
> > @@ -458,20 +478,21 @@ void rdma_backend_post_send(RdmaBackendDev *bac=
kend_dev,
> >       rc =3D rdma_rm_alloc_cqe_ctx(backend_dev->rdma_dev_res, &bctx_i=
d, bctx);
> >       if (unlikely(rc)) {
> >           complete_work(IBV_WC_GENERAL_ERR, VENDOR_ERR_NOMEM, ctx);
> > -        goto out_free_bctx;
> > +        goto err_free_bctx;
> >       }
> > -    rc =3D build_host_sge_array(backend_dev->rdma_dev_res, new_sge, =
sge, num_sge);
> > +    rc =3D build_host_sge_array(backend_dev->rdma_dev_res, new_sge, =
sge, num_sge,
> > +                              &backend_dev->rdma_dev_res->stats.tx_l=
en);
> >       if (rc) {
> >           complete_work(IBV_WC_GENERAL_ERR, rc, ctx);
> > -        goto out_dealloc_cqe_ctx;
> > +        goto err_dealloc_cqe_ctx;
> >       }
> >       if (qp_type =3D=3D IBV_QPT_UD) {
> >           wr.wr.ud.ah =3D create_ah(backend_dev, qp->ibpd, sgid_idx, =
dgid);
> >           if (!wr.wr.ud.ah) {
> >               complete_work(IBV_WC_GENERAL_ERR, VENDOR_ERR_FAIL_BACKE=
ND, ctx);
> > -            goto out_dealloc_cqe_ctx;
> > +            goto err_dealloc_cqe_ctx;
> >           }
> >           wr.wr.ud.remote_qpn =3D dqpn;
> >           wr.wr.ud.remote_qkey =3D dqkey;
> > @@ -488,15 +509,19 @@ void rdma_backend_post_send(RdmaBackendDev *bac=
kend_dev,
> >           rdma_error_report("ibv_post_send fail, qpn=3D0x%x, rc=3D%d,=
 errno=3D%d",
> >                             qp->ibqp->qp_num, rc, errno);
> >           complete_work(IBV_WC_GENERAL_ERR, VENDOR_ERR_FAIL_BACKEND, =
ctx);
> > -        goto out_dealloc_cqe_ctx;
> > +        goto err_dealloc_cqe_ctx;
> >       }
> > +    atomic_inc(&backend_dev->rdma_dev_res->stats.missing_cqe);
> > +    backend_dev->rdma_dev_res->stats.tx++;
> > +
> >       return;
> > -out_dealloc_cqe_ctx:
> > +err_dealloc_cqe_ctx:
> > +    backend_dev->rdma_dev_res->stats.tx_err++;
> >       rdma_rm_dealloc_cqe_ctx(backend_dev->rdma_dev_res, bctx_id);
> > -out_free_bctx:
> > +err_free_bctx:
> >       g_free(bctx);
> >   }
> > @@ -554,6 +579,9 @@ void rdma_backend_post_recv(RdmaBackendDev *backe=
nd_dev,
> >               rc =3D save_mad_recv_buffer(backend_dev, sge, num_sge, =
ctx);
> >               if (rc) {
> >                   complete_work(IBV_WC_GENERAL_ERR, rc, ctx);
> > +                rdma_dev_res->stats.mad_rx_bufs_err++;
> > +            } else {
> > +                rdma_dev_res->stats.mad_rx_bufs++;
> >               }
> >           }
> >           return;
> > @@ -565,13 +593,14 @@ void rdma_backend_post_recv(RdmaBackendDev *bac=
kend_dev,
> >       rc =3D rdma_rm_alloc_cqe_ctx(rdma_dev_res, &bctx_id, bctx);
> >       if (unlikely(rc)) {
> >           complete_work(IBV_WC_GENERAL_ERR, VENDOR_ERR_NOMEM, ctx);
> > -        goto out_free_bctx;
> > +        goto err_free_bctx;
> >       }
> > -    rc =3D build_host_sge_array(rdma_dev_res, new_sge, sge, num_sge)=
;
> > +    rc =3D build_host_sge_array(rdma_dev_res, new_sge, sge, num_sge,
> > +                              &backend_dev->rdma_dev_res->stats.rx_b=
ufs_len);
> >       if (rc) {
> >           complete_work(IBV_WC_GENERAL_ERR, rc, ctx);
> > -        goto out_dealloc_cqe_ctx;
> > +        goto err_dealloc_cqe_ctx;
> >       }
> >       wr.num_sge =3D num_sge;
> > @@ -582,15 +611,19 @@ void rdma_backend_post_recv(RdmaBackendDev *bac=
kend_dev,
> >           rdma_error_report("ibv_post_recv fail, qpn=3D0x%x, rc=3D%d,=
 errno=3D%d",
> >                             qp->ibqp->qp_num, rc, errno);
> >           complete_work(IBV_WC_GENERAL_ERR, VENDOR_ERR_FAIL_BACKEND, =
ctx);
> > -        goto out_dealloc_cqe_ctx;
> > +        goto err_dealloc_cqe_ctx;
> >       }
> > +    atomic_inc(&backend_dev->rdma_dev_res->stats.missing_cqe);
> > +    rdma_dev_res->stats.rx_bufs++;
> > +
> >       return;
> > -out_dealloc_cqe_ctx:
> > +err_dealloc_cqe_ctx:
> > +    backend_dev->rdma_dev_res->stats.rx_bufs_err++;
> >       rdma_rm_dealloc_cqe_ctx(rdma_dev_res, bctx_id);
> > -out_free_bctx:
> > +err_free_bctx:
> >       g_free(bctx);
> >   }
> > @@ -929,12 +962,14 @@ static void process_incoming_mad_req(RdmaBacken=
dDev *backend_dev,
> >       bctx =3D rdma_rm_get_cqe_ctx(backend_dev->rdma_dev_res, cqe_ctx=
_id);
> >       if (unlikely(!bctx)) {
> >           rdma_error_report("No matching ctx for req %ld", cqe_ctx_id=
);
> > +        backend_dev->rdma_dev_res->stats.mad_rx_err++;
> >           return;
> >       }
> >       mad =3D rdma_pci_dma_map(backend_dev->dev, bctx->sge.addr,
> >                              bctx->sge.length);
> >       if (!mad || bctx->sge.length < msg->umad_len + MAD_HDR_SIZE) {
> > +        backend_dev->rdma_dev_res->stats.mad_rx_err++;
> >           complete_work(IBV_WC_GENERAL_ERR, VENDOR_ERR_INV_MAD_BUFF,
> >                         bctx->up_ctx);
> >       } else {
> > @@ -949,6 +984,7 @@ static void process_incoming_mad_req(RdmaBackendD=
ev *backend_dev,
> >           wc.byte_len =3D msg->umad_len;
> >           wc.status =3D IBV_WC_SUCCESS;
> >           wc.wc_flags =3D IBV_WC_GRH;
> > +        backend_dev->rdma_dev_res->stats.mad_rx++;
> >           comp_handler(bctx->up_ctx, &wc);
> >       }
> > diff --git a/hw/rdma/rdma_rm.c b/hw/rdma/rdma_rm.c
> > index 14580ca379..16109b9647 100644
> > --- a/hw/rdma/rdma_rm.c
> > +++ b/hw/rdma/rdma_rm.c
> > @@ -37,6 +37,7 @@ static inline void res_tbl_init(const char *name, R=
dmaRmResTbl *tbl,
> >       tbl->bitmap =3D bitmap_new(tbl_sz);
> >       tbl->tbl_sz =3D tbl_sz;
> >       tbl->res_sz =3D res_sz;
> > +    tbl->used =3D 0;
> >       qemu_mutex_init(&tbl->lock);
> >   }
> > @@ -76,6 +77,8 @@ static inline void *rdma_res_tbl_alloc(RdmaRmResTbl=
 *tbl, uint32_t *handle)
> >       set_bit(*handle, tbl->bitmap);
> > +    tbl->used++;
> > +
> >       qemu_mutex_unlock(&tbl->lock);
> >       memset(tbl->tbl + *handle * tbl->res_sz, 0, tbl->res_sz);
> > @@ -93,6 +96,7 @@ static inline void rdma_res_tbl_dealloc(RdmaRmResTb=
l *tbl, uint32_t handle)
> >       if (handle < tbl->tbl_sz) {
> >           clear_bit(handle, tbl->bitmap);
> > +        tbl->used--;
> >       }
> >       qemu_mutex_unlock(&tbl->lock);
> > @@ -620,6 +624,9 @@ int rdma_rm_init(RdmaDeviceResources *dev_res, st=
ruct ibv_device_attr *dev_attr,
> >       qemu_mutex_init(&dev_res->lock);
> > +    memset(&dev_res->stats, 0, sizeof(dev_res->stats));
> > +    atomic_set(&dev_res->stats.missing_cqe, 0);
> > +
> >       return 0;
> >   }
> > diff --git a/hw/rdma/rdma_rm_defs.h b/hw/rdma/rdma_rm_defs.h
> > index f0ee1f3072..4b8d704cfe 100644
> > --- a/hw/rdma/rdma_rm_defs.h
> > +++ b/hw/rdma/rdma_rm_defs.h
> > @@ -34,7 +34,9 @@
> >   #define MAX_QP_INIT_RD_ATOM   16
> >   #define MAX_AH                64
> > -#define MAX_RM_TBL_NAME 16
> > +#define MAX_RM_TBL_NAME             16
> > +#define MAX_CONSEQ_EMPTY_POLL_CQ    4096 /* considered as error abov=
e this */
> > +
> >   typedef struct RdmaRmResTbl {
> >       char name[MAX_RM_TBL_NAME];
> >       QemuMutex lock;
> > @@ -42,6 +44,7 @@ typedef struct RdmaRmResTbl {
> >       size_t tbl_sz;
> >       size_t res_sz;
> >       void *tbl;
> > +    uint32_t used; /* number of used entries in the table */
> >   } RdmaRmResTbl;
> >   typedef struct RdmaRmPD {
> > @@ -96,6 +99,27 @@ typedef struct RdmaRmPort {
> >       enum ibv_port_state state;
> >   } RdmaRmPort;
> > +typedef struct RdmaRmStats {
> > +    uint64_t tx;
> > +    uint64_t tx_len;
> > +    uint64_t tx_err;
> > +    uint64_t rx_bufs;
> > +    uint64_t rx_bufs_len;
> > +    uint64_t rx_bufs_err;
> > +    uint64_t completions;
> > +    uint64_t mad_tx;
> > +    uint64_t mad_tx_err;
> > +    uint64_t mad_rx;
> > +    uint64_t mad_rx_err;
> > +    uint64_t mad_rx_bufs;
> > +    uint64_t mad_rx_bufs_err;
> > +    uint64_t poll_cq_from_bk;
> > +    uint64_t poll_cq_from_guest;
> > +    uint64_t poll_cq_from_guest_empty;
> > +    uint64_t poll_cq_ppoll_to;
> > +    uint32_t missing_cqe;
> > +} RdmaRmStats;
> > +
> >   typedef struct RdmaDeviceResources {
> >       RdmaRmPort port;
> >       RdmaRmResTbl pd_tbl;
> > @@ -106,6 +130,7 @@ typedef struct RdmaDeviceResources {
> >       RdmaRmResTbl cqe_ctx_tbl;
> >       GHashTable *qp_hash; /* Keeps mapping between real and emulated=
 */
> >       QemuMutex lock;
> > +    RdmaRmStats stats;
> >   } RdmaDeviceResources;
> >   #endif
> > diff --git a/hw/rdma/vmw/pvrdma.h b/hw/rdma/vmw/pvrdma.h
> > index 0879224957..167706ec2c 100644
> > --- a/hw/rdma/vmw/pvrdma.h
> > +++ b/hw/rdma/vmw/pvrdma.h
> > @@ -70,6 +70,10 @@ typedef struct DSRInfo {
> >       PvrdmaRing cq;
> >   } DSRInfo;
> > +typedef struct PVRDMADevStats {
> > +    uint64_t commands;
> > +} PVRDMADevStats;
> > +
> >   typedef struct PVRDMADev {
> >       PCIDevice parent_obj;
> >       MemoryRegion msix;
> > @@ -89,6 +93,7 @@ typedef struct PVRDMADev {
> >       CharBackend mad_chr;
> >       VMXNET3State *func0;
> >       Notifier shutdown_notifier;
> > +    PVRDMADevStats stats;
> >   } PVRDMADev;
> >   #define PVRDMA_DEV(dev) OBJECT_CHECK(PVRDMADev, (dev), PVRDMA_HW_NA=
ME)
> > diff --git a/hw/rdma/vmw/pvrdma_hmp.h b/hw/rdma/vmw/pvrdma_hmp.h
> > new file mode 100644
> > index 0000000000..2449bd2aef
> > --- /dev/null
> > +++ b/hw/rdma/vmw/pvrdma_hmp.h
> > @@ -0,0 +1,21 @@
> > +/*
> > + * QEMU VMWARE paravirtual RDMA device definitions
> > + *
> > + * Copyright (C) 2018 Oracle
> > + * Copyright (C) 2018 Red Hat Inc
> > + *
> > + * Authors:
> > + *     Yuval Shaia <yuval.shaia@oracle.com>
> > + *     Marcel Apfelbaum <marcel@redhat.com>
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2 o=
r later.
> > + * See the COPYING file in the top-level directory.
> > + *
> > + */
> > +
> > +#ifndef PVRDMA_PVRDMA_HMP_H
> > +#define PVRDMA_PVRDMA_HMP_H
> > +
> > +void pvrdma_dump_counters(Monitor *mon);
> > +
> > +#endif
> > diff --git a/hw/rdma/vmw/pvrdma_main.c b/hw/rdma/vmw/pvrdma_main.c
> > index b6061f4b6e..85101368c5 100644
> > --- a/hw/rdma/vmw/pvrdma_main.c
> > +++ b/hw/rdma/vmw/pvrdma_main.c
> > @@ -14,6 +14,7 @@
> >    */
> >   #include "qemu/osdep.h"
> > +#include "qemu/units.h"
> >   #include "qapi/error.h"
> >   #include "hw/hw.h"
> >   #include "hw/pci/pci.h"
> > @@ -25,6 +26,7 @@
> >   #include "cpu.h"
> >   #include "trace.h"
> >   #include "sysemu/sysemu.h"
> > +#include "monitor/monitor.h"
> >   #include "../rdma_rm.h"
> >   #include "../rdma_backend.h"
> > @@ -32,10 +34,13 @@
> >   #include <infiniband/verbs.h>
> >   #include "pvrdma.h"
> > +#include "pvrdma_hmp.h"
> >   #include "standard-headers/rdma/vmw_pvrdma-abi.h"
> >   #include "standard-headers/drivers/infiniband/hw/vmw_pvrdma/pvrdma_=
dev_api.h"
> >   #include "pvrdma_qp_ops.h"
> > +GSList *devices;
> > +
> >   static Property pvrdma_dev_properties[] =3D {
> >       DEFINE_PROP_STRING("netdev", PVRDMADev, backend_eth_device_name=
),
> >       DEFINE_PROP_STRING("ibdev", PVRDMADev, backend_device_name),
> > @@ -55,6 +60,71 @@ static Property pvrdma_dev_properties[] =3D {
> >       DEFINE_PROP_END_OF_LIST(),
> >   };
> > +static void pvrdma_dump_device_counters(gpointer data, gpointer user=
_data)
> > +{
> > +    Monitor *mon =3D user_data;
> > +    PCIDevice *pdev =3D data;
> > +    PVRDMADev *dev =3D PVRDMA_DEV(pdev);
> > +
> > +    monitor_printf(mon, "%s_%x.%x\n", pdev->name, PCI_SLOT(pdev->dev=
fn),
> > +                   PCI_FUNC(pdev->devfn));
> > +    monitor_printf(mon, "\tcommands         : %" PRId64 "\n",
> > +                   dev->stats.commands);
> > +    monitor_printf(mon, "\ttx               : %" PRId64 "\n",
> > +                   dev->rdma_dev_res.stats.tx);
> > +    monitor_printf(mon, "\ttx_len           : %" PRId64 "\n",
> > +                   dev->rdma_dev_res.stats.tx_len);
> > +    monitor_printf(mon, "\ttx_err           : %" PRId64 "\n",
> > +                   dev->rdma_dev_res.stats.tx_err);
> > +    monitor_printf(mon, "\trx_bufs          : %" PRId64 "\n",
> > +                   dev->rdma_dev_res.stats.rx_bufs);
> > +    monitor_printf(mon, "\trx_bufs_len      : %" PRId64 "\n",
> > +                   dev->rdma_dev_res.stats.rx_bufs_len);
> > +    monitor_printf(mon, "\trx_bufs_err      : %" PRId64 "\n",
> > +                   dev->rdma_dev_res.stats.rx_bufs_err);
> > +    monitor_printf(mon, "\tcomps            : %" PRId64 "\n",
> > +                   dev->rdma_dev_res.stats.completions);
> > +    monitor_printf(mon, "\tmissing_comps    : %" PRId32 "\n",
> > +                   dev->rdma_dev_res.stats.missing_cqe);
> > +    monitor_printf(mon, "\tpoll_cq (bk)     : %" PRId64 "\n",
> > +                   dev->rdma_dev_res.stats.poll_cq_from_bk);
> > +    monitor_printf(mon, "\tpoll_cq_ppoll_to : %" PRId64 "\n",
> > +                   dev->rdma_dev_res.stats.poll_cq_ppoll_to);
> > +    monitor_printf(mon, "\tpoll_cq (fe)     : %" PRId64 "\n",
> > +                   dev->rdma_dev_res.stats.poll_cq_from_guest);
> > +    monitor_printf(mon, "\tpoll_cq_empty    : %" PRId64 "\n",
> > +                   dev->rdma_dev_res.stats.poll_cq_from_guest_empty)=
;
> > +    monitor_printf(mon, "\tmad_tx           : %" PRId64 "\n",
> > +                   dev->rdma_dev_res.stats.mad_tx);
> > +    monitor_printf(mon, "\tmad_tx_err       : %" PRId64 "\n",
> > +                   dev->rdma_dev_res.stats.mad_tx_err);
> > +    monitor_printf(mon, "\tmad_rx           : %" PRId64 "\n",
> > +                   dev->rdma_dev_res.stats.mad_rx);
> > +    monitor_printf(mon, "\tmad_rx_err       : %" PRId64 "\n",
> > +                   dev->rdma_dev_res.stats.mad_rx_err);
> > +    monitor_printf(mon, "\tmad_rx_bufs      : %" PRId64 "\n",
> > +                   dev->rdma_dev_res.stats.mad_rx_bufs);
> > +    monitor_printf(mon, "\tmad_rx_bufs_err  : %" PRId64 "\n",
> > +                   dev->rdma_dev_res.stats.mad_rx_bufs_err);
> > +    monitor_printf(mon, "\tPDs              : %" PRId32 "\n",
> > +                   dev->rdma_dev_res.pd_tbl.used);
> > +    monitor_printf(mon, "\tMRs              : %" PRId32 "\n",
> > +                   dev->rdma_dev_res.mr_tbl.used);
> > +    monitor_printf(mon, "\tUCs              : %" PRId32 "\n",
> > +                   dev->rdma_dev_res.uc_tbl.used);
> > +    monitor_printf(mon, "\tQPs              : %" PRId32 "\n",
> > +                   dev->rdma_dev_res.qp_tbl.used);
> > +    monitor_printf(mon, "\tCQs              : %" PRId32 "\n",
> > +                   dev->rdma_dev_res.cq_tbl.used);
> > +    monitor_printf(mon, "\tCEQ_CTXs         : %" PRId32 "\n",
> > +                   dev->rdma_dev_res.cqe_ctx_tbl.used);
>=20
> It seems the counters are not VMware specifics, I would expose
> the statistics as RDMA counters

[1]
All besides 'commands' which counts the number of commands the driver
executes.
Anyway, this one is expendable so it make sense to move the function to
rdma level so it be reused for every future (pv)rdma device.

>=20
> > +}
> > +
> > +void pvrdma_dump_counters(Monitor *mon)
> > +{
> > +    g_slist_foreach(devices, pvrdma_dump_device_counters, mon);
> > +}
> > +
> >   static void free_dev_ring(PCIDevice *pci_dev, PvrdmaRing *ring,
> >                             void *ring_state)
> >   {
> > @@ -304,6 +374,8 @@ static void pvrdma_fini(PCIDevice *pdev)
> >       rdma_info_report("Device %s %x.%x is down", pdev->name,
> >                        PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn));
> > +
> > +    devices =3D g_slist_remove(devices, pdev);
> >   }
> >   static void pvrdma_stop(PVRDMADev *dev)
> > @@ -394,6 +466,7 @@ static void pvrdma_regs_write(void *opaque, hwadd=
r addr, uint64_t val,
> >           if (val =3D=3D 0) {
> >               trace_pvrdma_regs_write(addr, val, "REQUEST", "");
> >               pvrdma_exec_cmd(dev);
> > +            dev->stats.commands++;
> >           }
> >           break;
> >       default:
> > @@ -612,9 +685,13 @@ static void pvrdma_realize(PCIDevice *pdev, Erro=
r **errp)
> >           goto out;
> >       }
> > +    memset(&dev->stats, 0, sizeof(dev->stats));
> > +
> >       dev->shutdown_notifier.notify =3D pvrdma_shutdown_notifier;
> >       qemu_register_shutdown_notifier(&dev->shutdown_notifier);
> > +    devices =3D g_slist_append(devices, pdev);
> > +
> >   out:
> >       if (rc) {
> >           pvrdma_fini(pdev);
> > diff --git a/monitor.c b/monitor.c
> > index defa129319..53ecb5bc70 100644
> > --- a/monitor.c
> > +++ b/monitor.c
> > @@ -85,6 +85,9 @@
> >   #include "sysemu/iothread.h"
> >   #include "qemu/cutils.h"
> >   #include "tcg/tcg.h"
> > +#ifdef CONFIG_PVRDMA
> > +#include "hw/rdma/vmw/pvrdma_hmp.h"
> > +#endif
> >   #if defined(TARGET_S390X)
> >   #include "hw/s390x/storage-keys.h"
> > @@ -1362,6 +1365,13 @@ static void hmp_info_cpustats(Monitor *mon, co=
nst QDict *qdict)
> >       cpu_dump_statistics(cs, (FILE *)mon, &monitor_fprintf, 0);
> >   }
> > +#ifdef CONFIG_PVRDMA
> > +static void hmp_info_pvrdmacounters(Monitor *mon, const QDict *qdict=
)
> > +{
> > +    pvrdma_dump_counters(mon);
>=20
> Compilation fails on archs with no PCI support:
>=20
> =A0=A0=A0 /usr/bin/ld: monitor.o: in function `hmp_info_pvrdmacounters'=
:
> =A0=A0=A0 /home/marcel/git/qemu/monitor.c:1371: undefined reference to
> `pvrdma_dump_counters'
> =A0=A0 collect2: error: ld returned 1 exit status
> =A0=A0 make[1]: *** [Makefile:210: qemu-system-m68k] Error 1
>=20
>=20
> The below patch solves it by adding a pci stub:
>=20
> diff --git a/hw/pci/pci-stub.c b/hw/pci/pci-stub.c
> index b941a0e842..cab364f93d 100644
> --- a/hw/pci/pci-stub.c
> +++ b/hw/pci/pci-stub.c
> @@ -26,6 +26,7 @@
> =A0#include "qapi/qmp/qerror.h"
> =A0#include "hw/pci/pci.h"
> =A0#include "hw/pci/msi.h"
> +#include "hw/rdma/vmw/pvrdma_hmp.h"
>=20
> =A0bool msi_nonbroken;
> =A0bool pci_available;
> @@ -53,3 +54,9 @@ uint16_t pci_requester_id(PCIDevice *dev)
> =A0=A0=A0=A0 g_assert(false);
> =A0=A0=A0=A0 return 0;
> =A0}
> +
> +void pvrdma_dump_counters(Monitor *mon)
> +{
> +=A0=A0=A0 monitor_printf(mon, "PVRDMA requires PCI support\n");
> +}
> +

So let me understand it correctly. This file is a place holder for every
function that operates on a PCI device but platform does not have PCI BUS=
?

>=20
>=20
>=20
> However you should include a generic rdma header as hw/rdma/rdma_hmp.h
> and not a vmw specific one.

Sure, per above [1] it make sense.

>=20
>=20
> Thanks,
> Marcel
>=20
>=20
> > +}
> > +#endif
> > +
> >   static void hmp_info_trace_events(Monitor *mon, const QDict *qdict)
> >   {
> >       const char *name =3D qdict_get_try_str(qdict, "name");
>=20
