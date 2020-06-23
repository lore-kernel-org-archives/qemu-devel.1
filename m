Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B09C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 20:53:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CDE720738
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 20:53:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CDE720738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnpvU-0000SA-NX
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 16:53:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44986)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jnprk-00038X-05; Tue, 23 Jun 2020 16:50:00 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167]:56340
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jnpri-0001JB-3K; Tue, 23 Jun 2020 16:49:59 -0400
Received: from host86-158-109-79.range86-158.btcentralplus.com
 ([86.158.109.79] helo=kentang.home)
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1jnprf-0007T1-Ab; Tue, 23 Jun 2020 21:50:00 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, laurent@vivier.eu,
 fthain@telegraphics.com.au
Date: Tue, 23 Jun 2020 21:49:16 +0100
Message-Id: <20200623204936.24064-3-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200623204936.24064-1-mark.cave-ayland@ilande.co.uk>
References: <20200623204936.24064-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.158.109.79
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 02/22] adb: fix adb-mouse read length and revert
 disable-reg3-direct-writes workaround
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

Commit 84051eb400 "adb: add property to disable direct reg 3 writes" introduced
a workaround for spurious writes to ADB register 3 when MacOS 9 enables
autopoll on the mouse device. Further analysis shows that the problem is that
only a partial request is sent, and since the len parameter is ignored then
stale data from the previous request is used causing the incorrect address
assignment.

Remove the disable-reg3-direct-writes workaround and instead check the length
parameter when the write is attempted, discarding the invalid request.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Tested-by: Finn Thain <fthain@telegraphics.com.au>
---
 hw/input/adb-kbd.c     | 26 +++++++++++------------
 hw/input/adb-mouse.c   | 48 ++++++++++++++++++++++++------------------
 hw/input/adb.c         |  7 ------
 hw/ppc/mac_newworld.c  |  2 --
 include/hw/input/adb.h |  1 -
 5 files changed, 40 insertions(+), 44 deletions(-)

diff --git a/hw/input/adb-kbd.c b/hw/input/adb-kbd.c
index a6d5c9b7c9..027dd3e531 100644
--- a/hw/input/adb-kbd.c
+++ b/hw/input/adb-kbd.c
@@ -259,21 +259,19 @@ static int adb_kbd_request(ADBDevice *d, uint8_t *obuf,
                 trace_adb_kbd_request_change_addr(d->devaddr);
                 break;
             default:
-                if (!d->disable_direct_reg3_writes) {
-                    d->devaddr = buf[1] & 0xf;
-
-                    /* we support handlers:
-                     * 1: Apple Standard Keyboard
-                     * 2: Apple Extended Keyboard (LShift = RShift)
-                     * 3: Apple Extended Keyboard (LShift != RShift)
-                     */
-                    if (buf[2] == 1 || buf[2] == 2 || buf[2] == 3) {
-                        d->handler = buf[2];
-                    }
-
-                    trace_adb_kbd_request_change_addr_and_handler(d->devaddr,
-                                                                  d->handler);
+                d->devaddr = buf[1] & 0xf;
+                /*
+                 * we support handlers:
+                 * 1: Apple Standard Keyboard
+                 * 2: Apple Extended Keyboard (LShift = RShift)
+                 * 3: Apple Extended Keyboard (LShift != RShift)
+                 */
+                if (buf[2] == 1 || buf[2] == 2 || buf[2] == 3) {
+                    d->handler = buf[2];
                 }
+
+                trace_adb_kbd_request_change_addr_and_handler(d->devaddr,
+                                                              d->handler);
                 break;
             }
         }
