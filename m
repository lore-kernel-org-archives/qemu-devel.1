Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C16BFC352AA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 00:52:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9580D2070B
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 00:52:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9580D2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFSsF-0005SL-1j
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 20:52:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39905)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iFRsE-0001dj-N4
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 19:48:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iFRsB-00027A-Hc
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 19:48:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46892)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
 id 1iFRsA-0001e9-Uc; Tue, 01 Oct 2019 19:48:03 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x91NlPhN074797; Tue, 1 Oct 2019 19:47:42 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2vcdv2vpy2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 19:47:41 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x91Nlfl1075660;
 Tue, 1 Oct 2019 19:47:41 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com
 [169.55.91.170])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2vcdv2vpxf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 19:47:41 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
 by ppma02wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x91Njod0031648;
 Tue, 1 Oct 2019 23:47:40 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24]) by ppma02wdc.us.ibm.com with ESMTP id 2v9y587fc0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 23:47:40 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com
 [9.57.199.106])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x91Nldob53477664
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 1 Oct 2019 23:47:40 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E063B28059;
 Tue,  1 Oct 2019 23:47:39 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C5BA52805A;
 Tue,  1 Oct 2019 23:47:39 +0000 (GMT)
Received: from localhost (unknown [9.53.179.213])
 by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue,  1 Oct 2019 23:47:39 +0000 (GMT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 51/97] virtio-balloon: Rework pbp tracking data
Date: Tue,  1 Oct 2019 18:45:30 -0500
Message-Id: <20191001234616.7825-52-mdroth@linux.vnet.ibm.com>
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
X-Received-From: 148.163.156.1
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
Cc: "Michael S . Tsirkin" <mst@redhat.com>, qemu-stable@nongnu.org,
 David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: David Hildenbrand <david@redhat.com>

Using the address of a RAMBlock to test for a matching pbp is not really
safe. Instead, let's use the guest physical address of the base page
along with the page size (via the number of subpages).

Also, let's allocate the bitmap separately. This makes the code
easier to read and maintain - we can reuse bitmap_new().

Prepare the code to move the PBP out of the device.

Fixes: ed48c59875b6 ("virtio-balloon: Safely handle BALLOON_PAGE_SIZE < host page size")
Fixes: b27b32391404 ("virtio-balloon: Fix possible guest memory corruption with inflates & deflates")
Cc: qemu-stable@nongnu.org #v4.0.0
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20190722134108.22151-6-david@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit 1c5cfc2b7153dd72bf4b8ddc456408eb2b9b66d8)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/virtio/virtio-balloon.c | 69 +++++++++++++++++++++++++-------------
 1 file changed, 46 insertions(+), 23 deletions(-)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 76b4c58206..49999d0bbe 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -35,16 +35,44 @@
 #define BALLOON_PAGE_SIZE  (1 << VIRTIO_BALLOON_PFN_SHIFT)
 
 struct PartiallyBalloonedPage {
-    RAMBlock *rb;
-    ram_addr_t base;
-    unsigned long bitmap[];
+    ram_addr_t base_gpa;
+    long subpages;
+    unsigned long *bitmap;
 };
 
+static void virtio_balloon_pbp_free(PartiallyBalloonedPage *pbp)
+{
+    if (!pbp) {
+        return;
+    }
+    g_free(pbp->bitmap);
+    g_free(pbp);
+}
+
+static PartiallyBalloonedPage *virtio_balloon_pbp_alloc(ram_addr_t base_gpa,
+                                                        long subpages)
+{
+    PartiallyBalloonedPage *pbp = g_new0(PartiallyBalloonedPage, 1);
+
+    pbp->base_gpa = base_gpa;
+    pbp->subpages = subpages;
+    pbp->bitmap = bitmap_new(subpages);
+
+    return pbp;
+}
+
+static bool virtio_balloon_pbp_matches(PartiallyBalloonedPage *pbp,
+                                       ram_addr_t base_gpa, long subpages)
+{
+    return pbp->subpages == subpages && pbp->base_gpa == base_gpa;
+}
+
 static void balloon_inflate_page(VirtIOBalloon *balloon,
                                  MemoryRegion *mr, hwaddr mr_offset)
 {
     void *addr = memory_region_get_ram_ptr(mr) + mr_offset;
-    ram_addr_t rb_offset, rb_aligned_offset;
+    ram_addr_t rb_offset, rb_aligned_offset, base_gpa;
+    PartiallyBalloonedPage **pbp = &balloon->pbp;
     RAMBlock *rb;
     size_t rb_page_size;
     int subpages;
@@ -75,39 +103,34 @@ static void balloon_inflate_page(VirtIOBalloon *balloon,
 
     rb_aligned_offset = QEMU_ALIGN_DOWN(rb_offset, rb_page_size);
     subpages = rb_page_size / BALLOON_PAGE_SIZE;
+    base_gpa = memory_region_get_ram_addr(mr) + mr_offset -
+               (rb_offset - rb_aligned_offset);
 
-    if (balloon->pbp
-        && (rb != balloon->pbp->rb
-            || rb_aligned_offset != balloon->pbp->base)) {
+    if (*pbp && !virtio_balloon_pbp_matches(*pbp, base_gpa, subpages)) {
         /* We've partially ballooned part of a host page, but now
          * we're trying to balloon part of a different one.  Too hard,
          * give up on the old partial page */
-        g_free(balloon->pbp);
-        balloon->pbp = NULL;
+        virtio_balloon_pbp_free(*pbp);
+        *pbp = NULL;
     }
 
-    if (!balloon->pbp) {
-        /* Starting on a new host page */
-        size_t bitlen = BITS_TO_LONGS(subpages) * sizeof(unsigned long);
-        balloon->pbp = g_malloc0(sizeof(PartiallyBalloonedPage) + bitlen);
-        balloon->pbp->rb = rb;
-        balloon->pbp->base = rb_aligned_offset;
+    if (!*pbp) {
+        *pbp = virtio_balloon_pbp_alloc(base_gpa, subpages);
     }
 
-    set_bit((rb_offset - balloon->pbp->base) / BALLOON_PAGE_SIZE,
-            balloon->pbp->bitmap);
+    set_bit((rb_offset - rb_aligned_offset) / BALLOON_PAGE_SIZE,
+            (*pbp)->bitmap);
 
-    if (bitmap_full(balloon->pbp->bitmap, subpages)) {
+    if (bitmap_full((*pbp)->bitmap, subpages)) {
         /* We've accumulated a full host page, we can actually discard
          * it now */
 
-        ram_block_discard_range(rb, balloon->pbp->base, rb_page_size);
+        ram_block_discard_range(rb, rb_aligned_offset, rb_page_size);
         /* We ignore errors from ram_block_discard_range(), because it
          * has already reported them, and failing to discard a balloon
          * page is not fatal */
-
-        g_free(balloon->pbp);
-        balloon->pbp = NULL;
+        virtio_balloon_pbp_free(*pbp);
+        *pbp = NULL;
     }
 }
 
@@ -128,7 +151,7 @@ static void balloon_deflate_page(VirtIOBalloon *balloon,
 
     if (balloon->pbp) {
         /* Let's play safe and always reset the pbp on deflation requests. */
-        g_free(balloon->pbp);
+        virtio_balloon_pbp_free(balloon->pbp);
         balloon->pbp = NULL;
     }
 
-- 
2.17.1


