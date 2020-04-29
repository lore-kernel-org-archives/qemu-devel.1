Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1671CC83004
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 14:07:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4C932082E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 14:07:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RW9gdY45"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4C932082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTnMc-0003OB-VE
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 10:07:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42436)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jTnGe-0002GK-AR
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 10:01:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jTnGB-0003s6-0x
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 10:00:52 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:57245
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jTnGA-0003qL-Ge
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 10:00:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588168821;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ns10TmOrrDyIyxSx6sKY7GiFbnXZHstnlbWiBISKw4g=;
 b=RW9gdY45FENHQx4Uhf151Fa9tiye7MhrQGnfSoGC6OloABYi+jZXyQ5oZg/4w562HNcnGQ
 FczR3SRzceg/On2cPBZtx4k3iPjOLjxe7ZtSNIsXUAREfB2siAUbsaom/bQVp68mlA1tCp
 GILcgECNn6jhOPTVB5bE9kqHlmOwekE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-480-vLy9JsC-PXmXvgt9G2oSIA-1; Wed, 29 Apr 2020 10:00:20 -0400
X-MC-Unique: vLy9JsC-PXmXvgt9G2oSIA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CF38091165;
 Wed, 29 Apr 2020 14:00:18 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-193.ams2.redhat.com
 [10.36.113.193])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7C706648D2;
 Wed, 29 Apr 2020 14:00:16 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 4FAA99D9E; Wed, 29 Apr 2020 16:00:03 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 05/15] acpi: add ISADeviceClass->build_aml()
Date: Wed, 29 Apr 2020 15:59:53 +0200
Message-Id: <20200429140003.7336-6-kraxel@redhat.com>
In-Reply-To: <20200429140003.7336-1-kraxel@redhat.com>
References: <20200429140003.7336-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 00:53:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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

Also add isa_aml_build() function which walks all isa devices.
This allows to move aml builder code to isa devices.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 include/hw/isa/isa.h |  2 ++
 hw/i386/acpi-build.c |  1 +
 hw/isa/isa-bus.c     | 15 +++++++++++++++
 3 files changed, 18 insertions(+)

diff --git a/include/hw/isa/isa.h b/include/hw/isa/isa.h
index 59a4d4b50a6d..02c235027484 100644
--- a/include/hw/isa/isa.h
+++ b/include/hw/isa/isa.h
@@ -69,6 +69,7 @@ typedef struct IsaDmaClass {
=20
 typedef struct ISADeviceClass {
     DeviceClass parent_class;
+    void (*build_aml)(ISADevice *dev, Aml *scope);
 } ISADeviceClass;
=20
 struct ISABus {
@@ -107,6 +108,7 @@ ISADevice *isa_try_create(ISABus *bus, const char *name=
);
 ISADevice *isa_create_simple(ISABus *bus, const char *name);
=20
 ISADevice *isa_vga_init(ISABus *bus);
+void isa_build_aml(ISABus *bus, Aml *scope);
=20
 /**
  * isa_register_ioport: Install an I/O port region on the ISA bus.
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 3a046b03e4cd..97f3c75cd995 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1288,6 +1288,7 @@ static void build_isa_devices_aml(Aml *table)
         error_report("No ISA bus, unable to define IPMI ACPI data");
     } else {
         build_acpi_ipmi_devices(scope, BUS(obj), "\\_SB.PCI0.ISA");
+        isa_build_aml(ISA_BUS(obj), scope);
     }
=20
     aml_append(table, scope);
diff --git a/hw/isa/isa-bus.c b/hw/isa/isa-bus.c
index 798dd9194e8f..1f2189f4d5db 100644
--- a/hw/isa/isa-bus.c
+++ b/hw/isa/isa-bus.c
@@ -207,6 +207,21 @@ ISADevice *isa_vga_init(ISABus *bus)
     }
 }
=20
+void isa_build_aml(ISABus *bus, Aml *scope)
+{
+    BusChild *kid;
+    ISADevice *dev;
+    ISADeviceClass *dc;
+
+    QTAILQ_FOREACH(kid, &bus->parent_obj.children, sibling) {
+        dev =3D ISA_DEVICE(kid->child);
+        dc =3D ISA_DEVICE_GET_CLASS(dev);
+        if (dc->build_aml) {
+            dc->build_aml(dev, scope);
+        }
+    }
+}
+
 static void isabus_dev_print(Monitor *mon, DeviceState *dev, int indent)
 {
     ISADevice *d =3D ISA_DEVICE(dev);
--=20
2.18.2


