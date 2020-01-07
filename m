Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 913EBC33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 15:36:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CB3E2081E
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 15:36:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OR8rLhqq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CB3E2081E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioquL-0000my-0g
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 10:36:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55979)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1ioqSo-00047I-Fi
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 10:08:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1ioqSn-0004fH-5k
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 10:08:10 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29384
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1ioqSn-0004ei-2B
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 10:08:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578409688;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xzTtrwPBUO3ZOQDiQCQoKIsWvB6AIY1hpawn1DUdOoU=;
 b=OR8rLhqq2Gh6PXbdZQAXlnP2xbKASTYbEOTjzWbI6BkgCaU3VMGSM4RlecVJ3Vyu1iCHYc
 ZLabzRupl+loPbUr5kYAay8FnC9RvSIyc0w0xMdlj1apO4HAe8IsRoelSMPMPAnfeH9OaX
 RTLLimDW69qH9dgOdJQmpbRu6VWKtdY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-311-3x0A3W4zP7SChYJuzCVO8g-1; Tue, 07 Jan 2020 10:08:07 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 84678801E6C;
 Tue,  7 Jan 2020 15:08:06 +0000 (UTC)
Received: from localhost (ovpn-112-42.ams2.redhat.com [10.36.112.42])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D466360BFB;
 Tue,  7 Jan 2020 15:07:59 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 17/37] mips: inline serial_init()
Date: Tue,  7 Jan 2020 19:04:22 +0400
Message-Id: <20200107150442.1727958-18-marcandre.lureau@redhat.com>
In-Reply-To: <20200107150442.1727958-1-marcandre.lureau@redhat.com>
References: <20200107150442.1727958-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 3x0A3W4zP7SChYJuzCVO8g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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

The function is specific to mipssim, let's inline it.

(when inlining, we use a DeviceState variable instead of SerialIO, as
it is the most common type used, and avoids having too many casts)

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 include/hw/char/serial.h |  2 --
 hw/char/serial.c         | 16 ----------------
 hw/mips/mips_mipssim.c   | 15 ++++++++++++---
 3 files changed, 12 insertions(+), 21 deletions(-)

diff --git a/include/hw/char/serial.h b/include/hw/char/serial.h
index d356ba838c..535fa23a2b 100644
--- a/include/hw/char/serial.h
+++ b/include/hw/char/serial.h
@@ -108,8 +108,6 @@ void serial_set_frequency(SerialState *s, uint32_t freq=
uency);
 #define TYPE_SERIAL_IO "serial-io"
 #define SERIAL_IO(s) OBJECT_CHECK(SerialIO, (s), TYPE_SERIAL_IO)
=20
-SerialIO *serial_init(int base, qemu_irq irq, int baudbase,
-                      Chardev *chr, MemoryRegion *system_io);
 SerialMM *serial_mm_init(MemoryRegion *address_space,
                          hwaddr base, int regshift,
                          qemu_irq irq, int baudbase,
diff --git a/hw/char/serial.c b/hw/char/serial.c
index 3bcb7a6268..7746dfcee8 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -1028,22 +1028,6 @@ static const TypeInfo serial_io_info =3D {
     .class_init =3D serial_io_class_init,
 };
=20
-SerialIO *serial_init(int base, qemu_irq irq, int baudbase,
-                         Chardev *chr, MemoryRegion *system_io)
-{
-    SerialIO *sio =3D SERIAL_IO(qdev_create(NULL, TYPE_SERIAL_IO));
-
-    qdev_prop_set_uint32(DEVICE(sio), "baudbase", baudbase);
-    qdev_prop_set_chr(DEVICE(sio), "chardev", chr);
-    qdev_set_legacy_instance_id(DEVICE(sio), base, 2);
-    qdev_init_nofail(DEVICE(sio));
-
-    sysbus_connect_irq(SYS_BUS_DEVICE(sio), 0, irq);
-    memory_region_add_subregion(system_io, base, &sio->serial.io);
-
-    return sio;
-}
-
 static Property serial_properties[] =3D {
     DEFINE_PROP_CHR("chardev", SerialState, chr),
     DEFINE_PROP_UINT32("baudbase", SerialState, baudbase, 115200),
diff --git a/hw/mips/mips_mipssim.c b/hw/mips/mips_mipssim.c
index 282bbecb24..5ee26108f5 100644
--- a/hw/mips/mips_mipssim.c
+++ b/hw/mips/mips_mipssim.c
@@ -40,6 +40,7 @@
 #include "hw/loader.h"
 #include "elf.h"
 #include "hw/sysbus.h"
+#include "hw/qdev-properties.h"
 #include "exec/address-spaces.h"
 #include "qemu/error-report.h"
 #include "sysemu/qtest.h"
@@ -219,9 +220,17 @@ mips_mipssim_init(MachineState *machine)
      * A single 16450 sits at offset 0x3f8. It is attached to
      * MIPS CPU INT2, which is interrupt 4.
      */
-    if (serial_hd(0))
-        serial_init(0x3f8, env->irq[4], 115200, serial_hd(0),
-                    get_system_io());
+    if (serial_hd(0)) {
+        DeviceState *dev =3D qdev_create(NULL, TYPE_SERIAL_IO);
+
+        qdev_prop_set_uint32(dev, "baudbase", 115200);
+        qdev_prop_set_chr(dev, "chardev", serial_hd(0));
+        qdev_set_legacy_instance_id(dev, 0x3f8, 2);
+        qdev_init_nofail(dev);
+        sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, env->irq[4]);
+        memory_region_add_subregion(get_system_io(), 0x3f8,
+                                    &SERIAL_IO(dev)->serial.io);
+    }
=20
     if (nd_table[0].used)
         /* MIPSnet uses the MIPS CPU INT0, which is interrupt 2. */
--=20
2.25.0.rc1.20.g2443f3f80d


