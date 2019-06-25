Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB9B4C48BD6
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 23:25:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D96720645
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 23:25:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D96720645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35738 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfuoE-0002M1-It
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 19:25:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44513)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <marcandre.lureau@redhat.com>) id 1hfunI-0001mS-2H
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 19:24:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1hfunF-0007k7-Ti
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 19:24:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39036)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1hfunD-0007PP-Rz; Tue, 25 Jun 2019 19:24:05 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5A9D58666C;
 Tue, 25 Jun 2019 23:23:44 +0000 (UTC)
Received: from localhost (ovpn-112-17.ams2.redhat.com [10.36.112.17])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8D64D608C1;
 Tue, 25 Jun 2019 23:23:34 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 26 Jun 2019 01:23:33 +0200
Message-Id: <20190625232333.30752-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Tue, 25 Jun 2019 23:23:44 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] virtio-pci: fix missing device properties
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
Cc: lvivier@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-stable@nongnu.org, ehabkost@redhat.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since commit a4ee4c8baa37154 ("virtio: Helper for registering virtio
device types"), virtio-gpu-pci, virtio-vga, and virtio-crypto-pci lost
some properties: "ioeventfd" and "vectors". This may cause various
issues, such as failing migration or invalid properties.

Since those VirtioPCI devices do not have a base name, their class are
initialized with virtio_pci_generic_base_class_init(). However, if the
VirtioPCIDeviceTypeInfo provided a class_init which sets dc->props,
the properties were overwritten by virtio_pci_generic_class_init().

Instead, introduce an intermediary base-type to register the generic
properties.

Fixes: a4ee4c8baa37154f42b4dc6a13fee79268d15238
Cc: qemu-stable@nongnu.org
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/virtio/virtio-pci.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index e6d5467e54..62c4977332 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1913,13 +1913,6 @@ static void virtio_pci_generic_class_init(ObjectCl=
ass *klass, void *data)
     dc->props =3D virtio_pci_generic_properties;
 }
=20
-/* Used when the generic type and the base type is the same */
-static void virtio_pci_generic_base_class_init(ObjectClass *klass, void =
*data)
-{
-    virtio_pci_base_class_init(klass, data);
-    virtio_pci_generic_class_init(klass, NULL);
-}
-
 static void virtio_pci_transitional_instance_init(Object *obj)
 {
     VirtIOPCIProxy *proxy =3D VIRTIO_PCI(obj);
@@ -1938,14 +1931,13 @@ static void virtio_pci_non_transitional_instance_=
init(Object *obj)
=20
 void virtio_pci_types_register(const VirtioPCIDeviceTypeInfo *t)
 {
+    char *base_name =3D NULL;
     TypeInfo base_type_info =3D {
         .name          =3D t->base_name,
         .parent        =3D t->parent ? t->parent : TYPE_VIRTIO_PCI,
         .instance_size =3D t->instance_size,
         .instance_init =3D t->instance_init,
         .class_size    =3D t->class_size,
-        .class_init    =3D virtio_pci_base_class_init,
-        .class_data    =3D (void *)t,
         .abstract      =3D true,
     };
     TypeInfo generic_type_info =3D {
@@ -1961,13 +1953,20 @@ void virtio_pci_types_register(const VirtioPCIDev=
iceTypeInfo *t)
=20
     if (!base_type_info.name) {
         /* No base type -> register a single generic device type */
-        base_type_info.name =3D t->generic_name;
-        base_type_info.class_init =3D virtio_pci_generic_base_class_init=
;
-        base_type_info.interfaces =3D generic_type_info.interfaces;
-        base_type_info.abstract =3D false;
-        generic_type_info.name =3D NULL;
+        /* use intermediate %s-base-type to add generic device props */
+        base_name =3D g_strdup_printf("%s-base-type", t->generic_name);
+        base_type_info.name =3D base_name;
+        base_type_info.class_init =3D virtio_pci_generic_class_init;
+
+        generic_type_info.parent =3D base_name;
+        generic_type_info.class_init =3D virtio_pci_base_class_init;
+        generic_type_info.class_data =3D (void *)t;
+
         assert(!t->non_transitional_name);
         assert(!t->transitional_name);
+    } else {
+        base_type_info.class_init =3D virtio_pci_base_class_init;
+        base_type_info.class_data =3D (void *)t;
     }
=20
     type_register(&base_type_info);
@@ -2005,6 +2004,7 @@ void virtio_pci_types_register(const VirtioPCIDevic=
eTypeInfo *t)
         };
         type_register(&transitional_type_info);
     }
+    g_free(base_name);
 }
=20
 /* virtio-pci-bus */
--=20
2.22.0.rc2.384.g1a9a72ea1d


