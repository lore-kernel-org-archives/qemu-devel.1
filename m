Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E707C2BA17
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 17:56:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B40E206F8
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 17:56:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X1KU2tXN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B40E206F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLVyo-0000EI-8o
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 13:56:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35905)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVqs-0001ds-Uz
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:48:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVqr-0001rT-QH
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:48:02 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:42903)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVqr-0001mQ-KH; Mon, 06 Apr 2020 13:48:01 -0400
Received: by mail-wr1-x443.google.com with SMTP id h15so476352wrx.9;
 Mon, 06 Apr 2020 10:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6j0bhZZ4DXOIthIvcH8V/7teI/2Tb9x+JKEVdKazvPI=;
 b=X1KU2tXNDH5oKLXhUCQy2lQVeBbPbs/TJMa7hxWN5ICWvCYNdAPpAd/DFf0xuMWQG6
 cwqzS1t6QC0JzX5vZ2/jT0sx3PT0WCZPz7/5FwWIbo46IoHrZlvJjnHOyS0FMMmmirpZ
 NaiYD78By1i2Dwa7U1ZuiWG5kF5dq19RWVIIvi5DwjGZQi87skGeSzKmAn6FsQXYXqvb
 Gt0YsY+Ugn+KgpbPqiaQqLrqZo0trPsylmt3W18y6H+Y2UmEZZLResC0IGTxMhw5BS0A
 IHyTK7PSeYtPRlpZSk4N3q7jqwWeOYYCCGoaRBU0hUuKl52jRK0XBJkB98lUr70kI+cR
 69BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=6j0bhZZ4DXOIthIvcH8V/7teI/2Tb9x+JKEVdKazvPI=;
 b=kTxjAJmuJH9jQJ6Sx19HZu8LjkdwF/g46txSK1ZOvOhXmEj9Fv8WVWn+3wrGcGyX8c
 GYR3bt0/QRqOR+Xte1sojLQRmNLtAdGX2WK+NynIRSN1XfEqsrIbZajAwideNl17c8E+
 oc+1gkGqGdej/0gLGKkVMLl40G+DgOUHqwwE6N+wBzsrBW8zqk1JBYehwa0vqC6CDwYc
 ZeXHIs25aE+SbAHsH7THA/5NL1R/4AAaowaZd/rc+nhXBJtEzIz17cpIvKj+KbQTScn8
 emLgo5k2klMeYEdiKtm/XQRXvTaF+AU8uIjbFaImXTuUde/SFe7+WKGhkJhq3KYTxC6a
 JNXg==
X-Gm-Message-State: AGi0PuYDuBI/LthNS7hTzzxk5ow+322o0TQWI3H97Zhfw/+i+b/OmCU0
 MBPoaVmKkjxoGlc/JNzvgh4+mhPOPi8=
X-Google-Smtp-Source: APiQypLW/IYxXY+iRtT8LTwmBcdFXl7kw3iK4ji/0rTZf/nuBrGEucZybsqGwrOBwcACWlfU9qHrng==
X-Received: by 2002:a5d:6104:: with SMTP id v4mr357482wrt.213.1586195278992;
 Mon, 06 Apr 2020 10:47:58 -0700 (PDT)
