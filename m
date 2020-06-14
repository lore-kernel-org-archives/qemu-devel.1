Return-Path: <SRS0=clLO=73=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B2C5C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2020 14:31:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F4E62071A
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2020 14:31:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F4E62071A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkTfK-0008Q5-CJ
	for qemu-devel@archiver.kernel.org; Sun, 14 Jun 2020 10:31:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51648)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jkTdn-0006bz-T7; Sun, 14 Jun 2020 10:29:43 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167]:38388
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jkTdm-0005Do-1O; Sun, 14 Jun 2020 10:29:43 -0400
Received: from host217-39-64-113.range217-39.btcentralplus.com
 ([217.39.64.113] helo=kentang.home)
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jkTdf-0006Hv-Kz; Sun, 14 Jun 2020 15:29:40 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, laurent@vivier.eu,
 fthain@telegraphics.com.au
Date: Sun, 14 Jun 2020 15:28:26 +0100
Message-Id: <20200614142840.10245-9-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200614142840.10245-1-mark.cave-ayland@ilande.co.uk>
References: <20200614142840.10245-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 217.39.64.113
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 08/22] cuda: convert to use ADBBusState internal autopoll
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
 hw/misc/macio/cuda.c         | 56 +++++++++++++++---------------------
 include/hw/misc/macio/cuda.h |  4 ---
 2 files changed, 23 insertions(+), 37 deletions(-)

diff --git a/hw/misc/macio/cuda.c b/hw/misc/macio/cuda.c
index a407f2abc8..716866ea34 100644
--- a/hw/misc/macio/cuda.c
+++ b/hw/misc/macio/cuda.c
@@ -199,18 +199,16 @@ static void cuda_send_packet_to_host(CUDAState *s,
 static void cuda_adb_poll(void *opaque)
 {
     CUDAState *s = opaque;
+    ADBBusState *adb_bus = &s->adb_bus;
     uint8_t obuf[ADB_MAX_OUT_LEN + 2];
     int olen;
 
-    olen = adb_poll(&s->adb_bus, obuf + 2, s->adb_poll_mask);
+    olen = adb_poll(adb_bus, obuf + 2, adb_bus->autopoll_mask);
     if (olen > 0) {
         obuf[0] = ADB_PACKET;
         obuf[1] = 0x40; /* polled data */
         cuda_send_packet_to_host(s, obuf, olen + 2);
     }
-
-    timer_mod(s->adb_poll_timer, qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) +
-              s->autopoll_rate_ms);
 }
 
 /* description of commands */
@@ -226,23 +224,16 @@ static bool cuda_cmd_autopoll(CUDAState *s,
                               const uint8_t *in_data, int in_len,
                               uint8_t *out_data, int *out_len)
 {
-    int autopoll;
+    ADBBusState *adb_bus = &s->adb_bus;
+    bool autopoll;
 
     if (in_len != 1) {
         return false;
     }
 
-    autopoll = (in_data[0] != 0);
-    if (autopoll != s->autopoll) {
-        s->autopoll = autopoll;
-        if (autopoll) {
-            timer_mod(s->adb_poll_timer,
-                      qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) +
-                      s->autopoll_rate_ms);
-        } else {
-            timer_del(s->adb_poll_timer);
-        }
-    }
+    autopoll = (in_data[0] != 0) ? true : false;
+
+    adb_set_autopoll_enabled(adb_bus, autopoll);
     return true;
 }
 
@@ -250,6 +241,8 @@ static bool cuda_cmd_set_autorate(CUDAState *s,
                                   const uint8_t *in_data, int in_len,
                                   uint8_t *out_data, int *out_len)
 {
+    ADBBusState *adb_bus = &s->adb_bus;
+
     if (in_len != 1) {
         return false;
     }
@@ -260,12 +253,7 @@ static bool cuda_cmd_set_autorate(CUDAState *s,
         return false;
     }
 
-    s->autopoll_rate_ms = in_data[0];
-    if (s->autopoll) {
-        timer_mod(s->adb_poll_timer,
-                  qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) +
-                  s->autopoll_rate_ms);
-    }
+    adb_set_autopoll_rate_ms(adb_bus, in_data[0]);
     return true;
 }
 
