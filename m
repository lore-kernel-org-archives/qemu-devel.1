Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 110A1C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 02:44:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE63C20787
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 02:44:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE63C20787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvtsO-0007S5-3s
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 22:44:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37144)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <teawaterz@linux.alibaba.com>)
 id 1jvtrK-0005mj-7r
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 22:42:54 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:1107)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <teawaterz@linux.alibaba.com>)
 id 1jvtrI-00046d-1I
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 22:42:53 -0400
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R831e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04407; MF=teawaterz@linux.alibaba.com;
 NM=1; PH=DS; RN=11; SR=0; TI=SMTPD_---0U2rTvA2_1594867348; 
Received: from localhost(mailfrom:teawaterz@linux.alibaba.com
 fp:SMTPD_---0U2rTvA2_1594867348) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 16 Jul 2020 10:42:32 +0800
From: Hui Zhu <teawater@gmail.com>
To: mst@redhat.com, david@redhat.com, jasowang@redhat.com,
 akpm@linux-foundation.org, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, qemu-devel@nongnu.org,
 virtio-dev@lists.oasis-open.org
Subject: [RFC for Linux v4 2/2] virtio_balloon: Add deflate_cont_vq to deflate
 continuous pages
Date: Thu, 16 Jul 2020 10:41:52 +0800
Message-Id: <1594867315-8626-3-git-send-email-teawater@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594867315-8626-1-git-send-email-teawater@gmail.com>
References: <1594867315-8626-1-git-send-email-teawater@gmail.com>
Received-SPF: pass client-ip=47.88.44.36;
 envelope-from=teawaterz@linux.alibaba.com; helo=out4436.biz.mail.alibaba.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/15 22:42:26
X-ACL-Warn: Detected OS   = Linux 3.1-3.10
X-Spam_score_int: -71
X-Spam_score: -7.2
X-Spam_bar: -------
X-Spam_report: (-7.2 / 5.0 requ) BAYES_00=-1.9, DKIM_ADSP_CUSTOM_MED=0.001,
 FORGED_GMAIL_RCVD=1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, NML_ADSP_CUSTOM_MED=0.9,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Hui Zhu <teawaterz@linux.alibaba.com>, Hui Zhu <teawater@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This commit adds a vq deflate_cont_vq to deflate continuous pages.
When VIRTIO_BALLOON_F_CONT_PAGES is set, call leak_balloon_cont to leak
the balloon.
leak_balloon_cont will call balloon_page_list_dequeue_cont get continuous
pages from balloon and report them use deflate_cont_vq.

Signed-off-by: Hui Zhu <teawaterz@linux.alibaba.com>
---
 drivers/virtio/virtio_balloon.c    | 73 ++++++++++++++++++++++++++++++++----
 include/linux/balloon_compaction.h |  3 ++
 mm/balloon_compaction.c            | 76 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 144 insertions(+), 8 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index b89f566..258b3d9 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -44,6 +44,7 @@
 
 #define VIRTIO_BALLOON_INFLATE_MAX_ORDER min((int) (sizeof(__virtio32) * BITS_PER_BYTE - \
 						    1 - PAGE_SHIFT), (MAX_ORDER-1))
+#define VIRTIO_BALLOON_DEFLATE_MAX_PAGES_NUM (((__virtio32)~0U) >> PAGE_SHIFT)
 
 #ifdef CONFIG_BALLOON_COMPACTION
 static struct vfsmount *balloon_mnt;
@@ -56,6 +57,7 @@ enum virtio_balloon_vq {
 	VIRTIO_BALLOON_VQ_FREE_PAGE,
 	VIRTIO_BALLOON_VQ_REPORTING,
 	VIRTIO_BALLOON_VQ_INFLATE_CONT,
+	VIRTIO_BALLOON_VQ_DEFLATE_CONT,
 	VIRTIO_BALLOON_VQ_MAX
 };
 
