Received: from eggs.gnu.org ([2001:4830:134:3::10]:48642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1ffgWS-0005lT-4T
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 03:05:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1ffgWO-00009u-OI
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 03:05:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:16388)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pagupta@redhat.com>) id 1ffgWO-00006m-DS
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 03:05:12 -0400
Date: Wed, 18 Jul 2018 03:05:09 -0400 (EDT)
From: Pankaj Gupta <pagupta@redhat.com>
Message-ID: <2137768776.51859350.1531897509492.JavaMail.zimbra@redhat.com>
In-Reply-To: <20180717131156.GA13498@stefanha-x1.localdomain>
References: <20180713075232.9575-1-pagupta@redhat.com>
	<20180713075232.9575-3-pagupta@redhat.com>
	<20180717131156.GA13498@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v3 2/2] virtio-pmem: Add virtio pmem driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, linux-nvdimm@ml01.01.org, jack@suse.cz, dan j williams <dan.j.williams@intel.com>, riel@surriel.com, haozhong zhang <haozhong.zhang@intel.com>, nilal@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, ross zwisler <ross.zwisler@intel.com>, david@redhat.com, xiaoguangrong eric <xiaoguangrong.eric@gmail.com>, hch@infradead.org, mst@redhat.com, niteshnarayanlal@hotmail.com, lcapitulino@redhat.com, imammedo@redhat.com, eblake@redhat.com


Hi Stefan,

> > + /* The request submission function */
> > +static int virtio_pmem_flush(struct device *dev)
> > +{
> > +	int err;
> > +	unsigned long flags;
> > +	struct scatterlist *sgs[2], sg, ret;
> > +	struct virtio_device *vdev = dev_to_virtio(dev->parent->parent);
> > +	struct virtio_pmem *vpmem = vdev->priv;
> > +	struct virtio_pmem_request *req = kmalloc(sizeof(*req), GFP_KERNEL);
> > +
> > +	req->done = false;
> > +	init_waitqueue_head(&req->acked);
> > +	spin_lock_irqsave(&vpmem->pmem_lock, flags);
> > +
> > +	sg_init_one(&sg, req, sizeof(req));
> 
> What are you trying to do here?
> 
> sizeof(req) == sizeof(struct virtio_pmem_request *) == sizeof(void *)
> 
> Did you mean sizeof(*req)?

yes, I meant: sizeof(struct virtio_pmem_request)

Thanks for catching this.

> 
> But why map struct virtio_pmem_request to the device?  struct
> virtio_pmem_request is the driver-internal request state and is not part
> of the hardware interface.

o.k. I will separate out request from 'virtio_pmem_request' struct
and use that. 

> 
> > +	sgs[0] = &sg;
> > +	sg_init_one(&ret, &req->ret, sizeof(req->ret));
> > +	sgs[1] = &ret;
> > +	err = virtqueue_add_sgs(vpmem->req_vq, sgs, 1, 1, req, GFP_ATOMIC);
> > +	if (err) {
> > +		dev_err(&vdev->dev, "failed to send command to virtio pmem device\n");
> 
> This can happen if the virtqueue is full.  Printing a message and
> failing the flush isn't appropriate.  This thread needs to wait until
> virtqueue space becomes available.

o.k. I will implement this.

> 
> > +		spin_unlock_irqrestore(&vpmem->pmem_lock, flags);
> > +		return -ENOSPC;
> 
> req is leaked.

will free req.

> 
> > +	virtio_device_ready(vdev);
> 
> This call isn't needed.  Driver use it when they wish to submit buffers
> on virtqueues before ->probe() returns.

o.k. I will remove it.

> 
> > diff --git a/include/linux/virtio_pmem.h b/include/linux/virtio_pmem.h
> > new file mode 100644
> > index 0000000..0f83d9c
> > --- /dev/null
> > +++ b/include/linux/virtio_pmem.h
> 
> include/ is for declarations (e.g. kernel APIs) needed by other
> compilation units.  The contents of this header are internal to the
> virtio_pmem driver implementation and can therefore be in virtio_pmem.c.
> include/linux/virtio_pmem.h isn't necessary since nothing besides
> virtio_pmem.c will need to include it.

Agree. Will move declarations from virtio_pmem.h to virtio_pmem.c

Thanks,
Pankaj
