Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0948C49ED6
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 14:51:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C67892084F
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 14:51:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C67892084F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i83y7-0007VT-Dy
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 10:51:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44715)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <geert@linux-m68k.org>) id 1i83m7-00038r-E8
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 10:39:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <geert@linux-m68k.org>) id 1i83m6-0001x0-Bp
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 10:39:15 -0400
Received: from baptiste.telenet-ops.be ([2a02:1800:120:4::f00:13]:60958)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <geert@linux-m68k.org>)
 id 1i83m6-0001vE-5J
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 10:39:14 -0400
Received: from ramsan ([84.194.98.4]) by baptiste.telenet-ops.be with bizsmtp
 id 0Ef42100805gfCL01Ef4TC; Wed, 11 Sep 2019 16:39:10 +0200
Received: from rox.of.borg ([192.168.97.57]) by ramsan with esmtp (Exim 4.90_1)
 (envelope-from <geert@linux-m68k.org>)
 id 1i83lv-0006T3-Tj; Wed, 11 Sep 2019 16:39:03 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
 (envelope-from <geert@linux-m68k.org>)
 id 1i83lv-0003P0-SI; Wed, 11 Sep 2019 16:39:03 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date: Wed, 11 Sep 2019 16:38:54 +0200
Message-Id: <20190911143858.13024-2-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190911143858.13024-1-geert+renesas@glider.be>
References: <20190911143858.13024-1-geert+renesas@glider.be>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 2a02:1800:120:4::f00:13
Subject: [Qemu-devel] [PATCH/RFC v2 1/5] gpio: Export gpiod_{request,
 free}() to modular GPIO code
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

Export the gpiod_request() and gpiod_free() symbols, so modular GPIO
library code can make use of these functions.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
ERROR: "gpiod_free" [drivers/gpio/gpiolib-fwd.ko] undefined!
ERROR: "gpiod_request" [drivers/gpio/gpiolib-fwd.ko] undefined!

Alternatives:
  - Force gpiolib-fwd builtin,
  - Call gpio_{,request,free}(desc_to_gpio(...)) instead, as the legacy
    functions are exported,
  - Call gpiod_put() instead of gpiod_free(), as the former is a simple
    exported wrapper around the latter.  Unfortunately there's no such
    alternative for gpiod_request().
---
 drivers/gpio/gpiolib.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index f1c1b5d4b00b40a7..dbecf266be5a5a2a 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -2733,6 +2733,7 @@ int gpiod_request(struct gpio_desc *desc, const char *label)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(gpiod_request);
 
 static bool gpiod_free_commit(struct gpio_desc *desc)
 {
@@ -2777,6 +2778,7 @@ void gpiod_free(struct gpio_desc *desc)
 		WARN_ON(extra_checks);
 	}
 }
+EXPORT_SYMBOL_GPL(gpiod_free);
 
 /**
  * gpiochip_is_requested - return string iff signal was requested
-- 
2.17.1


