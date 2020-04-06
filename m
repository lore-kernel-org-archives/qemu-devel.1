Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5368AC2BA17
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 18:05:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2238E2064A
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 18:05:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IzVvpA9m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2238E2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36213 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLW87-0007Vy-84
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 14:05:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36125)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVr2-0001vb-2b
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:48:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVr0-0002jD-TV
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:48:12 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:33427)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVr0-0002gW-Mu; Mon, 06 Apr 2020 13:48:10 -0400
Received: by mail-wm1-x332.google.com with SMTP id g21so582346wmh.0;
 Mon, 06 Apr 2020 10:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Cywb3NzU3xTAsl3tlLXZAS+5IRTu4MJbpH6wU0QcRK0=;
 b=IzVvpA9m3fMFuR0rzc0GtThCkipYcef0pszA8n1Odu59QjGfSZPI2Y5pk+z+X/G4ZI
 gBupz8W822SeIX1S1ot3bVU+PzhnRz1VNfqZ51MgzYdYhSHYxlk2qN4Cz0MaM4Reopo6
 OzSQPrYkFTJvrfgWMXKAzoY07DT8S1FXcCC+eooKRAbmG5TSea1ZtusMn1OGBGjEycET
 oWsoiyXiAKtPAMMDbLh2/D9q+iY5obH8HfCtcyvB7zJea1cr79ZAt/hzmiTYQpBLR5y9
 DBeDobrjyFgL6EGnGIb7ftcA57p8sSykb44EnaehaN/oaIEbgrjZf+SkyOaJhcZ1yfOw
 wIOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=Cywb3NzU3xTAsl3tlLXZAS+5IRTu4MJbpH6wU0QcRK0=;
 b=MbZWLPlmXuWFMSZAuUA8ZUXRUigf9yPx6doXQOQgg44UgHXtlmmKnxob7LzGsnVBHr
 PsJb0LtaJhEDrKO6/AiKrushFcIpYdcQPqzC2Nu+Vrvj1kK4j15chF8W2cWSITpDThUZ
 xHmhGRgVy/WHWazhaIjxnT+flCgqMgouEN+J1SDlZe9WtsIGQPkauDBWvgkyNJsTI1Ak
 QidzD8Z37RWUetg6e/CpmxZWj9rFGTiruGAlTVzF9h7W40anjm4KYHhMEWIzsHR2hXfo
 fACenKEFRnT0bdLuMYABmwzEeWq6NvcYUx03VnDtTrmaBj5drPJPIiGyYzhwyr7Ds1Os
 sEzQ==
X-Gm-Message-State: AGi0PubrHppvtL7NIcre/4FgRL6bzb7kCmMIe+bGx5d52ubCTSZq3xEn
 y0Ye/DwYcIXl/lzV7GF554FKXy2LHGw=
X-Google-Smtp-Source: APiQypK8VND8Fj12H4vP1SchlZJltgfxbFXBX42JoIGZKM1LB9HaFE6eIPxJx38YxtdKDF033I8AIQ==
X-Received: by 2002:a1c:dfc6:: with SMTP id w189mr498174wmg.180.1586195289478; 
 Mon, 06 Apr 2020 10:48:09 -0700 (PDT)
