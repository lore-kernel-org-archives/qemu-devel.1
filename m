Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22EDDC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 14:58:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD01D20691
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 14:58:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Iag6ZhhP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD01D20691
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjl8Y-00023W-2H
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 10:58:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49722)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jjl1p-0005oE-Ox
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 10:51:33 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:54386
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jjl1n-0001OR-Tu
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 10:51:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591973491;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KpsP6snzFwXir/Xzc+9Qv0RUmc46Jj6u+9GlR3QS4bo=;
 b=Iag6ZhhP1jMPgMJlwvD/q5HIre97nOgUsVZN+Gr1rwBtmh7ssoIw7EWW6ipJQEobWEIX36
 69E0vQrqb3yWq0tTEujyfDCt1AUWec4/BLygO1NhcS0uaWawZoHBLn6BALTsMwiWrcUa9i
 H8S4VNylv9YpuF/qzv/2PRBlSSLPPqo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-317-T1IOaocINeyIfa33qLyWMQ-1; Fri, 12 Jun 2020 10:51:29 -0400
X-MC-Unique: T1IOaocINeyIfa33qLyWMQ-1
Received: by mail-wr1-f70.google.com with SMTP id c14so3961574wrw.11
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2020 07:51:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=KpsP6snzFwXir/Xzc+9Qv0RUmc46Jj6u+9GlR3QS4bo=;
 b=jpZRCfeIJg/S2Np+Mhb98xs4ExECfzCrVXaX/m388DVjt3+yeej64KeK5cB89TFDkG
 qrN8LmY9Z9DBmHKpqnKgBEyaLp4Y2u16QJBlRDSeDu1FC3dDO8avgZqDZ33mlvLUyrdy
 snmYnbUwMB9eYrFsdty8L9c6B+BvVN7PjiVqjWeVKyVx07+hDRyZltDrT7W5U4PtClkf
 nuWsltyNfvhH3+I/+3I1+We0JKJxtYSPEJ5vh627eVFie2Hy/3mHRaN+R0KPcwrK/wAw
 StbrJeOklE7BzciKhfY1YlTYh8WgQo6BnGyzSJ2mUSd+vEutpOksXlrCQSKFsC2CuLeY
 iydw==
X-Gm-Message-State: AOAM530b/25DePiEhU3WaR/wCf/v2NN0HqWA2dduTtDFrPO0rTiWIr2l
 qzeU83DnyVgcOwxdIk0Nhgh18mWEBa2fV4eKIrlfnNDrNCrCG0CtST86u1loyScBmruh7/662cV
 ZvtmpEDomcrq0oP4=
X-Received: by 2002:a5d:5704:: with SMTP id a4mr15280569wrv.389.1591973488111; 
 Fri, 12 Jun 2020 07:51:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy8xJDnl0b3jVB+hsMKJucrZNmC19qNHHbLXV7tqtyW/zHJTYVWw/AyvpbR8PnZJTsMmU1gSQ==
X-Received: by 2002:a5d:5704:: with SMTP id a4mr15280547wrv.389.1591973487935; 
 Fri, 12 Jun 2020 07:51:27 -0700 (PDT)
Received: from redhat.com (bzq-79-178-18-124.red.bezeqint.net. [79.178.18.124])
 by smtp.gmail.com with ESMTPSA id x18sm8853389wmi.35.2020.06.12.07.51.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2020 07:51:27 -0700 (PDT)
Date: Fri, 12 Jun 2020 10:51:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 11/58] acpi: move aml builder code for parallel device
Message-ID: <20200612141917.9446-12-mst@redhat.com>
References: <20200612141917.9446-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200612141917.9446-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/12 08:07:17
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
 Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Gerd Hoffmann <kraxel@redhat.com>

Also adds support for multiple LPT devices.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200515150421.25479-8-kraxel@redhat.com>
---
 hw/char/parallel.c   | 22 ++++++++++++++++++++++
 hw/i386/acpi-build.c | 23 -----------------------
 2 files changed, 22 insertions(+), 23 deletions(-)

diff --git a/hw/char/parallel.c b/hw/char/parallel.c
index 8dd67d1375..c0f34bf924 100644
--- a/hw/char/parallel.c
+++ b/hw/char/parallel.c
@@ -28,6 +28,7 @@
 #include "qemu/module.h"
 #include "chardev/char-parallel.h"
 #include "chardev/char-fe.h"
+#include "hw/acpi/aml-build.h"
 #include "hw/irq.h"
 #include "hw/isa/isa.h"
 #include "hw/qdev-properties.h"
@@ -568,6 +569,25 @@ static void parallel_isa_realizefn(DeviceState *dev, Error **errp)
                              s, "parallel");
 }
 
+static void parallel_isa_build_aml(ISADevice *isadev, Aml *scope)
+{
+    ISAParallelState *isa = ISA_PARALLEL(isadev);
+    Aml *dev;
+    Aml *crs;
+
+    crs = aml_resource_template();
+    aml_append(crs, aml_io(AML_DECODE16, isa->iobase, isa->iobase, 0x08, 0x08));
+    aml_append(crs, aml_irq_no_flags(isa->isairq));
+
+    dev = aml_device("LPT%d", isa->index + 1);
+    aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0400")));
+    aml_append(dev, aml_name_decl("_UID", aml_int(isa->index + 1)));
+    aml_append(dev, aml_name_decl("_STA", aml_int(0xf)));
+    aml_append(dev, aml_name_decl("_CRS", crs));
+
+    aml_append(scope, dev);
+}
+
 /* Memory mapped interface */
 static uint64_t parallel_mm_readfn(void *opaque, hwaddr addr, unsigned size)
 {
@@ -624,9 +644,11 @@ static Property parallel_isa_properties[] = {
 static void parallel_isa_class_initfn(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
+    ISADeviceClass *isa = ISA_DEVICE_CLASS(klass);
 
     dc->realize = parallel_isa_realizefn;
     dc->vmsd = &vmstate_parallel_isa;
+    isa->build_aml = parallel_isa_build_aml;
     device_class_set_props(dc, parallel_isa_properties);
     set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
 }
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 2cafad03e2..58fe505fb6 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1173,28 +1173,6 @@ static Aml *build_mouse_device_aml(void)
     return dev;
 }
 
-static void build_lpt_device_aml(Aml *scope)
-{
-    Aml *dev;
-    Aml *crs;
-
-    if (!memory_region_present(get_system_io(), 0x0378)) {
-        return;
-    }
-
-    dev = aml_device("LPT");
-    aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0400")));
-
-    aml_append(dev, aml_name_decl("_STA", aml_int(0xf)));
-
-    crs = aml_resource_template();
-    aml_append(crs, aml_io(AML_DECODE16, 0x0378, 0x0378, 0x08, 0x08));
-    aml_append(crs, aml_irq_no_flags(7));
-    aml_append(dev, aml_name_decl("_CRS", crs));
-
-    aml_append(scope, dev);
-}
-
 static void build_isa_devices_aml(Aml *table)
 {
     ISADevice *fdc = pc_find_fdc0();
@@ -1208,7 +1186,6 @@ static void build_isa_devices_aml(Aml *table)
     if (fdc) {
         aml_append(scope, build_fdc_device_aml(fdc));
     }
-    build_lpt_device_aml(scope);
 
     if (ambiguous) {
         error_report("Multiple ISA busses, unable to define IPMI ACPI data");
-- 
MST


