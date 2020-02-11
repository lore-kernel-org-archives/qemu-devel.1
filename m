Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38233C352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 13:35:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03FEF20675
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 13:35:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="MFDBCRgV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03FEF20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1VhZ-0000U3-0O
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 08:35:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49401)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <rvkagan@yandex-team.ru>) id 1j1U7K-0006CW-40
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 06:54:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rvkagan@yandex-team.ru>) id 1j1U7I-0005Ta-UC
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 06:54:14 -0500
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:48390)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <rvkagan@yandex-team.ru>)
 id 1j1U7D-0005Kw-G8; Tue, 11 Feb 2020 06:54:08 -0500
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net
 [IPv6:2a02:6b8:0:1619::119])
 by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id C90722E157B;
 Tue, 11 Feb 2020 14:54:02 +0300 (MSK)
Received: from vla5-58875c36c028.qloud-c.yandex.net
 (vla5-58875c36c028.qloud-c.yandex.net [2a02:6b8:c18:340b:0:640:5887:5c36])
 by mxbackcorp2j.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id
 RRyd5SKXoO-s2wGAHb5; Tue, 11 Feb 2020 14:54:02 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1581422042; bh=Tt2vqKivAOJ6aDB2/qFN9hpnhVxIgNZjPRUUlCBjKtc=;
 h=Message-Id:Date:Subject:To:From:Cc;
 b=MFDBCRgVazOl5HjER1qK34Bjt1ENXwclmQ4cgx+OAQ7fKdC+hh51gaVaR6XgdrXB7
 7l6kesBXornwMaYENQS/902X/wWkeEP+WrMFgR+l0vyRWFjcB+dBXGfR4bPguei6uw
 9M3Gh9idcIs/uk/aPhI8FNOaB298sdA/xjvQWsVw=
Authentication-Results: mxbackcorp2j.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net
 [2a02:6b8:0:408:5417:48f1:724b:1a04])
 by vla5-58875c36c028.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 fOc4LbSE0T-s2W4Kl6A; Tue, 11 Feb 2020 14:54:02 +0300
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (Client certificate not present)
From: Roman Kagan <rvkagan@yandex-team.ru>
To: qemu-devel@nongnu.org
Subject: [PATCH] block: make BlockConf.*_size properties 32-bit
Date: Tue, 11 Feb 2020 14:54:01 +0300
Message-Id: <20200211115401.43230-1-rvkagan@yandex-team.ru>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 95.108.205.193
X-Mailman-Approved-At: Tue, 11 Feb 2020 08:34:09 -0500
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Devices (virtio-blk, scsi, etc.) and the block layer are happy to use
32-bit for logical_block_size, physical_block_size, and min_io_size.
However, the properties in BlockConf are defined as uint16_t limiting
the values to 32768.

This appears unnecessary tight, and we've seen bigger block sizes handy
at times.

Make them 32 bit instead and lift the limitation.

Signed-off-by: Roman Kagan <rvkagan@yandex-team.ru>
---
 hw/core/qdev-properties.c    | 21 ++++++++++++---------
 include/hw/block/block.h     |  8 ++++----
 include/hw/qdev-properties.h |  2 +-
 3 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 7f93bfeb88..5f84e4a3b8 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -716,30 +716,32 @@ const PropertyInfo qdev_prop_pci_devfn =3D {
=20
 /* --- blocksize --- */
=20
+#define MIN_BLOCK_SIZE 512
+#define MAX_BLOCK_SIZE 2147483648
+
 static void set_blocksize(Object *obj, Visitor *v, const char *name,
                           void *opaque, Error **errp)
 {
     DeviceState *dev =3D DEVICE(obj);
     Property *prop =3D opaque;
-    uint16_t value, *ptr =3D qdev_get_prop_ptr(dev, prop);
+    uint32_t value, *ptr =3D qdev_get_prop_ptr(dev, prop);
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
+    visit_type_uint32(v, name, &value, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
     }
     /* value of 0 means "unset" */
-    if (value && (value < min || value > max)) {
+    if (value && (value < MIN_BLOCK_SIZE || value > MAX_BLOCK_SIZE)) {
         error_setg(errp, QERR_PROPERTY_VALUE_OUT_OF_RANGE,
-                   dev->id ? : "", name, (int64_t)value, min, max);
+                   dev->id ? : "", name, (int64_t)value,
+                   (int64_t)MIN_BLOCK_SIZE, (int64_t)MAX_BLOCK_SIZE);
         return;
     }
=20
@@ -755,9 +757,10 @@ static void set_blocksize(Object *obj, Visitor *v, c=
onst char *name,
 }
=20
 const PropertyInfo qdev_prop_blocksize =3D {
-    .name  =3D "uint16",
-    .description =3D "A power of two between 512 and 32768",
-    .get   =3D get_uint16,
+    .name  =3D "uint32",
+    .description =3D "A power of two between " stringify(MIN_BLOCK_SIZE)
+                   " and " stringify(MAX_BLOCK_SIZE),
+    .get   =3D get_uint32,
     .set   =3D set_blocksize,
     .set_default_value =3D set_default_value_uint,
 };
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
index 906e697c58..ebdeeb4866 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -193,7 +193,7 @@ extern const PropertyInfo qdev_prop_pcie_link_width;
 #define DEFINE_PROP_BIOS_CHS_TRANS(_n, _s, _f, _d) \
     DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_bios_chs_trans, int)
 #define DEFINE_PROP_BLOCKSIZE(_n, _s, _f) \
-    DEFINE_PROP_UNSIGNED(_n, _s, _f, 0, qdev_prop_blocksize, uint16_t)
+    DEFINE_PROP_UNSIGNED(_n, _s, _f, 0, qdev_prop_blocksize, uint32_t)
 #define DEFINE_PROP_PCI_HOST_DEVADDR(_n, _s, _f) \
     DEFINE_PROP(_n, _s, _f, qdev_prop_pci_host_devaddr, PCIHostDeviceAdd=
ress)
 #define DEFINE_PROP_OFF_AUTO_PCIBAR(_n, _s, _f, _d) \
--=20
2.24.1


