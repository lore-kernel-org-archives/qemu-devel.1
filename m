Received: from eggs.gnu.org ([2001:4830:134:3::10]:43485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1fCNPN-0007L1-Co
	for qemu-devel@nongnu.org; Sat, 28 Apr 2018 06:48:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1fCNPI-0000Hn-Gr
	for qemu-devel@nongnu.org; Sat, 28 Apr 2018 06:48:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56006)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pagupta@redhat.com>) id 1fCNPI-0000HW-9x
	for qemu-devel@nongnu.org; Sat, 28 Apr 2018 06:48:44 -0400
Date: Sat, 28 Apr 2018 06:48:41 -0400 (EDT)
From: Pankaj Gupta <pagupta@redhat.com>
Message-ID: <1266554822.23475618.1524912521209.JavaMail.zimbra@redhat.com>
In-Reply-To: <20180427133146.GB11150@stefanha-x1.localdomain>
References: <20180425112415.12327-1-pagupta@redhat.com>
	<20180425112415.12327-2-pagupta@redhat.com>
	<20180426131236.GA30991@stefanha-x1.localdomain>
	<197910974.22984070.1524757499459.JavaMail.zimbra@redhat.com>
	<20180427133146.GB11150@stefanha-x1.localdomain>
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
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: jack@suse.cz, kvm@vger.kernel.org, david@redhat.com, linux-nvdimm@ml01.01.org, ross zwisler <ross.zwisler@intel.com>, qemu-devel@nongnu.org, lcapitulino@redhat.com, linux-mm@kvack.org, niteshnarayanlal@hotmail.com, mst@redhat.com, hch@infradead.org, Stefan Hajnoczi <stefanha@gmail.com>, marcel@redhat.com, nilal@redhat.com, haozhong zhang <haozhong.zhang@intel.com>, riel@surriel.com, pbonzini@redhat.com, dan j williams <dan.j.williams@intel.com>, kwolf@redhat.com, xiaoguangrong eric <xiaoguangrong.eric@gmail.com>, linux-kernel@vger.kernel.org, imammedo@redhat.com


> > > > +        int err;
> > > > +
> > > > +        sg_init_one(&sg, buf, sizeof(buf));
> > > > +
> > > > +        err = virtqueue_add_outbuf(vpmem->req_vq, &sg, 1, buf, GFP_KERNEL);
> > > > +
> > > > +        if (err) {
> > > > +                dev_err(&vdev->dev, "failed to send command to virtio pmem
> > > > device\n");
> > > > +                return;
> > > > +        }
> > > > +
> > > > +        virtqueue_kick(vpmem->req_vq);
> > > 
> > > Is any locking necessary?  Two CPUs must not invoke virtio_pmem_flush()
> > > at the same time.  Not sure if anything guarantees this, maybe you're
> > > relying on libnvdimm but I haven't checked.
> > 
> > I thought about it to some extent, and wanted to go ahead with simple
> > version first:
> > 
> > - I think file 'inode -> locking' sill is there for request on single file.
> > - For multiple files, our aim is to just flush the backend block image.
> > - Even there is collision for virt queue read/write entry it should just
> > trigger a Qemu fsync.
> >   We just want most recent flush to assure guest writes are synced
> >   properly.
> > 
> > Important point here: We are doing entire block fsync for guest virtual
> > disk.
> 
> I don't understand your answer.  Is locking necessary or not?

It will be required with other changes.

> 
> From the virtqueue_add_outbuf() documentation:
> 
>  * Caller must ensure we don't call this with other virtqueue operations
>  * at the same time (except where noted).

Yes, I also saw it. But thought if can avoid it with current functionality. :)


Thanks,
Pankaj
