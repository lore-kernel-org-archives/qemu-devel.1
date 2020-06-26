Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7EC7C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 09:26:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD26D212CC
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 09:26:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD26D212CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jokdL-0000ty-VN
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 05:26:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54870)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jokaP-0003uk-Ol; Fri, 26 Jun 2020 05:23:53 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167]:34214
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jokaN-0004Vz-Rb; Fri, 26 Jun 2020 05:23:53 -0400
Received: from host86-158-109-79.range86-158.btcentralplus.com
 ([86.158.109.79] helo=kentang.home)
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jokaJ-0007bz-QB; Fri, 26 Jun 2020 10:23:53 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org, laurent@vivier.eu, david@gibson.dropbear.id.au,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Date: Fri, 26 Jun 2020 10:22:59 +0100
Message-Id: <20200626092317.3875-5-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200626092317.3875-1-mark.cave-ayland@ilande.co.uk>
References: <20200626092317.3875-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.158.109.79
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 04/22] pmu: fix duplicate autopoll mask variable
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

It seems that during the initial work to introduce the via-pmu ADB support a
duplicate autopoll mask variable was accidentally left in place.

Remove the duplicate autopoll_mask variable and switch everything over to
use adb_poll_mask instead.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Tested-by: Finn Thain <fthain@telegraphics.com.au>
Acked-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20200623204936.24064-5-mark.cave-ayland@ilande.co.uk>
---
 hw/misc/macio/pmu.c         | 15 +++++++--------
 include/hw/misc/macio/pmu.h |  1 -
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/hw/misc/macio/pmu.c b/hw/misc/macio/pmu.c
index 41b626c46c..cae2845936 100644
--- a/hw/misc/macio/pmu.c
+++ b/hw/misc/macio/pmu.c
@@ -175,11 +175,11 @@ static void pmu_cmd_set_adb_autopoll(PMUState *s, uint16_t mask)
 {
     trace_pmu_cmd_set_adb_autopoll(mask);
 
-    if (s->autopoll_mask == mask) {
+    if (s->adb_poll_mask == mask) {
         return;
     }
 
-    s->autopoll_mask = mask;
+    s->adb_poll_mask = mask;
     if (mask) {
         timer_mod(s->adb_poll_timer,
                   qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + 30);
@@ -274,9 +274,9 @@ static void pmu_cmd_adb_poll_off(PMUState *s,
         return;
     }
 
-    if (s->has_adb && s->autopoll_mask) {
+    if (s->has_adb && s->adb_poll_mask) {
         timer_del(s->adb_poll_timer);
-        s->autopoll_mask = false;
+        s->adb_poll_mask = 0;
     }
 }
 
@@ -698,8 +698,8 @@ static const VMStateDescription vmstate_pmu_adb = {
 
 static const VMStateDescription vmstate_pmu = {
     .name = "pmu",
-    .version_id = 0,
-    .minimum_version_id = 0,
+    .version_id = 1,
+    .minimum_version_id = 1,
     .fields = (VMStateField[]) {
         VMSTATE_STRUCT(mos6522_pmu.parent_obj, PMUState, 0, vmstate_mos6522,
                        MOS6522State),
@@ -715,7 +715,6 @@ static const VMStateDescription vmstate_pmu = {
         VMSTATE_UINT8(intbits, PMUState),
         VMSTATE_UINT8(intmask, PMUState),
         VMSTATE_UINT8(autopoll_rate_ms, PMUState),
-        VMSTATE_UINT8(autopoll_mask, PMUState),
         VMSTATE_UINT32(tick_offset, PMUState),
         VMSTATE_TIMER_PTR(one_sec_timer, PMUState),
         VMSTATE_INT64(one_sec_target, PMUState),
@@ -735,7 +734,7 @@ static void pmu_reset(DeviceState *dev)
     s->intbits = 0;
 
     s->cmd_state = pmu_state_idle;
-    s->autopoll_mask = 0;
+    s->adb_poll_mask = 0;
 }
 
 static void pmu_realize(DeviceState *dev, Error **errp)
diff --git a/include/hw/misc/macio/pmu.h b/include/hw/misc/macio/pmu.h
index 7ef83dee4c..4f34b6f9e7 100644
--- a/include/hw/misc/macio/pmu.h
+++ b/include/hw/misc/macio/pmu.h
@@ -220,7 +220,6 @@ typedef struct PMUState {
     ADBBusState adb_bus;
     uint16_t adb_poll_mask;
     uint8_t autopoll_rate_ms;
-    uint8_t autopoll_mask;
     QEMUTimer *adb_poll_timer;
     uint8_t adb_reply_size;
     uint8_t adb_reply[ADB_MAX_OUT_LEN];
-- 
2.20.1


