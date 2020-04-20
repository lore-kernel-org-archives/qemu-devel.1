Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9CFDC3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 04:16:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77FE620661
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 04:16:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77FE620661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQNrB-0001qE-MO
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 00:16:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36592 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wei.w.wang@intel.com>) id 1jQNcH-00075v-DE
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 00:01:06 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <wei.w.wang@intel.com>) id 1jQNcD-0000iJ-GO
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 00:01:05 -0400
Received: from mga09.intel.com ([134.134.136.24]:39949)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1jQNcC-0000cX-UT
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 00:01:01 -0400
IronPort-SDR: mLiZESEn3a88pC5Q5zAkFLL+4hRMxxdkWyEedz3G1AAsrS1tW2TfQu0W2q+tji7q+6fPVOXA+B
 IfAj4n0Qhodw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Apr 2020 21:00:56 -0700
IronPort-SDR: WDCwWHFCDj8FUgWaJzUpOTkebNmdaBqQvGIR/0IfZhkMC2PsylCyX8MvreR3PJSlTGDBOjNaEQ
 Lq62jRx5cirQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,405,1580803200"; d="scan'208";a="333790702"
Received: from unknown (HELO devel-ww.sh.intel.com) ([10.239.48.118])
 by orsmga001.jf.intel.com with ESMTP; 19 Apr 2020 21:00:54 -0700
From: Wei Wang <wei.w.wang@intel.com>
To: qemu-devel@nongnu.org, quintela@redhat.com, dgilbert@redhat.com,
 peterx@redhat.com
Subject: [PATCH v1 1/2] migration/xbzrle: replace transferred xbzrle bytes
 with encoded bytes
Date: Mon, 20 Apr 2020 11:06:42 +0800
Message-Id: <1587352003-3312-2-git-send-email-wei.w.wang@intel.com>
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

Like compressed_size which indicates how many bytes are compressed, we
need encoded_size to understand how many bytes are encoded with xbzrle
during migration.

Replace the old xbzrle_counter.bytes, instead of adding a new counter,
because we don't find a usage of xbzrle_counter.bytes currently, which
includes 3 more bytes of the migration transfer protocol header (in
addition to the encoding header). The encoded_size will further be used
to calculate the encoding rate.

Signed-off-by: Yi Sun <yi.y.sun@intel.com>
Signed-off-by: Wei Wang <wei.w.wang@intel.com>
---
 migration/migration.c |  2 +-
 migration/ram.c       | 18 +++++++++---------
 monitor/hmp-cmds.c    |  4 ++--
 qapi/migration.json   |  6 +++---
 4 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 187ac0410c..8e7ee0d76b 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -926,7 +926,7 @@ static void populate_ram_info(MigrationInfo *info, MigrationState *s)
         info->has_xbzrle_cache = true;
         info->xbzrle_cache = g_malloc0(sizeof(*info->xbzrle_cache));
         info->xbzrle_cache->cache_size = migrate_xbzrle_cache_size();
-        info->xbzrle_cache->bytes = xbzrle_counters.bytes;
+        info->xbzrle_cache->encoded_size = xbzrle_counters.encoded_size;
         info->xbzrle_cache->pages = xbzrle_counters.pages;
         info->xbzrle_cache->cache_miss = xbzrle_counters.cache_miss;
         info->xbzrle_cache->cache_miss_rate = xbzrle_counters.cache_miss_rate;
