Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82987C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 14:54:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DBE12067B
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 14:54:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eQgKiJaf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DBE12067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjl4u-0003CI-Jj
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 10:54:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49698)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jjl1n-0005ik-NB
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 10:51:31 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:41392
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jjl1l-0001O8-SJ
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 10:51:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591973489;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=loh3X3+SXpnVYZPqqNYKR+1uymLr/TH131RlRRt7Mrw=;
 b=eQgKiJafPq6N17SWuWDcXhUstVcPgRuwQ6c0bt2EiUaQ2vPVKyFULB/kZpV4yo+mAVJD2m
 aGOsQ/onvYl/eKIN2LHWxsb7PalCb0b5PYHHXoRmT1Ry40B+bgeIonGFmnzcOZ4Dpo7cZ0
 BF/Vl9V491yTHD/axSlVG4j2bOX8rLo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-68-KCQ7P_SPMbyMKq7NmMBxUQ-1; Fri, 12 Jun 2020 10:51:27 -0400
X-MC-Unique: KCQ7P_SPMbyMKq7NmMBxUQ-1
Received: by mail-wm1-f69.google.com with SMTP id u15so2034421wmm.5
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2020 07:51:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=loh3X3+SXpnVYZPqqNYKR+1uymLr/TH131RlRRt7Mrw=;
 b=AOif7dkIkQXWj0064n6p5ClGJBXXNzMuN0licIHQ4vIIBiJxALkp4pTXq3+SUbNsU2
 OmiBgPsLxXUpr8nReef9EbZg0Rxnb3dyruZKZWC0mx4KrOoiTOgSlZvfsYjVsA2ohm7q
 adCCYpOT8mQKaP3Q9kj5dSATK0WwQWVPHFi3KeEPGFJHJ3dZuJI+TdHC4nT6fex/5gGl
 ui/J3nI8jaW6wiBK1ttnlIuJwIoUwqzk8T4kxieO1yKhiR6OIeYamNu13WSt9htl0QWj
 F7obIAwfk/hRwqbMaiDZzig1AYedUizrZuqNQ/+mXJMmOkvsB9O0SsAcXg2QJRyqLPV+
 CH7Q==
X-Gm-Message-State: AOAM533NUM3KkSTKHvV5txTMOFr9nbpB+e1Vvqggke/Xu3QowcNx8nOA
 xHbN7yxf2FmeqtYJ2epwot8lbUcXagrcK+E6ai3FRTccQIDLGIh7mcZ/muVcjQPk2TL60qRakpU
 6XjZljTW0HI5PAe8=
X-Received: by 2002:a1c:7206:: with SMTP id n6mr14233883wmc.4.1591973483207;
 Fri, 12 Jun 2020 07:51:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw2wIMdcECWDx1W9/F27uwoiq2hrAbmk1LTDZI64gJdWi8mhBBqiCuYhMZYQmVg78U43XpbqQ==
X-Received: by 2002:a1c:7206:: with SMTP id n6mr14233867wmc.4.1591973483018;
 Fri, 12 Jun 2020 07:51:23 -0700 (PDT)
Received: from redhat.com (bzq-79-178-18-124.red.bezeqint.net. [79.178.18.124])
 by smtp.gmail.com with ESMTPSA id 40sm11158791wrc.15.2020.06.12.07.51.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2020 07:51:22 -0700 (PDT)
Date: Fri, 12 Jun 2020 10:51:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 09/58] acpi: move aml builder code for serial device
Message-ID: <20200612141917.9446-10-mst@redhat.com>
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
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/12 09:30:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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

The code uses the isa_serial_io array to figure what the device uid is.
Side effect is that acpi antries are not limited to port 1+2 any more,
we'll also get entries for ports 3+4.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200515150421.25479-6-kraxel@redhat.com>
---
 hw/char/serial-isa.c | 22 ++++++++++++++++++++++
 hw/i386/acpi-build.c | 32 --------------------------------
 2 files changed, 22 insertions(+), 32 deletions(-)

