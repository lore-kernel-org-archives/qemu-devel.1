Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4933AC33C9A
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 15:28:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16B7D21906
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 15:28:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uix6r7x0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16B7D21906
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXRuA-0002S5-Pg
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 10:28:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34222)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iXRsJ-0000GF-A1
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 10:26:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iXRsI-0007FU-3H
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 10:26:35 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45840
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1iXRsH-0007FM-W2
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 10:26:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574263593;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bdFx1S253CRXwCupfK/PdNiWnXox/3XHzF9jDi8r7W8=;
 b=Uix6r7x0tceYqszt701+wclHZbzlTMy0MkdezqAuv9z3gAdyz8UGd6s8iiyn7Ojrj85Eql
 DTfAKBgvUVa1V72jV9eWkREk0ddoNIbkD07t8kT/sa5rcicFt2g4lZhHWmtQB9pPQTW4xC
 53z1CgFHycJ3g4bMBMjVkLGHilDdiuc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-TgmSOwgXNP6ExGe9eOKQMg-1; Wed, 20 Nov 2019 10:26:30 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2BB21801E5B;
 Wed, 20 Nov 2019 15:26:29 +0000 (UTC)
Received: from localhost (ovpn-112-56.ams2.redhat.com [10.36.112.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 34A661037ADA;
 Wed, 20 Nov 2019 15:26:22 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 09/37] serial: add "baudbase" property
Date: Wed, 20 Nov 2019 19:24:14 +0400
Message-Id: <20191120152442.26657-10-marcandre.lureau@redhat.com>
In-Reply-To: <20191120152442.26657-1-marcandre.lureau@redhat.com>
References: <20191120152442.26657-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: TgmSOwgXNP6ExGe9eOKQMg-1
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
Cc: peter.maydell@linaro.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/char/serial-isa.c       | 1 -
 hw/char/serial-pci-multi.c | 1 -
 hw/char/serial-pci.c       | 1 -
 hw/char/serial.c           | 5 +++--
 include/hw/char/serial.h   | 2 +-
 5 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/hw/char/serial-isa.c b/hw/char/serial-isa.c
index 9a5928b3ee..2a4c8de1bf 100644
--- a/hw/char/serial-isa.c
+++ b/hw/char/serial-isa.c
@@ -73,7 +73,6 @@ static void serial_isa_realizefn(DeviceState *dev, Error =
**errp)
     }
     index++;
=20
-    s->baudbase =3D 115200;
     isa_init_irq(isadev, &s->irq, isa->isairq);
     serial_realize_core(s, errp);
     qdev_set_legacy_instance_id(dev, isa->iobase, 3);
diff --git a/hw/char/serial-pci-multi.c b/hw/char/serial-pci-multi.c
index edfbfdca9e..4891f32230 100644
--- a/hw/char/serial-pci-multi.c
+++ b/hw/char/serial-pci-multi.c
@@ -106,7 +106,6 @@ static void multi_serial_pci_realize(PCIDevice *dev, Er=
ror **errp)
=20
     for (i =3D 0; i < nports; i++) {
         s =3D pci->state + i;
-        s->baudbase =3D 115200;
         serial_realize_core(s, &err);
         if (err !=3D NULL) {
             error_propagate(errp, err);
diff --git a/hw/char/serial-pci.c b/hw/char/serial-pci.c
index f99b6c19e0..db2c17aafd 100644
--- a/hw/char/serial-pci.c
+++ b/hw/char/serial-pci.c
@@ -49,7 +49,6 @@ static void serial_pci_realize(PCIDevice *dev, Error **er=
rp)
     SerialState *s =3D &pci->state;
     Error *err =3D NULL;
=20
-    s->baudbase =3D 115200;
     serial_realize_core(s, &err);
     if (err !=3D NULL) {
         error_propagate(errp, err);
diff --git a/hw/char/serial.c b/hw/char/serial.c
index 83417cb8c4..4a598ead21 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -988,7 +988,7 @@ SerialState *serial_init(int base, qemu_irq irq, int ba=
udbase,
     SerialState *s =3D SERIAL(dev);
=20
     s->irq =3D irq;
-    s->baudbase =3D baudbase;
+    qdev_prop_set_uint32(dev, "baudbase", baudbase);
     qdev_prop_set_chr(dev, "chardev", chr);
     serial_realize_core(s, &error_fatal);
     qdev_set_legacy_instance_id(dev, base, 2);
@@ -1002,6 +1002,7 @@ SerialState *serial_init(int base, qemu_irq irq, int =
baudbase,
=20
 static Property serial_properties[] =3D {
     DEFINE_PROP_CHR("chardev", SerialState, chr),
+    DEFINE_PROP_UINT32("baudbase", SerialState, baudbase, 115200),
     DEFINE_PROP_END_OF_LIST(),
 };
=20
@@ -1071,7 +1072,7 @@ SerialState *serial_mm_init(MemoryRegion *address_spa=
ce,
=20
     s->it_shift =3D it_shift;
     s->irq =3D irq;
-    s->baudbase =3D baudbase;
+    qdev_prop_set_uint32(dev, "baudbase", baudbase);
     qdev_prop_set_chr(dev, "chardev", chr);
=20
     serial_realize_core(s, &error_fatal);
diff --git a/include/hw/char/serial.h b/include/hw/char/serial.h
index 180cc7c24e..3dc618598e 100644
--- a/include/hw/char/serial.h
+++ b/include/hw/char/serial.h
@@ -58,7 +58,7 @@ typedef struct SerialState {
     CharBackend chr;
     int last_break_enable;
     int it_shift;
-    int baudbase;
+    uint32_t baudbase;
     uint32_t tsr_retry;
     guint watch_tag;
     uint32_t wakeup;
--=20
2.24.0


