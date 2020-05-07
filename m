Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B52C38A2A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 13:22:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62AFA20838
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 13:22:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R9IXyAjr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62AFA20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWgUC-0001uc-GZ
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 09:22:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54976)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jWgOb-0000bR-Pe
 for qemu-devel@nongnu.org; Thu, 07 May 2020 09:17:01 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:50874
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jWgOa-0005UR-Pe
 for qemu-devel@nongnu.org; Thu, 07 May 2020 09:17:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588857419;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BQtPuNzsiDINldsmqHfPFyQron4PTdZNEFYCOJsCTQ8=;
 b=R9IXyAjrNjHcGO6pjuHZpFPWQUW5dL4Zin+94cRhugI1EhMIbLeAGn3V5sP7GMmFkw/Z30
 e4A9EQ+sKXPgkqtc8UmeY04nPdcVx393E99wYyNfUEiU8mZ7Szyuhq4xfSwYy6i4zdHcrY
 u0ADu+9HxZMtXvGtH4Q0unPsRryyu/0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-Tc2gkTG3NsKuwnmvUlQXHw-1; Thu, 07 May 2020 09:16:53 -0400
X-MC-Unique: Tc2gkTG3NsKuwnmvUlQXHw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B375F80183C;
 Thu,  7 May 2020 13:16:52 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-193.ams2.redhat.com
 [10.36.113.193])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6201B707B0;
 Thu,  7 May 2020 13:16:52 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id CDAD09D54; Thu,  7 May 2020 15:16:40 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 13/15] acpi: drop build_piix4_pm()
Date: Thu,  7 May 2020 15:16:38 +0200
Message-Id: <20200507131640.14041-14-kraxel@redhat.com>
In-Reply-To: <20200507131640.14041-1-kraxel@redhat.com>
References: <20200507131640.14041-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 02:00:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
 Max Reitz <mreitz@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The _SB.PCI0.PX13.P13C opregion (holds isa device enable bits)
is not used any more, remove it from DSDT.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/i386/acpi-build.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 765409a90eb6..c1e63cce5e8e 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1441,21 +1441,6 @@ static void build_q35_isa_bridge(Aml *table)
     aml_append(table, scope);
 }
=20
-static void build_piix4_pm(Aml *table)
-{
-    Aml *dev;
-    Aml *scope;
-
-    scope =3D  aml_scope("_SB.PCI0");
-    dev =3D aml_device("PX13");
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
@@ -1607,7 +1592,6 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
         aml_append(dsdt, sb_scope);
=20
         build_hpet_aml(dsdt);
-        build_piix4_pm(dsdt);
         build_piix4_isa_bridge(dsdt);
         build_isa_devices_aml(dsdt);
         build_piix4_pci_hotplug(dsdt);
--=20
2.18.4


