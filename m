Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FEAEC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 20:55:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66BC820656
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 20:55:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66BC820656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnpxK-0004cm-Jj
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 16:55:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45266)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jnpsA-00047Q-Jn; Tue, 23 Jun 2020 16:50:26 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167]:56384
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jnps8-0001b5-PE; Tue, 23 Jun 2020 16:50:26 -0400
Received: from host86-158-109-79.range86-158.btcentralplus.com
 ([86.158.109.79] helo=kentang.home)
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jnps3-0007T1-Te; Tue, 23 Jun 2020 21:50:26 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, laurent@vivier.eu,
 fthain@telegraphics.com.au
Date: Tue, 23 Jun 2020 21:49:21 +0100
Message-Id: <20200623204936.24064-8-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200623204936.24064-1-mark.cave-ayland@ilande.co.uk>
References: <20200623204936.24064-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.158.109.79
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 07/22] adb: create autopoll variables directly within
 ADBBusState
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

Rather than each ADB implementation requiring its own functions to manage
autopoll state, timers, and autopoll masks prepare to move this information
directly into ADBBusState.

Add external functions within adb.h to allow each ADB implementation to
manage the new autopoll variables.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Tested-by: Finn Thain <fthain@telegraphics.com.au>
---
 hw/input/adb.c         | 77 ++++++++++++++++++++++++++++++++++++++++++
 include/hw/input/adb.h | 13 +++++++
 2 files changed, 90 insertions(+)

diff --git a/hw/input/adb.c b/hw/input/adb.c
index 21a9b3aa96..bb36ce6fad 100644
--- a/hw/input/adb.c
+++ b/hw/input/adb.c
@@ -27,6 +27,7 @@
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
+#include "qemu/timer.h"
 #include "adb-internal.h"
 
 /* error codes */
@@ -89,19 +90,92 @@ int adb_poll(ADBBusState *s, uint8_t *obuf, uint16_t poll_mask)
     return olen;
 }
 
+void adb_set_autopoll_enabled(ADBBusState *s, bool enabled)
+{
+    if (s->autopoll_enabled != enabled) {
+        s->autopoll_enabled = enabled;
+        if (s->autopoll_enabled) {
+            timer_mod(s->autopoll_timer,
+                      qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) +
+                      s->autopoll_rate_ms);
+        } else {
+            timer_del(s->autopoll_timer);
+        }
+    }
+}
+
+void adb_set_autopoll_rate_ms(ADBBusState *s, int rate_ms)
+{
+    s->autopoll_rate_ms = rate_ms;
+
+    if (s->autopoll_enabled) {
+        timer_mod(s->autopoll_timer,
+                  qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) +
+                  s->autopoll_rate_ms);
+    }
+}
+
+void adb_set_autopoll_mask(ADBBusState *s, uint16_t mask)
+{
+    if (s->autopoll_mask != mask) {
+        s->autopoll_mask = mask;
+        if (s->autopoll_enabled && s->autopoll_mask) {
+            timer_mod(s->autopoll_timer,
+                      qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) +
+                      s->autopoll_rate_ms);
+        } else {
+            timer_del(s->autopoll_timer);
+        }
+    }
+}
+
+static void adb_autopoll(void *opaque)
+{
+    ADBBusState *s = opaque;
+
+    s->autopoll_cb(s->autopoll_cb_opaque);
+
+    timer_mod(s->autopoll_timer,
+              qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) +
+              s->autopoll_rate_ms);
+}
+
+void adb_register_autopoll_callback(ADBBusState *s, void (*cb)(void *opaque),
+                                    void *opaque)
+{
+    s->autopoll_cb = cb;
+    s->autopoll_cb_opaque = opaque;
+}
+
 static const VMStateDescription vmstate_adb_bus = {
     .name = "adb_bus",
     .version_id = 0,
     .minimum_version_id = 0,
     .fields = (VMStateField[]) {
+        VMSTATE_TIMER_PTR(autopoll_timer, ADBBusState),
+        VMSTATE_BOOL(autopoll_enabled, ADBBusState),
+        VMSTATE_UINT8(autopoll_rate_ms, ADBBusState),
+        VMSTATE_UINT16(autopoll_mask, ADBBusState),
         VMSTATE_END_OF_LIST()
     }
 };
 
+static void adb_bus_reset(BusState *qbus)
+{
+    ADBBusState *adb_bus = ADB_BUS(qbus);
+
+    adb_bus->autopoll_enabled = false;
+    adb_bus->autopoll_mask = 0xffff;
+    adb_bus->autopoll_rate_ms = 20;
+}
+
 static void adb_bus_realize(BusState *qbus, Error **errp)
 {
     ADBBusState *adb_bus = ADB_BUS(qbus);
 
+    adb_bus->autopoll_timer = timer_new_ms(QEMU_CLOCK_VIRTUAL, adb_autopoll,
+                                           adb_bus);
+
     vmstate_register(NULL, -1, &vmstate_adb_bus, adb_bus);
 }
 
@@ -109,6 +183,8 @@ static void adb_bus_unrealize(BusState *qbus)
 {
     ADBBusState *adb_bus = ADB_BUS(qbus);
 
+    timer_del(adb_bus->autopoll_timer);
+
     vmstate_unregister(NULL, &vmstate_adb_bus, adb_bus);
 }
 
@@ -118,6 +194,7 @@ static void adb_bus_class_init(ObjectClass *klass, void *data)
 
     k->realize = adb_bus_realize;
     k->unrealize = adb_bus_unrealize;
+    k->reset = adb_bus_reset;
 }
 
 static const TypeInfo adb_bus_type_info = {
diff --git a/include/hw/input/adb.h b/include/hw/input/adb.h
index 4d2c565f54..15b1874a3d 100644
--- a/include/hw/input/adb.h
+++ b/include/hw/input/adb.h
@@ -75,12 +75,25 @@ struct ADBBusState {
     ADBDevice *devices[MAX_ADB_DEVICES];
     int nb_devices;
     int poll_index;
+
+    QEMUTimer *autopoll_timer;
+    bool autopoll_enabled;
+    uint8_t autopoll_rate_ms;
+    uint16_t autopoll_mask;
+    void (*autopoll_cb)(void *opaque);
+    void *autopoll_cb_opaque;
 };
 
 int adb_request(ADBBusState *s, uint8_t *buf_out,
                 const uint8_t *buf, int len);
 int adb_poll(ADBBusState *s, uint8_t *buf_out, uint16_t poll_mask);
 
+void adb_set_autopoll_enabled(ADBBusState *s, bool enabled);
+void adb_set_autopoll_rate_ms(ADBBusState *s, int rate_ms);
+void adb_set_autopoll_mask(ADBBusState *s, uint16_t mask);
+void adb_register_autopoll_callback(ADBBusState *s, void (*cb)(void *opaque),
+                                    void *opaque);
+
 #define TYPE_ADB_KEYBOARD "adb-keyboard"
 #define TYPE_ADB_MOUSE "adb-mouse"
 
-- 
2.20.1


