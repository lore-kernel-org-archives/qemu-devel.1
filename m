Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,FROM_WSP_TRAIL,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B431DC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 05:57:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 248A0207DE
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 05:57:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 248A0207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTIkY-0002cD-3E
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 01:57:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44050)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1kTIhS-0006Hw-95
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 01:54:46 -0400
Received: from mga01.intel.com ([192.55.52.88]:36621)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1kTIhQ-0005D7-Hq
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 01:54:45 -0400
IronPort-SDR: EiLeu08svaTKttaWpyXwZNQbWs7BPUpReZW7U1XsEZshl2qkNiM0EjJSpx7CzMJgg/U2MXIpOF
 h5CGBlXxH76w==
X-IronPort-AV: E=McAfee;i="6000,8403,9775"; a="184094650"
X-IronPort-AV: E=Sophos;i="5.77,381,1596524400"; d="scan'208";a="184094650"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2020 22:54:41 -0700
IronPort-SDR: o2vAq4Oy1hUXMqKwecjIGye4ios++jGlaZmqHk3fD1FAMf03KhgYOTtoFpnJB8NaYrf7yaJdg3
 nnmuRZpqlRyA==
X-IronPort-AV: E=Sophos;i="5.77,381,1596524400"; d="scan'208";a="464572818"
Received: from unknown (HELO localhost.localdomain) ([10.239.13.19])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2020 22:54:40 -0700
From: Zhang Chen <chen.zhang@intel.com >
To: Jason Wang <jasowang@redhat.com>,
	qemu-dev <qemu-devel@nongnu.org>
Subject: [PATCH V2 03/10] Reduce the time of checkpoint for COLO
Date: Fri, 16 Oct 2020 13:52:01 +0800
Message-Id: <20201016055208.7969-4-chen.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201016055208.7969-1-chen.zhang@intel.com>
References: <20201016055208.7969-1-chen.zhang@intel.com>
Received-SPF: pass client-ip=192.55.52.88; envelope-from=chen.zhang@intel.com;
 helo=mga01.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/16 01:54:36
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, FROM_ADDR_WS=2.996,
 FROM_WSP_TRAIL=1, HEADER_FROM_DIFFERENT_DOMAINS=0.248, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Derek Su <dereksu@qnap.com>, Zhang Chen <chen.zhang@intel.com>, "Rao,
 Lei" <lei.rao@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Zhang Chen <zhangckid@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Rao, Lei" <lei.rao@intel.com>

we should set ram_bulk_stage to false after ram_state_init,
otherwise the bitmap will be unused in migration_bitmap_find_dirty.
all pages in ram cache will be flushed to the ram of secondary guest
for each checkpoint.

Signed-off-by: Lei Rao <lei.rao@intel.com>
Signed-off-by: Derek Su <dereksu@qnap.com>
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


