Received: from eggs.gnu.org ([2001:4830:134:3::10]:51430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dHtZp-0001Nc-4u
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 11:05:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dHtZk-0000g9-2u
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 11:05:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51740)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dHtZj-0000fT-T7
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 11:05:48 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8B01F81F01
	for <qemu-devel@nongnu.org>; Mon,  5 Jun 2017 15:05:46 +0000 (UTC)
Date: Mon, 5 Jun 2017 18:05:30 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170605180442-mutt-send-email-mst@kernel.org>
References: <1496404254-17429-1-git-send-email-peterx@redhat.com>
	<1496404254-17429-4-git-send-email-peterx@redhat.com>
	<20170602184329-mutt-send-email-mst@kernel.org>
	<20170605031511.GG4056@pxdev.xzpeter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170605031511.GG4056@pxdev.xzpeter.org>
Subject: Re: [Qemu-devel] [PATCH 3/3] vhost: iommu: cache static mapping if
 there is
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, Jason Wang <jasowang@redhat.com>

On Mon, Jun 05, 2017 at 11:15:11AM +0800, Peter Xu wrote:
> On Fri, Jun 02, 2017 at 06:45:05PM +0300, Michael S. Tsirkin wrote:
> > On Fri, Jun 02, 2017 at 07:50:54PM +0800, Peter Xu wrote:
> > > This patch pre-heat vhost iotlb cache when passthrough mode enabled.
> > > 
> > > Sometimes, even if user specified iommu_platform for vhost devices,
> > > IOMMU might still be disabled. One case is passthrough mode in VT-d
> > > implementation. We can detect this by observing iommu_list. If it's
> > > empty, it means IOMMU translation is disabled, then we can actually
> > > pre-heat the translation (it'll be static mapping then) by first
> > > invalidating all IOTLB, then cache existing memory ranges into vhost
> > > backend iotlb using 1:1 mapping.
> > > 
> > > Reviewed-by: Jason Wang <jasowang@redhat.com>
> > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > 
> > This is still a hack I think. What if there's an invalidation?
> > I think the right thing is to send updates only when requested,
> > but sent the largest mapping including the iova, not from iova until end
> > of page. Thoughts?
> 
> Indeed it's kind of a hack, but it does not hurt anything but will
> definitely boost performance in most cases...
> 
> Yes "sent the largest mapping including the iova" is okay, but the
> first IO on one region would be delayed as well, so IMHO it's not the
> best solution as well. I think the best solution should be (for sure)
> that vhost knows it's PT, then it just skips the translation
> completely. I just don't sure whether there's simple/good way to do
> this.
> 
> Thanks,

If you send the whole 64 bit area, then backend can detect this
easily.


> -- 
> Peter Xu