@@ -65,7 +67,8 @@ enum virtio_balloon_config_read {
 
 struct virtio_balloon {
 	struct virtio_device *vdev;
-	struct virtqueue *inflate_vq, *deflate_vq, *stats_vq, *free_page_vq, *inflate_cont_vq;
+	struct virtqueue *inflate_vq, *deflate_vq, *stats_vq, *free_page_vq,
+			 *inflate_cont_vq, *deflate_cont_vq;
 
 	/* Balloon's own wq for cpu-intensive work items */
 	struct workqueue_struct *balloon_wq;
@@ -215,6 +218,16 @@ static void set_page_pfns(struct virtio_balloon *vb,
 					  page_to_balloon_pfn(page) + i);
 }
 
+static void set_page_pfns_size(struct virtio_balloon *vb,
+			       __virtio32 pfns[], struct page *page,
+			       size_t size)
+{
+	/* Set the first pfn of the continuous pages.  */
+	pfns[0] = cpu_to_virtio32(vb->vdev, page_to_balloon_pfn(page));
+	/* Set the size of the continuous pages.  */
+	pfns[1] = (__virtio32) size;
+}
+
 static void set_page_pfns_order(struct virtio_balloon *vb,
 				__virtio32 pfns[], struct page *page,
 				unsigned int order)
@@ -222,10 +235,7 @@ static void set_page_pfns_order(struct virtio_balloon *vb,
 	if (order == 0)
 		return set_page_pfns(vb, pfns, page);
 
-	/* Set the first pfn of the continuous pages.  */
-	pfns[0] = cpu_to_virtio32(vb->vdev, page_to_balloon_pfn(page));
-	/* Set the size of the continuous pages.  */
-	pfns[1] = PAGE_SIZE << order;
+	set_page_pfns_size(vb, pfns, page, PAGE_SIZE << order);
 }
 
 static unsigned fill_balloon(struct virtio_balloon *vb, size_t num)
@@ -367,6 +377,42 @@ static unsigned leak_balloon(struct virtio_balloon *vb, size_t num)
 	return num_freed_pages;
 }
 
+static unsigned int leak_balloon_cont(struct virtio_balloon *vb, size_t num)
+{
+	unsigned int num_freed_pages;
+	struct balloon_dev_info *vb_dev_info = &vb->vb_dev_info;
+	LIST_HEAD(pages);
+	size_t num_pages;
+
+	mutex_lock(&vb->balloon_lock);
+	for (vb->num_pfns = 0, num_freed_pages = 0;
+	     vb->num_pfns < ARRAY_SIZE(vb->pfns) && num_freed_pages < num;
+	     vb->num_pfns += 2,
+	     num_freed_pages += num_pages << (PAGE_SHIFT - VIRTIO_BALLOON_PFN_SHIFT)) {
+		struct page *page;
+
+		num_pages = balloon_page_list_dequeue_cont(vb_dev_info, &pages, &page,
+						min_t(size_t,
+						      VIRTIO_BALLOON_DEFLATE_MAX_PAGES_NUM,
+						      num - num_freed_pages));
+		if (!num_pages)
+			break;
+		set_page_pfns_size(vb, vb->pfns + vb->num_pfns, page, num_pages << PAGE_SHIFT);
+	}
+	vb->num_pages -= num_freed_pages;
+
+	/*
+	 * Note that if
+	 * virtio_has_feature(vdev, VIRTIO_BALLOON_F_MUST_TELL_HOST);
+	 * is true, we *have* to do it in this order
+	 */
+	if (vb->num_pfns != 0)
+		tell_host(vb, vb->deflate_cont_vq);
+	release_pages_balloon(vb, &pages);
+	mutex_unlock(&vb->balloon_lock);
+	return num_freed_pages;
+}
+
 static inline void update_stat(struct virtio_balloon *vb, int idx,
 			       u16 tag, u64 val)
 {
@@ -551,8 +597,12 @@ static void update_balloon_size_func(struct work_struct *work)
 
 	if (diff > 0)
 		diff -= fill_balloon(vb, diff);
-	else
-		diff += leak_balloon(vb, -diff);
+	else {
+		if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_CONT_PAGES))
+			diff += leak_balloon_cont(vb, -diff);
+		else
+			diff += leak_balloon(vb, -diff);
+	}
 	update_balloon_size(vb);
 
 	if (diff)
@@ -587,6 +637,8 @@ static int init_vqs(struct virtio_balloon *vb)
 	names[VIRTIO_BALLOON_VQ_REPORTING] = NULL;
 	names[VIRTIO_BALLOON_VQ_INFLATE_CONT] = NULL;
 	callbacks[VIRTIO_BALLOON_VQ_INFLATE_CONT] = NULL;
+	names[VIRTIO_BALLOON_VQ_DEFLATE_CONT] = NULL;
+	callbacks[VIRTIO_BALLOON_VQ_DEFLATE_CONT] = NULL;
 
 	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_STATS_VQ)) {
 		names[VIRTIO_BALLOON_VQ_STATS] = "stats";
@@ -606,6 +658,8 @@ static int init_vqs(struct virtio_balloon *vb)
 	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_CONT_PAGES)) {
 		names[VIRTIO_BALLOON_VQ_INFLATE_CONT] = "inflate_cont";
 		callbacks[VIRTIO_BALLOON_VQ_INFLATE_CONT] = balloon_ack;
+		names[VIRTIO_BALLOON_VQ_DEFLATE_CONT] = "deflate_cont";
+		callbacks[VIRTIO_BALLOON_VQ_DEFLATE_CONT] = balloon_ack;
 	}
 
 	err = vb->vdev->config->find_vqs(vb->vdev, VIRTIO_BALLOON_VQ_MAX,
@@ -643,9 +697,12 @@ static int init_vqs(struct virtio_balloon *vb)
 	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTING))
 		vb->reporting_vq = vqs[VIRTIO_BALLOON_VQ_REPORTING];
 
