Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F8AC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 15:39:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDD9320709
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 15:39:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GsLZ78SW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDD9320709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXS4V-0007Ys-JE
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 10:39:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34267)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iXRsm-0001B6-Vp
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 10:27:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iXRsl-0007MG-PW
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 10:27:04 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39224
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1iXRsl-0007MA-Lq
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 10:27:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574263623;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yiSoyz5oAvRre2Fzv7HBbfQARJImnaGWmkkkI/c66bg=;
 b=GsLZ78SW+iIaCG1uET/5ijhKXOyTwwQlF8Fh+2njxsAH3R1iHqt8INfu3VFz/RhVMn5aIt
 +l4YXUvtTCsyY5+H428/VjbBn9THkh17k5kGsahztwS33mycAKqQwbYpZdyF5yuniVlUsu
 E8wa8cKzW4gIgXLENAOn97p7G6TrjBU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-243-bgGpLcpZP-OqYt4vcQMlhA-1; Wed, 20 Nov 2019 10:26:59 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D26F3801E74;
 Wed, 20 Nov 2019 15:26:58 +0000 (UTC)
Received: from localhost (ovpn-112-56.ams2.redhat.com [10.36.112.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E032C5ED31;
 Wed, 20 Nov 2019 15:26:48 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 11/37] serial: replace serial_exit_core() with unrealize
Date: Wed, 20 Nov 2019 19:24:16 +0400
Message-Id: <20191120152442.26657-12-marcandre.lureau@redhat.com>
In-Reply-To: <20191120152442.26657-1-marcandre.lureau@redhat.com>
References: <20191120152442.26657-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: bgGpLcpZP-OqYt4vcQMlhA-1
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
Cc: peter.maydell@linaro.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
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
index 1f3859eef1..2d8471dbbb 100644
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
@@ -1013,6 +1015,7 @@ static void serial_class_init(ObjectClass *klass, voi=
d* data)
=20
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
2.24.0


