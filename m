Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55F23C47254
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 11:43:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23F9E2073B
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 11:43:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XXdXmdkh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23F9E2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVvyv-0004P2-By
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 07:43:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48056)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jVvun-0005mU-6v
 for qemu-devel@nongnu.org; Tue, 05 May 2020 07:39:09 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:20432
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jVvum-00030y-FJ
 for qemu-devel@nongnu.org; Tue, 05 May 2020 07:39:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588678747;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OGI5s3kYy/mF7B9qjxqtCbPw1ZJ+CbiccvjcfHlVfAU=;
 b=XXdXmdkhRq9+2codoXSRYBslqpihyowV4ddvZUJXpyYEoL86rjncsqUw/OQeBKOJOu6m1r
 Qf8IMrAVB36ELlOq7x5zBjlQX/4ElYDD6J6J5xUWe0yW+M37GOjkxlrhZqdE6MD3isJirz
 TrxyW4ORiEZ7vdot5hMBMj9gg4D0Sts=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436-pqMfMeYXOBSpexu1WmhZxA-1; Tue, 05 May 2020 07:39:04 -0400
X-MC-Unique: pqMfMeYXOBSpexu1WmhZxA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2EB59835B43;
 Tue,  5 May 2020 11:39:03 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-193.ams2.redhat.com
 [10.36.113.193])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EEDDF5D9D5;
 Tue,  5 May 2020 11:38:45 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id BEA951753B; Tue,  5 May 2020 13:38:43 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 04/13] acpi: serial: don't use _STA method
Date: Tue,  5 May 2020 13:38:34 +0200
Message-Id: <20200505113843.22012-5-kraxel@redhat.com>
In-Reply-To: <20200505113843.22012-1-kraxel@redhat.com>
References: <20200505113843.22012-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 00:37:40
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
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, John Snow <jsnow@redhat.com>,
 Richard Henderson <rth@twiddle.net>
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
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/i386/acpi-build.c | 32 ++++++++------------------------
 1 file changed, 8 insertions(+), 24 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 0bfa2dd23fcc..3a82730a0d19 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1208,50 +1208,34 @@ static Aml *build_lpt_device_aml(void)
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
@@ -1268,8 +1252,8 @@ static void build_isa_devices_aml(Aml *table)
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
2.18.4


