Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F8B2C33C9E
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 15:42:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E20D02081E
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 15:42:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V2Os2q33"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E20D02081E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioqzX-0002K0-H2
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 10:41:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56999)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1ioqUN-0006xy-Ku
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 10:09:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1ioqUM-0005vT-Ba
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 10:09:47 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:47628
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1ioqUM-0005uX-8A
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 10:09:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578409785;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IuDUTL8sKfVL8YiysWAUm2XIrVkGt414sgEIf3Q3Blo=;
 b=V2Os2q33FbLt6noUq6ZA+5E9uTf8eoY1mMVnIokw4wHGCeqR2G+lBSPEz/YwIwr/MU3BLj
 yZHUf2dQOdrI+ad3KFGUhBRj6r2hYEVl2dqnWsWZktgr4WBSJ7bINXBJPgGbnFnXX4rsCk
 UrCGCJ/nYy26T9r/3S86vJh3KIEtDxg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-3CtiVAvUPgmyhfXknmHArw-1; Tue, 07 Jan 2020 10:09:44 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 407431B18BC1;
 Tue,  7 Jan 2020 15:09:43 +0000 (UTC)
Received: from localhost (ovpn-112-42.ams2.redhat.com [10.36.112.42])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DF6C985F13;
 Tue,  7 Jan 2020 15:09:41 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 25/37] dp8393x: replace PROP_PTR with PROP_LINK
Date: Tue,  7 Jan 2020 19:04:30 +0400
Message-Id: <20200107150442.1727958-26-marcandre.lureau@redhat.com>
In-Reply-To: <20200107150442.1727958-1-marcandre.lureau@redhat.com>
References: <20200107150442.1727958-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: 3CtiVAvUPgmyhfXknmHArw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Link property is the correct way to pass a MemoryRegion to a device
for DMA purposes.

Sidenote: as a sysbus device, this remains non-usercreatable
even though we can drop the specific flag here.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Tested-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/m68k/q800.c      | 3 ++-
 hw/mips/mips_jazz.c | 3 ++-
 hw/net/dp8393x.c    | 7 +++----
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index 4ca8678007..8f3eb6bfe7 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -239,7 +239,8 @@ static void q800_init(MachineState *machine)
     qdev_set_nic_properties(dev, &nd_table[0]);
     qdev_prop_set_uint8(dev, "it_shift", 2);
     qdev_prop_set_bit(dev, "big_endian", true);
-    qdev_prop_set_ptr(dev, "dma_mr", get_system_memory());
+    object_property_set_link(OBJECT(dev), OBJECT(get_system_memory()),
+                             "dma_mr", &error_abort);
     qdev_init_nofail(dev);
     sysbus =3D SYS_BUS_DEVICE(dev);
     sysbus_mmio_map(sysbus, 0, SONIC_BASE);
diff --git a/hw/mips/mips_jazz.c b/hw/mips/mips_jazz.c
index 291fd6c1b8..66fd4d867d 100644
--- a/hw/mips/mips_jazz.c
+++ b/hw/mips/mips_jazz.c
@@ -290,7 +290,8 @@ static void mips_jazz_init(MachineState *machine,
             dev =3D qdev_create(NULL, "dp8393x");
             qdev_set_nic_properties(dev, nd);
             qdev_prop_set_uint8(dev, "it_shift", 2);
-            qdev_prop_set_ptr(dev, "dma_mr", rc4030_dma_mr);
+            object_property_set_link(OBJECT(dev), OBJECT(rc4030_dma_mr),
+                                     "dma_mr", &error_abort);
             qdev_init_nofail(dev);
             sysbus =3D SYS_BUS_DEVICE(dev);
             sysbus_mmio_map(sysbus, 0, 0x80001000);
diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
index 3d991af163..cdc2631c0c 100644
--- a/hw/net/dp8393x.c
+++ b/hw/net/dp8393x.c
@@ -175,7 +175,7 @@ typedef struct dp8393xState {
     int loopback_packet;
=20
     /* Memory access */
-    void *dma_mr;
+    MemoryRegion *dma_mr;
     AddressSpace as;
 } dp8393xState;
=20
@@ -948,7 +948,8 @@ static const VMStateDescription vmstate_dp8393x =3D {
=20
 static Property dp8393x_properties[] =3D {
     DEFINE_NIC_PROPERTIES(dp8393xState, conf),
-    DEFINE_PROP_PTR("dma_mr", dp8393xState, dma_mr),
+    DEFINE_PROP_LINK("dma_mr", dp8393xState, dma_mr,
+                     TYPE_MEMORY_REGION, MemoryRegion *),
     DEFINE_PROP_UINT8("it_shift", dp8393xState, it_shift, 0),
     DEFINE_PROP_BOOL("big_endian", dp8393xState, big_endian, false),
     DEFINE_PROP_END_OF_LIST(),
@@ -963,8 +964,6 @@ static void dp8393x_class_init(ObjectClass *klass, void=
 *data)
     dc->reset =3D dp8393x_reset;
     dc->vmsd =3D &vmstate_dp8393x;
     dc->props =3D dp8393x_properties;
-    /* Reason: dma_mr property can't be set */
-    dc->user_creatable =3D false;
 }
=20
 static const TypeInfo dp8393x_info =3D {
--=20
2.25.0.rc1.20.g2443f3f80d


