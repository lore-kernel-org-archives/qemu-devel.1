Received: from eggs.gnu.org ([2001:4830:134:3::10]:39293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1e4o0k-0005P3-Ns
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 09:03:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1e4o0f-0007dn-2z
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 09:03:50 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:52057)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1e4o0e-0007dC-SS
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 09:03:45 -0400
Received: by mail-wm0-x242.google.com with SMTP id f4so10114720wme.0
	for <qemu-devel@nongnu.org>; Wed, 18 Oct 2017 06:03:43 -0700 (PDT)
Date: Wed, 18 Oct 2017 15:03:39 +0200
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20171018130339.GB29767@stefanha-x1.localdomain>
References: <20171012155027.3277-1-pagupta@redhat.com>
	<20171012155027.3277-3-pagupta@redhat.com>
	<20171017071633.GA9207@infradead.org>
	<1441791227.21027037.1508226056893.JavaMail.zimbra@redhat.com>
	<20171017080236.GA27649@infradead.org>
	<670833322.21037148.1508229041158.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <670833322.21037148.1508229041158.JavaMail.zimbra@redhat.com>
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
Cc: Christoph Hellwig <hch@infradead.org>, kwolf@redhat.com, haozhong zhang <haozhong.zhang@intel.com>, jack@suse.cz, xiaoguangrong eric <xiaoguangrong.eric@gmail.com>, kvm@vger.kernel.org, david@redhat.com, linux-nvdimm@ml01.01.org, ross zwisler <ross.zwisler@intel.com>, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, linux-mm@kvack.org, stefanha@redhat.com, pbonzini@redhat.com, dan j williams <dan.j.williams@intel.com>, nilal@redhat.com

On Tue, Oct 17, 2017 at 04:30:41AM -0400, Pankaj Gupta wrote:
> 
> > > Are you saying do it as existing i.e ACPI pmem like interface?
> > > The reason we have created this new driver is exiting pmem driver
> > > does not define proper semantics for guest flushing requests.
> > 
> > At this point I'm caring about the Linux-internal interface, and
> > for that it should be integrated into the nvdimm subsystem and not
> > a block driver.  How the host <-> guest interface looks is a different
> > idea.
> > 
> > > 
> > > Regarding block support of driver, we want to achieve DAX support
> > > to bypass guest page cache. Also, we want to utilize existing DAX
> > > capable file-system interfaces(e.g fsync) from userspace file API's
> > > to trigger the host side flush request.
> > 
> > Well, if you want to support XFS+DAX better don't make it a block
> > devices, because I'll post patches soon to stop using the block device
> > entirely for the DAX case.
> 
> o.k I will look at your patches once they are in mailing list.
> Thanks for the heads up.
> 
> If I am guessing it right, we don't need block device additional features
> for pmem? We can bypass block device features like blk device cache flush etc.
> Also, still we would be supporting ext4 & XFS filesystem with pmem?
> 
> If there is time to your patches can you please elaborate on this a bit.

I think the idea is that the nvdimm subsystem already adds block device
semantics on top of the struct nvdimms that it manages.  See
drivers/nvdimm/blk.c.

So it would be cleaner to make virtio-pmem an nvdimm bus.  This will
eliminate the duplication between your driver and drivers/nvdimm/ code.
Try "git grep nvdimm_bus_register" to find drivers that use the nvdimm
subsystem.

The virtio-pmem driver could register itself similar to the existing
ACPI NFIT and BIOS e820 pmem drivers.

Stefan
