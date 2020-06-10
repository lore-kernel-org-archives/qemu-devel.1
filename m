Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 320E7C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 04:29:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE5962074B
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 04:29:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R7tSxxKE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE5962074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jisMt-0003BA-5q
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 00:29:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33954)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jisKD-0006vG-9h
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 00:26:53 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:60503
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jisKC-0008Cf-8P
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 00:26:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591763211;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vySMNxAYh/bFwZPNm+lRlFJjyR1SjtCLydsHIq5v2R0=;
 b=R7tSxxKEmvVIIoE7N/kzjj3U4Y1c+NYI+JR9IdIbauAiOUtRBXWVVM7CJVKy111Kpey6uq
 18NtpuQSIBPHhSXzADVneIqtgtLtPlz683g0x+6FvUIurMvNzRZpR9wEw8UWkOLXV0/HCj
 AnSNEHcMLpCHh7Pv4BkhNR4lbm6QOVE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-hCA3aMPAP8mC4FiiercLhA-1; Wed, 10 Jun 2020 00:26:49 -0400
X-MC-Unique: hCA3aMPAP8mC4FiiercLhA-1
Received: by mail-wr1-f71.google.com with SMTP id l1so509409wrc.8
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 21:26:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=vySMNxAYh/bFwZPNm+lRlFJjyR1SjtCLydsHIq5v2R0=;
 b=DrPYXX8RvuV+qTiTHz0wsMULN7NqzPG0FM7Gc4PwZRm7tVDQRIR55nBMvewfQmY+x0
 8adT/l5tsyOb24OWtqn5OZGInyKJIyv5FzXVi9p3itb1CFkPE0dROh4lZdPXQj7jZ6zy
 z4km3uLsyaDMoUgaPyyRu+RhV+Jk3CGdGyd4Vm+3PwQaU5hUTymE8l9pjGcJ79mGX3mT
 xd5lTGA3u4nQeDO1zmxMCQLHah1n8//qUxk3/gEE1xFcVjUD/fQ+9y9sSTVn4pmSPppw
 1r5/zLHt0Px+h5+nmvauON0KD31VFq94yuAo9MMBpuJCgQBjvx/U+sV9Skhn58ORDStr
 A/jQ==
X-Gm-Message-State: AOAM533PzQeUgPhAOOGSmQcmcqRdqeQNNNKJDCr4QaNj6esPsLgKZgdP
 /3x7R3OxyR2MVxNHk2hMv9ycS2x8dnixDBsxvfjE+pBJ7NUdYAuM6WQENq+Cvd90yOZNQo6Vxrh
 eD8SD/o4B3py7GQc=
X-Received: by 2002:a5d:608d:: with SMTP id w13mr1305997wrt.298.1591763207743; 
 Tue, 09 Jun 2020 21:26:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwZnvbIuMfpRndaKtrV+qb9eGbiuW4B2yeQqVBO23s0ILABxSLvENxqENxBpOP/4EEH3TDIXw==
X-Received: by 2002:a5d:608d:: with SMTP id w13mr1305981wrt.298.1591763207570; 
 Tue, 09 Jun 2020 21:26:47 -0700 (PDT)
Received: from redhat.com (bzq-79-181-55-232.red.bezeqint.net. [79.181.55.232])
 by smtp.gmail.com with ESMTPSA id k16sm6198770wrp.66.2020.06.09.21.26.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 21:26:47 -0700 (PDT)
Date: Wed, 10 Jun 2020 00:26:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 06/56] acpi: move aml builder code for rtc device
Message-ID: <20200610042613.1459309-7-mst@redhat.com>
References: <20200610042613.1459309-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200610042613.1459309-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 23:22:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
 Eduardo Habkost <ehabkost@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Gerd Hoffmann <kraxel@redhat.com>

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200515150421.25479-3-kraxel@redhat.com>
---
 hw/i386/acpi-build.c | 17 -----------------
 hw/rtc/mc146818rtc.c | 22 ++++++++++++++++++++++
 2 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index d996525e2c..df5417c75f 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1137,22 +1137,6 @@ static Aml *build_fdc_device_aml(ISADevice *fdc)
     return dev;
 }
 
-static Aml *build_rtc_device_aml(void)
-{
-    Aml *dev;
-    Aml *crs;
-
-    dev = aml_device("RTC");
-    aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0B00")));
-    crs = aml_resource_template();
-    aml_append(crs, aml_io(AML_DECODE16, 0x0070, 0x0070, 0x10, 0x02));
-    aml_append(crs, aml_irq_no_flags(8));
-    aml_append(crs, aml_io(AML_DECODE16, 0x0072, 0x0072, 0x02, 0x06));
-    aml_append(dev, aml_name_decl("_CRS", crs));
-
-    return dev;
-}
-
 static Aml *build_kbd_device_aml(void)
 {
     Aml *dev;
@@ -1278,7 +1262,6 @@ static void build_isa_devices_aml(Aml *table)
     Aml *scope = aml_scope("_SB.PCI0.ISA");
     Object *obj = object_resolve_path_type("", TYPE_ISA_BUS, &ambiguous);
 
-    aml_append(scope, build_rtc_device_aml());
     aml_append(scope, build_kbd_device_aml());
     aml_append(scope, build_mouse_device_aml());
     if (fdc) {
diff --git a/hw/rtc/mc146818rtc.c b/hw/rtc/mc146818rtc.c
index 9c30cbdcd7..fe05a4488e 100644
--- a/hw/rtc/mc146818rtc.c
+++ b/hw/rtc/mc146818rtc.c
@@ -27,6 +27,7 @@
 #include "qemu/cutils.h"
 #include "qemu/module.h"
 #include "qemu/bcd.h"
+#include "hw/acpi/aml-build.h"
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
 #include "qemu/timer.h"
@@ -1007,13 +1008,34 @@ static void rtc_resetdev(DeviceState *d)
     }
 }
 
+static void rtc_build_aml(ISADevice *isadev, Aml *scope)
+{
+    Aml *dev;
+    Aml *crs;
+
+    crs = aml_resource_template();
+    aml_append(crs, aml_io(AML_DECODE16, RTC_ISA_BASE, RTC_ISA_BASE,
+                           0x10, 0x02));
+    aml_append(crs, aml_irq_no_flags(RTC_ISA_IRQ));
+    aml_append(crs, aml_io(AML_DECODE16, RTC_ISA_BASE + 2, RTC_ISA_BASE + 2,
+                           0x02, 0x06));
+
+    dev = aml_device("RTC");
+    aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0B00")));
+    aml_append(dev, aml_name_decl("_CRS", crs));
+
+    aml_append(scope, dev);
+}
+
 static void rtc_class_initfn(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
+    ISADeviceClass *isa = ISA_DEVICE_CLASS(klass);
 
     dc->realize = rtc_realizefn;
     dc->reset = rtc_resetdev;
     dc->vmsd = &vmstate_rtc;
+    isa->build_aml = rtc_build_aml;
     device_class_set_props(dc, mc146818rtc_properties);
 }
 
-- 
MST


