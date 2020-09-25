Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A87AC4727C
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 12:13:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B265A2083B
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 12:13:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JMa9CdcU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B265A2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLmbm-0002n2-Ie
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 08:13:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38330)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kLmW9-0003J6-Uv
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 08:08:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43925)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kLmW7-0004GP-T5
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 08:08:01 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601035679;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UWc4hSQmzBB7vyJUeLm8dd7XRJRw3sM/5DoLuwgjqS4=;
 b=JMa9CdcUPX2RFF1cF/2JRSZPok2Tigw9ItwWnlutBZE+LhC1DKQE/eHN47193+HVs2+2Yq
 ZWVzAz/EhOuHPS9t/va6E7fy9H2nT0oXD/j9vrZkM9Hq7cYib4pcL/h1e1Gqii3/PYUKga
 g3z86nf4ZG9W9KfboGo6SjlmigwEpvM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-CmQm6c5LPmaHD9IPEQ9tvQ-1; Fri, 25 Sep 2020 08:07:55 -0400
X-MC-Unique: CmQm6c5LPmaHD9IPEQ9tvQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D33088030CC;
 Fri, 25 Sep 2020 12:07:53 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-114-177.ams2.redhat.com
 [10.36.114.177])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8A3D073692;
 Fri, 25 Sep 2020 12:07:51 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, zhengchuan@huawei.com, dovmurik@linux.vnet.ibm.com,
 hgcoin@gmail.com, zhangjiachen.jaycee@bytedance.com, lvivier@redhat.com,
 peterx@redhat.com, stefanha@redhat.com, vgoyal@redhat.com,
 jinyan12@huawei.com, ann.zhuangyanying@huawei.com
Subject: [PULL 14/26] migration/dirtyrate: Add trace_calls to make it easier
 to debug
Date: Fri, 25 Sep 2020 13:06:43 +0100
Message-Id: <20200925120655.295142-15-dgilbert@redhat.com>
In-Reply-To: <20200925120655.295142-1-dgilbert@redhat.com>
References: <20200925120655.295142-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 02:48:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Chuan Zheng <zhengchuan@huawei.com>

Add trace_calls to make it easier to debug

Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: David Edmondson <david.edmondson@oracle.com>
Message-Id: <1600237327-33618-13-git-send-email-zhengchuan@huawei.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/dirtyrate.c  | 9 +++++++++
 migration/trace-events | 8 ++++++++
 2 files changed, 17 insertions(+)

diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
index 2ffd88d48e..68577ef250 100644
--- a/migration/dirtyrate.c
+++ b/migration/dirtyrate.c
@@ -22,6 +22,7 @@
 #include "qapi/qapi-commands-migration.h"
 #include "migration.h"
 #include "ram.h"
+#include "trace.h"
 #include "dirtyrate.h"
 
 static int CalculatingState = DIRTY_RATE_STATUS_UNSTARTED;
@@ -54,6 +55,7 @@ static bool is_sample_period_valid(int64_t sec)
 static int dirtyrate_set_state(int *state, int old_state, int new_state)
 {
     assert(new_state < DIRTY_RATE_STATUS__MAX);
+    trace_dirtyrate_set_state(DirtyRateStatus_str(new_state));
     if (qatomic_cmpxchg(state, old_state, new_state) == old_state) {
         return 0;
     } else {
@@ -76,6 +78,8 @@ static struct DirtyRateInfo *query_dirty_rate_info(void)
     info->start_time = DirtyStat.start_time;
     info->calc_time = DirtyStat.calc_time;
 
+    trace_query_dirty_rate_info(DirtyRateStatus_str(CalculatingState));
+
     return info;
 }
 
@@ -123,6 +127,7 @@ static uint32_t get_ramblock_vfn_hash(struct RamblockDirtyInfo *info,
     crc = crc32(0, (info->ramblock_addr +
                 vfn * TARGET_PAGE_SIZE), TARGET_PAGE_SIZE);
 
+    trace_get_ramblock_vfn_hash(info->idstr, vfn, crc);
     return crc;
 }
 
@@ -201,6 +206,8 @@ static bool skip_sample_ramblock(RAMBlock *block)
      * Sample only blocks larger than MIN_RAMBLOCK_SIZE.
      */
     if (qemu_ram_get_used_length(block) < (MIN_RAMBLOCK_SIZE << 10)) {
+        trace_skip_sample_ramblock(block->idstr,
+                                   qemu_ram_get_used_length(block));
         return true;
     }
 
@@ -260,6 +267,7 @@ static void calc_page_dirty_rate(struct RamblockDirtyInfo *info)
     for (i = 0; i < info->sample_pages_count; i++) {
         crc = get_ramblock_vfn_hash(info, info->sample_page_vfn[i]);
         if (crc != info->hash_result[i]) {
+            trace_calc_page_dirty_rate(info->idstr, crc, info->hash_result[i]);
             info->sample_dirty_count++;
         }
     }
@@ -285,6 +293,7 @@ find_block_matched(RAMBlock *block, int count,
     if (infos[i].ramblock_addr != qemu_ram_get_host_addr(block) ||
         infos[i].ramblock_pages !=
             (qemu_ram_get_used_length(block) >> TARGET_PAGE_BITS)) {
+        trace_find_page_matched(block->idstr);
         return NULL;
     }
 
diff --git a/migration/trace-events b/migration/trace-events
index 7ba2fa6644..597a470b9d 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -313,3 +313,11 @@ dirty_bitmap_load_bits_zeroes(void) ""
 dirty_bitmap_load_header(uint32_t flags) "flags 0x%x"
 dirty_bitmap_load_enter(void) ""
 dirty_bitmap_load_success(void) ""
+
+# dirtyrate.c
+dirtyrate_set_state(const char *new_state) "new state %s"
+query_dirty_rate_info(const char *new_state) "current state %s"
+get_ramblock_vfn_hash(const char *idstr, uint64_t vfn, uint32_t crc) "ramblock name: %s, vfn: %"PRIu64 ", crc: %" PRIu32
+calc_page_dirty_rate(const char *idstr, uint32_t new_crc, uint32_t old_crc) "ramblock name: %s, new crc: %" PRIu32 ", old crc: %" PRIu32
+skip_sample_ramblock(const char *idstr, uint64_t ramblock_size) "ramblock name: %s, ramblock size: %" PRIu64
+find_page_matched(const char *idstr) "ramblock %s addr or size changed"
-- 
2.26.2


