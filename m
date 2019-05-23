Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B47A4C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 16:09:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BB1B2175B
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 16:09:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BB1B2175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40008 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTqHu-0002ij-Mv
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 12:09:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hTqAb-0004mM-0C
	for qemu-devel@nongnu.org; Thu, 23 May 2019 12:02:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hTqAZ-0002L2-8p
	for qemu-devel@nongnu.org; Thu, 23 May 2019 12:02:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47930)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hTqAV-0001jp-Cz; Thu, 23 May 2019 12:02:11 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4B3D69FFC8;
	Thu, 23 May 2019 16:01:23 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-116-143.ams2.redhat.com
	[10.36.116.143])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 39DF0100200D;
	Thu, 23 May 2019 16:01:22 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Thu, 23 May 2019 18:00:53 +0200
Message-Id: <20190523160104.21258-5-kwolf@redhat.com>
In-Reply-To: <20190523160104.21258-1-kwolf@redhat.com>
References: <20190523160104.21258-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.39]);
	Thu, 23 May 2019 16:01:23 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 04/15] block: Add qdev_prop_drive_iothread
 property type
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Some qdev block devices have support for iothreads and take care of the
AioContext they are running in, but most devices don't know about any of
this. For the latter category, the qdev drive property must make sure
that their BlockBackend is in the main AioContext.

Unfortunately, while the current code just does the same thing for
devices that do support iothreads, this is not correct and it would show
as soon as we actually try to keep a consistent AioContext assignment
across all nodes and users of a block graph subtree: If a node is
already in a non-default AioContext because of one of its users,
attaching a new device should still be possible if that device can work
in the same AioContext. Switching the node back to the main context
first and only then into the device AioContext causes failure (because
the existing user wouldn't allow the switch to the main context).

So devices that support iothreads need a different kind of drive
property that leaves the node in its current AioContext, but by using
this type, the device promises to check later that it can work with this
context.

This patch adds the qdev infrastructure that allows devices to signal
that they handle iothreads and qdev should leave the AioContext alone.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/hw/block/block.h         |  7 ++++--
 include/hw/qdev-properties.h     |  3 +++
 hw/core/qdev-properties-system.c | 43 ++++++++++++++++++++++++++++----
 3 files changed, 46 insertions(+), 7 deletions(-)

diff --git a/include/hw/block/block.h b/include/hw/block/block.h
index d06f25aa0f..607539057a 100644
--- a/include/hw/block/block.h
+++ b/include/hw/block/block.h
@@ -45,8 +45,7 @@ static inline unsigned int get_physical_block_exp(Block=
Conf *conf)
     return exp;
 }
=20
-#define DEFINE_BLOCK_PROPERTIES(_state, _conf)                          =
\
-    DEFINE_PROP_DRIVE("drive", _state, _conf.blk),                      =
\
+#define DEFINE_BLOCK_PROPERTIES_BASE(_state, _conf)                     =
\
     DEFINE_PROP_BLOCKSIZE("logical_block_size", _state,                 =
\
                           _conf.logical_block_size),                    =
\
     DEFINE_PROP_BLOCKSIZE("physical_block_size", _state,                =
\
@@ -59,6 +58,10 @@ static inline unsigned int get_physical_block_exp(Bloc=
kConf *conf)
                             ON_OFF_AUTO_AUTO), \
     DEFINE_PROP_BOOL("share-rw", _state, _conf.share_rw, false)
=20
+#define DEFINE_BLOCK_PROPERTIES(_state, _conf)                          =
\
+    DEFINE_PROP_DRIVE("drive", _state, _conf.blk),                      =
\
+    DEFINE_BLOCK_PROPERTIES_BASE(_state, _conf)
+
 #define DEFINE_BLOCK_CHS_PROPERTIES(_state, _conf)      \
     DEFINE_PROP_UINT32("cyls", _state, _conf.cyls, 0),  \
     DEFINE_PROP_UINT32("heads", _state, _conf.heads, 0), \
diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index b6758c852e..1eae5ab056 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -28,6 +28,7 @@ extern const PropertyInfo qdev_prop_blockdev_on_error;
 extern const PropertyInfo qdev_prop_bios_chs_trans;
 extern const PropertyInfo qdev_prop_fdc_drive_type;
 extern const PropertyInfo qdev_prop_drive;
+extern const PropertyInfo qdev_prop_drive_iothread;
 extern const PropertyInfo qdev_prop_netdev;
 extern const PropertyInfo qdev_prop_pci_devfn;
 extern const PropertyInfo qdev_prop_blocksize;
