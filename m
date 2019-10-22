Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC888CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 16:38:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70608205ED
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 16:38:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GkNFnZte"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70608205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMxB7-0008EH-93
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 12:38:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38376)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iMwwV-0007bV-Sd
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 12:23:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iMwwU-0007WI-L1
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 12:23:31 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:56622
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1iMwwU-0007Vp-Gu
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 12:23:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571761409;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HotPPiIJVVyamwtat6NAZnHGetIQoRDZ3osWMjFNcac=;
 b=GkNFnZteX+k+H51Zvl73xWKiqzQFpjwVg/dtmft6819WT5CUEwuIn2RrFjwgTdRDgDafx1
 Z3yMJ5860oPvvz2U1DXx90dW75Y3SPa76Jcx4ojLFI3Wsn9BJwIiXQ4SP4UWC2Wxy7jdeE
 eAOqbiLoGff6iSuan2BBr+Y/mps4MuU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-BChp7aKON_SZ8m5KR-Ctng-1; Tue, 22 Oct 2019 12:23:26 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 21D511800D6A;
 Tue, 22 Oct 2019 16:23:19 +0000 (UTC)
Received: from localhost (ovpn-112-21.ams2.redhat.com [10.36.112.21])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 83FEB6012C;
 Tue, 22 Oct 2019 16:23:18 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 13/28] serial: factor out serial_mm_connect
Date: Tue, 22 Oct 2019 18:21:22 +0200
Message-Id: <20191022162137.27161-14-marcandre.lureau@redhat.com>
In-Reply-To: <20191022162137.27161-1-marcandre.lureau@redhat.com>
References: <20191022162137.27161-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: BChp7aKON_SZ8m5KR-Ctng-1
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
Cc: Corey Minyard <cminyard@mvista.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>, Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Fabien Chouteau <chouteau@adacore.com>, qemu-arm@nongnu.org,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-ppc@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Split IRQ and memory region initialization in a different function to
be reused by callers that realize the serial device themself, and
connect irq/mem after.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/char/serial.c         | 20 +++++++++++++-------
 include/hw/char/serial.h |  3 +++
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/hw/char/serial.c b/hw/char/serial.c
index 72d48b5cd8..41548e159c 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -1078,27 +1078,33 @@ static const MemoryRegionOps serial_mm_ops[3] =3D {
     },
 };
=20
+void serial_mm_connect(SerialMMState *self, enum device_endian end,
+                       MemoryRegion *address_space, qemu_irq irq)
+{
+    SerialState *s =3D SERIAL(self);
+
+    qdev_connect_gpio_out_named(DEVICE(self), "serial-irq", 0, irq);
+    memory_region_init_io(&s->io, NULL, &serial_mm_ops[end], self,
+                          "serial", 8 << self->regshift);
+    memory_region_add_subregion(address_space, s->base, &s->io);
+}
+
 SerialState *serial_mm_init(MemoryRegion *address_space,
                             hwaddr base, int regshift,
                             qemu_irq irq, int baudbase,
                             Chardev *chr, enum device_endian end)
 {
     DeviceState *dev =3D DEVICE(object_new(TYPE_SERIAL_MM));
-    SerialMMState *m =3D SERIAL_MM(dev);
-    SerialState *s =3D SERIAL(dev);
=20
-    qdev_connect_gpio_out_named(dev, "serial-irq", 0, irq);
     qdev_prop_set_uint32(dev, "baudbase", baudbase);
     qdev_prop_set_chr(dev, "chardev", chr);
     qdev_prop_set_uint8(dev, "regshift", regshift);
     qdev_prop_set_uint64(dev, "base", base);
     qdev_init_nofail(dev);
=20
-    memory_region_init_io(&s->io, NULL, &serial_mm_ops[end], s,
-                          "serial", 8 << m->regshift);
-    memory_region_add_subregion(address_space, base, &s->io);
+    serial_mm_connect(SERIAL_MM(dev), end, address_space, irq);
=20
-    return s;
+    return SERIAL(dev);
 }
=20
 static Property serial_mm_properties[] =3D {
diff --git a/include/hw/char/serial.h b/include/hw/char/serial.h
index 5e657d8ade..84ef8f01f0 100644
--- a/include/hw/char/serial.h
+++ b/include/hw/char/serial.h
@@ -104,6 +104,9 @@ SerialState *serial_mm_init(MemoryRegion *address_space=
,
                             qemu_irq irq, int baudbase,
                             Chardev *chr, enum device_endian end);
=20
+void serial_mm_connect(SerialMMState *self, enum device_endian end,
+                       MemoryRegion *address_space, qemu_irq irq);
+
 /* serial-isa.c */
=20
 #define MAX_ISA_SERIAL_PORTS 4
--=20
2.23.0.606.g08da6496b6


