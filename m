Received: from eggs.gnu.org ([2001:4830:134:3::10]:44156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1e55m6-0006So-9l
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 04:01:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1e55m3-0002aa-7O
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 04:01:54 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:54190)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1e55m3-0002aJ-1Z
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 04:01:51 -0400
Received: by mail-wm0-x243.google.com with SMTP id q132so14537782wmd.2
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 01:01:50 -0700 (PDT)
Date: Thu, 19 Oct 2017 10:01:46 +0200
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20171019080146.GA3503@stefanha-x1.localdomain>
References: <20171012155027.3277-1-pagupta@redhat.com>
	<20171012155027.3277-3-pagupta@redhat.com>
	<20171017071633.GA9207@infradead.org>
	<1441791227.21027037.1508226056893.JavaMail.zimbra@redhat.com>
	<20171017080236.GA27649@infradead.org>
	<670833322.21037148.1508229041158.JavaMail.zimbra@redhat.com>
	<20171018130339.GB29767@stefanha-x1.localdomain>
	<CAPcyv4h6aFkyHhh4R4DTznbSCLf9CuBoszk0Q1gB5EKNcp_SeQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4h6aFkyHhh4R4DTznbSCLf9CuBoszk0Q1gB5EKNcp_SeQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [RFC 2/2] KVM: add virtio-pmem driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Pankaj Gupta <pagupta@redhat.com>, Christoph Hellwig <hch@infradead.org>, Kevin Wolf <kwolf@redhat.com>, haozhong zhang <haozhong.zhang@intel.com>, Jan Kara <jack@suse.cz>, xiaoguangrong eric <xiaoguangrong.eric@gmail.com>, KVM list <kvm@vger.kernel.org>, David Hildenbrand <david@redhat.com>, linux-nvdimm <linux-nvdimm@ml01.01.org>, ross zwisler <ross.zwisler@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Qemu Developers <qemu-devel@nongnu.org>, Linux MM <linux-mm@kvack.org>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Nitesh Narayan Lal <nilal@redhat.com>

On Wed, Oct 18, 2017 at 08:51:37AM -0700, Dan Williams wrote:
> On Wed, Oct 18, 2017 at 6:03 AM, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> > On Tue, Oct 17, 2017 at 04:30:41AM -0400, Pankaj Gupta wrote:
> >>
> >> > > Are you saying do it as existing i.e ACPI pmem like interface?
> >> > > The reason we have created this new driver is exiting pmem driver
> >> > > does not define proper semantics for guest flushing requests.
> >> >
> >> > At this point I'm caring about the Linux-internal interface, and
> >> > for that it should be integrated into the nvdimm subsystem and not
> >> > a block driver.  How the host <-> guest interface looks is a different
> >> > idea.
> >> >
> >> > >
> >> > > Regarding block support of driver, we want to achieve DAX support
> >> > > to bypass guest page cache. Also, we want to utilize existing DAX
> >> > > capable file-system interfaces(e.g fsync) from userspace file API's
> >> > > to trigger the host side flush request.
> >> >
> >> > Well, if you want to support XFS+DAX better don't make it a block
> >> > devices, because I'll post patches soon to stop using the block device
> >> > entirely for the DAX case.
> >>
> >> o.k I will look at your patches once they are in mailing list.
> >> Thanks for the heads up.
> >>
> >> If I am guessing it right, we don't need block device additional features
> >> for pmem? We can bypass block device features like blk device cache flush etc.
> >> Also, still we would be supporting ext4 & XFS filesystem with pmem?
> >>
> >> If there is time to your patches can you please elaborate on this a bit.
> >
> > I think the idea is that the nvdimm subsystem already adds block device
> > semantics on top of the struct nvdimms that it manages.  See
> > drivers/nvdimm/blk.c.
> >
> > So it would be cleaner to make virtio-pmem an nvdimm bus.  This will
> > eliminate the duplication between your driver and drivers/nvdimm/ code.
> > Try "git grep nvdimm_bus_register" to find drivers that use the nvdimm
> > subsystem.
> 
> This use case is not "Persistent Memory". Persistent Memory is
> something you can map and make persistent with CPU instructions.
> Anything that requires a driver call is device driver managed "Shared
> Memory".

Dan, in that case do you have ideas regarding Christoph Hellwig's
comment that this driver should be integrated into the nvdimm subsystem
instead of a new block driver?

Stefan
