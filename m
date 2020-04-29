Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28445C83000
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 14:07:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E88EE2082E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 14:07:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c3mqF4AX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E88EE2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTnMm-0003mr-WB
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 10:07:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42472)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jTnGj-0002IL-3S
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 10:01:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jTnGD-0003vf-Bw
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 10:00:56 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:33599
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jTnGC-0003u7-TN
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 10:00:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588168824;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vL4QYNC1Utz73dg8QggHg2T9y20pbXAwRG0RK2n+1Yk=;
 b=c3mqF4AXQR+97jMWtbq4nZkOUdFVTJkPyeHPoFznCPowkG1VG0m1HEvs+h7ujqEOC4Rdiu
 8H7ymcOoYPE5B4YnfOI+Kz1p2ytXpKKeOQmGqSfFLSTSy15xLynaX+HNcsI58RxkCmZGJB
 +N+zxNrYmUg9fx2OuKhZQEYCOEjUV48=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-kBxDakOlOWuCcZjVYvkvGA-1; Wed, 29 Apr 2020 10:00:20 -0400
X-MC-Unique: kBxDakOlOWuCcZjVYvkvGA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 11076107ACCA;
 Wed, 29 Apr 2020 14:00:19 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-193.ams2.redhat.com
 [10.36.113.193])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AEB9866069;
 Wed, 29 Apr 2020 14:00:16 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 645039DA0; Wed, 29 Apr 2020 16:00:03 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 07/15] acpi: move aml builder code for rtc device
Date: Wed, 29 Apr 2020 15:59:55 +0200
Message-Id: <20200429140003.7336-8-kraxel@redhat.com>
In-Reply-To: <20200429140003.7336-1-kraxel@redhat.com>
References: <20200429140003.7336-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 01:28:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
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

Also use a single io range instead of two,
following what real hardware does.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/i386/acpi-build.c | 17 -----------------
 hw/rtc/mc146818rtc.c | 20 ++++++++++++++++++++
 2 files changed, 20 insertions(+), 17 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 97f3c75cd995..f79e5eaf170d 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1131,22 +1131,6 @@ static Aml *build_fdc_device_aml(ISADevice *fdc)
     return dev;
 }
=20
-static Aml *build_rtc_device_aml(void)
-{
-    Aml *dev;
-    Aml *crs;
-
-    dev =3D aml_device("RTC");
-    aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0B00")));
-    crs =3D aml_resource_template();
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
@@ -1272,7 +1256,6 @@ static void build_isa_devices_aml(Aml *table)
     Aml *scope =3D aml_scope("_SB.PCI0.ISA");
     Object *obj =3D object_resolve_path_type("", TYPE_ISA_BUS, &ambiguous)=
;
=20
-    aml_append(scope, build_rtc_device_aml());
     aml_append(scope, build_kbd_device_aml());
     aml_append(scope, build_mouse_device_aml());
     if (fdc) {
diff --git a/hw/rtc/mc146818rtc.c b/hw/rtc/mc146818rtc.c
index d18c09911be2..47fafcfb7c1d 100644
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
@@ -1007,13 +1008,32 @@ static void rtc_resetdev(DeviceState *d)
     }
 }
=20
+static void rtc_build_aml(ISADevice *isadev, Aml *scope)
+{
+    Aml *dev;
+    Aml *crs;
+
+    crs =3D aml_resource_template();
+    aml_append(crs, aml_io(AML_DECODE16, RTC_ISA_BASE, RTC_ISA_BASE,
+                           0x10, 0x08));
+    aml_append(crs, aml_irq_no_flags(RTC_ISA_IRQ));
+
+    dev =3D aml_device("RTC");
+    aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0B00")));
+    aml_append(dev, aml_name_decl("_CRS", crs));
+
+    aml_append(scope, dev);
+}
+
 static void rtc_class_initfn(ObjectClass *klass, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
+    ISADeviceClass *isa =3D ISA_DEVICE_CLASS(klass);
=20
     dc->realize =3D rtc_realizefn;
     dc->reset =3D rtc_resetdev;
     dc->vmsd =3D &vmstate_rtc;
+    isa->build_aml =3D rtc_build_aml;
     device_class_set_props(dc, mc146818rtc_properties);
 }
=20
--=20
2.18.2


