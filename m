Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64EF8C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 07:35:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CF712072F
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 07:35:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QeX6Kedc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CF712072F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjHkR-0008JS-7g
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 03:35:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52240)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jjHet-0000Q2-Ib
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 03:29:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46824
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jjHes-0004kU-O5
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 03:29:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591860594;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=6k1jcxf8ypU/XW3uW5/tOJlrRS6jF0mmavKqpADz79A=;
 b=QeX6Kedcr88gwUwkVbxDR7xIjRO+ckqisAK9h592cQk32qTQoULFiuysn78r8k4Wz4OyOt
 STQOJegkrfE3Kps6IM2wBsyuMUFCtA1mbNU1cSWLvD4liPPF3NxFgEzGaMZwlW1lGuzPyC
 pJg/mVJRWIxlUMjuHTzmoQPQrTXkCM4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-114-St0AVwkaN22CXtFcv47h3g-1; Thu, 11 Jun 2020 03:29:52 -0400
X-MC-Unique: St0AVwkaN22CXtFcv47h3g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 783571009600;
 Thu, 11 Jun 2020 07:29:51 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-50.ams2.redhat.com
 [10.36.113.50])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3073E5C3E7;
 Thu, 11 Jun 2020 07:29:31 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 0A4A39D57; Thu, 11 Jun 2020 09:29:20 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 09/10] acpi: drop build_piix4_pm()
Date: Thu, 11 Jun 2020 09:29:18 +0200
Message-Id: <20200611072919.16638-10-kraxel@redhat.com>
In-Reply-To: <20200611072919.16638-1-kraxel@redhat.com>
References: <20200611072919.16638-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 03:29:33
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
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, John Snow <jsnow@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The _SB.PCI0.PX13.P13C opregion (holds isa device enable bits)
is not used any more, remove it from DSDT.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Igor Mammedow <imammedo@redhat.com>
---
 hw/i386/acpi-build.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 750fcf9baa37..02cf4199c2e9 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1320,21 +1320,6 @@ static void build_q35_isa_bridge(Aml *table)
     aml_append(table, scope);
 }
 
-static void build_piix4_pm(Aml *table)
-{
-    Aml *dev;
-    Aml *scope;
-
-    scope =  aml_scope("_SB.PCI0");
-    dev = aml_device("PX13");
-    aml_append(dev, aml_name_decl("_ADR", aml_int(0x00010003)));
-
-    aml_append(dev, aml_operation_region("P13C", AML_PCI_CONFIG,
-                                         aml_int(0x00), 0xff));
-    aml_append(scope, dev);
-    aml_append(table, scope);
-}
-
 static void build_piix4_isa_bridge(Aml *table)
 {
     Aml *dev;
@@ -1486,7 +1471,6 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
         aml_append(dsdt, sb_scope);
 
         build_hpet_aml(dsdt);
-        build_piix4_pm(dsdt);
         build_piix4_isa_bridge(dsdt);
         build_isa_devices_aml(dsdt);
         build_piix4_pci_hotplug(dsdt);
-- 
2.18.4


