Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9296BC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 14:00:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 687B4205ED
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 14:00:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 687B4205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGk6M-00056e-HF
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 10:00:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53308)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <geert@linux-m68k.org>) id 1jGk3K-000061-Un
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 09:57:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <geert@linux-m68k.org>) id 1jGk3J-0006GG-1m
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 09:57:10 -0400
Received: from laurent.telenet-ops.be ([2a02:1800:110:4::f00:19]:56650)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <geert@linux-m68k.org>)
 id 1jGk3I-0006CE-Hq
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 09:57:08 -0400
Received: from ramsan ([84.195.182.253]) by laurent.telenet-ops.be with bizsmtp
 id JDwu2200H5USYZQ01Dwulu; Tue, 24 Mar 2020 14:57:05 +0100
Received: from rox.of.borg ([192.168.97.57]) by ramsan with esmtp (Exim 4.90_1)
 (envelope-from <geert@linux-m68k.org>)
 id 1jGk34-0006Ol-KV; Tue, 24 Mar 2020 14:56:54 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
 (envelope-from <geert@linux-m68k.org>)
 id 1jGk34-0001kf-Ih; Tue, 24 Mar 2020 14:56:54 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Harish Jenny K N <harish_kandiga@mentor.com>,
 Eugeniu Rosca <erosca@de.adit-jv.com>
Subject: [PATCH v6 4/8] gpiolib: Add support for GPIO lookup by line name
Date: Tue, 24 Mar 2020 14:56:49 +0100
Message-Id: <20200324135653.6676-4-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200324135653.6676-1-geert+renesas@glider.be>
References: <20200324135328.5796-1-geert+renesas@glider.be>
 <20200324135653.6676-1-geert+renesas@glider.be>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 2a02:1800:110:4::f00:19
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Geert Uytterhoeven <geert+renesas@glider.be>, linux-doc@vger.kernel.org,
 Marc Zyngier <marc.zyngier@arm.com>, Magnus Damm <magnus.damm@gmail.com>,
 Christoffer Dall <christoffer.dall@arm.com>, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, Alexander Graf <graf@amazon.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Phil Reid <preid@electromag.com.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently a GPIO lookup table can only refer to a specific GPIO by a
tuple, consisting of a GPIO controller label and a GPIO offset inside
the controller.

However, a GPIO may also carry a line name, defined by DT or ACPI.
If present, the line name is the most use-centric way to refer to a
GPIO.  Hence add support for looking up GPIOs by line name.

Implement this by reusing the existing gpiod_lookup infrastructure.
Rename gpiod_lookup.chip_label to gpiod_lookup.key, to make it clear
that this field can have two meanings, and update the kerneldoc and
GPIO_LOOKUP*() macros.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Ulrich Hecht <uli+renesas@fpond.eu>
Reviewed-by: Eugeniu Rosca <erosca@de.adit-jv.com>
Tested-by: Eugeniu Rosca <erosca@de.adit-jv.com>
---
v6:
  - Update Documentation/driver-api/gpio/board.rst,
  - Reword rationale,

v5:
  - Add Reviewed-by, Tested-by,

v4:
  - Add Reviewed-by,
  - Rename gpiod_lookup.chip_label.
  - Use U16_MAX instead of (u16)-1,

v3:
  - New.
---
 Documentation/driver-api/gpio/board.rst | 10 ++++++----
 drivers/gpio/gpiolib.c                  | 22 +++++++++++++++++-----
 include/linux/gpio/machine.h            | 15 ++++++++-------
 3 files changed, 31 insertions(+), 16 deletions(-)

diff --git a/Documentation/driver-api/gpio/board.rst b/Documentation/driver-api/gpio/board.rst
index ce91518bf9f48ded..0ad1f8cacf5e5d26 100644
--- a/Documentation/driver-api/gpio/board.rst
+++ b/Documentation/driver-api/gpio/board.rst
@@ -113,13 +113,15 @@ files that desire to do so need to include the following header::
 GPIOs are mapped by the means of tables of lookups, containing instances of the
 gpiod_lookup structure. Two macros are defined to help declaring such mappings::
 
-	GPIO_LOOKUP(chip_label, chip_hwnum, con_id, flags)
-	GPIO_LOOKUP_IDX(chip_label, chip_hwnum, con_id, idx, flags)
+	GPIO_LOOKUP(key, chip_hwnum, con_id, flags)
+	GPIO_LOOKUP_IDX(key, chip_hwnum, con_id, idx, flags)
 
 where
 
