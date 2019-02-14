Received: from eggs.gnu.org ([209.51.188.92]:54621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1guGyd-00070B-Fj
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 08:22:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1guGsr-0002jK-Uy
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 08:17:00 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:42178)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1guGsr-0002Vs-Gh
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 08:16:57 -0500
Received: by mail-wr1-x442.google.com with SMTP id q18so6417083wrx.9
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 05:16:43 -0800 (PST)
References: <20190213065357.16076-1-yuval.shaia@oracle.com>
	<20190213065357.16076-6-yuval.shaia@oracle.com>
	<20190213102059.GB2601@work-vm>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <3d4d9979-e09e-bafb-e6e4-36dbb0078ab8@gmail.com>
Date: Thu, 14 Feb 2019 15:17:10 +0200
MIME-Version: 1.0
In-Reply-To: <20190213102059.GB2601@work-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2 4/9] {monitor,
 hw/pvrdma}: Expose device internals via monitor interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Yuval Shaia <yuval.shaia@oracle.com>
Cc: armbru@redhat.com, qemu-devel@nongnu.org



On 2/13/19 12:21 PM, Dr. David Alan Gilbert wrote:
> * Yuval Shaia (yuval.shaia@oracle.com) wrote:
>> Allow interrogating device internals through HMP interface.
>> The exposed indicators can be used for troubleshooting by developers or
>> sysadmin.
>> There is no need to expose these attributes to a management system (e.x.
>> libvirt) because (1) most of them are not "device-management' related
>> info and (2) there is no guarantee the interface is stable.
>>
>> Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
> OK for HMP
>
> Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Marcel Apfelbaum<marcel.apfelbaum@gmail.com>
Thanks,
Marcel

