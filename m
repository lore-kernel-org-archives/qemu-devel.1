Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A99EC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 04:33:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E64982074B
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 04:33:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZXYOmCvR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E64982074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jisQN-0006yL-3N
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 00:33:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33980)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jisKH-00071a-7L
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 00:26:57 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:23198
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jisKG-0008DR-AT
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 00:26:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591763215;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3luZdMVyzlQigwCf25ntlxiRwHdihmch0JzTpvPMHt4=;
 b=ZXYOmCvRBeRu6vc/n/tLOInR/RzagODQtsC9aDurfd+rUnWO8SvDzD+OxemQAZM/8Q5WhT
 FpMDdhmNJywajW5OPLvWTfOJTVNxJ0tkwI7fn/ql7rsthohPC24mavEyjYFMvpFZmbVE2v
 VjBEypVsy4AYJtG8yRdyARF11jXhjhY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-iWu3FQhEMSqqoJjSwA2UKg-1; Wed, 10 Jun 2020 00:26:53 -0400
X-MC-Unique: iWu3FQhEMSqqoJjSwA2UKg-1
Received: by mail-wr1-f69.google.com with SMTP id h6so515006wrx.4
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 21:26:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=3luZdMVyzlQigwCf25ntlxiRwHdihmch0JzTpvPMHt4=;
 b=eI76aOz+tjgwQ9c5VR6mxKwpIsw/QWwlikZ+BCX/NljTQs1elkPkih6/uDBBN23eVi
 44+J3WUZIRTYMPrW09RmAvA+58a4Mkpp9jF9lLI4HGSzacsiyvyHyF2J9V8dawo9VD3u
 euwCcs/00+e9BUDc7EA7Uk26qFMwrGuCeI7jlxy9B2mtwZraSSV1CCR40urviBJRAqnF
 5bQ7eGjqohXhnjkl1wGKtej1PTMLQdT1/5IHFuZAnJTSs5kvenqYStBG/+YoTY9xpF2i
 i4Gi40JxJ/gSQ/qu4qRtIvmjXOEb31P8jXdScy2kc3o4olDkedAnGnBE/l8B9OVKXXja
 jVxA==
X-Gm-Message-State: AOAM5301j9BiuoA0nxjXa5ZYBiRE19hEGFVEH6njbSQHf8Uf0wO5XaBW
 VLUMeERgbhNXuFAZd0G+ApMMQBzdnN0bpmGu3EXJrMhQylo9Z3523DufEUWxBqQ8aFXCxSyni+E
 3aswuPvM0+RPMWkY=
X-Received: by 2002:adf:f003:: with SMTP id j3mr1327099wro.228.1591763212156; 
 Tue, 09 Jun 2020 21:26:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwxsPDHmJOAXK5hSJW7appCrMI9PEEGuVBYMhhk5Qi7hF5yjOn0619kcoD+OCaYqd+lvxaWJQ==
X-Received: by 2002:adf:f003:: with SMTP id j3mr1327084wro.228.1591763211990; 
 Tue, 09 Jun 2020 21:26:51 -0700 (PDT)
Received: from redhat.com (bzq-79-181-55-232.red.bezeqint.net. [79.181.55.232])
 by smtp.gmail.com with ESMTPSA id p1sm5965317wrx.44.2020.06.09.21.26.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 21:26:51 -0700 (PDT)
Date: Wed, 10 Jun 2020 00:26:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 08/56] acpi: serial: don't use _STA method
Message-ID: <20200610042613.1459309-9-mst@redhat.com>
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
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200515150421.25479-5-kraxel@redhat.com>
---
 hw/i386/acpi-build.c | 32 ++++++++------------------------
 1 file changed, 8 insertions(+), 24 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index df5417c75f..cb22cb0fe6 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1208,50 +1208,34 @@ static Aml *build_lpt_device_aml(void)
     return dev;
 }
 
-static Aml *build_com_device_aml(uint8_t uid)
+static void build_com_device_aml(Aml *scope, uint8_t uid)
 {
     Aml *dev;
     Aml *crs;
-    Aml *method;
-    Aml *if_ctx;
-    Aml *else_ctx;
-    Aml *zero = aml_int(0);
-    Aml *is_present = aml_local(0);
-    const char *enabled_field = "CAEN";
     uint8_t irq = 4;
     uint16_t io_port = 0x03F8;
 
     assert(uid == 1 || uid == 2);
     if (uid == 2) {
-        enabled_field = "CBEN";
         irq = 3;
         io_port = 0x02F8;
     }
+    if (!memory_region_present(get_system_io(), io_port)) {
+        return;
+    }
 
     dev = aml_device("COM%d", uid);
     aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0501")));
     aml_append(dev, aml_name_decl("_UID", aml_int(uid)));
 
-    method = aml_method("_STA", 0, AML_NOTSERIALIZED);
-    aml_append(method, aml_store(aml_name("%s", enabled_field), is_present));
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
     aml_append(crs, aml_io(AML_DECODE16, io_port, io_port, 0x00, 0x08));
     aml_append(crs, aml_irq_no_flags(irq));
     aml_append(dev, aml_name_decl("_CRS", crs));
 
-    return dev;
+    aml_append(scope, dev);
 }
 
 static void build_isa_devices_aml(Aml *table)
@@ -1268,8 +1252,8 @@ static void build_isa_devices_aml(Aml *table)
         aml_append(scope, build_fdc_device_aml(fdc));
     }
     aml_append(scope, build_lpt_device_aml());
-    aml_append(scope, build_com_device_aml(1));
-    aml_append(scope, build_com_device_aml(2));
+    build_com_device_aml(scope, 1);
+    build_com_device_aml(scope, 2);
 
     if (ambiguous) {
         error_report("Multiple ISA busses, unable to define IPMI ACPI data");
-- 
MST