Received: from x1w.redhat.com (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id a67sm364880wmc.30.2020.04.06.10.48.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2020 10:48:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Subject: [PATCH-for-5.1 v2 17/54] hw/microblaze/xlnx-zynqmp-pmu: Move some
 code from realize() to init()
Date: Mon,  6 Apr 2020 19:47:06 +0200
Message-Id: <20200406174743.16956-18-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200406174743.16956-1-f4bug@amsat.org>
References: <20200406174743.16956-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::332
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
 "open list:Xilinx ZynqMP" <qemu-arm@nongnu.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Coccinelle reported:

  $ spatch ... --timeout 60 --sp-file \
    scripts/coccinelle/simplify-init-realize-error_propagate.cocci
  HANDLING: ./hw/microblaze/xlnx-zynqmp-pmu.c
  >>> possible moves from xlnx_zynqmp_pmu_soc_init() to xlnx_zynqmp_pmu_soc_realize() in ./hw/microblaze/xlnx-zynqmp-pmu.c:79

Move the calls using &error_abort which don't depend of input
updated before realize() to init().

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/microblaze/xlnx-zynqmp-pmu.c | 46 ++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/hw/microblaze/xlnx-zynqmp-pmu.c b/hw/microblaze/xlnx-zynqmp-pmu.c
index 028f31894d..2aa602cf85 100644
--- a/hw/microblaze/xlnx-zynqmp-pmu.c
+++ b/hw/microblaze/xlnx-zynqmp-pmu.c
@@ -63,24 +63,6 @@ static void xlnx_zynqmp_pmu_soc_init(Object *obj)
 
     object_initialize_child(obj, "pmu-cpu", &s->cpu, sizeof(s->cpu),
                             TYPE_MICROBLAZE_CPU, &error_abort, NULL);
-
-    sysbus_init_child_obj(obj, "intc", &s->intc, sizeof(s->intc),
-                          TYPE_XLNX_PMU_IO_INTC);
-
-    /* Create the IPI device */
-    for (int i = 0; i < XLNX_ZYNQMP_PMU_NUM_IPIS; i++) {
-        char *name = g_strdup_printf("ipi%d", i);
-        sysbus_init_child_obj(obj, name, &s->ipi[i],
-                              sizeof(XlnxZynqMPIPI), TYPE_XLNX_ZYNQMP_IPI);
-        g_free(name);
-    }
-}
-
-static void xlnx_zynqmp_pmu_soc_realize(DeviceState *dev, Error **errp)
-{
-    XlnxZynqMPPMUSoCState *s = XLNX_ZYNQMP_PMU_SOC(dev);
-    Error *err = NULL;
-
     object_property_set_uint(OBJECT(&s->cpu), XLNX_ZYNQMP_PMU_ROM_ADDR,
                              "base-vectors", &error_abort);
     object_property_set_bool(OBJECT(&s->cpu), true, "use-stack-protection",
@@ -99,18 +81,36 @@ static void xlnx_zynqmp_pmu_soc_realize(DeviceState *dev, Error **errp)
     object_property_set_str(OBJECT(&s->cpu), "8.40.b", "version",
                             &error_abort);
     object_property_set_uint(OBJECT(&s->cpu), 0, "pvr", &error_abort);
-    object_property_set_bool(OBJECT(&s->cpu), true, "realized", &err);
-    if (err) {
-        error_propagate(errp, err);
-        return;
-    }
 
+    sysbus_init_child_obj(obj, "intc", &s->intc, sizeof(s->intc),
+                          TYPE_XLNX_PMU_IO_INTC);
     object_property_set_uint(OBJECT(&s->intc), 0x10, "intc-intr-size",
                              &error_abort);
     object_property_set_uint(OBJECT(&s->intc), 0x0, "intc-level-edge",
                              &error_abort);
     object_property_set_uint(OBJECT(&s->intc), 0xffff, "intc-positive",
                              &error_abort);
+
+    /* Create the IPI device */
+    for (int i = 0; i < XLNX_ZYNQMP_PMU_NUM_IPIS; i++) {
+        char *name = g_strdup_printf("ipi%d", i);
+        sysbus_init_child_obj(obj, name, &s->ipi[i],
+                              sizeof(XlnxZynqMPIPI), TYPE_XLNX_ZYNQMP_IPI);
+        g_free(name);
+    }
+}
+
+static void xlnx_zynqmp_pmu_soc_realize(DeviceState *dev, Error **errp)
+{
+    XlnxZynqMPPMUSoCState *s = XLNX_ZYNQMP_PMU_SOC(dev);
+    Error *err = NULL;
+
+    object_property_set_bool(OBJECT(&s->cpu), true, "realized", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+
     object_property_set_bool(OBJECT(&s->intc), true, "realized", &err);
     if (err) {
         error_propagate(errp, err);
-- 
2.21.1


