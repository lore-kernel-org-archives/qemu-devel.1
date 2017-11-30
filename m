Received: from eggs.gnu.org ([2001:4830:134:3::10]:57524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eKKt4-0000bR-Mi
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 04:12:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eKKt0-0005Qs-Mr
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 04:12:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:19699)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eKKt0-0005QY-GG
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 04:12:02 -0500
Date: Thu, 30 Nov 2017 17:11:55 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20171130091155.GH22901@xz-mi>
References: <20171114231350.286025-1-prasad.singamsetty@oracle.com>
	<20171114231350.286025-3-prasad.singamsetty@oracle.com>
	<20171130052238.GB30936@sky-dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171130052238.GB30936@sky-dev>
Subject: Re: [Qemu-devel] [PATCH v1 2/2] intel-iommu: Extend address width
 to 48 bits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Liu, Yi L" <yi.l.liu@linux.intel.com>
Cc: prasad.singamsetty@oracle.com, qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, mst@redhat.com, imammedo@redhat.com, konrad.wilk@oracle.com

On Thu, Nov 30, 2017 at 01:22:38PM +0800, Liu, Yi L wrote:
> On Tue, Nov 14, 2017 at 06:13:50PM -0500, prasad.singamsetty@oracle.com wrote:
> > From: Prasad Singamsetty <prasad.singamsetty@oracle.com>
> > 
> > The current implementation of Intel IOMMU code only supports 39 bits
> > iova address width. This patch provides a new parameter (x-aw-bits)
> > for intel-iommu to extend its address width to 48 bits but keeping the
> > default the same (39 bits). The reason for not changing the default
> > is to avoid potential compatibility problems with live migration of
> > intel-iommu enabled QEMU guest. The only valid values for 'x-aw-bits'
> > parameter are 39 and 48.
> > 
> > After enabling larger address width (48), we should be able to map
> > larger iova addresses in the guest. For example, a QEMU guest that
> > is configured with large memory ( >=1TB ). To check whether 48 bits
> 
> I didn't quite get your point here. Address width limits the iova range,
> but it doesn't limit the guest memory range. e.g. you can use 39 bit iova
> address to access a guest physical address larger than (2^39 - 1) as long
> as the guest 2nd level page table is well programmed. Only one exception,
> if you requires a continuous iova range(e.g. 2^39), it would be an issue.
> Not sure if this is the major motivation of your patch? However, I'm not
> against extend the address width to be 48 bits. Just need to make it clear
> here.

One thing I can think of is the identity mapping. Say, when iommu=pt
is set in guest, meanwhile when PT capability is not supported from
hardware (here I mean, the emulated hardware, of course), guest kernel
will create one identity mapping to emulate the PT mode.

Current linux kernel's identity mapping should be a static 48 bits
mapping (it must cover the whole memory range of guest), so if we
provide a 39 bits vIOMMU to the guest, AFAIU we'll fail at device
attaching to that identity domain of every single device that is
protected by that 39 bits vIOMMU (kernel will find that domain gaw is
bigger than vIOMMU supported gaw of that device).

I do see no good fix for that, except boost the supported gaw to
bigger ones.

Thanks,

-- 
Peter Xu