@@ -198,6 +199,8 @@ extern const PropertyInfo qdev_prop_pcie_link_width;
     DEFINE_PROP(_n, _s, _f, qdev_prop_netdev, NICPeers)
 #define DEFINE_PROP_DRIVE(_n, _s, _f) \
     DEFINE_PROP(_n, _s, _f, qdev_prop_drive, BlockBackend *)
+#define DEFINE_PROP_DRIVE_IOTHREAD(_n, _s, _f) \
+    DEFINE_PROP(_n, _s, _f, qdev_prop_drive_iothread, BlockBackend *)
 #define DEFINE_PROP_MACADDR(_n, _s, _f)         \
     DEFINE_PROP(_n, _s, _f, qdev_prop_macaddr, MACAddr)
 #define DEFINE_PROP_ON_OFF_AUTO(_n, _s, _f, _d) \
diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-s=
ystem.c
index 42e048f190..ba412dd2ca 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -69,8 +69,8 @@ static void set_pointer(Object *obj, Visitor *v, Proper=
ty *prop,
=20
 /* --- drive --- */
=20
-static void parse_drive(DeviceState *dev, const char *str, void **ptr,
-                        const char *propname, Error **errp)
+static void do_parse_drive(DeviceState *dev, const char *str, void **ptr=
,
+                           const char *propname, bool iothread, Error **=
errp)
 {
     BlockBackend *blk;
     bool blk_created =3D false;
@@ -80,9 +80,16 @@ static void parse_drive(DeviceState *dev, const char *=
str, void **ptr,
     if (!blk) {
         BlockDriverState *bs =3D bdrv_lookup_bs(NULL, str, NULL);
         if (bs) {
-            /* BlockBackends of devices start in the main context and ar=
e only
-             * later moved into another context if the device supports t=
hat. */
-            blk =3D blk_new(qemu_get_aio_context(), 0, BLK_PERM_ALL);
+            /*
+             * If the device supports iothreads, it will make sure to mo=
ve the
+             * block node to the right AioContext if necessary (or fail =
if this
+             * isn't possible because of other users). Devices that are =
not
+             * aware of iothreads require their BlockBackends to be in t=
he main
+             * AioContext.
+             */
+            AioContext *ctx =3D iothread ? bdrv_get_aio_context(bs) :
+                                         qemu_get_aio_context();
+            blk =3D blk_new(ctx, 0, BLK_PERM_ALL);
             blk_created =3D true;
=20
             ret =3D blk_insert_bs(blk, bs, errp);
@@ -120,6 +127,18 @@ fail:
     }
 }
=20
+static void parse_drive(DeviceState *dev, const char *str, void **ptr,
+                        const char *propname, Error **errp)
+{
+    do_parse_drive(dev, str, ptr, propname, false, errp);
+}
+
+static void parse_drive_iothread(DeviceState *dev, const char *str, void=
 **ptr,
+                                 const char *propname, Error **errp)
+{
+    do_parse_drive(dev, str, ptr, propname, true, errp);
+}
+
 static void release_drive(Object *obj, const char *name, void *opaque)
 {
     DeviceState *dev =3D DEVICE(obj);
@@ -162,6 +181,12 @@ static void set_drive(Object *obj, Visitor *v, const=
 char *name, void *opaque,
     set_pointer(obj, v, opaque, parse_drive, name, errp);
 }
=20
+static void set_drive_iothread(Object *obj, Visitor *v, const char *name=
,
+                               void *opaque, Error **errp)
+{
+    set_pointer(obj, v, opaque, parse_drive_iothread, name, errp);
+}
+
 const PropertyInfo qdev_prop_drive =3D {
     .name  =3D "str",
     .description =3D "Node name or ID of a block device to use as a back=
end",
@@ -170,6 +195,14 @@ const PropertyInfo qdev_prop_drive =3D {
     .release =3D release_drive,
 };
=20
+const PropertyInfo qdev_prop_drive_iothread =3D {
+    .name  =3D "str",
+    .description =3D "Node name or ID of a block device to use as a back=
end",
+    .get   =3D get_drive,
+    .set   =3D set_drive_iothread,
+    .release =3D release_drive,
+};
+
 /* --- character device --- */
=20
 static void get_chr(Object *obj, Visitor *v, const char *name, void *opa=
que,
--=20
2.20.1


