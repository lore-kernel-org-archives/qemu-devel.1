Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39928C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 08:11:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05BC7206F8
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 08:11:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f6X4YiTV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05BC7206F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKHPp-0003CR-3g
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 04:11:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42365)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jKHKL-00011E-El
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 04:05:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1jKHKK-0007nn-3p
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 04:05:21 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:39708
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1jKHKJ-0007nR-Ve
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 04:05:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585901119;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4YbRkhcht6AfyVCgYgKokBY6y6+1gGLr7bQc2d2xUGA=;
 b=f6X4YiTVv4pk9+SQVzsBBdZbwX34pY32OLi8tjNXeUGc6WzPR8x+/vk8786fTAH1jvQbod
 OmHblkTyKL8XQYRvsiexMgnAmdknsqMndqCBJKqI3F4SloibmPI7+Npd145yWzm3pAYfum
 GV4Qd3xUkhXWvcuHMYFyzkoIy9IB1lI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-TkiDnXzpNNWJ1Aeqji_rkw-1; Fri, 03 Apr 2020 04:05:14 -0400
X-MC-Unique: TkiDnXzpNNWJ1Aeqji_rkw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 82F67107ACCC;
 Fri,  3 Apr 2020 08:05:13 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-60.ams2.redhat.com
 [10.36.113.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1676860BF3;
 Fri,  3 Apr 2020 08:05:13 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 1D9AC17511; Fri,  3 Apr 2020 10:05:03 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 06/12] acpi: add ISADeviceClass->build_aml()
Date: Fri,  3 Apr 2020 10:04:56 +0200
Message-Id: <20200403080502.8154-7-kraxel@redhat.com>
In-Reply-To: <20200403080502.8154-1-kraxel@redhat.com>
References: <20200403080502.8154-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, John Snow <jsnow@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Also add isa_aml_build() function which walks all isa devices.
This allows to move aml builder code to isa devices.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/hw/isa/isa.h |  2 ++
 hw/i386/acpi-build.c |  1 +
 hw/isa/isa-bus.c     | 15 +++++++++++++++
 3 files changed, 18 insertions(+)

diff --git a/include/hw/isa/isa.h b/include/hw/isa/isa.h
index e9ac1f1205a4..1534f8826453 100644
--- a/include/hw/isa/isa.h
+++ b/include/hw/isa/isa.h
@@ -70,6 +70,7 @@ typedef struct IsaDmaClass {
=20
 typedef struct ISADeviceClass {
     DeviceClass parent_class;
+    void (*build_aml)(ISADevice *dev, Aml *scope);
 } ISADeviceClass;
=20
 struct ISABus {
@@ -108,6 +109,7 @@ ISADevice *isa_try_create(ISABus *bus, const char *name=
);
 ISADevice *isa_create_simple(ISABus *bus, const char *name);
=20
 ISADevice *isa_vga_init(ISABus *bus);
+void isa_build_aml(ISABus *bus, Aml *scope);
=20
 /**
  * isa_register_ioport: Install an I/O port region on the ISA bus.
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 5d2b9b099684..77fc9df74735 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1259,6 +1259,7 @@ static void build_isa_devices_aml(Aml *table)
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


