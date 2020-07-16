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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE920C433E4
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 02:43:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 964D620663
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 02:43:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 964D620663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvtsL-0007NS-R9
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 22:43:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37132)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <teawaterz@linux.alibaba.com>)
 id 1jvtrH-0005hh-EW
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 22:42:51 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:52214)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <teawaterz@linux.alibaba.com>)
 id 1jvtrF-00043r-9i
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 22:42:51 -0400
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R131e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04407; MF=teawaterz@linux.alibaba.com;
 NM=1; PH=DS; RN=11; SR=0; TI=SMTPD_---0U2rEMvL_1594867329; 
Received: from localhost(mailfrom:teawaterz@linux.alibaba.com
 fp:SMTPD_---0U2rEMvL_1594867329) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 16 Jul 2020 10:42:28 +0800
From: Hui Zhu <teawater@gmail.com>
To: mst@redhat.com, david@redhat.com, jasowang@redhat.com,
 akpm@linux-foundation.org, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, qemu-devel@nongnu.org,
 virtio-dev@lists.oasis-open.org
Subject: [RFC for Linux v4 1/2] virtio_balloon: Add
 VIRTIO_BALLOON_F_CONT_PAGES and inflate_cont_vq
Date: Thu, 16 Jul 2020 10:41:51 +0800
Message-Id: <1594867315-8626-2-git-send-email-teawater@gmail.com>
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

This commit adds a new flag VIRTIO_BALLOON_F_CONT_PAGES to virtio_balloon.
Add it adds a vq inflate_cont_vq to inflate continuous pages.
When VIRTIO_BALLOON_F_CONT_PAGES is set, try to allocate continuous pages
and report them use inflate_cont_vq.

Signed-off-by: Hui Zhu <teawaterz@linux.alibaba.com>
---
 drivers/virtio/virtio_balloon.c     | 119 ++++++++++++++++++++++++++++++------
 include/linux/balloon_compaction.h  |   9 ++-
 include/uapi/linux/virtio_balloon.h |   1 +
 mm/balloon_compaction.c             |  41 ++++++++++---
 4 files changed, 142 insertions(+), 28 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 1f157d2..b89f566 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -42,6 +42,9 @@
 	(1 << (VIRTIO_BALLOON_HINT_BLOCK_ORDER + PAGE_SHIFT))
 #define VIRTIO_BALLOON_HINT_BLOCK_PAGES (1 << VIRTIO_BALLOON_HINT_BLOCK_ORDER)
 
+#define VIRTIO_BALLOON_INFLATE_MAX_ORDER min((int) (sizeof(__virtio32) * BITS_PER_BYTE - \
+						    1 - PAGE_SHIFT), (MAX_ORDER-1))
+
 #ifdef CONFIG_BALLOON_COMPACTION
 static struct vfsmount *balloon_mnt;
 #endif
@@ -52,6 +55,7 @@ enum virtio_balloon_vq {
 	VIRTIO_BALLOON_VQ_STATS,
 	VIRTIO_BALLOON_VQ_FREE_PAGE,
 	VIRTIO_BALLOON_VQ_REPORTING,
+	VIRTIO_BALLOON_VQ_INFLATE_CONT,
 	VIRTIO_BALLOON_VQ_MAX
 };
 
