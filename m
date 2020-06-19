Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 184C1C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 09:22:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3D43208DB
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 09:22:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EvQp2W34"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3D43208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmDE9-0008Uj-2n
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 05:22:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37544)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jmDBI-00036t-FK
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 05:19:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46161
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jmDBF-0003gq-UQ
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 05:19:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592558365;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=z72Yr4FMuinu64y2syYrbEnB9c9HaZz9cSe0nG+rUYA=;
 b=EvQp2W343m/FPUFwJRNYeinlr3IcTlqFmxY+h4M3HvlRt17YaD2ilJ9xpftWprfPvAQ+pv
 D/+WvtWjPoBLVoLM3r+bnS9mvwEWE7jzMVewZXithQ3una4GQ6ZjWlHXksBpt6P3xy920L
 2GBQkzYWyvx4ls3cvKMUtJGeh67gnb8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-_bGPfUNMNSeLpbbMM1utWA-1; Fri, 19 Jun 2020 05:19:21 -0400
X-MC-Unique: _bGPfUNMNSeLpbbMM1utWA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7F843107ACF2;
 Fri, 19 Jun 2020 09:19:20 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-67.ams2.redhat.com
 [10.36.112.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 854FE19C79;
 Fri, 19 Jun 2020 09:19:15 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 5AA689D99; Fri, 19 Jun 2020 11:19:06 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 09/12] acpi: drop serial/parallel enable bits from dsdt
Date: Fri, 19 Jun 2020 11:19:02 +0200
Message-Id: <20200619091905.21676-10-kraxel@redhat.com>
In-Reply-To: <20200619091905.21676-1-kraxel@redhat.com>
References: <20200619091905.21676-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 05:19:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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
---
 hw/i386/acpi-build.c | 23 -----------------------
 1 file changed, 23 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index d27cecc877c4..ffbdbee51aa8 100644
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
2.18.4


