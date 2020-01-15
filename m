Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C793DC32771
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 18:23:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97D42214AF
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 18:23:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97D42214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irnJy-00076t-Ko
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 13:23:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53060)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <geert@linux-m68k.org>) id 1irnCk-0006aa-GU
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 13:15:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <geert@linux-m68k.org>) id 1irnCj-0003cG-G8
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 13:15:46 -0500
Received: from andre.telenet-ops.be ([2a02:1800:120:4::f00:15]:55970)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <geert@linux-m68k.org>)
 id 1irnCj-0003b7-9r
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 13:15:45 -0500
Received: from ramsan ([84.195.182.253]) by andre.telenet-ops.be with bizsmtp
 id qiFR2100W5USYZQ01iFRmd; Wed, 15 Jan 2020 19:15:43 +0100
Received: from rox.of.borg ([192.168.97.57]) by ramsan with esmtp (Exim 4.90_1)
 (envelope-from <geert@linux-m68k.org>)
 id 1irnCP-00012W-F4; Wed, 15 Jan 2020 19:15:25 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
 (envelope-from <geert@linux-m68k.org>)
 id 1irnCP-000692-Cf; Wed, 15 Jan 2020 19:15:25 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Harish Jenny K N <harish_kandiga@mentor.com>,
 Eugeniu Rosca <erosca@de.adit-jv.com>
Subject: [PATCH v4 1/5] gpiolib: Add support for gpiochipN-based table lookup
Date: Wed, 15 Jan 2020 19:15:19 +0100
Message-Id: <20200115181523.23556-2-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200115181523.23556-1-geert+renesas@glider.be>
References: <20200115181523.23556-1-geert+renesas@glider.be>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 2a02:1800:120:4::f00:15
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

Currently GPIO controllers can only be referred to by label in GPIO
lookup tables.

Add support for looking them up by "gpiochipN" name, with "N" the
corresponding GPIO device's ID number.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Ulrich Hecht <uli+renesas@fpond.eu>
---
v4:
  - Add Reviewed-by,
  - Drop support for legacy sysfs interface based name matching,
  - Replace complex custom matching by a simple additional check in the
    existing gpiochip_match_name() function,
  - Add kerneldoc() for find_chip_by_name(), documenting matching order.

v3:
  - New.
---
 drivers/gpio/gpiolib.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 9fd2dfb658546159..114325b366ae33d5 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1738,9 +1738,18 @@ static int gpiochip_match_name(struct gpio_chip *chip, void *data)
 {
 	const char *name = data;
 
-	return !strcmp(chip->label, name);
+	return !strcmp(chip->label, name) ||
+	       !strcmp(dev_name(&chip->gpiodev->dev), name);
 }
 
+/**
+ * find_chip_by_name() - Find a specific gpio_chip by name
+ * @name: Name to match
+ *
+ * Return a reference to a gpio_chip that matches the passed name.
+ * This function first tries matching on the gpio_chip's label, followed by
+ * matching on dev_name() of the corresponding gpio_device.
+ */
 static struct gpio_chip *find_chip_by_name(const char *name)
 {
 	return gpiochip_find((void *)name, gpiochip_match_name);
-- 
2.17.1


