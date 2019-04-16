Received: from eggs.gnu.org ([209.51.188.92]:40797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1hGJtT-0004iI-OR
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 04:56:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1hGJtS-0002IQ-Na
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 04:56:43 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:44656)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1hGJtS-0002Hk-Cg
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 04:56:42 -0400
Date: Tue, 16 Apr 2019 11:56:21 +0300
From: Yuval Shaia <yuval.shaia@oracle.com>
Message-ID: <20190416085620.GA4493@lap1>
References: <20190411110157.14252-1-yuval.shaia@oracle.com>
	<20190411110157.14252-4-yuval.shaia@oracle.com>
	<f133d122-5b00-2e3b-f5cc-efc6d2cc3d3b@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f133d122-5b00-2e3b-f5cc-efc6d2cc3d3b@acm.org>
Subject: Re: [Qemu-devel] [RFC 3/3] RDMA/virtio-rdma: VirtIO rdma driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bart Van Assche <bvanassche@acm.org>
Cc: virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org, mst@redhat.com, cohuck@redhat.com, marcel.apfelbaum@gmail.com, linux-rdma@vger.kernel.org, jgg@mellanox.com

On Mon, Apr 15, 2019 at 06:07:52PM -0700, Bart Van Assche wrote:
> On 4/11/19 4:01 AM, Yuval Shaia wrote:
> > +++ b/drivers/infiniband/hw/virtio/Kconfig
> > @@ -0,0 +1,6 @@
> > +config INFINIBAND_VIRTIO_RDMA
> > +	tristate "VirtIO Paravirtualized RDMA Driver"
> > +	depends on NETDEVICES && ETHERNET && PCI && INET
> > +	---help---
> > +	  This driver provides low-level support for VirtIO Paravirtual
> > +	  RDMA adapter.
> 
> Does this driver really depend on Ethernet, or does it also work with
> Ethernet support disabled?

The device should eventually expose Ethernet interface as well as IB.

> 
> > +static inline struct virtio_rdma_info *to_vdev(struct ib_device *ibdev)
> > +{
> > +	return container_of(ibdev, struct virtio_rdma_info, ib_dev);
> > +}
> 
> Is it really worth to introduce this function? Have you considered to
> use container_of(ibdev, struct virtio_rdma_info, ib_dev) directly instead
> of to_vdev()?

Agree, not sure really needed, just saw that some drivers uses this pattern.

> 
> > +static void rdma_ctrl_ack(struct virtqueue *vq)
> > +{
> > +	struct virtio_rdma_info *dev = vq->vdev->priv;
> > +
> > +	wake_up(&dev->acked);
> > +
> > +	printk("%s\n", __func__);
> > +}
> 
> Should that printk() be changed into pr_debug()? The same comment holds for
> all other printk() calls.

All prints will be removed, this is still wip.

> 
> > +#define VIRTIO_RDMA_BOARD_ID	1
> > +#define VIRTIO_RDMA_HW_NAME	"virtio-rdma"
> > +#define VIRTIO_RDMA_HW_REV	1
> > +#define VIRTIO_RDMA_DRIVER_VER	"1.0"
> 
> Is a driver version number useful in an upstream driver?

I've noticed that other drivers exposes this in sysfs.

> 
> > +struct ib_cq *virtio_rdma_create_cq(struct ib_device *ibdev,
> > +				    const struct ib_cq_init_attr *attr,
> > +				    struct ib_ucontext *context,
> > +				    struct ib_udata *udata)
> > +{
> > +	struct scatterlist in, out;
> > +	struct virtio_rdma_ib_cq *vcq;
> > +	struct cmd_create_cq *cmd;
> > +	struct rsp_create_cq *rsp;
> > +	struct ib_cq *cq = NULL;
> > +	int rc;
> > +
> > +	/* TODO: Check MAX_CQ */
> > +
> > +	cmd = kmalloc(sizeof(*cmd), GFP_ATOMIC);
> > +	if (!cmd)
> > +		return ERR_PTR(-ENOMEM);
> > +
> > +	rsp = kmalloc(sizeof(*rsp), GFP_ATOMIC);
> > +	if (!rsp) {
> > +		kfree(cmd);
> > +		return ERR_PTR(-ENOMEM);
> > +	}
> > +
> > +	vcq = kzalloc(sizeof(*vcq), GFP_KERNEL);
> > +	if (!vcq)
> > +		goto out;
> 
> Are you sure that you want to mix GFP_ATOMIC and GFP_KERNEL in a single
> function?

Right, a mistake.

> 
> Thanks,
> 
> Bart.

Thanks.

> 
