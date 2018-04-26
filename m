Received: from eggs.gnu.org ([2001:4830:134:3::10]:51287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fBhCD-0006Ck-TA
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 09:44:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fBhCA-00048v-Qj
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 09:44:25 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:36620)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fBhCA-00048f-IR
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 09:44:22 -0400
Received: by mail-wm0-x244.google.com with SMTP id n10so13357279wmc.1
	for <qemu-devel@nongnu.org>; Thu, 26 Apr 2018 06:44:22 -0700 (PDT)
Date: Thu, 26 Apr 2018 14:24:06 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180426132406.GC30991@stefanha-x1.localdomain>
References: <20180425112415.12327-1-pagupta@redhat.com>
	<20180425112415.12327-4-pagupta@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Fig2xvG2VGoz8o/s"
Content-Disposition: inline
In-Reply-To: <20180425112415.12327-4-pagupta@redhat.com>
Subject: Re: [Qemu-devel] [RFC v2] qemu: Add virtio pmem device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pankaj Gupta <pagupta@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, linux-nvdimm@ml01.01.org, linux-mm@kvack.org, jack@suse.cz, stefanha@redhat.com, dan.j.williams@intel.com, riel@surriel.com, haozhong.zhang@intel.com, nilal@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, ross.zwisler@intel.com, david@redhat.com, xiaoguangrong.eric@gmail.com, hch@infradead.org, marcel@redhat.com, mst@redhat.com, niteshnarayanlal@hotmail.com, imammedo@redhat.com, lcapitulino@redhat.com


--Fig2xvG2VGoz8o/s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 25, 2018 at 04:54:15PM +0530, Pankaj Gupta wrote:
> +static void virtio_pmem_flush(VirtIODevice *vdev, VirtQueue *vq)
> +{
> +    VirtQueueElement *elem;
> +    VirtIOPMEM *pmem = VIRTIO_PMEM(vdev);
> +    HostMemoryBackend *backend = MEMORY_BACKEND(pmem->memdev);
> +    int fd = memory_region_get_fd(&backend->mr);
> +
> +    elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
> +    if (!elem) {
> +        return;
> +    }
> +    /* flush raw backing image */
> +    fsync(fd);

fsync(2) is a blocking syscall.  This can hang QEMU for an unbounded
amount of time.

Please do the fsync from a thread pool.  See block/file-posix.c's
aio_worker() for an example.

> +static void virtio_pmem_get_config(VirtIODevice *vdev, uint8_t *config)
> +{
> +    VirtIOPMEM *pmem = VIRTIO_PMEM(vdev);
> +    struct virtio_pmem_config *pmemcfg = (struct virtio_pmem_config *) config;
> +
> +    pmemcfg->start = pmem->start;
> +    pmemcfg->size  = pmem->size;

Endianness.  Please use virtio_st*_p() instead.

> +#define VIRTIO_PMEM_PLUG 0

What is this?

--Fig2xvG2VGoz8o/s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa4dL2AAoJEJykq7OBq3PIp2cH/04ij3qJX2uJVEfJckUXj9lJ
fjMJsmgdYmJatxT52TPw12puheCukYnuCbsWspRls4Q2Lr0sKRZ1vQ9nObO8yTUT
jtsRUwuiezUPUwih88GHt0Rud52SZtq9fCtkYf3mupjxn22n9x2xeFVMqgKvKZoJ
QdfS/K5FrrD+wBAptUjTMWt7Kf0mTANUDUUfHj5zgQwT6nwHbFyImF3etC4I98Yf
MSjPFw3V5mF4TYV5ZoPHXQmE6tjVj2G17SJiKfa5x53RNUMDTYD4DJaLQnCeRLLa
7ka5Z4SDUlBvZkLDEAx5VQ7rWHPjCpoddcqqXAhiDGDBb6zZAKtY7i/WUV9kxaE=
=NyIA
-----END PGP SIGNATURE-----

--Fig2xvG2VGoz8o/s--
