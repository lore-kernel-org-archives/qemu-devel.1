Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=FROM_WSP_TRAIL,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89FDEFA372A
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 11:30:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15DC92067B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 11:30:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15DC92067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKhV9-0001v4-TX
	for qemu-devel@archiver.kernel.org; Wed, 16 Oct 2019 07:29:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42667)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chen.zhang@intel.com>) id 1iKhUA-00010P-L2
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 07:28:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chen.zhang@intel.com>) id 1iKhU9-0005P1-9p
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 07:28:58 -0400
Received: from mga07.intel.com ([134.134.136.100]:55310)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <chen.zhang@intel.com>)
 id 1iKhU9-0005O1-1K
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 07:28:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 16 Oct 2019 04:28:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,303,1566889200"; d="scan'208";a="208393379"
Received: from unknown (HELO localhost.localdomain) ([10.239.13.19])
 by fmsmga001.fm.intel.com with ESMTP; 16 Oct 2019 04:28:52 -0700
From: Zhang Chen <chen.zhang@intel.com >
To: Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-dev <qemu-devel@nongnu.org>
Subject: [RFC PATCH 4/4] vl.c: Make Advanced Watch Dog delayed initialization
Date: Wed, 16 Oct 2019 19:22:09 +0800
Message-Id: <20191016112209.9024-5-chen.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191016112209.9024-1-chen.zhang@intel.com>
References: <20191016112209.9024-1-chen.zhang@intel.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.100
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

Because Advanced Watch Dog module needs chardev socket
to initialize properly before.

Signed-off-by: Zhang Chen <chen.zhang@intel.com>
---
 vl.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/vl.c b/vl.c
index 4489cfb2bb..4094f61d28 100644
--- a/vl.c
+++ b/vl.c
@@ -2683,6 +2683,13 @@ static bool object_create_initial(const char *type, QemuOpts *opts)
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


