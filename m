Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5911FC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:49:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22F7D2070A
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:49:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="TqT7SBJx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22F7D2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlfw9-0004j3-Bd
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 17:49:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45970)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=430b82a1d=dmitry.fomichev@wdc.com>)
 id 1jlfhh-0003jc-02; Wed, 17 Jun 2020 17:34:41 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:29831)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=430b82a1d=dmitry.fomichev@wdc.com>)
 id 1jlfhc-0005By-QC; Wed, 17 Jun 2020 17:34:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1592429676; x=1623965676;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=VW+dI6TvAaMrKKR91glOG79oHU+lmwb39OiAXEN/4fk=;
 b=TqT7SBJxVtcEqPn95bK4p3c+0RYoiKCn32X9rqKF6FubTRoZ86WARHKF
 Vn23ogHj99b73pZtu5Bmzwu+EUfNhZ58hG/S5Z0Z5xE2tC+vczhI5w68Q
 sFePvoZiwCETJ0j99tUsDS6QhDXhVxbxLgPtIimha6JMIWXy29OBVwYA0
 aUZ/kuyfiopOPyYBOSkoG57QJZ1S5p1IIwXsU2onpe9agruDC4XBHRmWE
 LazbRQ1OklmFcgnWpyf4nOkJF10ArVyvo5S916obd3woN7ScLD5okuziI
 5TsPGi2DojEwc0SZpAj3TqXQKZuKPs1gfxzSCLK/P8PA3q1Av6QLhv75o Q==;
IronPort-SDR: LcFcDANmQvIHdO6cRadgp9TNRkXGwY5AGL+EILAerRzou+WJJx6KpB0yaEp/5EBe5KUiywoTfc
 7pec73PpXKWzfMQ/TzPHDCCHj9WFWF+0uTURKSV+iwgK+9MRAFKQBJUfzxBaS1ke5/bU56dfnG
 wHZSQcTxXNzQFJ6656k5NXJbSnAY0W7GWzsLhpna6IiZyWM0gkN1BYvA9Iw1iCaUaB+oluFFF9
 0j23JY8eIrK8ih+Chje1poBnKv2MJ9IzKWcd/nseSeD3qWgXYqCzAkA1p1jxomB5IeI4f6vGC7
 uz4=
X-IronPort-AV: E=Sophos;i="5.73,523,1583164800"; d="scan'208";a="249439792"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 18 Jun 2020 05:34:33 +0800
IronPort-SDR: DE3CKNVxw/HIDJZEAfRfiQzuBXgLzOBZl57R7wQNmxCjQqwFKJZiKuvQ9ioyugZ1oZT0avkfBa
 GhbbyIzhmLne0OWFLSb/o9PF3rE5mkC9o=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2020 14:23:14 -0700
IronPort-SDR: PVyZEXqMhpOlCrTi2nPGHvEkOBSuZj5CskZFLEuomzUdCVbQXApSte5ZFlyYihDHrPjFNwsOWe
 jKJ7L1Wsbj/g==
WDCIronportException: Internal
Received: from unknown (HELO redsun50.ssa.fujisawa.hgst.com) ([10.149.66.24])
 by uls-op-cesaip02.wdc.com with ESMTP; 17 Jun 2020 14:34:31 -0700
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
To: Kevin Wolf <kwolf@redhat.com>, Keith Busch <kbusch@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Maxim Levitsky <mlevitsky@redhat.com>
Subject: [PATCH v2 03/18] hw/block/nvme: Clean up unused AER definitions
Date: Thu, 18 Jun 2020 06:34:00 +0900
Message-Id: <20200617213415.22417-4-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200617213415.22417-1-dmitry.fomichev@wdc.com>
References: <20200617213415.22417-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=430b82a1d=dmitry.fomichev@wdc.com; helo=esa1.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 17:34:28
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Niklas Cassel <niklas.cassel@wdc.com>,
 Damien Le Moal <damien.lemoal@wdc.com>, qemu-block@nongnu.org,
 Dmitry Fomichev <dmitry.fomichev@wdc.com>, qemu-devel@nongnu.org,
 Matias Bjorling <matias.bjorling@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Removed unused struct NvmeAerResult and SMART-related async event
