Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 883E0C43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 12:12:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55A8B20774
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 12:12:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z0bwGD+M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55A8B20774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHnqh-0006vJ-Gj
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 08:12:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35286)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jHnpc-0005Hd-NV
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 08:11:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1jHnpb-0002Ej-Dc
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 08:11:24 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:56540)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1jHnpb-0002Cl-AE
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 08:11:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585311082;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iecBE+0B1PGZoq65FTFsNM1AMbDLLSz4/8wfLx6LjOs=;
 b=Z0bwGD+M4DOsbX8kQgRrTjg06qiB/kdmuy89gwoSQtkm1uzu2xh8NVixJZxGgy9hXwOEyO
 oGuc1ljo4I4MHToXtfYvnvN5IrwpHZw6eG4pwxHRKKIrUJgmWOgBTEqEejRBYqXtTgZj3r
 ZK+rVVO+Jf2zXS34+ff6xsR7h2MC8c4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-80-qIOTUP2fPRqVXEHceBeNQw-1; Fri, 27 Mar 2020 08:11:20 -0400
X-MC-Unique: qIOTUP2fPRqVXEHceBeNQw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BC3C1DBAB;
 Fri, 27 Mar 2020 12:11:19 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-49.ams2.redhat.com
 [10.36.112.49])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 492395E01D;
 Fri, 27 Mar 2020 12:11:19 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id EBA5B31E47; Fri, 27 Mar 2020 13:11:11 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 5/6] acpi: serial: don't use _STA method
Date: Fri, 27 Mar 2020 13:11:10 +0100
Message-Id: <20200327121111.1530-6-kraxel@redhat.com>
In-Reply-To: <20200327121111.1530-1-kraxel@redhat.com>
References: <20200327121111.1530-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The _STA method dates back to the days where we had a static DSDT.  The
device is listed in the DSDT table unconditionally and the _STA method
checks a bit in the isa bridge pci config space to figure whenever a
given is isa device is present or not, then evaluates to 0x0f (present)
or 0x00 (absent).

These days the DSDT is generated by qemu anyway, so if a device is not
present we can simply drop it from the DSDT instead.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/i386/acpi-build-pc.c | 32 ++++++++------------------------
 1 file changed, 8 insertions(+), 24 deletions(-)

diff --git a/hw/i386/acpi-build-pc.c b/hw/i386/acpi-build-pc.c
index 18ca2fd46961..97af5eac3d79 100644
--- a/hw/i386/acpi-build-pc.c
+++ b/hw/i386/acpi-build-pc.c
@@ -1204,50 +1204,34 @@ static Aml *build_lpt_device_aml(void)
     return dev;
 }
=20
-static Aml *build_com_device_aml(uint8_t uid)
+static void build_com_device_aml(Aml *scope, uint8_t uid)
 {
     Aml *dev;
     Aml *crs;
-    Aml *method;
-    Aml *if_ctx;
-    Aml *else_ctx;
-    Aml *zero =3D aml_int(0);
-    Aml *is_present =3D aml_local(0);
-    const char *enabled_field =3D "CAEN";
     uint8_t irq =3D 4;
     uint16_t io_port =3D 0x03F8;
=20
     assert(uid =3D=3D 1 || uid =3D=3D 2);
     if (uid =3D=3D 2) {
-        enabled_field =3D "CBEN";
         irq =3D 3;
         io_port =3D 0x02F8;
     }
+    if (!memory_region_present(get_system_io(), io_port)) {
+        return;
+    }
=20
     dev =3D aml_device("COM%d", uid);
     aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0501")));
     aml_append(dev, aml_name_decl("_UID", aml_int(uid)));
=20
-    method =3D aml_method("_STA", 0, AML_NOTSERIALIZED);
-    aml_append(method, aml_store(aml_name("%s", enabled_field), is_present=
));
-    if_ctx =3D aml_if(aml_equal(is_present, zero));
-    {
-        aml_append(if_ctx, aml_return(aml_int(0x00)));
-    }
-    aml_append(method, if_ctx);
-    else_ctx =3D aml_else();
-    {
-        aml_append(else_ctx, aml_return(aml_int(0x0f)));
-    }
-    aml_append(method, else_ctx);
-    aml_append(dev, method);
+    aml_append(dev, aml_name_decl("_STA", aml_int(0xf)));
=20
     crs =3D aml_resource_template();
     aml_append(crs, aml_io(AML_DECODE16, io_port, io_port, 0x00, 0x08));
     aml_append(crs, aml_irq_no_flags(irq));
     aml_append(dev, aml_name_decl("_CRS", crs));
=20
-    return dev;
+    aml_append(scope, dev);
 }
=20
 static void build_isa_devices_aml(Aml *table)
@@ -1265,8 +1249,8 @@ static void build_isa_devices_aml(Aml *table)
         aml_append(scope, build_fdc_device_aml(fdc));
     }
     aml_append(scope, build_lpt_device_aml());
-    aml_append(scope, build_com_device_aml(1));
-    aml_append(scope, build_com_device_aml(2));
+    build_com_device_aml(scope, 1);
+    build_com_device_aml(scope, 2);
=20
     if (ambiguous) {
         error_report("Multiple ISA busses, unable to define IPMI ACPI data=
");
--=20
2.18.2


