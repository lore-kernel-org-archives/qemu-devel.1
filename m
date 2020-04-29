Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E4D5C83000
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 14:09:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B50F2083B
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 14:09:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VaC2djYW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B50F2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTnOn-0008U1-FD
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 10:09:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42480)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jTnGj-0002JB-Tx
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 10:01:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jTnGE-0003wB-Ax
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 10:00:57 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:24196)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jTnGD-0003vl-Us
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 10:00:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588168825;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n22B91IYToKPDnGhoaRPiX3EBwGdgVDWVvKNerABCAU=;
 b=VaC2djYWKxmUIq06Q+cQoL8bBT6sv5uvtchqzLiWwYy6f9Pkt41bn7JA4hfnKEoPdgf3Vz
 TwdJQrAK/fF6YLPpEiMHZA/ju/nk6LizOR9JH0uPBabzUnZ7VeS4C5oUyDuln7uWBbsmrX
 xHOgQTH4g3sDUYjncnR0WNL0LXb3ajg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-WKFz3I-kMLWnDitecz7ARw-1; Wed, 29 Apr 2020 10:00:20 -0400
X-MC-Unique: WKFz3I-kMLWnDitecz7ARw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 22749835B41;
 Wed, 29 Apr 2020 14:00:19 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-193.ams2.redhat.com
 [10.36.113.193])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9222F28550;
 Wed, 29 Apr 2020 14:00:18 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id B81549DAA; Wed, 29 Apr 2020 16:00:03 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 15/15] acpi: simplify build_isa_devices_aml()
Date: Wed, 29 Apr 2020 16:00:03 +0200
Message-Id: <20200429140003.7336-16-kraxel@redhat.com>
In-Reply-To: <20200429140003.7336-1-kraxel@redhat.com>
References: <20200429140003.7336-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 01:28:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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

x86 machines can have a single ISA bus only.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/i386/acpi-build.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index a8b790021974..98b3fd1cdb14 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1055,19 +1055,14 @@ static void build_hpet_aml(Aml *table)
 static void build_isa_devices_aml(Aml *table)
 {
     bool ambiguous;
-
-    Aml *scope =3D aml_scope("_SB.PCI0.ISA");
     Object *obj =3D object_resolve_path_type("", TYPE_ISA_BUS, &ambiguous)=
;
+    Aml *scope;
=20
-    if (ambiguous) {
-        error_report("Multiple ISA busses, unable to define IPMI ACPI data=
");
-    } else if (!obj) {
-        error_report("No ISA bus, unable to define IPMI ACPI data");
-    } else {
-        build_acpi_ipmi_devices(scope, BUS(obj), "\\_SB.PCI0.ISA");
-        isa_build_aml(ISA_BUS(obj), scope);
-    }
+    assert(obj && !ambiguous);
=20
+    scope =3D aml_scope("_SB.PCI0.ISA");
+    build_acpi_ipmi_devices(scope, BUS(obj), "\\_SB.PCI0.ISA");
+    isa_build_aml(ISA_BUS(obj), scope);
     aml_append(table, scope);
 }
=20
--=20
2.18.2