codes. All other event codes are now categorized by their type.
This avoids having to define the same values in a single enum,
NvmeAsyncEventRequest, that is now removed.

Later commits in this series will define additional values in some
of these enums. No functional change.

Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
---
 hw/block/nvme.h      |  1 -
 include/block/nvme.h | 43 ++++++++++++++++++++++---------------------
 2 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index 0460cc0e62..4f0dac39ae 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -13,7 +13,6 @@ typedef struct NvmeParams {
 
 typedef struct NvmeAsyncEvent {
     QSIMPLEQ_ENTRY(NvmeAsyncEvent) entry;
-    NvmeAerResult result;
 } NvmeAsyncEvent;
 
 enum NvmeRequestFlags {
diff --git a/include/block/nvme.h b/include/block/nvme.h
index 9c3a04dcd7..3099df99eb 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -553,28 +553,30 @@ typedef struct NvmeDsmRange {
     uint64_t    slba;
 } NvmeDsmRange;
 
-enum NvmeAsyncEventRequest {
-    NVME_AER_TYPE_ERROR                     = 0,
-    NVME_AER_TYPE_SMART                     = 1,
-    NVME_AER_TYPE_IO_SPECIFIC               = 6,
-    NVME_AER_TYPE_VENDOR_SPECIFIC           = 7,
-    NVME_AER_INFO_ERR_INVALID_SQ            = 0,
-    NVME_AER_INFO_ERR_INVALID_DB            = 1,
-    NVME_AER_INFO_ERR_DIAG_FAIL             = 2,
-    NVME_AER_INFO_ERR_PERS_INTERNAL_ERR     = 3,
-    NVME_AER_INFO_ERR_TRANS_INTERNAL_ERR    = 4,
-    NVME_AER_INFO_ERR_FW_IMG_LOAD_ERR       = 5,
-    NVME_AER_INFO_SMART_RELIABILITY         = 0,
-    NVME_AER_INFO_SMART_TEMP_THRESH         = 1,
-    NVME_AER_INFO_SMART_SPARE_THRESH        = 2,
+enum NvmeAsyncEventType {
+    NVME_AER_TYPE_ERROR                     = 0x00,
+    NVME_AER_TYPE_SMART                     = 0x01,
+    NVME_AER_TYPE_NOTICE                    = 0x02,
+    NVME_AER_TYPE_CMDSET_SPECIFIC           = 0x06,
+    NVME_AER_TYPE_VENDOR_SPECIFIC           = 0x07,
 };
 
-typedef struct NvmeAerResult {
-    uint8_t event_type;
-    uint8_t event_info;
-    uint8_t log_page;
-    uint8_t resv;
-} NvmeAerResult;
+enum NvmeAsyncErrorInfo {
+    NVME_AER_ERR_INVALID_SQ                 = 0x00,
+    NVME_AER_ERR_INVALID_DB                 = 0x01,
+    NVME_AER_ERR_DIAG_FAIL                  = 0x02,
+    NVME_AER_ERR_PERS_INTERNAL_ERR          = 0x03,
+    NVME_AER_ERR_TRANS_INTERNAL_ERR         = 0x04,
+    NVME_AER_ERR_FW_IMG_LOAD_ERR            = 0x05,
+};
+
+enum NvmeAsyncNoticeInfo {
+    NVME_AER_NOTICE_NS_CHANGED              = 0x00,
+};
+
+enum NvmeAsyncEventCfg {
+    NVME_AEN_CFG_NS_ATTR                    = 1 << 8,
+};
 
 typedef struct NvmeCqe {
     union {
@@ -881,7 +883,6 @@ enum NvmeIdNsDps {
 
 static inline void _nvme_check_size(void)
 {
-    QEMU_BUILD_BUG_ON(sizeof(NvmeAerResult) != 4);
     QEMU_BUILD_BUG_ON(sizeof(NvmeCqe) != 16);
     QEMU_BUILD_BUG_ON(sizeof(NvmeDsmRange) != 16);
     QEMU_BUILD_BUG_ON(sizeof(NvmeCmd) != 64);
-- 
2.21.0


