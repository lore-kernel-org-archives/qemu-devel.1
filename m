Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 420DAC433E1
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 11:26:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1373320936
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 11:26:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y10VyYb8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1373320936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqxLy-00027M-Bz
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 07:26:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52734)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jqx6J-0006zA-GA
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 07:09:55 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:30347
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jqx68-00011O-8x
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 07:09:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593688183;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FKPSUjRRwthP4rZxyZNbMUp9PqJDx4lkfSn3R+EIYpM=;
 b=Y10VyYb8ddQ36dBHX9+OTrVNI5JpuxtA4WGLuIYPHRpcoqg6e2uf6vD79LDORWIw9gTGSA
 UO/ea8tT+yrAtKDlsGGwzmEWJH62F6MI7GnzLR6mN1vNTc+FeheQVxsX64ZVqWdqvoT+Yn
 gy2WjsIldYpKIfz2U92E3XKxP5QAjFw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-103-Rr61AxxhMmOQmmb_Y9Gf-w-1; Thu, 02 Jul 2020 07:09:41 -0400
X-MC-Unique: Rr61AxxhMmOQmmb_Y9Gf-w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B373DBFC3;
 Thu,  2 Jul 2020 11:09:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3372379229;
 Thu,  2 Jul 2020 11:09:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4C3751138487; Thu,  2 Jul 2020 13:09:32 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 27/28] arm/{bcm2835, fsl-imx25,
 fsl-imx6}: Fix realize error API violations
Date: Thu,  2 Jul 2020 13:09:30 +0200
Message-Id: <20200702110931.2953148-28-armbru@redhat.com>
In-Reply-To: <20200702110931.2953148-1-armbru@redhat.com>
References: <20200702110931.2953148-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 04:18:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Error ** argument must be NULL, &error_abort, &error_fatal, or a
pointer to a variable containing NULL.  Passing an argument of the
latter kind twice without clearing it in between is wrong: if the
first call sets an error, it no longer points to NULL for the second
call.

bcm2835_peripherals_realize(), fsl_imx25_realize() and
fsl_imx6_realize() are wrong that way: they pass &err to
object_property_set_uint() and object_property_set_bool() without
checking it, and then to sysbus_realize().  Harmless, because the
former can't actually fail here.

Fix by passing &error_abort instead.

Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Andrew Baumann <Andrew.Baumann@microsoft.com>
Cc: "Philippe Mathieu-Daudé" <philmd@redhat.com>
Cc: Jean-Christophe Dubois <jcd@tribudubois.net>
Cc: qemu-arm@nongnu.org
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20200630090351.1247703-26-armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/bcm2835_peripherals.c | 12 ++++--------
 hw/arm/fsl-imx25.c           | 12 +++++-------
 hw/arm/fsl-imx6.c            | 12 +++++-------
 3 files changed, 14 insertions(+), 22 deletions(-)

diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
index 1e975d7eec..7ffdf62067 100644
--- a/hw/arm/bcm2835_peripherals.c
+++ b/hw/arm/bcm2835_peripherals.c
@@ -283,16 +283,12 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
      * For the exact details please refer to the Arasan documentation:
      *   SD3.0_Host_AHB_eMMC4.4_Usersguide_ver5.9_jan11_10.pdf
      */
-    object_property_set_uint(OBJECT(&s->sdhci), 3, "sd-spec-version", &err);
+    object_property_set_uint(OBJECT(&s->sdhci), 3, "sd-spec-version",
+                             &error_abort);
     object_property_set_uint(OBJECT(&s->sdhci), BCM2835_SDHC_CAPAREG, "capareg",
-                             &err);
+                             &error_abort);
     object_property_set_bool(OBJECT(&s->sdhci), true, "pending-insert-quirk",
-                             &err);
-    if (err) {
-        error_propagate(errp, err);
-        return;
-    }
-
+                             &error_abort);
     sysbus_realize(SYS_BUS_DEVICE(&s->sdhci), &err);
     if (err) {
         error_propagate(errp, err);
diff --git a/hw/arm/fsl-imx25.c b/hw/arm/fsl-imx25.c
index f32f9bce0f..7ab5c98fbe 100644
--- a/hw/arm/fsl-imx25.c
+++ b/hw/arm/fsl-imx25.c
@@ -260,15 +260,13 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
         };
 
         object_property_set_uint(OBJECT(&s->esdhc[i]), 2, "sd-spec-version",
-                                 &err);
+                                 &error_abort);
         object_property_set_uint(OBJECT(&s->esdhc[i]), IMX25_ESDHC_CAPABILITIES,
-                                 "capareg", &err);
+                                 "capareg",
+                                 &error_abort);
         object_property_set_uint(OBJECT(&s->esdhc[i]), SDHCI_VENDOR_IMX,
-                                 "vendor", &err);
-        if (err) {
-            error_propagate(errp, err);
-            return;
-        }
+                                 "vendor",
+                                 &error_abort);
         sysbus_realize(SYS_BUS_DEVICE(&s->esdhc[i]), &err);
         if (err) {
             error_propagate(errp, err);
diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
index d4bc4fae93..4ae3c3efc2 100644
--- a/hw/arm/fsl-imx6.c
+++ b/hw/arm/fsl-imx6.c
@@ -336,15 +336,13 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
 
         /* UHS-I SDIO3.0 SDR104 1.8V ADMA */
         object_property_set_uint(OBJECT(&s->esdhc[i]), 3, "sd-spec-version",
-                                 &err);
+                                 &error_abort);
         object_property_set_uint(OBJECT(&s->esdhc[i]), IMX6_ESDHC_CAPABILITIES,
-                                 "capareg", &err);
+                                 "capareg",
+                                 &error_abort);
         object_property_set_uint(OBJECT(&s->esdhc[i]), SDHCI_VENDOR_IMX,
-                                 "vendor", &err);
-        if (err) {
-            error_propagate(errp, err);
-            return;
-        }
+                                 "vendor",
+                                 &error_abort);
         sysbus_realize(SYS_BUS_DEVICE(&s->esdhc[i]), &err);
         if (err) {
             error_propagate(errp, err);
-- 
2.26.2


