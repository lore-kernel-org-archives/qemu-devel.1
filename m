Return-Path: <SRS0=clLO=73=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E11A7C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2020 14:42:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B54CE206D7
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2020 14:42:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B54CE206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkTqH-00019J-2E
	for qemu-devel@archiver.kernel.org; Sun, 14 Jun 2020 10:42:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52204)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jkTep-0000J5-Pf; Sun, 14 Jun 2020 10:30:47 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167]:38476
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jkTeo-0005VK-53; Sun, 14 Jun 2020 10:30:47 -0400
Received: from host217-39-64-113.range217-39.btcentralplus.com
 ([217.39.64.113] helo=kentang.home)
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jkTef-0006Hv-T1; Sun, 14 Jun 2020 15:30:44 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, laurent@vivier.eu,
 fthain@telegraphics.com.au
Date: Sun, 14 Jun 2020 15:28:36 +0100
Message-Id: <20200614142840.10245-19-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200614142840.10245-1-mark.cave-ayland@ilande.co.uk>
References: <20200614142840.10245-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 217.39.64.113
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 18/22] mac_via: move VIA1 portB write logic into
 mos6522_q800_via1_write()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk;
 helo=mail.default.ilande.uk0.bigv.io
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently the logic is split between the mos6522 portB_write() callback and
the memory region used to capture the VIA1 MMIO accesses. Move everything
into the latter mos6522_q800_via1_write() function to keep all the logic in
one place to make it easier to follow.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/misc/mac_via.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/hw/misc/mac_via.c b/hw/misc/mac_via.c
index 669fdca4c4..4779236f95 100644
--- a/hw/misc/mac_via.c
+++ b/hw/misc/mac_via.c
@@ -801,11 +801,21 @@ static void mos6522_q800_via1_write(void *opaque, hwaddr addr, uint64_t val,
                                     unsigned size)
 {
     MOS6522Q800VIA1State *v1s = MOS6522_Q800_VIA1(opaque);
+    MacVIAState *m = container_of(v1s, MacVIAState, mos6522_via1);
     MOS6522State *ms = MOS6522(v1s);
 
     addr = (addr >> 9) & 0xf;
     mos6522_write(ms, addr, val, size);
 
+    switch (addr) {
+    case VIA_REG_B:
+        via1_rtc_update(m);
+        via1_adb_update(m);
+
+        v1s->last_b = ms->b;
+        break;
+    }
+
     via1_one_second_update(v1s);
     via1_VBL_update(v1s);
 }
@@ -1034,18 +1044,6 @@ static TypeInfo mac_via_info = {
 };
 
 /* VIA 1 */
-static void mos6522_q800_via1_portB_write(MOS6522State *s)
-{
-    MOS6522Q800VIA1State *v1s = container_of(s, MOS6522Q800VIA1State,
-                                             parent_obj);
-    MacVIAState *m = container_of(v1s, MacVIAState, mos6522_via1);
-
-    via1_rtc_update(m);
-    via1_adb_update(m);
-
-    v1s->last_b = s->b;
-}
-
 static void mos6522_q800_via1_reset(DeviceState *dev)
 {
     MOS6522State *ms = MOS6522(dev);
@@ -1068,10 +1066,8 @@ static void mos6522_q800_via1_init(Object *obj)
 static void mos6522_q800_via1_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
-    MOS6522DeviceClass *mdc = MOS6522_DEVICE_CLASS(oc);
 
     dc->reset = mos6522_q800_via1_reset;
-    mdc->portB_write = mos6522_q800_via1_portB_write;
 }
 
 static const TypeInfo mos6522_q800_via1_type_info = {
-- 
2.20.1