-	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_CONT_PAGES))
+	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_CONT_PAGES)) {
 		vb->inflate_cont_vq
 			= vqs[VIRTIO_BALLOON_VQ_INFLATE_CONT];
+		vb->deflate_cont_vq
+			= vqs[VIRTIO_BALLOON_VQ_DEFLATE_CONT];
+	}
 
 	return 0;
 }
diff --git a/include/linux/balloon_compaction.h b/include/linux/balloon_compaction.h
index 8180bbf..7cb2a75 100644
--- a/include/linux/balloon_compaction.h
+++ b/include/linux/balloon_compaction.h
@@ -70,6 +70,9 @@ extern size_t balloon_page_list_enqueue(struct balloon_dev_info *b_dev_info,
 				      struct list_head *pages);
 extern size_t balloon_page_list_dequeue(struct balloon_dev_info *b_dev_info,
 				     struct list_head *pages, size_t n_req_pages);
+extern size_t balloon_page_list_dequeue_cont(struct balloon_dev_info *b_dev_info,
+					     struct list_head *pages, struct page **first_page,
+					     size_t max_req_pages);
 
 static inline struct page *balloon_page_alloc(void)
 {
diff --git a/mm/balloon_compaction.c b/mm/balloon_compaction.c
index 397d0b9..ea7d91f 100644
--- a/mm/balloon_compaction.c
+++ b/mm/balloon_compaction.c
@@ -111,6 +111,82 @@ size_t balloon_page_list_dequeue(struct balloon_dev_info *b_dev_info,
 }
 EXPORT_SYMBOL_GPL(balloon_page_list_dequeue);
 
+/**
+ * balloon_page_list_dequeue_cont() - removes continuous pages from balloon's page list
+ *				      and returns a list of the continuous pages.
+ * @b_dev_info: balloon device decriptor where we will grab a page from.
+ * @pages: pointer to the list of pages that would be returned to the caller.
+ * @max_req_pages: max number of requested pages.
+ *
+ * Driver must call this function to properly de-allocate a previous enlisted
+ * balloon pages before definitively releasing it back to the guest system.
+ * This function tries to remove @max_req_pages continuous pages from the ballooned
+ * pages and return them to the caller in the @pages list.
+ *
+ * Note that this function may fail to dequeue some pages even if the balloon
+ * isn't empty - since the page list can be temporarily empty due to compaction
+ * of isolated pages.
+ *
+ * Return: number of pages that were added to the @pages list.
+ */
+size_t balloon_page_list_dequeue_cont(struct balloon_dev_info *b_dev_info,
+				      struct list_head *pages, struct page **first_page,
+				      size_t max_req_pages)
+{
+	struct page *page, *tmp;
+	unsigned long flags, tail_pfn;
+	size_t n_pages = 0;
+	bool got_first = false;
+
+	spin_lock_irqsave(&b_dev_info->pages_lock, flags);
+	list_for_each_entry_safe_reverse(page, tmp, &b_dev_info->pages, lru) {
+		unsigned long pfn;
+
+		if (n_pages == max_req_pages)
+			break;
+
+		pfn = page_to_pfn(page);
+
+		if (got_first && pfn != tail_pfn + 1)
+			break;
+
+		/*
+		 * Block others from accessing the 'page' while we get around to
+		 * establishing additional references and preparing the 'page'
+		 * to be released by the balloon driver.
+		 */
+		if (!trylock_page(page)) {
+			if (!got_first)
+				continue;
+			else
+				break;
+		}
+
+		if (IS_ENABLED(CONFIG_BALLOON_COMPACTION) && PageIsolated(page)) {
+			/* raced with isolation */
+			unlock_page(page);
+			if (!got_first)
+				continue;
+			else
+				break;
+		}
+		balloon_page_delete(page);
+		__count_vm_event(BALLOON_DEFLATE);
+		list_add(&page->lru, pages);
+		unlock_page(page);
+		n_pages++;
+		tail_pfn = pfn;
+		if (!got_first) {
+			got_first = true;
+			*first_page = page;
+		}
+	}
+	spin_unlock_irqrestore(&b_dev_info->pages_lock, flags);
+
+	return n_pages;
+}
+EXPORT_SYMBOL_GPL(balloon_page_list_dequeue_cont);
+
 /*
  * balloon_pages_alloc - allocates a new page for insertion into the balloon
  *			 page list.
-- 
2.7.4


