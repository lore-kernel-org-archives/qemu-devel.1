Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2EC1C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 06:53:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6834206F8
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 06:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="uwClgTgX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6834206F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHMO9-00035u-O9
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 02:53:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52659)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <rvkagan@yandex-team.ru>) id 1jHMNY-0002bN-Bx
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 02:52:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rvkagan@yandex-team.ru>) id 1jHMNX-0004e7-4B
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 02:52:36 -0400
Received: from forwardcorp1j.mail.yandex.net ([2a02:6b8:0:1619::183]:36572)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <rvkagan@yandex-team.ru>)
 id 1jHMNR-0004Sj-1X; Thu, 26 Mar 2020 02:52:29 -0400
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net
 [IPv6:2a02:6b8:0:1619::162])
 by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 5E7A62E1578;
 Thu, 26 Mar 2020 09:52:23 +0300 (MSK)
Received: from myt4-18a966dbd9be.qloud-c.yandex.net
 (myt4-18a966dbd9be.qloud-c.yandex.net [2a02:6b8:c00:12ad:0:640:18a9:66db])
 by mxbackcorp1j.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id
 lJhXDVmP9y-qM54oRkN; Thu, 26 Mar 2020 09:52:23 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1585205543; bh=jWOcllMaGULgexMQwj30L5GAXwCNkVdQlQuQkNB7RQU=;
 h=Message-Id:Date:Subject:To:From:Cc;
 b=uwClgTgXKiyvYJpnIZuB2bsAxyRwUVHiGv47EBh4qqnKtyGYPgDpr2LmdKcngsFCT
 oG/EpDKzmacS7OGI+GO7d2TgGZ36GoeqbM9X+7XmlZt5TpLZl7VAE/DgpoDfD9VZbs
 zGy1XMfZb7G79cZbJnlkv9X0GvdfYSQRkYHwnXPY=
Authentication-Results: mxbackcorp1j.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from unknown (unknown [2a02:6b8:b080:7202::1:9])
 by myt4-18a966dbd9be.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 cObCXjccKf-qMc4mPeF; Thu, 26 Mar 2020 09:52:22 +0300
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (Client certificate not present)
From: Roman Kagan <rvkagan@yandex-team.ru>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] block: make BlockConf.*_size properties 32-bit
Date: Thu, 26 Mar 2020 09:52:17 +0300
Message-Id: <20200326065217.1626748-1-rvkagan@yandex-team.ru>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a02:6b8:0:1619::183
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Devices (virtio-blk, scsi, etc.) and the block layer are happy to use
32-bit for logical_block_size, physical_block_size, and min_io_size.
However, the properties in BlockConf are defined as uint16_t limiting
the values to 32768.

This appears unnecessary tight, and we've seen bigger block sizes handy
at times.

Make them 32 bit instead and lift the limitation up to 2 MiB which
appears to be good enough for everybody.

As the values can now be fairly big and awkward to type, make the
property setter accept common size suffixes (k, m).

Signed-off-by: Roman Kagan <rvkagan@yandex-team.ru>
---
v1 -> v2:
- cap the property at 2 MiB [Eric]
- accept size suffixes

 include/hw/block/block.h     |  8 ++++----
 include/hw/qdev-properties.h |  2 +-
 hw/core/qdev-properties.c    | 31 +++++++++++++++++++++----------
 3 files changed, 26 insertions(+), 15 deletions(-)

diff --git a/include/hw/block/block.h b/include/hw/block/block.h
index d7246f3862..9dd6bba56a 100644
--- a/include/hw/block/block.h
+++ b/include/hw/block/block.h
@@ -18,9 +18,9 @@
=20
 typedef struct BlockConf {
     BlockBackend *blk;
-    uint16_t physical_block_size;
-    uint16_t logical_block_size;
-    uint16_t min_io_size;
+    uint32_t physical_block_size;
+    uint32_t logical_block_size;
+    uint32_t min_io_size;
     uint32_t opt_io_size;
     int32_t bootindex;
     uint32_t discard_granularity;
@@ -51,7 +51,7 @@ static inline unsigned int get_physical_block_exp(Block=
Conf *conf)
                           _conf.logical_block_size),                    =
\
     DEFINE_PROP_BLOCKSIZE("physical_block_size", _state,                =
\
                           _conf.physical_block_size),                   =
