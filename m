Received: from eggs.gnu.org ([2001:4830:134:3::10]:56525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dVsRa-0000sw-Nd
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 00:43:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dVsRZ-0001To-Mu
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 00:43:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53562)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dVsRZ-0001TP-FT
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 00:43:09 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 63EEF68DA
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 04:43:08 +0000 (UTC)
Date: Fri, 14 Jul 2017 12:43:05 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170714044305.GL27284@pxdev.xzpeter.org>
References: <1499847223-8078-1-git-send-email-peterx@redhat.com>
	<1499847223-8078-5-git-send-email-peterx@redhat.com>
	<20170713204803-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170713204803-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH v3 4/4] intel_iommu: implement mru list for
 iotlb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>

On Thu, Jul 13, 2017 at 08:49:44PM +0300, Michael S. Tsirkin wrote:
> On Wed, Jul 12, 2017 at 04:13:43PM +0800, Peter Xu wrote:
> > It is not wise to disgard all the IOTLB cache when cache size reaches
> > max, but that's what we do now. A slightly better (but still simple) way
> > to do this is, we just throw away the least recent used cache entry.
> 
> Not wise how? Slower? It seems simpler.

When the cache is full, the cached items are still valid, but we just
throw them away. I agree it is definitely simpler, but is that really
wise?

> 
> > This patch implemented MRU list algorithm for VT-d IOTLB. The main logic
> > is to maintain a Most Recently Used list for the IOTLB entries. The hash
> > table is still used for lookup, though a new list field is added to each
> > IOTLB entry for a iotlb MRU list. For each active IOTLB entry, it's both
> > in the hash table in s->iotlb, and also linked into the MRU list of
> > s->iotlb_head. The hash helps in fast lookup, and the MRU list helps in
> > knowing whether the cache is still hot.
> 
> Helps how? Faster?  What's missing here is a report of the performance
> impact.

Not faster, the hash is already there. This patch only tries to fix
the thing I mentioned above (not throwing valid entries when cache
full). As far as I tested (all simple ones), it does not have
performance boost since it's not easy to trigger cache full (our cache
size is 1024, not to mention that current intel iommu driver will do
very rapid global flush). I just think it makes sense, and maybe it
can help in the future when there are no that frequent iotlb flushes.

If we still require performance numbers to merge this patch, I think
we can put this patch aside, until one day we might think it useful.

Thanks,

-- 
Peter Xu
