Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2567C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 08:07:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC755206F8
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 08:07:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H15/WJjG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC755206F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKHMQ-0005Cy-Ts
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 04:07:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42269)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jKHKJ-0000yX-C4
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 04:05:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1jKHKH-0007jZ-NR
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 04:05:18 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:23668
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1jKHKH-0007f0-J7
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 04:05:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585901114;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tDvYI9qnFYs+oXzmsMFgzI0u/pj5+Ditow3Dy4Jt+20=;
 b=H15/WJjG5r/9wIrtTryvNkka2Ogdmdp7PJ3UIAZe61tML/Aez6qNh9uXOqt0DvEVpfFisG
 7G/MuAJ9Cd5BC+GA2FDH0wF5IUvBGcTZt8swQOJREUCPTScUBUFLWLlBfif6E5wI+pank3
 U1wxksJDgwOL1nGYILnV4Z/wrXSk66Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-5cZRIKHYNvuemUYwUN030w-1; Fri, 03 Apr 2020 04:05:13 -0400
X-MC-Unique: 5cZRIKHYNvuemUYwUN030w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0D98C1005509;
 Fri,  3 Apr 2020 08:05:12 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-60.ams2.redhat.com
 [10.36.113.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F080060BF3;
 Fri,  3 Apr 2020 08:05:03 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 002561750A; Fri,  3 Apr 2020 10:05:02 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 03/12] acpi: drop pointless _STA method
Date: Fri,  3 Apr 2020 10:04:53 +0200
Message-Id: <20200403080502.8154-4-kraxel@redhat.com>
In-Reply-To: <20200403080502.8154-1-kraxel@redhat.com>
References: <20200403080502.8154-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, John Snow <jsnow@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When returning a constant there is no point in having a method
in the first place, _STA can be a simple integer instead.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/i386/acpi-build.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 9a19c14e661b..214b98671bf2 100644
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


