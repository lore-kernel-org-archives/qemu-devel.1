Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F00C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 23:13:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4D13206F7
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 23:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cSThRj2h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4D13206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joEZl-0002gV-6Y
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 19:13:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42170)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1joETk-0008NX-TC
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 19:06:52 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:35924
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1joETj-0001Pd-21
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 19:06:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593040010;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4103IHCahkyMhhMJ5CqnoOKuVcMixIsrI5jBYx2fDK8=;
 b=cSThRj2hGitj9SomN1O0iFQgiMNNS+YZx9uSaTR+HFMPmDUmEEdPA8m8PUiJXvGqZd5nc1
 LgJ0WUSb94CJMMGZgFJRQcZPxns6x2OSHkpCpQ9o/wCfy6DbRKHA42PUZvMzzHgOAidfrP
 lUnlPTLZtl9M9yKH3i3ekis6z39I1wM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-Q0EoPfi8MXywKDE_PKDB2w-1; Wed, 24 Jun 2020 19:06:48 -0400
X-MC-Unique: Q0EoPfi8MXywKDE_PKDB2w-1
Received: by mail-wr1-f70.google.com with SMTP id a6so4733245wrq.3
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 16:06:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=4103IHCahkyMhhMJ5CqnoOKuVcMixIsrI5jBYx2fDK8=;
 b=ZfTJp3JE/7bKQQCJBMgx7Hdh3fRnMxD2u7oM+eyEEIW55ItWVJ7OirQ9/ij1604J+l
 2Y5zeIUbjCxAPQ4gDLkni8Kjl1/ruo/Jw6arJ845ZxNl4Mgyv3veXv1+3ZZQjM5Y9qPZ
 Mg9t6xjtwf/luWq0eceEHfrqXGMO6OOpxTzU2s7W9lvSSh/wgeK1lT+lnsD6inpdiS5U
 ZKvWRrkLaR1y/5SeIunQlB3Fau9jca963vRv51q0v40y/X5nni3K2Sd0PpBmiNZOdimp
 q7qp8PoEgugwJniC2KWUDwPBykYdNK2mVIpQ8S2YcBmeT9OU/xROBGHKyophSw5frYMn
 iqpA==
X-Gm-Message-State: AOAM532J8gB5bMhUYo3gH4ImC8gHii41HzHpcuMQs0+5gOsEA10CqalU
 twoI7BrUvi1HdH6oIPvGTHKaZeh977pvFuR+7agF/fX0BotsQzuIm1uUoHY9THRIcyJeM5v0t+Q
 W/K1BPmRytz59PAg=
X-Received: by 2002:adf:9286:: with SMTP id 6mr33831454wrn.361.1593040006716; 
 Wed, 24 Jun 2020 16:06:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyo8ugK1vjkowQx1kL5pUwtfekIUeCULLH1ZVGFiaadrPFIkvACHNVcpkfpV1rFxi6ZxV0iDQ==
X-Received: by 2002:adf:9286:: with SMTP id 6mr33831436wrn.361.1593040006534; 
 Wed, 24 Jun 2020 16:06:46 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 11sm10040719wmg.41.2020.06.24.16.06.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2020 16:06:45 -0700 (PDT)
Date: Wed, 24 Jun 2020 19:06:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 06/19] acpi: move aml builder code for i8042 (kbd+mouse) device
Message-ID: <20200624230609.703104-7-mst@redhat.com>
References: <20200624230609.703104-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200624230609.703104-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 01:59:40
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
 Eduardo Habkost <ehabkost@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Gerd Hoffmann <kraxel@redhat.com>

DSDT change: isa device order changes in case MI1 (ipmi) is present.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20200619091905.21676-7-kraxel@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/acpi-build.c | 39 ---------------------------------------
 hw/input/pckbd.c     | 31 +++++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 39 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 45297d9a90..13113e83df 100644
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
index 60a4130320..29d633ca94 100644
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
 
-- 
MST


