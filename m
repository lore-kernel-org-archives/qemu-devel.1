Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDCA2C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 09:20:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B12A4208E4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 09:20:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B12A4208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBb48-0003W9-QR
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 05:20:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37568)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhukeqian1@huawei.com>) id 1jBb2v-0001pv-ED
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 05:19:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhukeqian1@huawei.com>) id 1jBb2t-00065N-Ao
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 05:19:29 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3269 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhukeqian1@huawei.com>)
 id 1jBb2p-0005ih-N1; Tue, 10 Mar 2020 05:19:24 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 3DD00CAF2E97E0FBE086;
 Tue, 10 Mar 2020 17:19:19 +0800 (CST)
Received: from linux-kDCJWP.huawei.com (10.175.104.212) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Tue, 10 Mar 2020 17:19:09 +0800
From: Keqian Zhu <zhukeqian1@huawei.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH v2 1/2] memory: Introduce start_global variable in dirty
 bitmap sync
Date: Tue, 10 Mar 2020 17:17:03 +0800
Message-ID: <20200310091704.42340-2-zhukeqian1@huawei.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20200310091704.42340-1-zhukeqian1@huawei.com>
References: <20200310091704.42340-1-zhukeqian1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.104.212]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.191
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Keqian Zhu <zhukeqian1@huawei.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, wanghaibin.wang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In the cpu_physical_memory_sync_dirty_bitmap func, use start_global
variable to make code more clear. And the addr variable is only used
in slow path, so move it to slow path.

Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
---
 include/exec/ram_addr.h | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index 5e59a3d8d7..8311efb7bc 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -445,14 +445,13 @@ uint64_t cpu_physical_memory_sync_dirty_bitmap(RAMB=
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
     /* start address and length is aligned at the start of a word? */
-    if (((word * BITS_PER_LONG) << TARGET_PAGE_BITS) =3D=3D
-         (start + rb->offset) &&
+    if (((word * BITS_PER_LONG) << TARGET_PAGE_BITS) =3D=3D start_global=
 &&
         !(length & ((BITS_PER_LONG << TARGET_PAGE_BITS) - 1))) {
         int k;
         int nr =3D BITS_TO_LONGS(length >> TARGET_PAGE_BITS);
@@ -495,11 +494,11 @@ uint64_t cpu_physical_memory_sync_dirty_bitmap(RAMB=
lock *rb,
             memory_region_clear_dirty_bitmap(rb->mr, start, length);
         }
     } else {
-        ram_addr_t offset =3D rb->offset;
+        ram_addr_t addr;
=20
         for (addr =3D 0; addr < length; addr +=3D TARGET_PAGE_SIZE) {
             if (cpu_physical_memory_test_and_clear_dirty(
-                        start + addr + offset,
+                        start_global + addr,
                         TARGET_PAGE_SIZE,
                         DIRTY_MEMORY_MIGRATION)) {
                 *real_dirty_pages +=3D 1;
--=20
2.19.1


