Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C60F0C2D0E5
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 16:48:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9330F2072E
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 16:48:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gxuXeY4B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9330F2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIxaP-0006w4-Or
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 12:48:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52937)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jIxZQ-0005Zh-N1
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 12:47:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1jIxZP-0001pz-26
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 12:47:28 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:39538)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1jIxZO-0001nX-PN
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 12:47:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585586845;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=GH+HsEqN61hy6bX9z7Ta7fs1JcJhCfX13beqwU2GDME=;
 b=gxuXeY4Bg2uIFEP45qRNwlsLaB1lwG781YAR2Lst1hMe+J5ULBN8p/vt5jCLnJgxWT8I97
 Y00CqxgoCRQWNbl3pg+AFkOe0utEVavr7LDsI5wlLMGHcggwvvZPC9qh9dK9AcGp9zAEne
 WraAl7FOdccNrTDxsz/fuZfzZFwUuGg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-47-lAuvz1iaP9W89So6KMxsGw-1; Mon, 30 Mar 2020 12:47:21 -0400
X-MC-Unique: lAuvz1iaP9W89So6KMxsGw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BA36E149C7
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2020 16:47:20 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-114-162.ams2.redhat.com
 [10.36.114.162])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8D0E1100EBB3;
 Mon, 30 Mar 2020 16:47:14 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 mst@redhat.com
Subject: [PATCH] serial: Fix double migration data
Date: Mon, 30 Mar 2020 17:47:12 +0100
Message-Id: <20200330164712.198282-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

After c9808d60281 we have both an object representing the serial-isa
device and a separate object representing the underlying common serial
uart.  Both of these have vmsd's associated with them and thus the
migration stream ends up with two copies of the migration data - the
serial-isa includes the vmstate of the core serial.   Besides
being wrong, it breaks backwards migration compatibility.

Fix this by removing the dc->vmsd from the core device, so it only
gets migrated by any parent devices including it.
Add a vmstate_serial_mm so that any device that uses serial_mm_init
rather than creating a device still gets migrated.
(That doesn't fix backwards migration for serial_mm_init users,
but does seem to work forwards for ppce500).

Fixes: c9808d60281 ('serial: realize the serial device')
Buglink: https://bugs.launchpad.net/qemu/+bug/1869426
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hw/char/serial.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/hw/char/serial.c b/hw/char/serial.c
index 2ab8b69e03..c822a9ae6c 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -1043,7 +1043,6 @@ static void serial_class_init(ObjectClass *klass, voi=
d* data)
     dc->user_creatable =3D false;
     dc->realize =3D serial_realize;
     dc->unrealize =3D serial_unrealize;
-    dc->vmsd =3D &vmstate_serial;
     device_class_set_props(dc, serial_properties);
 }
=20
@@ -1113,6 +1112,16 @@ static void serial_mm_realize(DeviceState *dev, Erro=
r **errp)
     sysbus_init_irq(SYS_BUS_DEVICE(smm), &smm->serial.irq);
 }
=20
+static const VMStateDescription vmstate_serial_mm =3D {
+    .name =3D "serial",
+    .version_id =3D 3,
+    .minimum_version_id =3D 2,
+    .fields =3D (VMStateField[]) {
+        VMSTATE_STRUCT(serial, SerialMM, 0, vmstate_serial, SerialState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 SerialMM *serial_mm_init(MemoryRegion *address_space,
                          hwaddr base, int regshift,
                          qemu_irq irq, int baudbase,
@@ -1162,6 +1171,7 @@ static void serial_mm_class_init(ObjectClass *oc, voi=
d *data)
=20
     device_class_set_props(dc, serial_mm_properties);
     dc->realize =3D serial_mm_realize;
+    dc->vmsd =3D &vmstate_serial_mm;
 }
=20
 static const TypeInfo serial_mm_info =3D {
--=20
2.25.1


