Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C76C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 02:11:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 790292071A
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 02:11:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 790292071A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jl14v-0003fT-Pm
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 22:11:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34952)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhukeqian1@huawei.com>)
 id 1jl14N-00039K-2d; Mon, 15 Jun 2020 22:11:23 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3783 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhukeqian1@huawei.com>)
 id 1jl14K-00030X-UB; Mon, 15 Jun 2020 22:11:22 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 7C17DEDDFCFFC548C81E;
 Tue, 16 Jun 2020 10:11:14 +0800 (CST)
Received: from DESKTOP-5IS4806.china.huawei.com (10.173.221.230) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Tue, 16 Jun 2020 10:11:06 +0800
From: Keqian Zhu <zhukeqian1@huawei.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
Subject: [PATCH v2] migration: Count new_dirty instead of real_dirty
Date: Tue, 16 Jun 2020 10:10:59 +0800
Message-ID: <20200616021059.25984-1-zhukeqian1@huawei.com>
X-Mailer: git-send-email 2.8.4.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.173.221.230]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.191;
 envelope-from=zhukeqian1@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 22:11:15
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: zhang.zhanghailiang@huawei.com, Juan Quintela <quintela@redhat.com>, Chao
 Fan <fanc.fnst@cn.fujitsu.com>, jianjay.zhou@huawei.com,
 wanghaibin.wang@huawei.com, Paolo Bonzini <pbonzini@redhat.com>,
 Keqian Zhu <zhukeqian1@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

real_dirty_pages becomes equal to total ram size after dirty log sync
in ram_init_bitmaps, the reason is that the bitmap of ramblock is
initialized to be all set, so old path counts them as "real dirty" at
beginning.

This causes wrong dirty rate and false positive throttling at the end
of first ram save iteration.

Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>

---
Changelog:

v2:
 - use new_dirty_pages instead of accu_dirty_pages.
 - adjust commit messages.

---
 include/exec/ram_addr.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index 7b5c24e928..a95e2e7c25 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -443,7 +443,7 @@ static inline
 uint64_t cpu_physical_memory_sync_dirty_bitmap(RAMBlock *rb,
                                                ram_addr_t start,
                                                ram_addr_t length,
-                                               uint64_t *real_dirty_pages)
+                                               uint64_t *new_dirty_pages)
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
 
+    *new_dirty_pages += num_dirty;
     return num_dirty;
 }
 #endif
-- 
2.19.1


