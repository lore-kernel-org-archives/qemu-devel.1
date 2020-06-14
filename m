Return-Path: <SRS0=clLO=73=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A49C433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2020 14:40:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DB78206D7
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2020 14:40:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DB78206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkTno-0006HO-Sc
	for qemu-devel@archiver.kernel.org; Sun, 14 Jun 2020 10:40:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51850)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jkTdy-00073q-TX; Sun, 14 Jun 2020 10:29:54 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167]:38402
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jkTdx-0005Eh-3e; Sun, 14 Jun 2020 10:29:54 -0400
Received: from host217-39-64-113.range217-39.btcentralplus.com
 ([217.39.64.113] helo=kentang.home)
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jkTdn-0006Hv-DC; Sun, 14 Jun 2020 15:29:50 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, laurent@vivier.eu,
 fthain@telegraphics.com.au
Date: Sun, 14 Jun 2020 15:28:28 +0100
Message-Id: <20200614142840.10245-11-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200614142840.10245-1-mark.cave-ayland@ilande.co.uk>
References: <20200614142840.10245-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 217.39.64.113
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 10/22] mac_via: convert to use ADBBusState internal autopoll
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
---
 hw/misc/mac_via.c         | 22 ++++++++++------------
 include/hw/misc/mac_via.h |  1 -
 2 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/hw/misc/mac_via.c b/hw/misc/mac_via.c
index e05623d730..669fdca4c4 100644
--- a/hw/misc/mac_via.c
+++ b/hw/misc/mac_via.c
@@ -601,6 +601,8 @@ static void via1_rtc_update(MacVIAState *m)
 
 static int adb_via_poll(MacVIAState *s, int state, uint8_t *data)
 {
+    ADBBusState *adb_bus = &s->adb_bus;
+
     if (state != ADB_STATE_IDLE) {
         return 0;
     }
@@ -615,7 +617,8 @@ static int adb_via_poll(MacVIAState *s, int state, uint8_t *data)
 
     s->adb_data_in_index = 0;
     s->adb_data_out_index = 0;
-    s->adb_data_in_size = adb_poll(&s->adb_bus, s->adb_data_in, 0xffff);
+    s->adb_data_in_size = adb_poll(adb_bus, s->adb_data_in,
+                                   adb_bus->autopoll_mask);
 
     if (s->adb_data_in_size) {
         *data = s->adb_data_in[s->adb_data_in_index++];
@@ -768,10 +771,6 @@ static void via_adb_poll(void *opaque)
             s->b &= ~VIA1B_vADBInt;
         }
     }
-
-    timer_mod(m->adb_poll_timer,
-              qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
-              (NANOSECONDS_PER_SECOND / VIA_ADB_POLL_FREQ));
 }
 
 static uint64_t mos6522_q800_via1_read(void *opaque, hwaddr addr, unsigned size)
@@ -854,10 +853,9 @@ static void mac_via_reset(DeviceState *dev)
 {
     MacVIAState *m = MAC_VIA(dev);
     MOS6522Q800VIA1State *v1s = &m->mos6522_via1;
+    ADBBusState *adb_bus = &m->adb_bus;
 
-    timer_mod(m->adb_poll_timer,
-              qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
-              (NANOSECONDS_PER_SECOND / VIA_ADB_POLL_FREQ));
+    adb_set_autopoll_enabled(adb_bus, true);
 
     timer_del(v1s->VBL_timer);
     v1s->next_VBL = 0;
@@ -872,6 +870,7 @@ static void mac_via_realize(DeviceState *dev, Error **errp)
 {
     MacVIAState *m = MAC_VIA(dev);
     MOS6522State *ms;
+    ADBBusState *adb_bus = &m->adb_bus;
     struct tm tm;
     int ret;
 
@@ -904,7 +903,7 @@ static void mac_via_realize(DeviceState *dev, Error **errp)
     qemu_get_timedate(&tm, 0);
     m->tick_offset = (uint32_t)mktimegm(&tm) + RTC_OFFSET;
 
-    m->adb_poll_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, via_adb_poll, m);
+    adb_register_autopoll_callback(adb_bus, via_adb_poll, m);
     m->adb_data_ready = qdev_get_gpio_in_named(dev, "via1-irq",
                                                VIA1_IRQ_ADB_READY_BIT);
 
@@ -977,8 +976,8 @@ static int mac_via_post_load(void *opaque, int version_id)
 
 static const VMStateDescription vmstate_mac_via = {
     .name = "mac-via",
-    .version_id = 1,
-    .minimum_version_id = 1,
+    .version_id = 2,
+    .minimum_version_id = 2,
     .post_load = mac_via_post_load,
     .fields = (VMStateField[]) {
         /* VIAs */
@@ -1002,7 +1001,6 @@ static const VMStateDescription vmstate_mac_via = {
         VMSTATE_INT32(wprotect, MacVIAState),
         VMSTATE_INT32(alt, MacVIAState),
         /* ADB */
-        VMSTATE_TIMER_PTR(adb_poll_timer, MacVIAState),
         VMSTATE_INT32(adb_data_in_size, MacVIAState),
         VMSTATE_INT32(adb_data_in_index, MacVIAState),
         VMSTATE_INT32(adb_data_out_index, MacVIAState),
diff --git a/include/hw/misc/mac_via.h b/include/hw/misc/mac_via.h
index e74f85be0f..2aaf9e27bf 100644
--- a/include/hw/misc/mac_via.h
+++ b/include/hw/misc/mac_via.h
@@ -106,7 +106,6 @@ typedef struct MacVIAState {
 
     /* ADB */
     ADBBusState adb_bus;
-    QEMUTimer *adb_poll_timer;
     qemu_irq adb_data_ready;
     int adb_data_in_size;
     int adb_data_in_index;
-- 
2.20.1


