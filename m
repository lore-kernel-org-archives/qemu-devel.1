Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC4BFC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 21:00:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B48C420663
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 21:00:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B48C420663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnq1m-0004st-U5
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 17:00:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45466)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jnpsf-0004vO-Oj; Tue, 23 Jun 2020 16:50:57 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167]:56436
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jnpsd-0001ub-Un; Tue, 23 Jun 2020 16:50:57 -0400
Received: from host86-158-109-79.range86-158.btcentralplus.com
 ([86.158.109.79] helo=kentang.home)
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jnpsb-0007T1-B4; Tue, 23 Jun 2020 21:50:57 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, laurent@vivier.eu,
 fthain@telegraphics.com.au
Date: Tue, 23 Jun 2020 21:49:27 +0100
Message-Id: <20200623204936.24064-14-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200623204936.24064-1-mark.cave-ayland@ilande.co.uk>
References: <20200623204936.24064-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.158.109.79
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 13/22] adb: add status field for holding information about
 the last ADB request
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

Currently only 2 bits are defined: one to indicate if the request timed out (no
reply) and another to indicate whether the request was the result of an autopoll
operation.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Tested-by: Finn Thain <fthain@telegraphics.com.au>
---
 hw/input/adb.c         | 14 +++++++++++---
 include/hw/input/adb.h |  4 ++++
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/hw/input/adb.c b/hw/input/adb.c
index c1adb21e6b..a7a482fdfa 100644
--- a/hw/input/adb.c
+++ b/hw/input/adb.c
@@ -42,7 +42,7 @@ int adb_request(ADBBusState *s, uint8_t *obuf, const uint8_t *buf, int len)
 {
     ADBDevice *d;
     ADBDeviceClass *adc;
-    int devaddr, cmd, i;
+    int devaddr, cmd, olen, i;
 
     cmd = buf[0] & 0xf;
     if (cmd == ADB_BUSRESET) {
@@ -50,6 +50,7 @@ int adb_request(ADBBusState *s, uint8_t *obuf, const uint8_t *buf, int len)
             d = s->devices[i];
             adb_device_reset(d);
         }
+        s->status = 0;
         return 0;
     }
 
@@ -63,16 +64,22 @@ int adb_request(ADBBusState *s, uint8_t *obuf, const uint8_t *buf, int len)
         }
     }
 
+    s->status = 0;
     devaddr = buf[0] >> 4;
     for (i = 0; i < s->nb_devices; i++) {
         d = s->devices[i];
         adc = ADB_DEVICE_GET_CLASS(d);
 
         if (d->devaddr == devaddr) {
-            return adc->devreq(d, obuf, buf, len);
+            olen = adc->devreq(d, obuf, buf, len);
+            if (!olen) {
+                s->status |= ADB_STATUS_BUSTIMEOUT;
+            }
+            return olen;
         }
     }
 
+    s->status |= ADB_STATUS_BUSTIMEOUT;
     return ADB_RET_NOTPRESENT;
 }
 
@@ -94,9 +101,10 @@ int adb_poll(ADBBusState *s, uint8_t *obuf, uint16_t poll_mask)
             olen = adb_request(s, obuf + 1, buf, 1);
             /* if there is data, we poll again the same device */
             if (olen > 0) {
+                s->status |= ADB_STATUS_POLLREPLY;
                 obuf[0] = buf[0];
                 olen++;
-                break;
+                return olen;
             }
         }
         s->poll_index++;
diff --git a/include/hw/input/adb.h b/include/hw/input/adb.h
index f1bc358d8e..cff264739c 100644
--- a/include/hw/input/adb.h
+++ b/include/hw/input/adb.h
@@ -70,6 +70,9 @@ typedef struct ADBDeviceClass {
 #define TYPE_ADB_BUS "apple-desktop-bus"
 #define ADB_BUS(obj) OBJECT_CHECK(ADBBusState, (obj), TYPE_ADB_BUS)
 
+#define ADB_STATUS_BUSTIMEOUT  0x1
+#define ADB_STATUS_POLLREPLY   0x2
+
 struct ADBBusState {
     /*< private >*/
     BusState parent_obj;
@@ -79,6 +82,7 @@ struct ADBBusState {
     uint16_t pending;
     int nb_devices;
     int poll_index;
+    uint8_t status;
 
     QEMUTimer *autopoll_timer;
     bool autopoll_enabled;
-- 
2.20.1


