Received: from eggs.gnu.org ([2001:4830:134:3::10]:33327)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1cGWO6-0005qC-3s
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 14:35:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1cGWO3-0001qo-5V
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 14:35:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44426)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1cGWO2-0001qG-VG
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 14:35:47 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0D5354E4F3
	for <qemu-devel@nongnu.org>; Mon, 12 Dec 2016 19:35:45 +0000 (UTC)
Date: Mon, 12 Dec 2016 12:35:44 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20161212123544.2139b842@t450s.home>
In-Reply-To: <20161212015602.GJ28693@pxdev.xzpeter.org>
References: <1481089965-3888-1-git-send-email-peterx@redhat.com>
	<1481089965-3888-3-git-send-email-peterx@redhat.com>
	<20161211051011-mutt-send-email-mst@kernel.org>
	<20161212015602.GJ28693@pxdev.xzpeter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.9 2/2] intel_iommu: extend supported
 guest aw to 48 bits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, jasowang@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

On Mon, 12 Dec 2016 10:01:15 +0800
Peter Xu <peterx@redhat.com> wrote:

> On Sun, Dec 11, 2016 at 05:13:45AM +0200, Michael S. Tsirkin wrote:
> > On Wed, Dec 07, 2016 at 01:52:45PM +0800, Peter Xu wrote:  
> > > Previously vt-d codes only supports 39 bits iova address width. It won't
> > > be hard to extend it to 48 bits.
> > > 
> > > After enabling this, we should be able to map larger iova addresses.
> > > 
> > > To check whether 48 bits aw is enabled, we can grep in the guest dmesg
> > > with line: "dmar: Host address width 48" (previously it was 39).
> > > 
> > > Signed-off-by: Peter Xu <peterx@redhat.com>  
> > 
> > I suspect we can't do this for old machine types.
> > Need to behave in compatible ways.  
> 
> Sure. I can do that.
> 
> Btw, is vt-d iommu still in experimental stage? I am just thinking
> whether it'll be overkill we add lots of tunables before we have one
> stable and mature vt-d emulation.
> 
> > Also, is 48 always enough? 5 level with 57 bits
> > is just around the corner.  
> 
> Please refer to the discussion with Jason - looks like vt-d spec
> currently supports only 39/48 bits address width? Please correct if I
> made a mistake.
> 
> > And is it always supported? for things like vfio
> > to work, don't we need to check what does host support?  
> 
> Hmm, yes, we should do that. But until now, we still don't have a
> complete vfio support. IMHO we can postpone this issue until vfio is
> fully supported.

I'm not sure how the vIOMMU supporting 39 bits or 48 bits is directly
relevant to vfio, we're not sharing page tables.  There is already a
case today, without vIOMMU that you can make a guest which has more
guest physical address space than the hardware IOMMU by overcommitting
system memory.  Generally this quickly resolves itself when we start
pinning pages since the physical address width of the IOMMU is
typically the same as the physical address width of the host system
(ie. we exhaust the host memory).  It is possible though that we could
create a sparse memory VM that makes use of gfns beyond the physical
IOMMU, with or without a vIOMMU.  You'll get an error from the mapping
ioctl when this occurs and the VM will abort.  It's not typically an
issue since the memory capacity of the host and the IOMMU physical
address width really better align fairly well.  Thanks,

Alex
