Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C336FC352AA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 00:44:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9513520818
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 00:44:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9513520818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFSkd-0005nV-9U
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 20:44:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40240)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iFRsL-0001nr-7P
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 19:48:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iFRsE-0002DR-UF
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 19:48:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:28616)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
 id 1iFRsE-0001hx-Eo; Tue, 01 Oct 2019 19:48:06 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x91NlMkj193517; Tue, 1 Oct 2019 19:47:44 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2vc71qsg6u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 19:47:43 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x91NlMnL193520;
 Tue, 1 Oct 2019 19:47:42 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.27])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2vc71qsg6m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 19:47:42 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
 by ppma05wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x91Njm5w023587;
 Tue, 1 Oct 2019 23:47:41 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26]) by ppma05wdc.us.ibm.com with ESMTP id 2v9y577gyn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 23:47:41 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com
 [9.57.199.106])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x91NlfS514090956
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 1 Oct 2019 23:47:41 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 62A432805A;
 Tue,  1 Oct 2019 23:47:41 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 46F442805E;
 Tue,  1 Oct 2019 23:47:41 +0000 (GMT)
Received: from localhost (unknown [9.53.179.213])
 by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue,  1 Oct 2019 23:47:41 +0000 (GMT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 54/97] virtio-balloon: free pbp more aggressively
Date: Tue,  1 Oct 2019 18:45:33 -0500
Message-Id: <20191001234616.7825-55-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191001234616.7825-1-mdroth@linux.vnet.ibm.com>
References: <20191001234616.7825-1-mdroth@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-10-01_10:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910010203
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.158.5
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
Cc: David Hildenbrand <david@redhat.com>, qemu-stable@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Michael S. Tsirkin" <mst@redhat.com>

Previous patches switched to a temporary pbp but that does not go far
enough: after device uses a buffer, guest is free to reuse it, so
tracking the page and freeing it later is wrong.

Free and reset the pbp after we push each element.

Fixes: ed48c59875b6 ("virtio-balloon: Safely handle BALLOON_PAGE_SIZE < host page size")
Cc: qemu-stable@nongnu.org #v4.0.0
Cc: David Hildenbrand <david@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit 1b47b37c33ec01ae1efc527f4c97f97f93723bc4)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/virtio/virtio-balloon.c | 37 ++++++++++++++++---------------------
 1 file changed, 16 insertions(+), 21 deletions(-)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 4a5a22ca3d..adde97fe4b 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -41,22 +41,19 @@ typedef struct PartiallyBalloonedPage {
 
 static void virtio_balloon_pbp_free(PartiallyBalloonedPage *pbp)
 {
-    if (!pbp) {
+    if (!pbp->bitmap) {
         return;
     }
     g_free(pbp->bitmap);
-    g_free(pbp);
+    pbp->bitmap = NULL;
 }
 
-static PartiallyBalloonedPage *virtio_balloon_pbp_alloc(ram_addr_t base_gpa,
-                                                        long subpages)
+static void virtio_balloon_pbp_alloc(PartiallyBalloonedPage *pbp,
+                                     ram_addr_t base_gpa,
+                                     long subpages)
 {
-    PartiallyBalloonedPage *pbp = g_new0(PartiallyBalloonedPage, 1);
-
     pbp->base_gpa = base_gpa;
     pbp->bitmap = bitmap_new(subpages);
-
-    return pbp;
 }
 
 static bool virtio_balloon_pbp_matches(PartiallyBalloonedPage *pbp,
@@ -67,7 +64,7 @@ static bool virtio_balloon_pbp_matches(PartiallyBalloonedPage *pbp,
 
 static void balloon_inflate_page(VirtIOBalloon *balloon,
                                  MemoryRegion *mr, hwaddr mr_offset,
-                                 PartiallyBalloonedPage **pbp)
+                                 PartiallyBalloonedPage *pbp)
 {
     void *addr = memory_region_get_ram_ptr(mr) + mr_offset;
     ram_addr_t rb_offset, rb_aligned_offset, base_gpa;
@@ -104,22 +101,21 @@ static void balloon_inflate_page(VirtIOBalloon *balloon,
     base_gpa = memory_region_get_ram_addr(mr) + mr_offset -
                (rb_offset - rb_aligned_offset);
 
-    if (*pbp && !virtio_balloon_pbp_matches(*pbp, base_gpa)) {
+    if (pbp->bitmap && !virtio_balloon_pbp_matches(pbp, base_gpa)) {
         /* We've partially ballooned part of a host page, but now
          * we're trying to balloon part of a different one.  Too hard,
          * give up on the old partial page */
-        virtio_balloon_pbp_free(*pbp);
-        *pbp = NULL;
+        virtio_balloon_pbp_free(pbp);
     }
 
-    if (!*pbp) {
-        *pbp = virtio_balloon_pbp_alloc(base_gpa, subpages);
+    if (!pbp->bitmap) {
+        virtio_balloon_pbp_alloc(pbp, base_gpa, subpages);
     }
 
     set_bit((rb_offset - rb_aligned_offset) / BALLOON_PAGE_SIZE,
-            (*pbp)->bitmap);
+            pbp->bitmap);
 
-    if (bitmap_full((*pbp)->bitmap, subpages)) {
+    if (bitmap_full(pbp->bitmap, subpages)) {
         /* We've accumulated a full host page, we can actually discard
          * it now */
 
@@ -127,8 +123,7 @@ static void balloon_inflate_page(VirtIOBalloon *balloon,
         /* We ignore errors from ram_block_discard_range(), because it
          * has already reported them, and failing to discard a balloon
          * page is not fatal */
-        virtio_balloon_pbp_free(*pbp);
-        *pbp = NULL;
+        virtio_balloon_pbp_free(pbp);
     }
 }
 
@@ -328,13 +323,14 @@ static void balloon_stats_set_poll_interval(Object *obj, Visitor *v,
 static void virtio_balloon_handle_output(VirtIODevice *vdev, VirtQueue *vq)
 {
     VirtIOBalloon *s = VIRTIO_BALLOON(vdev);
-    PartiallyBalloonedPage *pbp = NULL;
     VirtQueueElement *elem;
     MemoryRegionSection section;
 
     for (;;) {
+        PartiallyBalloonedPage pbp = {};
         size_t offset = 0;
         uint32_t pfn;
+
         elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
         if (!elem) {
             break;
@@ -379,9 +375,8 @@ static void virtio_balloon_handle_output(VirtIODevice *vdev, VirtQueue *vq)
         virtqueue_push(vq, elem, offset);
         virtio_notify(vdev, vq);
         g_free(elem);
+        virtio_balloon_pbp_free(&pbp);
     }
-
-    virtio_balloon_pbp_free(pbp);
 }
 
 static void virtio_balloon_receive_stats(VirtIODevice *vdev, VirtQueue *vq)
-- 
2.17.1


