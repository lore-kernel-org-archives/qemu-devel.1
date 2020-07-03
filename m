Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D87EC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 15:33:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59542208C7
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 15:33:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hTRRcDqR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59542208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrNgr-0005Dr-MD
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 11:33:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51110)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jrNbl-000768-Nr
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 11:28:09 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:58093
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jrNbg-0006eC-AV
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 11:28:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593790082;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TgBnNY+2WV0e8/kWUtIYyrE1baZDFHlj+IejXzvllD8=;
 b=hTRRcDqRvigdy4xjIfg+9/iiVOQiWLbtvfu0zDkzC9Ag7zzMvHwXyW9JGldGQsUrmtIYJW
 4phqq4VaPe0/e7Y3hDImOo9Uqo95wCuGv7DVXyFFBOU18gsglQzh9i6E4l4BklPfaA/Tta
 U/vadCUA9TjBawbsoXA40/zhnicnSus=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-367-4XdK1vOXN52AiGmc0iux8A-1; Fri, 03 Jul 2020 11:28:00 -0400
X-MC-Unique: 4XdK1vOXN52AiGmc0iux8A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CAE7B800C60;
 Fri,  3 Jul 2020 15:27:59 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-114-207.ams2.redhat.com
 [10.36.114.207])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CF3F42DE72;
 Fri,  3 Jul 2020 15:27:58 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, quintela@redhat.com, zhukeqian1@huawei.com,
 stefanha@redhat.com
Subject: [PULL 5/5] migration: Count new_dirty instead of real_dirty
Date: Fri,  3 Jul 2020 16:27:48 +0100
Message-Id: <20200703152748.277255-6-dgilbert@redhat.com>
In-Reply-To: <20200703152748.277255-1-dgilbert@redhat.com>
References: <20200703152748.277255-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 01:34:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Keqian Zhu <zhukeqian1@huawei.com>

real_dirty_pages becomes equal to total ram size after dirty log sync
in ram_init_bitmaps, the reason is that the bitmap of ramblock is
initialized to be all set, so old path counts them as "real dirty" at
beginning.

This causes wrong dirty rate and false positive throttling.

Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
Message-Id: <20200622032037.31112-1-zhukeqian1@huawei.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 include/exec/ram_addr.h | 5 +----
 migration/ram.c         | 8 +++++---
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index 7b5c24e928..3ef729a23c 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -442,8 +442,7 @@ static inline void cpu_physical_memory_clear_dirty_range(ram_addr_t start,
 static inline
 uint64_t cpu_physical_memory_sync_dirty_bitmap(RAMBlock *rb,
                                                ram_addr_t start,
-                                               ram_addr_t length,
-                                               uint64_t *real_dirty_pages)
+                                               ram_addr_t length)
 {
     ram_addr_t addr;
     unsigned long word = BIT_WORD((start + rb->offset) >> TARGET_PAGE_BITS);
@@ -469,7 +468,6 @@ uint64_t cpu_physical_memory_sync_dirty_bitmap(RAMBlock *rb,
             if (src[idx][offset]) {
                 unsigned long bits = atomic_xchg(&src[idx][offset], 0);
                 unsigned long new_dirty;
-                *real_dirty_pages += ctpopl(bits);
                 new_dirty = ~dest[k];
                 dest[k] |= bits;
                 new_dirty &= bits;
@@ -502,7 +500,6 @@ uint64_t cpu_physical_memory_sync_dirty_bitmap(RAMBlock *rb,
                         start + addr + offset,
                         TARGET_PAGE_SIZE,
                         DIRTY_MEMORY_MIGRATION)) {
-                *real_dirty_pages += 1;
                 long k = (start + addr) >> TARGET_PAGE_BITS;
                 if (!test_and_set_bit(k, dest)) {
                     num_dirty++;
diff --git a/migration/ram.c b/migration/ram.c
index 069b6e30bc..5554a7d2d8 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -859,9 +859,11 @@ static inline bool migration_bitmap_clear_dirty(RAMState *rs,
 /* Called with RCU critical section */
 static void ramblock_sync_dirty_bitmap(RAMState *rs, RAMBlock *rb)
 {
-    rs->migration_dirty_pages +=
-        cpu_physical_memory_sync_dirty_bitmap(rb, 0, rb->used_length,
-                                              &rs->num_dirty_pages_period);
+    uint64_t new_dirty_pages =
+        cpu_physical_memory_sync_dirty_bitmap(rb, 0, rb->used_length);
+
+    rs->migration_dirty_pages += new_dirty_pages;
+    rs->num_dirty_pages_period += new_dirty_pages;
 }
 
 /**
-- 
2.26.2


