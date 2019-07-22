Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=FROM_WSP_TRAIL,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF7BC76190
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 17:23:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 572F9217D4
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 17:23:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 572F9217D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpc2U-0006qB-L7
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 13:23:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49957)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <chen.zhang@intel.com>) id 1hpc2K-0006Rs-8I
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 13:23:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chen.zhang@intel.com>) id 1hpc2J-0002SW-AS
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 13:23:44 -0400
Received: from mga05.intel.com ([192.55.52.43]:26061)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <chen.zhang@intel.com>)
 id 1hpc2I-0002OI-W8
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 13:23:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 22 Jul 2019 10:23:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,295,1559545200"; d="scan'208";a="320745645"
Received: from unknown (HELO localhost.localdomain) ([10.239.13.19])
 by orsmga004.jf.intel.com with ESMTP; 22 Jul 2019 10:23:34 -0700
From: Zhang Chen <chen.zhang@intel.com >
To: Li Zhijian <lizhijian@cn.fujitsu.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 qemu-dev <qemu-devel@nongnu.org>
Date: Tue, 23 Jul 2019 01:18:28 +0800
Message-Id: <20190722171828.11322-1-chen.zhang@intel.com>
X-Mailer: git-send-email 2.17.GIT
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.43
Subject: [Qemu-devel] [PATCH V5] net/colo-compare.c: Fix memory leak and
 code style issue.
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

This patch to fix the origin "char *data" memory leak, code style issue
and add necessary check here.
Reported-by: Coverity (CID 1402785)

Signed-off-by: Zhang Chen <chen.zhang@intel.com>
---
 net/colo-compare.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index 909dd6c6eb..7489840bde 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -127,6 +127,17 @@ static int compare_chr_send(CompareState *s,
                             uint32_t vnet_hdr_len,
                             bool notify_remote_frame);
 
+static bool packet_matches_str(const char *str,
+                               const uint8_t *buf,
+                               uint32_t packet_len)
+{
+    if (packet_len != strlen(str)) {
+        return false;
+    }
+
+    return !memcmp(str, buf, strlen(str));
+}
+
 static void notify_remote_frame(CompareState *s)
 {
     char msg[] = "DO_CHECKPOINT";
@@ -1008,21 +1019,23 @@ static void compare_notify_rs_finalize(SocketReadState *notify_rs)
 {
     CompareState *s = container_of(notify_rs, CompareState, notify_rs);
 
-    /* Get Xen colo-frame's notify and handle the message */
-    char *data = g_memdup(notify_rs->buf, notify_rs->packet_len);
-    char msg[] = "COLO_COMPARE_GET_XEN_INIT";
+    const char msg[] = "COLO_COMPARE_GET_XEN_INIT";
     int ret;
 
-    if (!strcmp(data, "COLO_USERSPACE_PROXY_INIT")) {
+    if (packet_matches_str("COLO_USERSPACE_PROXY_INIT",
+                           notify_rs->buf,
+                           notify_rs->packet_len)) {
         ret = compare_chr_send(s, (uint8_t *)msg, strlen(msg), 0, true);
         if (ret < 0) {
             error_report("Notify Xen COLO-frame INIT failed");
         }
-    }
-
-    if (!strcmp(data, "COLO_CHECKPOINT")) {
+    } else if (packet_matches_str("COLO_CHECKPOINT",
+                                  notify_rs->buf,
+                                  notify_rs->packet_len)) {
         /* colo-compare do checkpoint, flush pri packet and remove sec packet */
         g_queue_foreach(&s->conn_list, colo_flush_packets, s);
+    } else {
+        error_report("COLO compare got unsupported instruction");
     }
 }
 
-- 
2.17.GIT


