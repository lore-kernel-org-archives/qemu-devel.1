Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9015C47247
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 11:40:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A50A42073B
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 11:40:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eE/uiHKV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A50A42073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVvwV-0007wl-M8
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 07:40:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48110)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jVvuv-00064b-NO
 for qemu-devel@nongnu.org; Tue, 05 May 2020 07:39:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44711
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jVvuv-0003Zh-2b
 for qemu-devel@nongnu.org; Tue, 05 May 2020 07:39:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588678756;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I0qh2xPxJYLmXMo2QOX76vG75M0qxBOZz6gOO+mWZOY=;
 b=eE/uiHKVZfifVsyEuvX6Csr3QhcxlybWegrLdHYc051FYP7RLEQOnE+L6fvnS8C8ZqPAF+
 FZ0/nAJMNtwo3JQxERzk/0SFj2T5gOUyXG4yTNi6qaQRXdGfn/Lr8Pj/zh8X/7kiH9zxcf
 1LCSGgrQh/TDrGB1fL67flcKFK6gvqY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-oWeQKbWQPiq0b-e53CTD8g-1; Tue, 05 May 2020 07:39:13 -0400
X-MC-Unique: oWeQKbWQPiq0b-e53CTD8g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D0E66800D24;
 Tue,  5 May 2020 11:39:11 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-193.ams2.redhat.com
 [10.36.113.193])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 23B007053E;
 Tue,  5 May 2020 11:39:01 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 1614F9D56; Tue,  5 May 2020 13:38:44 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 11/13] acpi: simplify build_isa_devices_aml()
Date: Tue,  5 May 2020 13:38:41 +0200
Message-Id: <20200505113843.22012-12-kraxel@redhat.com>
In-Reply-To: <20200505113843.22012-1-kraxel@redhat.com>
References: <20200505113843.22012-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 00:37:38
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

x86 machines can have a single ISA bus only.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/i386/acpi-build.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index cb3913d2ee76..1922868f3401 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1061,19 +1061,14 @@ static void build_hpet_aml(Aml *table)
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
2.18.4


