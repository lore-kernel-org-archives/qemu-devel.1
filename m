Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,FROM_WSP_TRAIL,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89FC9C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 07:31:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA32520878
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 07:31:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA32520878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSbFY-00013x-PC
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 03:31:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50892)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1kSbD4-0007hI-OD
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 03:28:30 -0400
Received: from mga05.intel.com ([192.55.52.43]:54364)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1kSbD2-00040p-KU
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 03:28:30 -0400
IronPort-SDR: ybgreQDChSDv1ASkjJgY2gJC6X7e5XHoeWoqrj/x3Zlt5nUpOVX759ebmc47HwDVwZ/WSbRHbW
 hh8dMP+siIEA==
X-IronPort-AV: E=McAfee;i="6000,8403,9773"; a="250751924"
X-IronPort-AV: E=Sophos;i="5.77,374,1596524400"; d="scan'208";a="250751924"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2020 00:28:27 -0700
IronPort-SDR: 9BMicKigJHIx5iEfBMmltV8bs/HmgMNf3InkqwcOGbqvFUJKReo7V5POT4p151ciDBAFTezqw1
 Y6jsiUXvGHaQ==
X-IronPort-AV: E=Sophos;i="5.77,374,1596524400"; d="scan'208";a="521323038"
Received: from unknown (HELO localhost.localdomain) ([10.239.13.19])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2020 00:28:25 -0700
From: Zhang Chen <chen.zhang@intel.com >
To: Jason Wang <jasowang@redhat.com>,
	qemu-dev <qemu-devel@nongnu.org>
Subject: [PATCH 03/10] Reduce the time of checkpoint for COLO
Date: Wed, 14 Oct 2020 15:25:49 +0800
Message-Id: <20201014072555.12515-4-chen.zhang@intel.com>
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
Cc: Zhang Chen <chen.zhang@intel.com>, "Rao, Lei" <lei.rao@intel.com>,
 Zhang Chen <zhangckid@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Rao, Lei" <lei.rao@intel.com>

we should set ram_bulk_stage to false after ram_state_init,
otherwise the bitmap will be unused in migration_bitmap_find_dirty.
all pages in ram cache will be flushed to the ram of secondary guest
for each checkpoint.

Signed-off-by: leirao <lei.rao@intel.com>
Signed-off-by: Zhang Chen <chen.zhang@intel.com>
Reviewed-by: Li Zhijian <lizhijian@cn.fujitsu.com>
Reviewed-by: Zhang Chen <chen.zhang@intel.com>
---
 migration/ram.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/migration/ram.c b/migration/ram.c
index 433489d633..9cfac3d9ba 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3009,6 +3009,18 @@ static void decompress_data_with_multi_threads(QEMUFile *f,
     qemu_mutex_unlock(&decomp_done_lock);
 }
 
+ /*
+  * we must set ram_bulk_stage to false, otherwise in
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
@@ -3052,7 +3064,7 @@ int colo_init_ram_cache(void)
         }
     }
 
-    ram_state_init(&ram_state);
+    colo_init_ram_state();
     return 0;
 }
 
-- 
2.17.1


