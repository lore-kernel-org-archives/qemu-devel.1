Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8249C352AA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 00:48:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B896E2070B
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 00:48:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B896E2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFSoL-0001dJ-JA
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 20:48:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39904)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iFRsE-0001df-Mb
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 19:48:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iFRsB-000274-FL
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 19:48:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:3240)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
 id 1iFRsA-0001dh-S6; Tue, 01 Oct 2019 19:48:03 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x91NlPJA088120; Tue, 1 Oct 2019 19:47:41 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2vbsjt6bxe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 19:47:41 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x91NlWuq088382;
 Tue, 1 Oct 2019 19:47:41 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.27])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2vbsjt6bwh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 19:47:41 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
 by ppma05wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x91NjmlK023578;
 Tue, 1 Oct 2019 23:47:39 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24]) by ppma05wdc.us.ibm.com with ESMTP id 2v9y577gyj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 23:47:39 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com
 [9.57.199.106])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x91Nldda40304954
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 1 Oct 2019 23:47:39 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E70A928059;
 Tue,  1 Oct 2019 23:47:38 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CAA692805A;
 Tue,  1 Oct 2019 23:47:38 +0000 (GMT)
Received: from localhost (unknown [9.53.179.213])
 by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue,  1 Oct 2019 23:47:38 +0000 (GMT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 50/97] virtio-balloon: Better names for offset variables in
 inflate/deflate code
Date: Tue,  1 Oct 2019 18:45:29 -0500
Message-Id: <20191001234616.7825-51-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191001234616.7825-1-mdroth@linux.vnet.ibm.com>
References: <20191001234616.7825-1-mdroth@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-10-01_10:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
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

"host_page_base" is really confusing, let's make this clearer, also
rename the other offsets to indicate to which base they apply.

offset -> mr_offset
ram_offset -> rb_offset
host_page_base -> rb_aligned_offset

While at it, use QEMU_ALIGN_DOWN() instead of a handcrafted computation
and move the computation to the place where it is needed.

Acked-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20190722134108.22151-5-david@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit e6129b271b9dccca22c84870e313c315f2c70063)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/virtio/virtio-balloon.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 4f42d3f2b0..76b4c58206 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -41,24 +41,23 @@ struct PartiallyBalloonedPage {
 };
 
 static void balloon_inflate_page(VirtIOBalloon *balloon,
-                                 MemoryRegion *mr, hwaddr offset)
+                                 MemoryRegion *mr, hwaddr mr_offset)
 {
-    void *addr = memory_region_get_ram_ptr(mr) + offset;
+    void *addr = memory_region_get_ram_ptr(mr) + mr_offset;
+    ram_addr_t rb_offset, rb_aligned_offset;
     RAMBlock *rb;
     size_t rb_page_size;
     int subpages;
-    ram_addr_t ram_offset, host_page_base;
 
     /* XXX is there a better way to get to the RAMBlock than via a
      * host address? */
-    rb = qemu_ram_block_from_host(addr, false, &ram_offset);
+    rb = qemu_ram_block_from_host(addr, false, &rb_offset);
     rb_page_size = qemu_ram_pagesize(rb);
-    host_page_base = ram_offset & ~(rb_page_size - 1);
 
     if (rb_page_size == BALLOON_PAGE_SIZE) {
         /* Easy case */
 
-        ram_block_discard_range(rb, ram_offset, rb_page_size);
+        ram_block_discard_range(rb, rb_offset, rb_page_size);
         /* We ignore errors from ram_block_discard_range(), because it
          * has already reported them, and failing to discard a balloon
          * page is not fatal */
@@ -74,11 +73,12 @@ static void balloon_inflate_page(VirtIOBalloon *balloon,
     warn_report_once(
 "Balloon used with backing page size > 4kiB, this may not be reliable");
 
+    rb_aligned_offset = QEMU_ALIGN_DOWN(rb_offset, rb_page_size);
     subpages = rb_page_size / BALLOON_PAGE_SIZE;
 
     if (balloon->pbp
         && (rb != balloon->pbp->rb
-            || host_page_base != balloon->pbp->base)) {
+            || rb_aligned_offset != balloon->pbp->base)) {
         /* We've partially ballooned part of a host page, but now
          * we're trying to balloon part of a different one.  Too hard,
          * give up on the old partial page */
@@ -91,10 +91,10 @@ static void balloon_inflate_page(VirtIOBalloon *balloon,
         size_t bitlen = BITS_TO_LONGS(subpages) * sizeof(unsigned long);
         balloon->pbp = g_malloc0(sizeof(PartiallyBalloonedPage) + bitlen);
         balloon->pbp->rb = rb;
-        balloon->pbp->base = host_page_base;
+        balloon->pbp->base = rb_aligned_offset;
     }
 
-    set_bit((ram_offset - balloon->pbp->base) / BALLOON_PAGE_SIZE,
+    set_bit((rb_offset - balloon->pbp->base) / BALLOON_PAGE_SIZE,
             balloon->pbp->bitmap);
 
     if (bitmap_full(balloon->pbp->bitmap, subpages)) {
@@ -112,18 +112,18 @@ static void balloon_inflate_page(VirtIOBalloon *balloon,
 }
 
 static void balloon_deflate_page(VirtIOBalloon *balloon,
-                                 MemoryRegion *mr, hwaddr offset)
+                                 MemoryRegion *mr, hwaddr mr_offset)
 {
-    void *addr = memory_region_get_ram_ptr(mr) + offset;
+    void *addr = memory_region_get_ram_ptr(mr) + mr_offset;
+    ram_addr_t rb_offset;
     RAMBlock *rb;
     size_t rb_page_size;
-    ram_addr_t ram_offset;
     void *host_addr;
     int ret;
 
     /* XXX is there a better way to get to the RAMBlock than via a
      * host address? */
-    rb = qemu_ram_block_from_host(addr, false, &ram_offset);
+    rb = qemu_ram_block_from_host(addr, false, &rb_offset);
     rb_page_size = qemu_ram_pagesize(rb);
 
     if (balloon->pbp) {
-- 
2.17.1


