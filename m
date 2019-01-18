Received: from eggs.gnu.org ([209.51.188.92]:37678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gkWvu-0003ni-7Z
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 11:23:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gkWvs-00006x-CZ
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 11:23:50 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:40848)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1gkWvo-0007yK-Gk
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 11:23:46 -0500
Date: Fri, 18 Jan 2019 18:23:23 +0200
From: Yuval Shaia <yuval.shaia@oracle.com>
Message-ID: <20190118162322.GA3558@lap1>
References: <20190109201559.3906-1-yuval.shaia@oracle.com>
	<9cde91d0-ec6a-d66c-c699-1d35f8dd84a5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <9cde91d0-ec6a-d66c-c699-1d35f8dd84a5@gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/pvrdma: Post CQE when receive invalid
 gid index
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, liq3ea@163.com, philmd@redhat.com
Cc: qemu-devel@nongnu.org

On Fri, Jan 18, 2019 at 03:55:36PM +0200, Marcel Apfelbaum wrote:
> Hi Yuval,
>=20
> On 1/9/19 10:15 PM, Yuval Shaia wrote:
> > This error should propagate back to guest.
> >=20
> > Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
> > ---
> >   hw/rdma/rdma_backend.h      | 1 +
> >   hw/rdma/vmw/pvrdma_qp_ops.c | 6 ++++--
> >   2 files changed, 5 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/hw/rdma/rdma_backend.h b/hw/rdma/rdma_backend.h
> > index a9ba40ae48..5114c90e67 100644
> > --- a/hw/rdma/rdma_backend.h
> > +++ b/hw/rdma/rdma_backend.h
> > @@ -32,6 +32,7 @@
> >   #define VENDOR_ERR_INVLKEY          0x207
> >   #define VENDOR_ERR_MR_SMALL         0x208
> >   #define VENDOR_ERR_INV_MAD_BUFF     0x209
> > +#define VENDOR_ERR_INV_GID_IDX      0x210
> >   /* Add definition for QP0 and QP1 as there is no userspace enums fo=
r them */
> >   enum ibv_special_qp_type {
> > diff --git a/hw/rdma/vmw/pvrdma_qp_ops.c b/hw/rdma/vmw/pvrdma_qp_ops.=
c
> > index 465bee8641..0565eba981 100644
> > --- a/hw/rdma/vmw/pvrdma_qp_ops.c
> > +++ b/hw/rdma/vmw/pvrdma_qp_ops.c
> > @@ -178,7 +178,8 @@ int pvrdma_qp_send(PVRDMADev *dev, uint32_t qp_ha=
ndle)
> >           sgid =3D rdma_rm_get_gid(&dev->rdma_dev_res, wqe->hdr.wr.ud=
.av.gid_index);
> >           if (!sgid) {
> >               pr_dbg("Fail to get gid for idx %d\n", wqe->hdr.wr.ud.a=
v.gid_index);
> > -            return -EIO;
> > +            complete_with_error(VENDOR_ERR_INV_GID_IDX, comp_ctx);
>=20
> There may be a problem here, comp_ctx may be uninitialized at this poin=
t.
> I see that comp_ctx gets initalized after this call:
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0 /* Prepare CQE */
> =A0=A0=A0=A0=A0=A0=A0 comp_ctx =3D g_malloc(sizeof(CompHandlerCtx));
> =A0=A0=A0=A0=A0=A0=A0 comp_ctx->dev =3D dev;
>=20
>=20
> What do you think?
>=20
> Thanks,
> Marcel

Applying this patch on top of upstream make sense.
Problem start because you probably applied Li Qiang's patch "[PATCH v2] h=
w:
pvrdma: fix memory leak in error path" which moves the initialization of
comp_ctx to be right after all checks are done.

More than that, accepting this patch makes Li Qiang's patch redundant sin=
ce
the cleanup of comp_ctx will be taken care by the usual process of
'completion' (see the callback function pvrdma_qp_ops_comp_handler).
Li Qiang, can you confirm?

Yuval

>=20
> > +            continue;
> >           }
> >           pr_dbg("sgid_id=3D%d, sgid=3D0x%llx\n", wqe->hdr.wr.ud.av.g=
id_index,
> >                  sgid->global.interface_id);
> > @@ -189,7 +190,8 @@ int pvrdma_qp_send(PVRDMADev *dev, uint32_t qp_ha=
ndle)
> >           if (sgid_idx <=3D 0) {
> >               pr_dbg("Fail to get bk sgid_idx for sgid_idx %d\n",
> >                      wqe->hdr.wr.ud.av.gid_index);
> > -            return -EIO;
> > +            complete_with_error(VENDOR_ERR_INV_GID_IDX, comp_ctx);
> > +            continue;
> >           }
> >           if (wqe->hdr.num_sge > dev->dev_attr.max_sge) {
>=20
