Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE117C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 04:47:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 651BD20734
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 04:47:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P9VAV+jR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 651BD20734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiseU-000343-E4
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 00:47:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34630)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jisNe-00041Y-43
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 00:30:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23930
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jisNb-00005q-V5
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 00:30:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591763404;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KpsP6snzFwXir/Xzc+9Qv0RUmc46Jj6u+9GlR3QS4bo=;
 b=P9VAV+jRPSsIxLbWqdGqRO4GDR9UDG619ix45JiQzRrwzTfTJS6gdsNWaftjeKjlrj/nsq
 V30NLrpmUZS06xJAagdkagESK6UtD8G1SVO3uCocJhuNj/qobZ69GiOIFyvwcW25CSsMBz
 8sa624zmK8wBcjKi2+um3ZHK6hrWG4c=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-bz6pGaWCOCmLzfrzmKel3w-1; Wed, 10 Jun 2020 00:27:00 -0400
X-MC-Unique: bz6pGaWCOCmLzfrzmKel3w-1
Received: by mail-wr1-f72.google.com with SMTP id s17so509131wrt.7
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 21:27:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=KpsP6snzFwXir/Xzc+9Qv0RUmc46Jj6u+9GlR3QS4bo=;
 b=OATKDZekG1M/Aq8riMGYDu3663pYVV/ceCvUoxzYfjznugkik5pjr7CwlOL3dt4KTY
 nm6M/diEp8qL2q7xXWLMflpXxQuPO6K9wi7U8rY1Ov7GL9p5BBFLLzxgcJp1EfBfFGfd
 47k8JJKWCaB0cCgpkaxHHJSBBiq6GGsHvH4aLJx0bqAJGtSgoNndGoLx1BaZAQ8VAm53
 ROkmIDPIu8p2OwkmYnGN/WVl9Tp8EbWLiFiep5AoLkt2ySl+wlwPIaTKybdp9Gf++eON
 zfUF+4/xGJf7ERGqpyPbPVtWqmYruCWLzU4U9ZvQ5nO+TpAevlzXVILqVaz9anJPYC8W
 EQ/A==
X-Gm-Message-State: AOAM530M7s00V053LQ7qnlP5cbka9JCUbz9B6fc/5W0UlNBYLJu2FSZD
 /i8eUKOfzS8m+mnFFm9bSjyjMX3fJU2XcQ8fZKHttVunSfyF/CXJ19Sfq1C543n9pknyJOKwJgS
 nSE2dj57SipIgwlk=
X-Received: by 2002:a05:600c:4102:: with SMTP id
 j2mr1161429wmi.48.1591763219302; 
 Tue, 09 Jun 2020 21:26:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz+P9LvctaFEEaesPYRV//eo6qXbENBwuie8d5WgqL5E6i9MHQiAUtnNtsQxQ8bb8dx1Z6D7Q==
X-Received: by 2002:a05:600c:4102:: with SMTP id
 j2mr1161417wmi.48.1591763219054; 
 Tue, 09 Jun 2020 21:26:59 -0700 (PDT)
Received: from redhat.com (bzq-79-181-55-232.red.bezeqint.net. [79.181.55.232])
 by smtp.gmail.com with ESMTPSA id z206sm5397457wmg.30.2020.06.09.21.26.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 21:26:58 -0700 (PDT)
Date: Wed, 10 Jun 2020 00:26:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 11/56] acpi: move aml builder code for parallel device
Message-ID: <20200610042613.1459309-12-mst@redhat.com>
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
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 21:17:20
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


