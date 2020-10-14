Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,FROM_WSP_TRAIL,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18844C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 07:35:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E11720878
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 07:35:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E11720878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSbJU-0006cr-FB
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 03:35:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50956)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1kSbDE-0007xe-Fk
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 03:28:40 -0400
Received: from mga05.intel.com ([192.55.52.43]:54365)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1kSbDC-00041U-0g
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 03:28:40 -0400
IronPort-SDR: ppkB0OOm7j+WctjkesFiUVPON26CJfEvY14U/TL0Yq3j1BlXGGESLQHACsmQ95Mln4bBNl0ofm
 NODCb1WPNkqg==
X-IronPort-AV: E=McAfee;i="6000,8403,9773"; a="250751939"
X-IronPort-AV: E=Sophos;i="5.77,374,1596524400"; d="scan'208";a="250751939"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2020 00:28:36 -0700
IronPort-SDR: D3UsL91e682iarRxpFAnUnvaxGEXNJfV6Zqef5CwEAFx3tF8SoiskQ0xnWNMLiZ/R1WzmipNlz
 ROUexMQJRQww==
X-IronPort-AV: E=Sophos;i="5.77,374,1596524400"; d="scan'208";a="521323068"
Received: from unknown (HELO localhost.localdomain) ([10.239.13.19])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2020 00:28:34 -0700
From: Zhang Chen <chen.zhang@intel.com >
To: Jason Wang <jasowang@redhat.com>,
	qemu-dev <qemu-devel@nongnu.org>
Subject: [PATCH 09/10] net/colo-compare.c: Add secondary old packet detection
Date: Wed, 14 Oct 2020 15:25:55 +0800
Message-Id: <20201014072555.12515-10-chen.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201014072555.12515-1-chen.zhang@intel.com>
References: <20201014072555.12515-1-chen.zhang@intel.com>
Received-SPF: pass client-ip=192.55.52.43; envelope-from=chen.zhang@intel.com;
 helo=mga05.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 03:28:22
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, FROM_ADDR_WS=2.999,
 FROM_WSP_TRAIL=2.199, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Zhang Chen <chen.zhang@intel.com>, Zhang Chen <zhangckid@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Zhang Chen <chen.zhang@intel.com>

Detect queued secondary packet to sync VM state in time.

Signed-off-by: Zhang Chen <chen.zhang@intel.com>
Reviewed-by: Li Zhijian <lizhijian@cn.fujitsu.com>
---
 net/colo-compare.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index 61c95fe7e9..c22f2af941 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -635,19 +635,26 @@ void colo_compare_unregister_notifier(Notifier *notify)
 static int colo_old_packet_check_one_conn(Connection *conn,
                                           CompareState *s)
 {
-    GList *result = NULL;
-
-    result = g_queue_find_custom(&conn->primary_list,
-                                 &s->compare_timeout,
-                                 (GCompareFunc)colo_old_packet_check_one);
+    if (!g_queue_is_empty(&conn->primary_list)) {
+        if (g_queue_find_custom(&conn->primary_list,
+                                &s->compare_timeout,
+                                (GCompareFunc)colo_old_packet_check_one))
+            goto out;
+    }
 
-    if (result) {
-        /* Do checkpoint will flush old packet */
-        colo_compare_inconsistency_notify(s);
-        return 0;
+    if (!g_queue_is_empty(&conn->secondary_list)) {
+        if (g_queue_find_custom(&conn->secondary_list,
+                                &s->compare_timeout,
+                                (GCompareFunc)colo_old_packet_check_one))
+            goto out;
     }
 
     return 1;
+
+out:
+    /* Do checkpoint will flush old packet */
+    colo_compare_inconsistency_notify(s);
+    return 0;
 }
 
 /*
-- 
2.17.1