diff --git a/hw/input/adb-mouse.c b/hw/input/adb-mouse.c
index aeba41bddd..78b6f5030c 100644
--- a/hw/input/adb-mouse.c
+++ b/hw/input/adb-mouse.c
@@ -135,6 +135,16 @@ static int adb_mouse_request(ADBDevice *d, uint8_t *obuf,
         case 2:
             break;
         case 3:
+            /*
+             * MacOS 9 has a bug in its ADB driver whereby after configuring
+             * the ADB bus devices it sends another write of invalid length
+             * to reg 3. Make sure we ignore it to prevent an address clash
+             * with the previous device.
+             */
+            if (len != 3) {
+                return 0;
+            }
+
             switch (buf[2]) {
             case ADB_CMD_SELF_TEST:
                 break;
@@ -145,27 +155,25 @@ static int adb_mouse_request(ADBDevice *d, uint8_t *obuf,
                 trace_adb_mouse_request_change_addr(d->devaddr);
                 break;
             default:
-                if (!d->disable_direct_reg3_writes) {
-                    d->devaddr = buf[1] & 0xf;
-
-                    /* we support handlers:
-                     * 0x01: Classic Apple Mouse Protocol / 100 cpi operations
-                     * 0x02: Classic Apple Mouse Protocol / 200 cpi operations
-                     * we don't support handlers (at least):
-                     * 0x03: Mouse systems A3 trackball
-                     * 0x04: Extended Apple Mouse Protocol
-                     * 0x2f: Microspeed mouse
-                     * 0x42: Macally
-                     * 0x5f: Microspeed mouse
-                     * 0x66: Microspeed mouse
-                     */
-                    if (buf[2] == 1 || buf[2] == 2) {
-                        d->handler = buf[2];
-                    }
-
-                    trace_adb_mouse_request_change_addr_and_handler(
-                        d->devaddr, d->handler);
+                d->devaddr = buf[1] & 0xf;
+                /*
+                 * we support handlers:
+                 * 0x01: Classic Apple Mouse Protocol / 100 cpi operations
+                 * 0x02: Classic Apple Mouse Protocol / 200 cpi operations
+                 * we don't support handlers (at least):
+                 * 0x03: Mouse systems A3 trackball
+                 * 0x04: Extended Apple Mouse Protocol
+                 * 0x2f: Microspeed mouse
+                 * 0x42: Macally
+                 * 0x5f: Microspeed mouse
+                 * 0x66: Microspeed mouse
+                 */
+                if (buf[2] == 1 || buf[2] == 2) {
+                    d->handler = buf[2];
                 }
+
+                trace_adb_mouse_request_change_addr_and_handler(d->devaddr,
+                                                                d->handler);
                 break;
             }
         }
diff --git a/hw/input/adb.c b/hw/input/adb.c
index bf1bc30d19..d85278a7b7 100644
--- a/hw/input/adb.c
+++ b/hw/input/adb.c
@@ -118,18 +118,11 @@ static void adb_device_realizefn(DeviceState *dev, Error **errp)
     bus->devices[bus->nb_devices++] = d;
 }
 
-static Property adb_device_properties[] = {
-    DEFINE_PROP_BOOL("disable-direct-reg3-writes", ADBDevice,
-                     disable_direct_reg3_writes, false),
-    DEFINE_PROP_END_OF_LIST(),
-};
-
 static void adb_device_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
     dc->realize = adb_device_realizefn;
-    device_class_set_props(dc, adb_device_properties);
     dc->bus_type = TYPE_ADB_BUS;
 }
 
diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index 5f3a028e6a..828c5992ae 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -404,11 +404,9 @@ static void ppc_core99_init(MachineState *machine)
 
         adb_bus = qdev_get_child_bus(dev, "adb.0");
         dev = qdev_new(TYPE_ADB_KEYBOARD);
-        qdev_prop_set_bit(dev, "disable-direct-reg3-writes", true);
         qdev_realize_and_unref(dev, adb_bus, &error_fatal);
 
         dev = qdev_new(TYPE_ADB_MOUSE);
-        qdev_prop_set_bit(dev, "disable-direct-reg3-writes", true);
         qdev_realize_and_unref(dev, adb_bus, &error_fatal);
     }
 
diff --git a/include/hw/input/adb.h b/include/hw/input/adb.h
index b7b32e2b16..4d2c565f54 100644
--- a/include/hw/input/adb.h
+++ b/include/hw/input/adb.h
@@ -49,7 +49,6 @@ struct ADBDevice {
 
     int devaddr;
     int handler;
-    bool disable_direct_reg3_writes;
 };
 
 #define ADB_DEVICE_CLASS(cls) \
-- 
2.20.1


