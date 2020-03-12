Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E91C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 07:51:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39C9B206B7
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 07:51:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39C9B206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCIcl-00034M-CU
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 03:51:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40403)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <teawaterz@linux.alibaba.com>) id 1jCIc4-0002Hw-C2
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 03:50:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <teawaterz@linux.alibaba.com>) id 1jCIbw-0003ah-Ff
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 03:50:33 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:64027)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <teawaterz@linux.alibaba.com>)
 id 1jCIbw-0003YO-3u
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 03:50:32 -0400
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R391e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01f04396; MF=teawaterz@linux.alibaba.com;
 NM=1; PH=DS; RN=12; SR=0; TI=SMTPD_---0TsNBE3D_1583999397; 
Received: from localhost(mailfrom:teawaterz@linux.alibaba.com
 fp:SMTPD_---0TsNBE3D_1583999397) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 12 Mar 2020 15:50:03 +0800
From: Hui Zhu <teawater@gmail.com>
To: mst@redhat.com, jasowang@redhat.com, akpm@linux-foundation.org,
 pagupta@redhat.com, mojha@codeaurora.org, david@redhat.com,
 namit@vmware.com, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, qemu-devel@nongnu.org
Subject: [RFC for Linux] virtio_balloon: Add VIRTIO_BALLOON_F_THP_ORDER to
 handle THP spilt issue
Date: Thu, 12 Mar 2020 15:49:54 +0800
Message-Id: <1583999395-9131-1-git-send-email-teawater@gmail.com>
X-Mailer: git-send-email 2.7.4
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 47.88.44.36
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

If the guest kernel has many fragmentation pages, use virtio_balloon
will split THP of QEMU when it calls MADV_DONTNEED madvise to release
the balloon pages.
This is an example in a VM with 1G memory 1CPU:
cat /proc/meminfo | grep AnonHugePages:
AnonHugePages:         0 kB

usemem --punch-holes -s -1 800m &

cat /proc/meminfo | grep AnonHugePages:
AnonHugePages:    976896 kB

(qemu) device_add virtio-balloon-pci,id=balloon1
(qemu) info balloon
balloon: actual=1024
(qemu) balloon 624
(qemu) info balloon
balloon: actual=624

cat /proc/meminfo | grep AnonHugePages:
AnonHugePages:    153600 kB

THP number decreased more than 800M.
The reason is usemem with punch-holes option will free every other page
after allocation.  Then 400M free memory inside the guest kernel is
fragmentation pages.
The guest kernel will use them to inflate the balloon.  When these
fragmentation pages are freed, THP will be split.

This commit tries to handle this with add a new flag
VIRTIO_BALLOON_F_THP_ORDER.
When this flag is set, the balloon page order will be set to the THP order.
Then THP pages will be freed together in the host.
This is an example in a VM with 1G memory 1CPU:
cat /proc/meminfo | grep AnonHugePages:
AnonHugePages:         0 kB

usemem --punch-holes -s -1 800m &

cat /proc/meminfo | grep AnonHugePages:
AnonHugePages:    976896 kB

(qemu) device_add virtio-balloon-pci,id=balloon1,thp-order=on
(qemu) info balloon
balloon: actual=1024
(qemu) balloon 624
(qemu) info balloon
balloon: actual=624

cat /proc/meminfo | grep AnonHugePages:
AnonHugePages:    583680 kB

The THP number decreases 384M.  This shows that VIRTIO_BALLOON_F_THP_ORDER
can help handle the THP split issue.

Signed-off-by: Hui Zhu <teawaterz@linux.alibaba.com>
---
 drivers/virtio/virtio_balloon.c     | 57 ++++++++++++++++++++++++++-----------
 include/linux/balloon_compaction.h  | 14 ++++++---
 include/uapi/linux/virtio_balloon.h |  4 +++
 3 files changed, 54 insertions(+), 21 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 7bfe365..1e1dc76 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -175,18 +175,31 @@ static unsigned fill_balloon(struct virtio_balloon *vb, size_t num)
 	unsigned num_pfns;
 	struct page *page;
 	LIST_HEAD(pages);
+	int page_order = 0;
 
 	/* We can only do one array worth at a time. */
 	num = min(num, ARRAY_SIZE(vb->pfns));
 
+	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_THP_ORDER))
+		page_order = VIRTIO_BALLOON_THP_ORDER;
+
 	for (num_pfns = 0; num_pfns < num;
 	     num_pfns += VIRTIO_BALLOON_PAGES_PER_PAGE) {
-		struct page *page = balloon_page_alloc();
+		struct page *page;
+
+		if (page_order)
+			page = alloc_pages(__GFP_HIGHMEM |
+					   __GFP_KSWAPD_RECLAIM |
+					   __GFP_RETRY_MAYFAIL |
+					   __GFP_NOWARN | __GFP_NOMEMALLOC,
+					   page_order);
+		else
+			page = balloon_page_alloc();
 
 		if (!page) {
 			dev_info_ratelimited(&vb->vdev->dev,
-					     "Out of puff! Can't get %u pages\n",
-					     VIRTIO_BALLOON_PAGES_PER_PAGE);
+				"Out of puff! Can't get %u pages\n",
+				VIRTIO_BALLOON_PAGES_PER_PAGE << page_order);
 			/* Sleep for at least 1/5 of a second before retry. */
 			msleep(200);
 			break;
@@ -206,7 +219,7 @@ static unsigned fill_balloon(struct virtio_balloon *vb, size_t num)
 		vb->num_pages += VIRTIO_BALLOON_PAGES_PER_PAGE;
 		if (!virtio_has_feature(vb->vdev,
 					VIRTIO_BALLOON_F_DEFLATE_ON_OOM))
-			adjust_managed_page_count(page, -1);
+			adjust_managed_page_count(page, -(1 << page_order));
 		vb->num_pfns += VIRTIO_BALLOON_PAGES_PER_PAGE;
 	}
 