@@ -61,7 +65,7 @@ enum virtio_balloon_config_read {
 
 struct virtio_balloon {
 	struct virtio_device *vdev;
-	struct virtqueue *inflate_vq, *deflate_vq, *stats_vq, *free_page_vq;
+	struct virtqueue *inflate_vq, *deflate_vq, *stats_vq, *free_page_vq, *inflate_cont_vq;
 
 	/* Balloon's own wq for cpu-intensive work items */
 	struct workqueue_struct *balloon_wq;
@@ -126,6 +130,9 @@ struct virtio_balloon {
 	/* Free page reporting device */
 	struct virtqueue *reporting_vq;
 	struct page_reporting_dev_info pr_dev_info;
+
+	/* Current order of inflate continuous pages - VIRTIO_BALLOON_F_CONT_PAGES */
+	__u32 current_pages_order;
 };
 
 static struct virtio_device_id id_table[] = {
@@ -208,19 +215,59 @@ static void set_page_pfns(struct virtio_balloon *vb,
 					  page_to_balloon_pfn(page) + i);
 }
 
+static void set_page_pfns_order(struct virtio_balloon *vb,
+				__virtio32 pfns[], struct page *page,
+				unsigned int order)
+{
+	if (order == 0)
+		return set_page_pfns(vb, pfns, page);
+
+	/* Set the first pfn of the continuous pages.  */
+	pfns[0] = cpu_to_virtio32(vb->vdev, page_to_balloon_pfn(page));
+	/* Set the size of the continuous pages.  */
+	pfns[1] = PAGE_SIZE << order;
+}
+
 static unsigned fill_balloon(struct virtio_balloon *vb, size_t num)
 {
 	unsigned num_allocated_pages;
-	unsigned num_pfns;
+	unsigned int num_pfns, pfn_per_alloc;
 	struct page *page;
 	LIST_HEAD(pages);
+	bool is_cont = vb->current_pages_order != 0;
 
-	/* We can only do one array worth at a time. */
-	num = min(num, ARRAY_SIZE(vb->pfns));
-
-	for (num_pfns = 0; num_pfns < num;
-	     num_pfns += VIRTIO_BALLOON_PAGES_PER_PAGE) {
-		struct page *page = balloon_page_alloc();
+	if (is_cont)
+		pfn_per_alloc = 2;
+	else
+		pfn_per_alloc = VIRTIO_BALLOON_PAGES_PER_PAGE;
+
+	for (num_pfns = 0, num_allocated_pages = 0;
+	     num_pfns < ARRAY_SIZE(vb->pfns) && num_allocated_pages < num;
+	     num_pfns += pfn_per_alloc,
+	     num_allocated_pages += VIRTIO_BALLOON_PAGES_PER_PAGE << vb->current_pages_order) {
+		struct page *page;
+
+		for (; vb->current_pages_order >= 0; vb->current_pages_order--) {
+			if (vb->current_pages_order &&
+			    num - num_allocated_pages <
+				VIRTIO_BALLOON_PAGES_PER_PAGE << vb->current_pages_order)
+				continue;
+			page = balloon_pages_alloc(vb->current_pages_order);
+			if (page) {
+				/* If the first allocated page is not continuous pages,
+				 * go back to transport page as signle page.
+				 */
+				if (is_cont && num_pfns == 0 && !vb->current_pages_order) {
+					is_cont = false;
+					pfn_per_alloc = VIRTIO_BALLOON_PAGES_PER_PAGE;
+				}
+				set_page_private(page, vb->current_pages_order);
+				balloon_page_push(&pages, page);
+				break;
+			}
+			if (!vb->current_pages_order)
+				break;
+		}
 
 		if (!page) {
 			dev_info_ratelimited(&vb->vdev->dev,
@@ -230,8 +277,6 @@ static unsigned fill_balloon(struct virtio_balloon *vb, size_t num)
 			msleep(200);
 			break;
 		}
-
-		balloon_page_push(&pages, page);
 	}
 
 	mutex_lock(&vb->balloon_lock);
@@ -239,20 +284,34 @@ static unsigned fill_balloon(struct virtio_balloon *vb, size_t num)
 	vb->num_pfns = 0;
 
 	while ((page = balloon_page_pop(&pages))) {
-		balloon_page_enqueue(&vb->vb_dev_info, page);
+		unsigned int order = page_private(page);
+
+		set_page_private(page, 0);
+
+		/* Split the continuous pages because they will be freed
+		 * by release_pages_balloon respectively.
+		 */
+		if (order)
+			split_page(page, order);
+
+		balloon_pages_enqueue(&vb->vb_dev_info, page, order);
+
+		set_page_pfns_order(vb, vb->pfns + vb->num_pfns, page, order);
 
-		set_page_pfns(vb, vb->pfns + vb->num_pfns, page);
-		vb->num_pages += VIRTIO_BALLOON_PAGES_PER_PAGE;
 		if (!virtio_has_feature(vb->vdev,
 					VIRTIO_BALLOON_F_DEFLATE_ON_OOM))
-			adjust_managed_page_count(page, -1);
-		vb->num_pfns += VIRTIO_BALLOON_PAGES_PER_PAGE;
+			adjust_managed_page_count(page, -(1 << order));
+		vb->num_pfns += pfn_per_alloc;
 	}
+	vb->num_pages += num_allocated_pages;
 
-	num_allocated_pages = vb->num_pfns;
 	/* Did we get any? */
-	if (vb->num_pfns != 0)
-		tell_host(vb, vb->inflate_vq);
+	if (vb->num_pfns != 0) {
+		if (is_cont)
+			tell_host(vb, vb->inflate_cont_vq);
+		else
+			tell_host(vb, vb->inflate_vq);
+	}
 	mutex_unlock(&vb->balloon_lock);
 
 	return num_allocated_pages;
@@ -488,7 +547,7 @@ static void update_balloon_size_func(struct work_struct *work)
 	diff = towards_target(vb);
 
 	if (!diff)
-		return;
+		goto stop_out;
 
 	if (diff > 0)
 		diff -= fill_balloon(vb, diff);
@@ -498,6 +557,11 @@ static void update_balloon_size_func(struct work_struct *work)
 
 	if (diff)
 		queue_work(system_freezable_wq, work);
+	else {
+stop_out:
+		if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_CONT_PAGES))
+			vb->current_pages_order = VIRTIO_BALLOON_INFLATE_MAX_ORDER;
+	}
 }
 
 static int init_vqs(struct virtio_balloon *vb)
@@ -521,6 +585,8 @@ static int init_vqs(struct virtio_balloon *vb)
 	callbacks[VIRTIO_BALLOON_VQ_FREE_PAGE] = NULL;
 	names[VIRTIO_BALLOON_VQ_FREE_PAGE] = NULL;
 	names[VIRTIO_BALLOON_VQ_REPORTING] = NULL;
+	names[VIRTIO_BALLOON_VQ_INFLATE_CONT] = NULL;
+	callbacks[VIRTIO_BALLOON_VQ_INFLATE_CONT] = NULL;
 
 	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_STATS_VQ)) {
 		names[VIRTIO_BALLOON_VQ_STATS] = "stats";
@@ -537,6 +603,11 @@ static int init_vqs(struct virtio_balloon *vb)
 		callbacks[VIRTIO_BALLOON_VQ_REPORTING] = balloon_ack;
 	}
 
