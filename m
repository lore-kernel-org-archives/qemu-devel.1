Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=FROM_WSP_TRAIL,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A2A5C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 12:40:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3B9E21D7B
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 12:40:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3B9E21D7B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX2oM-00084z-67
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 07:40:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56989)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chen.zhang@intel.com>) id 1iX2l8-0004DX-IN
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 07:37:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chen.zhang@intel.com>) id 1iX2l7-0001LY-70
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 07:37:30 -0500
Received: from mga11.intel.com ([192.55.52.93]:24785)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <chen.zhang@intel.com>)
 id 1iX2l6-0001JG-Sz
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 07:37:29 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 19 Nov 2019 04:37:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,322,1569308400"; d="scan'208";a="237316882"
Received: from unknown (HELO localhost.localdomain) ([10.239.13.19])
 by fmsmga002.fm.intel.com with ESMTP; 19 Nov 2019 04:37:27 -0800
From: Zhang Chen <chen.zhang@intel.com >
To: Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-dev <qemu-devel@nongnu.org>
Subject: [PATCH V3 4/4] vl.c: Make Advanced Watch Dog delayed initialization
Date: Tue, 19 Nov 2019 20:30:16 +0800
Message-Id: <20191119123016.13740-5-chen.zhang@intel.com>
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

Advanced Watch Dog module needs chardev socket
to initialize properly before running.

Signed-off-by: Zhang Chen <chen.zhang@intel.com>
---
 vl.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/vl.c b/vl.c
index 6a65a64bfd..048fe458b9 100644
--- a/vl.c
+++ b/vl.c
@@ -2689,6 +2689,13 @@ static bool object_create_initial(const char *type, QemuOpts *opts)
         return false;
     }
 
+    /*
+     * Reason: Advanced Watch Dog property "chardev".
+     */
+    if (g_str_equal(type, "advanced-watchdog")) {
+        return false;
+    }
+
     /* Memory allocation by backends needs to be done
      * after configure_accelerator() (due to the tcg_enabled()
      * checks at memory_region_init_*()).
-- 
2.17.1


