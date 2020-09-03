Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 573AEC43461
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:52:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22CF520678
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:52:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22CF520678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmp.felk.cvut.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDx9j-0000RY-7Z
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 17:52:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41356)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pisa@cmp.felk.cvut.cz>)
 id 1kDx7B-0005Xa-4b
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 17:49:53 -0400
Received: from relay.felk.cvut.cz ([2001:718:2:1611:0:1:0:70]:15107)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pisa@cmp.felk.cvut.cz>) id 1kDx79-0005M4-36
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 17:49:52 -0400
Received: from cmp.felk.cvut.cz (haar.felk.cvut.cz [147.32.84.19])
 by relay.felk.cvut.cz (8.15.2/8.15.2) with ESMTP id 083Lmkt9031922;
 Thu, 3 Sep 2020 23:48:46 +0200 (CEST)
 (envelope-from pisa@cmp.felk.cvut.cz)
Received: from haar.felk.cvut.cz (localhost [127.0.0.1])
 by cmp.felk.cvut.cz (8.14.0/8.12.3/SuSE Linux 0.6) with ESMTP id
 083LmjDG026130; Thu, 3 Sep 2020 23:48:45 +0200
Received: (from pisa@localhost)
 by haar.felk.cvut.cz (8.14.0/8.13.7/Submit) id 083Lmj6B026129;
 Thu, 3 Sep 2020 23:48:45 +0200
From: Pavel Pisa <pisa@cmp.felk.cvut.cz>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 2/7] hw/net/can: sja1000 ignore CAN FD frames
Date: Thu,  3 Sep 2020 23:48:18 +0200
Message-Id: <17e5e09da81539405f9ad3665eabbff0a897a855.1599168753.git.pisa@cmp.felk.cvut.cz>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1599168753.git.pisa@cmp.felk.cvut.cz>
References: <cover.1599168753.git.pisa@cmp.felk.cvut.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-FELK-MailScanner-Information: 
X-MailScanner-ID: 083Lmkt9031922
X-FELK-MailScanner: Found to be clean
X-FELK-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
 score=-0.098, required 6, BAYES_00 -0.50, KHOP_HELO_FCRDNS 0.40,
 SPF_HELO_NONE 0.00, SPF_NONE 0.00)
X-FELK-MailScanner-From: pisa@cmp.felk.cvut.cz
X-FELK-MailScanner-Watermark: 1599774529.85662@Z2aOrjN3Ac3jIRkSVeQgXg
Received-SPF: none client-ip=2001:718:2:1611:0:1:0:70;
 envelope-from=pisa@cmp.felk.cvut.cz; helo=relay.felk.cvut.cz
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 17:39:24
X-ACL-Warn: Detected OS   = ???
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Marek Vasut <marex@denx.de>, Vikram Garhwal <fnu.vikram@xilinx.com>,
 Jiri Novak <jnovak@fel.cvut.cz>, Stefan Hajnoczi <stefanha@gmail.com>,
 Deniz Eren <deniz.eren@icloud.com>, Markus Armbruster <armbru@redhat.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 Konrad Frederic <frederic.konrad@adacore.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Jan Charvat <charvj10@fel.cvut.cz>,
 Oliver Hartkopp <socketcan@hartkopp.net>, Ondrej Ille <ondrej.ille@gmail.com>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jan Charvat <charvj10@fel.cvut.cz>

Signed-off-by: Jan Charvat <charvj10@fel.cvut.cz>
Signed-off-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Reviewed-by: Vikram Garhwal <fnu.vikram@xilinx.com>
---
 hw/net/can/can_sja1000.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/hw/net/can/can_sja1000.c b/hw/net/can/can_sja1000.c
index ec66d4232d..0898f54dea 100644
--- a/hw/net/can/can_sja1000.c
+++ b/hw/net/can/can_sja1000.c
@@ -323,11 +323,16 @@ static void buff2frame_bas(const uint8_t *buff, qemu_can_frame *frame)
 static int frame2buff_pel(const qemu_can_frame *frame, uint8_t *buff)
 {
     int i;
+    int dlen = frame->can_dlc;
 
     if (frame->can_id & QEMU_CAN_ERR_FLAG) { /* error frame, NOT support now. */
         return -1;
     }
 
+    if (dlen > 8) {
+        return -1;
+    }
+
     buff[0] = 0x0f & frame->can_dlc; /* DLC */
     if (frame->can_id & QEMU_CAN_RTR_FLAG) { /* RTR */
         buff[0] |= (1 << 6);
@@ -338,18 +343,18 @@ static int frame2buff_pel(const qemu_can_frame *frame, uint8_t *buff)
         buff[2] = extract32(frame->can_id, 13, 8); /* ID.20~ID.13 */
         buff[3] = extract32(frame->can_id, 5, 8);  /* ID.12~ID.05 */
         buff[4] = extract32(frame->can_id, 0, 5) << 3; /* ID.04~ID.00,xxx */
-        for (i = 0; i < frame->can_dlc; i++) {
+        for (i = 0; i < dlen; i++) {
             buff[5 + i] = frame->data[i];
         }
-        return frame->can_dlc + 5;
+        return dlen + 5;
     } else { /* SFF */
         buff[1] = extract32(frame->can_id, 3, 8); /* ID.10~ID.03 */
         buff[2] = extract32(frame->can_id, 0, 3) << 5; /* ID.02~ID.00,xxxxx */
-        for (i = 0; i < frame->can_dlc; i++) {
+        for (i = 0; i < dlen; i++) {
             buff[3 + i] = frame->data[i];
         }
 
-        return frame->can_dlc + 3;
+        return dlen + 3;
     }
 
     return -1;
@@ -358,6 +363,7 @@ static int frame2buff_pel(const qemu_can_frame *frame, uint8_t *buff)
 static int frame2buff_bas(const qemu_can_frame *frame, uint8_t *buff)
 {
     int i;
+    int dlen = frame->can_dlc;
 
      /*
       * EFF, no support for BasicMode
@@ -369,17 +375,21 @@ static int frame2buff_bas(const qemu_can_frame *frame, uint8_t *buff)
         return -1;
     }
 
+    if (dlen > 8) {
+        return -1;
+    }
+
     buff[0] = extract32(frame->can_id, 3, 8); /* ID.10~ID.03 */
     buff[1] = extract32(frame->can_id, 0, 3) << 5; /* ID.02~ID.00,xxxxx */
     if (frame->can_id & QEMU_CAN_RTR_FLAG) { /* RTR */
         buff[1] |= (1 << 4);
     }
     buff[1] |= frame->can_dlc & 0x0f;
-    for (i = 0; i < frame->can_dlc; i++) {
+    for (i = 0; i < dlen; i++) {
         buff[2 + i] = frame->data[i];
     }
 
-    return frame->can_dlc + 2;
+    return dlen + 2;
 }
 
 static void can_sja_update_pel_irq(CanSJA1000State *s)
@@ -766,6 +776,13 @@ ssize_t can_sja_receive(CanBusClientState *client, const qemu_can_frame *frames,
     if (frames_cnt <= 0) {
         return 0;
     }
+    if (frame->flags && QEMU_CAN_FRMF_TYPE_FD) {
+        if (DEBUG_FILTER) {
+            can_display_msg("[cansja]: ignor fd frame ", frame);
+        }
+        return 1;
+    }
+
     if (DEBUG_FILTER) {
         can_display_msg("[cansja]: receive ", frame);
     }
-- 
2.20.1


