Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED9F1C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 04:04:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2108206E2
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 04:04:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2108206E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfbgm-0006a5-VD
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 00:04:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57112)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhukeqian1@huawei.com>)
 id 1jfbfq-0005wl-3w; Mon, 01 Jun 2020 00:03:42 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3771 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhukeqian1@huawei.com>)
 id 1jfbfo-00081y-GG; Mon, 01 Jun 2020 00:03:41 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 25604FEA423AB5663262;
 Mon,  1 Jun 2020 12:03:30 +0800 (CST)
Received: from DESKTOP-5IS4806.china.huawei.com (10.173.221.230) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Mon, 1 Jun 2020 12:03:21 +0800
From: Keqian Zhu <zhukeqian1@huawei.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
Subject: [PATCH] migration: Count new_dirty instead of real_dirty
Date: Mon, 1 Jun 2020 12:02:50 +0800
Message-ID: <20200601040250.38324-1-zhukeqian1@huawei.com>
X-Mailer: git-send-email 2.8.4.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.173.221.230]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.191;
 envelope-from=zhukeqian1@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/01 00:03:30
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Chao Fan <fanc.fnst@cn.fujitsu.com>,
 Keqian Zhu <zhukeqian1@huawei.com>, wanghaibin.wang@huawei.com,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DIRTY_LOG_INITIALLY_ALL_SET feature is on the queue. This fixs the
dirty rate calculation for this feature. After introducing this
feature, real_dirty_pages is equal to total memory size at begining.
This causing wrong dirty rate and false positive throttling.

BTW, real dirty rate is not suitable and not very accurate.

1. For not suitable: We mainly concern on the relationship between
   dirty rate and network bandwidth. Net increasement of dirty pages
   makes more sense.
2. For not very accurate: With manual dirty log clear, some dirty pages
   will be cleared during each peroid, our "real dirty rate" is less
   than real "real dirty rate".

Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
---
 include/exec/ram_addr.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index 5e59a3d8d7..af9677e291 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -443,7 +443,7 @@ static inline
 uint64_t cpu_physical_memory_sync_dirty_bitmap(RAMBlock *rb,
                                                ram_addr_t start,
                                                ram_addr_t length,
-                                               uint64_t *real_dirty_pages)
+                                               uint64_t *accu_dirty_pages)
 {
     ram_addr_t addr;
     unsigned long word = BIT_WORD((start + rb->offset) >> TARGET_PAGE_BITS);
@@ -469,7 +469,6 @@ uint64_t cpu_physical_memory_sync_dirty_bitmap(RAMBlock *rb,
             if (src[idx][offset]) {
                 unsigned long bits = atomic_xchg(&src[idx][offset], 0);
                 unsigned long new_dirty;
-                *real_dirty_pages += ctpopl(bits);
                 new_dirty = ~dest[k];
                 dest[k] |= bits;
                 new_dirty &= bits;
@@ -502,7 +501,6 @@ uint64_t cpu_physical_memory_sync_dirty_bitmap(RAMBlock *rb,
                         start + addr + offset,
                         TARGET_PAGE_SIZE,
                         DIRTY_MEMORY_MIGRATION)) {
-                *real_dirty_pages += 1;
                 long k = (start + addr) >> TARGET_PAGE_BITS;
                 if (!test_and_set_bit(k, dest)) {
                     num_dirty++;
@@ -511,6 +509,7 @@ uint64_t cpu_physical_memory_sync_dirty_bitmap(RAMBlock *rb,
         }
     }
 
+    *accu_dirty_pages += num_dirty;
     return num_dirty;
 }
 #endif
-- 
2.19.1


