Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E3A0C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 05:23:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D13D321897
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 05:23:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="i2u5xjAa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D13D321897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFW6G-0002nZ-Ns
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 01:23:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57296)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kFW3H-0005vB-HM; Tue, 08 Sep 2020 01:20:19 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:41377)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kFW3F-0005sJ-1D; Tue, 08 Sep 2020 01:20:19 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4Bltkk0f4zz9sTh; Tue,  8 Sep 2020 15:19:57 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1599542398;
 bh=qRvDkKeGN3ISEoYcHLWQNMPIJ9YGM+/j4ALri4j7g1A=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=i2u5xjAaH/qJHU3lR4WjkK6DYCqmepo1lUJp/8ar3fKmSZqwtVDujcd/U2MT1GcPB
 pZVJ6Pb4UZaVy2JF/lcDuqhbamgDXcUOUGMflaV3IBOZj2lMbEVisPpCjsYBFEeQcO
 nowMSrtZpQMurfHtOhkOdo+acSibUiWLI/3zX8zo=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 05/33] ppc/pnv: Add a HIOMAP erase command
Date: Tue,  8 Sep 2020 15:19:25 +1000
Message-Id: <20200908051953.1616885-6-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200908051953.1616885-1-david@gibson.dropbear.id.au>
References: <20200908051953.1616885-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Corey Minyard <cminyard@mvista.com>, danielhb413@gmail.com,
 qemu-devel@nongnu.org, groug@kaod.org,
 Klaus Heinrich Kiwi <klaus@linux.vnet.ibm.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, bauerman@linux.ibm.com,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Cédric Le Goater <clg@kaod.org>

The OPAL test suite runs a read-erase-write test on the PNOR :

  https://github.com/open-power/op-test/blob/master/testcases/OpTestPNOR.py

which revealed that the IPMI HIOMAP handlers didn't support
HIOMAP_C_ERASE. Implement the sector erase command by writing 0xFF in
the PNOR memory region.

Cc: Corey Minyard <cminyard@mvista.com>
Reported-by: Klaus Heinrich Kiwi <klaus@linux.vnet.ibm.com>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Message-Id: <20200820164638.2515681-1-clg@kaod.org>
Acked-by: Corey Minyard <cminyard@mvista.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/pnv_bmc.c       | 29 ++++++++++++++++++++++++++++-
 include/hw/ipmi/ipmi.h |  1 +
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/pnv_bmc.c b/hw/ppc/pnv_bmc.c
index 2e1a03daa4..67ebb16c4d 100644
--- a/hw/ppc/pnv_bmc.c
+++ b/hw/ppc/pnv_bmc.c
@@ -140,6 +140,27 @@ static uint16_t bytes_to_blocks(uint32_t bytes)
     return bytes >> BLOCK_SHIFT;
 }
 
+static uint32_t blocks_to_bytes(uint16_t blocks)
+{
+    return blocks << BLOCK_SHIFT;
+}
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
@@ -155,10 +176,16 @@ static void hiomap_cmd(IPMIBmcSim *ibs, uint8_t *cmd, unsigned int cmd_len,
     switch (cmd[2]) {
     case HIOMAP_C_MARK_DIRTY:
     case HIOMAP_C_FLUSH:
-    case HIOMAP_C_ERASE:
     case HIOMAP_C_ACK:
         break;
 
+    case HIOMAP_C_ERASE:
+        if (hiomap_erase(pnor, blocks_to_bytes(cmd[5] << 8 | cmd[4]),
+                        blocks_to_bytes(cmd[7] << 8 | cmd[6]))) {
+            rsp_buffer_set_error(rsp, IPMI_CC_UNSPECIFIED);
+        }
+        break;
+
     case HIOMAP_C_GET_INFO:
         rsp_buffer_push(rsp, 2);  /* Version 2 */
         rsp_buffer_push(rsp, BLOCK_SHIFT); /* block size */
diff --git a/include/hw/ipmi/ipmi.h b/include/hw/ipmi/ipmi.h
index 8a99d958bb..c1efdaa4cb 100644
--- a/include/hw/ipmi/ipmi.h
+++ b/include/hw/ipmi/ipmi.h
@@ -53,6 +53,7 @@ enum ipmi_op {
 #define IPMI_CC_INVALID_DATA_FIELD                       0xcc
 #define IPMI_CC_BMC_INIT_IN_PROGRESS                     0xd2
 #define IPMI_CC_COMMAND_NOT_SUPPORTED                    0xd5
+#define IPMI_CC_UNSPECIFIED                              0xff
 
 #define IPMI_NETFN_APP                0x06
 #define IPMI_NETFN_OEM                0x3a
-- 
2.26.2


