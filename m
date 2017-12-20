Received: from eggs.gnu.org ([2001:4830:134:3::10]:36888)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1eRgFP-0003k8-Rd
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 10:25:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1eRgFL-0002KF-7w
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 10:25:31 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:37482)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1eRgFK-0002GX-9v
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 10:25:26 -0500
Date: Wed, 20 Dec 2017 17:25:11 +0200
From: Yuval Shaia <yuval.shaia@oracle.com>
Message-ID: <20171220152509.GA2526@yuvallap>
References: <20171217125457.3429-1-marcel@redhat.com>
	<20171217125457.3429-5-marcel@redhat.com>
	<20171219181257-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171219181257-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH V2 4/5] pvrdma: initial implementation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel@redhat.com>, qemu-devel@nongnu.org, ehabkost@redhat.com, imammedo@redhat.com, pbonzini@redhat.com

On Tue, Dec 19, 2017 at 07:48:44PM +0200, Michael S. Tsirkin wrote:
> I won't have time to review before the next year.
> Results of a quick peek.

Thanks for the parts you found the time to review.

> 
> On Sun, Dec 17, 2017 at 02:54:56PM +0200, Marcel Apfelbaum wrote:
> > +static void *mad_handler_thread(void *arg)
> > +{
> > +    PVRDMADev *dev = (PVRDMADev *)arg;
> > +    int rc;
> > +    QObject *o_ctx_id;
> > +    unsigned long cqe_ctx_id;
> > +    BackendCtx *bctx;
> > +    /*
> > +    int len;
> > +    void *mad;
> > +    */
> > +
> > +    pr_dbg("Starting\n");
> > +
> > +    dev->backend_dev.mad_thread.run = false;
> > +
> > +    while (dev->backend_dev.mad_thread.run) {
> > +        /* Get next buffer to pust MAD into */
> > +        o_ctx_id = qlist_pop(dev->backend_dev.mad_agent.recv_mads_list);
> > +        if (!o_ctx_id) {
> > +            /* pr_dbg("Error: No more free MADs buffers\n"); */
> > +            sleep(5);
> 
> Looks suspicious.  What is above doing?

This function is responsible to process incoming MAD messages.

Usual (good) flow is that guest driver prepares some buffers to be used for
that purpose and gives it to device with the usual post_recv mechanism.
Upon receiving a MAD message from the device the driver should pass a new
buffer to device.

But what if the device didn't do it.

This section handle such case, as we have nothing to do - let's sleep and
hope for the best.

> 
> > +            continue;
> > +        }
> > +        cqe_ctx_id = qnum_get_uint(qobject_to_qnum(o_ctx_id));
> > +        bctx = rm_get_cqe_ctx(dev, cqe_ctx_id);
> > +        if (unlikely(!bctx)) {
> > +            pr_dbg("Error: Fail to find ctx for %ld\n", cqe_ctx_id);
> > +            continue;
> > +        }
> > +
> > +        pr_dbg("Calling umad_recv\n");
> > +        /*
> > +        mad = pvrdma_pci_dma_map(PCI_DEVICE(dev), bctx->req.sge[0].addr,
> > +                                 bctx->req.sge[0].length);
> > +
> > +        len = bctx->req.sge[0].length;
> > +
> > +        do {
> > +            rc = umad_recv(dev->backend_dev.mad_agent.port_id, mad, &len, 5000);
> 
> That's a huge timeout.

This is the maximum timeout.
On low MAD traffic we don't want to take much of the CPU for that purpose
so 5 seconds looks good to me.

Anyway, just because it is not obvious i will make it configurable.

> 
> > +        } while ( (rc != ETIMEDOUT) && dev->backend_dev.mad_thread.run);
> > +        pr_dbg("umad_recv, rc=%d\n", rc);
> > +
> > +        pvrdma_pci_dma_unmap(PCI_DEVICE(dev), mad, bctx->req.sge[0].length);
> > +        */
> > +        rc = -1;
> > +
> > +        /* rc is used as vendor_err */
> > +        comp_handler(rc > 0 ? IB_WC_SUCCESS : IB_WC_GENERAL_ERR, rc,
> > +                     bctx->up_ctx);
> > +
> > +        rm_dealloc_cqe_ctx(dev, cqe_ctx_id);
> > +        free(bctx);
> > +    }
> > +
> > +    pr_dbg("Going down\n");
> > +    /* TODO: Post cqe for all remaining MADs in list */
> > +
> > +    qlist_destroy_obj(QOBJECT(dev->backend_dev.mad_agent.recv_mads_list));
> > +
> > +    return NULL;
> > +}
> > +
> > +static void *comp_handler_thread(void *arg)
> > +{
> > +    PVRDMADev *dev = (PVRDMADev *)arg;
> > +    int rc;
> > +    struct ibv_cq *ev_cq;
> > +    void *ev_ctx;
> > +
> > +    pr_dbg("Starting\n");
> > +
> > +    while (dev->backend_dev.comp_thread.run) {
> > +        pr_dbg("Waiting for completion on channel %p\n",
> > +               dev->backend_dev.channel);
> > +        rc = ibv_get_cq_event(dev->backend_dev.channel, &ev_cq, &ev_ctx);
> > +        pr_dbg("ibv_get_cq_event=%d\n", rc);
> > +        if (unlikely(rc)) {
> > +            pr_dbg("---> ibv_get_cq_event (%d)\n", rc);
> > +            continue;
> > +        }
> > +
> > +        if (unlikely(ibv_req_notify_cq(ev_cq, 0))) {
> > +            pr_dbg("---> ibv_req_notify_cq\n");
> > +        }
> > +
> > +        poll_cq(dev, ev_cq, false);
> > +
> > +        ibv_ack_cq_events(ev_cq, 1);
> > +    }
> > +
> > +    pr_dbg("Going down\n");
> > +    /* TODO: Post cqe for all remaining buffs that were posted */
> > +
> > +    return NULL;
> > +}
> > +
> > +void backend_register_comp_handler(void (*handler)(int status,
> > +                                   unsigned int vendor_err, void *ctx))
> > +{
> > +    comp_handler = handler;
> > +}
> > +
> > +int backend_query_port(BackendDevice *dev, struct pvrdma_port_attr *attrs)
> > +{
> > +    int rc;
> > +    struct ibv_port_attr port_attr;
> > +
> > +    rc = ibv_query_port(dev->context, dev->port_num, &port_attr);
> > +    if (rc) {
> > +        pr_dbg("Error %d from ibv_query_port\n", rc);
> > +        return -EIO;
> > +    }
> > +
> > +    attrs->state = port_attr.state;
> > +    attrs->max_mtu = port_attr.max_mtu;
> > +    attrs->active_mtu = port_attr.active_mtu;
> > +    attrs->gid_tbl_len = port_attr.gid_tbl_len;
> > +    attrs->pkey_tbl_len = port_attr.pkey_tbl_len;
> > +    attrs->phys_state = port_attr.phys_state;
> > +
> > +    return 0;
> > +}
> > +
> > +void backend_poll_cq(PVRDMADev *dev, BackendCQ *cq)
> > +{
> > +    poll_cq(dev, cq->ibcq, true);
> > +}
> > +
> > +static GHashTable *ah_hash;
> > +
> > +static struct ibv_ah *create_ah(BackendDevice *dev, struct ibv_pd *pd,
> > +                                union ibv_gid *dgid, uint8_t sgid_idx)
> > +{
> > +    GBytes *ah_key = g_bytes_new(dgid, sizeof(*dgid));
> > +    struct ibv_ah *ah = g_hash_table_lookup(ah_hash, ah_key);
> > +
> > +    if (ah) {
> > +        trace_create_ah_cache_hit(be64_to_cpu(dgid->global.subnet_prefix),
> > +                                  be64_to_cpu(dgid->global.interface_id));
> > +    } else {
> > +        struct ibv_ah_attr ah_attr = {
> > +            .is_global     = 1,
> > +            .port_num      = dev->port_num,
> > +            .grh.hop_limit = 1,
> > +        };
> > +
> > +        ah_attr.grh.dgid = *dgid;
> > +        ah_attr.grh.sgid_index = sgid_idx;
> > +
> > +        ah = ibv_create_ah(pd, &ah_attr);
> > +        if (ah) {
> > +            g_hash_table_insert(ah_hash, ah_key, ah);
> > +        } else {
> > +            pr_dbg("ibv_create_ah failed for gid <%lx %lx>\n",
> > +                    be64_to_cpu(dgid->global.subnet_prefix),
> > +                    be64_to_cpu(dgid->global.interface_id));
> > +        }
> > +
> > +        trace_create_ah_cache_miss(be64_to_cpu(dgid->global.subnet_prefix),
> > +                                   be64_to_cpu(dgid->global.interface_id));
> > +    }
> > +
> > +    return ah;
> > +}
> > +
> > +static void destroy_ah(gpointer data)
> > +{
> > +    struct ibv_ah *ah = data;
> > +    ibv_destroy_ah(ah);
> > +}
> > +
> > +static void ah_cache_init(void)
> > +{
> > +    ah_hash = g_hash_table_new_full(g_bytes_hash, g_bytes_equal,
> > +                                    NULL, destroy_ah);
> > +}
> > +
> > +static int send_mad(PVRDMADev *dev, struct pvrdma_sge *sge, u32 num_sge)
> > +{
> > +    int ret = -1;
> > +
> > +    /*
> > +     * TODO: Currently QP1 is not supported
> > +     *
> > +    PCIDevice *pci_dev = PCI_DEVICE(dev);
> > +    char mad_msg[1024];
> > +    void *hdr, *msg;
> > +    struct ib_user_mad *umad = (struct ib_user_mad *)&mad_msg;
> > +
> > +    umad->length = sge[0].length + sge[1].length;
> > +
> > +    if (num_sge != 2)
> > +        return -EINVAL;
> > +
> > +    pr_dbg("msg_len=%d\n", umad->length);
> > +
> > +    hdr = pvrdma_pci_dma_map(pci_dev, sge[0].addr, sge[0].length);
> > +    msg = pvrdma_pci_dma_map(pci_dev, sge[1].addr, sge[1].length);
> > +
> > +    memcpy(&mad_msg[64], hdr, sge[0].length);
> > +    memcpy(&mad_msg[sge[0].length+64], msg, sge[1].length);
> > +
> > +    pvrdma_pci_dma_unmap(pci_dev, msg, sge[1].length);
> > +    pvrdma_pci_dma_unmap(pci_dev, hdr, sge[0].length);
> > +
> > +    ret = umad_send(dev->backend_dev.mad_agent.port_id,
> > +                    dev->backend_dev.mad_agent.agent_id,
> > +                    mad_msg, umad->length, 10, 10);
> > +    */
> 
> Then what is above code doing here?

Support for QP1 is a work in progress.
In the meantime i can take this entire code out to a separate private
branch.

> 
> Also, isn't QP1 a big deal? If it's missing then how do you
> do multicast etc?

Even without QP1 the device can still be used for usual RDMA send and
receive operations, but yes, no rdma_cm and multicast for now.
Please note that vmware support for QP1 is proprietary and can be used only
between two ESX guests so we give more or less the same.

> 
> How does guest know it's missing?

I had two options, one is to reject the creation of QP1 via the control
interface and second is to post CQE with error. Since the former causes
some driver loading errors in guest i choose the second.

> 
> 
> 
> ...
> 
> > diff --git a/hw/net/pvrdma/pvrdma_utils.h b/hw/net/pvrdma/pvrdma_utils.h
> > new file mode 100644
> > index 0000000000..a09e39946c
> > --- /dev/null
> > +++ b/hw/net/pvrdma/pvrdma_utils.h
> > @@ -0,0 +1,41 @@
> > +/*
> > + * QEMU VMWARE paravirtual RDMA interface definitions
> > + *
> > + * Developed by Oracle & Redhat
> > + *
> > + * Authors:
> > + *     Yuval Shaia <yuval.shaia@oracle.com>
> > + *     Marcel Apfelbaum <marcel@redhat.com>
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2.
> > + * See the COPYING file in the top-level directory.
> > + *
> > + */
> > +
> > +#ifndef PVRDMA_UTILS_H
> > +#define PVRDMA_UTILS_H
> > +
> > +#include <include/hw/pci/pci.h>
> > +
> > +#define pr_info(fmt, ...) \
> > +    fprintf(stdout, "%s: %-20s (%3d): " fmt, "pvrdma",  __func__, __LINE__,\
> > +           ## __VA_ARGS__)
> > +
> > +#define pr_err(fmt, ...) \
> > +    fprintf(stderr, "%s: Error at %-20s (%3d): " fmt, "pvrdma", __func__, \
> > +        __LINE__, ## __VA_ARGS__)
> > +
> > +#ifdef PVRDMA_DEBUG
> > +#define pr_dbg(fmt, ...) \
> > +    fprintf(stdout, "%s: %-20s (%3d): " fmt, "pvrdma", __func__, __LINE__,\
> > +           ## __VA_ARGS__)
> > +#else
> > +#define pr_dbg(fmt, ...)
> > +#endif
> > +
> > +void pvrdma_pci_dma_unmap(PCIDevice *dev, void *buffer, dma_addr_t len);
> > +void *pvrdma_pci_dma_map(PCIDevice *dev, dma_addr_t addr, dma_addr_t plen);
> > +void *map_to_pdir(PCIDevice *pdev, uint64_t pdir_dma, uint32_t nchunks,
> > +                  size_t length);
> > +
> > +#endif
> 
> Can you make sure all prefixes are pvrdma_?

Is it a general practice or just for non-static functions?

> 
> > diff --git a/hw/net/pvrdma/trace-events b/hw/net/pvrdma/trace-events
> > new file mode 100644
> > index 0000000000..bbc52286bc
> > --- /dev/null
> > +++ b/hw/net/pvrdma/trace-events
> > @@ -0,0 +1,9 @@
> > +# See docs/tracing.txt for syntax documentation.
> > +
> > +# hw/net/pvrdma/pvrdma_main.c
> > +pvrdma_regs_read(uint64_t addr, uint64_t val) "regs[0x%lx] = 0x%lx"
> > +pvrdma_regs_write(uint64_t addr, uint64_t val) "regs[0x%lx] = 0x%lx"
> > +
> > +#hw/net/pvrdma/pvrdma_backend.c
> > +create_ah_cache_hit(uint64_t subnet, uint64_t net_id) "subnet = 0x%lx net_id = 0x%lx"
> > +create_ah_cache_miss(uint64_t subnet, uint64_t net_id) "subnet = 0x%lx net_id = 0x%lx"
> > diff --git a/include/hw/pci/pci_ids.h b/include/hw/pci/pci_ids.h
> > index 35df1874a9..1dbf53627c 100644
> > --- a/include/hw/pci/pci_ids.h
> > +++ b/include/hw/pci/pci_ids.h
> > @@ -266,4 +266,7 @@
> >  #define PCI_VENDOR_ID_TEWS               0x1498
> >  #define PCI_DEVICE_ID_TEWS_TPCI200       0x30C8
> >  
> > +#define PCI_VENDOR_ID_VMWARE             0x15ad
> > +#define PCI_DEVICE_ID_VMWARE_PVRDMA      0x0820
> > +
> >  #endif
> > -- 
> > 2.13.5
