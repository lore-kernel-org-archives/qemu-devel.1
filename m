Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C69C83000
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 14:07:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2F072083B
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 14:07:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hicx1F6i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2F072083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTnNF-0004to-Ry
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 10:07:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42526)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jTnGo-0002Ne-DE
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 10:01:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jTnGI-00042f-Tr
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 10:01:02 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:26144
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jTnGI-00041u-Bu
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 10:00:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588168829;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pZi0V42eFndZ+YKjEr8yBEyH88fyEYZmQ6EWCr9VMEY=;
 b=hicx1F6ioxAFYeL3vQ3BZVAZ6DfM/AkHa8AeB4oegOYopO6ZCEtrzEXsvH7TXKg43r2cuc
 hb1mEeyGOP2Erqw474SavpReHRJm2UIwmszrLwbtUTD+e+qUw+iUXGMws5U1NqPdbwqmoz
 u/MP99RhvjSNF1sQ5gUJayP//ixfhlU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-497-KzHl4OzKPZmEMmd-BcLjRg-1; Wed, 29 Apr 2020 10:00:27 -0400
X-MC-Unique: KzHl4OzKPZmEMmd-BcLjRg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8C953100A630;
 Wed, 29 Apr 2020 14:00:26 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-193.ams2.redhat.com
 [10.36.113.193])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 22DF75D77B;
 Wed, 29 Apr 2020 14:00:17 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 80CA29DA4; Wed, 29 Apr 2020 16:00:03 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 10/15] acpi: parallel: don't use _STA method
Date: Wed, 29 Apr 2020 15:59:58 +0200
Message-Id: <20200429140003.7336-11-kraxel@redhat.com>
In-Reply-To: <20200429140003.7336-1-kraxel@redhat.com>
References: <20200429140003.7336-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 01:28:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.81
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

The _STA method dates back to the days where we had a static DSDT.  The
device is listed in the DSDT table unconditionally and the _STA method
checks a bit in the isa bridge pci config space to figure whenever a
given is isa device is present or not, then evaluates to 0x0f (present)
or 0x00 (absent).

These days the DSDT is generated by qemu anyway, so if a device is not
present we can simply drop it from the DSDT instead.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/i386/acpi-build.c | 29 ++++++++---------------------
 1 file changed, 8 insertions(+), 21 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index fea83352e6ab..e01afbd011d9 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1167,39 +1167,26 @@ static Aml *build_mouse_device_aml(void)
     return dev;
 }
=20
-static Aml *build_lpt_device_aml(void)
+static void build_lpt_device_aml(Aml *scope)
 {
     Aml *dev;
     Aml *crs;
-    Aml *method;
-    Aml *if_ctx;
-    Aml *else_ctx;
-    Aml *zero =3D aml_int(0);
-    Aml *is_present =3D aml_local(0);
+
+    if (!memory_region_present(get_system_io(), 0x0378)) {
+        return;
+    }
=20
     dev =3D aml_device("LPT");
     aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0400")));
=20
-    method =3D aml_method("_STA", 0, AML_NOTSERIALIZED);
-    aml_append(method, aml_store(aml_name("LPEN"), is_present));
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
     aml_append(crs, aml_io(AML_DECODE16, 0x0378, 0x0378, 0x08, 0x08));
     aml_append(crs, aml_irq_no_flags(7));
     aml_append(dev, aml_name_decl("_CRS", crs));
=20
-    return dev;
+    aml_append(scope, dev);
 }
=20
 static void build_isa_devices_aml(Aml *table)
@@ -1215,7 +1202,7 @@ static void build_isa_devices_aml(Aml *table)
     if (fdc) {
         aml_append(scope, build_fdc_device_aml(fdc));
     }
-    aml_append(scope, build_lpt_device_aml());
+    build_lpt_device_aml(scope);
=20
     if (ambiguous) {
         error_report("Multiple ISA busses, unable to define IPMI ACPI data=
");
--=20
2.18.2


