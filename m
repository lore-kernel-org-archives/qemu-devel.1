Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D51BC2BA17
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 18:04:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2073B2064A
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 18:04:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S80ufqKN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2073B2064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLW6s-00050e-3w
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 14:04:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36696)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVrX-0002hb-Dm
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:48:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVrW-0003SJ-7E
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:48:43 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:52260)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVrW-0003RB-1D; Mon, 06 Apr 2020 13:48:42 -0400
Received: by mail-wm1-x32d.google.com with SMTP id t203so297339wmt.2;
 Mon, 06 Apr 2020 10:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7nYHyoCJMlnQy3DVHwC5v3e8R1Ia13oWI3bOWgCiP+E=;
 b=S80ufqKNxYsOM37GU0HwCQZ2Hv7rbwYyLWzpwXqZo1/iG/IBrLHVBkMivBmjHCcnrb
 RdcyQIu8R31xk52mKCQjoJQU9OwduNfomP0M7YF96oWPA6wwO8wkjMg6tqA001jI7C9x
 lPJlA2m4cjKK2ZwxDINMHvZK4GYcTkFYQT+GiCoMBoz9Htxj8RkEUeADW7QAunK1UYx1
 ZGqyq+klezNQEFwHJSjVPvr8QrYOJFGQWtNfI7XlddyS/nDl/HLMX6kZrOu8nd186WnS
 1Aobj0J5aonnwIa7tCyVP/ud3eVlYs35T7D5grlnb59PMinWM/J/elsoqU0fXoz/ehYi
 MBOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=7nYHyoCJMlnQy3DVHwC5v3e8R1Ia13oWI3bOWgCiP+E=;
 b=mcAs58sbS7+OJYZcFzXZxETYkVEWE5kF033zBvQGAmmatLRixrNMjK5y/FDU8Z2OBR
 0wM6K9fYLwp/l/sUQ25njuC9n8hsWZU+HV1b+J7C9s9Ma9zt8P3I236Ufhak0UF/Fr2M
 FImo0QOikg8lF9uOFXwfEZ/CPjeumnNjkoOXo0Vx+5SwEldjMByOozPBgva8Sc4+hV2l
 f4Yw4saWqzuBGjF3GuzLoHYzmUNgZoTVktmuSsGnFZWi7gtnWmUb8gYUlDdjFQk87uNb
 uFN5zlAgNB0hEIENrNUvGOi0wC8A7bM9LkjyTJWSOqWZLS76cvsPBe3zXmSAx/hiY/o/
 scjA==
X-Gm-Message-State: AGi0PuZrKbUZ25TEDu7iaapGmc1tYiHtut7oXpFbLpeOoY/t5VL4MSXy
 HVtKbquD7qEaiEDiKje8yYeDwxlwlW4=
X-Google-Smtp-Source: APiQypILTiqajSq9uDraEKNyusqNZCcyzJgUbpxVRfw/NO4Uaj7/mrvAo6i7fyGgYgfD98Fk16dfkg==
X-Received: by 2002:a1c:f315:: with SMTP id q21mr459404wmq.169.1586195320705; 
 Mon, 06 Apr 2020 10:48:40 -0700 (PDT)
Received: from x1w.redhat.com (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id a67sm364880wmc.30.2020.04.06.10.48.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2020 10:48:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Subject: [PATCH-for-5.1 v2 40/54] hw/arm/stm32fx05_soc: Add missing
 error-propagation code
Date: Mon,  6 Apr 2020 19:47:29 +0200
Message-Id: <20200406174743.16956-41-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200406174743.16956-1-f4bug@amsat.org>
References: <20200406174743.16956-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32d
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
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 "open list:STM32F205" <qemu-arm@nongnu.org>,
 Alistair Francis <alistair.francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Patch created mechanically by running:

  $ spatch \
    --macro-file scripts/cocci-macro-file.h --include-headers \
    --sp-file scripts/coccinelle/object_property_missing_error_propagate.cocci \
    --keep-comments --smpl-spacing --in-place --dir hw

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/stm32f205_soc.c | 4 ++++
 hw/arm/stm32f405_soc.c | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/hw/arm/stm32f205_soc.c b/hw/arm/stm32f205_soc.c
index b1be4fde40..fba18bc204 100644
--- a/hw/arm/stm32f205_soc.c
+++ b/hw/arm/stm32f205_soc.c
@@ -159,6 +159,10 @@ static void stm32f205_soc_realize(DeviceState *dev_soc, Error **errp)
     /* ADC 1 to 3 */
     object_property_set_int(OBJECT(s->adc_irqs), STM_NUM_ADCS,
                             "num-lines", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
     object_property_set_bool(OBJECT(s->adc_irqs), true, "realized", &err);
     if (err != NULL) {
         error_propagate(errp, err);
diff --git a/hw/arm/stm32f405_soc.c b/hw/arm/stm32f405_soc.c
index 2b8a84a695..6db77d296b 100644
--- a/hw/arm/stm32f405_soc.c
+++ b/hw/arm/stm32f405_soc.c
@@ -181,6 +181,10 @@ static void stm32f405_soc_realize(DeviceState *dev_soc, Error **errp)
     }
     object_property_set_int(OBJECT(&s->adc_irqs), STM_NUM_ADCS,
                             "num-lines", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
     object_property_set_bool(OBJECT(&s->adc_irqs), true, "realized", &err);
     if (err != NULL) {
         error_propagate(errp, err);
-- 
2.21.1


