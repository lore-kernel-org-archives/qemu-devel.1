Received: from eggs.gnu.org ([209.51.188.92]:44495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1ggXkU-0002wf-6E
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:27:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1ggXkO-00037T-Tu
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:27:31 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:43534)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1ggXkG-0002qv-Av
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:27:25 -0500
Date: Mon, 7 Jan 2019 18:26:58 +0200
From: Yuval Shaia <yuval.shaia@oracle.com>
Message-ID: <20190107162657.GB3249@lap1>
References: <20190103130338.49081-1-liq3ea@163.com>
	<fad70169-0cff-ede5-c07d-bff01d113f88@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <fad70169-0cff-ede5-c07d-bff01d113f88@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw: pvrdma: fix memory leak in error path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, liq3ea@163.com
Cc: marcel.apfelbaum@gmail.com, peter.maydell@linaro.org, qemu-devel@nongnu.org, yuval.shaia@oracle.com

On Thu, Jan 03, 2019 at 02:47:37PM +0100, Philippe Mathieu-Daud=E9 wrote:
> On 1/3/19 2:03 PM, Li Qiang wrote:
> > Spotted by Coverity: CID 1398595
> >=20
>=20
> Fixes: 2b05705dc8
>=20
> > Signed-off-by: Li Qiang <liq3ea@163.com>
>=20
> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
>=20
> > ---
> >  hw/rdma/vmw/pvrdma_qp_ops.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >=20
> > diff --git a/hw/rdma/vmw/pvrdma_qp_ops.c b/hw/rdma/vmw/pvrdma_qp_ops.=
c
> > index 300471a4c9..584be2043e 100644
> > --- a/hw/rdma/vmw/pvrdma_qp_ops.c
> > +++ b/hw/rdma/vmw/pvrdma_qp_ops.c
> > @@ -168,6 +168,7 @@ int pvrdma_qp_send(PVRDMADev *dev, uint32_t qp_ha=
ndle)
> >          sgid =3D rdma_rm_get_gid(&dev->rdma_dev_res, wqe->hdr.wr.ud.=
av.gid_index);
> >          if (!sgid) {
> >              pr_dbg("Fail to get gid for idx %d\n", wqe->hdr.wr.ud.av=
.gid_index);
> > +            g_free(comp_ctx);
> >              return -EIO;
> >          }
> >          pr_dbg("sgid_id=3D%d, sgid=3D0x%llx\n", wqe->hdr.wr.ud.av.gi=
d_index,
> > @@ -179,6 +180,7 @@ int pvrdma_qp_send(PVRDMADev *dev, uint32_t qp_ha=
ndle)
> >          if (sgid_idx <=3D 0) {
> >              pr_dbg("Fail to get bk sgid_idx for sgid_idx %d\n",
> >                     wqe->hdr.wr.ud.av.gid_index);
> > +            g_free(comp_ctx);
> >              return -EIO;
> >          }

Since comp_ctx is not used until the two checks are done we just can
relocate the allocation & initialization right after the two checks.

Yuval

> > =20
> >=20
