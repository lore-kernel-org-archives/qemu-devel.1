Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D557C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 19:31:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C60A2067D
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 19:31:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C60A2067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpzUa-0004ox-Gs
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 15:31:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51612)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jpzRJ-00086n-LR; Mon, 29 Jun 2020 15:27:37 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:42921)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jpzRG-0002IU-D4; Mon, 29 Jun 2020 15:27:37 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id C5608748DCA;
 Mon, 29 Jun 2020 21:27:18 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 1E4B4748DCC; Mon, 29 Jun 2020 21:27:18 +0200 (CEST)
Message-Id: <015adea83c4708c5ed32e561bc8d0691ef839764.1593456926.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1593456926.git.balaton@eik.bme.hu>
References: <cover.1593456926.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v7 6/8] i2c: Match parameters of i2c_start_transfer and
 i2c_send_recv
Date: Mon, 29 Jun 2020 20:55:26 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Howard Spoelstra <hsp.cat7@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These functions have a parameter that decides the direction of
transfer but totally confusingly they don't match but inverted sense.
To avoid frequent mistakes when using these functions change
i2c_send_recv to match i2c_start_transfer. Also use bool in
i2c_start_transfer instead of int to match i2c_send_recv.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
This probably won't be the solution accepted as Philippe has an
alternative series fixing this problem here:
https://lists.nongnu.org/archive/html/qemu-devel/2020-06/msg07022.html
but until that or something else is merged this will do for the next
patch. When this gets sorted out I'll send a rebased version.

 hw/display/sm501.c   |  2 +-
 hw/i2c/core.c        | 34 +++++++++++++++++-----------------
 hw/i2c/ppc4xx_i2c.c  |  2 +-
 include/hw/i2c/i2c.h |  4 ++--
 4 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index a7fc08c52b..e714674681 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -1041,7 +1041,7 @@ static void sm501_i2c_write(void *opaque, hwaddr addr, uint64_t value,
                                   s->i2c_byte_count + 1, s->i2c_addr >> 1);
                     for (i = 0; i <= s->i2c_byte_count; i++) {
                         res = i2c_send_recv(s->i2c_bus, &s->i2c_data[i],
-                                            !(s->i2c_addr & 1));
+                                            s->i2c_addr & 1);
                         if (res) {
                             SM501_DPRINTF("sm501 i2c : transfer failed"
                                           " i=%d, res=%d\n", i, res);
diff --git a/hw/i2c/core.c b/hw/i2c/core.c
index acf34a12d6..0303fefeaf 100644
--- a/hw/i2c/core.c
+++ b/hw/i2c/core.c
@@ -91,7 +91,7 @@ int i2c_bus_busy(I2CBus *bus)
  * without releasing the bus.  If that fails, the bus is still
  * in a transaction.
  */
-int i2c_start_transfer(I2CBus *bus, uint8_t address, int recv)
+int i2c_start_transfer(I2CBus *bus, uint8_t address, bool recv)
 {
     BusChild *kid;
     I2CSlaveClass *sc;
@@ -175,26 +175,14 @@ void i2c_end_transfer(I2CBus *bus)
     bus->broadcast = false;
 }
 
-int i2c_send_recv(I2CBus *bus, uint8_t *data, bool send)
+int i2c_send_recv(I2CBus *bus, uint8_t *data, bool recv)
 {
     I2CSlaveClass *sc;
     I2CSlave *s;
     I2CNode *node;
     int ret = 0;
 
-    if (send) {
-        QLIST_FOREACH(node, &bus->current_devs, next) {
-            s = node->elt;
-            sc = I2C_SLAVE_GET_CLASS(s);
-            if (sc->send) {
-                trace_i2c_send(s->address, *data);
-                ret = ret || sc->send(s, *data);
-            } else {
-                ret = -1;
-            }
-        }
-        return ret ? -1 : 0;
-    } else {
+    if (recv) {
         ret = 0xff;
         if (!QLIST_EMPTY(&bus->current_devs) && !bus->broadcast) {
             sc = I2C_SLAVE_GET_CLASS(QLIST_FIRST(&bus->current_devs)->elt);
@@ -206,19 +194,31 @@ int i2c_send_recv(I2CBus *bus, uint8_t *data, bool send)
         }
         *data = ret;
         return 0;
+    } else {
+        QLIST_FOREACH(node, &bus->current_devs, next) {
+            s = node->elt;
+            sc = I2C_SLAVE_GET_CLASS(s);
+            if (sc->send) {
+                trace_i2c_send(s->address, *data);
+                ret = ret || sc->send(s, *data);
+            } else {
+                ret = -1;
+            }
+        }
+        return ret ? -1 : 0;
     }
 }
 
 int i2c_send(I2CBus *bus, uint8_t data)
 {
-    return i2c_send_recv(bus, &data, true);
+    return i2c_send_recv(bus, &data, false);
 }
 
 uint8_t i2c_recv(I2CBus *bus)
 {
     uint8_t data = 0xff;
 
-    i2c_send_recv(bus, &data, false);
+    i2c_send_recv(bus, &data, true);
     return data;
 }
 
diff --git a/hw/i2c/ppc4xx_i2c.c b/hw/i2c/ppc4xx_i2c.c
index c0a8e04567..d3899203a4 100644
--- a/hw/i2c/ppc4xx_i2c.c
+++ b/hw/i2c/ppc4xx_i2c.c
@@ -239,7 +239,7 @@ static void ppc4xx_i2c_writeb(void *opaque, hwaddr addr, uint64_t value,
                     }
                 }
                 if (!(i2c->sts & IIC_STS_ERR) &&
-                    i2c_send_recv(i2c->bus, &i2c->mdata[i], !recv)) {
+                    i2c_send_recv(i2c->bus, &i2c->mdata[i], recv)) {
                     i2c->sts |= IIC_STS_ERR;
                     i2c->extsts |= IIC_EXTSTS_XFRA;
                     break;
diff --git a/include/hw/i2c/i2c.h b/include/hw/i2c/i2c.h
index d6e3d85faf..ad2475d6a2 100644
--- a/include/hw/i2c/i2c.h
+++ b/include/hw/i2c/i2c.h
@@ -72,10 +72,10 @@ struct I2CBus {
 I2CBus *i2c_init_bus(DeviceState *parent, const char *name);
 void i2c_set_slave_address(I2CSlave *dev, uint8_t address);
 int i2c_bus_busy(I2CBus *bus);
-int i2c_start_transfer(I2CBus *bus, uint8_t address, int recv);
+int i2c_start_transfer(I2CBus *bus, uint8_t address, bool recv);
 void i2c_end_transfer(I2CBus *bus);
 void i2c_nack(I2CBus *bus);
-int i2c_send_recv(I2CBus *bus, uint8_t *data, bool send);
+int i2c_send_recv(I2CBus *bus, uint8_t *data, bool recv);
 int i2c_send(I2CBus *bus, uint8_t data);
 uint8_t i2c_recv(I2CBus *bus);
 
-- 
2.21.3


