Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABFB0C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 08:11:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82ABC2067B
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 08:11:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82ABC2067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgOUF-0002V0-Pm
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 04:10:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39554)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maozhongyi@cmss.chinamobile.com>)
 id 1jgOTF-0000Z2-9K
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 04:09:57 -0400
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:3997)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maozhongyi@cmss.chinamobile.com>) id 1jgOTD-0000Dg-VK
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 04:09:57 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.15]) by
 rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee15ed75ab66af-8ada2;
 Wed, 03 Jun 2020 16:09:26 +0800 (CST)
X-RM-TRANSID: 2ee15ed75ab66af-8ada2
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.25.154.146])
 by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee85ed75aae43e-61025;
 Wed, 03 Jun 2020 16:09:26 +0800 (CST)
X-RM-TRANSID: 2ee85ed75aae43e-61025
From: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 7/9] monitor/hmp-cmds: improvements for the 'info migrate'
Date: Wed,  3 Jun 2020 16:09:02 +0800
Message-Id: <20200603080904.997083-8-maozhongyi@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200603080904.997083-1-maozhongyi@cmss.chinamobile.com>
References: <20200603080904.997083-1-maozhongyi@cmss.chinamobile.com>
Received-SPF: pass client-ip=221.176.66.79;
 envelope-from=maozhongyi@cmss.chinamobile.com; helo=cmccmta1.chinamobile.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/03 04:09:40
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
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
Cc: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When running:

(qemu) info migrate
globals:
store-global-state: on
only-migratable: off
...
xbzrle transferred: 640892 kbytes
xbzrle pages: 16645936 pages
xbzrle cache miss: 1525426
xbzrle cache miss rate: 0.09
xbzrle encoding rate: 91.42
xbzrle overflow: 40896
...
compression pages: 377710 pages
compression busy: 0
compression busy rate: 0.00
compressed size: 463169457
compression rate: 3.33

Add units for 'xbzrle cache miss' and 'compressed size',
make it easier to read.

Suggested-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
---
 docs/xbzrle.txt    | 2 +-
 monitor/hmp-cmds.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/docs/xbzrle.txt b/docs/xbzrle.txt
index b431bdaf0f..385b4993f8 100644
--- a/docs/xbzrle.txt
+++ b/docs/xbzrle.txt
@@ -112,7 +112,7 @@ is recommended.
     cache size: H bytes
     xbzrle transferred: I kbytes
     xbzrle pages: J pages
-    xbzrle cache miss: K
+    xbzrle cache miss: K pages
     xbzrle overflow: L
 
 xbzrle cache-miss: the number of cache misses to date - high cache-miss rate
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index e8cf72eb3a..24f3e8e44d 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -299,7 +299,7 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdict)
                        info->xbzrle_cache->bytes >> 10);
         monitor_printf(mon, "xbzrle pages: %" PRIu64 " pages\n",
                        info->xbzrle_cache->pages);
-        monitor_printf(mon, "xbzrle cache miss: %" PRIu64 "\n",
+        monitor_printf(mon, "xbzrle cache miss: %" PRIu64 " pages\n",
                        info->xbzrle_cache->cache_miss);
         monitor_printf(mon, "xbzrle cache miss rate: %0.2f\n",
                        info->xbzrle_cache->cache_miss_rate);
@@ -316,8 +316,8 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdict)
                        info->compression->busy);
         monitor_printf(mon, "compression busy rate: %0.2f\n",
                        info->compression->busy_rate);
-        monitor_printf(mon, "compressed size: %" PRIu64 "\n",
-                       info->compression->compressed_size);
+        monitor_printf(mon, "compressed size: %" PRIu64 " kbytes\n",
+                       info->compression->compressed_size >> 10);
         monitor_printf(mon, "compression rate: %0.2f\n",
                        info->compression->compression_rate);
     }
-- 
2.17.1