+	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_CONT_PAGES)) {
+		names[VIRTIO_BALLOON_VQ_INFLATE_CONT] = "inflate_cont";
+		callbacks[VIRTIO_BALLOON_VQ_INFLATE_CONT] = balloon_ack;
+	}
+
 	err = vb->vdev->config->find_vqs(vb->vdev, VIRTIO_BALLOON_VQ_MAX,
 					 vqs, callbacks, names, NULL, NULL);
 	if (err)
@@ -572,6 +643,10 @@ static int init_vqs(struct virtio_balloon *vb)
 	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTING))
 		vb->reporting_vq = vqs[VIRTIO_BALLOON_VQ_REPORTING];
 
+	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_CONT_PAGES))
+		vb->inflate_cont_vq
+			= vqs[VIRTIO_BALLOON_VQ_INFLATE_CONT];
+
 	return 0;
 }
 
@@ -997,6 +1072,11 @@ static int virtballoon_probe(struct virtio_device *vdev)
 			goto out_unregister_oom;
 	}
 
+	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_CONT_PAGES))
+		vb->current_pages_order = VIRTIO_BALLOON_INFLATE_MAX_ORDER;
+	else
+		vb->current_pages_order = 0;
+
 	virtio_device_ready(vdev);
 
 	if (towards_target(vb))
