Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D931CC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 23:14:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A45E5206F7
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 23:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A4lWc5Ly"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A45E5206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joEaz-0004uq-OS
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 19:14:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42230)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1joETs-0000Fq-VS
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 19:07:00 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:23435
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1joETr-0001T8-69
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 19:07:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593040018;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DkqmilDoYxlrdvOEadJHYOZPGQ72zPB+ueTswvkBgD4=;
 b=A4lWc5LygmNFDIm3DNYwvhn3CdYOi1ce4fLjTQ/c61LudZtKkOD6RG+XynqfVLuEMGVQAo
 4MT9mkbN8W1ELqST8OPzupa12/BrsFZK1ob6/UVrlh0jWyVy8dj4uQRcXu3rSAu9j7eKuL
 KKqjE5IXkaEHKqFNZfGvrQHAKk1pbBI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-288-sHUR8HAKOlWtqSNKEZDUNQ-1; Wed, 24 Jun 2020 19:06:56 -0400
X-MC-Unique: sHUR8HAKOlWtqSNKEZDUNQ-1
Received: by mail-wr1-f72.google.com with SMTP id w4so2809917wrm.5
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 16:06:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=DkqmilDoYxlrdvOEadJHYOZPGQ72zPB+ueTswvkBgD4=;
 b=FlBvqOTPbl5bxIitV+uzUQae0H2vq/NpJOQnpeL9ogNQbODZ5Ae5v/M/H0dxc+I4V6
 qfhXvW3r2FapTwblCMSKaPN9usFX7ZoVo5J1h7ZVNMDUsn+ZWRoqvRFvNbrJ6hh+wGX5
 k5fkAuk1JD4ec4Ow/NGqkvuM4yhPYFsmQqtT07C+ccCj5NnT2+ttTg0svO3Nk0NrFr5F
 P/8iCdYd/SQg86KE0v236PlMkmQoui4rX4JtTOVg/Hg6npwWGzwlwqr5/C/C2WsYpqb0
 jBz2ytSXSELVcTvbzNLvwmQVrS8MPsf+UPW/FKsCW/CORKTLLuQCjgZpKUUaXsHwUA5p
 /7zw==
X-Gm-Message-State: AOAM5336Gz5Jf+hKlAbG67wd21iIv2FaXmJvQ1MhlJZiqxu40PlT9p0k
 PnV8+PrJk/M4rWE7cRbZYChe1fmxUbYtbYVlln5PLeHPEAKh+pzj4hty46gYj0loBWblSLWY7Ah
 OLLgFNN8/LBxhCJs=
X-Received: by 2002:a7b:ce97:: with SMTP id q23mr99007wmj.89.1593040014852;
 Wed, 24 Jun 2020 16:06:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwp1NhzHTme6qLKxQGXsLqANtXaOH2ZjVwQ+zBuD8DhQAi79Stv3ibQjBzElJmCHQrT+ap3cQ==
X-Received: by 2002:a7b:ce97:: with SMTP id q23mr98988wmj.89.1593040014620;
 Wed, 24 Jun 2020 16:06:54 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 3sm4181906wmi.45.2020.06.24.16.06.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2020 16:06:54 -0700 (PDT)
Date: Wed, 24 Jun 2020 19:06:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 09/19] acpi: drop serial/parallel enable bits from dsdt
Message-ID: <20200624230609.703104-10-mst@redhat.com>
References: <20200624230609.703104-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200624230609.703104-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 00:34:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Gerd Hoffmann <kraxel@redhat.com>

The _STA methods for COM+LPT used to reference them,
but that isn't the case any more.

piix4 DSDT changes:

     Scope (_SB.PCI0)
     {
         Device (ISA)
         {
             Name (_ADR, 0x00010000)  // _ADR: Address
             OperationRegion (P40C, PCI_Config, 0x60, 0x04)
-            Field (^PX13.P13C, AnyAcc, NoLock, Preserve)
-            {
-                Offset (0x5F),
-                    ,   7,
-                LPEN,   1,
-                Offset (0x67),
-                    ,   3,
-                CAEN,   1,
-                    ,   3,
-                CBEN,   1
-            }
         }
     }

ich9 DSDT changes:

     Scope (_SB.PCI0)
     {
         Device (ISA)
         {
             Name (_ADR, 0x001F0000)  // _ADR: Address
             OperationRegion (PIRQ, PCI_Config, 0x60, 0x0C)
             OperationRegion (LPCD, PCI_Config, 0x80, 0x02)
             Field (LPCD, AnyAcc, NoLock, Preserve)
             {
                 COMA,   3,
                     ,   1,
                 COMB,   3,
                 Offset (0x01),
                 LPTD,   2
             }
-
-            OperationRegion (LPCE, PCI_Config, 0x82, 0x02)
-            Field (LPCE, AnyAcc, NoLock, Preserve)
-            {
-                CAEN,   1,
-                CBEN,   1,
-                LPEN,   1
-            }
         }
     }

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20200619091905.21676-10-kraxel@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/acpi-build.c | 23 -----------------------
 1 file changed, 23 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index d27cecc877..ffbdbee51a 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1360,15 +1360,6 @@ static void build_q35_isa_bridge(Aml *table)
     aml_append(field, aml_named_field("LPTD", 2));
     aml_append(dev, field);
 
-    aml_append(dev, aml_operation_region("LPCE", AML_PCI_CONFIG,
-                                         aml_int(0x82), 0x02));
-    /* enable bits */
-    field = aml_field("LPCE", AML_ANY_ACC, AML_NOLOCK, AML_PRESERVE);
-    aml_append(field, aml_named_field("CAEN", 1));
-    aml_append(field, aml_named_field("CBEN", 1));
-    aml_append(field, aml_named_field("LPEN", 1));
-    aml_append(dev, field);
-
     aml_append(scope, dev);
     aml_append(table, scope);
 }
@@ -1392,7 +1383,6 @@ static void build_piix4_isa_bridge(Aml *table)
 {
     Aml *dev;
     Aml *scope;
-    Aml *field;
 
     scope =  aml_scope("_SB.PCI0");
     dev = aml_device("ISA");
@@ -1401,19 +1391,6 @@ static void build_piix4_isa_bridge(Aml *table)
     /* PIIX PCI to ISA irq remapping */
     aml_append(dev, aml_operation_region("P40C", AML_PCI_CONFIG,
                                          aml_int(0x60), 0x04));
-    /* enable bits */
-    field = aml_field("^PX13.P13C", AML_ANY_ACC, AML_NOLOCK, AML_PRESERVE);
-    /* Offset(0x5f),, 7, */
-    aml_append(field, aml_reserved_field(0x2f8));
-    aml_append(field, aml_reserved_field(7));
-    aml_append(field, aml_named_field("LPEN", 1));
-    /* Offset(0x67),, 3, */
-    aml_append(field, aml_reserved_field(0x38));
-    aml_append(field, aml_reserved_field(3));
-    aml_append(field, aml_named_field("CAEN", 1));
-    aml_append(field, aml_reserved_field(3));
-    aml_append(field, aml_named_field("CBEN", 1));
-    aml_append(dev, field);
 
     aml_append(scope, dev);
     aml_append(table, scope);
-- 
MST


