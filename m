Received: from eggs.gnu.org ([2001:4830:134:3::10]:59602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <penguin-kernel@I-love.SAKURA.ne.jp>)
	id 1eQalp-0001g1-Ne
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 10:22:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <penguin-kernel@I-love.SAKURA.ne.jp>)
	id 1eQalm-00026g-H2
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 10:22:29 -0500
Received: from www262.sakura.ne.jp ([2001:e42:101:1:202:181:97:72]:28046)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <penguin-kernel@I-love.SAKURA.ne.jp>)
	id 1eQall-00022n-2O
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 10:22:26 -0500
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
References: <5A34F193.5040700@intel.com>
	<201712162028.FEB87079.FOJFMQHVOSLtFO@I-love.SAKURA.ne.jp>
	<5A35FF89.8040500@intel.com>
	<201712171921.IBB30790.VOOOFMQHFSLFJt@I-love.SAKURA.ne.jp>
	<286AC319A985734F985F78AFA26841F739387B68@shsmsx102.ccr.corp.intel.com>
In-Reply-To: <286AC319A985734F985F78AFA26841F739387B68@shsmsx102.ccr.corp.intel.com>
Message-Id: <201712180016.GHD34301.MQOLOFFJHOVFtS@I-love.SAKURA.ne.jp>
Date: Mon, 18 Dec 2017 00:16:33 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: Re: [Qemu-devel] [PATCH v19 3/7] xbitmap: add more operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: wei.w.wang@intel.com, willy@infradead.org
Cc: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org, akpm@linux-foundation.org, mawilcox@microsoft.com, david@redhat.com, cornelia.huck@de.ibm.com, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu@aliyun.com, nilal@redhat.com, riel@redhat.com

Wang, Wei W wrote:
> > Wei Wang wrote:
> > > > But passing GFP_NOWAIT means that we can handle allocation failure.
> > > > There is no need to use preload approach when we can handle allocation failure.
> > >
> > > I think the reason we need xb_preload is because radix tree insertion
> > > needs the memory being preallocated already (it couldn't suffer from
> > > memory failure during the process of inserting, probably because
> > > handling the failure there isn't easy, Matthew may know the backstory
> > > of
> > > this)
> > 
> > According to https://lwn.net/Articles/175432/ , I think that preloading is
> > needed only when failure to insert an item into a radix tree is a significant
> > problem.
> > That is, when failure to insert an item into a radix tree is not a problem, I
> > think that we don't need to use preloading.
> 
> It also mentions that the preload attempts to allocate sufficient memory to *guarantee* that the next radix tree insertion cannot fail.
> 
> If we check radix_tree_node_alloc(), the comments there says "this assumes that the caller has performed appropriate preallocation".

If you read what radix_tree_node_alloc() is doing, you will find that
radix_tree_node_alloc() returns NULL when memory allocation failed.

I think that "this assumes that the caller has performed appropriate preallocation"
means "The caller has to perform appropriate preallocation if the caller does not
want radix_tree_node_alloc() to return NULL".

> 
> So, I think we would get a risk of triggering some issue without preload().
> 
> > >
> > > So, I think we can handle the memory failure with xb_preload, which
> > > stops going into the radix tree APIs, but shouldn't call radix tree
> > > APIs without the related memory preallocated.
> > 
> > It seems to me that virtio-ballon case has no problem without using
> > preloading.
> 
> Why is that?
> 

Because you are saying in PATCH 4/7 that it is OK to fail xb_set_page()
due to -ENOMEM (apart from lack of ability to fallback to !use_sg path
when all xb_set_page() calls failed (i.e. no page will be handled because
there is no "1" bit in the xbitmap)).


+static inline int xb_set_page(struct virtio_balloon *vb,
+			       struct page *page,
+			       unsigned long *pfn_min,
+			       unsigned long *pfn_max)
+{
+	unsigned long pfn = page_to_pfn(page);
+	int ret;
+
+	*pfn_min = min(pfn, *pfn_min);
+	*pfn_max = max(pfn, *pfn_max);
+
+	do {
+		ret = xb_preload_and_set_bit(&vb->page_xb, pfn,
+					     GFP_NOWAIT | __GFP_NOWARN);
+	} while (unlikely(ret == -EAGAIN));
+
+	return ret;
+}

@@ -173,8 +290,15 @@ static unsigned fill_balloon(struct virtio_balloon *vb, size_t num)
 
 	while ((page = balloon_page_pop(&pages))) {
 		balloon_page_enqueue(&vb->vb_dev_info, page);
+		if (use_sg) {
+			if (xb_set_page(vb, page, &pfn_min, &pfn_max) < 0) {
+				__free_page(page);
+				continue;
+			}
+		} else {
+			set_page_pfns(vb, vb->pfns + vb->num_pfns, page);
+		}
 

@@ -223,7 +354,14 @@ static unsigned leak_balloon(struct virtio_balloon *vb, size_t num)
 		page = balloon_page_dequeue(vb_dev_info);
 		if (!page)
 			break;
-		set_page_pfns(vb, vb->pfns + vb->num_pfns, page);
+		if (use_sg) {
+			if (xb_set_page(vb, page, &pfn_min, &pfn_max) < 0) {
+				balloon_page_enqueue(&vb->vb_dev_info, page);
+				break;
+			}
+		} else {
+			set_page_pfns(vb, vb->pfns + vb->num_pfns, page);
+		}
 		list_add(&page->lru, &pages);
 		vb->num_pages -= VIRTIO_BALLOON_PAGES_PER_PAGE;
 	}