@@ -1131,6 +1211,7 @@ static unsigned int features[] = {
 	VIRTIO_BALLOON_F_FREE_PAGE_HINT,
 	VIRTIO_BALLOON_F_PAGE_POISON,
 	VIRTIO_BALLOON_F_REPORTING,
+	VIRTIO_BALLOON_F_CONT_PAGES,
 };
 
 static struct virtio_driver virtio_balloon_driver = {
diff --git a/include/linux/balloon_compaction.h b/include/linux/balloon_compaction.h
index 338aa27..8180bbf 100644
--- a/include/linux/balloon_compaction.h
+++ b/include/linux/balloon_compaction.h
@@ -60,15 +60,22 @@ struct balloon_dev_info {
 	struct inode *inode;
 };
 
-extern struct page *balloon_page_alloc(void);
+extern struct page *balloon_pages_alloc(unsigned int order);
 extern void balloon_page_enqueue(struct balloon_dev_info *b_dev_info,
 				 struct page *page);
+extern void balloon_pages_enqueue(struct balloon_dev_info *b_dev_info,
+				  struct page *page, unsigned int order);
 extern struct page *balloon_page_dequeue(struct balloon_dev_info *b_dev_info);
 extern size_t balloon_page_list_enqueue(struct balloon_dev_info *b_dev_info,
 				      struct list_head *pages);
 extern size_t balloon_page_list_dequeue(struct balloon_dev_info *b_dev_info,
 				     struct list_head *pages, size_t n_req_pages);
 
+static inline struct page *balloon_page_alloc(void)
+{
+	return balloon_pages_alloc(0);
+}
+
 static inline void balloon_devinfo_init(struct balloon_dev_info *balloon)
 {
 	balloon->isolated_pages = 0;
diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/virtio_balloon.h
index dc3e656..4d0151a 100644
--- a/include/uapi/linux/virtio_balloon.h
+++ b/include/uapi/linux/virtio_balloon.h
@@ -37,6 +37,7 @@
 #define VIRTIO_BALLOON_F_FREE_PAGE_HINT	3 /* VQ to report free pages */
 #define VIRTIO_BALLOON_F_PAGE_POISON	4 /* Guest is using page poisoning */
 #define VIRTIO_BALLOON_F_REPORTING	5 /* Page reporting virtqueue */
+#define VIRTIO_BALLOON_F_CONT_PAGES	6 /* VQ to report continuous pages */
 
 /* Size of a PFN in the balloon interface. */
 #define VIRTIO_BALLOON_PFN_SHIFT 12
diff --git a/mm/balloon_compaction.c b/mm/balloon_compaction.c
index 26de020..397d0b9 100644
--- a/mm/balloon_compaction.c
+++ b/mm/balloon_compaction.c
@@ -112,8 +112,8 @@ size_t balloon_page_list_dequeue(struct balloon_dev_info *b_dev_info,
 EXPORT_SYMBOL_GPL(balloon_page_list_dequeue);
 
 /*
- * balloon_page_alloc - allocates a new page for insertion into the balloon
- *			page list.
+ * balloon_pages_alloc - allocates a new page for insertion into the balloon
+ *			 page list.
  *
  * Driver must call this function to properly allocate a new balloon page.
  * Driver must call balloon_page_enqueue before definitively removing the page
@@ -121,14 +121,19 @@ EXPORT_SYMBOL_GPL(balloon_page_list_dequeue);
  *
  * Return: struct page for the allocated page or NULL on allocation failure.
  */
-struct page *balloon_page_alloc(void)
+struct page *balloon_pages_alloc(unsigned int order)
 {
-	struct page *page = alloc_page(balloon_mapping_gfp_mask() |
-				       __GFP_NOMEMALLOC | __GFP_NORETRY |
-				       __GFP_NOWARN);
-	return page;
+	gfp_t gfp_mask;
+
+	if (order > 1)
+		gfp_mask = __GFP_RETRY_MAYFAIL;
+	else
+		gfp_mask = __GFP_NORETRY;
+
+	return alloc_pages(balloon_mapping_gfp_mask() |
+			   gfp_mask | __GFP_NOMEMALLOC | __GFP_NOWARN, order);
 }
-EXPORT_SYMBOL_GPL(balloon_page_alloc);
+EXPORT_SYMBOL_GPL(balloon_pages_alloc);
 
 /*
  * balloon_page_enqueue - inserts a new page into the balloon page list.
@@ -155,6 +160,26 @@ void balloon_page_enqueue(struct balloon_dev_info *b_dev_info,
 EXPORT_SYMBOL_GPL(balloon_page_enqueue);
 
 /*
+ * balloon_pages_enqueue - inserts continuous pages into the balloon page list.
+ */
+void balloon_pages_enqueue(struct balloon_dev_info *b_dev_info,
+			   struct page *page, unsigned int order)
+{
+	unsigned long flags, pfn, last_pfn;
+
+	pfn = page_to_pfn(page);
+	last_pfn = pfn + (1 << order) - 1;
+
+	spin_lock_irqsave(&b_dev_info->pages_lock, flags);
+	for (; pfn <= last_pfn; pfn++) {
+		page = pfn_to_page(pfn);
+		balloon_page_enqueue_one(b_dev_info, page);
+	}
+	spin_unlock_irqrestore(&b_dev_info->pages_lock, flags);
+}
+EXPORT_SYMBOL_GPL(balloon_pages_enqueue);
+
+/*
  * balloon_page_dequeue - removes a page from balloon's page list and returns
  *			  its address to allow the driver to release the page.
  * @b_dev_info: balloon device decriptor where we will grab a page from.
-- 
2.7.4


