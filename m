Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E760BC2BA17
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 18:13:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B97A0206B8
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 18:13:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EXiwzYrX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B97A0206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLWFL-0005kH-RN
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 14:13:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36470)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVrK-0002N9-VN
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:48:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVrJ-0003Iz-Qv
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:48:30 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:39322)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVrI-0003HN-8Y; Mon, 06 Apr 2020 13:48:29 -0400
Received: by mail-wm1-x343.google.com with SMTP id y20so307436wma.4;
 Mon, 06 Apr 2020 10:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YIEKjYaSehnFfLSFKx18jrIeGBK5qNFrnpqQGnepkJE=;
 b=EXiwzYrXydWHRtvzz/VrwFWn0hXV/FrHUlBcwRHa6zCq0M+8qlGxJoWEO0xgJXi31r
 3mK2SwjzIe2s0TaouAfjEc6zfXKgYPjfz2Xh83tW6wJeSZwR6IE00W6CwXqi8YGWB/ka
 rPMclv10b4Qgl9eePMQHrtQtzNjMb7l0o7weFtVl4GDWUNo7LppAlQeY5xzEii9cxakT
 aCOUE0s/SEbEiG2Z915JKZWf1ff3nh7l1M00aHlgmeDwGoNzwD1mYLTi2G7qsFFFNFXP
 8S9MLxR0DC+E38zUSzFtUhKIAbdv6fMduVziylINM0ysYNrrjSjak3T6ZBQiJW8PQARg
 rphw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=YIEKjYaSehnFfLSFKx18jrIeGBK5qNFrnpqQGnepkJE=;
 b=M0DuwEvz1sQJ2CJjgwc30jw5uHnsLJOjF1sZ6ueKw8kvFlXYhzj6cUxIFASpx2MwFn
 KH4YgIcRAquDlWJzTG+W+J8km41tqQiuP3zEElTrqFeIYmM7oYnmA/yhZrcKd5dYl08K
 /AKf0cgwoUWoUfBbWG87v5DK83pbKj9FmGr45IDDLjgCwuPi5MwZFU+YPObc/u+IN7qN
 f/xmtV2Zbm7VRNQjPhdvZQDp6CWGACnF1Q1teH9fOcd3hrj9nvz8YNbBpvwHYIKfIcy3
 RqN7+7WB8IIJ0h4MkScze9p08pKd3xmCmVPlSUoxzgxWYmwi1luGQnCm/a+i3A/3uodS
 Jcog==
X-Gm-Message-State: AGi0PubXgOrgb23RjLA+81TJJ3Rh9rXDpTb9WGrxTUEweDdta4RT6UX3
 zXxYTW27oto5ZAc+rKJ5BQ2IVP8CPN4=
X-Google-Smtp-Source: APiQypLKbbLisqlOTNCKlL8AxmNztCdBs4VTbm9sUa0LmrVDAsF5eKwQQtdj990RjDqlxpFg07Aw8A==
X-Received: by 2002:a1c:bb08:: with SMTP id l8mr191865wmf.168.1586195307084;
 Mon, 06 Apr 2020 10:48:27 -0700 (PDT)
Received: from x1w.redhat.com (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id a67sm364880wmc.30.2020.04.06.10.48.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2020 10:48:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Subject: [PATCH-for-5.1 v2 30/54] hw/arm/msf2-soc: Add missing
 error-propagation code
Date: Mon,  6 Apr 2020 19:47:19 +0200
Message-Id: <20200406174743.16956-31-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200406174743.16956-1-f4bug@amsat.org>
References: <20200406174743.16956-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
 "open list:SmartFusion2" <qemu-arm@nongnu.org>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Patch created mechanically by running:

  $ spatch \
    --macro-file scripts/cocci-macro-file.h --include-headers \
    --sp-file scripts/coccinelle/use-error_propagate-in-realize.cocci \
    --keep-comments --smpl-spacing --in-place --dir hw

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/msf2-soc.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/hw/arm/msf2-soc.c b/hw/arm/msf2-soc.c
index e448b0ab74..7619e71cfa 100644
--- a/hw/arm/msf2-soc.c
+++ b/hw/arm/msf2-soc.c
@@ -93,7 +93,11 @@ static void m2sxxx_soc_realize(DeviceState *dev_soc, Error **errp)
     MemoryRegion *system_memory = get_system_memory();
 
     memory_region_init_rom(&s->nvm, OBJECT(dev_soc), "MSF2.eNVM", s->envm_size,
-                           &error_fatal);
+                           &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
     /*
      * On power-on, the eNVM region 0x60000000 is automatically
      * remapped to the Cortex-M3 processor executable region
@@ -107,7 +111,11 @@ static void m2sxxx_soc_realize(DeviceState *dev_soc, Error **errp)
     memory_region_add_subregion(system_memory, 0, &s->nvm_alias);
 
     memory_region_init_ram(&s->sram, NULL, "MSF2.eSRAM", s->esram_size,
-                           &error_fatal);
+                           &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
     memory_region_add_subregion(system_memory, SRAM_BASE_ADDRESS, &s->sram);
 
     armv7m = DEVICE(&s->armv7m);
@@ -115,7 +123,11 @@ static void m2sxxx_soc_realize(DeviceState *dev_soc, Error **errp)
     qdev_prop_set_string(armv7m, "cpu-type", s->cpu_type);
     qdev_prop_set_bit(armv7m, "enable-bitband", true);
     object_property_set_link(OBJECT(&s->armv7m), OBJECT(get_system_memory()),
-                                     "memory", &error_abort);
+                                     "memory", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
     object_property_set_bool(OBJECT(&s->armv7m), true, "realized", &err);
     if (err != NULL) {
         error_propagate(errp, err);
@@ -184,8 +196,12 @@ static void m2sxxx_soc_realize(DeviceState *dev_soc, Error **errp)
         bus_name = g_strdup_printf("spi%d", i);
         object_property_add_alias(OBJECT(s), bus_name,
                                   OBJECT(&s->spi[i]), "spi",
-                                  &error_abort);
+                                  &err);
         g_free(bus_name);
+        if (err) {
+            error_propagate(errp, err);
+            return;
+        }
     }
 
     /* Below devices are not modelled yet. */
-- 
2.21.1


