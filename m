Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA59C54FCB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 04:05:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7329520735
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 04:05:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7329520735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQNgp-0008Ur-Lb
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 00:05:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36582 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wei.w.wang@intel.com>) id 1jQNcF-00073d-O4
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 00:01:04 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <wei.w.wang@intel.com>) id 1jQNcD-0000iw-JU
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 00:01:03 -0400
Received: from mga09.intel.com ([134.134.136.24]:39951)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1jQNcC-0000eQ-VG
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 00:01:01 -0400
IronPort-SDR: mXzgoDXDtW9xq4vkXLDsG3qctruusVb9dUv6ExsSVUXUrSywuN3O20aTe2R1ov7pSZSZpQJuW+
 b6hWtVjfqz5A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Apr 2020 21:00:58 -0700
IronPort-SDR: vUUSSr6/GgaPeoFk5JOlzPnL4sISx0Lca0UhfliYmvcNCuweLYIEo5ec+49Gr4bAtH6uLZj65q
 AJ5uba2PqdUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,405,1580803200"; d="scan'208";a="333790715"
Received: from unknown (HELO devel-ww.sh.intel.com) ([10.239.48.118])
 by orsmga001.jf.intel.com with ESMTP; 19 Apr 2020 21:00:56 -0700
From: Wei Wang <wei.w.wang@intel.com>
To: qemu-devel@nongnu.org, quintela@redhat.com, dgilbert@redhat.com,
 peterx@redhat.com
Subject: [PATCH v1 2/2] migration/xbzrle: add encoding rate
Date: Mon, 20 Apr 2020 11:06:43 +0800
Message-Id: <1587352003-3312-3-git-send-email-wei.w.wang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587352003-3312-1-git-send-email-wei.w.wang@intel.com>
References: <1587352003-3312-1-git-send-email-wei.w.wang@intel.com>
Received-SPF: pass client-ip=134.134.136.24; envelope-from=wei.w.wang@intel.com;
 helo=mga09.intel.com
X-detected-operating-system: by eggs1p.gnu.org: First seen = 2020/04/20
 00:00:54
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Received-From: 134.134.136.24
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
Cc: gloryxiao@tencent.com, kevin.tian@intel.com, wei.w.wang@intel.com,
 yi.y.sun@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Users may need to check the xbzrle encoding rate to know if the guest
memory is xbzrle encoding-friendly, and dynamically turn off the
encoding if the encoding rate is low.

Signed-off-by: Yi Sun <yi.y.sun@intel.com>
Signed-off-by: Wei Wang <wei.w.wang@intel.com>
---
 migration/migration.c |  1 +
 migration/ram.c       | 31 +++++++++++++++++++++++++++++--
 monitor/hmp-cmds.c    |  2 ++
 qapi/migration.json   |  5 ++++-
 slirp                 |  2 +-
 5 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 8e7ee0d76b..84a556a4ac 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -930,6 +930,7 @@ static void populate_ram_info(MigrationInfo *info, MigrationState *s)
         info->xbzrle_cache->pages = xbzrle_counters.pages;
         info->xbzrle_cache->cache_miss = xbzrle_counters.cache_miss;
         info->xbzrle_cache->cache_miss_rate = xbzrle_counters.cache_miss_rate;
+        info->xbzrle_cache->encoding_rate = xbzrle_counters.encoding_rate;
         info->xbzrle_cache->overflow = xbzrle_counters.overflow;
     }
 
