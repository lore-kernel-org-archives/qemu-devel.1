Received: from eggs.gnu.org ([2001:4830:134:3::10]:49739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1fBjzV-00063n-7F
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 12:43:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1fBjzS-0005U9-0M
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 12:43:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57830)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pagupta@redhat.com>) id 1fBjzR-0005Tl-Of
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 12:43:25 -0400
Date: Thu, 26 Apr 2018 12:43:24 -0400 (EDT)
From: Pankaj Gupta <pagupta@redhat.com>
Message-ID: <358601698.23011599.1524761004239.JavaMail.zimbra@redhat.com>
In-Reply-To: <20180426132406.GC30991@stefanha-x1.localdomain>
References: <20180425112415.12327-1-pagupta@redhat.com>
	<20180425112415.12327-4-pagupta@redhat.com>
	<20180426132406.GC30991@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v2] qemu: Add virtio pmem device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: jack@suse.cz, kvm@vger.kernel.org, david@redhat.com, linux-nvdimm@ml01.01.org, ross zwisler <ross.zwisler@intel.com>, qemu-devel@nongnu.org, lcapitulino@redhat.com, linux-mm@kvack.org, niteshnarayanlal@hotmail.com, mst@redhat.com, hch@infradead.org, marcel@redhat.com, nilal@redhat.com, haozhong zhang <haozhong.zhang@intel.com>, riel@surriel.com, stefanha@redhat.com, pbonzini@redhat.com, dan j williams <dan.j.williams@intel.com>, kwolf@redhat.com, xiaoguangrong eric <xiaoguangrong.eric@gmail.com>, linux-kernel@vger.kernel.org, imammedo@redhat.com



> > +static void virtio_pmem_flush(VirtIODevice *vdev, VirtQueue *vq)
> > +{
> > +    VirtQueueElement *elem;
> > +    VirtIOPMEM *pmem = VIRTIO_PMEM(vdev);
> > +    HostMemoryBackend *backend = MEMORY_BACKEND(pmem->memdev);
> > +    int fd = memory_region_get_fd(&backend->mr);
> > +
> > +    elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
> > +    if (!elem) {
> > +        return;
> > +    }
> > +    /* flush raw backing image */
> > +    fsync(fd);
> 
> fsync(2) is a blocking syscall.  This can hang QEMU for an unbounded
> amount of time.

o.k. Main thread will block, agree.

> 
> Please do the fsync from a thread pool.  See block/file-posix.c's
> aio_worker() for an example.

Sure!

> 
> > +static void virtio_pmem_get_config(VirtIODevice *vdev, uint8_t *config)
> > +{
> > +    VirtIOPMEM *pmem = VIRTIO_PMEM(vdev);
> > +    struct virtio_pmem_config *pmemcfg = (struct virtio_pmem_config *)
> > config;
> > +
> > +    pmemcfg->start = pmem->start;
> > +    pmemcfg->size  = pmem->size;
> 
> Endianness.  Please use virtio_st*_p() instead.

sure.

> 
> > +#define VIRTIO_PMEM_PLUG 0
> 
> What is this?

will remove

Thanks,
Pankaj 
