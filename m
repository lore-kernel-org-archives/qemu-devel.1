Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86864C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 12:32:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1160222453
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 12:32:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=seznam.cz header.i=@seznam.cz header.b="lucLEHNi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1160222453
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmp.felk.cvut.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvK7F-0003JZ-Vx
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 08:32:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40284)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <autobot.majer@seznam.cz>)
 id 1jvK4b-00012A-5T
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 08:30:13 -0400
Received: from mxa2.seznam.cz ([2a02:598:2::90]:37217)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <autobot.majer@seznam.cz>)
 id 1jvK4Z-0008Pm-J9
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 08:30:12 -0400
Received: from email.seznam.cz
 by email-smtpc19b.ng.seznam.cz (email-smtpc19b.ng.seznam.cz [10.23.18.23])
 id 5c84d78b9e3bc8ca59f633bf; Tue, 14 Jul 2020 14:30:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz; s=beta;
 t=1594729809; bh=zG9X0uXgcL2CRJUhJOx6jYFPRtibHoLyks3WJxRo6zI=;
 h=Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding;
 b=lucLEHNi3cqP2dfP5DZ04NgeHcsAEyMGrbMbiB5xQ04VwDxLvhmlec+bC9H3mbrQT
 uxshl9+bU+YZHm7Wy2aZk3tt2qh4vdzamiElmUzemVsn9qukVdqUXJI8+xmZQWmDPO
 fZVt2qjFhxdbxSWtfcsD/xQqsb3GG9p5lqqmEr9Q=
Received: from hathi.duckdns.org (2001:718:2:1654:e269:95ff:fec3:1c81
 [2001:718:2:1654:e269:95ff:fec3:1c81])
 by email-relay12.ng.seznam.cz (Seznam SMTPD 1.3.119) with ESMTP;
 Tue, 14 Jul 2020 14:30:06 +0200 (CEST)  
From: pisa@cmp.felk.cvut.cz
To: qemu-devel@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v1 3/6] net/can: Add can_dlc2len and can_len2dlc for CAN FD.
Date: Tue, 14 Jul 2020 14:20:16 +0200
Message-Id: <30758547c49f254b3965fc12500735bea8265c97.1594725647.git.pisa@cmp.felk.cvut.cz>
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
 include/net/can_emu.h |  4 ++++
 net/can/can_core.c    | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/include/net/can_emu.h b/include/net/can_emu.h
index c6164dcfb4..7d395fbb9b 100644
--- a/include/net/can_emu.h
+++ b/include/net/can_emu.h
@@ -127,4 +127,8 @@ int can_bus_client_set_filters(CanBusClientState *,
                                const struct qemu_can_filter *filters,
                                size_t filters_cnt);
 
+uint8_t can_dlc2len(uint8_t can_dlc);
+
+uint8_t can_len2dlc(uint8_t len);
+
 #endif
diff --git a/net/can/can_core.c b/net/can/can_core.c
index 90f4d8576a..0115d78794 100644
--- a/net/can/can_core.c
+++ b/net/can/can_core.c
@@ -33,6 +33,42 @@
 #include "net/can_emu.h"
 #include "qom/object_interfaces.h"
 
+/* CAN DLC to real data length conversion helpers */
+
+static const uint8_t dlc2len[] = {
+    0, 1, 2, 3, 4, 5, 6, 7,
+    8, 12, 16, 20, 24, 32, 48, 64
+};
+
+/* get data length from can_dlc with sanitized can_dlc */
+uint8_t can_dlc2len(uint8_t can_dlc)
+{
+    return dlc2len[can_dlc & 0x0F];
+}
+
+static const uint8_t len2dlc[] = {
+    0, 1, 2, 3, 4, 5, 6, 7, 8,                              /* 0 - 8 */
+    9, 9, 9, 9,                                             /* 9 - 12 */
+    10, 10, 10, 10,                                         /* 13 - 16 */
+    11, 11, 11, 11,                                         /* 17 - 20 */
+    12, 12, 12, 12,                                         /* 21 - 24 */
+    13, 13, 13, 13, 13, 13, 13, 13,                         /* 25 - 32 */
+    14, 14, 14, 14, 14, 14, 14, 14,                         /* 33 - 40 */
+    14, 14, 14, 14, 14, 14, 14, 14,                         /* 41 - 48 */
+    15, 15, 15, 15, 15, 15, 15, 15,                         /* 49 - 56 */
+    15, 15, 15, 15, 15, 15, 15, 15                          /* 57 - 64 */
+};
+
+/* map the sanitized data length to an appropriate data length code */
+uint8_t can_len2dlc(uint8_t len)
+{
+    if (unlikely(len > 64)) {
+        return 0xF;
+    }
+
+    return len2dlc[len];
+}
+
 struct CanBusState {
     Object object;
 
-- 
2.20.1


