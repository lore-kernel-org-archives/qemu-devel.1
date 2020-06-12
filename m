Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0319CC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 14:56:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2E5A20691
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 14:56:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RT3V9VC9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2E5A20691
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjl6a-0006Z8-Uy
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 10:56:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49694)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jjl1n-0005hJ-2R
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 10:51:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29730
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jjl1l-0001O2-CE
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 10:51:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591973488;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eElz0rYHeKUNjkzhwC6MFQcNn/IDvjC4Rb+mBNhdY5E=;
 b=RT3V9VC9o+Vsf98pqeXklh4zw1xFMXrSxXGyvacytp2ZD4euS8Nz7+k5zZIPt3anEce34Y
 X+V1yLahQuinOS2sWnlTtFhgYJWq6Iev8KwUpJ9ibTiVILXJD2b/CO4J3PQtnoc9QybK9K
 9C/YlnUiPPq2yUx2Krc0GdbqJJzEPho=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-487--Zh3xB-UP0myQ8nuMJHo3g-1; Fri, 12 Jun 2020 10:51:26 -0400
X-MC-Unique: -Zh3xB-UP0myQ8nuMJHo3g-1
Received: by mail-wm1-f70.google.com with SMTP id p24so2034505wma.4
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2020 07:51:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=eElz0rYHeKUNjkzhwC6MFQcNn/IDvjC4Rb+mBNhdY5E=;
 b=ZfzWY1yLbklLPtIeQlA/0Tov2Btl3XhPVPvqXtkQpMu3/oRB0fpPTR0beQianxLgEu
 wZ94s5FPmN5YHaOZQYUrjX1EUhQ+uoRAXahzfmgLstUg0P7H9NdV/S/8qj5FnTHJOpl6
 HweIFyLHYoevCj9hHUyE16uJ6Gw/2tmswJNQch8VwOEyHNbp56+OxRAhUNXgRKPQS3nZ
 l+WcHmy94J8j1TIbE1QfUKly3XEym6i1qj0trQa3Za+2MNWEk0Acs+HimQBcBWRwB+DF
 o9gpv2IdlwuzLyMiiWOY3BXs4Qzi9Ku64PPzlNDHZ9m6St++xew7fLPcsVdLTXfJqDmb
 x4hg==
X-Gm-Message-State: AOAM530WedUJoKr9FfRbbiT6cV6A2jFzjpeLItxPEX0qRwX0kZtA419F
 v3yXXX5vPN+NMLa6nxLHDTNKReeVowPjI2fU2kKbgIwiCnDQA1fDVvN/f5h28gUneKxU8qxubcn
 TvdzcYKYZvnCygU8=
X-Received: by 2002:adf:a18b:: with SMTP id u11mr15250682wru.102.1591973485467; 
 Fri, 12 Jun 2020 07:51:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxlegNpe6tsxrdR/sdAWfEXbFwlkS2Pz4v7NRMTJq4RF5jPAhrC7VNd/2w46+/o/xO8jkai3A==
X-Received: by 2002:adf:a18b:: with SMTP id u11mr15250657wru.102.1591973485236; 
 Fri, 12 Jun 2020 07:51:25 -0700 (PDT)
Received: from redhat.com (bzq-79-178-18-124.red.bezeqint.net. [79.178.18.124])
 by smtp.gmail.com with ESMTPSA id 88sm11327904wre.45.2020.06.12.07.51.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2020 07:51:24 -0700 (PDT)
Date: Fri, 12 Jun 2020 10:51:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 10/58] acpi: parallel: don't use _STA method
Message-ID: <20200612141917.9446-11-mst@redhat.com>
References: <20200612141917.9446-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200612141917.9446-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/12 08:07:26
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