diff --git a/hw/char/serial-isa.c b/hw/char/serial-isa.c
index f9b6eed783..165e320e65 100644
--- a/hw/char/serial-isa.c
+++ b/hw/char/serial-isa.c
@@ -27,6 +27,7 @@
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "sysemu/sysemu.h"
+#include "hw/acpi/aml-build.h"
 #include "hw/char/serial.h"
 #include "hw/isa/isa.h"
 #include "hw/qdev-properties.h"
@@ -81,6 +82,25 @@ static void serial_isa_realizefn(DeviceState *dev, Error **errp)
     isa_register_ioport(isadev, &s->io, isa->iobase);
 }
 
+static void serial_isa_build_aml(ISADevice *isadev, Aml *scope)
+{
+    ISASerialState *isa = ISA_SERIAL(isadev);
+    Aml *dev;
+    Aml *crs;
+
+    crs = aml_resource_template();
+    aml_append(crs, aml_io(AML_DECODE16, isa->iobase, isa->iobase, 0x00, 0x08));
+    aml_append(crs, aml_irq_no_flags(isa->isairq));
+
+    dev = aml_device("COM%d", isa->index + 1);
+    aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0501")));
+    aml_append(dev, aml_name_decl("_UID", aml_int(isa->index + 1)));
+    aml_append(dev, aml_name_decl("_STA", aml_int(0xf)));
+    aml_append(dev, aml_name_decl("_CRS", crs));
+
+    aml_append(scope, dev);
+}
+
 static const VMStateDescription vmstate_isa_serial = {
     .name = "serial",
     .version_id = 3,
@@ -103,9 +123,11 @@ static Property serial_isa_properties[] = {
 static void serial_isa_class_initfn(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
+    ISADeviceClass *isa = ISA_DEVICE_CLASS(klass);
 
     dc->realize = serial_isa_realizefn;
     dc->vmsd = &vmstate_isa_serial;
+    isa->build_aml = serial_isa_build_aml;
     device_class_set_props(dc, serial_isa_properties);
     set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
 }
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index cb22cb0fe6..6de25f6484 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1208,36 +1208,6 @@ static Aml *build_lpt_device_aml(void)
     return dev;
 }
 
-static void build_com_device_aml(Aml *scope, uint8_t uid)
-{
-    Aml *dev;
-    Aml *crs;
-    uint8_t irq = 4;
-    uint16_t io_port = 0x03F8;
-
-    assert(uid == 1 || uid == 2);
-    if (uid == 2) {
-        irq = 3;
-        io_port = 0x02F8;
-    }
-    if (!memory_region_present(get_system_io(), io_port)) {
-        return;
-    }
-
-    dev = aml_device("COM%d", uid);
-    aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0501")));
-    aml_append(dev, aml_name_decl("_UID", aml_int(uid)));
-
-    aml_append(dev, aml_name_decl("_STA", aml_int(0xf)));
-
-    crs = aml_resource_template();
-    aml_append(crs, aml_io(AML_DECODE16, io_port, io_port, 0x00, 0x08));
-    aml_append(crs, aml_irq_no_flags(irq));
-    aml_append(dev, aml_name_decl("_CRS", crs));
-
-    aml_append(scope, dev);
-}
-
 static void build_isa_devices_aml(Aml *table)
 {
     ISADevice *fdc = pc_find_fdc0();
@@ -1252,8 +1222,6 @@ static void build_isa_devices_aml(Aml *table)
         aml_append(scope, build_fdc_device_aml(fdc));
     }
     aml_append(scope, build_lpt_device_aml());
-    build_com_device_aml(scope, 1);
-    build_com_device_aml(scope, 2);
 
     if (ambiguous) {
         error_report("Multiple ISA busses, unable to define IPMI ACPI data");
-- 
MST


