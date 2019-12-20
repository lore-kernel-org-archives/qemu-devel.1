Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24DAAC43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 13:56:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E458A218AC
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 13:56:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ggpTSAta"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E458A218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiIlH-00014b-Nf
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 08:56:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37617)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iiIdC-00048J-9O
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 08:47:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iiIdA-0000gI-Gu
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 08:47:49 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34784
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1iiIdA-0000em-B9
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 08:47:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576849666;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OozN9IdXbzYikbY0vcB6F7rZ/9QvMwXvXxBYIqWfGgc=;
 b=ggpTSAtayGBCpXEnPJOhbVFBMbNA0sxtgSfhHT7GGK/2M3gtZ0ohQG8vjz2x5vaIu4h0N5
 qOGqmngtpn/fv0yGolp+fqc2/qJMannKwm36ATXkIJhl1EbHH4qqtxrBPDW4OUa0pCYqdA
 cn8DaxDzrQJ6waYFFmt9YW+1lqPOhGE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-149--RUF5h0oMx-I4hYFl1Bipg-1; Fri, 20 Dec 2019 08:47:44 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 363508024D4;
 Fri, 20 Dec 2019 13:47:43 +0000 (UTC)
Received: from localhost (ovpn-112-54.ams2.redhat.com [10.36.112.54])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A27A726FC8;
 Fri, 20 Dec 2019 13:47:39 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 11/37] serial: replace serial_exit_core() with unrealize
Date: Fri, 20 Dec 2019 17:45:35 +0400
Message-Id: <20191220134601.571905-12-marcandre.lureau@redhat.com>
In-Reply-To: <20191220134601.571905-1-marcandre.lureau@redhat.com>
References: <20191220134601.571905-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: -RUF5h0oMx-I4hYFl1Bipg-1
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Instead of calling serial_exit_core() directly, use the QDev unrealize
callback.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/char/serial-pci-multi.c | 2 +-
 hw/char/serial-pci.c       | 2 +-
 hw/char/serial.c           | 5 ++++-
 include/hw/char/serial.h   | 1 -
 4 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/char/serial-pci-multi.c b/hw/char/serial-pci-multi.c
index 0e1fdb75d2..e343a1235c 100644
--- a/hw/char/serial-pci-multi.c
+++ b/hw/char/serial-pci-multi.c
@@ -56,7 +56,7 @@ static void multi_serial_pci_exit(PCIDevice *dev)
=20
     for (i =3D 0; i < pci->ports; i++) {
         s =3D pci->state + i;
-        serial_exit_core(s);
+        object_property_set_bool(OBJECT(s), false, "realized", NULL);
         memory_region_del_subregion(&pci->iobar, &s->io);
         g_free(pci->name[i]);
     }
diff --git a/hw/char/serial-pci.c b/hw/char/serial-pci.c
index 4b6a217365..b6a73c65a9 100644
--- a/hw/char/serial-pci.c
+++ b/hw/char/serial-pci.c
@@ -68,7 +68,7 @@ static void serial_pci_exit(PCIDevice *dev)
     PCISerialState *pci =3D DO_UPCAST(PCISerialState, dev, dev);
     SerialState *s =3D &pci->state;
=20
-    serial_exit_core(s);
+    object_property_set_bool(OBJECT(s), false, "realized", NULL);
     qemu_free_irq(s->irq);
 }
=20
diff --git a/hw/char/serial.c b/hw/char/serial.c
index 8328cc62c3..ec388f3876 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -950,8 +950,10 @@ static void serial_realize(DeviceState *dev, Error **e=
rrp)
     serial_reset(s);
 }
=20
-void serial_exit_core(SerialState *s)
+static void serial_unrealize(DeviceState *dev, Error **errp)
 {
+    SerialState *s =3D SERIAL(dev);
+
     qemu_chr_fe_deinit(&s->chr, false);
=20
     timer_del(s->modem_status_poll);
@@ -1014,6 +1016,7 @@ static void serial_class_init(ObjectClass *klass, voi=
d* data)
     /* internal device for serialio/serialmm, not user-creatable */
     dc->user_creatable =3D false;
     dc->realize =3D serial_realize;
+    dc->unrealize =3D serial_unrealize;
     dc->vmsd =3D &vmstate_serial;
     dc->props =3D serial_properties;
 }
diff --git a/include/hw/char/serial.h b/include/hw/char/serial.h
index 571aab97c8..548944b06a 100644
--- a/include/hw/char/serial.h
+++ b/include/hw/char/serial.h
@@ -83,7 +83,6 @@ typedef struct SerialState {
 extern const VMStateDescription vmstate_serial;
 extern const MemoryRegionOps serial_io_ops;
=20
-void serial_exit_core(SerialState *s);
 void serial_set_frequency(SerialState *s, uint32_t frequency);
=20
 #define TYPE_SERIAL "serial"
--=20
2.24.0.308.g228f53135a


