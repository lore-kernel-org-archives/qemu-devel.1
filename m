Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9257CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 16:27:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73DE52084B
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 16:27:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HiY7U5Qa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73DE52084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMx0N-00043z-1i
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 12:27:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37988)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iMwvd-0006cX-2C
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 12:22:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iMwvb-0007Cw-Uj
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 12:22:36 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:34567
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1iMwvb-0007Cb-QD
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 12:22:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571761355;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GaTurT3upL4y8fIu0BrHJ2JN2Wz8zzAEzAZLgqvUav4=;
 b=HiY7U5Qa4tr6YWxTv/drnp7SBdX62I5SMqPf2heU5SiLmpWD11iw57ULXfNtFIUJfGC+Bf
 ieI671RLrEmU9piGxuRGrSVWQ3AyXoVBxcXsgHP+g+DkHlh4ojf2JdBn/cBhGFhselQ5ol
 RjkTpeCnngZ2CqwSP+1qQ6/N6begIk8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-76-5hrajvAMMzeBP4eaAWG4Ng-1; Tue, 22 Oct 2019 12:22:33 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0B70E800D49;
 Tue, 22 Oct 2019 16:22:26 +0000 (UTC)
Received: from localhost (ovpn-112-21.ams2.redhat.com [10.36.112.21])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B46BB19C4F;
 Tue, 22 Oct 2019 16:22:20 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 04/28] serial: register vmsd with DeviceClass
Date: Tue, 22 Oct 2019 18:21:13 +0200
Message-Id: <20191022162137.27161-5-marcandre.lureau@redhat.com>
In-Reply-To: <20191022162137.27161-1-marcandre.lureau@redhat.com>
References: <20191022162137.27161-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 5hrajvAMMzeBP4eaAWG4Ng-1
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

QOM-ify further.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/char/serial.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/char/serial.c b/hw/char/serial.c
index fb0dd98103..143e39c1b1 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -990,8 +990,7 @@ SerialState *serial_init(int base, qemu_irq irq, int ba=
udbase,
     s->baudbase =3D baudbase;
     qemu_chr_fe_init(&s->chr, chr, &error_abort);
     serial_realize_core(s, &error_fatal);
-
-    vmstate_register(NULL, base, &vmstate_serial, s);
+    qdev_set_legacy_instance_id(dev, base, 2);
     qdev_init_nofail(dev);
=20
     memory_region_init_io(&s->io, NULL, &serial_io_ops, s, "serial", 8);
@@ -1005,6 +1004,7 @@ static void serial_class_init(ObjectClass *klass, voi=
d* data)
     DeviceClass *dc =3D DEVICE_CLASS(klass);
=20
     dc->user_creatable =3D false;
+    dc->vmsd =3D &vmstate_serial;
 }
=20
 static const TypeInfo serial_info =3D {
@@ -1068,7 +1068,7 @@ SerialState *serial_mm_init(MemoryRegion *address_spa=
ce,
     qemu_chr_fe_init(&s->chr, chr, &error_abort);
=20
     serial_realize_core(s, &error_fatal);
-    vmstate_register(NULL, base, &vmstate_serial, s);
+    qdev_set_legacy_instance_id(DEVICE(s), base, 2);
     qdev_init_nofail(dev);
=20
     memory_region_init_io(&s->io, NULL, &serial_mm_ops[end], s,
--=20
2.23.0.606.g08da6496b6


