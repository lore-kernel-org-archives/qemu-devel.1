Received: from eggs.gnu.org ([2001:4830:134:3::10]:45829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gLn2I-0004MW-Jp
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 05:32:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gLn2E-0005Xq-Gi
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 05:32:10 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:54374)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1gLn2E-0005Sn-5s
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 05:32:06 -0500
Date: Sun, 11 Nov 2018 12:31:51 +0200
From: Yuval Shaia <yuval.shaia@oracle.com>
Message-ID: <20181111103150.GG2974@lap1>
References: <20181108160818.5485-1-yuval.shaia@oracle.com>
	<20181108160818.5485-6-yuval.shaia@oracle.com>
	<70268ddc-0be6-6128-e9c1-28037c11a5a9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <70268ddc-0be6-6128-e9c1-28037c11a5a9@gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 05/22] hw/rdma: Add support for MAD
 packets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: dmitry.fleytman@gmail.com, jasowang@redhat.com, eblake@redhat.com, armbru@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, shamir.rabinovitch@oracle.com, yuval.shaia@oracle.com

On Sat, Nov 10, 2018 at 08:15:27PM +0200, Marcel Apfelbaum wrote:
> Hi Yuval
>=20
> On 11/8/18 6:08 PM, Yuval Shaia wrote:
> > MAD (Management Datagram) packets are widely used by various modules
> > both in kernel and in user space for example the rdma_* API which is
> > used to create and maintain "connection" layer on top of RDMA uses
> > several types of MAD packets.
>=20
> Can you add a link to MAD spec to commit or event in the code?

Have no idea where to take it from, does it requires some subscription or
so?

>=20
> > To support MAD packets the device uses an external utility
> > (contrib/rdmacm-mux) to relay packets from and to the guest driver.
>=20
> Can the device be used without MADs support?

Since we have a support now i don't see a reason why we like to use (or
even expose) device with no MAD support.

> If not, can you update the pvrdma documentation to
> reflect the changes?

Sure, missed that, will document the changes in v3.

>=20
> > Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
> > ---
> >   hw/rdma/rdma_backend.c      | 263 +++++++++++++++++++++++++++++++++=
++-
> >   hw/rdma/rdma_backend.h      |   4 +-
> >   hw/rdma/rdma_backend_defs.h |  10 +-
> >   hw/rdma/vmw/pvrdma.h        |   2 +
> >   hw/rdma/vmw/pvrdma_main.c   |   4 +-
> >   5 files changed, 273 insertions(+), 10 deletions(-)
> >=20
> > diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
> > index 1e148398a2..3eb0099f8d 100644
> > --- a/hw/rdma/rdma_backend.c
> > +++ b/hw/rdma/rdma_backend.c
> > @@ -16,8 +16,13 @@
> >   #include "qemu/osdep.h"
> >   #include "qemu/error-report.h"
> >   #include "qapi/error.h"
> > +#include "qapi/qmp/qlist.h"
> > +#include "qapi/qmp/qnum.h"
> >   #include <infiniband/verbs.h>
> > +#include <infiniband/umad_types.h>
> > +#include <infiniband/umad.h>
> > +#include <rdma/rdma_user_cm.h>
> >   #include "trace.h"
> >   #include "rdma_utils.h"
> > @@ -33,16 +38,25 @@
> >   #define VENDOR_ERR_MAD_SEND         0x206
> >   #define VENDOR_ERR_INVLKEY          0x207
> >   #define VENDOR_ERR_MR_SMALL         0x208
> > +#define VENDOR_ERR_INV_MAD_BUFF     0x209
> > +#define VENDOR_ERR_INV_NUM_SGE      0x210
> >   #define THR_NAME_LEN 16
> >   #define THR_POLL_TO  5000
> > +#define MAD_HDR_SIZE sizeof(struct ibv_grh)
> > +
> >   typedef struct BackendCtx {
> > -    uint64_t req_id;
> >       void *up_ctx;
> >       bool is_tx_req;
> > +    struct ibv_sge sge; /* Used to save MAD recv buffer */
> >   } BackendCtx;
> > +struct backend_umad {
> > +    struct ib_user_mad hdr;
> > +    char mad[RDMA_MAX_PRIVATE_DATA];
> > +};
> > +
> >   static void (*comp_handler)(int status, unsigned int vendor_err, vo=
id *ctx);
> >   static void dummy_comp_handler(int status, unsigned int vendor_err,=
 void *ctx)
