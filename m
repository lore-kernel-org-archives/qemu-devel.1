Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26BB7C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 18:43:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E11A21532
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 18:43:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PX+dBLXj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E11A21532
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jld1o-0002bw-SU
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 14:43:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51698)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jlcwx-0004DC-Ar
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 14:38:15 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:60732
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jlcwv-0008Bf-0A
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 14:38:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592419092;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1T2hRnHo2ZQkp6yhb7Dn8+feROfOWRPY4/N/6N5P/ug=;
 b=PX+dBLXjg5x0U5lUAi4apvnw/MXjYZBteEMtfVF+Nketm62cA41MDP4TjYuzI0HXaF0o+O
 AyhQpHB+1qctiF6ZmcinZ8CLzXU6IubT/tH+qsQA4tNN/1qsUXhV6vh/4+8n90Fw3lM+BN
 YnEyozU+Y3JoJp5fZ+y4EHeVU+UlMRs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-202-BZuqFqsFN6WJn4waTIDKvA-1; Wed, 17 Jun 2020 14:38:09 -0400
X-MC-Unique: BZuqFqsFN6WJn4waTIDKvA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DC14F8035C1;
 Wed, 17 Jun 2020 18:38:08 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-115-47.ams2.redhat.com
 [10.36.115.47])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 367765EE0E;
 Wed, 17 Jun 2020 18:38:07 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, david@redhat.com, lvivier@redhat.com,
 maozhongyi@cmss.chinamobile.com, mreitz@redhat.com, pannengyuan@huawei.com
Subject: [PULL 10/12] monitor/hmp-cmds: improvements for the 'info migrate'
Date: Wed, 17 Jun 2020 19:37:31 +0100
Message-Id: <20200617183733.186168-11-dgilbert@redhat.com>
In-Reply-To: <20200617183733.186168-1-dgilbert@redhat.com>
References: <20200617183733.186168-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 02:02:46
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
Cc: stefanha@redhat.com, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>

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
Message-Id: <20200603080904.997083-8-maozhongyi@cmss.chinamobile.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
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
index 00e3362cb0..2b0b58a336 100644
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
2.26.2


