Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D3EC4332B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 08:04:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C25022072C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 08:04:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KktBBEvN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C25022072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEqAd-0006aL-S3
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 04:04:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39759)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jEq7e-0001kV-BL
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 04:01:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1jEq7Y-0005Xk-Rc
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 04:01:42 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:38905)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1jEq7Y-0005Ug-Mf
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 04:01:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584604900;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OFA+B2NRdiftPIIZGM8KNaGgqaNO6iGHD6YJngzvo54=;
 b=KktBBEvNG+P6XYmCzZFu6OtpIDp/E8z1NzVVXo+APYyAt9EBbJAUtvoTLKLuis7JyGFiS/
 IlVTjNHUGTUgV2MUsFScTCgW2A1BK5Da11Gsj7QWSQIooy7l+FZ1sitMMcgxzZMoOVB7XJ
 9wsrJfWN1UIeRapHMbR9Vi3YcdeAfsk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-126-ZebcUN-8PfSkJJch1HQUJA-1; Thu, 19 Mar 2020 04:01:38 -0400
X-MC-Unique: ZebcUN-8PfSkJJch1HQUJA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2E4CD107ACC9;
 Thu, 19 Mar 2020 08:01:37 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-49.ams2.redhat.com
 [10.36.112.49])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EF81160BF1;
 Thu, 19 Mar 2020 08:01:28 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 1A23F3EC09; Thu, 19 Mar 2020 09:01:18 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 11/13] microvm/acpi: add serial
Date: Thu, 19 Mar 2020 09:01:15 +0100
Message-Id: <20200319080117.7725-12-kraxel@redhat.com>
In-Reply-To: <20200319080117.7725-1-kraxel@redhat.com>
References: <20200319080117.7725-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/i386/acpi-build.c | 36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 928e0ee2deeb..b765c31c80b0 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1226,7 +1226,7 @@ static Aml *build_lpt_device_aml(void)
     return dev;
 }
=20
-static Aml *build_com_device_aml(uint8_t uid)
+static Aml *build_com_device_aml(uint8_t uid, bool sta)
 {
     Aml *dev;
     Aml *crs;
@@ -1250,19 +1250,22 @@ static Aml *build_com_device_aml(uint8_t uid)
     aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0501")));
     aml_append(dev, aml_name_decl("_UID", aml_int(uid)));
=20
-    method =3D aml_method("_STA", 0, AML_NOTSERIALIZED);
-    aml_append(method, aml_store(aml_name("%s", enabled_field), is_present=
));
-    if_ctx =3D aml_if(aml_equal(is_present, zero));
-    {
-        aml_append(if_ctx, aml_return(aml_int(0x00)));
+    if (sta) {
+        method =3D aml_method("_STA", 0, AML_NOTSERIALIZED);
+        aml_append(method, aml_store(aml_name("%s", enabled_field),
+                                         is_present));
+        if_ctx =3D aml_if(aml_equal(is_present, zero));
+        {
+            aml_append(if_ctx, aml_return(aml_int(0x00)));
+        }
+        aml_append(method, if_ctx);
+        else_ctx =3D aml_else();
+        {
+            aml_append(else_ctx, aml_return(aml_int(0x0f)));
+        }
+        aml_append(method, else_ctx);
+        aml_append(dev, method);
     }
-    aml_append(method, if_ctx);
-    else_ctx =3D aml_else();
-    {
-        aml_append(else_ctx, aml_return(aml_int(0x0f)));
-    }
-    aml_append(method, else_ctx);
-    aml_append(dev, method);
=20
     crs =3D aml_resource_template();
     aml_append(crs, aml_io(AML_DECODE16, io_port, io_port, 0x00, 0x08));
@@ -1287,8 +1290,8 @@ static void build_isa_devices_aml(Aml *table)
         aml_append(scope, build_fdc_device_aml(fdc));
     }
     aml_append(scope, build_lpt_device_aml());
-    aml_append(scope, build_com_device_aml(1));
-    aml_append(scope, build_com_device_aml(2));
+    aml_append(scope, build_com_device_aml(1, true));
+    aml_append(scope, build_com_device_aml(2, true));
=20
     if (ambiguous) {
         error_report("Multiple ISA busses, unable to define IPMI ACPI data=
");
@@ -2818,6 +2821,9 @@ build_dsdt_microvm(GArray *table_data, BIOSLinker *li=
nker,
     if (mms->rtc_state) {
         aml_append(sb_scope, build_rtc_device_aml());
     }
+    if (mms->isa_serial) {
+        aml_append(sb_scope, build_com_device_aml(1, false));
+    }
     acpi_dsdt_add_fw_cfg(sb_scope, OBJECT(x86ms->fw_cfg));
     acpi_dsdt_add_virtio(sb_scope);
     aml_append(dsdt, sb_scope);
--=20
2.18.2


