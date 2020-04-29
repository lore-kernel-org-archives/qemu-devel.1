Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A60C83000
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 14:09:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 831372083B
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 14:09:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G6XeiYVB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 831372083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTnOj-0008LF-Ld
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 10:09:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42450)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jTnGf-0002GR-By
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 10:01:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jTnGB-0003sl-KQ
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 10:00:53 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:25267
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jTnGB-0003rX-75
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 10:00:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588168822;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5ZDaOnP7JoaHpj6dJQ1fXf7vB0ob55bzO9rc0pYbHF0=;
 b=G6XeiYVBb9R/WW4AuKeeQZUZ7eMFbzG4EAq1RAcWtrHAP7dDZ80r/tEwWKqZ3HQnR2fm03
 voWKOkHi7/hfBf6Hc0FxuG0hJM7jtbTbmZaVb+5xx1WzKzqnCQEZn12o6nLGquxC3LIFjV
 TpQ1COPSBF+C4vYEXgRFvKriaNZ8/XA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-216-Dg2078jNOQWiCF376AWcyQ-1; Wed, 29 Apr 2020 10:00:19 -0400
X-MC-Unique: Dg2078jNOQWiCF376AWcyQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5EECC8C1A00;
 Wed, 29 Apr 2020 14:00:18 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-193.ams2.redhat.com
 [10.36.113.193])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3B1205D9C9;
 Wed, 29 Apr 2020 14:00:17 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 8B43B9DA6; Wed, 29 Apr 2020 16:00:03 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 11/15] acpi: move aml builder code for parallel device
Date: Wed, 29 Apr 2020 15:59:59 +0200
Message-Id: <20200429140003.7336-12-kraxel@redhat.com>
In-Reply-To: <20200429140003.7336-1-kraxel@redhat.com>
References: <20200429140003.7336-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 00:53:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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

Also adds support for multiple LPT devices.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/char/parallel.c   | 32 ++++++++++++++++++++++++++++++++
 hw/i386/acpi-build.c | 23 -----------------------
 2 files changed, 32 insertions(+), 23 deletions(-)

diff --git a/hw/char/parallel.c b/hw/char/parallel.c
index 8dd67d13759b..bc6b55b3b910 100644
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
@@ -568,6 +569,35 @@ static void parallel_isa_realizefn(DeviceState *dev, E=
rror **errp)
                              s, "parallel");
 }
=20
+static void parallel_isa_build_aml(ISADevice *isadev, Aml *scope)
+{
+    ISAParallelState *isa =3D ISA_PARALLEL(isadev);
+    int i, uid =3D 0;
+    Aml *dev;
+    Aml *crs;
+
+    for (i =3D 0; i < ARRAY_SIZE(isa_parallel_io); i++) {
+        if (isa->iobase =3D=3D isa_parallel_io[i]) {
+            uid =3D i + 1;
+        }
+    }
+    if (!uid) {
+        return;
+    }
+
+    crs =3D aml_resource_template();
+    aml_append(crs, aml_io(AML_DECODE16, isa->iobase, isa->iobase, 0x08, 0=
x08));
+    aml_append(crs, aml_irq_no_flags(isa->isairq));
+
+    dev =3D aml_device("LPT%d", uid);
+    aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0400")));
+    aml_append(dev, aml_name_decl("_UID", aml_int(uid)));
+    aml_append(dev, aml_name_decl("_STA", aml_int(0xf)));
+    aml_append(dev, aml_name_decl("_CRS", crs));
+
+    aml_append(scope, dev);
+}
+
 /* Memory mapped interface */
 static uint64_t parallel_mm_readfn(void *opaque, hwaddr addr, unsigned siz=
e)
 {
@@ -624,9 +654,11 @@ static Property parallel_isa_properties[] =3D {
 static void parallel_isa_class_initfn(ObjectClass *klass, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
+    ISADeviceClass *isa =3D ISA_DEVICE_CLASS(klass);
=20
     dc->realize =3D parallel_isa_realizefn;
     dc->vmsd =3D &vmstate_parallel_isa;
+    isa->build_aml =3D parallel_isa_build_aml;
     device_class_set_props(dc, parallel_isa_properties);
     set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
 }
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index e01afbd011d9..12a017e1f45b 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1167,28 +1167,6 @@ static Aml *build_mouse_device_aml(void)
     return dev;
 }
=20
-static void build_lpt_device_aml(Aml *scope)
-{
-    Aml *dev;
-    Aml *crs;
-
-    if (!memory_region_present(get_system_io(), 0x0378)) {
-        return;
-    }
-
-    dev =3D aml_device("LPT");
-    aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0400")));
-
-    aml_append(dev, aml_name_decl("_STA", aml_int(0xf)));
-
-    crs =3D aml_resource_template();
-    aml_append(crs, aml_io(AML_DECODE16, 0x0378, 0x0378, 0x08, 0x08));
-    aml_append(crs, aml_irq_no_flags(7));
-    aml_append(dev, aml_name_decl("_CRS", crs));
-
-    aml_append(scope, dev);
-}
-
 static void build_isa_devices_aml(Aml *table)
 {
     ISADevice *fdc =3D pc_find_fdc0();
@@ -1202,7 +1180,6 @@ static void build_isa_devices_aml(Aml *table)
     if (fdc) {
         aml_append(scope, build_fdc_device_aml(fdc));
     }
-    build_lpt_device_aml(scope);
=20
     if (ambiguous) {
         error_report("Multiple ISA busses, unable to define IPMI ACPI data=
");
--=20
2.18.2


