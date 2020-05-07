Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A91C38A2A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 13:18:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5276920708
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 13:18:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZJ3cgYX5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5276920708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWgPv-0002vT-Cx
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 09:18:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54964)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jWgOb-0000Zj-5s
 for qemu-devel@nongnu.org; Thu, 07 May 2020 09:17:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42732
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jWgOa-0005UC-1p
 for qemu-devel@nongnu.org; Thu, 07 May 2020 09:17:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588857419;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kLf2LG53Ycyq+Slhr14t+DqqkTQ/JgLPQjJmg2uSvFg=;
 b=ZJ3cgYX5Q7BJzxiKV1yprm3/1Q2iWXhYSgN6IPV3gnYtw1sAuz1mN8Cqw2iLxSx3LUE3in
 tzRAVc0Yv00Uu5aoqnV3jaAT7TER2VTz3FFTVk6zcf2CXGNoFR4REbg/HCPKEYwtD799eL
 uPxpHbVcYTwLM/We6/fmD7h3GY+UwOE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-453-4TzE2hq3Oc6tRW1bNZH11A-1; Thu, 07 May 2020 09:16:53 -0400
X-MC-Unique: 4TzE2hq3Oc6tRW1bNZH11A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 26296835B90;
 Thu,  7 May 2020 13:16:52 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-193.ams2.redhat.com
 [10.36.113.193])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5A6DD5D9DC;
 Thu,  7 May 2020 13:16:51 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id A6CE99DAD; Thu,  7 May 2020 15:16:40 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 09/15] acpi: move aml builder code for i8042 (kbd+mouse)
 device
Date: Thu,  7 May 2020 15:16:34 +0200
Message-Id: <20200507131640.14041-10-kraxel@redhat.com>
In-Reply-To: <20200507131640.14041-1-kraxel@redhat.com>
References: <20200507131640.14041-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 03:56:18
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
 Max Reitz <mreitz@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/i386/acpi-build.c | 39 ---------------------------------------
 hw/input/pckbd.c     | 31 +++++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 39 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 775936e28b9a..829e20664fff 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1058,42 +1058,6 @@ static void build_hpet_aml(Aml *table)
     aml_append(table, scope);
 }
=20
-static Aml *build_kbd_device_aml(void)
-{
-    Aml *dev;
-    Aml *crs;
-
-    dev =3D aml_device("KBD");
-    aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0303")));
-
-    aml_append(dev, aml_name_decl("_STA", aml_int(0xf)));
-
-    crs =3D aml_resource_template();
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
-    dev =3D aml_device("MOU");
-    aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0F13")));
-
-    aml_append(dev, aml_name_decl("_STA", aml_int(0xf)));
-
-    crs =3D aml_resource_template();
-    aml_append(crs, aml_irq_no_flags(12));
-    aml_append(dev, aml_name_decl("_CRS", crs));
-
-    return dev;
-}
-
 static void build_isa_devices_aml(Aml *table)
 {
     bool ambiguous;
@@ -1101,9 +1065,6 @@ static void build_isa_devices_aml(Aml *table)
     Aml *scope =3D aml_scope("_SB.PCI0.ISA");
     Object *obj =3D object_resolve_path_type("", TYPE_ISA_BUS, &ambiguous)=
;
=20
-    aml_append(scope, build_kbd_device_aml());
-    aml_append(scope, build_mouse_device_aml());
-
     if (ambiguous) {
         error_report("Multiple ISA busses, unable to define IPMI ACPI data=
");
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
@@ -561,12 +562,42 @@ static void i8042_realizefn(DeviceState *dev, Error *=
*errp)
     qemu_register_reset(kbd_reset, s);
 }
=20
+static void i8042_build_aml(ISADevice *isadev, Aml *scope)
+{
+    Aml *kbd;
+    Aml *mou;
+    Aml *crs;
+
+    crs =3D aml_resource_template();
+    aml_append(crs, aml_io(AML_DECODE16, 0x0060, 0x0060, 0x01, 0x01));
+    aml_append(crs, aml_io(AML_DECODE16, 0x0064, 0x0064, 0x01, 0x01));
+    aml_append(crs, aml_irq_no_flags(1));
+
+    kbd =3D aml_device("KBD");
+    aml_append(kbd, aml_name_decl("_HID", aml_eisaid("PNP0303")));
+    aml_append(kbd, aml_name_decl("_STA", aml_int(0xf)));
+    aml_append(kbd, aml_name_decl("_CRS", crs));
+
+    crs =3D aml_resource_template();
+    aml_append(crs, aml_irq_no_flags(12));
+
+    mou =3D aml_device("MOU");
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
     DeviceClass *dc =3D DEVICE_CLASS(klass);
+    ISADeviceClass *isa =3D ISA_DEVICE_CLASS(klass);
=20
     dc->realize =3D i8042_realizefn;
     dc->vmsd =3D &vmstate_kbd_isa;
+    isa->build_aml =3D i8042_build_aml;
     set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
 }
=20
--=20
2.18.4