-  - chip_label is the label of the gpiod_chip instance providing the GPIO
-  - chip_hwnum is the hardware number of the GPIO within the chip
+  - key is either the label of the gpiod_chip instance providing the GPIO, or
+    the GPIO line name
+  - chip_hwnum is the hardware number of the GPIO within the chip, or U16_MAX
+    to indicate that key is a GPIO line name
   - con_id is the name of the GPIO function from the device point of view. It
 	can be NULL, in which case it will match any function.
   - idx is the index of the GPIO within the function.
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 8d7366f4451fe695..c756602e249c052e 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -4643,7 +4643,7 @@ static struct gpio_desc *gpiod_find(struct device *dev, const char *con_id,
 	if (!table)
 		return desc;
 
-	for (p = &table->table[0]; p->chip_label; p++) {
+	for (p = &table->table[0]; p->key; p++) {
 		struct gpio_chip *chip;
 
 		/* idx must always match exactly */
@@ -4654,18 +4654,30 @@ static struct gpio_desc *gpiod_find(struct device *dev, const char *con_id,
 		if (p->con_id && (!con_id || strcmp(p->con_id, con_id)))
 			continue;
 
-		chip = find_chip_by_name(p->chip_label);
+		if (p->chip_hwnum == U16_MAX) {
+			desc = gpio_name_to_desc(p->key);
+			if (desc) {
+				*flags = p->flags;
+				return desc;
+			}
+
+			dev_warn(dev, "cannot find GPIO line %s, deferring\n",
+				 p->key);
+			return ERR_PTR(-EPROBE_DEFER);
+		}
+
+		chip = find_chip_by_name(p->key);
 
 		if (!chip) {
 			/*
 			 * As the lookup table indicates a chip with
-			 * p->chip_label should exist, assume it may
+			 * p->key should exist, assume it may
 			 * still appear later and let the interested
 			 * consumer be probed again or let the Deferred
 			 * Probe infrastructure handle the error.
 			 */
 			dev_warn(dev, "cannot find GPIO chip %s, deferring\n",
-				 p->chip_label);
+				 p->key);
 			return ERR_PTR(-EPROBE_DEFER);
 		}
 
@@ -4696,7 +4708,7 @@ static int platform_gpio_count(struct device *dev, const char *con_id)
 	if (!table)
 		return -ENOENT;
 
-	for (p = &table->table[0]; p->chip_label; p++) {
+	for (p = &table->table[0]; p->key; p++) {
 		if ((con_id && p->con_id && !strcmp(con_id, p->con_id)) ||
 		    (!con_id && !p->con_id))
 			count++;
diff --git a/include/linux/gpio/machine.h b/include/linux/gpio/machine.h
index 1ebe5be05d5f81fa..84c66fbf54fd5811 100644
--- a/include/linux/gpio/machine.h
+++ b/include/linux/gpio/machine.h
@@ -20,8 +20,9 @@ enum gpio_lookup_flags {
 
 /**
  * struct gpiod_lookup - lookup table
- * @chip_label: name of the chip the GPIO belongs to
- * @chip_hwnum: hardware number (i.e. relative to the chip) of the GPIO
+ * @key: either the name of the chip the GPIO belongs to, or the GPIO line name
+ * @chip_hwnum: hardware number (i.e. relative to the chip) of the GPIO, or
+ *              U16_MAX to indicate that @key is a GPIO line name
  * @con_id: name of the GPIO from the device's point of view
  * @idx: index of the GPIO in case several GPIOs share the same name
  * @flags: bitmask of gpio_lookup_flags GPIO_* values
@@ -30,7 +31,7 @@ enum gpio_lookup_flags {
  * functions using platform data.
  */
 struct gpiod_lookup {
-	const char *chip_label;
+	const char *key;
 	u16 chip_hwnum;
 	const char *con_id;
 	unsigned int idx;
@@ -63,17 +64,17 @@ struct gpiod_hog {
 /*
  * Simple definition of a single GPIO under a con_id
  */
-#define GPIO_LOOKUP(_chip_label, _chip_hwnum, _con_id, _flags) \
-	GPIO_LOOKUP_IDX(_chip_label, _chip_hwnum, _con_id, 0, _flags)
+#define GPIO_LOOKUP(_key, _chip_hwnum, _con_id, _flags) \
+	GPIO_LOOKUP_IDX(_key, _chip_hwnum, _con_id, 0, _flags)
 
 /*
  * Use this macro if you need to have several GPIOs under the same con_id.
  * Each GPIO needs to use a different index and can be accessed using
  * gpiod_get_index()
  */
-#define GPIO_LOOKUP_IDX(_chip_label, _chip_hwnum, _con_id, _idx, _flags)  \
+#define GPIO_LOOKUP_IDX(_key, _chip_hwnum, _con_id, _idx, _flags)         \
 {                                                                         \
-	.chip_label = _chip_label,                                        \
+	.key = _key,                                                      \
 	.chip_hwnum = _chip_hwnum,                                        \
 	.con_id = _con_id,                                                \
 	.idx = _idx,                                                      \
-- 
2.17.1


