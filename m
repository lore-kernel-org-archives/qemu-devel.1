Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92DBBC47257
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:35:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FD382075A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:35:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KZchg0Jh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FD382075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVcBb-0006EW-Bb
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 10:35:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47314)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jVc69-0004yo-P4
 for qemu-devel@nongnu.org; Mon, 04 May 2020 10:29:33 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:40208
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jVc68-0005vm-Uo
 for qemu-devel@nongnu.org; Mon, 04 May 2020 10:29:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588602572;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=itmu7tz+8YX6LWqNTTBDZfH0oyb1cw8xwtWy0pZ6Qys=;
 b=KZchg0Jhlbj8a9FDaKIqDNHIVH3e8HJVy2+scpU5NImg8TSbVQxRtzV6zFpXztKq3uQ+ZX
 w1bAcITDe3gegwsTmwZ1ZKOwAgZM0V0MJO8DSWwXkKTo/Hgb+V570NoyS33jhyitlCw5vi
 FyOdK0J9uQzRlYMh+bCqDXPfHBaIMQ8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-499-uRSSTouTPt-DQxzrKdADSw-1; Mon, 04 May 2020 10:29:30 -0400
X-MC-Unique: uRSSTouTPt-DQxzrKdADSw-1
Received: by mail-wr1-f72.google.com with SMTP id 30so363885wrp.22
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 07:29:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=V7k4n5KKJ25ykZvHnBkd3lhwrbgQ3O6cOV8Obfh+XCs=;
 b=Y9jT9BtpIDAihRfXO/7AoS2HAGGr0HQ1AL+c+vWobA5dJe0fbV/VvkUDxVPbWrk15Z
 uxY5nEC0DijTiwJXW7z9Jvh5j4dVy5zeKJDQ0x9kXDYIgLGtOO3E37JQFf4avNBhKJli
 aq5XnO6d2gvQl7SghSKS1zP5zoAHbLRQcQTbtn0bVejpnCHxrYnVdmSt305yVMw4WboF
 cZ7JhoWNKPgYpM4QaewTkLDxp6qMBO9066AZA5uIMsmO/2PNAvwSOp9kyNoxZ6xXyovf
 nsKZ09by0/qmwJyXdYiBIoaJtbrEOz2drkqJd7yh8nEnMZlitO75ArOVx4RY+1YVKVa2
 89AQ==
X-Gm-Message-State: AGi0PuatawD+U0dFTRplY6S5lpsMBUsQfP2gvnl5Bsu1NmzU5ymKRk9S
 F9wAFroRnLsVmQh8zPB3whAUPSD6VGj6Z3zeMNPQAaMO74I2EI2HMB7hfOCIMStajgtVWrKzgpx
 cQU37vpBO0XgogTU=
X-Received: by 2002:a05:6000:11cb:: with SMTP id
 i11mr20093171wrx.339.1588602569205; 
 Mon, 04 May 2020 07:29:29 -0700 (PDT)
X-Google-Smtp-Source: APiQypImRRhiJVXe5c1VsKIMZFSVCbA1G6yPSA5w8T2/B+qd3JL+2VKLXyHyCiRybUN/HXD1FE0EYw==
X-Received: by 2002:a05:6000:11cb:: with SMTP id
 i11mr20093155wrx.339.1588602569000; 
 Mon, 04 May 2020 07:29:29 -0700 (PDT)
Received: from redhat.com (bzq-109-66-7-121.red.bezeqint.net. [109.66.7.121])
 by smtp.gmail.com with ESMTPSA id
 w83sm14504279wmb.37.2020.05.04.07.29.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 07:29:28 -0700 (PDT)
Date: Mon, 4 May 2020 10:29:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 06/29] acpi: drop pointless _STA method
Message-ID: <20200504142814.157589-7-mst@redhat.com>
References: <20200504142814.157589-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200504142814.157589-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 08:14:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Gerd Hoffmann <kraxel@redhat.com>

When returning a constant there is no point in having a method
in the first place, _STA can be a simple integer instead.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20200429140003.7336-5-kraxel@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/i386/acpi-build.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 23c77eeb95..3a046b03e4 100644
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
MST


