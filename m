Received: from eggs.gnu.org ([2001:4830:134:3::10]:54075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fBZiu-0002zh-OK
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 01:45:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fBZip-0004Mi-TZ
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 01:45:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56662 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fBZip-0004MT-P6
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 01:45:35 -0400
Date: Thu, 26 Apr 2018 13:45:22 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180426054522.GP9036@xz-mi>
References: <20180425045129.17449-1-peterx@redhat.com>
	<20180425045129.17449-4-peterx@redhat.com>
	<20180425162658.GA9204@flamenco>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180425162658.GA9204@flamenco>
Subject: Re: [Qemu-devel] [PATCH 03/10] intel-iommu: add iommu lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Jintack Lim <jintack@cs.columbia.edu>, "Michael S . Tsirkin" <mst@redhat.com>

On Wed, Apr 25, 2018 at 12:26:58PM -0400, Emilio G. Cota wrote:
> On Wed, Apr 25, 2018 at 12:51:22 +0800, Peter Xu wrote:
> > Add a per-iommu big lock to protect IOMMU status.  Currently the only
> > thing to be protected is the IOTLB cache, since that can be accessed
> > even without BQL, e.g., in IO dataplane.
> 
> Is the added lock going to protect anything else beyond a g_hash_table?

It's only for that now.  Maybe there can be other candidates.

> If not, did you consider using qht instead of the lock + hash table?
> It would give you lockless lookups as well as scalable updates.

Thanks for pointing that out.  I didn't even know that we have such a
nice hash there. :) Though for this series I would still prefer to
keep the mutex way as is for now.

Firstly, I'd better fix the problem first before considering
performance - after all this series is not really persuing for
performance but fixing holes.  So we can have follow up works for QHT
convertions.  Meanwhile, IOTLB is a bit special in that it might
really update more often than we thought, so I'm not really sure
whether a RCU-based hash would bring better performance.  This is even
not considering the fact that Linux guest intel-iommu driver will do
more tricks (like frequently flushing IOTLBs) to make the update much
more than usual.

But again, the suggestion is valid and it worths further
investigations to make sure my understandings are correct.

> 
> [Sorry if my question isn't relevant, I am not familiar with
> this code and just briefly skimmed over this series.

It's of course relevant.  Thanks for your input!

-- 
Peter Xu
