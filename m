Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B69C2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 09:46:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E7502145D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 09:46:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E7502145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKesU-0003il-Fe
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 05:46:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42350)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lei.rao@intel.com>) id 1kKeof-00085g-3T
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 05:42:29 -0400
Received: from mga11.intel.com ([192.55.52.93]:64260)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lei.rao@intel.com>) id 1kKeod-0008QL-A8
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 05:42:28 -0400
IronPort-SDR: mggVKMBtr8PgRgvSyBpdo7zltvAm8+APlzTLgOZlZAZaeGonvALpFbdCoLet/K/9S6iImUx1ml
 4NebgPAB3uAw==
X-IronPort-AV: E=McAfee;i="6000,8403,9751"; a="157947014"
X-IronPort-AV: E=Sophos;i="5.77,290,1596524400"; d="scan'208";a="157947014"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2020 02:42:25 -0700
IronPort-SDR: A4K+Odw0I/qaTsshUZePnEaQAYkuyRW4UAoEHmzZq63moPHdCUqyBjxpY666IGkG+gRRGQdGt9
 QWxBi3cfNmYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,290,1596524400"; d="scan'208";a="348424035"
Received: from unknown (HELO localhost.localdomain.bj.intel.com)
 ([10.240.192.103])
 by orsmga007.jf.intel.com with ESMTP; 22 Sep 2020 02:42:23 -0700
From: leirao <lei.rao@intel.com>
To: chen.zhang@intel.com, lizhijian@cn.fujitsu.com, jasowang@redhat.com,
 quintela@redhat.com, dgilbert@redhat.com, pbonzini@redhat.com
Subject: [PATCH v2 2/3] Reduce the time of checkpoint for COLO
Date: Tue, 22 Sep 2020 05:24:49 -0400
Message-Id: <1600766690-94980-3-git-send-email-lei.rao@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1600766690-94980-1-git-send-email-lei.rao@intel.com>
References: <1600766690-94980-1-git-send-email-lei.rao@intel.com>
Received-SPF: pass client-ip=192.55.52.93; envelope-from=lei.rao@intel.com;
 helo=mga11.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 05:42:20
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: leirao <lei.rao@intel.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

we should set ram_bulk_stage to false after ram_state_init,
otherwise the bitmap will be unused in migration_bitmap_find_dirty.
all pages in ram cache will be flushed to the ram of secondary guest
for each checkpoint.

Signed-off-by: leirao <lei.rao@intel.com>
---
 migration/ram.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/migration/ram.c b/migration/ram.c
index 76d4fee..59ff0cf 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3018,6 +3018,18 @@ static void decompress_data_with_multi_threads(QEMUFile *f,
     qemu_mutex_unlock(&decomp_done_lock);
 }
 
+ /*
+  * we must set ram_bulk_stage to fasle, otherwise in
+  * migation_bitmap_find_dirty the bitmap will be unused and
+  * all the pages in ram cache wil be flushed to the ram of
+  * secondary VM.
+  */
+static void colo_init_ram_state(void)
+{
+    ram_state_init(&ram_state);
+    ram_state->ram_bulk_stage = false;
+}
+
 /*
  * colo cache: this is for secondary VM, we cache the whole
  * memory of the secondary VM, it is need to hold the global lock
@@ -3061,7 +3073,7 @@ int colo_init_ram_cache(void)
         }
     }
 
-    ram_state_init(&ram_state);
+    colo_init_ram_state();
     return 0;
 }
 
-- 
1.8.3.1