Received: from x1w.redhat.com (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id a67sm364880wmc.30.2020.04.06.10.47.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2020 10:47:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Subject: [PATCH-for-5.1 v2 09/54] hw/arm/fsl-imx6: Move some code from
 realize() to init()
Date: Mon,  6 Apr 2020 19:46:58 +0200
Message-Id: <20200406174743.16956-10-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200406174743.16956-1-f4bug@amsat.org>
References: <20200406174743.16956-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 "open list:SABRELITE / i.MX6" <qemu-arm@nongnu.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Coccinelle failed at processing this file:

  $ spatch ... --timeout 60 --sp-file \
    scripts/coccinelle/simplify-init-realize-error_propagate.cocci
  HANDLING: ./hw/arm/fsl-imx6.c
  Fatal error: exception Coccinelle_modules.Common.Timeout

While reviewing we noticed some functions can be called at
init() time, reducing the need to add extra Error checks at
realize() time. Move them. The coccinelle script succeeds
after this.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/fsl-imx6.c | 47 +++++++++++++++++++++++------------------------
 1 file changed, 23 insertions(+), 24 deletions(-)

diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
index 3d37352b08..6bf8aa0404 100644
--- a/hw/arm/fsl-imx6.c
+++ b/hw/arm/fsl-imx6.c
@@ -48,11 +48,30 @@ static void fsl_imx6_init(Object *obj)
         object_initialize_child(obj, name, &s->cpu[i], sizeof(s->cpu[i]),
                                 ARM_CPU_TYPE_NAME("cortex-a9"),
                                 &error_abort, NULL);
+
+        /* On uniprocessor, the CBAR is set to 0 */
+        if (smp_cpus > 1) {
+            object_property_set_int(OBJECT(&s->cpu[i]), FSL_IMX6_A9MPCORE_ADDR,
+                                    "reset-cbar", &error_abort);
+        }
+
+        /* All CPU but CPU 0 start in power off mode */
+        if (i) {
+            object_property_set_bool(OBJECT(&s->cpu[i]), true,
+                                     "start-powered-off", &error_abort);
+        }
     }
 
     sysbus_init_child_obj(obj, "a9mpcore", &s->a9mpcore, sizeof(s->a9mpcore),
                           TYPE_A9MPCORE_PRIV);
 
+    object_property_set_int(OBJECT(&s->a9mpcore), smp_cpus, "num-cpu",
+                            &error_abort);
+
+    object_property_set_int(OBJECT(&s->a9mpcore),
+                            FSL_IMX6_MAX_IRQ + GIC_INTERNAL, "num-irq",
+                            &error_abort);
+
     sysbus_init_child_obj(obj, "ccm", &s->ccm, sizeof(s->ccm), TYPE_IMX6_CCM);
 
     sysbus_init_child_obj(obj, "src", &s->src, sizeof(s->src), TYPE_IMX6_SRC);
@@ -81,6 +100,10 @@ static void fsl_imx6_init(Object *obj)
         snprintf(name, NAME_SIZE, "gpio%d", i + 1);
         sysbus_init_child_obj(obj, name, &s->gpio[i], sizeof(s->gpio[i]),
                               TYPE_IMX_GPIO);
+        object_property_set_bool(OBJECT(&s->gpio[i]), true, "has-edge-sel",
+                                 &error_abort);
+        object_property_set_bool(OBJECT(&s->gpio[i]), true, "has-upper-pin-irq",
+                                 &error_abort);
     }
 
     for (i = 0; i < FSL_IMX6_NUM_ESDHCS; i++) {
@@ -124,19 +147,6 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
     unsigned int smp_cpus = ms->smp.cpus;
 
     for (i = 0; i < smp_cpus; i++) {
-
-        /* On uniprocessor, the CBAR is set to 0 */
-        if (smp_cpus > 1) {
-            object_property_set_int(OBJECT(&s->cpu[i]), FSL_IMX6_A9MPCORE_ADDR,
-                                    "reset-cbar", &error_abort);
-        }
-
-        /* All CPU but CPU 0 start in power off mode */
-        if (i) {
-            object_property_set_bool(OBJECT(&s->cpu[i]), true,
-                                     "start-powered-off", &error_abort);
-        }
-
         object_property_set_bool(OBJECT(&s->cpu[i]), true, "realized", &err);
         if (err) {
             error_propagate(errp, err);
@@ -144,13 +154,6 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
         }
     }
 
-    object_property_set_int(OBJECT(&s->a9mpcore), smp_cpus, "num-cpu",
-                            &error_abort);
-
-    object_property_set_int(OBJECT(&s->a9mpcore),
-                            FSL_IMX6_MAX_IRQ + GIC_INTERNAL, "num-irq",
-                            &error_abort);
-
     object_property_set_bool(OBJECT(&s->a9mpcore), true, "realized", &err);
     if (err) {
         error_propagate(errp, err);
@@ -310,10 +313,6 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
             },
         };
 
-        object_property_set_bool(OBJECT(&s->gpio[i]), true, "has-edge-sel",
-                                 &error_abort);
-        object_property_set_bool(OBJECT(&s->gpio[i]), true, "has-upper-pin-irq",
-                                 &error_abort);
         object_property_set_bool(OBJECT(&s->gpio[i]), true, "realized", &err);
         if (err) {
             error_propagate(errp, err);
-- 
2.21.1