>> ---
>>   hmp-commands-info.hx      | 16 ++++++++
>>   hw/rdma/rdma_backend.c    | 70 ++++++++++++++++++++++++++---------
>>   hw/rdma/rdma_rm.c         |  7 ++++
>>   hw/rdma/rdma_rm_defs.h    | 27 +++++++++++++-
>>   hw/rdma/vmw/pvrdma.h      |  5 +++
>>   hw/rdma/vmw/pvrdma_hmp.h  | 21 +++++++++++
>>   hw/rdma/vmw/pvrdma_main.c | 77 +++++++++++++++++++++++++++++++++++++++
>>   monitor.c                 | 10 +++++
>>   8 files changed, 215 insertions(+), 18 deletions(-)
>>   create mode 100644 hw/rdma/vmw/pvrdma_hmp.h
>>
>> diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
>> index cbee8b944d..9153c33974 100644
>> --- a/hmp-commands-info.hx
>> +++ b/hmp-commands-info.hx
>> @@ -524,6 +524,22 @@ STEXI
>>   Show CPU statistics.
>>   ETEXI
>>   
>> +#if defined(CONFIG_PVRDMA)
>> +    {
>> +        .name       = "pvrdmacounters",
>> +        .args_type  = "",
>> +        .params     = "",
>> +        .help       = "show pvrdma device counters",
>> +        .cmd        = hmp_info_pvrdmacounters,
>> +    },
>> +
>> +STEXI
>> +@item info pvrdmacounters
>> +@findex info pvrdmacounters
>> +Show pvrdma device counters.
>> +ETEXI
>> +#endif
>> +
>>   #if defined(CONFIG_SLIRP)
>>       {
>>           .name       = "usernet",
>> diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
>> index 3a2913facf..0fb4842970 100644
>> --- a/hw/rdma/rdma_backend.c
>> +++ b/hw/rdma/rdma_backend.c
>> @@ -64,9 +64,9 @@ static inline void complete_work(enum ibv_wc_status status, uint32_t vendor_err,
>>       comp_handler(ctx, &wc);
>>   }
>>   
>> -static void rdma_poll_cq(RdmaDeviceResources *rdma_dev_res, struct ibv_cq *ibcq)
>> +static int rdma_poll_cq(RdmaDeviceResources *rdma_dev_res, struct ibv_cq *ibcq)
>>   {
>> -    int i, ne;
>> +    int i, ne, total_ne = 0;
>>       BackendCtx *bctx;
>>       struct ibv_wc wc[2];
>>   
>> @@ -89,12 +89,18 @@ static void rdma_poll_cq(RdmaDeviceResources *rdma_dev_res, struct ibv_cq *ibcq)
>>               rdma_rm_dealloc_cqe_ctx(rdma_dev_res, wc[i].wr_id);
>>               g_free(bctx);
>>           }
>> +        total_ne += ne;
>>       } while (ne > 0);
>> +    atomic_sub(&rdma_dev_res->stats.missing_cqe, total_ne);
>>       qemu_mutex_unlock(&rdma_dev_res->lock);
>>   
>>       if (ne < 0) {
>>           rdma_error_report("ibv_poll_cq fail, rc=%d, errno=%d", ne, errno);
>>       }
>> +
>> +    rdma_dev_res->stats.completions += total_ne;
>> +
>> +    return total_ne;
>>   }
>>   
>>   static void *comp_handler_thread(void *arg)
>> @@ -122,6 +128,9 @@ static void *comp_handler_thread(void *arg)
>>       while (backend_dev->comp_thread.run) {
>>           do {
>>               rc = qemu_poll_ns(pfds, 1, THR_POLL_TO * (int64_t)SCALE_MS);
>> +            if (!rc) {
>> +                backend_dev->rdma_dev_res->stats.poll_cq_ppoll_to++;
>> +            }
>>           } while (!rc && backend_dev->comp_thread.run);
>>   
>>           if (backend_dev->comp_thread.run) {
>> @@ -138,6 +147,7 @@ static void *comp_handler_thread(void *arg)
>>                                     errno);
>>               }
>>   
>> +            backend_dev->rdma_dev_res->stats.poll_cq_from_bk++;
>>               rdma_poll_cq(backend_dev->rdma_dev_res, ev_cq);
>>   
>>               ibv_ack_cq_events(ev_cq, 1);
>> @@ -271,7 +281,13 @@ int rdma_backend_query_port(RdmaBackendDev *backend_dev,
>>   
>>   void rdma_backend_poll_cq(RdmaDeviceResources *rdma_dev_res, RdmaBackendCQ *cq)
>>   {
>> -    rdma_poll_cq(rdma_dev_res, cq->ibcq);
>> +    int polled;
>> +
>> +    rdma_dev_res->stats.poll_cq_from_guest++;
>> +    polled = rdma_poll_cq(rdma_dev_res, cq->ibcq);
>> +    if (!polled) {
>> +        rdma_dev_res->stats.poll_cq_from_guest_empty++;
>> +    }
>>   }
>>   
>>   static GHashTable *ah_hash;
>> @@ -333,7 +349,7 @@ static void ah_cache_init(void)
>>   
>>   static int build_host_sge_array(RdmaDeviceResources *rdma_dev_res,
>>                                   struct ibv_sge *dsge, struct ibv_sge *ssge,
>> -                                uint8_t num_sge)
>> +                                uint8_t num_sge, uint64_t *total_length)
>>   {
>>       RdmaRmMR *mr;
>>       int ssge_idx;
>> @@ -349,6 +365,8 @@ static int build_host_sge_array(RdmaDeviceResources *rdma_dev_res,
>>           dsge->length = ssge[ssge_idx].length;
>>           dsge->lkey = rdma_backend_mr_lkey(&mr->backend_mr);
>>   
>> +        *total_length += dsge->length;
>> +
>>           dsge++;
>>       }
>>   
>> @@ -445,8 +463,10 @@ void rdma_backend_post_send(RdmaBackendDev *backend_dev,
>>               rc = mad_send(backend_dev, sgid_idx, sgid, sge, num_sge);
>>               if (rc) {
>>                   complete_work(IBV_WC_GENERAL_ERR, VENDOR_ERR_MAD_SEND, ctx);
>> +                backend_dev->rdma_dev_res->stats.mad_tx_err++;
>>               } else {
>>                   complete_work(IBV_WC_SUCCESS, 0, ctx);
>> +                backend_dev->rdma_dev_res->stats.mad_tx++;
>>               }
>>           }
>>           return;
>> @@ -458,20 +478,21 @@ void rdma_backend_post_send(RdmaBackendDev *backend_dev,
>>       rc = rdma_rm_alloc_cqe_ctx(backend_dev->rdma_dev_res, &bctx_id, bctx);
>>       if (unlikely(rc)) {
>>           complete_work(IBV_WC_GENERAL_ERR, VENDOR_ERR_NOMEM, ctx);
>> -        goto out_free_bctx;
>> +        goto err_free_bctx;
>>       }
>>   
>> -    rc = build_host_sge_array(backend_dev->rdma_dev_res, new_sge, sge, num_sge);
>> +    rc = build_host_sge_array(backend_dev->rdma_dev_res, new_sge, sge, num_sge,
>> +                              &backend_dev->rdma_dev_res->stats.tx_len);
>>       if (rc) {
>>           complete_work(IBV_WC_GENERAL_ERR, rc, ctx);
>> -        goto out_dealloc_cqe_ctx;
>> +        goto err_dealloc_cqe_ctx;
>>       }
>>   
>>       if (qp_type == IBV_QPT_UD) {
>>           wr.wr.ud.ah = create_ah(backend_dev, qp->ibpd, sgid_idx, dgid);
>>           if (!wr.wr.ud.ah) {
>>               complete_work(IBV_WC_GENERAL_ERR, VENDOR_ERR_FAIL_BACKEND, ctx);
>> -            goto out_dealloc_cqe_ctx;
>> +            goto err_dealloc_cqe_ctx;
>>           }
>>           wr.wr.ud.remote_qpn = dqpn;
>>           wr.wr.ud.remote_qkey = dqkey;
>> @@ -488,15 +509,19 @@ void rdma_backend_post_send(RdmaBackendDev *backend_dev,
>>           rdma_error_report("ibv_post_send fail, qpn=0x%x, rc=%d, errno=%d",
>>                             qp->ibqp->qp_num, rc, errno);
>>           complete_work(IBV_WC_GENERAL_ERR, VENDOR_ERR_FAIL_BACKEND, ctx);
>> -        goto out_dealloc_cqe_ctx;
>> +        goto err_dealloc_cqe_ctx;
>>       }
>>   
>> +    atomic_inc(&backend_dev->rdma_dev_res->stats.missing_cqe);
>> +    backend_dev->rdma_dev_res->stats.tx++;
>> +
>>       return;
>>   
>> -out_dealloc_cqe_ctx:
>> +err_dealloc_cqe_ctx:
>> +    backend_dev->rdma_dev_res->stats.tx_err++;
>>       rdma_rm_dealloc_cqe_ctx(backend_dev->rdma_dev_res, bctx_id);
>>   
>> -out_free_bctx:
>> +err_free_bctx:
>>       g_free(bctx);
>>   }
>>   
>> @@ -554,6 +579,9 @@ void rdma_backend_post_recv(RdmaBackendDev *backend_dev,
>>               rc = save_mad_recv_buffer(backend_dev, sge, num_sge, ctx);
>>               if (rc) {
>>                   complete_work(IBV_WC_GENERAL_ERR, rc, ctx);
>> +                rdma_dev_res->stats.mad_rx_bufs_err++;
>> +            } else {
>> +                rdma_dev_res->stats.mad_rx_bufs++;
>>               }
>>           }
>>           return;
>> @@ -565,13 +593,14 @@ void rdma_backend_post_recv(RdmaBackendDev *backend_dev,
>>       rc = rdma_rm_alloc_cqe_ctx(rdma_dev_res, &bctx_id, bctx);
>>       if (unlikely(rc)) {
>>           complete_work(IBV_WC_GENERAL_ERR, VENDOR_ERR_NOMEM, ctx);
>> -        goto out_free_bctx;
>> +        goto err_free_bctx;
>>       }
>>   
>> -    rc = build_host_sge_array(rdma_dev_res, new_sge, sge, num_sge);
>> +    rc = build_host_sge_array(rdma_dev_res, new_sge, sge, num_sge,
>> +                              &backend_dev->rdma_dev_res->stats.rx_bufs_len);
>>       if (rc) {
>>           complete_work(IBV_WC_GENERAL_ERR, rc, ctx);
>> -        goto out_dealloc_cqe_ctx;
>> +        goto err_dealloc_cqe_ctx;
>>       }
>>   
>>       wr.num_sge = num_sge;
>> @@ -582,15 +611,19 @@ void rdma_backend_post_recv(RdmaBackendDev *backend_dev,
>>           rdma_error_report("ibv_post_recv fail, qpn=0x%x, rc=%d, errno=%d",
>>                             qp->ibqp->qp_num, rc, errno);
>>           complete_work(IBV_WC_GENERAL_ERR, VENDOR_ERR_FAIL_BACKEND, ctx);
>> -        goto out_dealloc_cqe_ctx;
>> +        goto err_dealloc_cqe_ctx;
>>       }
>>   
>> +    atomic_inc(&backend_dev->rdma_dev_res->stats.missing_cqe);
>> +    rdma_dev_res->stats.rx_bufs++;
>> +
>>       return;
>>   
>> -out_dealloc_cqe_ctx:
>> +err_dealloc_cqe_ctx:
>> +    backend_dev->rdma_dev_res->stats.rx_bufs_err++;
>>       rdma_rm_dealloc_cqe_ctx(rdma_dev_res, bctx_id);
>>   
>> -out_free_bctx:
>> +err_free_bctx:
>>       g_free(bctx);
>>   }
>>   
>> @@ -929,12 +962,14 @@ static void process_incoming_mad_req(RdmaBackendDev *backend_dev,
>>       bctx = rdma_rm_get_cqe_ctx(backend_dev->rdma_dev_res, cqe_ctx_id);
>>       if (unlikely(!bctx)) {
>>           rdma_error_report("No matching ctx for req %ld", cqe_ctx_id);
>> +        backend_dev->rdma_dev_res->stats.mad_rx_err++;
>>           return;
>>       }
>>   
>>       mad = rdma_pci_dma_map(backend_dev->dev, bctx->sge.addr,
>>                              bctx->sge.length);
>>       if (!mad || bctx->sge.length < msg->umad_len + MAD_HDR_SIZE) {
>> +        backend_dev->rdma_dev_res->stats.mad_rx_err++;
>>           complete_work(IBV_WC_GENERAL_ERR, VENDOR_ERR_INV_MAD_BUFF,
>>                         bctx->up_ctx);
>>       } else {
>> @@ -949,6 +984,7 @@ static void process_incoming_mad_req(RdmaBackendDev *backend_dev,
>>           wc.byte_len = msg->umad_len;
>>           wc.status = IBV_WC_SUCCESS;
>>           wc.wc_flags = IBV_WC_GRH;
>> +        backend_dev->rdma_dev_res->stats.mad_rx++;
>>           comp_handler(bctx->up_ctx, &wc);
>>       }
>>   
>> diff --git a/hw/rdma/rdma_rm.c b/hw/rdma/rdma_rm.c
>> index 7cc597cdc8..d0f5dd0744 100644
>> --- a/hw/rdma/rdma_rm.c
>> +++ b/hw/rdma/rdma_rm.c
>> @@ -37,6 +37,7 @@ static inline void res_tbl_init(const char *name, RdmaRmResTbl *tbl,
>>       tbl->bitmap = bitmap_new(tbl_sz);
>>       tbl->tbl_sz = tbl_sz;
>>       tbl->res_sz = res_sz;
>> +    tbl->used = 0;
>>       qemu_mutex_init(&tbl->lock);
>>   }
>>   
>> @@ -76,6 +77,8 @@ static inline void *rdma_res_tbl_alloc(RdmaRmResTbl *tbl, uint32_t *handle)
>>   
>>       set_bit(*handle, tbl->bitmap);
>>   
>> +    tbl->used++;
>> +
>>       qemu_mutex_unlock(&tbl->lock);
>>   
>>       memset(tbl->tbl + *handle * tbl->res_sz, 0, tbl->res_sz);
>> @@ -93,6 +96,7 @@ static inline void rdma_res_tbl_dealloc(RdmaRmResTbl *tbl, uint32_t handle)
>>   
>>       if (handle < tbl->tbl_sz) {
>>           clear_bit(handle, tbl->bitmap);
>> +        tbl->used--;
>>       }
>>   
>>       qemu_mutex_unlock(&tbl->lock);
>> @@ -620,6 +624,9 @@ int rdma_rm_init(RdmaDeviceResources *dev_res, struct ibv_device_attr *dev_attr,
>>   
>>       qemu_mutex_init(&dev_res->lock);
>>   
>> +    memset(&dev_res->stats, 0, sizeof(dev_res->stats));
>> +    atomic_set(&dev_res->stats.missing_cqe, 0);
>> +
>>       return 0;
>>   }
>>   
>> diff --git a/hw/rdma/rdma_rm_defs.h b/hw/rdma/rdma_rm_defs.h
>> index f0ee1f3072..325bbf58ec 100644
>> --- a/hw/rdma/rdma_rm_defs.h
>> +++ b/hw/rdma/rdma_rm_defs.h
>> @@ -34,7 +34,9 @@
>>   #define MAX_QP_INIT_RD_ATOM   16
>>   #define MAX_AH                64
>>   
>> -#define MAX_RM_TBL_NAME 16
>> +#define MAX_RM_TBL_NAME             16
>> +#define MAX_CONSEQ_EMPTY_POLL_CQ    4096 /* considered as error above this */
>> +
>>   typedef struct RdmaRmResTbl {
>>       char name[MAX_RM_TBL_NAME];
>>       QemuMutex lock;
>> @@ -42,6 +44,7 @@ typedef struct RdmaRmResTbl {
>>       size_t tbl_sz;
>>       size_t res_sz;
>>       void *tbl;
>> +    uint32_t used; /* number of used entries in the table */
>>   } RdmaRmResTbl;
>>   
>>   typedef struct RdmaRmPD {
>> @@ -96,6 +99,27 @@ typedef struct RdmaRmPort {
>>       enum ibv_port_state state;
>>   } RdmaRmPort;
>>   
>> +typedef struct RdmaRmStats {
>> +    uint64_t tx;
>> +    uint64_t tx_len;
>> +    uint64_t tx_err;
>> +    uint64_t rx_bufs;
>> +    uint64_t rx_bufs_len;
>> +    uint64_t rx_bufs_err;
>> +    uint64_t completions;
>> +    uint64_t mad_tx;
>> +    uint64_t mad_tx_err;
>> +    uint64_t mad_rx;
>> +    uint64_t mad_rx_err;
>> +    uint64_t mad_rx_bufs;
>> +    uint64_t mad_rx_bufs_err;
>> +    uint64_t poll_cq_from_bk;
>> +    uint64_t poll_cq_from_guest;
>> +    uint64_t poll_cq_from_guest_empty;
>> +    uint64_t poll_cq_ppoll_to;
>> +    uint64_t missing_cqe;
>> +} RdmaRmStats;
>> +
>>   typedef struct RdmaDeviceResources {
>>       RdmaRmPort port;
>>       RdmaRmResTbl pd_tbl;
>> @@ -106,6 +130,7 @@ typedef struct RdmaDeviceResources {
>>       RdmaRmResTbl cqe_ctx_tbl;
>>       GHashTable *qp_hash; /* Keeps mapping between real and emulated */
>>       QemuMutex lock;
>> +    RdmaRmStats stats;
>>   } RdmaDeviceResources;
>>   
>>   #endif
>> diff --git a/hw/rdma/vmw/pvrdma.h b/hw/rdma/vmw/pvrdma.h
>> index 0879224957..167706ec2c 100644
>> --- a/hw/rdma/vmw/pvrdma.h
>> +++ b/hw/rdma/vmw/pvrdma.h
>> @@ -70,6 +70,10 @@ typedef struct DSRInfo {
>>       PvrdmaRing cq;
>>   } DSRInfo;
>>   
>> +typedef struct PVRDMADevStats {
>> +    uint64_t commands;
>> +} PVRDMADevStats;
>> +
>>   typedef struct PVRDMADev {
>>       PCIDevice parent_obj;
>>       MemoryRegion msix;
>> @@ -89,6 +93,7 @@ typedef struct PVRDMADev {
>>       CharBackend mad_chr;
>>       VMXNET3State *func0;
>>       Notifier shutdown_notifier;
>> +    PVRDMADevStats stats;
>>   } PVRDMADev;
>>   #define PVRDMA_DEV(dev) OBJECT_CHECK(PVRDMADev, (dev), PVRDMA_HW_NAME)
>>   
>> diff --git a/hw/rdma/vmw/pvrdma_hmp.h b/hw/rdma/vmw/pvrdma_hmp.h
>> new file mode 100644
>> index 0000000000..2449bd2aef
>> --- /dev/null
>> +++ b/hw/rdma/vmw/pvrdma_hmp.h
>> @@ -0,0 +1,21 @@
>> +/*
>> + * QEMU VMWARE paravirtual RDMA device definitions
>> + *
>> + * Copyright (C) 2018 Oracle
>> + * Copyright (C) 2018 Red Hat Inc
>> + *
>> + * Authors:
>> + *     Yuval Shaia <yuval.shaia@oracle.com>
>> + *     Marcel Apfelbaum <marcel@redhat.com>
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
>> + * See the COPYING file in the top-level directory.
>> + *
>> + */
>> +
>> +#ifndef PVRDMA_PVRDMA_HMP_H
>> +#define PVRDMA_PVRDMA_HMP_H
>> +
>> +void pvrdma_dump_counters(Monitor *mon);
>> +
>> +#endif
>> diff --git a/hw/rdma/vmw/pvrdma_main.c b/hw/rdma/vmw/pvrdma_main.c
>> index b6061f4b6e..8ffe79ceca 100644
>> --- a/hw/rdma/vmw/pvrdma_main.c
>> +++ b/hw/rdma/vmw/pvrdma_main.c
>> @@ -14,6 +14,7 @@
>>    */
>>   
>>   #include "qemu/osdep.h"
>> +#include "qemu/units.h"
>>   #include "qapi/error.h"
>>   #include "hw/hw.h"
>>   #include "hw/pci/pci.h"
>> @@ -25,6 +26,7 @@
>>   #include "cpu.h"
>>   #include "trace.h"
>>   #include "sysemu/sysemu.h"
>> +#include "monitor/monitor.h"
>>   
>>   #include "../rdma_rm.h"
>>   #include "../rdma_backend.h"
>> @@ -32,10 +34,13 @@
>>   
>>   #include <infiniband/verbs.h>
>>   #include "pvrdma.h"
>> +#include "pvrdma_hmp.h"
>>   #include "standard-headers/rdma/vmw_pvrdma-abi.h"
>>   #include "standard-headers/drivers/infiniband/hw/vmw_pvrdma/pvrdma_dev_api.h"
>>   #include "pvrdma_qp_ops.h"
>>   
>> +GSList *devices;
>> +
>>   static Property pvrdma_dev_properties[] = {
>>       DEFINE_PROP_STRING("netdev", PVRDMADev, backend_eth_device_name),
>>       DEFINE_PROP_STRING("ibdev", PVRDMADev, backend_device_name),
>> @@ -55,6 +60,71 @@ static Property pvrdma_dev_properties[] = {
>>       DEFINE_PROP_END_OF_LIST(),
>>   };
>>   
>> +static void pvrdma_dump_device_counters(gpointer data, gpointer user_data)
>> +{
>> +    Monitor *mon = user_data;
>> +    PCIDevice *pdev = data;
>> +    PVRDMADev *dev = PVRDMA_DEV(pdev);
>> +
>> +    monitor_printf(mon, "%s_%x.%x\n", pdev->name, PCI_SLOT(pdev->devfn),
>> +                   PCI_FUNC(pdev->devfn));
>> +    monitor_printf(mon, "\tcommands         : %" PRId64 "\n",
>> +                   dev->stats.commands);
>> +    monitor_printf(mon, "\ttx               : %" PRId64 "\n",
>> +                   dev->rdma_dev_res.stats.tx);
>> +    monitor_printf(mon, "\ttx_len           : %" PRId64 "\n",
>> +                   dev->rdma_dev_res.stats.tx_len);
>> +    monitor_printf(mon, "\ttx_err           : %" PRId64 "\n",
>> +                   dev->rdma_dev_res.stats.tx_err);
>> +    monitor_printf(mon, "\trx_bufs          : %" PRId64 "\n",
>> +                   dev->rdma_dev_res.stats.rx_bufs);
>> +    monitor_printf(mon, "\trx_bufs_len      : %" PRId64 "\n",
>> +                   dev->rdma_dev_res.stats.rx_bufs_len);
>> +    monitor_printf(mon, "\trx_bufs_err      : %" PRId64 "\n",
>> +                   dev->rdma_dev_res.stats.rx_bufs_err);
>> +    monitor_printf(mon, "\tcomps            : %" PRId64 "\n",
>> +                   dev->rdma_dev_res.stats.completions);
>> +    monitor_printf(mon, "\tmissing_comps    : %" PRId64 "\n",
>> +                   dev->rdma_dev_res.stats.missing_cqe);
>> +    monitor_printf(mon, "\tpoll_cq (bk)     : %" PRId64 "\n",
>> +                   dev->rdma_dev_res.stats.poll_cq_from_bk);
>> +    monitor_printf(mon, "\tpoll_cq_ppoll_to : %" PRId64 "\n",
>> +                   dev->rdma_dev_res.stats.poll_cq_ppoll_to);
>> +    monitor_printf(mon, "\tpoll_cq (fe)     : %" PRId64 "\n",
>> +                   dev->rdma_dev_res.stats.poll_cq_from_guest);
>> +    monitor_printf(mon, "\tpoll_cq_empty    : %" PRId64 "\n",
>> +                   dev->rdma_dev_res.stats.poll_cq_from_guest_empty);
>> +    monitor_printf(mon, "\tmad_tx           : %" PRId64 "\n",
>> +                   dev->rdma_dev_res.stats.mad_tx);
>> +    monitor_printf(mon, "\tmad_tx_err       : %" PRId64 "\n",
>> +                   dev->rdma_dev_res.stats.mad_tx_err);
>> +    monitor_printf(mon, "\tmad_rx           : %" PRId64 "\n",
>> +                   dev->rdma_dev_res.stats.mad_rx);
>> +    monitor_printf(mon, "\tmad_rx_err       : %" PRId64 "\n",
>> +                   dev->rdma_dev_res.stats.mad_rx_err);
>> +    monitor_printf(mon, "\tmad_rx_bufs      : %" PRId64 "\n",
>> +                   dev->rdma_dev_res.stats.mad_rx_bufs);
>> +    monitor_printf(mon, "\tmad_rx_bufs_err  : %" PRId64 "\n",
>> +                   dev->rdma_dev_res.stats.mad_rx_bufs_err);
>> +    monitor_printf(mon, "\tPDs              : %" PRId32 "\n",
>> +                   dev->rdma_dev_res.pd_tbl.used);
>> +    monitor_printf(mon, "\tMRs              : %" PRId32 "\n",
>> +                   dev->rdma_dev_res.mr_tbl.used);
>> +    monitor_printf(mon, "\tUCs              : %" PRId32 "\n",
>> +                   dev->rdma_dev_res.uc_tbl.used);
>> +    monitor_printf(mon, "\tQPs              : %" PRId32 "\n",
>> +                   dev->rdma_dev_res.qp_tbl.used);
>> +    monitor_printf(mon, "\tCQs              : %" PRId32 "\n",
>> +                   dev->rdma_dev_res.cq_tbl.used);
>> +    monitor_printf(mon, "\tCEQ_CTXs         : %" PRId32 "\n",
>> +                   dev->rdma_dev_res.cqe_ctx_tbl.used);
>> +}
>> +
>> +void pvrdma_dump_counters(Monitor *mon)
>> +{
>> +    g_slist_foreach(devices, pvrdma_dump_device_counters, mon);
>> +}
>> +
>>   static void free_dev_ring(PCIDevice *pci_dev, PvrdmaRing *ring,
>>                             void *ring_state)
>>   {
>> @@ -304,6 +374,8 @@ static void pvrdma_fini(PCIDevice *pdev)
>>   
>>       rdma_info_report("Device %s %x.%x is down", pdev->name,
>>                        PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn));
>> +
>> +    devices = g_slist_remove(devices, pdev);
>>   }
>>   
>>   static void pvrdma_stop(PVRDMADev *dev)
>> @@ -394,6 +466,7 @@ static void pvrdma_regs_write(void *opaque, hwaddr addr, uint64_t val,
>>           if (val == 0) {
>>               trace_pvrdma_regs_write(addr, val, "REQUEST", "");
>>               pvrdma_exec_cmd(dev);
>> +            dev->stats.commands++;
>>           }
>>           break;
>>       default:
>> @@ -612,9 +685,13 @@ static void pvrdma_realize(PCIDevice *pdev, Error **errp)
>>           goto out;
>>       }
>>   
>> +    memset(&dev->stats, 0, sizeof(dev->stats));
>> +
>>       dev->shutdown_notifier.notify = pvrdma_shutdown_notifier;
>>       qemu_register_shutdown_notifier(&dev->shutdown_notifier);
>>   
>> +    devices = g_slist_append(devices, pdev);
>> +
>>   out:
>>       if (rc) {
>>           pvrdma_fini(pdev);
>> diff --git a/monitor.c b/monitor.c
>> index e5de5765b8..7b757bd9b1 100644
>> --- a/monitor.c
>> +++ b/monitor.c
>> @@ -84,6 +84,9 @@
>>   #include "sysemu/iothread.h"
>>   #include "qemu/cutils.h"
>>   #include "tcg/tcg.h"
>> +#ifdef CONFIG_PVRDMA
>> +#include "hw/rdma/vmw/pvrdma_hmp.h"
>> +#endif
>>   
>>   #if defined(TARGET_S390X)
>>   #include "hw/s390x/storage-keys.h"
>> @@ -1397,6 +1400,13 @@ static void hmp_info_cpustats(Monitor *mon, const QDict *qdict)
>>       cpu_dump_statistics(cs, (FILE *)mon, &monitor_fprintf, 0);
>>   }
>>   
>> +#ifdef CONFIG_PVRDMA
>> +static void hmp_info_pvrdmacounters(Monitor *mon, const QDict *qdict)
>> +{
>> +    pvrdma_dump_counters(mon);
>> +}
>> +#endif
>> +
>>   static void hmp_info_trace_events(Monitor *mon, const QDict *qdict)
>>   {
>>       const char *name = qdict_get_try_str(qdict, "name");
>> -- 
>> 2.17.2
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
