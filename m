Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E9FC3F2C6
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 03:44:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E48F82084E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 03:44:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E48F82084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jA3uM-0002QH-4i
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 22:44:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48469)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhukeqian1@huawei.com>) id 1jA3tc-0001vM-Qg
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 22:43:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhukeqian1@huawei.com>) id 1jA3tb-0005d2-QK
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 22:43:32 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:46942 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhukeqian1@huawei.com>)
 id 1jA3tZ-0005C6-4K; Thu, 05 Mar 2020 22:43:29 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 11F153F6A4A8244704DB;
 Fri,  6 Mar 2020 11:43:20 +0800 (CST)
Received: from linux-kDCJWP.huawei.com (10.175.104.212) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.439.0; Fri, 6 Mar 2020 11:43:13 +0800
From: Keqian Zhu <zhukeqian1@huawei.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH] migration: not require length align when choose fast dirty
 sync path
Date: Fri, 6 Mar 2020 11:41:09 +0800
Message-ID: <20200306034109.19992-1-zhukeqian1@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.104.212]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.35
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
Cc: wanghaibin.wang@huawei.com, qemu-arm@nongnu.org,
 Keqian Zhu <zhukeqian1@huawei.com>, "Dr. David
 Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In aa777e297c840, ramblock length is required to align word pages
when we choose the fast dirty sync path. The reason is that "If the
Ramblock is less than 64 pages in length that long can contain bits
representing two different RAMBlocks, but the code will update the
bmap belinging to the 1st RAMBlock only while having updated the total
dirty page count for both."

This is right before 801110ab22be1ef2, which align ram_addr_t allocation
on long boundaries. So currently we wont "updated the total dirty page
count for both".

Remove the alignment constraint of length and we can always use fast
dirty sync path.

Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
---
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org
---
 include/exec/ram_addr.h | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index 5e59a3d8d7..40fd89e1cd 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -445,15 +445,13 @@ uint64_t cpu_physical_memory_sync_dirty_bitmap(RAMB=
lock *rb,
                                                ram_addr_t length,
                                                uint64_t *real_dirty_page=
s)
 {
-    ram_addr_t addr;
-    unsigned long word =3D BIT_WORD((start + rb->offset) >> TARGET_PAGE_=
BITS);
+    ram_addr_t start_global =3D start + rb->offset;
+    unsigned long word =3D BIT_WORD(start_global >> TARGET_PAGE_BITS);
     uint64_t num_dirty =3D 0;
     unsigned long *dest =3D rb->bmap;
=20
-    /* start address and length is aligned at the start of a word? */
-    if (((word * BITS_PER_LONG) << TARGET_PAGE_BITS) =3D=3D
-         (start + rb->offset) &&
-        !(length & ((BITS_PER_LONG << TARGET_PAGE_BITS) - 1))) {
+    /* start address is aligned at the start of a word? */
+    if (((word * BITS_PER_LONG) << TARGET_PAGE_BITS) =3D=3D start_global=
) {
         int k;
         int nr =3D BITS_TO_LONGS(length >> TARGET_PAGE_BITS);
         unsigned long * const *src;
@@ -495,11 +493,10 @@ uint64_t cpu_physical_memory_sync_dirty_bitmap(RAMB=
lock *rb,
             memory_region_clear_dirty_bitmap(rb->mr, start, length);
         }
     } else {
-        ram_addr_t offset =3D rb->offset;
-
+        ram_addr_t addr;
         for (addr =3D 0; addr < length; addr +=3D TARGET_PAGE_SIZE) {
             if (cpu_physical_memory_test_and_clear_dirty(
-                        start + addr + offset,
+                        start_global + addr,
                         TARGET_PAGE_SIZE,
                         DIRTY_MEMORY_MIGRATION)) {
                 *real_dirty_pages +=3D 1;
--=20
2.19.1


