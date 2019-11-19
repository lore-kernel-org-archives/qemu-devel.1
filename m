Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=FROM_WSP_TRAIL,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF99DC432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 12:38:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9C0E222AB
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 12:38:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9C0E222AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX2lq-000512-Rb
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 07:38:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56951)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chen.zhang@intel.com>) id 1iX2l5-0004BN-OS
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 07:37:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chen.zhang@intel.com>) id 1iX2l4-0001KE-H7
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 07:37:27 -0500
Received: from mga11.intel.com ([192.55.52.93]:24785)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <chen.zhang@intel.com>)
 id 1iX2l4-0001JG-A1
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 07:37:26 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 19 Nov 2019 04:37:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,322,1569308400"; d="scan'208";a="237316869"
Received: from unknown (HELO localhost.localdomain) ([10.239.13.19])
 by fmsmga002.fm.intel.com with ESMTP; 19 Nov 2019 04:37:24 -0800
From: Zhang Chen <chen.zhang@intel.com >
To: Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-dev <qemu-devel@nongnu.org>
Subject: [PATCH V3 2/4] net/awd.c: Initailize input/output chardev
Date: Tue, 19 Nov 2019 20:30:14 +0800
Message-Id: <20191119123016.13740-3-chen.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191119123016.13740-1-chen.zhang@intel.com>
References: <20191119123016.13740-1-chen.zhang@intel.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.93
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

Find and check the chardev awd_node and notification_node,
The awd_node used for keep connect with outside(like VM client/other
host/Remote server), and the notification_node used for do some
operation when disconnect event occur.

Signed-off-by: Zhang Chen <chen.zhang@intel.com>
---
 net/awd.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/net/awd.c b/net/awd.c
index d42b4a7372..ad3d39c982 100644
--- a/net/awd.c
+++ b/net/awd.c
@@ -42,6 +42,8 @@ typedef struct AwdState {
     char *opt_script;
     uint32_t pulse_interval;
     uint32_t timeout;
+    CharBackend chr_awd_node;
+    CharBackend chr_notification_node;
     IOThread *iothread;
 } AwdState;
 
@@ -175,9 +177,30 @@ out:
     error_propagate(errp, local_err);
 }
 
+static int find_and_check_chardev(Chardev **chr,
+                                  char *chr_name,
+                                  Error **errp)
+{
+    *chr = qemu_chr_find(chr_name);
+    if (*chr == NULL) {
+        error_setg(errp, "Device '%s' not found",
+                   chr_name);
+        return 1;
+    }
+
+    if (!qemu_chr_has_feature(*chr, QEMU_CHAR_FEATURE_RECONNECTABLE)) {
+        error_setg(errp, "chardev \"%s\" is not reconnectable",
+                   chr_name);
+        return 1;
+    }
+
+    return 0;
+}
+
 static void awd_complete(UserCreatable *uc, Error **errp)
 {
     AwdState *s = AWD(uc);
+    Chardev *chr;
 
     if (!s->awd_node || !s->iothread ||
         !s->notification_node || !s->opt_script) {
@@ -187,6 +210,20 @@ static void awd_complete(UserCreatable *uc, Error **errp)
         return;
     }
 
+    if (find_and_check_chardev(&chr, s->awd_node, errp) ||
+        !qemu_chr_fe_init(&s->chr_awd_node, chr, errp)) {
+        error_setg(errp, "advanced-watchdog can't find chardev awd_node: %s",
+                   s->awd_node);
+        return;
+    }
+
+    if (find_and_check_chardev(&chr, s->notification_node, errp) ||
+        !qemu_chr_fe_init(&s->chr_notification_node, chr, errp)) {
+        error_setg(errp, "advanced-watchdog can't find "
+                   "chardev notification_node: %s", s->notification_node);
+        return;
+    }
+
     return;
 }
 
-- 
2.17.1


