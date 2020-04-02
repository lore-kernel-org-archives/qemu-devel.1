Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB69C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 19:10:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3377720719
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 19:10:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aq6rg2K3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3377720719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jK5Ef-0000OI-9Z
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 15:10:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33940)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jK5B4-0002b0-BF
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 15:06:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jK5B2-0000Ud-Vk
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 15:06:58 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:41368
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jK5B2-0000RD-Ra
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 15:06:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585854415;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UayyH5L3cRZEe5aAN8X8vb46906NYlR3VbPuC43zOEs=;
 b=aq6rg2K3vqBTi9SthiyY2KM9tgonnyH3mSwxTMPRJuihSERAFaaygQWipyLP9ACnkfAwE6
 agHSyGSlxGjU6vYg9/oqMKvlNSi0IIlh6u/Q5EZYyLdRjDRJ1Qa1fa3kdKxH3z8hXQgR2d
 z8qEsu8QwZ7GvnXZjUVHUW4k9AErf2c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-507-qwJMkc0FOAWN9nWfuiXXCw-1; Thu, 02 Apr 2020 15:06:51 -0400
X-MC-Unique: qwJMkc0FOAWN9nWfuiXXCw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6A6F5100550D
 for <qemu-devel@nongnu.org>; Thu,  2 Apr 2020 19:06:50 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0D07750BEE;
 Thu,  2 Apr 2020 19:06:49 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 10/15] serial: Fix double migration data
Date: Thu,  2 Apr 2020 15:06:35 -0400
Message-Id: <20200402190640.1693-11-pbonzini@redhat.com>
In-Reply-To: <20200402190640.1693-1-pbonzini@redhat.com>
References: <20200402190640.1693-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
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
Message-Id: <20200330164712.198282-1-dgilbert@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
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
2.18.2



