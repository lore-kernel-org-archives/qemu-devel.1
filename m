Received: from eggs.gnu.org ([209.51.188.92]:58281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gtSBB-0004BV-H9
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 02:08:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gtSB9-00078K-Ix
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 02:08:29 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:32994)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1gtSB7-00073M-8T
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 02:08:25 -0500
Date: Tue, 12 Feb 2019 09:08:09 +0200
From: Yuval Shaia <yuval.shaia@oracle.com>
Message-ID: <20190212070808.GA3103@lap1>
References: <20190210104537.1488-1-yuval.shaia@oracle.com>
	<20190210104537.1488-3-yuval.shaia@oracle.com>
	<19605c6a-56c4-6467-23b6-f59d7a79cf98@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19605c6a-56c4-6467-23b6-f59d7a79cf98@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v1 2/9] hw/rdma: Introduce locked qlist
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: dgilbert@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org, eblake@redhat.com

On Mon, Feb 11, 2019 at 10:10:56AM +0200, Marcel Apfelbaum wrote:
> 
> 
> On 2/10/19 12:45 PM, Yuval Shaia wrote:
> > To make code more readable move handling of locked list to a generic
> > functions.
> > 
> > Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
> > ---
> >   hw/rdma/rdma_backend.c      | 20 +++++--------------
> >   hw/rdma/rdma_backend_defs.h |  8 ++------
> >   hw/rdma/rdma_utils.c        | 39 +++++++++++++++++++++++++++++++++++++
> >   hw/rdma/rdma_utils.h        |  9 +++++++++
> >   4 files changed, 55 insertions(+), 21 deletions(-)
> > 
> > diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
> > index 5f60856d19..2f6372f8f0 100644
> > --- a/hw/rdma/rdma_backend.c
> > +++ b/hw/rdma/rdma_backend.c
> > @@ -527,9 +527,7 @@ static unsigned int save_mad_recv_buffer(RdmaBackendDev *backend_dev,
> >       bctx->up_ctx = ctx;
> >       bctx->sge = *sge;
> > -    qemu_mutex_lock(&backend_dev->recv_mads_list.lock);
> > -    qlist_append_int(backend_dev->recv_mads_list.list, bctx_id);
> > -    qemu_mutex_unlock(&backend_dev->recv_mads_list.lock);
> > +    rdma_locked_list_append_int64(&backend_dev->recv_mads_list, bctx_id);
> >       return 0;
> >   }
> > @@ -913,23 +911,19 @@ static inline void build_mad_hdr(struct ibv_grh *grh, union ibv_gid *sgid,
> >   static void process_incoming_mad_req(RdmaBackendDev *backend_dev,
> >                                        RdmaCmMuxMsg *msg)
> >   {
> > -    QObject *o_ctx_id;
> >       unsigned long cqe_ctx_id;
> >       BackendCtx *bctx;
> >       char *mad;
> >       trace_mad_message("recv", msg->umad.mad, msg->umad_len);
> > -    qemu_mutex_lock(&backend_dev->recv_mads_list.lock);
> > -    o_ctx_id = qlist_pop(backend_dev->recv_mads_list.list);
> > -    qemu_mutex_unlock(&backend_dev->recv_mads_list.lock);
> > -    if (!o_ctx_id) {
> > +    cqe_ctx_id = rdma_locked_list_pop_int64(&backend_dev->recv_mads_list);
> > +    if (cqe_ctx_id == -ENOENT) {
> >           rdma_warn_report("No more free MADs buffers, waiting for a while");
> >           sleep(THR_POLL_TO);
> >           return;
> >       }
> > -    cqe_ctx_id = qnum_get_uint(qobject_to(QNum, o_ctx_id));
> >       bctx = rdma_rm_get_cqe_ctx(backend_dev->rdma_dev_res, cqe_ctx_id);
> >       if (unlikely(!bctx)) {
> >           rdma_error_report("No matching ctx for req %ld", cqe_ctx_id);
> > @@ -994,8 +988,7 @@ static int mad_init(RdmaBackendDev *backend_dev, CharBackend *mad_chr_be)
> >           return -EIO;
> >       }
> > -    qemu_mutex_init(&backend_dev->recv_mads_list.lock);
> > -    backend_dev->recv_mads_list.list = qlist_new();
> > +    rdma_locked_list_init(&backend_dev->recv_mads_list);
> >       enable_rdmacm_mux_async(backend_dev);
> > @@ -1010,10 +1003,7 @@ static void mad_fini(RdmaBackendDev *backend_dev)
> >   {
> >       disable_rdmacm_mux_async(backend_dev);
> >       qemu_chr_fe_disconnect(backend_dev->rdmacm_mux.chr_be);
> > -    if (backend_dev->recv_mads_list.list) {
> > -        qlist_destroy_obj(QOBJECT(backend_dev->recv_mads_list.list));
> > -        qemu_mutex_destroy(&backend_dev->recv_mads_list.lock);
> > -    }
> > +    rdma_locked_list_destroy(&backend_dev->recv_mads_list);
> >   }
> >   int rdma_backend_get_gid_index(RdmaBackendDev *backend_dev,
> > diff --git a/hw/rdma/rdma_backend_defs.h b/hw/rdma/rdma_backend_defs.h
> > index 15ae8b970e..bec0457f25 100644
> > --- a/hw/rdma/rdma_backend_defs.h
> > +++ b/hw/rdma/rdma_backend_defs.h
> > @@ -20,6 +20,7 @@
> >   #include "chardev/char-fe.h"
> >   #include <infiniband/verbs.h>
> >   #include "contrib/rdmacm-mux/rdmacm-mux.h"
> > +#include "rdma_utils.h"
> >   typedef struct RdmaDeviceResources RdmaDeviceResources;
> > @@ -30,11 +31,6 @@ typedef struct RdmaBackendThread {
> >       bool is_running; /* Set by the thread to report its status */
> >   } RdmaBackendThread;
> > -typedef struct RecvMadList {
> > -    QemuMutex lock;
> > -    QList *list;
> > -} RecvMadList;
> > -
> >   typedef struct RdmaCmMux {
> >       CharBackend *chr_be;
> >       int can_receive;
> > @@ -48,7 +44,7 @@ typedef struct RdmaBackendDev {
> >       struct ibv_context *context;
> >       struct ibv_comp_channel *channel;
> >       uint8_t port_num;
> > -    RecvMadList recv_mads_list;
> > +    LockedList recv_mads_list;
> >       RdmaCmMux rdmacm_mux;
> >   } RdmaBackendDev;
> > diff --git a/hw/rdma/rdma_utils.c b/hw/rdma/rdma_utils.c
> > index f1c980c6be..a2a4ea2a15 100644
> > --- a/hw/rdma/rdma_utils.c
> > +++ b/hw/rdma/rdma_utils.c
> > @@ -14,6 +14,8 @@
> >    */
> >   #include "qemu/osdep.h"
> > +#include "qapi/qmp/qlist.h"
> > +#include "qapi/qmp/qnum.h"
> >   #include "trace.h"
> >   #include "rdma_utils.h"
> > @@ -55,3 +57,40 @@ void rdma_pci_dma_unmap(PCIDevice *dev, void *buffer, dma_addr_t len)
> >           pci_dma_unmap(dev, buffer, len, DMA_DIRECTION_TO_DEVICE, 0);
> >       }
> >   }
> > +
> > +void rdma_locked_list_init(LockedList *list)
> > +{
> > +    qemu_mutex_init(&list->lock);
> > +    list->list = qlist_new();
> > +}
> > +
> > +void rdma_locked_list_destroy(LockedList *list)
> > +{
> > +    if (list->list) {
> > +        qlist_destroy_obj(QOBJECT(list->list));
> > +        qemu_mutex_destroy(&list->lock);
> > +        list->list = NULL;
> > +    }
> > +}
> > +
> > +void rdma_locked_list_append_int64(LockedList *list, int64_t value)
> > +{
> > +    qemu_mutex_lock(&list->lock);
> > +    qlist_append_int(list->list, value);
> > +    qemu_mutex_unlock(&list->lock);
> > +}
> > +
> > +int64_t rdma_locked_list_pop_int64(LockedList *list)
> > +{
> > +    QObject *obj;
> > +
> > +    qemu_mutex_lock(&list->lock);
> > +    obj = qlist_pop(list->list);
> > +    qemu_mutex_unlock(&list->lock);
> > +
> > +    if (!obj) {
> > +        return -ENOENT;
> > +    }
> > +
> > +    return qnum_get_uint(qobject_to(QNum, obj));
> > +}
> > diff --git a/hw/rdma/rdma_utils.h b/hw/rdma/rdma_utils.h
> > index acd148837f..4ba9956f81 100644
> > --- a/hw/rdma/rdma_utils.h
> > +++ b/hw/rdma/rdma_utils.h
> > @@ -29,8 +29,17 @@
> >   #define rdma_info_report(fmt, ...) \
> >       info_report("%s: " fmt, "rdma", ## __VA_ARGS__)
> > +typedef struct LockedList {
> > +    QemuMutex lock;
> > +    QList *list;
> > +} LockedList;
> 
> I am still not sure about the naming, the list is not "locked",
> is "synchronized", and also is not a 'generic' list since is located in the
> rdma code.
> 
> Maybe RdmaSyncList?
> 
> Thanks,
> Marcel

Sure, will rename it (to RdmaProtectedQList).
Will do the same in patch #6

> 
> > +
> >   void *rdma_pci_dma_map(PCIDevice *dev, dma_addr_t addr, dma_addr_t plen);
> >   void rdma_pci_dma_unmap(PCIDevice *dev, void *buffer, dma_addr_t len);
> > +void rdma_locked_list_init(LockedList *list);
> > +void rdma_locked_list_destroy(LockedList *list);
> > +void rdma_locked_list_append_int64(LockedList *list, int64_t value);
> > +int64_t rdma_locked_list_pop_int64(LockedList *list);
> >   static inline void addrconf_addr_eui48(uint8_t *eui, const char *addr)
> >   {
> 
> 
