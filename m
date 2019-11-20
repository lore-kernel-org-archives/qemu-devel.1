Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F25EC432C3
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 15:36:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF81E206B6
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 15:36:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PxV6yer2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF81E206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXS1h-00036E-Ch
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 10:36:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34190)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iXRs6-0008Gk-E2
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 10:26:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iXRs5-0007DN-9Q
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 10:26:22 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20238
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1iXRs5-0007DH-5W
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 10:26:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574263580;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k7tsKAjQaYQy+4EmO0PxMNIAK2KLeclCEDRvDbEHUA4=;
 b=PxV6yer2AChbxaLGu6l2ZP+ROtn3WwQPa6LDcssWCfV1UPyIuDPJPifTMuvavOwA3l6/mb
 GLpwlcqlvb1kA9lMPjWJZdgNlAHINgSEhOpVF82oGpW1PRH/OUy/D4Amm+rzuYoWaPbrId
 0R3shFhzoojWC9GZzltD3lguAb/yL7w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-tJdQsuFuPV-ugFC7tF-Tzg-1; Wed, 20 Nov 2019 10:26:19 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1F05FDBAB;
 Wed, 20 Nov 2019 15:26:18 +0000 (UTC)
Received: from localhost (ovpn-112-56.ams2.redhat.com [10.36.112.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CB21660499;
 Wed, 20 Nov 2019 15:26:10 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 08/37] serial: add "chardev" property
Date: Wed, 20 Nov 2019 19:24:13 +0400
Message-Id: <20191120152442.26657-9-marcandre.lureau@redhat.com>
In-Reply-To: <20191120152442.26657-1-marcandre.lureau@redhat.com>
References: <20191120152442.26657-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: tJdQsuFuPV-ugFC7tF-Tzg-1
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

This is more QOM-friendly, callers may set/get the property themself.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/char/serial.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/hw/char/serial.c b/hw/char/serial.c
index 0c7b9ae45a..83417cb8c4 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -34,6 +34,7 @@
 #include "sysemu/runstate.h"
 #include "qemu/error-report.h"
 #include "trace.h"
+#include "hw/qdev-properties.h"
=20
 //#define DEBUG_SERIAL
=20
@@ -988,7 +989,7 @@ SerialState *serial_init(int base, qemu_irq irq, int ba=
udbase,
=20
     s->irq =3D irq;
     s->baudbase =3D baudbase;
-    qemu_chr_fe_init(&s->chr, chr, &error_abort);
+    qdev_prop_set_chr(dev, "chardev", chr);
     serial_realize_core(s, &error_fatal);
     qdev_set_legacy_instance_id(dev, base, 2);
     qdev_init_nofail(dev);
@@ -999,12 +1000,18 @@ SerialState *serial_init(int base, qemu_irq irq, int=
 baudbase,
     return s;
 }
=20
-static void serial_class_init(ObjectClass *klass, void *data)
+static Property serial_properties[] =3D {
+    DEFINE_PROP_CHR("chardev", SerialState, chr),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void serial_class_init(ObjectClass *klass, void* data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
=20
     dc->user_creatable =3D false;
     dc->vmsd =3D &vmstate_serial;
+    dc->props =3D serial_properties;
 }
=20
 static const TypeInfo serial_info =3D {
@@ -1065,7 +1072,7 @@ SerialState *serial_mm_init(MemoryRegion *address_spa=
ce,
     s->it_shift =3D it_shift;
     s->irq =3D irq;
     s->baudbase =3D baudbase;
-    qemu_chr_fe_init(&s->chr, chr, &error_abort);
+    qdev_prop_set_chr(dev, "chardev", chr);
=20
     serial_realize_core(s, &error_fatal);
     qdev_set_legacy_instance_id(dev, base, 2);
--=20
2.24.0


