Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B1C4C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 07:37:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06998207DE
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 07:37:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06998207DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8f8g-0001gQ-64
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 03:37:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37442)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1k8f88-00019Z-TA; Thu, 20 Aug 2020 03:37:00 -0400
Received: from smtpout1.mo529.mail-out.ovh.net ([178.32.125.2]:38863)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1k8f86-0006QR-CY; Thu, 20 Aug 2020 03:37:00 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.156.102])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id E35A1522ADA9;
 Thu, 20 Aug 2020 09:36:53 +0200 (CEST)
Received: from kaod.org (37.59.142.105) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 20 Aug
 2020 09:36:53 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-105G006f5bb0c52-95b7-41a9-a726-f07b9e12a38d,
 02C359FD435C2C4122574921AFFD4D91C9CEEBEA) smtp.auth=clg@kaod.org
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH] ppc/pnv: Add a HIOMAP erase command
Date: Thu, 20 Aug 2020 09:36:50 +0200
Message-ID: <20200820073650.2315095-1-clg@kaod.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.105]
X-ClientProxiedBy: DAG4EX2.mxp5.local (172.16.2.32) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: 3874bcc1-36b2-47d6-8a47-9feaf372f44e
X-Ovh-Tracer-Id: 2888214737856269161
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedruddtledgleefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffogggtgfhisehtkeertdertdejnecuhfhrohhmpeevrogurhhitgcunfgvucfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepuedtieekkeelgfduvdeijeeujefhheefjedtleegtdehteejteduuddtjeefjeeknecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddruddtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtoheptghlgheskhgrohgurdhorhhg
Received-SPF: pass client-ip=178.32.125.2; envelope-from=clg@kaod.org;
 helo=smtpout1.mo529.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 02:45:31
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-devel@nongnu.org,
 Klaus Heinrich Kiwi <klaus@linux.vnet.ibm.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The OPAL test suite runs a read-erase-write test on the PNOR :

  https://github.com/open-power/op-test/blob/master/testcases/OpTestPNOR.py

which revealed that the IPMI HIOMAP handlers didn't support
HIOMAP_C_ERASE. Implement the sector erase command by writing 0xFF in
the PNOR memory region.

Reported-by: Klaus Heinrich Kiwi <klaus@linux.vnet.ibm.com>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 hw/ppc/pnv_bmc.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/pnv_bmc.c b/hw/ppc/pnv_bmc.c
index 2e1a03daa45a..0fb082fcb8ee 100644
--- a/hw/ppc/pnv_bmc.c
+++ b/hw/ppc/pnv_bmc.c
@@ -140,6 +140,29 @@ static uint16_t bytes_to_blocks(uint32_t bytes)
     return bytes >> BLOCK_SHIFT;
 }
 
+static uint32_t blocks_to_bytes(uint16_t blocks)
+{
+    return blocks << BLOCK_SHIFT;
+}
+
+#define IPMI_ERR_UNSPECIFIED            0xff
+
+static int hiomap_erase(PnvPnor *pnor, uint32_t offset, uint32_t size)
+{
+    MemTxResult result;
+    int i;
+
+    for (i = 0; i < size / 4; i++) {
+        result = memory_region_dispatch_write(&pnor->mmio, offset + i * 4,
+                                              0xFFFFFFFF, MO_32,
+                                              MEMTXATTRS_UNSPECIFIED);
+        if (result != MEMTX_OK) {
+            return -1;
+        }
+    }
+    return 0;
+}
+
 static void hiomap_cmd(IPMIBmcSim *ibs, uint8_t *cmd, unsigned int cmd_len,
                        RspBuffer *rsp)
 {
@@ -155,10 +178,16 @@ static void hiomap_cmd(IPMIBmcSim *ibs, uint8_t *cmd, unsigned int cmd_len,
     switch (cmd[2]) {
     case HIOMAP_C_MARK_DIRTY:
     case HIOMAP_C_FLUSH:
-    case HIOMAP_C_ERASE:
     case HIOMAP_C_ACK:
         break;
 
+    case HIOMAP_C_ERASE:
+        if (hiomap_erase(pnor, blocks_to_bytes(cmd[5] << 8 | cmd[4]),
+                        blocks_to_bytes(cmd[7] << 8 | cmd[6]))) {
+            rsp_buffer_set_error(rsp, IPMI_ERR_UNSPECIFIED);
+        }
+        break;
+
     case HIOMAP_C_GET_INFO:
         rsp_buffer_push(rsp, 2);  /* Version 2 */
         rsp_buffer_push(rsp, BLOCK_SHIFT); /* block size */
-- 
2.25.4


