Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8CA6C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 15:08:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5B342076A
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 15:08:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UhYUZW7r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5B342076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZbwo-00083S-RZ
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 11:08:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48518)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jZbtB-0000um-T4
 for qemu-devel@nongnu.org; Fri, 15 May 2020 11:04:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26076
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jZbt8-0001AQ-VD
 for qemu-devel@nongnu.org; Fri, 15 May 2020 11:04:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589555078;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=faAdizEussft1IhAqCXbHMqyYK+xsct2InbS9hpx9V4=;
 b=UhYUZW7rz4tkOQC5dkLBSHv1mI3KFR6D/bOcDqDJvyZ96+GFMbZxZd6fpyIu9Qj4STLBsL
 cG8xHuQSKQQdQX/vm/h0fFJegBrVsJo3I7vt26VURT5D0rXwxuRotwt0+/LGNqQElV+uvH
 c/ETnoCRiavegYUaBUvcz2zaJQE9NNs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-230-abugkkeePMWeYGBCbudMLA-1; Fri, 15 May 2020 11:04:33 -0400
X-MC-Unique: abugkkeePMWeYGBCbudMLA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A5189800053;
 Fri, 15 May 2020 15:04:32 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-115-145.ams2.redhat.com
 [10.36.115.145])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0561B5D714;
 Fri, 15 May 2020 15:04:32 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id D7AFE9D5B; Fri, 15 May 2020 17:04:21 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 07/16] acpi: move aml builder code for parallel device
Date: Fri, 15 May 2020 17:04:12 +0200
Message-Id: <20200515150421.25479-8-kraxel@redhat.com>
In-Reply-To: <20200515150421.25479-1-kraxel@redhat.com>
References: <20200515150421.25479-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 23:27:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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

Also adds support for multiple LPT devices.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/char/parallel.c   | 22 ++++++++++++++++++++++
 hw/i386/acpi-build.c | 23 -----------------------
 2 files changed, 22 insertions(+), 23 deletions(-)

diff --git a/hw/char/parallel.c b/hw/char/parallel.c
index 8dd67d13759b..c0f34bf924ec 100644
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
index 2188a2b99d18..443db94deb5b 100644
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
2.18.4


