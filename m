Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04355C76188
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 07:55:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF50421BE6
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 07:55:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF50421BE6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpTA3-0004e7-UZ
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 03:55:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39589)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richardw.yang@linux.intel.com>) id 1hpT9K-0001gA-L0
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 03:54:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richardw.yang@linux.intel.com>) id 1hpT9J-0000yf-Gn
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 03:54:22 -0400
Received: from mga03.intel.com ([134.134.136.65]:6620)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
 id 1hpT9J-0000uj-7o
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 03:54:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 22 Jul 2019 00:54:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,294,1559545200"; d="scan'208";a="188554615"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
 by fmsmga001.fm.intel.com with ESMTP; 22 Jul 2019 00:54:16 -0700
From: Wei Yang <richardw.yang@linux.intel.com>
To: qemu-devel@nongnu.org
Date: Mon, 22 Jul 2019 15:53:39 +0800
Message-Id: <20190722075339.25121-3-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190722075339.25121-1-richardw.yang@linux.intel.com>
References: <20190722075339.25121-1-richardw.yang@linux.intel.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.65
Subject: [Qemu-devel] [PATCH 2/2] migration: extract ram_load_precopy
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
Cc: Wei Yang <richardw.yang@linux.intel.com>, dgilbert@redhat.com,
 quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

After cleanup, it would be clear to audience there are two cases
ram_load:

  * precopy
  * postcopy

And it is not necessary to check postcopy_running on each iteration for
precopy.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 migration/ram.c | 73 +++++++++++++++++++++++++++++++------------------
 1 file changed, 46 insertions(+), 27 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 6bfdfae16e..5f6f07b255 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -4200,40 +4200,26 @@ static void colo_flush_ram_cache(void)
     trace_colo_flush_ram_cache_end();
 }
 
-static int ram_load(QEMUFile *f, void *opaque, int version_id)
+/**
+ * ram_load_precopy: load a page in precopy case
+ *
+ * Returns 0 for success or -errno in case of error
+ *
+ * Called in precopy mode by ram_load().
+ * rcu_read_lock is taken prior to this being called.
+ *
+ * @f: QEMUFile where to send the data
+ */
+static int ram_load_precopy(QEMUFile *f)
 {
-    int flags = 0, ret = 0, invalid_flags = 0;
-    static uint64_t seq_iter;
-    int len = 0;
-    /*
-     * If system is running in postcopy mode, page inserts to host memory must
-     * be atomic
-     */
-    bool postcopy_running = postcopy_is_running();
+    int flags = 0, ret = 0, invalid_flags = 0, len = 0;
     /* ADVISE is earlier, it shows the source has the postcopy capability on */
     bool postcopy_advised = postcopy_is_advised();
-
-    seq_iter++;
-
-    if (version_id != 4) {
-        return -EINVAL;
-    }
-
     if (!migrate_use_compression()) {
         invalid_flags |= RAM_SAVE_FLAG_COMPRESS_PAGE;
     }
-    /* This RCU critical section can be very long running.
-     * When RCU reclaims in the code start to become numerous,
-     * it will be necessary to reduce the granularity of this
-     * critical section.
-     */
-    rcu_read_lock();
-
-    if (postcopy_running) {
-        ret = ram_load_postcopy(f);
-    }
 
-    while (!postcopy_running && !ret && !(flags & RAM_SAVE_FLAG_EOS)) {
+    while (!ret && !(flags & RAM_SAVE_FLAG_EOS)) {
         ram_addr_t addr, total_ram_bytes;
         void *host = NULL;
         uint8_t ch;
@@ -4390,6 +4376,39 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
         }
     }
 
+    return ret;
+}
+
+static int ram_load(QEMUFile *f, void *opaque, int version_id)
+{
+    int ret = 0;
+    static uint64_t seq_iter;
+    /*
+     * If system is running in postcopy mode, page inserts to host memory must
+     * be atomic
+     */
+    bool postcopy_running = postcopy_is_running();
+
+    seq_iter++;
+
+    if (version_id != 4) {
+        return -EINVAL;
+    }
+
+    /*
+     * This RCU critical section can be very long running.
+     * When RCU reclaims in the code start to become numerous,
+     * it will be necessary to reduce the granularity of this
+     * critical section.
+     */
+    rcu_read_lock();
+
+    if (postcopy_running) {
+        ret = ram_load_postcopy(f);
+    } else {
+        ret = ram_load_precopy(f);
+    }
+
     ret |= wait_for_decompress_done();
     rcu_read_unlock();
     trace_ram_load_complete(ret, seq_iter);
-- 
2.17.1


