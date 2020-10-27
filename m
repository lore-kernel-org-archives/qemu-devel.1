Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB30FC55178
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 11:54:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06B9B22263
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 11:54:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J4bRbJfC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06B9B22263
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXNYe-0001Vm-Td
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 07:54:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52026)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXNPh-0001a4-N0
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 07:45:17 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:52350)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXNPc-0004b5-Es
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 07:45:17 -0400
Received: by mail-wm1-x32d.google.com with SMTP id c194so1065393wme.2
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 04:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=S726yokpihMdOCsUn8mswwXIVf7NmgTBXtwEGAf2yIU=;
 b=J4bRbJfCvWfJHBil5r+cMfn9wKxiXGydE5vJOeZrRc8gs/Cn7DdgsXQcE1rVVhTpuY
 n9/6zQDSkCvj8lglXhfYjvMZojSp6Qb2yfBS1jYO1IW4MxTvWj/j0Ks+bt5RrNXLSnEZ
 a/3d50PzmWhl5jLLgvUdIbB8g/wyT6IpUFxeJlQUFNUvr+LuHVpOQOG9BOglXWhIcdey
 lAUDgsGpAu1bvG8Q8AWE8qBnrMcWrShsdkz8uJTaQsqM8WT78uD3P71vgqRjpLI52Zy8
 6Vvdmue8qoNW21yuVDXoBrBpJjj6dq8dOGxy/VPKIg7DY1exozL+d0o39k+OAzgSV4IU
 J7bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=S726yokpihMdOCsUn8mswwXIVf7NmgTBXtwEGAf2yIU=;
 b=HUt3jOX3DqhcvRFR+jNd7c5HCcGEWjug1eGaaA9eQxdsMif/lo1+fK/vCppeaNvakJ
 ZX9YKJcRVGwlrCNRFB1vh74hW3tJBNDU302Y38QBd7Jr6EpdZdI0zVZeJqadTlZO90Ob
 ej/8XFgHiaO2YPQyt+jaXtKLKAolQW1gI0D7oyfsJlwAUOWyv34QvYCiO6uC/O6H8EP+
 yFaTqwVQ6wxjQ++STbDXHZN+LAlVRLJ0bzD3CjfkDfM57e3DcLQDVwl456M1zu3uoJ+a
 jQtRbSD5mVPeuOwJuMZa4jynQNd5yd7M+VGYWBm45s+/KzvYc8xXGEfWbypN4f4My0qw
 rtDw==
X-Gm-Message-State: AOAM532nrMv/bbq6GSgliNclRuilWi5eLYd0uHdvi7zpdu0JETAvb2tz
 xoqgx/SvlCkNoUwCcUavpInnwqr4w+agJg==
X-Google-Smtp-Source: ABdhPJznxalYiEVE4TnC8v1aWpoDiqit6877QTCgMmawVSi6KAp4qCLu4mKilzukMRPEEmTxjWDX6w==
X-Received: by 2002:a1c:6804:: with SMTP id d4mr2246918wmc.94.1603799110562;
 Tue, 27 Oct 2020 04:45:10 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 32sm1712203wro.31.2020.10.27.04.45.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2020 04:45:09 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 24/48] hw/arm/bcm2836: Only provide "enabled-cpus" property to
 multicore SoCs
Date: Tue, 27 Oct 2020 11:44:14 +0000
Message-Id: <20201027114438.17662-25-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201027114438.17662-1-peter.maydell@linaro.org>
References: <20201027114438.17662-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

It makes no sense to set enabled-cpus=0 on single core SoCs.

Reviewed-by: Luc Michel <luc.michel@greensocs.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20201024170127.3592182-5-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/bcm2836.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
index c5d46a8e805..fcb2c9c3e73 100644
--- a/hw/arm/bcm2836.c
+++ b/hw/arm/bcm2836.c
@@ -34,6 +34,9 @@ typedef struct BCM283XClass {
 #define BCM283X_GET_CLASS(obj) \
     OBJECT_GET_CLASS(BCM283XClass, (obj), TYPE_BCM283X)
 
+static Property bcm2836_enabled_cores_property =
+    DEFINE_PROP_UINT32("enabled-cpus", BCM283XState, enabled_cpus, 0);
+
 static void bcm2836_init(Object *obj)
 {
     BCM283XState *s = BCM283X(obj);
@@ -44,6 +47,10 @@ static void bcm2836_init(Object *obj)
         object_initialize_child(obj, "cpu[*]", &s->cpu[n].core,
                                 bc->cpu_type);
     }
+    if (bc->core_count > 1) {
+        qdev_property_add_static(DEVICE(obj), &bcm2836_enabled_cores_property);
+        qdev_prop_set_uint32(DEVICE(obj), "enabled-cpus", bc->core_count);
+    }
 
     object_initialize_child(obj, "control", &s->control, TYPE_BCM2836_CONTROL);
 
@@ -130,12 +137,6 @@ static void bcm2836_realize(DeviceState *dev, Error **errp)
     }
 }
 
-static Property bcm2836_props[] = {
-    DEFINE_PROP_UINT32("enabled-cpus", BCM283XState, enabled_cpus,
-                       BCM283X_NCPUS),
-    DEFINE_PROP_END_OF_LIST()
-};
-
 static void bcm283x_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
@@ -155,7 +156,6 @@ static void bcm2836_class_init(ObjectClass *oc, void *data)
     bc->ctrl_base = 0x40000000;
     bc->clusterid = 0xf;
     dc->realize = bcm2836_realize;
-    device_class_set_props(dc, bcm2836_props);
 };
 
 #ifdef TARGET_AARCH64
@@ -170,7 +170,6 @@ static void bcm2837_class_init(ObjectClass *oc, void *data)
     bc->ctrl_base = 0x40000000;
     bc->clusterid = 0x0;
     dc->realize = bcm2836_realize;
-    device_class_set_props(dc, bcm2836_props);
 };
 #endif
 
-- 
2.20.1


