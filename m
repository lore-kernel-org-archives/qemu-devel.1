Received: from eggs.gnu.org ([2001:4830:134:3::10]:42391)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ffPlv-0003Rq-Mp
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 09:12:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ffPlu-00006w-Nr
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 09:12:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41892 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ffPlu-00006T-GV
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 09:12:06 -0400
Date: Tue, 17 Jul 2018 14:11:56 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180717131156.GA13498@stefanha-x1.localdomain>
References: <20180713075232.9575-1-pagupta@redhat.com>
	<20180713075232.9575-3-pagupta@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IS0zKkzwUGydFO0o"
Content-Disposition: inline
In-Reply-To: <20180713075232.9575-3-pagupta@redhat.com>
Subject: Re: [Qemu-devel] [RFC v3 2/2] virtio-pmem: Add virtio pmem driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pankaj Gupta <pagupta@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, linux-nvdimm@ml01.01.org, jack@suse.cz, dan.j.williams@intel.com, riel@surriel.com, haozhong.zhang@intel.com, nilal@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, ross.zwisler@intel.com, david@redhat.com, xiaoguangrong.eric@gmail.com, hch@infradead.org, mst@redhat.com, niteshnarayanlal@hotmail.com, lcapitulino@redhat.com, imammedo@redhat.com, eblake@redhat.com


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


On Fri, Jul 13, 2018 at 01:22:31PM +0530, Pankaj Gupta wrote:
> + /* The request submission function */
> +static int virtio_pmem_flush(struct device *dev)
> +{
> +	int err;
> +	unsigned long flags;
> +	struct scatterlist *sgs[2], sg, ret;
> +	struct virtio_device *vdev = dev_to_virtio(dev->parent->parent);
> +	struct virtio_pmem *vpmem = vdev->priv;
> +	struct virtio_pmem_request *req = kmalloc(sizeof(*req), GFP_KERNEL);
> +
> +	req->done = false;
> +	init_waitqueue_head(&req->acked);
> +	spin_lock_irqsave(&vpmem->pmem_lock, flags);
> +
> +	sg_init_one(&sg, req, sizeof(req));

What are you trying to do here?

sizeof(req) == sizeof(struct virtio_pmem_request *) == sizeof(void *)

Did you mean sizeof(*req)?

But why map struct virtio_pmem_request to the device?  struct
virtio_pmem_request is the driver-internal request state and is not part
of the hardware interface.

> +	sgs[0] = &sg;
> +	sg_init_one(&ret, &req->ret, sizeof(req->ret));
> +	sgs[1] = &ret;
> +	err = virtqueue_add_sgs(vpmem->req_vq, sgs, 1, 1, req, GFP_ATOMIC);
> +	if (err) {
> +		dev_err(&vdev->dev, "failed to send command to virtio pmem device\n");

This can happen if the virtqueue is full.  Printing a message and
failing the flush isn't appropriate.  This thread needs to wait until
virtqueue space becomes available.

> +		spin_unlock_irqrestore(&vpmem->pmem_lock, flags);
> +		return -ENOSPC;

req is leaked.

> +	virtio_device_ready(vdev);

This call isn't needed.  Driver use it when they wish to submit buffers
on virtqueues before ->probe() returns.

> diff --git a/include/linux/virtio_pmem.h b/include/linux/virtio_pmem.h
> new file mode 100644
> index 0000000..0f83d9c
> --- /dev/null
> +++ b/include/linux/virtio_pmem.h

include/ is for declarations (e.g. kernel APIs) needed by other
compilation units.  The contents of this header are internal to the
virtio_pmem driver implementation and can therefore be in virtio_pmem.c.
include/linux/virtio_pmem.h isn't necessary since nothing besides
virtio_pmem.c will need to include it.

--IS0zKkzwUGydFO0o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbTescAAoJEJykq7OBq3PIwPQH/3keU8xWbvv1c729mwMrCSlT
GRJkt3AyzE2iIoaXFkeBpnjnpARsajzX0vH/EheCEse46G6aOtia9fALOzf0Fo2l
XRB1KM3WhEDIx+xNZuk4/WH5AaSHEJPjSBM6Isv410MASfrDJzyu0vuRSjzqEAT8
augb75qojqCkqkDQm5iMcN6zGwgjJ0MLrXZdN8EKIpgsqeMW7QmwWCwlmWwCgXrq
f5nor6oEl3jci/EYjw6ctjWsBCSKdDz813phHbQLCbcMD9IuEngGlZt5b9XwdfNY
5u2SaC66cIPqMYyogb6duBFMZ2AOzkrSZjHbHyh1HArf7Lhd/aoYYMLABy/hwTs=
=0jCu
-----END PGP SIGNATURE-----

--IS0zKkzwUGydFO0o--
