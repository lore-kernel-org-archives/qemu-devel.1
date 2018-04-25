Received: from eggs.gnu.org ([2001:4830:134:3::10]:45593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1fBM4i-0001L6-HG
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 11:11:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1fBM4e-0007nM-E0
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 11:11:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38095)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pagupta@redhat.com>) id 1fBM4e-0007m4-5w
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 11:11:12 -0400
Date: Wed, 25 Apr 2018 11:11:09 -0400 (EDT)
From: Pankaj Gupta <pagupta@redhat.com>
Message-ID: <1651348200.22658063.1524669069712.JavaMail.zimbra@redhat.com>
In-Reply-To: <20180425174705-mutt-send-email-mst@kernel.org>
References: <20180425112415.12327-1-pagupta@redhat.com>
	<20180425112415.12327-2-pagupta@redhat.com>
	<20180425174705-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v2 1/2] virtio: add pmem driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kwolf@redhat.com, haozhong zhang <haozhong.zhang@intel.com>, lcapitulino@redhat.com, jack@suse.cz, xiaoguangrong eric <xiaoguangrong.eric@gmail.com>, kvm@vger.kernel.org, riel@surriel.com, linux-nvdimm@ml01.01.org, david@redhat.com, ross zwisler <ross.zwisler@intel.com>, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, hch@infradead.org, linux-mm@kvack.org, imammedo@redhat.com, stefanha@redhat.com, niteshnarayanlal@hotmail.com, marcel@redhat.com, pbonzini@redhat.com, dan j williams <dan.j.williams@intel.com>, nilal@redhat.com


> 
> On Wed, Apr 25, 2018 at 04:54:13PM +0530, Pankaj Gupta wrote:
> > diff --git a/include/uapi/linux/virtio_ids.h
> > b/include/uapi/linux/virtio_ids.h
> > index 6d5c3b2..5ebd049 100644
> > --- a/include/uapi/linux/virtio_ids.h
> > +++ b/include/uapi/linux/virtio_ids.h
> > @@ -43,5 +43,6 @@
> >  #define VIRTIO_ID_INPUT        18 /* virtio input */
> >  #define VIRTIO_ID_VSOCK        19 /* virtio vsock transport */
> >  #define VIRTIO_ID_CRYPTO       20 /* virtio crypto */
> > +#define VIRTIO_ID_PMEM         21 /* virtio pmem */
> >  
> >  #endif /* _LINUX_VIRTIO_IDS_H */
> 
> Please register the device id with virtio TC.

O.K Will create virtio spec and follow the procedure.
 
> 
> 
> > diff --git a/include/uapi/linux/virtio_pmem.h
> > b/include/uapi/linux/virtio_pmem.h
> > new file mode 100644
> > index 0000000..2ec27cb
> > --- /dev/null
> > +++ b/include/uapi/linux/virtio_pmem.h
> > @@ -0,0 +1,58 @@
> > +/* Virtio pmem Driver
> > + *
> > + * Discovers persitent memory range information
> > + * from host and provides a virtio based flushing
> > + * interface.
> > + */
> > +
> > +#ifndef _LINUX_VIRTIO_PMEM_H
> > +#define _LINUX_VIRTIO_PMEM_H
> > +
> > +#include <linux/types.h>
> > +#include <linux/virtio_types.h>
> > +#include <linux/virtio_ids.h>
> > +#include <linux/virtio_config.h>
> > +#include <linux/virtio_ring.h>
> > +
> > +
> > +struct virtio_pmem_config {
> > +
> 
> don't add empty lines pls.

o.k

> 
> > +	uint64_t start;
> > +	uint64_t size;
> 
> Used LE fields for everything.

o.k

> 
> > +};
> > +
> > +struct virtio_pmem {
> > +
> > +	struct virtio_device *vdev;
> > +	struct virtqueue *req_vq;
> > +
> > +	uint64_t start;
> > +	uint64_t size;
> > +} __packed;
> 
> This does not belong in uapi, and should not be packed either.

o.k

> 
> > +
> > +static struct virtio_device_id id_table[] = {
> > +	{ VIRTIO_ID_PMEM, VIRTIO_DEV_ANY_ID },
> > +	{ 0 },
> > +};
> > +
> > +void virtio_pmem_flush(struct device *dev)
> > +{
> > +	struct scatterlist sg;
> > +	struct virtio_device *vdev  = dev_to_virtio(dev->parent->parent);
> > +	struct virtio_pmem   *vpmem = vdev->priv;
> > +	char *buf = "FLUSH";
> > +	int err;
> > +
> > +	sg_init_one(&sg, buf, sizeof(buf));
> > +
> > +	err = virtqueue_add_outbuf(vpmem->req_vq, &sg, 1, buf, GFP_KERNEL);
> > +
> > +	if (err) {
> > +		dev_err(&vdev->dev, "failed to send command to virtio pmem device\n");
> > +		return;
> > +	}
> > +
> > +	virtqueue_kick(vpmem->req_vq);
> > +};
> 
> this doesn't belong in uapi.

o.k.

Thanks,
Pankaj
