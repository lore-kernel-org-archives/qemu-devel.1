Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA293C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 13:55:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B71F7218AC
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 13:55:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hJp/a5tU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B71F7218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiIki-0000Aa-Qj
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 08:55:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60101)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iiIca-0003I4-CG
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 08:47:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iiIcY-0006lg-Qt
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 08:47:12 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54727
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1iiIcY-0006kM-IT
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 08:47:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576849629;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9PQoHRH13/SC8yXSoSVhEmwn/sgJvGoh4IdGtcXaSlA=;
 b=hJp/a5tUmeJPSRUAi0XZMmiisK7zVrFz6RyVlH6QYCvWPBlL8WLjaUDTbpKZruoA0ck1aq
 Nk+PbrRwNywcgTjiHm2rwu7j87PGZ6XxUeue1FU8avpL8AmGCaWqI3OrQojEyv3IiW854Y
 AQSQGS3WuKPnXm9xviUn2eRdMQfB0LI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-287-NVhIv37BMFOgVIoBsG0N6g-1; Fri, 20 Dec 2019 08:47:07 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D225E107ACE6;
 Fri, 20 Dec 2019 13:47:06 +0000 (UTC)
Received: from localhost (ovpn-112-54.ams2.redhat.com [10.36.112.54])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D0FB46046B;
 Fri, 20 Dec 2019 13:47:04 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 07/37] serial: register vmsd with DeviceClass
Date: Fri, 20 Dec 2019 17:45:31 +0400
Message-Id: <20191220134601.571905-8-marcandre.lureau@redhat.com>
In-Reply-To: <20191220134601.571905-1-marcandre.lureau@redhat.com>
References: <20191220134601.571905-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: NVhIv37BMFOgVIoBsG0N6g-1
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Migration from old to new code works, however the other way fails for
devices that use serial_init/serial_mm_init with "base", used as
instance_id previously.

(with qdev_set_legacy_instance_id, the alias_id is only used in
savevm.c:find_se(), and thus can only be used to match against
"legacy" instance id values. On new code, instance_id is generated
incrementally from 0 with calculate_new_instance_id(), based on
"qdev-path/vmsd-name")

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/char/serial.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/char/serial.c b/hw/char/serial.c
index 233a9e2076..e926845843 100644
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
@@ -1006,6 +1005,7 @@ static void serial_class_init(ObjectClass *klass, voi=
d *data)
=20
     /* internal device for serialio/serialmm, not user-creatable */
     dc->user_creatable =3D false;
+    dc->vmsd =3D &vmstate_serial;
 }
=20
 static const TypeInfo serial_info =3D {
@@ -1069,7 +1069,7 @@ SerialState *serial_mm_init(MemoryRegion *address_spa=
ce,
     qemu_chr_fe_init(&s->chr, chr, &error_abort);
=20
     serial_realize_core(s, &error_fatal);
-    vmstate_register(NULL, base, &vmstate_serial, s);
+    qdev_set_legacy_instance_id(dev, base, 2);
     qdev_init_nofail(dev);
=20
     memory_region_init_io(&s->io, NULL, &serial_mm_ops[end], s,
--=20
2.24.0.308.g228f53135a


