Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D21B4C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 09:13:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9789020738
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 09:13:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9789020738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBDxv-00045X-Ot
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 05:13:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54424)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1kBDwg-0001fD-7W; Thu, 27 Aug 2020 05:11:46 -0400
Received: from smtpout1.mo529.mail-out.ovh.net ([178.32.125.2]:41739)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1kBDwe-0001zi-0B; Thu, 27 Aug 2020 05:11:45 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.156.44])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id F0BBF54810E6;
 Thu, 27 Aug 2020 11:11:33 +0200 (CEST)
Received: from kaod.org (37.59.142.99) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Thu, 27 Aug
 2020 11:11:32 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-99G003d6fa0ea9-06f3-4474-923a-91ee005d5c8c,
 618CF37EF0508A6B3BD090B4D8B11E595DDBE7AA) smtp.auth=clg@kaod.org
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: <qemu-devel@nongnu.org>
Subject: [PATCH 1/2] m25p80: Add basic support for the SFDP command
Date: Thu, 27 Aug 2020 11:11:29 +0200
Message-ID: <20200827091130.3525790-2-clg@kaod.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200827091130.3525790-1-clg@kaod.org>
References: <20200827091130.3525790-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.99]
X-ClientProxiedBy: DAG7EX2.mxp5.local (172.16.2.62) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: b5469d95-93aa-4455-a49e-f5c5e03ab007
X-Ovh-Tracer-Id: 8702080382030482284
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedruddvgedguddvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffojghfgggtgfhisehtkeertdertdejnecuhfhrohhmpeevrogurhhitgcunfgvucfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepheehfeegjeeitdfffeetjeduveejueefuefgtdefueelueetveeliefhhffgtdelnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrdelleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtoheptghlgheskhgrohgurdhorhhg
Received-SPF: pass client-ip=178.32.125.2; envelope-from=clg@kaod.org;
 helo=smtpout1.mo529.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 05:11:34
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 Francisco Iglesias <frasse.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

JEDEC STANDARD JESD216 for Serial Flash Discovery Parameters (SFDP)
provides a mean to describe the features of a serial flash device
using a set of internal parameter tables.

This is the initial framework for the RDSFDP command giving access to
a private SFDP area under the flash. This area now needs to be
populated with the flash device characteristics, using a new 'sfdp'
pointer under FlashPartInfo.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 hw/block/m25p80_sfdp.h | 15 +++++++++++++++
 hw/block/m25p80.c      | 33 +++++++++++++++++++++++++++++++++
 hw/block/trace-events  |  1 +
 3 files changed, 49 insertions(+)
 create mode 100644 hw/block/m25p80_sfdp.h

diff --git a/hw/block/m25p80_sfdp.h b/hw/block/m25p80_sfdp.h
new file mode 100644
index 000000000000..b75fd0b0c13f
--- /dev/null
+++ b/hw/block/m25p80_sfdp.h
@@ -0,0 +1,15 @@
+/*
+ * M25P80 SFDP
+ *
+ * Copyright (c) 2020, IBM Corporation.
+ *
+ * This code is licensed under the GPL version 2 or later. See the
+ * COPYING file in the top-level directory.
+ */
+
+#ifndef HW_M25P80_SFDP_H
+#define HW_M25P80_SFDP_H
+
+#define M25P80_SFDP_AREA_SIZE 0x100
+
+#endif
diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index 82270884416e..32925589ec7a 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -33,6 +33,7 @@
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "trace.h"
+#include "m25p80_sfdp.h"
 
 /* Fields for FlashPartInfo->flags */
 
@@ -72,6 +73,7 @@ typedef struct FlashPartInfo {
      * This field inform how many die is in the chip.
      */
     uint8_t die_cnt;
+    const uint8_t *sfdp;
 } FlashPartInfo;
 
 /* adapted from linux */
@@ -333,6 +335,7 @@ typedef enum {
     BULK_ERASE = 0xc7,
     READ_FSR = 0x70,
     RDCR = 0x15,
+    RDSFDP = 0x5a,
 
     READ = 0x03,
     READ4 = 0x13,
@@ -398,6 +401,7 @@ typedef enum {
     STATE_COLLECTING_DATA,
     STATE_COLLECTING_VAR_LEN_DATA,
     STATE_READING_DATA,
+    STATE_READING_SFDP,
 } CMDState;
 
 typedef enum {
@@ -619,6 +623,8 @@ static inline int get_addr_length(Flash *s)
     }
 
    switch (s->cmd_in_progress) {
+   case RDSFDP:
+       return 3;
    case PP4:
    case PP4_4:
    case QPP_4:
@@ -744,6 +750,17 @@ static void complete_collecting_data(Flash *s)
                           " by device\n");
         }
         break;
+
+    case RDSFDP:
+        if (s->cur_addr < M25P80_SFDP_AREA_SIZE) {
+            s->state = STATE_READING_SFDP;
+        } else {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "M25P80: Invalid SFDP address %#" PRIx32 "\n",
+                          s->cur_addr);
+        }
+        break;
+
     default:
         break;
     }
@@ -1160,6 +1177,16 @@ static void decode_new_cmd(Flash *s, uint32_t value)
     case RSTQIO:
         s->quad_enable = false;
         break;
+    case RDSFDP:
+        if (s->pi->sfdp) {
+            s->needed_bytes = get_addr_length(s) + 1 ; /* SFDP addr + dummy */
+            s->pos = 0;
+            s->len = 0;
+            s->state = STATE_COLLECTING_DATA;
+            break;
+        }
+        /* Fallthrough */
+
     default:
         s->pos = 0;
         s->len = 1;
@@ -1256,6 +1283,12 @@ static uint32_t m25p80_transfer8(SSISlave *ss, uint32_t tx)
             }
         }
         break;
+    case STATE_READING_SFDP:
+        assert(s->pi->sfdp);
+        r = s->pi->sfdp[s->cur_addr];
+        trace_m25p80_read_sfdp(s, s->cur_addr, (uint8_t)r);
+        s->cur_addr = (s->cur_addr + 1) & (M25P80_SFDP_AREA_SIZE - 1);
+        break;
 
     default:
     case STATE_IDLE:
diff --git a/hw/block/trace-events b/hw/block/trace-events
index 958fcc5508d1..53d377ca2b46 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -152,5 +152,6 @@ m25p80_page_program(void *s, uint32_t addr, uint8_t tx) "[%p] page program cur_a
 m25p80_transfer(void *s, uint8_t state, uint32_t len, uint8_t needed, uint32_t pos, uint32_t cur_addr, uint8_t t) "[%p] Transfer state 0x%"PRIx8" len 0x%"PRIx32" needed 0x%"PRIx8" pos 0x%"PRIx32" addr 0x%"PRIx32" tx 0x%"PRIx8
 m25p80_read_byte(void *s, uint32_t addr, uint8_t v) "[%p] Read byte 0x%"PRIx32"=0x%"PRIx8
 m25p80_read_data(void *s, uint32_t pos, uint8_t v) "[%p] Read data 0x%"PRIx32"=0x%"PRIx8
+m25p80_read_sfdp(void *s, uint32_t addr, uint8_t v) "[%p] Read SFDP 0x%"PRIx32"=0x%"PRIx8
 m25p80_binding(void *s) "[%p] Binding to IF_MTD drive"
 m25p80_binding_no_bdrv(void *s) "[%p] No BDRV - binding to RAM"
-- 
2.25.4