@@ -223,13 +236,20 @@ static void release_pages_balloon(struct virtio_balloon *vb,
 				 struct list_head *pages)
 {
 	struct page *page, *next;
+	int page_order = 0;
+
+	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_THP_ORDER))
+		page_order = VIRTIO_BALLOON_THP_ORDER;
 
 	list_for_each_entry_safe(page, next, pages, lru) {
 		if (!virtio_has_feature(vb->vdev,
 					VIRTIO_BALLOON_F_DEFLATE_ON_OOM))
-			adjust_managed_page_count(page, 1);
+			adjust_managed_page_count(page, 1 << page_order);
 		list_del(&page->lru);
-		put_page(page); /* balloon reference */
+		if (page_order)
+			__free_pages(page, page_order);
+		else
+			put_page(page); /* balloon reference */
 	}
 }
 
@@ -893,19 +913,21 @@ static int virtballoon_probe(struct virtio_device *vdev)
 		goto out_free_vb;
 
 #ifdef CONFIG_BALLOON_COMPACTION
-	balloon_mnt = kern_mount(&balloon_fs);
-	if (IS_ERR(balloon_mnt)) {
-		err = PTR_ERR(balloon_mnt);
-		goto out_del_vqs;
-	}
+	if (!virtio_has_feature(vdev, VIRTIO_BALLOON_F_THP_ORDER)) {
+		balloon_mnt = kern_mount(&balloon_fs);
+		if (IS_ERR(balloon_mnt)) {
+			err = PTR_ERR(balloon_mnt);
+			goto out_del_vqs;
+		}
 
-	vb->vb_dev_info.migratepage = virtballoon_migratepage;
-	vb->vb_dev_info.inode = alloc_anon_inode(balloon_mnt->mnt_sb);
-	if (IS_ERR(vb->vb_dev_info.inode)) {
-		err = PTR_ERR(vb->vb_dev_info.inode);
-		goto out_kern_unmount;
+		vb->vb_dev_info.migratepage = virtballoon_migratepage;
+		vb->vb_dev_info.inode = alloc_anon_inode(balloon_mnt->mnt_sb);
+		if (IS_ERR(vb->vb_dev_info.inode)) {
+			err = PTR_ERR(vb->vb_dev_info.inode);
+			goto out_kern_unmount;
+		}
+		vb->vb_dev_info.inode->i_mapping->a_ops = &balloon_aops;
 	}
-	vb->vb_dev_info.inode->i_mapping->a_ops = &balloon_aops;
 #endif
 	if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
 		/*
@@ -1058,6 +1080,7 @@ static unsigned int features[] = {
 	VIRTIO_BALLOON_F_DEFLATE_ON_OOM,
 	VIRTIO_BALLOON_F_FREE_PAGE_HINT,
 	VIRTIO_BALLOON_F_PAGE_POISON,
+	VIRTIO_BALLOON_F_THP_ORDER,
 };
 
 static struct virtio_driver virtio_balloon_driver = {
diff --git a/include/linux/balloon_compaction.h b/include/linux/balloon_compaction.h
index 338aa27..4c9164e 100644
--- a/include/linux/balloon_compaction.h
+++ b/include/linux/balloon_compaction.h
@@ -100,8 +100,12 @@ static inline void balloon_page_insert(struct balloon_dev_info *balloon,
 				       struct page *page)
 {
 	__SetPageOffline(page);
-	__SetPageMovable(page, balloon->inode->i_mapping);
-	set_page_private(page, (unsigned long)balloon);
+	if (balloon->inode) {
+		__SetPageMovable(page, balloon->inode->i_mapping);
+		set_page_private(page, (unsigned long)balloon);
+	} else {
+		set_page_private(page, 0);
+	}
 	list_add(&page->lru, &balloon->pages);
 }
 
@@ -116,8 +120,10 @@ static inline void balloon_page_insert(struct balloon_dev_info *balloon,
 static inline void balloon_page_delete(struct page *page)
 {
 	__ClearPageOffline(page);
-	__ClearPageMovable(page);
-	set_page_private(page, 0);
+	if (page_private(page)) {
+		__ClearPageMovable(page);
+		set_page_private(page, 0);
+	}
 	/*
 	 * No touch page.lru field once @page has been isolated
 	 * because VM is using the field.
diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/virtio_balloon.h
index a1966cd7..a2998a9 100644
--- a/include/uapi/linux/virtio_balloon.h
+++ b/include/uapi/linux/virtio_balloon.h
@@ -36,10 +36,14 @@
 #define VIRTIO_BALLOON_F_DEFLATE_ON_OOM	2 /* Deflate balloon on OOM */
 #define VIRTIO_BALLOON_F_FREE_PAGE_HINT	3 /* VQ to report free pages */
 #define VIRTIO_BALLOON_F_PAGE_POISON	4 /* Guest is using page poisoning */
+#define VIRTIO_BALLOON_F_THP_ORDER	5 /* Balloon page order to thp order */
 
 /* Size of a PFN in the balloon interface. */
 #define VIRTIO_BALLOON_PFN_SHIFT 12
 
+/* The order of the balloon page */
+#define VIRTIO_BALLOON_THP_ORDER 9
+
 #define VIRTIO_BALLOON_CMD_ID_STOP	0
 #define VIRTIO_BALLOON_CMD_ID_DONE	1
 struct virtio_balloon_config {
-- 
2.7.4