> > @@ -286,6 +300,49 @@ static int build_host_sge_array(RdmaDeviceResour=
ces *rdma_dev_res,
> >       return 0;
> >   }
> > +static int mad_send(RdmaBackendDev *backend_dev, struct ibv_sge *sge=
,
> > +                    uint32_t num_sge)
> > +{
> > +    struct backend_umad umad =3D {0};
> > +    char *hdr, *msg;
> > +    int ret;
> > +
> > +    pr_dbg("num_sge=3D%d\n", num_sge);
> > +
> > +    if (num_sge !=3D 2) {
> > +        return -EINVAL;
> > +    }
> > +
> > +    umad.hdr.length =3D sge[0].length + sge[1].length;
> > +    pr_dbg("msg_len=3D%d\n", umad.hdr.length);
> > +
> > +    if (umad.hdr.length > sizeof(umad.mad)) {
> > +        return -ENOMEM;
> > +    }
> > +
> > +    umad.hdr.addr.qpn =3D htobe32(1);
> > +    umad.hdr.addr.grh_present =3D 1;
> > +    umad.hdr.addr.gid_index =3D backend_dev->backend_gid_idx;
> > +    memcpy(umad.hdr.addr.gid, backend_dev->gid.raw, sizeof(umad.hdr.=
addr.gid));
> > +    umad.hdr.addr.hop_limit =3D 1;
> > +
> > +    hdr =3D rdma_pci_dma_map(backend_dev->dev, sge[0].addr, sge[0].l=
ength);
> > +    msg =3D rdma_pci_dma_map(backend_dev->dev, sge[1].addr, sge[1].l=
ength);
> > +
> > +    memcpy(&umad.mad[0], hdr, sge[0].length);
> > +    memcpy(&umad.mad[sge[0].length], msg, sge[1].length);
> > +
> > +    rdma_pci_dma_unmap(backend_dev->dev, msg, sge[1].length);
> > +    rdma_pci_dma_unmap(backend_dev->dev, hdr, sge[0].length);
> > +
> > +    ret =3D qemu_chr_fe_write(backend_dev->mad_chr_be, (const uint8_=
t *)&umad,
> > +                            sizeof(umad));
> > +
> > +    pr_dbg("qemu_chr_fe_write=3D%d\n", ret);
> > +
> > +    return (ret !=3D sizeof(umad));
> > +}
> > +
> >   void rdma_backend_post_send(RdmaBackendDev *backend_dev,
> >                               RdmaBackendQP *qp, uint8_t qp_type,
> >                               struct ibv_sge *sge, uint32_t num_sge,
> > @@ -304,9 +361,13 @@ void rdma_backend_post_send(RdmaBackendDev *back=
end_dev,
> >               comp_handler(IBV_WC_GENERAL_ERR, VENDOR_ERR_QP0, ctx);
> >           } else if (qp_type =3D=3D IBV_QPT_GSI) {
> >               pr_dbg("QP1\n");
> > -            comp_handler(IBV_WC_GENERAL_ERR, VENDOR_ERR_MAD_SEND, ct=
x);
> > +            rc =3D mad_send(backend_dev, sge, num_sge);
> > +            if (rc) {
> > +                comp_handler(IBV_WC_GENERAL_ERR, VENDOR_ERR_MAD_SEND=
, ctx);
> > +            } else {
> > +                comp_handler(IBV_WC_SUCCESS, 0, ctx);
> > +            }
> >           }
> > -        pr_dbg("qp->ibqp is NULL for qp_type %d!!!\n", qp_type);
> >           return;
> >       }
> > @@ -370,6 +431,48 @@ out_free_bctx:
> >       g_free(bctx);
> >   }
> > +static unsigned int save_mad_recv_buffer(RdmaBackendDev *backend_dev=
,
> > +                                         struct ibv_sge *sge, uint32=
_t num_sge,
> > +                                         void *ctx)
> > +{
> > +    BackendCtx *bctx;
> > +    int rc;
> > +    uint32_t bctx_id;
> > +
> > +    if (num_sge !=3D 1) {
> > +        pr_dbg("Invalid num_sge (%d), expecting 1\n", num_sge);
> > +        return VENDOR_ERR_INV_NUM_SGE;
> > +    }
> > +
> > +    if (sge[0].length < RDMA_MAX_PRIVATE_DATA + sizeof(struct ibv_gr=
h)) {
> > +        pr_dbg("Too small buffer for MAD\n");
> > +        return VENDOR_ERR_INV_MAD_BUFF;
> > +    }
> > +
> > +    pr_dbg("addr=3D0x%" PRIx64"\n", sge[0].addr);
> > +    pr_dbg("length=3D%d\n", sge[0].length);
> > +    pr_dbg("lkey=3D%d\n", sge[0].lkey);
> > +
> > +    bctx =3D g_malloc0(sizeof(*bctx));
> > +
> > +    rc =3D rdma_rm_alloc_cqe_ctx(backend_dev->rdma_dev_res, &bctx_id=
, bctx);
> > +    if (unlikely(rc)) {
> > +        g_free(bctx);
> > +        pr_dbg("Fail to allocate cqe_ctx\n");
> > +        return VENDOR_ERR_NOMEM;
> > +    }
> > +
> > +    pr_dbg("bctx_id %d, bctx %p, ctx %p\n", bctx_id, bctx, ctx);
> > +    bctx->up_ctx =3D ctx;
> > +    bctx->sge =3D *sge;
> > +
> > +    qemu_mutex_lock(&backend_dev->recv_mads_list.lock);
> > +    qlist_append_int(backend_dev->recv_mads_list.list, bctx_id);
> > +    qemu_mutex_unlock(&backend_dev->recv_mads_list.lock);
> > +
> > +    return 0;
> > +}
> > +
> >   void rdma_backend_post_recv(RdmaBackendDev *backend_dev,
> >                               RdmaDeviceResources *rdma_dev_res,
> >                               RdmaBackendQP *qp, uint8_t qp_type,
> > @@ -388,7 +491,10 @@ void rdma_backend_post_recv(RdmaBackendDev *back=
end_dev,
> >           }
> >           if (qp_type =3D=3D IBV_QPT_GSI) {
> >               pr_dbg("QP1\n");
> > -            comp_handler(IBV_WC_GENERAL_ERR, VENDOR_ERR_MAD_SEND, ct=
x);
> > +            rc =3D save_mad_recv_buffer(backend_dev, sge, num_sge, c=
tx);
> > +            if (rc) {
> > +                comp_handler(IBV_WC_GENERAL_ERR, rc, ctx);
> > +            }
> >           }
> >           return;
> >       }
> > @@ -517,7 +623,6 @@ int rdma_backend_create_qp(RdmaBackendQP *qp, uin=
t8_t qp_type,
> >       switch (qp_type) {
> >       case IBV_QPT_GSI:
> > -        pr_dbg("QP1 unsupported\n");
> >           return 0;
> >       case IBV_QPT_RC:
> > @@ -748,11 +853,146 @@ static int init_device_caps(RdmaBackendDev *ba=
ckend_dev,
> >       return 0;
> >   }
> > +static inline void build_mad_hdr(struct ibv_grh *grh, union ibv_gid =
*sgid,
> > +                                 union ibv_gid *my_gid, int paylen)
> > +{
> > +    grh->paylen =3D htons(paylen);
> > +    grh->sgid =3D *sgid;
> > +    grh->dgid =3D *my_gid;
> > +
> > +    pr_dbg("paylen=3D%d (net=3D0x%x)\n", paylen, grh->paylen);
> > +    pr_dbg("my_gid=3D0x%llx\n", my_gid->global.interface_id);
> > +    pr_dbg("gid=3D0x%llx\n", sgid->global.interface_id);
> > +}
> > +
> > +static inline int mad_can_receieve(void *opaque)
> > +{
> > +    return sizeof(struct backend_umad);
> > +}
> > +
> > +static void mad_read(void *opaque, const uint8_t *buf, int size)
> > +{
> > +    RdmaBackendDev *backend_dev =3D (RdmaBackendDev *)opaque;
> > +    QObject *o_ctx_id;
> > +    unsigned long cqe_ctx_id;
> > +    BackendCtx *bctx;
> > +    char *mad;
> > +    struct backend_umad *umad;
> > +
> > +    assert(size !=3D sizeof(umad));
> > +    umad =3D (struct backend_umad *)buf;
> > +
> > +    pr_dbg("Got %d bytes\n", size);
> > +    pr_dbg("umad->hdr.length=3D%d\n", umad->hdr.length);
> > +
> > +#ifdef PVRDMA_DEBUG
> > +    struct umad_hdr *hdr =3D (struct umad_hdr *)&msg->umad.mad;
> > +    pr_dbg("bv %x cls %x cv %x mtd %x st %d tid %" PRIx64 " at %x at=
m %x\n",
> > +           hdr->base_version, hdr->mgmt_class, hdr->class_version,
> > +           hdr->method, hdr->status, be64toh(hdr->tid),
> > +           hdr->attr_id, hdr->attr_mod);
> > +#endif
> > +
> > +    qemu_mutex_lock(&backend_dev->recv_mads_list.lock);
> > +    o_ctx_id =3D qlist_pop(backend_dev->recv_mads_list.list);
> > +    qemu_mutex_unlock(&backend_dev->recv_mads_list.lock);
> > +    if (!o_ctx_id) {
> > +        pr_dbg("No more free MADs buffers, waiting for a while\n");
> > +        sleep(THR_POLL_TO);
>=20
> Why do we sleep here? Seems a little odd.

Well, this should never happen. The guest driver on load, pushes 512
buffers and then refill it back on every MAD CQ.
But what device should do in case the bucket is empty? The best i found i=
s
to wait and retry, just to cover a burst that will be fixed soon.

Any other idea is welcome.

>=20
> > +        return;
> > +    }
> > +
> > +    cqe_ctx_id =3D qnum_get_uint(qobject_to(QNum, o_ctx_id));
> > +    bctx =3D rdma_rm_get_cqe_ctx(backend_dev->rdma_dev_res, cqe_ctx_=
id);
> > +    if (unlikely(!bctx)) {
> > +        pr_dbg("Error: Fail to find ctx for %ld\n", cqe_ctx_id);
> > +        return;
> > +    }
> > +
> > +    pr_dbg("id %ld, bctx %p, ctx %p\n", cqe_ctx_id, bctx, bctx->up_c=
tx);
> > +
> > +    mad =3D rdma_pci_dma_map(backend_dev->dev, bctx->sge.addr,
> > +                           bctx->sge.length);
> > +    if (!mad || bctx->sge.length < umad->hdr.length + MAD_HDR_SIZE) =
{
> > +        comp_handler(IBV_WC_GENERAL_ERR, VENDOR_ERR_INV_MAD_BUFF,
> > +                     bctx->up_ctx);
> > +    } else {
> > +        memset(mad, 0, bctx->sge.length);
> > +        build_mad_hdr((struct ibv_grh *)mad,
> > +                      (union ibv_gid *)&umad->hdr.addr.gid,
> > +                      &backend_dev->gid, umad->hdr.length);
> > +        memcpy(&mad[MAD_HDR_SIZE], umad->mad, umad->hdr.length);
> > +        rdma_pci_dma_unmap(backend_dev->dev, mad, bctx->sge.length);
> > +
> > +        comp_handler(IBV_WC_SUCCESS, 0, bctx->up_ctx);
> > +    }
> > +
> > +    g_free(bctx);
> > +    rdma_rm_dealloc_cqe_ctx(backend_dev->rdma_dev_res, cqe_ctx_id);
> > +}
> > +
> > +static int mad_init(RdmaBackendDev *backend_dev)
> > +{
> > +    struct backend_umad umad =3D {0};
> > +    int ret;
> > +
> > +    if (!qemu_chr_fe_backend_connected(backend_dev->mad_chr_be)) {
> > +        pr_dbg("Missing chardev for MAD multiplexer\n");
> > +        return -EIO;
> > +    }
> > +
> > +    qemu_chr_fe_set_handlers(backend_dev->mad_chr_be, mad_can_receie=
ve,
> > +                             mad_read, NULL, NULL, backend_dev, NULL=
, true);
> > +
> > +    /* Register ourself */
> > +    memcpy(umad.hdr.addr.gid, backend_dev->gid.raw, sizeof(umad.hdr.=
addr.gid));
> > +    ret =3D qemu_chr_fe_write(backend_dev->mad_chr_be, (const uint8_=
t *)&umad,
> > +                            sizeof(umad.hdr));
> > +    if (ret !=3D sizeof(umad.hdr)) {
> > +        pr_dbg("Fail to register to rdma_umadmux (%d)\n", ret);
>=20
> Why only a dbg message and=A0 not fail the init proc in this case ?

You are correct, this code is moved and fixed in patch #11.

>=20
> > +    }
> > +
> > +    qemu_mutex_init(&backend_dev->recv_mads_list.lock);
> > +    backend_dev->recv_mads_list.list =3D qlist_new();
> > +
> > +    return 0;
> > +}
> > +
> > +static void mad_stop(RdmaBackendDev *backend_dev)
> > +{
> > +    QObject *o_ctx_id;
> > +    unsigned long cqe_ctx_id;
> > +    BackendCtx *bctx;
> > +
> > +    pr_dbg("Closing MAD\n");
> > +
> > +    /* Clear MAD buffers list */
> > +    qemu_mutex_lock(&backend_dev->recv_mads_list.lock);
>=20
> Does it makes sense to lock only around the
> qlist_post call?

Yes, it does.
But since this function is called when devices is going down i do not see=
 a
reason to release the lock just to allow "list" users to append entries i=
n
between.

>=20
>=20
> Thanks,
> Marcel
>=20
> > +    do {
> > +        o_ctx_id =3D qlist_pop(backend_dev->recv_mads_list.list);
> > +        if (o_ctx_id) {
> > +            cqe_ctx_id =3D qnum_get_uint(qobject_to(QNum, o_ctx_id))=
;
> > +            bctx =3D rdma_rm_get_cqe_ctx(backend_dev->rdma_dev_res, =
cqe_ctx_id);
> > +            if (bctx) {
> > +                rdma_rm_dealloc_cqe_ctx(backend_dev->rdma_dev_res, c=
qe_ctx_id);
> > +                g_free(bctx);
> > +            }
> > +        }
> > +    } while (o_ctx_id);
> > +    qemu_mutex_unlock(&backend_dev->recv_mads_list.lock);
> > +}
> > +
> > +static void mad_fini(RdmaBackendDev *backend_dev)
> > +{
> > +    qlist_destroy_obj(QOBJECT(backend_dev->recv_mads_list.list));
> > +    qemu_mutex_destroy(&backend_dev->recv_mads_list.lock);
> > +}
> > +
> >   int rdma_backend_init(RdmaBackendDev *backend_dev, PCIDevice *pdev,
> >                         RdmaDeviceResources *rdma_dev_res,
> >                         const char *backend_device_name, uint8_t port=
_num,
> >                         uint8_t backend_gid_idx, struct ibv_device_at=
tr *dev_attr,
> > -                      Error **errp)
> > +                      CharBackend *mad_chr_be, Error **errp)
> >   {
> >       int i;
> >       int ret =3D 0;
> > @@ -763,7 +1003,7 @@ int rdma_backend_init(RdmaBackendDev *backend_de=
v, PCIDevice *pdev,
> >       memset(backend_dev, 0, sizeof(*backend_dev));
> >       backend_dev->dev =3D pdev;
> > -
> > +    backend_dev->mad_chr_be =3D mad_chr_be;
> >       backend_dev->backend_gid_idx =3D backend_gid_idx;
> >       backend_dev->port_num =3D port_num;
> >       backend_dev->rdma_dev_res =3D rdma_dev_res;
> > @@ -854,6 +1094,13 @@ int rdma_backend_init(RdmaBackendDev *backend_d=
ev, PCIDevice *pdev,
> >       pr_dbg("interface_id=3D0x%" PRIx64 "\n",
> >              be64_to_cpu(backend_dev->gid.global.interface_id));
> > +    ret =3D mad_init(backend_dev);
> > +    if (ret) {
> > +        error_setg(errp, "Fail to initialize mad");
> > +        ret =3D -EIO;
> > +        goto out_destroy_comm_channel;
> > +    }
> > +
> >       backend_dev->comp_thread.run =3D false;
> >       backend_dev->comp_thread.is_running =3D false;
> > @@ -885,11 +1132,13 @@ void rdma_backend_stop(RdmaBackendDev *backend=
_dev)
> >   {
> >       pr_dbg("Stopping rdma_backend\n");
> >       stop_backend_thread(&backend_dev->comp_thread);
> > +    mad_stop(backend_dev);
> >   }
> >   void rdma_backend_fini(RdmaBackendDev *backend_dev)
> >   {
> >       rdma_backend_stop(backend_dev);
> > +    mad_fini(backend_dev);
> >       g_hash_table_destroy(ah_hash);
> >       ibv_destroy_comp_channel(backend_dev->channel);
> >       ibv_close_device(backend_dev->context);
> > diff --git a/hw/rdma/rdma_backend.h b/hw/rdma/rdma_backend.h
> > index 3ccc9a2494..fc83330251 100644
> > --- a/hw/rdma/rdma_backend.h
> > +++ b/hw/rdma/rdma_backend.h
> > @@ -17,6 +17,8 @@
> >   #define RDMA_BACKEND_H
> >   #include "qapi/error.h"
> > +#include "chardev/char-fe.h"
> > +
> >   #include "rdma_rm_defs.h"
> >   #include "rdma_backend_defs.h"
> > @@ -50,7 +52,7 @@ int rdma_backend_init(RdmaBackendDev *backend_dev, =
PCIDevice *pdev,
> >                         RdmaDeviceResources *rdma_dev_res,
> >                         const char *backend_device_name, uint8_t port=
_num,
> >                         uint8_t backend_gid_idx, struct ibv_device_at=
tr *dev_attr,
> > -                      Error **errp);
> > +                      CharBackend *mad_chr_be, Error **errp);
> >   void rdma_backend_fini(RdmaBackendDev *backend_dev);
> >   void rdma_backend_start(RdmaBackendDev *backend_dev);
> >   void rdma_backend_stop(RdmaBackendDev *backend_dev);
> > diff --git a/hw/rdma/rdma_backend_defs.h b/hw/rdma/rdma_backend_defs.=
h
> > index 7404f64002..2a7e667075 100644
> > --- a/hw/rdma/rdma_backend_defs.h
> > +++ b/hw/rdma/rdma_backend_defs.h
> > @@ -16,8 +16,9 @@
> >   #ifndef RDMA_BACKEND_DEFS_H
> >   #define RDMA_BACKEND_DEFS_H
> > -#include <infiniband/verbs.h>
> >   #include "qemu/thread.h"
> > +#include "chardev/char-fe.h"
> > +#include <infiniband/verbs.h>
> >   typedef struct RdmaDeviceResources RdmaDeviceResources;
> > @@ -28,6 +29,11 @@ typedef struct RdmaBackendThread {
> >       bool is_running; /* Set by the thread to report its status */
> >   } RdmaBackendThread;
> > +typedef struct RecvMadList {
> > +    QemuMutex lock;
> > +    QList *list;
> > +} RecvMadList;
> > +
> >   typedef struct RdmaBackendDev {
> >       struct ibv_device_attr dev_attr;
> >       RdmaBackendThread comp_thread;
> > @@ -39,6 +45,8 @@ typedef struct RdmaBackendDev {
> >       struct ibv_comp_channel *channel;
> >       uint8_t port_num;
> >       uint8_t backend_gid_idx;
> > +    RecvMadList recv_mads_list;
> > +    CharBackend *mad_chr_be;
> >   } RdmaBackendDev;
> >   typedef struct RdmaBackendPD {
> > diff --git a/hw/rdma/vmw/pvrdma.h b/hw/rdma/vmw/pvrdma.h
> > index e2d9f93cdf..e3742d893a 100644
> > --- a/hw/rdma/vmw/pvrdma.h
> > +++ b/hw/rdma/vmw/pvrdma.h
> > @@ -19,6 +19,7 @@
> >   #include "qemu/units.h"
> >   #include "hw/pci/pci.h"
> >   #include "hw/pci/msix.h"
> > +#include "chardev/char-fe.h"
> >   #include "../rdma_backend_defs.h"
> >   #include "../rdma_rm_defs.h"
> > @@ -83,6 +84,7 @@ typedef struct PVRDMADev {
> >       uint8_t backend_port_num;
> >       RdmaBackendDev backend_dev;
> >       RdmaDeviceResources rdma_dev_res;
> > +    CharBackend mad_chr;
> >   } PVRDMADev;
> >   #define PVRDMA_DEV(dev) OBJECT_CHECK(PVRDMADev, (dev), PVRDMA_HW_NA=
ME)
> > diff --git a/hw/rdma/vmw/pvrdma_main.c b/hw/rdma/vmw/pvrdma_main.c
> > index ca5fa8d981..6c8c0154fa 100644
> > --- a/hw/rdma/vmw/pvrdma_main.c
> > +++ b/hw/rdma/vmw/pvrdma_main.c
> > @@ -51,6 +51,7 @@ static Property pvrdma_dev_properties[] =3D {
> >       DEFINE_PROP_INT32("dev-caps-max-qp-init-rd-atom", PVRDMADev,
> >                         dev_attr.max_qp_init_rd_atom, MAX_QP_INIT_RD_=
ATOM),
> >       DEFINE_PROP_INT32("dev-caps-max-ah", PVRDMADev, dev_attr.max_ah=
, MAX_AH),
> > +    DEFINE_PROP_CHR("mad-chardev", PVRDMADev, mad_chr),
> >       DEFINE_PROP_END_OF_LIST(),
> >   };
> > @@ -613,7 +614,8 @@ static void pvrdma_realize(PCIDevice *pdev, Error=
 **errp)
> >       rc =3D rdma_backend_init(&dev->backend_dev, pdev, &dev->rdma_de=
v_res,
> >                              dev->backend_device_name, dev->backend_p=
ort_num,
> > -                           dev->backend_gid_idx, &dev->dev_attr, err=
p);
> > +                           dev->backend_gid_idx, &dev->dev_attr, &de=
v->mad_chr,
> > +                           errp);
> >       if (rc) {
> >           goto out;
> >       }
>=20
