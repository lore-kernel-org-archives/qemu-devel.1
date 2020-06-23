Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7002C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 20:56:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DBCC20724
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 20:56:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DBCC20724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnpxy-0005tE-Kb
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 16:56:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45338)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jnpsL-0004V9-Fv; Tue, 23 Jun 2020 16:50:37 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167]:56398
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jnpsI-0001es-NH; Tue, 23 Jun 2020 16:50:37 -0400
Received: from host86-158-109-79.range86-158.btcentralplus.com
 ([86.158.109.79] helo=kentang.home)
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jnpsF-0007T1-Of; Tue, 23 Jun 2020 21:50:36 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, laurent@vivier.eu,
 fthain@telegraphics.com.au
Date: Tue, 23 Jun 2020 21:49:23 +0100
Message-Id: <20200623204936.24064-10-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200623204936.24064-1-mark.cave-ayland@ilande.co.uk>
References: <20200623204936.24064-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.158.109.79
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 09/22] pmu: convert to use ADBBusState internal autopoll
 variables
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

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Tested-by: Finn Thain <fthain@telegraphics.com.au>
---
 hw/misc/macio/pmu.c         | 39 ++++++++++++++-----------------------
 include/hw/misc/macio/pmu.h |  3 ---
 2 files changed, 15 insertions(+), 27 deletions(-)

diff --git a/hw/misc/macio/pmu.c b/hw/misc/macio/pmu.c
index bae0b440d0..01d49e6695 100644
--- a/hw/misc/macio/pmu.c
+++ b/hw/misc/macio/pmu.c
@@ -92,10 +92,11 @@ static void pmu_update_extirq(PMUState *s)
 static void pmu_adb_poll(void *opaque)
 {
     PMUState *s = opaque;
+    ADBBusState *adb_bus = &s->adb_bus;
     int olen;
 
     if (!(s->intbits & PMU_INT_ADB)) {
-        olen = adb_poll(&s->adb_bus, s->adb_reply, s->adb_poll_mask);
+        olen = adb_poll(adb_bus, s->adb_reply, adb_bus->autopoll_mask);
         trace_pmu_adb_poll(olen);
 
         if (olen > 0) {
@@ -104,9 +105,6 @@ static void pmu_adb_poll(void *opaque)
             pmu_update_extirq(s);
         }
     }
-
-    timer_mod(s->adb_poll_timer,
-              qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + s->autopoll_rate_ms);
 }
 
 static void pmu_one_sec_timer(void *opaque)
@@ -173,18 +171,15 @@ static void pmu_cmd_set_int_mask(PMUState *s,
 
 static void pmu_cmd_set_adb_autopoll(PMUState *s, uint16_t mask)
 {
-    trace_pmu_cmd_set_adb_autopoll(mask);
+    ADBBusState *adb_bus = &s->adb_bus;
 
-    if (s->adb_poll_mask == mask) {
-        return;
-    }
+    trace_pmu_cmd_set_adb_autopoll(mask);
 
-    s->adb_poll_mask = mask;
     if (mask) {
-        timer_mod(s->adb_poll_timer,
-                  qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + s->autopoll_rate_ms);
+        adb_set_autopoll_mask(adb_bus, mask);
+        adb_set_autopoll_enabled(adb_bus, true);
     } else {
-        timer_del(s->adb_poll_timer);
+        adb_set_autopoll_enabled(adb_bus, false);
     }
 }
 
@@ -267,6 +262,8 @@ static void pmu_cmd_adb_poll_off(PMUState *s,
                                  const uint8_t *in_data, uint8_t in_len,
                                  uint8_t *out_data, uint8_t *out_len)
 {
+    ADBBusState *adb_bus = &s->adb_bus;
+
     if (in_len != 0) {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "PMU: ADB POLL OFF command, invalid len: %d want: 0\n",
@@ -274,9 +271,8 @@ static void pmu_cmd_adb_poll_off(PMUState *s,
         return;
     }
 
-    if (s->has_adb && s->adb_poll_mask) {
-        timer_del(s->adb_poll_timer);
-        s->adb_poll_mask = 0;
+    if (s->has_adb) {
+        adb_set_autopoll_enabled(adb_bus, false);
     }
 }
 
@@ -684,12 +680,10 @@ static bool pmu_adb_state_needed(void *opaque)
 
 static const VMStateDescription vmstate_pmu_adb = {
     .name = "pmu/adb",
-    .version_id = 0,
-    .minimum_version_id = 0,
+    .version_id = 1,
+    .minimum_version_id = 1,
     .needed = pmu_adb_state_needed,
     .fields = (VMStateField[]) {
-        VMSTATE_UINT16(adb_poll_mask, PMUState),
-        VMSTATE_TIMER_PTR(adb_poll_timer, PMUState),
         VMSTATE_UINT8(adb_reply_size, PMUState),
         VMSTATE_BUFFER(adb_reply, PMUState),
         VMSTATE_END_OF_LIST()
@@ -714,7 +708,6 @@ static const VMStateDescription vmstate_pmu = {
         VMSTATE_BUFFER(cmd_rsp, PMUState),
         VMSTATE_UINT8(intbits, PMUState),
         VMSTATE_UINT8(intmask, PMUState),
-        VMSTATE_UINT8(autopoll_rate_ms, PMUState),
         VMSTATE_UINT32(tick_offset, PMUState),
         VMSTATE_TIMER_PTR(one_sec_timer, PMUState),
         VMSTATE_INT64(one_sec_target, PMUState),
@@ -734,7 +727,6 @@ static void pmu_reset(DeviceState *dev)
     s->intbits = 0;
 
     s->cmd_state = pmu_state_idle;
-    s->adb_poll_mask = 0;
 }
 
 static void pmu_realize(DeviceState *dev, Error **errp)
@@ -742,6 +734,7 @@ static void pmu_realize(DeviceState *dev, Error **errp)
     PMUState *s = VIA_PMU(dev);
     Error *err = NULL;
     SysBusDevice *sbd;
+    ADBBusState *adb_bus = &s->adb_bus;
     struct tm tm;
 
     sysbus_realize(SYS_BUS_DEVICE(&s->mos6522_pmu), &err);
@@ -763,9 +756,7 @@ static void pmu_realize(DeviceState *dev, Error **errp)
     if (s->has_adb) {
         qbus_create_inplace(&s->adb_bus, sizeof(s->adb_bus), TYPE_ADB_BUS,
                             dev, "adb.0");
-        s->adb_poll_timer = timer_new_ms(QEMU_CLOCK_VIRTUAL, pmu_adb_poll, s);
-        s->adb_poll_mask = 0xffff;
-        s->autopoll_rate_ms = 20;
+        adb_register_autopoll_callback(adb_bus, pmu_adb_poll, s);
     }
 }
 
diff --git a/include/hw/misc/macio/pmu.h b/include/hw/misc/macio/pmu.h
index 4f34b6f9e7..72f75612b6 100644
--- a/include/hw/misc/macio/pmu.h
+++ b/include/hw/misc/macio/pmu.h
@@ -218,9 +218,6 @@ typedef struct PMUState {
     /* ADB */
     bool has_adb;
     ADBBusState adb_bus;
-    uint16_t adb_poll_mask;
-    uint8_t autopoll_rate_ms;
-    QEMUTimer *adb_poll_timer;
     uint8_t adb_reply_size;
     uint8_t adb_reply[ADB_MAX_OUT_LEN];
 
-- 
2.20.1


