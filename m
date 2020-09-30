Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9ECDC4741F
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 22:06:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CCC9206BE
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 22:06:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="y2Umwbbg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CCC9206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNkEi-00075I-2e
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 18:06:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56118)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1kNkD4-0005O9-R8; Wed, 30 Sep 2020 18:04:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:50460)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1kNkD2-0007vK-BC; Wed, 30 Sep 2020 18:04:26 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 434B62076A;
 Wed, 30 Sep 2020 22:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1601503462;
 bh=/62M2pSDHHfBPXS/NRYPqbkA4RFhwX8RNBnWCfBW6hQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=y2Umwbbghn7Ac1NdbwAAWxobd+Lr70EUXIYDDmXbMumMeM9I2VwrD4SZaO1yyMqco
 It4Rj71HwPO0rASd2XO9Gqnt4z+YwWYC5oB7AKSZoY5EaniNrXOZ5rnpUnusvS117O
 qaOi77NJCiKAtwdXjbit5zy3M5ramQqUFiy4wIGk=
From: Keith Busch <kbusch@kernel.org>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Klaus Jensen <k.jensen@samsung.com>
Subject: [PATCH 2/9] hw/block/nvme: fix log page offset check
Date: Wed, 30 Sep 2020 15:04:07 -0700
Message-Id: <20200930220414.562527-3-kbusch@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200930220414.562527-1-kbusch@kernel.org>
References: <20200930220414.562527-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.145.29.99; envelope-from=kbusch@kernel.org;
 helo=mail.kernel.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 18:04:21
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -75
X-Spam_score: -7.6
X-Spam_bar: -------
X-Spam_report: (-7.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.469,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
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
Cc: Dmitry Fomichev <dmitry.fomichev@wdc.com>,
 Niklas Cassel <Niklas.Cassel@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Kevin Wolf <kwolf@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Return error if the requested offset starts after the size of the log
being returned. Also, move the check for earlier in the function so
we're not doing unnecessary calculations.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 hw/block/nvme.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index db52ea0db9..8d2b5be567 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -1179,6 +1179,10 @@ static uint16_t nvme_smart_info(NvmeCtrl *n, uint8_t rae, uint32_t buf_len,
         return NVME_INVALID_FIELD | NVME_DNR;
     }
 
+    if (off >= sizeof(smart)) {
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
     for (int i = 1; i <= n->num_namespaces; i++) {
         NvmeNamespace *ns = nvme_ns(n, i);
         if (!ns) {
@@ -1193,10 +1197,6 @@ static uint16_t nvme_smart_info(NvmeCtrl *n, uint8_t rae, uint32_t buf_len,
         write_commands += s->nr_ops[BLOCK_ACCT_WRITE];
     }
 
-    if (off > sizeof(smart)) {
-        return NVME_INVALID_FIELD | NVME_DNR;
-    }
-
     trans_len = MIN(sizeof(smart) - off, buf_len);
 
     memset(&smart, 0x0, sizeof(smart));
@@ -1234,12 +1234,11 @@ static uint16_t nvme_fw_log_info(NvmeCtrl *n, uint32_t buf_len, uint64_t off,
         .afi = 0x1,
     };
 
-    strpadcpy((char *)&fw_log.frs1, sizeof(fw_log.frs1), "1.0", ' ');
-
-    if (off > sizeof(fw_log)) {
+    if (off >= sizeof(fw_log)) {
         return NVME_INVALID_FIELD | NVME_DNR;
     }
 
+    strpadcpy((char *)&fw_log.frs1, sizeof(fw_log.frs1), "1.0", ' ');
     trans_len = MIN(sizeof(fw_log) - off, buf_len);
 
     return nvme_dma(n, (uint8_t *) &fw_log + off, trans_len,
@@ -1252,16 +1251,15 @@ static uint16_t nvme_error_info(NvmeCtrl *n, uint8_t rae, uint32_t buf_len,
     uint32_t trans_len;
     NvmeErrorLog errlog;
 
-    if (!rae) {
-        nvme_clear_events(n, NVME_AER_TYPE_ERROR);
+    if (off >= sizeof(errlog)) {
+        return NVME_INVALID_FIELD | NVME_DNR;
     }
 
-    if (off > sizeof(errlog)) {
-        return NVME_INVALID_FIELD | NVME_DNR;
+    if (!rae) {
+        nvme_clear_events(n, NVME_AER_TYPE_ERROR);
     }
 
     memset(&errlog, 0x0, sizeof(errlog));
-
     trans_len = MIN(sizeof(errlog) - off, buf_len);
 
     return nvme_dma(n, (uint8_t *)&errlog, trans_len,
-- 
2.24.1


