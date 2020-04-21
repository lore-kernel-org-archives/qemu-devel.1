Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A2BC54FD0
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 12:35:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46AE32071C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 12:35:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YouLP0jX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46AE32071C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQs7C-0007fY-Cr
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 08:35:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59384)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jQrpp-0005nW-Vx
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 08:17:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jQrpo-0006yR-G1
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 08:17:04 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:55865)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jQrpn-0006tX-1C; Tue, 21 Apr 2020 08:17:03 -0400
Received: by mail-wm1-x343.google.com with SMTP id e26so3291642wmk.5;
 Tue, 21 Apr 2020 05:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=v/VKNfTk/p6cUWVFeTBWVu5kpM3OkAcXwfifz7UuQ5M=;
 b=YouLP0jXEAwMPe2IYglMiWmL9ZNdMl1jFFNZvPxXV7HCv4BEqup6xWUhJoKEYVUydY
 5WYdzdNS/qEFld2XJsV4xkR02HPF9WCTRUAljClMYnGrfnJQEHzt8OFkeQLqWAe0bGf8
 IX2/pab2ZiLgwWCMLXP0pkyWKqciysHH0BCeraxfvqZ4aycioXFhQjlxtZ1z4Y+XGT/+
 cMHbZGH2ichhFCbf7qNQxIzqI2LtocnYz7nHRBcEtBbg95d91u4Qr4pPB8dJsfzZ6rfM
 l0SE27oWnH3BUrymC7oX+5lGbcH/APYcNt75c82TwkmgiSjuw6bKBdHO566J8woXg5It
 8+Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=v/VKNfTk/p6cUWVFeTBWVu5kpM3OkAcXwfifz7UuQ5M=;
 b=rVEEEznTW0gPOFE/upSYQz6BvkbwjQYO1Bli1efFQrFHS5rG+Hg/mGJ5Mk/NeKveM4
 FXn2Q7epHWFHfWZPB2G/U9Ns1lh4LKB10Ju6I+Jnzpxu1F8lbUit7ZtmOK6U0T6CNrbT
 opdm34NqawjYR+CXLUYGRrS8s0rHaLmJrFgEGCbEbMYb8SQYY7m0+3UZX+3lz75LSxjF
 v3FbOW/tjX/poI+X8LPPTe/VmtR18ZJ9d6qzfUUJDC3OaYkJ+Pn0dWQJedbB7ILW18dR
 Tz3utcaqPAzS0AbKiO031yhwvDoCuB0L6hNlcEqHVXtbRxof95MbAVnGia/82kuWCSv1
 4DAA==
X-Gm-Message-State: AGi0PuYLDknkLcA/eMs5bFmTGbqSbGRaPZMdbRPF/nWmNHpZ2A/xbi49
 m/hG1EUnL0xV6SVbo7WnPoykZVeZRZw=
X-Google-Smtp-Source: APiQypJ+CajEavIA6cRjLXp4Jv4QccTdur7j7ltn/UDE0eCtkhmhD9mjHBFwYBa4QPcIipljBySG6w==
X-Received: by 2002:a1c:f416:: with SMTP id z22mr4666667wma.32.1587471419716; 
 Tue, 21 Apr 2020 05:16:59 -0700 (PDT)
Received: from x1w.redhat.com (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id z76sm3761140wmc.9.2020.04.21.05.16.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2020 05:16:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 16/17] hw/misc/imx6ul_ccm: Implement the
 'temperature-sensor' qdev interface
Date: Tue, 21 Apr 2020 14:16:25 +0200
Message-Id: <20200421121626.23791-17-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200421121626.23791-1-f4bug@amsat.org>
References: <20200421121626.23791-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 qemu-block@nongnu.org, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, Markus Armbruster <armbru@redhat.com>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, John Snow <jsnow@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The IMX6UL Clock Control Module can report few temperatures.
While the model doesn't implement it, we can still let it
implement the 'temperature-sensor' interface.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/misc/imx6ul_ccm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/misc/imx6ul_ccm.c b/hw/misc/imx6ul_ccm.c
index a2fc1d0364..2711cdaf09 100644
--- a/hw/misc/imx6ul_ccm.c
+++ b/hw/misc/imx6ul_ccm.c
@@ -16,6 +16,7 @@
 #include "hw/misc/imx6ul_ccm.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
+#include "hw/misc/temp-sensor.h"
 
 #include "trace.h"
 
@@ -864,12 +865,14 @@ static void imx6ul_ccm_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     IMXCCMClass *ccm = IMX_CCM_CLASS(klass);
+    TempSensorClass *tc = TEMPSENSOR_INTERFACE_CLASS(klass);
 
     dc->reset = imx6ul_ccm_reset;
     dc->vmsd = &vmstate_imx6ul_ccm;
     dc->desc = "i.MX6UL Clock Control Module";
 
     ccm->get_clock_frequency = imx6ul_ccm_get_clock_frequency;
+    tc->sensor_count = 3;
 }
 
 static const TypeInfo imx6ul_ccm_info = {
@@ -878,6 +881,10 @@ static const TypeInfo imx6ul_ccm_info = {
     .instance_size = sizeof(IMX6ULCCMState),
     .instance_init = imx6ul_ccm_init,
     .class_init    = imx6ul_ccm_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_TEMPSENSOR_INTERFACE },
+        { }
+    },
 };
 
 static void imx6ul_ccm_register_types(void)
-- 
2.21.1


