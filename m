Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF62BCA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 16:30:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DC3D20B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 16:30:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ywk8CDKq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DC3D20B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMx3L-0008BF-Ap
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 12:30:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38253)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iMwwE-0007Dc-22
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 12:23:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iMwwC-0007PT-Li
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 12:23:13 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27156
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1iMwwC-0007Ow-I2
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 12:23:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571761392;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=89Zo2A2N2T1L7Eo/D/HcuXY8WnhlbrmU/BS7ldbzPes=;
 b=Ywk8CDKqYiwfv6HfD1ddxcJzHsMCu6YD+Hcaz71PbvMFlGe5IcwArUl97XO1FJw82zZdzb
 jiR+TonxQFWLkcCkb3ZLn6SrEjGVXFigKNhACyrJ3zqSTZRPZtk0EIYwRpR/nL4oF0XNf8
 +bCyzQynYiMWDVhhOJALUOMX7Pu81To=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-VjPIc05rNO2t1yDblpAyQg-1; Tue, 22 Oct 2019 12:23:08 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DBE89107AD31;
 Tue, 22 Oct 2019 16:23:02 +0000 (UTC)
Received: from localhost (ovpn-112-21.ams2.redhat.com [10.36.112.21])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3FA1D5DC18;
 Tue, 22 Oct 2019 16:22:57 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 09/28] serial: add "baudbase" property
Date: Tue, 22 Oct 2019 18:21:18 +0200
Message-Id: <20191022162137.27161-10-marcandre.lureau@redhat.com>
In-Reply-To: <20191022162137.27161-1-marcandre.lureau@redhat.com>
References: <20191022162137.27161-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: VjPIc05rNO2t1yDblpAyQg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/char/serial.c         | 5 +++--
 include/hw/char/serial.h | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/char/serial.c b/hw/char/serial.c
index 7bc7c4370b..0ae52ec60c 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -988,7 +988,7 @@ SerialState *serial_init(int base, qemu_irq irq, int ba=
udbase,
     SerialState *s =3D SERIAL(dev);
=20
     qdev_connect_gpio_out_named(dev, "serial-irq", 0, irq);
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
@@ -1079,7 +1080,7 @@ SerialState *serial_mm_init(MemoryRegion *address_spa=
ce,
     SerialState *s =3D SERIAL(dev);
=20
     qdev_connect_gpio_out_named(dev, "serial-irq", 0, irq);
-    s->baudbase =3D baudbase;
+    qdev_prop_set_uint32(dev, "baudbase", baudbase);
     qdev_prop_set_chr(dev, "chardev", chr);
     qdev_prop_set_uint8(dev, "regshift", regshift);
=20
diff --git a/include/hw/char/serial.h b/include/hw/char/serial.h
index 613879ced8..ecbd3f1b40 100644
--- a/include/hw/char/serial.h
+++ b/include/hw/char/serial.h
@@ -57,7 +57,7 @@ typedef struct SerialState {
     qemu_irq irq;
     CharBackend chr;
     int last_break_enable;
-    int baudbase;
+    uint32_t baudbase;
     uint32_t tsr_retry;
     guint watch_tag;
     uint32_t wakeup;
--=20
2.23.0.606.g08da6496b6


