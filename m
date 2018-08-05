Received: from eggs.gnu.org ([2001:4830:134:3::10]:33924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1fmKSe-00058Q-Hq
	for qemu-devel@nongnu.org; Sun, 05 Aug 2018 10:56:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1fmKSb-00066E-C1
	for qemu-devel@nongnu.org; Sun, 05 Aug 2018 10:56:48 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:49576)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1fmKSb-000655-0T
	for qemu-devel@nongnu.org; Sun, 05 Aug 2018 10:56:45 -0400
Date: Sun, 5 Aug 2018 17:56:34 +0300
From: Yuval Shaia <yuval.shaia@oracle.com>
Message-ID: <20180805145634.GA22209@lap1>
References: <20180716074038.3364-1-yuval.shaia@oracle.com>
	<20180716074038.3364-8-yuval.shaia@oracle.com>
	<42b81675-ea89-e9e9-f84c-ad723372fc1c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42b81675-ea89-e9e9-f84c-ad723372fc1c@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 07/13] hw/rdma: Do not allocate memory for
 non-dma MR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: qemu-devel@nongnu.org, yuval.shaia@oracle.com

On Tue, Jul 24, 2018 at 03:19:52PM +0300, Marcel Apfelbaum wrote:
> 
> Hi Yuval,
> 
> On 07/16/2018 10:40 AM, Yuval Shaia wrote:
> > There is no use in the memory allocated for non-dma MR (one with
> > host_virt equals to NULL).
> 
> No need for the (one with...)

Will remove.

> 
> > Delete the code that allocates it.
> > 
> > Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
> > ---
> >   hw/rdma/rdma_rm.c | 52 +++++++++++++++++++----------------------------
> >   1 file changed, 21 insertions(+), 31 deletions(-)
> > 
> > diff --git a/hw/rdma/rdma_rm.c b/hw/rdma/rdma_rm.c
> > index 7403d24674..bf4a5c71b4 100644
> > --- a/hw/rdma/rdma_rm.c
> > +++ b/hw/rdma/rdma_rm.c
> > @@ -144,8 +144,6 @@ int rdma_rm_alloc_mr(RdmaDeviceResources *dev_res, uint32_t pd_handle,
> >       RdmaRmMR *mr;
> >       int ret = 0;
> >       RdmaRmPD *pd;
> > -    void *addr;
> > -    size_t length;
> >       pd = rdma_rm_get_pd(dev_res, pd_handle);
> >       if (!pd) {
> > @@ -158,40 +156,29 @@ int rdma_rm_alloc_mr(RdmaDeviceResources *dev_res, uint32_t pd_handle,
> >           pr_dbg("Failed to allocate obj in table\n");
> >           return -ENOMEM;
> >       }
> > +    pr_dbg("mr_handle=%d\n", *mr_handle);
> > -    if (!host_virt) {
> > -        /* TODO: This is my guess but not so sure that this needs to be
> > -         * done */
> > -        length = TARGET_PAGE_SIZE;
> > -        addr = g_malloc(length);
> > -    } else {
> > +    pr_dbg("host_virt=0x%p\n", host_virt);
> > +    pr_dbg("guest_start=0x%" PRIx64 "\n", guest_start);
> > +    pr_dbg("length=%zu\n", guest_length);
> > +
> > +    if (host_virt) {
> >           mr->virt = host_virt;
> > -        pr_dbg("host_virt=0x%p\n", mr->virt);
> > -        mr->length = guest_length;
> > -        pr_dbg("length=%zu\n", guest_length);
> >           mr->start = guest_start;

[1]

> > -        pr_dbg("guest_start=0x%" PRIx64 "\n", mr->start);
> > -
> > -        length = mr->length;
> > -        addr = mr->virt;
> > -    }
> > +        mr->length = guest_length;
> > -    ret = rdma_backend_create_mr(&mr->backend_mr, &pd->backend_pd, addr, length,
> > -                                 access_flags);
> > -    if (ret) {
> > -        pr_dbg("Fail in rdma_backend_create_mr, err=%d\n", ret);
> > -        ret = -EIO;
> > -        goto out_dealloc_mr;
> > +        ret = rdma_backend_create_mr(&mr->backend_mr, &pd->backend_pd, mr->virt,
> > +                                     mr->length, access_flags);
> > +        if (ret) {
> > +            pr_dbg("Fail in rdma_backend_create_mr, err=%d\n", ret);
> > +            ret = -EIO;
> > +            goto out_dealloc_mr;
> > +        }
> >       }
> > -    if (!host_virt) {
> > -        *lkey = mr->lkey = rdma_backend_mr_lkey(&mr->backend_mr);
> > -        *rkey = mr->rkey = rdma_backend_mr_rkey(&mr->backend_mr);
> > -    } else {
> > -        /* We keep mr_handle in lkey so send and recv get get mr ptr */
> > -        *lkey = *mr_handle;
> > -        *rkey = -1;
> > -    }
> > +    /* We keep mr_handle in lkey so send and recv get get mr ptr */
> > +    *lkey = *mr_handle;
> > +    *rkey = -1;
> 
> Before this change rkey whould get a value when !host_virt.
> But I suppose is OK since Remote DMA operations are not implemented yet.

The entire code that handled the case where host_virt is NULL was wrong
thus removed.
And yes, RDMA verb is not yet implemented so rkey is anyway not needed.

> 
> >       mr->pd_handle = pd_handle;
> > @@ -214,7 +201,10 @@ void rdma_rm_dealloc_mr(RdmaDeviceResources *dev_res, uint32_t mr_handle)
> >       if (mr) {
> >           rdma_backend_destroy_mr(&mr->backend_mr);
> > -        munmap(mr->virt, mr->length);
> > +        pr_dbg("start=0x%" PRIx64 "\n", mr->start);
> > +        if (mr->start) {
> 
> When is the mr->start inited?

res_tbl_alloc cleans the MR before giving it to caller so we expect
mr->start to be NULL.
Then if host_virt is given then mr->start is set to guest virtual address
[1].

> 
> Thanks,
> Marcel
> 
> > +            munmap(mr->virt, mr->length);
> > +        }
> >           res_tbl_dealloc(&dev_res->mr_tbl, mr_handle);
> >       }
> >   }
> 
