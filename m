Received: from eggs.gnu.org ([2001:4830:134:3::10]:54249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1e46gi-0000vq-LR
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 10:48:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1e46gQ-0001aC-BC
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 10:48:16 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:48703)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1e46gQ-0001YY-2m
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 10:47:58 -0400
Received: by mail-wm0-x242.google.com with SMTP id i124so4085634wmf.3
	for <qemu-devel@nongnu.org>; Mon, 16 Oct 2017 07:47:56 -0700 (PDT)
Date: Mon, 16 Oct 2017 15:47:53 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20171016144753.GB14135@stefanha-x1.localdomain>
References: <20171012155027.3277-1-pagupta@redhat.com>
	<20171012155027.3277-3-pagupta@redhat.com>
	<20171013094431.GA27308@stefanha-x1.localdomain>
	<24301306.20068579.1507891695416.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24301306.20068579.1507891695416.JavaMail.zimbra@redhat.com>
Subject: Re: [Qemu-devel] [RFC 2/2] KVM: add virtio-pmem driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pankaj Gupta <pagupta@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, linux-nvdimm@ml01.01.org, linux-mm@kvack.org, jack@suse.cz, stefanha@redhat.com, dan j williams <dan.j.williams@intel.com>, riel@redhat.com, haozhong zhang <haozhong.zhang@intel.com>, nilal@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, ross zwisler <ross.zwisler@intel.com>, david@redhat.com, xiaoguangrong eric <xiaoguangrong.eric@gmail.com>

On Fri, Oct 13, 2017 at 06:48:15AM -0400, Pankaj Gupta wrote:
> > On Thu, Oct 12, 2017 at 09:20:26PM +0530, Pankaj Gupta wrote:
> > > +static blk_qc_t virtio_pmem_make_request(struct request_queue *q,
> > > +			struct bio *bio)
> > > +{
> > > +	blk_status_t rc = 0;
> > > +	struct bio_vec bvec;
> > > +	struct bvec_iter iter;
> > > +	struct virtio_pmem *pmem = q->queuedata;
> > > +
> > > +	if (bio->bi_opf & REQ_FLUSH)
> > > +		//todo host flush command
> > 
> > This detail is critical to the device design.  What is the plan?
> 
> yes, this is good point.
> 
> was thinking of guest sending a flush command to Qemu which
> will do a fsync on file fd.

Previously there was discussion about fsyncing a specific file range
instead of the whole file.  This could perform better in cases where
only a subset of dirty pages need to be flushed.

One possibility is to design the virtio interface to communicate ranges
but the emulation code simply fsyncs the fd for the time being.  Later
on, if the necessary kernel and userspace interfaces are added, we can
make use of the interface.

> If we do a async flush and move the task to wait queue till we receive 
> flush complete reply from host we can allow other tasks to execute
> in current cpu.
> 
> Any suggestions you have or anything I am not foreseeing here?

My main thought about this patch series is whether pmem should be a
virtio-blk feature bit instead of a whole new device.  There is quite a
bit of overlap between the two.

Stefan
