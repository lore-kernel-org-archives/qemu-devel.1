Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5708C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 14:56:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6FAD20643
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 14:56:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6FAD20643
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY9qf-0003ll-RC
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 10:56:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34496)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <geert@linux-m68k.org>)
 id 1jY9nv-0004xK-VZ
 for qemu-devel@nongnu.org; Mon, 11 May 2020 10:53:17 -0400
Received: from baptiste.telenet-ops.be ([2a02:1800:120:4::f00:13]:59816)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <geert@linux-m68k.org>)
 id 1jY9ns-0000dP-UQ
 for qemu-devel@nongnu.org; Mon, 11 May 2020 10:53:15 -0400
Received: from ramsan ([IPv6:2a02:1810:ac12:ed60:702c:fb99:3097:2049])
 by baptiste.telenet-ops.be with bizsmtp
 id dSsy2200G0GoAb601SsyU6; Mon, 11 May 2020 16:53:08 +0200
Received: from rox.of.borg ([192.168.97.57]) by ramsan with esmtp (Exim 4.90_1)
 (envelope-from <geert@linux-m68k.org>)
 id 1jY9ne-00082j-3k; Mon, 11 May 2020 16:52:58 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
 (envelope-from <geert@linux-m68k.org>)
 id 1jY9ne-0005zX-2C; Mon, 11 May 2020 16:52:58 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Harish Jenny K N <harish_kandiga@mentor.com>,
 Eugeniu Rosca <erosca@de.adit-jv.com>
Subject: [PATCH v7 3/6] gpiolib: Add support for GPIO lookup by line name
Date: Mon, 11 May 2020 16:52:54 +0200
Message-Id: <20200511145257.22970-4-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200511145257.22970-1-geert+renesas@glider.be>
References: <20200511145257.22970-1-geert+renesas@glider.be>
Received-SPF: none client-ip=2a02:1800:120:4::f00:13;
 envelope-from=geert@linux-m68k.org; helo=baptiste.telenet-ops.be
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_LOW=-0.7,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Geert Uytterhoeven <geert+renesas@glider.be>, linux-doc@vger.kernel.org,
 Marc Zyngier <marc.zyngier@arm.com>, Magnus Damm <magnus.damm@gmail.com>,
 Christoffer Dall <christoffer.dall@arm.com>, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
 Alexander Graf <graf@amazon.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Phil Reid <preid@electromag.com.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently a GPIO lookup table can only refer to a specific GPIO by a
tuple, consisting of a GPIO controller label and a GPIO offset inside
the controller.

However, a GPIO may also carry a line name, defined by DT or ACPI.
If present, the line name is the most use-centric way to refer to a
GPIO.  Hence add support for looking up GPIOs by line name.
Note that there is no guarantee that GPIO line names are globally
unique, so this will use the first match found.

Implement this by reusing the existing gpiod_lookup infrastructure.
Rename gpiod_lookup.chip_label to gpiod_lookup.key, to make it clear
that this field can have two meanings, and update the kerneldoc and
GPIO_LOOKUP*() macros.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Ulrich Hecht <uli+renesas@fpond.eu>
Reviewed-by: Eugeniu Rosca <erosca@de.adit-jv.com>
Tested-by: Eugeniu Rosca <erosca@de.adit-jv.com>
---
v7:
  - Document non-uniqueness of line names,
  - Rebase on top of commit a0b66a73785ccc8f ("gpio: Rename variable in
    core APIs"),

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
 Documentation/driver-api/gpio/board.rst | 15 ++++++++++-----
 drivers/gpio/gpiolib.c                  | 22 +++++++++++++++++-----
 include/linux/gpio/machine.h            | 17 ++++++++++-------
 3 files changed, 37 insertions(+), 17 deletions(-)

diff --git a/Documentation/driver-api/gpio/board.rst b/Documentation/driver-api/gpio/board.rst
index ce91518bf9f48ded..191fa867826a45c3 100644
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
@@ -135,7 +137,10 @@ where
 
 In the future, these flags might be extended to support more properties.
 
-Note that GPIO_LOOKUP() is just a shortcut to GPIO_LOOKUP_IDX() where idx = 0.
+Note that:
+  1. GPIO line names are not guaranteed to be globally unique, so the first
+     match found will be used.
+  2. GPIO_LOOKUP() is just a shortcut to GPIO_LOOKUP_IDX() where idx = 0.
 
 A lookup table can then be defined as follows, with an empty entry defining its
 end. The 'dev_id' field of the table is the identifier of the device that will
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 98822412f565073a..2e4aacbad8fe586b 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -4645,7 +4645,7 @@ static struct gpio_desc *gpiod_find(struct device *dev, const char *con_id,
 	if (!table)
 		return desc;
 
-	for (p = &table->table[0]; p->chip_label; p++) {
+	for (p = &table->table[0]; p->key; p++) {
 		struct gpio_chip *gc;
 
 		/* idx must always match exactly */
@@ -4656,18 +4656,30 @@ static struct gpio_desc *gpiod_find(struct device *dev, const char *con_id,
 		if (p->con_id && (!con_id || strcmp(p->con_id, con_id)))
 			continue;
 
-		gc = find_chip_by_name(p->chip_label);
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
+		gc = find_chip_by_name(p->key);
 
 		if (!gc) {
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
 
@@ -4698,7 +4710,7 @@ static int platform_gpio_count(struct device *dev, const char *con_id)
 	if (!table)
 		return -ENOENT;
 
-	for (p = &table->table[0]; p->chip_label; p++) {
+	for (p = &table->table[0]; p->key; p++) {
 		if ((con_id && p->con_id && !strcmp(con_id, p->con_id)) ||
 		    (!con_id && !p->con_id))
 			count++;
diff --git a/include/linux/gpio/machine.h b/include/linux/gpio/machine.h
index 1ebe5be05d5f81fa..781a053abbb99a1d 100644
--- a/include/linux/gpio/machine.h
+++ b/include/linux/gpio/machine.h
@@ -20,8 +20,11 @@ enum gpio_lookup_flags {
 
 /**
  * struct gpiod_lookup - lookup table
- * @chip_label: name of the chip the GPIO belongs to
- * @chip_hwnum: hardware number (i.e. relative to the chip) of the GPIO
+ * @key: either the name of the chip the GPIO belongs to, or the GPIO line name
+ *       Note that GPIO line names are not guaranteed to be globally unique,
+ *       so this will use the first match found!
+ * @chip_hwnum: hardware number (i.e. relative to the chip) of the GPIO, or
+ *              U16_MAX to indicate that @key is a GPIO line name
  * @con_id: name of the GPIO from the device's point of view
  * @idx: index of the GPIO in case several GPIOs share the same name
  * @flags: bitmask of gpio_lookup_flags GPIO_* values
@@ -30,7 +33,7 @@ enum gpio_lookup_flags {
  * functions using platform data.
  */
 struct gpiod_lookup {
-	const char *chip_label;
+	const char *key;
 	u16 chip_hwnum;
 	const char *con_id;
 	unsigned int idx;
@@ -63,17 +66,17 @@ struct gpiod_hog {
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


