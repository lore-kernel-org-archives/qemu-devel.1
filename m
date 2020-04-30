Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A50F1C83000
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 01:54:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77FDD2082E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 01:54:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77FDD2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTyPF-0004f5-Ib
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 21:54:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35622)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wei.w.wang@intel.com>) id 1jTyOg-0004GS-C9
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 21:53:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <wei.w.wang@intel.com>) id 1jTyOe-0007Ex-M3
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 21:53:53 -0400
Received: from mga17.intel.com ([192.55.52.151]:46011)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1jTyOe-0007Ec-4g
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 21:53:52 -0400
IronPort-SDR: a5XSvhW8BczX0FwkNDACqBT9Tu/wp7o6aw5lcfsqogy/3Y8oAsjC4+/QyObkK85Z+3kdoOMpXi
 uNGmVpS83RAQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2020 18:53:43 -0700
IronPort-SDR: E0nw1rKUWXwuIfqqP5uib1vp6j7gsMEBTaq1rbIoYmoa0chLAx1t3KGHsROmqKutQCFsxu5jwB
 JuFfLRE9goVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,333,1583222400"; d="scan'208";a="459397216"
Received: from devel-ww.sh.intel.com ([10.239.48.118])
 by fmsmga005.fm.intel.com with ESMTP; 29 Apr 2020 18:53:41 -0700
From: Wei Wang <wei.w.wang@intel.com>
To: qemu-devel@nongnu.org, quintela@redhat.com, dgilbert@redhat.com,
 peterx@redhat.com
Subject: [PATCH v3] migration/xbzrle: add encoding rate
Date: Thu, 30 Apr 2020 08:59:35 +0800
Message-Id: <1588208375-19556-1-git-send-email-wei.w.wang@intel.com>
X-Mailer: git-send-email 2.7.4
Received-SPF: pass client-ip=192.55.52.151; envelope-from=wei.w.wang@intel.com;
 helo=mga17.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 21:53:44
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Received-From: 192.55.52.151
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
 migration/ram.c       | 39 +++++++++++++++++++++++++++++++++++++--
 monitor/hmp-cmds.c    |  2 ++
 qapi/migration.json   |  5 ++++-
 4 files changed, 44 insertions(+), 3 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 187ac0410c..e40421353c 100644
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
index 04f13feb2e..41b75a0a0f 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -327,6 +327,10 @@ struct RAMState {
     uint64_t num_dirty_pages_period;
     /* xbzrle misses since the beginning of the period */
     uint64_t xbzrle_cache_miss_prev;
+    /* Amount of xbzrle pages since the beginning of the period */
+    uint64_t xbzrle_pages_prev;
+    /* Amount of xbzrle encoded bytes since the beginning of the period */
+    uint64_t xbzrle_bytes_prev;
 
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
@@ -726,6 +742,7 @@ static int save_xbzrle_page(RAMState *rs, uint8_t **current_data,
     } else if (encoded_len == -1) {
         trace_save_xbzrle_page_overflow();
         xbzrle_counters.overflow++;
+        xbzrle_counters.bytes += TARGET_PAGE_SIZE;
         return -1;
     }
 
@@ -736,8 +753,12 @@ static int save_xbzrle_page(RAMState *rs, uint8_t **current_data,
     qemu_put_be16(rs->f, encoded_len);
     qemu_put_buffer(rs->f, XBZRLE.encoded_buf, encoded_len);
     bytes_xbzrle += encoded_len + 1 + 2;
-    xbzrle_counters.pages++;
-    xbzrle_counters.bytes += bytes_xbzrle;
+    /*
+     * Like compressed_size (please see update_compress_thread_counts),
+     * the xbzrle encoded bytes don't count the 8 byte header with
+     * RAM_SAVE_FLAG_CONTINUE.
+     */
+    xbzrle_counters.bytes += bytes_xbzrle - 8;
     ram_counters.transferred += bytes_xbzrle;
 
     return 1;
@@ -870,9 +891,23 @@ static void migration_update_rates(RAMState *rs, int64_t end_time)
     }
 
     if (migrate_use_xbzrle()) {
+        double encoded_size, unencoded_size;
+
         xbzrle_counters.cache_miss_rate = (double)(xbzrle_counters.cache_miss -
             rs->xbzrle_cache_miss_prev) / page_count;
         rs->xbzrle_cache_miss_prev = xbzrle_counters.cache_miss;
+        unencoded_size = (xbzrle_counters.pages - rs->xbzrle_pages_prev) *
+                         TARGET_PAGE_SIZE;
+        encoded_size = xbzrle_counters.bytes - rs->xbzrle_bytes_prev;
+        if (xbzrle_counters.pages == rs->xbzrle_pages_prev) {
+            xbzrle_counters.encoding_rate = 0;
+        } else if (!encoded_size) {
+            xbzrle_counters.encoding_rate = UINT64_MAX;
+        } else {
+            xbzrle_counters.encoding_rate = unencoded_size / encoded_size;
+        }
+        rs->xbzrle_pages_prev = xbzrle_counters.pages;
+        rs->xbzrle_bytes_prev = xbzrle_counters.bytes;
     }
 
     if (migrate_use_compression()) {
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index 9b94e67879..c2a3a667ae 100644
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
index eca2981d0a..358e40226d 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -70,6 +70,8 @@
 #
 # @cache-miss-rate: rate of cache miss (since 2.1)
 #
+# @encoding-rate: rate of encoded bytes (since 5.1)
+#
 # @overflow: number of overflows
 #
 # Since: 1.2
@@ -77,7 +79,7 @@
 { 'struct': 'XBZRLECacheStats',
   'data': {'cache-size': 'int', 'bytes': 'int', 'pages': 'int',
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
-- 
2.20.1


