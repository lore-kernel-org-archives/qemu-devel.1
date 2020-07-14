Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14EBAC433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 12:30:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D608C22453
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 12:30:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=seznam.cz header.i=@seznam.cz header.b="L0QjY1MC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D608C22453
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmp.felk.cvut.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvK4T-0000du-1B
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 08:30:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39612)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <autobot.majer@seznam.cz>)
 id 1jvK2l-0008A2-9X
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 08:28:19 -0400
Received: from mxa2.seznam.cz ([2a02:598:2::90]:58117)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <autobot.majer@seznam.cz>)
 id 1jvK2j-00086H-OU
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 08:28:18 -0400
Received: from email.seznam.cz
 by email-smtpc6b.ng.seznam.cz (email-smtpc6b.ng.seznam.cz [10.23.13.165])
 id 1366aa58d1d9b51916144e6c; Tue, 14 Jul 2020 14:28:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz; s=beta;
 t=1594729696; bh=TiJmP84fYCWtcrwCfmPiWA9raLRLkF+qrR458zJPqns=;
 h=Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding;
 b=L0QjY1MC7m8xzaDbnTVAlISBC0LpKkS8jpwNq5QkpZM+Z4jQ4M5znMKXykD6ziw5D
 EF8X0C/BcBKRIAsFfhFAmyfD6BlXKkGe0E253N/lHK/B9io4E7TrL9iXigvhBzUJVb
 Il96WGlAhnrrNfYzJPmxcIskjVtReVKMf+gtUwfk=
Received: from hathi.duckdns.org (2001:718:2:1654:e269:95ff:fec3:1c81
 [2001:718:2:1654:e269:95ff:fec3:1c81])
 by email-relay26.ng.seznam.cz (Seznam SMTPD 1.3.119) with ESMTP;
 Tue, 14 Jul 2020 14:28:14 +0200 (CEST)  
From: pisa@cmp.felk.cvut.cz
To: qemu-devel@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v1 2/6] hw/net/can: sja1000 ignore CAN FD frames
Date: Tue, 14 Jul 2020 14:20:15 +0200
Message-Id: <e9a4847e46810282319bdde1a6ddd901eb8783fd.1594725647.git.pisa@cmp.felk.cvut.cz>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1594725647.git.pisa@cmp.felk.cvut.cz>
References: <cover.1594725647.git.pisa@cmp.felk.cvut.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:598:2::90;
 envelope-from=autobot.majer@seznam.cz; helo=mxa2.seznam.cz
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: Marek Vasut <marex@denx.de>, Oliver Hartkopp <socketcan@hartkopp.net>,
 Jiri Novak <jnovak@fel.cvut.cz>, Stefan Hajnoczi <stefanha@gmail.com>,
 Deniz Eren <deniz.eren@icloud.com>, Markus Armbruster <armbru@redhat.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 Konrad Frederic <frederic.konrad@adacore.com>,
 Jan Charvat <charvj10@fel.cvut.cz>, Jan Kiszka <jan.kiszka@siemens.com>,
 Ondrej Ille <ondrej.ille@gmail.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jan Charvat <charvj10@fel.cvut.cz>

Signed-off-by: Jan Charvat <charvj10@fel.cvut.cz>
Signed-off-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>
---
 hw/net/can/can_sja1000.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/hw/net/can/can_sja1000.c b/hw/net/can/can_sja1000.c
index d83c550edc..382911560c 100644
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
@@ -764,6 +774,13 @@ ssize_t can_sja_receive(CanBusClientState *client, const qemu_can_frame *frames,
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


