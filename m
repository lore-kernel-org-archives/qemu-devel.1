Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C47C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 04:36:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C019A20734
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 04:36:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TtnE1ZYP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C019A20734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jisTH-0002Ff-TZ
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 00:36:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33990)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jisKL-00077y-Pl
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 00:27:01 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:48732
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jisKK-0008Dv-T6
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 00:27:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591763220;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eElz0rYHeKUNjkzhwC6MFQcNn/IDvjC4Rb+mBNhdY5E=;
 b=TtnE1ZYPMTiP8FrkDaGKChSQ8uKSg7JuWStU65OeRzue5jSfwd/JODtptTAimK23CxRhPe
 aaY6X3tRjubnY81peKpYZOyAQifl2RxNY3JrKoxKaWNODQES6X0No9gTsL6y0iWZFHnk2w
 XpmKt0pYvtNNEAV+NYd+MdBUFWbWHOE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-pfS6R0ToMe-6Lzie4A7WAg-1; Wed, 10 Jun 2020 00:26:58 -0400
X-MC-Unique: pfS6R0ToMe-6Lzie4A7WAg-1
Received: by mail-wr1-f72.google.com with SMTP id d6so516117wrn.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 21:26:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=eElz0rYHeKUNjkzhwC6MFQcNn/IDvjC4Rb+mBNhdY5E=;
 b=ailvlG6rWIcFxa6m/ZiZY8/LvY2icEuJ/nBVV/DBOCzyX+IGrfuWI4V/UoaiU6h6pG
 lUoYrlcXUGuyP6Prv7TCJZgvUnDDhL3W4hGrE60nxZ2VLhqpuFJe8dduXCPccihj5nHw
 hTsd4DeXpjZ8FS/N00vSFypASNgRkF1mvqa6myzwPulgnM2esl/WS+cDjPSvdVAH/QKK
 KHCjs6ns5WRxhGRU4dyls3xSZbxVPNpQH5AOkr6WEz4zLMNST59K1IWmCFgQ0A8NQHn1
 6ckfXSV8e24D5/W9wb4cZNPq2mYd5o0gOZLFDoLUc5T13vcapqL8nKHtaiv4w4pLLbPD
 AKTA==
X-Gm-Message-State: AOAM532mNSLGtCLkjx1wfPZ+U8EUZT1oUCIfdJb690jMRIqr47ftsgVb
 xZC5X/a4Jxvms4WKuY9ZGAdWt9bXcq1So4sEdGFKXFKwbv3vGGlvKpQqO5WzqAymZ842CVFLfM0
 NSqsE8Tr17q6qgEk=
X-Received: by 2002:a7b:c0c8:: with SMTP id s8mr1217464wmh.134.1591763216881; 
 Tue, 09 Jun 2020 21:26:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyWF5VtKszEZibyhigUlBQmm1BdoCcAB2175i4AWIE5t23KWCA7rbZfUoxkRHf9m0j8z2F6kg==
X-Received: by 2002:a7b:c0c8:: with SMTP id s8mr1217446wmh.134.1591763216650; 
 Tue, 09 Jun 2020 21:26:56 -0700 (PDT)
Received: from redhat.com (bzq-79-181-55-232.red.bezeqint.net. [79.181.55.232])
 by smtp.gmail.com with ESMTPSA id y5sm6510379wrs.63.2020.06.09.21.26.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 21:26:56 -0700 (PDT)
Date: Wed, 10 Jun 2020 00:26:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 10/56] acpi: parallel: don't use _STA method
Message-ID: <20200610042613.1459309-11-mst@redhat.com>
References: <20200610042613.1459309-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200610042613.1459309-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 23:51:15
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
 Eduardo Habkost <ehabkost@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Gerd Hoffmann <kraxel@redhat.com>

The _STA method dates back to the days where we had a static DSDT.  The
device is listed in the DSDT table unconditionally and the _STA method
checks a bit in the isa bridge pci config space to figure whenever a
given is isa device is present or not, then evaluates to 0x0f (present)
or 0x00 (absent).

These days the DSDT is generated by qemu anyway, so if a device is not
present we can simply drop it from the DSDT instead.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20200515150421.25479-7-kraxel@redhat.com>
---
 hw/i386/acpi-build.c | 29 ++++++++---------------------
 1 file changed, 8 insertions(+), 21 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 6de25f6484..2cafad03e2 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1173,39 +1173,26 @@ static Aml *build_mouse_device_aml(void)
     return dev;
 }
 
-static Aml *build_lpt_device_aml(void)
+static void build_lpt_device_aml(Aml *scope)
 {
     Aml *dev;
     Aml *crs;
-    Aml *method;
-    Aml *if_ctx;
-    Aml *else_ctx;
-    Aml *zero = aml_int(0);
-    Aml *is_present = aml_local(0);
+
+    if (!memory_region_present(get_system_io(), 0x0378)) {
+        return;
+    }
 
     dev = aml_device("LPT");
     aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0400")));
 
-    method = aml_method("_STA", 0, AML_NOTSERIALIZED);
-    aml_append(method, aml_store(aml_name("LPEN"), is_present));
-    if_ctx = aml_if(aml_equal(is_present, zero));
-    {
-        aml_append(if_ctx, aml_return(aml_int(0x00)));
-    }
-    aml_append(method, if_ctx);
-    else_ctx = aml_else();
-    {
-        aml_append(else_ctx, aml_return(aml_int(0x0f)));
-    }
-    aml_append(method, else_ctx);
-    aml_append(dev, method);
+    aml_append(dev, aml_name_decl("_STA", aml_int(0xf)));
 
     crs = aml_resource_template();
     aml_append(crs, aml_io(AML_DECODE16, 0x0378, 0x0378, 0x08, 0x08));
     aml_append(crs, aml_irq_no_flags(7));
     aml_append(dev, aml_name_decl("_CRS", crs));
 
-    return dev;
+    aml_append(scope, dev);
 }
 
 static void build_isa_devices_aml(Aml *table)
@@ -1221,7 +1208,7 @@ static void build_isa_devices_aml(Aml *table)
     if (fdc) {
         aml_append(scope, build_fdc_device_aml(fdc));
     }
-    aml_append(scope, build_lpt_device_aml());
+    build_lpt_device_aml(scope);
 
     if (ambiguous) {
         error_report("Multiple ISA busses, unable to define IPMI ACPI data");
-- 
MST


