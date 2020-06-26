Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E11E9C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 15:26:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB90D20773
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 15:26:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tRd/GlfS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB90D20773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joqFL-0005w6-VU
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 11:26:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35348)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joq3o-0001s5-9E
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 11:14:36 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:53870)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joq3m-0006DO-JY
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 11:14:35 -0400
Received: by mail-wm1-x32e.google.com with SMTP id j18so9157612wmi.3
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 08:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=MGJixcDIgTvYDsTmGzHDvC7oKBPaR9Bngw/q3X8ML5A=;
 b=tRd/GlfSq+fFbMFybYhBW+gWTUwa7fZtEYw8RH1txvzLYUp//sgX0paVD6KfZjCuDx
 hiWrh2Y3+ImLKyGN7FOKF1RR3uoYA1K+2V0VFI8cmN5z98o5oUYgp8GbGxXBIPYMZ/td
 YsMSjmJ91ClnAlfANoIwBwb0NGXvaRyUFVvTirpTW1stml92rOWlc4IfJ+iruFlqfHHw
 4l7GjpQzqcGdX93aQy/CjieHqTNILb74S08M/80Vm5VoJlfxKaxWknN573Wq7N3A7HqN
 ND+zD7M9bpkl6o4AOd0kDv0SyTqy5dcpMilNw1BOzTSdnwbJc1MxS72lw+hAPlqBj0iP
 y6nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=MGJixcDIgTvYDsTmGzHDvC7oKBPaR9Bngw/q3X8ML5A=;
 b=FXrJhIIRpCOibm1lUeVsRgfwdXMKYw53r/2xe5QDmomms272wrwderHvBRZdPP05D2
 Z3sf7CZ/YV6MjqQL8gKsv1J6Nx7PTe0BNZJfi0wsa9BYgSl/B4y4OcJlK/HXhFBXj3Kj
 f/5/mzjykqLWdM9fn0CsJL5NNCdhAfano9IgWKc9XoUk5xZae0PWS1SD1b8s9nYOINvq
 YLaIKBrTelQSxjEet5FX+ecmh+QVN4W7gA/8UMsD9KqrRPXl0swabYmwKuO2HQ6vi/Qd
 lTK4UW/yzuLx2rN60AiYoGiKqVWL6bvVBLdh/OYbgVDX/J9dCQTBliy6CL+ifNun7fqw
 GVhg==
X-Gm-Message-State: AOAM533YZylU8bGxtjoa5xcCM6zrlrpHpFAEA7y6zpUVNH1rKVj0gP1W
 h66KZYyAVBoCqiep3XSYAZODpmLI3a5S7g==
X-Google-Smtp-Source: ABdhPJxdphpo27N1fjiYQhmRp9RSl03g7hANtNJC7zjjmv0Ss6DOA1ls0yDnp1L9p5g/Vrl9UEJRaQ==
X-Received: by 2002:a7b:cb59:: with SMTP id v25mr3843942wmj.141.1593184472501; 
 Fri, 26 Jun 2020 08:14:32 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w13sm37838852wrr.67.2020.06.26.08.14.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2020 08:14:31 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/57] hw/misc/pca9552: Rename 'nr_leds' as 'pin_count'
Date: Fri, 26 Jun 2020 16:13:32 +0100
Message-Id: <20200626151424.30117-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200626151424.30117-1-peter.maydell@linaro.org>
References: <20200626151424.30117-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

The PCA9552 device does not expose LEDs, but simple pins
to connnect LEDs to. To be clearer with the device model,
rename 'nr_leds' as 'pin_count'.

Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Cédric Le Goater <clg@kaod.org>
Message-id: 20200623072723.6324-3-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/misc/pca9552.h |  2 +-
 hw/misc/pca9552.c         | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/hw/misc/pca9552.h b/include/hw/misc/pca9552.h
index ebb43c63fe1..bc5ed310878 100644
--- a/include/hw/misc/pca9552.h
+++ b/include/hw/misc/pca9552.h
@@ -26,7 +26,7 @@ typedef struct PCA9552State {
 
     uint8_t regs[PCA9552_NR_REGS];
     uint8_t max_reg;
-    uint8_t nr_leds;
+    uint8_t pin_count;
 } PCA9552State;
 
 #endif
diff --git a/hw/misc/pca9552.c b/hw/misc/pca9552.c
index cac729e35af..81da757a7ea 100644
--- a/hw/misc/pca9552.c
+++ b/hw/misc/pca9552.c
@@ -37,7 +37,7 @@ static void pca9552_update_pin_input(PCA9552State *s)
 {
     int i;
 
-    for (i = 0; i < s->nr_leds; i++) {
+    for (i = 0; i < s->pin_count; i++) {
         uint8_t input_reg = PCA9552_INPUT0 + (i / 8);
         uint8_t input_shift = (i % 8);
         uint8_t config = pca9552_pin_get_config(s, i);
@@ -185,7 +185,7 @@ static void pca9552_get_led(Object *obj, Visitor *v, const char *name,
         error_setg(errp, "%s: error reading %s", __func__, name);
         return;
     }
-    if (led < 0 || led > s->nr_leds) {
+    if (led < 0 || led > s->pin_count) {
         error_setg(errp, "%s invalid led %s", __func__, name);
         return;
     }
@@ -228,7 +228,7 @@ static void pca9552_set_led(Object *obj, Visitor *v, const char *name,
         error_setg(errp, "%s: error reading %s", __func__, name);
         return;
     }
-    if (led < 0 || led > s->nr_leds) {
+    if (led < 0 || led > s->pin_count) {
         error_setg(errp, "%s invalid led %s", __func__, name);
         return;
     }
@@ -291,9 +291,9 @@ static void pca9552_initfn(Object *obj)
      * PCA955X device
      */
     s->max_reg = PCA9552_LS3;
-    s->nr_leds = 16;
+    s->pin_count = 16;
 
-    for (led = 0; led < s->nr_leds; led++) {
+    for (led = 0; led < s->pin_count; led++) {
         char *name;
 
         name = g_strdup_printf("led%d", led);
-- 
2.20.1


