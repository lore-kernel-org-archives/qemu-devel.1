Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A891C4725A
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 15:44:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC38F206FA
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 15:44:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b/sOZKrV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC38F206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVzjn-000475-Ud
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 11:44:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46016)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jVzVs-0003Ql-SJ
 for qemu-devel@nongnu.org; Tue, 05 May 2020 11:29:40 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:35087
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jVzVo-0007TE-AR
 for qemu-devel@nongnu.org; Tue, 05 May 2020 11:29:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588692575;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U8xOOlXSApfWeIfbfA93BiP5xHl4aV/joyRqnXcAhfM=;
 b=b/sOZKrVZZPL3eOofSzc367K2mQR1cJI4CxRqavrKeHcAHkF59hc8z1Tjzx6r5YO1xbKfS
 2yWjMej1S/kxS0BlJVT0JVrI1X71D8Eek/JtD++uNgp63yRyvq8EMgPstbnHftPMU3ssZw
 DiPIYlpgsLTRrFEDbO+r2sOnwtRI4U8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387--cD-XD60Nuer5eqMfb-Qyg-1; Tue, 05 May 2020 11:29:33 -0400
X-MC-Unique: -cD-XD60Nuer5eqMfb-Qyg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3334B835B40
 for <qemu-devel@nongnu.org>; Tue,  5 May 2020 15:29:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3CF975C1B2;
 Tue,  5 May 2020 15:29:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4EF7711358C6; Tue,  5 May 2020 17:29:26 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 10/18] hw/isa/superio: Make the components QOM children
Date: Tue,  5 May 2020 17:29:18 +0200
Message-Id: <20200505152926.18877-11-armbru@redhat.com>
In-Reply-To: <20200505152926.18877-1-armbru@redhat.com>
References: <20200505152926.18877-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 00:37:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: berrange@redhat.com, ehabkost@redhat.com,
 "Michael S . Tsirkin" <mst@redhat.com>, philmd@redhat.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

isa_superio_realize() attempts to make isa-parallel and isa-serial QOM
children, but this does not work, because it calls
object_property_add_child() after realizing with qdev_init_nofail().
Realizing a device without a parent gives it one: it gets put into the
"/machine/unattached/" orphanage.  The extra
object_property_add_child() fails, and isa_superio_realize() ignores
the error.

Move the object_property_add_child() before qdev_init_nofail(), and
pass &error_abort.

For the other components, isa_superio_realize() doesn't even try.  Add
object_property_add_child() there.

This affects machines 40p, clipper and fulong2e.

For instance, fulong2e has its vt82c686b-superio (which is an
isa-superio) at /machine/unattached/device[9].  Before the patch, its
components are at /machine/unattached/device[10] .. [14].  Afterwards,
they are at
/machine/unattached/device[9]/{parallel0,serial0,serial1,isa-fdc,i8042}.

Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/isa/isa-superio.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/hw/isa/isa-superio.c b/hw/isa/isa-superio.c
index 180a8b9625..0d9d848280 100644
--- a/hw/isa/isa-superio.c
+++ b/hw/isa/isa-superio.c
@@ -62,6 +62,8 @@ static void isa_superio_realize(DeviceState *dev, Error *=
*errp)
                 qdev_prop_set_uint32(d, "irq", k->parallel.get_irq(sio, i)=
);
             }
             qdev_prop_set_chr(d, "chardev", chr);
+            object_property_add_child(OBJECT(sio), name, OBJECT(isa),
+                                      &error_abort);
             qdev_init_nofail(d);
             sio->parallel[i] =3D isa;
             trace_superio_create_parallel(i,
@@ -69,8 +71,6 @@ static void isa_superio_realize(DeviceState *dev, Error *=
*errp)
                                           k->parallel.get_iobase(sio, i) :=
 -1,
                                           k->parallel.get_irq ?
                                           k->parallel.get_irq(sio, i) : -1=
);
-            object_property_add_child(OBJECT(dev), name,
-                                      OBJECT(sio->parallel[i]), NULL);
             g_free(name);
         }
     }
@@ -102,6 +102,8 @@ static void isa_superio_realize(DeviceState *dev, Error=
 **errp)
                 qdev_prop_set_uint32(d, "irq", k->serial.get_irq(sio, i));
             }
             qdev_prop_set_chr(d, "chardev", chr);
+            object_property_add_child(OBJECT(sio), name, OBJECT(isa),
+                                      &error_abort);
             qdev_init_nofail(d);
             sio->serial[i] =3D isa;
             trace_superio_create_serial(i,
@@ -109,8 +111,6 @@ static void isa_superio_realize(DeviceState *dev, Error=
 **errp)
                                         k->serial.get_iobase(sio, i) : -1,
                                         k->serial.get_irq ?
                                         k->serial.get_irq(sio, i) : -1);
-            object_property_add_child(OBJECT(dev), name,
-                                      OBJECT(sio->serial[0]), NULL);
             g_free(name);
         }
     }
@@ -137,6 +137,8 @@ static void isa_superio_realize(DeviceState *dev, Error=
 **errp)
             qdev_prop_set_drive(d, "driveB", blk_by_legacy_dinfo(drive),
                                 &error_fatal);
         }
+        object_property_add_child(OBJECT(sio), "isa-fdc", OBJECT(isa),
+                                  &error_abort);
         qdev_init_nofail(d);
         sio->floppy =3D isa;
         trace_superio_create_floppy(0,
@@ -147,7 +149,11 @@ static void isa_superio_realize(DeviceState *dev, Erro=
r **errp)
     }
=20
     /* Keyboard, mouse */
-    sio->kbc =3D isa_create_simple(bus, TYPE_I8042);
+    isa =3D isa_create(bus, TYPE_I8042);
+    object_property_add_child(OBJECT(sio), TYPE_I8042, OBJECT(isa),
+                              &error_abort);
+    qdev_init_nofail(DEVICE(isa));
+    sio->kbc =3D isa;
=20
     /* IDE */
     if (k->ide.count && (!k->ide.is_enabled || k->ide.is_enabled(sio, 0)))=
 {
@@ -163,6 +169,8 @@ static void isa_superio_realize(DeviceState *dev, Error=
 **errp)
             qdev_prop_set_uint32(d, "irq", k->ide.get_irq(sio, 0));
         }
         qdev_init_nofail(d);
+        object_property_add_child(OBJECT(sio), "isa-ide", OBJECT(isa),
+                                  &error_abort);
         sio->ide =3D isa;
         trace_superio_create_ide(0,
                                  k->ide.get_iobase ?
--=20
2.21.1


