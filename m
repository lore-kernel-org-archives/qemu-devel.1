Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1177AC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 07:20:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D03722073E
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 07:20:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LaGB91dK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D03722073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlSMc-0001mK-3m
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 03:20:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38454)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jlSFE-0007gB-Q4
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 03:12:24 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:35068
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jlSFA-0000aa-Vx
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 03:12:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592377940;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aOrkg4Bq1AyQnWT/LKJuy+2V/sf1OOGgK3vWrtb+27k=;
 b=LaGB91dKcHJRuPhoVKA7scrk/KJFzg7gnnY6ZeeWeggiwcbcO18F69Q7xPpoeZoB7ytI42
 8tdbarkYFagYqVGoLxRcHliMImuoInh1k0F33uRUuJo0XYcJEd/9KTZg7X5f35frxEMSgh
 yuMY+DkH+uq7pRMJLVTKY4YzsDEosSs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-216-RVwpJliRP-KfjFsxCwBAmg-1; Wed, 17 Jun 2020 03:12:18 -0400
X-MC-Unique: RVwpJliRP-KfjFsxCwBAmg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 05AE15AEE9;
 Wed, 17 Jun 2020 07:12:12 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-67.ams2.redhat.com
 [10.36.112.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E9FDB5D9D3;
 Wed, 17 Jun 2020 07:11:59 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id C191B9D92; Wed, 17 Jun 2020 09:11:38 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 05/10] acpi: move aml builder code for i8042 (kbd+mouse)
 device
Date: Wed, 17 Jun 2020 09:11:33 +0200
Message-Id: <20200617071138.11159-6-kraxel@redhat.com>
In-Reply-To: <20200617071138.11159-1-kraxel@redhat.com>
References: <20200617071138.11159-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 02:02:46
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
Cc: Laurent Vivier <lvivier@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Max Reitz <mreitz@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, John Snow <jsnow@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DSDT change: isa device order changes in case MI1 (ipmi) is present.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/i386/acpi-build.c            |  39 --------------------------------
 hw/input/pckbd.c                |  31 +++++++++++++++++++++++++
 tests/data/acpi/pc/DSDT.ipmikcs | Bin 5086 -> 5086 bytes
 tests/data/acpi/q35/DSDT.ipmibt | Bin 7827 -> 7827 bytes
 4 files changed, 31 insertions(+), 39 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 45297d9a90e7..13113e83dfe2 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -938,42 +938,6 @@ static void build_hpet_aml(Aml *table)
     aml_append(table, scope);
 }
 
-static Aml *build_kbd_device_aml(void)
-{
-    Aml *dev;
-    Aml *crs;
-
-    dev = aml_device("KBD");
-    aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0303")));
-
-    aml_append(dev, aml_name_decl("_STA", aml_int(0xf)));
-
-    crs = aml_resource_template();
-    aml_append(crs, aml_io(AML_DECODE16, 0x0060, 0x0060, 0x01, 0x01));
-    aml_append(crs, aml_io(AML_DECODE16, 0x0064, 0x0064, 0x01, 0x01));
-    aml_append(crs, aml_irq_no_flags(1));
-    aml_append(dev, aml_name_decl("_CRS", crs));
-
-    return dev;
-}
-
-static Aml *build_mouse_device_aml(void)
-{
-    Aml *dev;
-    Aml *crs;
-
-    dev = aml_device("MOU");
-    aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0F13")));
-
-    aml_append(dev, aml_name_decl("_STA", aml_int(0xf)));
-
-    crs = aml_resource_template();
-    aml_append(crs, aml_irq_no_flags(12));
-    aml_append(dev, aml_name_decl("_CRS", crs));
-
-    return dev;
-}
-
 static Aml *build_vmbus_device_aml(VMBusBridge *vmbus_bridge)
 {
     Aml *dev;
@@ -1019,9 +983,6 @@ static void build_isa_devices_aml(Aml *table)
     Aml *scope = aml_scope("_SB.PCI0.ISA");
     Object *obj = object_resolve_path_type("", TYPE_ISA_BUS, &ambiguous);
 
-    aml_append(scope, build_kbd_device_aml());
-    aml_append(scope, build_mouse_device_aml());
-
     if (ambiguous) {
         error_report("Multiple ISA busses, unable to define IPMI ACPI data");
     } else if (!obj) {
diff --git a/hw/input/pckbd.c b/hw/input/pckbd.c
index 60a41303203a..29d633ca9478 100644
--- a/hw/input/pckbd.c
+++ b/hw/input/pckbd.c
@@ -26,6 +26,7 @@
 #include "qemu/log.h"
 #include "hw/isa/isa.h"
 #include "migration/vmstate.h"
+#include "hw/acpi/aml-build.h"
 #include "hw/input/ps2.h"
 #include "hw/irq.h"
 #include "hw/input/i8042.h"
@@ -561,12 +562,42 @@ static void i8042_realizefn(DeviceState *dev, Error **errp)
     qemu_register_reset(kbd_reset, s);
 }
 
+static void i8042_build_aml(ISADevice *isadev, Aml *scope)
+{
+    Aml *kbd;
+    Aml *mou;
+    Aml *crs;
+
+    crs = aml_resource_template();
+    aml_append(crs, aml_io(AML_DECODE16, 0x0060, 0x0060, 0x01, 0x01));
+    aml_append(crs, aml_io(AML_DECODE16, 0x0064, 0x0064, 0x01, 0x01));
+    aml_append(crs, aml_irq_no_flags(1));
+
+    kbd = aml_device("KBD");
+    aml_append(kbd, aml_name_decl("_HID", aml_eisaid("PNP0303")));
+    aml_append(kbd, aml_name_decl("_STA", aml_int(0xf)));
+    aml_append(kbd, aml_name_decl("_CRS", crs));
+
+    crs = aml_resource_template();
+    aml_append(crs, aml_irq_no_flags(12));
+
+    mou = aml_device("MOU");
+    aml_append(mou, aml_name_decl("_HID", aml_eisaid("PNP0F13")));
+    aml_append(mou, aml_name_decl("_STA", aml_int(0xf)));
+    aml_append(mou, aml_name_decl("_CRS", crs));
+
+    aml_append(scope, kbd);
+    aml_append(scope, mou);
+}
+
 static void i8042_class_initfn(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
+    ISADeviceClass *isa = ISA_DEVICE_CLASS(klass);
 
     dc->realize = i8042_realizefn;
     dc->vmsd = &vmstate_kbd_isa;
+    isa->build_aml = i8042_build_aml;
     set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
 }
 
diff --git a/tests/data/acpi/pc/DSDT.ipmikcs b/tests/data/acpi/pc/DSDT.ipmikcs
index c285651131dc2ab8b0f32de750d7ac02a8b09936..1c19e2f354d022279d7e1343fa7212396d8c25a0 100644
GIT binary patch
delta 20
ccmcboeouYFO2)~oOdgY0GRAE7Wtu1m09c?0ga7~l

delta 20
ccmcboeouYFO2)|_8Dl1|Wc1kV%QR6C0AuwCZvX%Q

diff --git a/tests/data/acpi/q35/DSDT.ipmibt b/tests/data/acpi/q35/DSDT.ipmibt
index 38723daef80421ea528b2ad2d411e7357df43956..0173c3668a6cdef80127de7880a19cb5c5ea7dc0 100644
GIT binary patch
delta 20
ccmbPiJK1)F4%6fgChy5QOfj1;GaZly08TOoX8-^I

delta 20
ccmbPiJK1)F4%6gvrkKe(Ox~L>GaZly08Od~RsaA1

-- 
2.18.4


