Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 022ADC83006
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 14:02:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3C2E2083B
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 14:02:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QxU+oFKw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3C2E2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTnIO-0004KN-Ia
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 10:02:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42378)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jTnGW-0002E4-Dy
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 10:01:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jTnGA-0003qb-1v
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 10:00:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44001
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jTnG9-0003oy-JO
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 10:00:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588168820;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aC0zQw/NnoGL/JhiojHL3INj+DHgvZROMxh43h66evM=;
 b=QxU+oFKwa0QEo2kaU+K8uxTilQBrSPPCnrptYi3cplIZ2e/PLP/L+WOit7Z/nb1XmkNXhs
 iCtO1mE/tJ/4OB7VTmyLHJWxgx+rbY0b3NTU3R4QEmO7lXh3nyMzUlpKtv4/TFllna73cO
 lOcItRMY477tFkqH5f75ho/TwUDGf2g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-322-zyXDUhxnN42CTqXnmmSrBQ-1; Wed, 29 Apr 2020 10:00:17 -0400
X-MC-Unique: zyXDUhxnN42CTqXnmmSrBQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3DEBE468;
 Wed, 29 Apr 2020 14:00:16 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-193.ams2.redhat.com
 [10.36.113.193])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 25E565C1BE;
 Wed, 29 Apr 2020 14:00:04 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 43E779D9D; Wed, 29 Apr 2020 16:00:03 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 04/15] acpi: drop pointless _STA method
Date: Wed, 29 Apr 2020 15:59:52 +0200
Message-Id: <20200429140003.7336-5-kraxel@redhat.com>
In-Reply-To: <20200429140003.7336-1-kraxel@redhat.com>
References: <20200429140003.7336-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 01:42:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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

When returning a constant there is no point in having a method
in the first place, _STA can be a simple integer instead.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/i386/acpi-build.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 23c77eeb95a9..3a046b03e4cd 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1151,14 +1151,11 @@ static Aml *build_kbd_device_aml(void)
 {
     Aml *dev;
     Aml *crs;
-    Aml *method;
=20
     dev =3D aml_device("KBD");
     aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0303")));
=20
-    method =3D aml_method("_STA", 0, AML_NOTSERIALIZED);
-    aml_append(method, aml_return(aml_int(0x0f)));
-    aml_append(dev, method);
+    aml_append(dev, aml_name_decl("_STA", aml_int(0xf)));
=20
     crs =3D aml_resource_template();
     aml_append(crs, aml_io(AML_DECODE16, 0x0060, 0x0060, 0x01, 0x01));
@@ -1173,14 +1170,11 @@ static Aml *build_mouse_device_aml(void)
 {
     Aml *dev;
     Aml *crs;
-    Aml *method;
=20
     dev =3D aml_device("MOU");
     aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0F13")));
=20
-    method =3D aml_method("_STA", 0, AML_NOTSERIALIZED);
-    aml_append(method, aml_return(aml_int(0x0f)));
-    aml_append(dev, method);
+    aml_append(dev, aml_name_decl("_STA", aml_int(0xf)));
=20
     crs =3D aml_resource_template();
     aml_append(crs, aml_irq_no_flags(12));
@@ -2238,9 +2232,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
                                            TPM_CRB_ADDR_SIZE, AML_READ_WRI=
TE));
         aml_append(dev, aml_name_decl("_CRS", crs));
=20
-        method =3D aml_method("_STA", 0, AML_NOTSERIALIZED);
-        aml_append(method, aml_return(aml_int(0x0f)));
-        aml_append(dev, method);
+        aml_append(dev, aml_name_decl("_STA", aml_int(0xf)));
=20
         tpm_build_ppi_acpi(tpm, dev);
=20
--=20
2.18.2


