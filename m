Received: from eggs.gnu.org ([2001:4830:134:3::10]:45271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1fr1kz-00024S-1s
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 09:59:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1fr1ku-00078K-3T
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 09:59:08 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:41846)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1fr1kt-00072v-S8
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 09:59:04 -0400
Date: Sat, 18 Aug 2018 16:58:55 +0300
From: Yuval Shaia <yuval.shaia@oracle.com>
Message-ID: <20180818135854.GA2984@lap1>
References: <20180814100010.2546-1-yuval.shaia@oracle.com>
	<e835cd66-9830-21c0-c3e2-08f6a1dc64eb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e835cd66-9830-21c0-c3e2-08f6a1dc64eb@gmail.com>
Subject: Re: [Qemu-devel] [PATCH] hw/rdma: Abort send-op if fail to create
 addr handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, yuval.shaia@oracle.com
Cc: qemu-devel@nongnu.org

On Sat, Aug 18, 2018 at 04:46:29PM +0300, Marcel Apfelbaum wrote:
> Hi Yuval,
> 
> On 08/14/2018 01:00 PM, Yuval Shaia wrote:
> > Function create_ah might return NULL, let's exit with an error.
> > 
> > Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
> > ---
> >   hw/rdma/rdma_backend.c | 4 ++++
> >   1 file changed, 4 insertions(+)
> > 
> > diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
> > index 35726bda2e..59d02eb567 100644
> > --- a/hw/rdma/rdma_backend.c
> > +++ b/hw/rdma/rdma_backend.c
> > @@ -402,6 +402,10 @@ void rdma_backend_post_send(RdmaBackendDev *backend_dev,
> >       if (qp_type == IBV_QPT_UD) {
> >           wr.wr.ud.ah = create_ah(backend_dev, qp->ibpd,
> >                                   backend_dev->backend_gid_idx, dgid);
> > +        if (!wr.wr.ud.ah) {
> > +            comp_handler(IBV_WC_GENERAL_ERR, VENDOR_ERR_FAIL_BACKEND, ctx, 0);
> 
> comp_handler takes 3 arguments, but here you pass 4, so the compilation
> fails.

Right, please ignore this patch.
I will send it with a different patch-set which is still under work.

> 
> Thanks,
> Marcel
> 
> > +            goto out_dealloc_cqe_ctx;
> > +        }
> >           wr.wr.ud.remote_qpn = dqpn;
> >           wr.wr.ud.remote_qkey = dqkey;
> >       }
> 
