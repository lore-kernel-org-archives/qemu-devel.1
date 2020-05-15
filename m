Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B06C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 15:06:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 560A32075F
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 15:06:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L0L2jNFO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 560A32075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZbuf-0003kV-I4
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 11:06:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48478)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jZbt8-0000m9-GO
 for qemu-devel@nongnu.org; Fri, 15 May 2020 11:04:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24635
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jZbt6-000197-93
 for qemu-devel@nongnu.org; Fri, 15 May 2020 11:04:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589555075;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X/757cAOOEVAIRv8q9tT4p1h2VrBFcNg4z5LyBn7QYw=;
 b=L0L2jNFOsxzPWX9kjmZjh60OFiv7MxnN3QqLxXmSOCsoaXum7DaR43CZdJyu6Vd/pREwMQ
 ZrL2Kl4WQDKhaX5HEyijRqt88s/FQhV31W1XzDReImSzCrmsL2LqJaXgO5QAXLtXPZUFWH
 5FBcXBmAuOVyV8ph/6xhReu5hR5LDNY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-PVAUkJDZM92Ox3XkQ4QorA-1; Fri, 15 May 2020 11:04:33 -0400
X-MC-Unique: PVAUkJDZM92Ox3XkQ4QorA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 88801107ACF4;
 Fri, 15 May 2020 15:04:32 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-115-145.ams2.redhat.com
 [10.36.115.145])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EE40663F8F;
 Fri, 15 May 2020 15:04:31 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id C40BB9D59; Fri, 15 May 2020 17:04:21 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 05/16] acpi: move aml builder code for serial device
Date: Fri, 15 May 2020 17:04:10 +0200
Message-Id: <20200515150421.25479-6-kraxel@redhat.com>
In-Reply-To: <20200515150421.25479-1-kraxel@redhat.com>
References: <20200515150421.25479-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 22:56:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The code uses the isa_serial_io array to figure what the device uid is.
Side effect is that acpi antries are not limited to port 1+2 any more,
we'll also get entries for ports 3+4.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/char/serial-isa.c | 22 ++++++++++++++++++++++
 hw/i386/acpi-build.c | 32 --------------------------------
 2 files changed, 22 insertions(+), 32 deletions(-)

diff --git a/hw/char/serial-isa.c b/hw/char/serial-isa.c
index f9b6eed7833d..165e320e65f0 100644
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
index 3a82730a0d19..0e6a5151f4c3 100644
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
2.18.4