diff --git a/migration/ram.c b/migration/ram.c
index bca5878f25..c87c38ec80 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -327,6 +327,10 @@ struct RAMState {
     uint64_t num_dirty_pages_period;
     /* xbzrle misses since the beginning of the period */
     uint64_t xbzrle_cache_miss_prev;
+    /* Amount of xbzrle pages since the beginning of the period */
+    uint64_t xbzrle_pages_prev;
+    /* Amount of encoded bytes since the beginning of the period */
+    uint64_t encoded_size_prev;
 
     /* compression statistics since the beginning of the period */
     /* amount of count that no free thread to compress data */
@@ -696,6 +700,18 @@ static int save_xbzrle_page(RAMState *rs, uint8_t **current_data,
         return -1;
     }
 
+    /*
+     * Reaching here means the page has hit the xbzrle cache, no matter what
+     * encoding result it is (normal encoding, overflow or skipping the page),
+     * count the page as encoded. This is used to caculate the encoding rate.
+     *
+     * Example: 2 pages (8KB) being encoded, first page encoding generates 2KB,
+     * 2nd page turns out to be skipped (i.e. no new bytes written to the
+     * page), the overall encoding rate will be 8KB / 2KB = 4, which has the
+     * skipped page included. In this way, the encoding rate can tell if the
+     * guest page is good for xbzrle encoding.
+     */
+    xbzrle_counters.pages++;
     prev_cached_page = get_cached_data(XBZRLE.cache, current_addr);
 
     /* save current buffer into memory */
@@ -736,7 +752,6 @@ static int save_xbzrle_page(RAMState *rs, uint8_t **current_data,
     qemu_put_be16(rs->f, encoded_size);
     qemu_put_buffer(rs->f, XBZRLE.encoded_buf, encoded_size);
     bytes_xbzrle += encoded_size + 1 + 2;
-    xbzrle_counters.pages++;
     xbzrle_counters.encoded_size += encoded_size;
     ram_counters.transferred += bytes_xbzrle;
 
@@ -859,7 +874,7 @@ uint64_t ram_get_total_transferred_pages(void)
 static void migration_update_rates(RAMState *rs, int64_t end_time)
 {
     uint64_t page_count = rs->target_page_count - rs->target_page_count_prev;
-    double compressed_size;
+    double compressed_size, encoded_size, unencoded_size;
 
     /* calculate period counters */
     ram_counters.dirty_pages_rate = rs->num_dirty_pages_period * 1000
@@ -873,6 +888,18 @@ static void migration_update_rates(RAMState *rs, int64_t end_time)
         xbzrle_counters.cache_miss_rate = (double)(xbzrle_counters.cache_miss -
             rs->xbzrle_cache_miss_prev) / page_count;
         rs->xbzrle_cache_miss_prev = xbzrle_counters.cache_miss;
+        unencoded_size = (xbzrle_counters.pages - rs->xbzrle_pages_prev) *
+                         TARGET_PAGE_SIZE;
+        encoded_size = xbzrle_counters.encoded_size - rs->encoded_size_prev;
+        if (xbzrle_counters.pages == rs->xbzrle_pages_prev) {
+            xbzrle_counters.encoding_rate = 0;
+        } else if (!encoded_size) {
+            xbzrle_counters.encoding_rate = UINT64_MAX;
+        } else {
+            xbzrle_counters.encoding_rate = unencoded_size / encoded_size;
+        }
+        rs->xbzrle_pages_prev = xbzrle_counters.pages;
+        rs->encoded_size_prev = xbzrle_counters.encoded_size;
     }
 
     if (migrate_use_compression()) {
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index 6d3b35ca64..07f41e582f 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -303,6 +303,8 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdict)
                        info->xbzrle_cache->cache_miss);
         monitor_printf(mon, "xbzrle cache miss rate: %0.2f\n",
                        info->xbzrle_cache->cache_miss_rate);
+        monitor_printf(mon, "xbzrle encoding rate: %0.2f\n",
+                       info->xbzrle_cache->encoding_rate);
         monitor_printf(mon, "xbzrle overflow: %" PRIu64 "\n",
                        info->xbzrle_cache->overflow);
     }
diff --git a/qapi/migration.json b/qapi/migration.json
index bf195ff6ac..ee4513c565 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -70,6 +70,8 @@
 #
 # @cache-miss-rate: rate of cache miss (since 2.1)
 #
+# @encoding-rate: rate of cache miss
+#
 # @overflow: number of overflows
 #
 # Since: 1.2
@@ -77,7 +79,7 @@
 { 'struct': 'XBZRLECacheStats',
   'data': {'cache-size': 'int', 'encoded_size': 'int', 'pages': 'int',
            'cache-miss': 'int', 'cache-miss-rate': 'number',
-           'overflow': 'int' } }
+           'encoding-rate': 'number', 'overflow': 'int' } }
 
 ##
 # @CompressionStats:
@@ -337,6 +339,7 @@
 #             "pages":2444343,
 #             "cache-miss":2244,
 #             "cache-miss-rate":0.123,
+#             "encoding-rate":80.1,
 #             "overflow":34434
 #          }
 #       }
diff --git a/slirp b/slirp
index 55ab21c9a3..126c04acba 160000
--- a/slirp
+++ b/slirp
@@ -1 +1 @@
-Subproject commit 55ab21c9a36852915b81f1b41ebaf3b6509dd8ba
+Subproject commit 126c04acbabd7ad32c2b018fe10dfac2a3bc1210
-- 
2.20.1


