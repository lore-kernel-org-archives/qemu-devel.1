Received: from eggs.gnu.org ([2001:4830:134:3::10]:60795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dGnv7-0003Qi-Ea
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 10:51:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dGnv1-00063R-Cb
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 10:51:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57688)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dGnv1-00062h-6Z
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 10:51:15 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EE3DF7D0C3
	for <qemu-devel@nongnu.org>; Fri,  2 Jun 2017 14:51:12 +0000 (UTC)
Date: Fri, 2 Jun 2017 17:51:07 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170602174804-mutt-send-email-mst@kernel.org>
References: <1496404254-17429-1-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1496404254-17429-1-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/3] exec: further refine
 address_space_get_iotlb_entry()
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

On Fri, Jun 02, 2017 at 07:50:51PM +0800, Peter Xu wrote:
> With the patch applied:
> 
>   [PATCH v3] exec: fix address_space_get_iotlb_entry page mask
>   (already in Paolo's pull request but not yet merged)
> 
> Now we can have valid address masks. However it is still not ideal,
> considering that the mask may not be aligned to guest page sizes. One
> example would be when huge page is used in guest (please see commit
> message in patch 1 for details). It applies to normal pages too. So we
> not only need a valid address mask, we should make sure it is page
> mask (for x86, it should be either 4K/2M/1G pages).

Why should we? To get better performance, right?

> Patch 1+2 fixes the problem. Tested with both kernel net driver or
> testpmd, on either 4K/2M pages, to make sure the page mask is correct.
> 
> Patch 3 is cherry picked from PT series, after fixing from 1+2, we'll
> definitely want patch 3 now. Here's the simplest TCP streaming test
> using vhost dmar and iommu=pt in guest:
> 
>   without patch 3:    12.0Gbps

And what happens without patches 1-2?

>   with patch 3:       33.5Gbps

This is the part I don't get. Patches 1-2 will return a bigger region to
callers. The result should be better performance - instead it seems to
slow down vhost for some reason and we need tricks to get
performance back. What's going on?

> Please review, thanks.
> 
> Peter Xu (3):
>   exec: add page_mask for address_space_do_translate
>   exec: simplify address_space_get_iotlb_entry
>   vhost: iommu: cache static mapping if there is
> 
>  exec.c                 | 73 +++++++++++++++++++++++++++++++++-----------------
>  hw/virtio/trace-events |  4 +++
>  hw/virtio/vhost.c      | 66 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 119 insertions(+), 24 deletions(-)
> 
> -- 
> 2.7.4
