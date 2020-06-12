Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C3ADC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 14:54:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFB922067B
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 14:54:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JGl8VLRv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFB922067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjl4z-0003MA-31
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 10:54:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49634)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jjl1i-0005Vc-7d
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 10:51:26 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:36041
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jjl1g-0001NQ-Ea
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 10:51:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591973483;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3luZdMVyzlQigwCf25ntlxiRwHdihmch0JzTpvPMHt4=;
 b=JGl8VLRv7QXkYXr5xpub/QzDsgZy+YBF/gc/QZHL7b9fyXHAdfwp33mn+Xp5Gz/4/u6P4R
 4YnEo3jtFPS+Qqr0hi8NEcWWkM84QentJS2/uApxkEpwEJDczOsW+hH/Ds+/1x6xoQ8wL3
 5UZr10uQik0cd4QCpc5+Uak6vUh+2Fo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-HR-c2yN5NZOIurtpgBMqbQ-1; Fri, 12 Jun 2020 10:51:21 -0400
X-MC-Unique: HR-c2yN5NZOIurtpgBMqbQ-1
Received: by mail-wr1-f71.google.com with SMTP id l1so3984112wrc.8
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2020 07:51:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=3luZdMVyzlQigwCf25ntlxiRwHdihmch0JzTpvPMHt4=;
 b=s1HzD0g1AkkO+HZvqEmsoA17XqAa2jorAzH1NMOBuqlU9bVPY9cn2NSKXVDzAcsrPo
 mKRjrTGu3tpcg730v9SaZ/O+4Ou3XE++Ym55ysFae7LBNWAWu4DooFw50nlAH3CaBS0i
 2FlJWVmkAyDya7IcD57kNOsiQB1pCkIxHUPW9o4ti9Wh2zooVJsq0ooam3CghkAkQrdJ
 VXHkaMxRs9jp/rpHYVKauQXUACQME0lOJ1v/unN2Mihnx/tAa3IzVaNgj4qrgbwCEjFd
 iyN31qVCaXiJbV2iVs9zg1hu+CZor5TA/264O4WictrBWNgJz7bDHpFmxwlTlK+lN41a
 FGAA==
X-Gm-Message-State: AOAM533H3IMU+UyqTMvQwB6YySY4P06luAX1nIhZ1X+dpqwIeQ4VgsLh
 93yd0p3cUDnry+kj1unRiB5yi3MG+rGWwi7javRCP+LMRTId6FmXLJMfVEx6fGPp1+8liyrr3kJ
 S1iqIHhQmc1/H+IM=
X-Received: by 2002:a1c:9896:: with SMTP id a144mr13548287wme.75.1591973480541; 
 Fri, 12 Jun 2020 07:51:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwDToCNur4o9tcugHwWj9jToyFrRqE9wWkqek/dvAyQU2moUF2aO3prp+Yb6Q7iz5BawZAAqg==
X-Received: by 2002:a1c:9896:: with SMTP id a144mr13548277wme.75.1591973480358; 
 Fri, 12 Jun 2020 07:51:20 -0700 (PDT)
Received: from redhat.com (bzq-79-178-18-124.red.bezeqint.net. [79.178.18.124])
 by smtp.gmail.com with ESMTPSA id y80sm9200104wmc.34.2020.06.12.07.51.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2020 07:51:19 -0700 (PDT)
Date: Fri, 12 Jun 2020 10:51:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 08/58] acpi: serial: don't use _STA method
Message-ID: <20200612141917.9446-9-mst@redhat.com>
References: <20200612141917.9446-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200612141917.9446-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/12 09:30:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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