diff --git a/migration/ram.c b/migration/ram.c
index 04f13feb2e..bca5878f25 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -677,7 +677,7 @@ static int save_xbzrle_page(RAMState *rs, uint8_t **current_data,
                             ram_addr_t current_addr, RAMBlock *block,
                             ram_addr_t offset, bool last_stage)
 {
-    int encoded_len = 0, bytes_xbzrle;
+    int encoded_size = 0, bytes_xbzrle;
     uint8_t *prev_cached_page;
 
     if (!cache_is_cached(XBZRLE.cache, current_addr,
@@ -702,7 +702,7 @@ static int save_xbzrle_page(RAMState *rs, uint8_t **current_data,
     memcpy(XBZRLE.current_buf, *current_data, TARGET_PAGE_SIZE);
 
     /* XBZRLE encoding (if there is no overflow) */
-    encoded_len = xbzrle_encode_buffer(prev_cached_page, XBZRLE.current_buf,
+    encoded_size = xbzrle_encode_buffer(prev_cached_page, XBZRLE.current_buf,
                                        TARGET_PAGE_SIZE, XBZRLE.encoded_buf,
                                        TARGET_PAGE_SIZE);
 
@@ -710,7 +710,7 @@ static int save_xbzrle_page(RAMState *rs, uint8_t **current_data,
      * Update the cache contents, so that it corresponds to the data
      * sent, in all cases except where we skip the page.
      */
-    if (!last_stage && encoded_len != 0) {
+    if (!last_stage && encoded_size != 0) {
         memcpy(prev_cached_page, XBZRLE.current_buf, TARGET_PAGE_SIZE);
         /*
          * In the case where we couldn't compress, ensure that the caller
@@ -720,10 +720,10 @@ static int save_xbzrle_page(RAMState *rs, uint8_t **current_data,
         *current_data = prev_cached_page;
     }
 
-    if (encoded_len == 0) {
+    if (encoded_size == 0) {
         trace_save_xbzrle_page_skipping();
         return 0;
-    } else if (encoded_len == -1) {
+    } else if (encoded_size == -1) {
         trace_save_xbzrle_page_overflow();
         xbzrle_counters.overflow++;
         return -1;
@@ -733,11 +733,11 @@ static int save_xbzrle_page(RAMState *rs, uint8_t **current_data,
     bytes_xbzrle = save_page_header(rs, rs->f, block,
                                     offset | RAM_SAVE_FLAG_XBZRLE);
     qemu_put_byte(rs->f, ENCODING_FLAG_XBZRLE);
-    qemu_put_be16(rs->f, encoded_len);
-    qemu_put_buffer(rs->f, XBZRLE.encoded_buf, encoded_len);
-    bytes_xbzrle += encoded_len + 1 + 2;
+    qemu_put_be16(rs->f, encoded_size);
+    qemu_put_buffer(rs->f, XBZRLE.encoded_buf, encoded_size);
+    bytes_xbzrle += encoded_size + 1 + 2;
     xbzrle_counters.pages++;
-    xbzrle_counters.bytes += bytes_xbzrle;
+    xbzrle_counters.encoded_size += encoded_size;
     ram_counters.transferred += bytes_xbzrle;
 
     return 1;
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index 9b94e67879..6d3b35ca64 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -295,8 +295,8 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdict)
     if (info->has_xbzrle_cache) {
         monitor_printf(mon, "cache size: %" PRIu64 " bytes\n",
                        info->xbzrle_cache->cache_size);
-        monitor_printf(mon, "xbzrle transferred: %" PRIu64 " kbytes\n",
-                       info->xbzrle_cache->bytes >> 10);
+        monitor_printf(mon, "xbzrle encoded size: %" PRIu64 " kbytes\n",
+                       info->xbzrle_cache->encoded_size >> 10);
         monitor_printf(mon, "xbzrle pages: %" PRIu64 " pages\n",
                        info->xbzrle_cache->pages);
         monitor_printf(mon, "xbzrle cache miss: %" PRIu64 "\n",
diff --git a/qapi/migration.json b/qapi/migration.json
index eca2981d0a..bf195ff6ac 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -62,7 +62,7 @@
 #
 # @cache-size: XBZRLE cache size
 #
-# @bytes: amount of bytes already transferred to the target VM
+# @encoded_size: amount of bytes encoded
 #
 # @pages: amount of pages transferred to the target VM
 #
@@ -75,7 +75,7 @@
 # Since: 1.2
 ##
 { 'struct': 'XBZRLECacheStats',
-  'data': {'cache-size': 'int', 'bytes': 'int', 'pages': 'int',
+  'data': {'cache-size': 'int', 'encoded_size': 'int', 'pages': 'int',
            'cache-miss': 'int', 'cache-miss-rate': 'number',
            'overflow': 'int' } }
 
@@ -333,7 +333,7 @@
 #          },
 #          "xbzrle-cache":{
 #             "cache-size":67108864,
-#             "bytes":20971520,
+#             "encoded_size":20971520,
 #             "pages":2444343,
 #             "cache-miss":2244,
 #             "cache-miss-rate":0.123,
-- 
2.20.1


