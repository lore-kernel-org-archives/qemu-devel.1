Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 496A6C2BAEE
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 13:58:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1ACE920714
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 13:58:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ACE920714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGk4s-00020u-1V
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 09:58:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53305)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <geert@linux-m68k.org>) id 1jGk3K-00005v-Td
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 09:57:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <geert@linux-m68k.org>) id 1jGk3J-0006Gp-8Q
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 09:57:10 -0400
Received: from albert.telenet-ops.be ([2a02:1800:110:4::f00:1a]:55116)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <geert@linux-m68k.org>)
 id 1jGk3I-0006CS-IE
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 09:57:08 -0400
Received: from ramsan ([84.195.182.253]) by albert.telenet-ops.be with bizsmtp
 id JDwu2200P5USYZQ06Dwua9; Tue, 24 Mar 2020 14:57:06 +0100
Received: from rox.of.borg ([192.168.97.57]) by ramsan with esmtp (Exim 4.90_1)
 (envelope-from <geert@linux-m68k.org>)
 id 1jGk34-0006On-Ln; Tue, 24 Mar 2020 14:56:54 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
 (envelope-from <geert@linux-m68k.org>)
 id 1jGk34-0001ki-Jv; Tue, 24 Mar 2020 14:56:54 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Harish Jenny K N <harish_kandiga@mentor.com>,
 Eugeniu Rosca <erosca@de.adit-jv.com>
Subject: [PATCH v6 5/8] gpiolib: Introduce gpiod_set_config()
Date: Tue, 24 Mar 2020 14:56:50 +0100
Message-Id: <20200324135653.6676-5-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200324135653.6676-1-geert+renesas@glider.be>
References: <20200324135328.5796-1-geert+renesas@glider.be>
 <20200324135653.6676-1-geert+renesas@glider.be>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 2a02:1800:110:4::f00:1a
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

The GPIO Aggregator will need a method to forward a .set_config() call
to its parent gpiochip.  This requires obtaining the gpio_chip and
offset for a given gpio_desc.  While gpiod_to_chip() is public,
gpio_chip_hwgpio() is not, so there is currently no method to obtain the
needed GPIO offset parameter.

Hence introduce a public gpiod_set_config() helper, which invokes the
.set_config() callback through a gpio_desc pointer, like is done for
most other gpio_chip callbacks.

Rewrite the existing gpiod_set_debounce() helper as a wrapper around
gpiod_set_config(), to avoid duplication.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v6:
  - New.
---
 drivers/gpio/gpiolib.c        | 28 ++++++++++++++++++++++------
 include/linux/gpio/consumer.h |  8 ++++++++
 2 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index c756602e249c052e..30ea75e972b5a3b1 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -3478,6 +3478,26 @@ int gpiod_direction_output(struct gpio_desc *desc, int value)
 }
 EXPORT_SYMBOL_GPL(gpiod_direction_output);
 
+/**
+ * gpiod_set_config - sets @config for a GPIO
+ * @desc: descriptor of the GPIO for which to set the configuration
+ * @config: Same packed config format as generic pinconf
+ *
+ * Returns:
+ * 0 on success, %-ENOTSUPP if the controller doesn't support setting the
+ * configuration.
+ */
+int gpiod_set_config(struct gpio_desc *desc, unsigned long config)
+{
+	struct gpio_chip *chip;
+
+	VALIDATE_DESC(desc);
+	chip = desc->gdev->chip;
+
+	return gpio_do_set_config(chip, gpio_chip_hwgpio(desc), config);
+}
+EXPORT_SYMBOL_GPL(gpiod_set_config);
+
 /**
  * gpiod_set_debounce - sets @debounce time for a GPIO
  * @desc: descriptor of the GPIO for which to set debounce time
@@ -3489,14 +3509,10 @@ EXPORT_SYMBOL_GPL(gpiod_direction_output);
  */
 int gpiod_set_debounce(struct gpio_desc *desc, unsigned debounce)
 {
-	struct gpio_chip	*chip;
-	unsigned long		config;
-
-	VALIDATE_DESC(desc);
-	chip = desc->gdev->chip;
+	unsigned long config;
 
 	config = pinconf_to_config_packed(PIN_CONFIG_INPUT_DEBOUNCE, debounce);
-	return gpio_do_set_config(chip, gpio_chip_hwgpio(desc), config);
+	return gpiod_set_config(desc, config);
 }
 EXPORT_SYMBOL_GPL(gpiod_set_debounce);
 
diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
index 0a72fccf60fff230..901aab89d025f3ff 100644
--- a/include/linux/gpio/consumer.h
+++ b/include/linux/gpio/consumer.h
@@ -157,6 +157,7 @@ int gpiod_set_raw_array_value_cansleep(unsigned int array_size,
 				       struct gpio_array *array_info,
 				       unsigned long *value_bitmap);
 
+int gpiod_set_config(struct gpio_desc *desc, unsigned long config);
 int gpiod_set_debounce(struct gpio_desc *desc, unsigned debounce);
 int gpiod_set_transitory(struct gpio_desc *desc, bool transitory);
 void gpiod_toggle_active_low(struct gpio_desc *desc);
@@ -473,6 +474,13 @@ static inline int gpiod_set_raw_array_value_cansleep(unsigned int array_size,
 	return 0;
 }
 
+static inline int gpiod_set_config(struct gpio_desc *desc, unsigned long config)
+{
+	/* GPIO can never have been requested */
+	WARN_ON(desc);
+	return -ENOSYS;
+}
+
 static inline int gpiod_set_debounce(struct gpio_desc *desc, unsigned debounce)
 {
 	/* GPIO can never have been requested */
-- 
2.17.1


