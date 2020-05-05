Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9300AC47247
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 11:44:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D362206B8
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 11:44:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZJKBza6b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D362206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVvzv-0005Ir-Gm
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 07:44:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48158)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jVvuz-0006DW-Gf
 for qemu-devel@nongnu.org; Tue, 05 May 2020 07:39:21 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:29585
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jVvux-0003aT-Vn
 for qemu-devel@nongnu.org; Tue, 05 May 2020 07:39:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588678759;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gM9CYxAKvVg1hN4bItv68KBJKyF6SrKF+mESMvEQDn8=;
 b=ZJKBza6b7imYtyvPlu3WtpVI3oqB7LvyhDeBjluNTCi9PMFmq6Af76ei1KOxGMWbsRyKRi
 0f5HC47Ezw2DxdgG/dV6Afk+eo++TGARLSbMM4eAZWuq8wI31Zw6rMlYPSHxuVaYDyUC+A
 y0tXTY0fGvdFa6bMckRVxtn7eywIJn4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-121-ddYGmjF9Nu2MOoyU8Jwrmw-1; Tue, 05 May 2020 07:39:17 -0400
X-MC-Unique: ddYGmjF9Nu2MOoyU8Jwrmw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 78C87835B41;
 Tue,  5 May 2020 11:39:16 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-193.ams2.redhat.com
 [10.36.113.193])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8EA1863F97;
 Tue,  5 May 2020 11:39:04 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 1ECFE9D57; Tue,  5 May 2020 13:38:44 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 12/13] acpi: drop serial/parallel enable bits from dsdt
Date: Tue,  5 May 2020 13:38:42 +0200
Message-Id: <20200505113843.22012-13-kraxel@redhat.com>
In-Reply-To: <20200505113843.22012-1-kraxel@redhat.com>
References: <20200505113843.22012-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 00:37:19
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

The _STA methods for COM+LPT used to reference them,
but that isn't the case any more.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/i386/acpi-build.c | 23 -----------------------
 1 file changed, 23 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 1922868f3401..765409a90eb6 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1437,15 +1437,6 @@ static void build_q35_isa_bridge(Aml *table)
     aml_append(field, aml_named_field("LPTD", 2));
     aml_append(dev, field);
=20
-    aml_append(dev, aml_operation_region("LPCE", AML_PCI_CONFIG,
-                                         aml_int(0x82), 0x02));
-    /* enable bits */
-    field =3D aml_field("LPCE", AML_ANY_ACC, AML_NOLOCK, AML_PRESERVE);
-    aml_append(field, aml_named_field("CAEN", 1));
-    aml_append(field, aml_named_field("CBEN", 1));
-    aml_append(field, aml_named_field("LPEN", 1));
-    aml_append(dev, field);
-
     aml_append(scope, dev);
     aml_append(table, scope);
 }
@@ -1469,7 +1460,6 @@ static void build_piix4_isa_bridge(Aml *table)
 {
     Aml *dev;
     Aml *scope;
-    Aml *field;
=20
     scope =3D  aml_scope("_SB.PCI0");
     dev =3D aml_device("ISA");
@@ -1478,19 +1468,6 @@ static void build_piix4_isa_bridge(Aml *table)
     /* PIIX PCI to ISA irq remapping */
     aml_append(dev, aml_operation_region("P40C", AML_PCI_CONFIG,
                                          aml_int(0x60), 0x04));
-    /* enable bits */
-    field =3D aml_field("^PX13.P13C", AML_ANY_ACC, AML_NOLOCK, AML_PRESERV=
E);
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
=20
     aml_append(scope, dev);
     aml_append(table, scope);
--=20
2.18.4


