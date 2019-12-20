Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE5E4C2D0D4
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 14:04:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D2E22068F
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 14:04:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JbKJxqn3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D2E22068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiItP-0004Hn-B1
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 09:04:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46797)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iiIeK-0005o9-Rc
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 08:49:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iiIeJ-0004PS-Gl
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 08:49:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22910
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1iiIeJ-0004Nh-Bi
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 08:48:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576849738;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VJFI0s8ox07qoJE1UDX4mtILVP9oq6ke2Z20xFAN4vI=;
 b=JbKJxqn3uwwl9InIKLeAMsaZAxvOGpa0aOgNTPKsmfEpC+RzNx+SxRV7fE/Pt7qMNl1H4/
 vl13yJ1mLUdEvQdnXDiaUaU52SW+K/Bqaq5S31yDpF7M1M1QngnBBGdW9oiuUcjM82etNJ
 M1q/Hk0a7TjFYOR9NVWAXTgEvKwKZbo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-TbDvIuK8NvKfnooJCb7I_w-1; Fri, 20 Dec 2019 08:48:56 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 889FD81CE31;
 Fri, 20 Dec 2019 13:48:55 +0000 (UTC)
Received: from localhost (ovpn-112-54.ams2.redhat.com [10.36.112.54])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0A70B48;
 Fri, 20 Dec 2019 13:48:50 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 17/37] mips: inline serial_init()
Date: Fri, 20 Dec 2019 17:45:41 +0400
Message-Id: <20191220134601.571905-18-marcandre.lureau@redhat.com>
In-Reply-To: <20191220134601.571905-1-marcandre.lureau@redhat.com>
References: <20191220134601.571905-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: TbDvIuK8NvKfnooJCb7I_w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: peter.maydell@linaro.org,
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
 hw/char/serial.c         | 16 ----------------
 hw/mips/mips_mipssim.c   | 15 ++++++++++++---
 include/hw/char/serial.h |  2 --
 3 files changed, 12 insertions(+), 21 deletions(-)

diff --git a/hw/char/serial.c b/hw/char/serial.c
index 84b4267ce6..f0f81b34ec 100644
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
--=20
2.24.0.308.g228f53135a