\
-    DEFINE_PROP_UINT16("min_io_size", _state, _conf.min_io_size, 0),    =
\
+    DEFINE_PROP_UINT32("min_io_size", _state, _conf.min_io_size, 0),    =
\
     DEFINE_PROP_UINT32("opt_io_size", _state, _conf.opt_io_size, 0),    =
\
     DEFINE_PROP_UINT32("discard_granularity", _state,                   =
\
                        _conf.discard_granularity, -1),                  =
\
diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index f161604fb6..f9e0f8c041 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -197,7 +197,7 @@ extern const PropertyInfo qdev_prop_pcie_link_width;
 #define DEFINE_PROP_BIOS_CHS_TRANS(_n, _s, _f, _d) \
     DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_bios_chs_trans, int)
 #define DEFINE_PROP_BLOCKSIZE(_n, _s, _f) \
-    DEFINE_PROP_UNSIGNED(_n, _s, _f, 0, qdev_prop_blocksize, uint16_t)
+    DEFINE_PROP_UNSIGNED(_n, _s, _f, 0, qdev_prop_blocksize, uint32_t)
 #define DEFINE_PROP_PCI_HOST_DEVADDR(_n, _s, _f) \
     DEFINE_PROP(_n, _s, _f, qdev_prop_pci_host_devaddr, PCIHostDeviceAdd=
ress)
 #define DEFINE_PROP_OFF_AUTO_PCIBAR(_n, _s, _f, _d) \
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 2047114fca..a571be7607 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -14,6 +14,7 @@
 #include "qapi/visitor.h"
 #include "chardev/char.h"
 #include "qemu/uuid.h"
+#include "qemu/units.h"
=20
 void qdev_prop_set_after_realize(DeviceState *dev, const char *name,
                                   Error **errp)
@@ -729,30 +730,39 @@ const PropertyInfo qdev_prop_pci_devfn =3D {
=20
 /* --- blocksize --- */
=20
+/* lower limit is sector size */
+#define MIN_BLOCK_SIZE          512
+#define MIN_BLOCK_SIZE_STR      "512 B"
+/* upper limit is arbitrary, 2 MiB looks sufficient */
+#define MAX_BLOCK_SIZE          (2 * MiB)
+#define MAX_BLOCK_SIZE_STR      "2 MiB"
+
 static void set_blocksize(Object *obj, Visitor *v, const char *name,
                           void *opaque, Error **errp)
 {
     DeviceState *dev =3D DEVICE(obj);
     Property *prop =3D opaque;
-    uint16_t value, *ptr =3D qdev_get_prop_ptr(dev, prop);
+    uint32_t *ptr =3D qdev_get_prop_ptr(dev, prop);
+    uint64_t value;
     Error *local_err =3D NULL;
-    const int64_t min =3D 512;
-    const int64_t max =3D 32768;
=20
     if (dev->realized) {
         qdev_prop_set_after_realize(dev, name, errp);
         return;
     }
=20
-    visit_type_uint16(v, name, &value, &local_err);
+    visit_type_size(v, name, &value, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
     }
     /* value of 0 means "unset" */
-    if (value && (value < min || value > max)) {
-        error_setg(errp, QERR_PROPERTY_VALUE_OUT_OF_RANGE,
-                   dev->id ? : "", name, (int64_t)value, min, max);
+    if (value && (value < MIN_BLOCK_SIZE || value > MAX_BLOCK_SIZE)) {
+        error_setg(errp,
+                   "Property %s.%s doesn't take value %" PRIu64
+                   " (minimum: " MIN_BLOCK_SIZE_STR
+                   ", maximum: " MAX_BLOCK_SIZE_STR ")",
+                   dev->id ? : "", name, value);
         return;
     }
=20
@@ -768,9 +778,10 @@ static void set_blocksize(Object *obj, Visitor *v, c=
onst char *name,
 }
=20
 const PropertyInfo qdev_prop_blocksize =3D {
-    .name  =3D "uint16",
-    .description =3D "A power of two between 512 and 32768",
-    .get   =3D get_uint16,
+    .name  =3D "size",
+    .description =3D "A power of two between " MIN_BLOCK_SIZE_STR
+                   " and " MAX_BLOCK_SIZE_STR,
+    .get   =3D get_uint32,
     .set   =3D set_blocksize,
     .set_default_value =3D set_default_value_uint,
 };
--=20
2.25.1


