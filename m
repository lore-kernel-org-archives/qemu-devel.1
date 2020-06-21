Return-Path: <SRS0=M+f9=AC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A8AC433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2020 14:53:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AADD251C5
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2020 14:53:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AADD251C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jn1Ll-0006Kr-SW
	for qemu-devel@archiver.kernel.org; Sun, 21 Jun 2020 10:53:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37992)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jn1Kv-0005IB-6j
 for qemu-devel@nongnu.org; Sun, 21 Jun 2020 10:52:45 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:52758)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jn1Kr-00022w-Q8
 for qemu-devel@nongnu.org; Sun, 21 Jun 2020 10:52:44 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id C759074594E;
 Sun, 21 Jun 2020 16:52:35 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 9E241745712; Sun, 21 Jun 2020 16:52:35 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH] i2c: Match parameters of i2c_start_transfer and i2c_send_recv
Date: Sun, 21 Jun 2020 16:43:38 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org
Message-Id: <20200621145235.9E241745712@zero.eik.bme.hu>
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
Cc: Corey Minyard <cminyard@mvista.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
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
Looks like hw/misc/auxbus.c already got this wrong and calls both
i2c_start_transfer and i2c_send_recv with same is_write parameter.
Although the name of the is_write variable suggest this may need to be
inverted I'm not sure what that value actially means and which usage
was correct so I did not touch it. Someone knowing this device might
want to review and fix it.

 hw/display/sm501.c   |  2 +-
 hw/i2c/core.c        | 34 +++++++++++++++++-----------------
 hw/i2c/ppc4xx_i2c.c  |  2 +-
 include/hw/i2c/i2c.h |  4 ++--
 4 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index 2db347dcbc..ccd0a6e376 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -1034,7 +1034,7 @@ static void sm501_i2c_write(void *opaque, hwaddr addr, uint64_t value,
                     int i;
                     for (i = 0; i <= s->i2c_byte_count; i++) {
                         res = i2c_send_recv(s->i2c_bus, &s->i2c_data[i],
-                                            !(s->i2c_addr & 1));
+                                            s->i2c_addr & 1);
                         if (res) {
                             s->i2c_status |= SM501_I2C_STATUS_ERROR;
                             return;
diff --git a/hw/i2c/core.c b/hw/i2c/core.c
index 1aac457a2a..c9d01df427 100644
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
index 4117211565..a09ab9230b 100644
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


