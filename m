Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD2CC43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 12:12:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27BB22074F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 12:12:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HPSbAx+O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27BB22074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHnqe-0006ot-C7
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 08:12:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35229)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jHnpb-0005HN-6Z
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 08:11:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1jHnpZ-0002AY-MM
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 08:11:22 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:24066)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1jHnpZ-00029B-Ie
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 08:11:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585311081;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zKFU+QLhKKKhlgw/DTPXPv/7+TQNF+2jYPAaGnR8B5o=;
 b=HPSbAx+OEJMm9+aT1Yh7zITT0b3QVfryWnJjO66O8KOZ7IeXlByYuYWEuJFsiPX4oMUuiR
 cNLmhnmrr+JkzF/ZHx3M743LPc2UU4ndQg0xVbnHbcUm++AFurIy4LMrPiriaBPj3s3bns
 9+30uFoCqC33gYj41rFgP31EppTV8h8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-ToRXe8pgON2fyaw7FGUjDQ-1; Fri, 27 Mar 2020 08:11:19 -0400
X-MC-Unique: ToRXe8pgON2fyaw7FGUjDQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1AFD9100550E;
 Fri, 27 Mar 2020 12:11:18 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-49.ams2.redhat.com
 [10.36.112.49])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D01707E311;
 Fri, 27 Mar 2020 12:11:12 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id E2EFB31E3F; Fri, 27 Mar 2020 13:11:11 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/6] acpi: drop pointless _STA method
Date: Fri, 27 Mar 2020 13:11:09 +0100
Message-Id: <20200327121111.1530-5-kraxel@redhat.com>
In-Reply-To: <20200327121111.1530-1-kraxel@redhat.com>
References: <20200327121111.1530-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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

When returning a constant there is no point in having a method
in the first place, _STA can be a simple integer instead.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/i386/acpi-build-pc.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/hw/i386/acpi-build-pc.c b/hw/i386/acpi-build-pc.c
index 3fdae2984b91..18ca2fd46961 100644
--- a/hw/i386/acpi-build-pc.c
+++ b/hw/i386/acpi-build-pc.c
@@ -1137,14 +1137,11 @@ static Aml *build_kbd_device_aml(void)
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
@@ -1159,14 +1156,11 @@ static Aml *build_mouse_device_aml(void)
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
@@ -2229,9 +2223,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
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


