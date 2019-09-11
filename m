Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9802BC5ACAE
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 14:45:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C4FE2053B
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 14:45:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C4FE2053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i83ri-00014c-VZ
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 10:45:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44719)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <geert@linux-m68k.org>) id 1i83m7-000396-Ix
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 10:39:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <geert@linux-m68k.org>) id 1i83m6-0001xB-Ck
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 10:39:15 -0400
Received: from laurent.telenet-ops.be ([2a02:1800:110:4::f00:19]:53992)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <geert@linux-m68k.org>)
 id 1i83m6-0001vO-6I
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 10:39:14 -0400
Received: from ramsan ([84.194.98.4]) by laurent.telenet-ops.be with bizsmtp
 id 0Ef42100205gfCL01Ef4Ro; Wed, 11 Sep 2019 16:39:10 +0200
Received: from rox.of.borg ([192.168.97.57]) by ramsan with esmtp (Exim 4.90_1)
 (envelope-from <geert@linux-m68k.org>)
 id 1i83lv-0006T7-V5; Wed, 11 Sep 2019 16:39:03 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
 (envelope-from <geert@linux-m68k.org>)
 id 1i83lv-0003PC-Tp; Wed, 11 Sep 2019 16:39:03 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date: Wed, 11 Sep 2019 16:38:56 +0200
Message-Id: <20190911143858.13024-4-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190911143858.13024-1-geert+renesas@glider.be>
References: <20190911143858.13024-1-geert+renesas@glider.be>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 2a02:1800:110:4::f00:19
Subject: [Qemu-devel] [PATCH/RFC v2 3/5] gpio: Export gpio_name_to_desc() to
 modular GPIO code
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
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Marc Zyngier <marc.zyngier@arm.com>, Magnus Damm <magnus.damm@gmail.com>,
 Christoffer Dall <christoffer.dall@arm.com>, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
 Alexander Graf <graf@amazon.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Harish Jenny K N <harish_kandiga@mentor.com>,
 Phil Reid <preid@electromag.com.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Make gpio_name_to_desc() global, and export its symbol, so modular GPIO
driver can make use of this function.

This will be used by the GPIO Aggregator.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/gpio/gpiolib.c | 3 ++-
 drivers/gpio/gpiolib.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index c2cf01fb72a9de87..c0caafd111e6ff51 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -288,7 +288,7 @@ static int gpiodev_add_to_list(struct gpio_device *gdev)
 /*
  * Convert a GPIO name to its descriptor
  */
-static struct gpio_desc *gpio_name_to_desc(const char * const name)
+struct gpio_desc *gpio_name_to_desc(const char * const name)
 {
 	struct gpio_device *gdev;
 	unsigned long flags;
@@ -315,6 +315,7 @@ static struct gpio_desc *gpio_name_to_desc(const char * const name)
 
 	return NULL;
 }
+EXPORT_SYMBOL_GPL(gpio_name_to_desc);
 
 /*
  * Takes the names from gc->names and checks if they are all unique. If they
diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index b8b10a409c7b9c65..240d2868a3024b52 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -117,6 +117,7 @@ struct gpio_desc {
 	const char		*name;
 };
 
+struct gpio_desc *gpio_name_to_desc(const char * const name);
 int gpiod_request(struct gpio_desc *desc, const char *label);
 void gpiod_free(struct gpio_desc *desc);
 int gpiod_configure_flags(struct gpio_desc *desc, const char *con_id,
-- 
2.17.1