@@ -273,11 +261,16 @@ static bool cuda_cmd_set_device_list(CUDAState *s,
                                      const uint8_t *in_data, int in_len,
                                      uint8_t *out_data, int *out_len)
 {
+    ADBBusState *adb_bus = &s->adb_bus;
+    uint16_t mask;
+
     if (in_len != 2) {
         return false;
     }
 
-    s->adb_poll_mask = (((uint16_t)in_data[0]) << 8) | in_data[1];
+    mask = (((uint16_t)in_data[0]) << 8) | in_data[1];
+
+    adb_set_autopoll_mask(adb_bus, mask);
     return true;
 }
 
@@ -488,8 +481,8 @@ static const MemoryRegionOps mos6522_cuda_ops = {
 
 static const VMStateDescription vmstate_cuda = {
     .name = "cuda",
-    .version_id = 5,
-    .minimum_version_id = 5,
+    .version_id = 6,
+    .minimum_version_id = 6,
     .fields = (VMStateField[]) {
         VMSTATE_STRUCT(mos6522_cuda.parent_obj, CUDAState, 0, vmstate_mos6522,
                        MOS6522State),
@@ -498,13 +491,9 @@ static const VMStateDescription vmstate_cuda = {
         VMSTATE_INT32(data_in_size, CUDAState),
         VMSTATE_INT32(data_in_index, CUDAState),
         VMSTATE_INT32(data_out_index, CUDAState),
-        VMSTATE_UINT8(autopoll, CUDAState),
-        VMSTATE_UINT8(autopoll_rate_ms, CUDAState),
-        VMSTATE_UINT16(adb_poll_mask, CUDAState),
         VMSTATE_BUFFER(data_in, CUDAState),
         VMSTATE_BUFFER(data_out, CUDAState),
         VMSTATE_UINT32(tick_offset, CUDAState),
-        VMSTATE_TIMER_PTR(adb_poll_timer, CUDAState),
         VMSTATE_TIMER_PTR(sr_delay_timer, CUDAState),
         VMSTATE_END_OF_LIST()
     }
@@ -513,11 +502,13 @@ static const VMStateDescription vmstate_cuda = {
 static void cuda_reset(DeviceState *dev)
 {
     CUDAState *s = CUDA(dev);
+    ADBBusState *adb_bus = &s->adb_bus;
 
     s->data_in_size = 0;
     s->data_in_index = 0;
     s->data_out_index = 0;
-    s->autopoll = 0;
+
+    adb_set_autopoll_enabled(adb_bus, false);
 }
 
 static void cuda_realize(DeviceState *dev, Error **errp)
@@ -526,6 +517,7 @@ static void cuda_realize(DeviceState *dev, Error **errp)
     SysBusDevice *sbd;
     MOS6522State *ms;
     DeviceState *d;
+    ADBBusState *adb_bus = &s->adb_bus;
     struct tm tm;
 
     /* Pass IRQ from 6522 */
@@ -540,9 +532,7 @@ static void cuda_realize(DeviceState *dev, Error **errp)
     s->sr_delay_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, cuda_set_sr_int, s);
     s->sr_delay_ns = 20 * SCALE_US;
 
-    s->adb_poll_timer = timer_new_ms(QEMU_CLOCK_VIRTUAL, cuda_adb_poll, s);
-    s->adb_poll_mask = 0xffff;
-    s->autopoll_rate_ms = 20;
+    adb_register_autopoll_callback(adb_bus, cuda_adb_poll, s);
 }
 
 static void cuda_init(Object *obj)
diff --git a/include/hw/misc/macio/cuda.h b/include/hw/misc/macio/cuda.h
index 5768075ac5..a8cf0be1ec 100644
--- a/include/hw/misc/macio/cuda.h
+++ b/include/hw/misc/macio/cuda.h
@@ -95,12 +95,8 @@ typedef struct CUDAState {
     int data_out_index;
 
     qemu_irq irq;
-    uint16_t adb_poll_mask;
-    uint8_t autopoll_rate_ms;
-    uint8_t autopoll;
     uint8_t data_in[128];
     uint8_t data_out[16];
-    QEMUTimer *adb_poll_timer;
 } CUDAState;
 
 #endif /* CUDA_H */
-- 
2.20.1


