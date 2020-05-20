Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00064C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 08:07:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2F292065F
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 08:07:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="lnFfEsot"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2F292065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbJlc-0005VW-1k
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 04:07:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40428)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rvkagan@yandex-team.ru>)
 id 1jbJkw-0004SA-3R; Wed, 20 May 2020 04:07:14 -0400
Received: from forwardcorp1p.mail.yandex.net
 ([2a02:6b8:0:1472:2741:0:8b6:217]:50354)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rvkagan@yandex-team.ru>)
 id 1jbJku-00009V-OS; Wed, 20 May 2020 04:07:13 -0400
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net
 [IPv6:2a02:6b8:0:1619::119])
 by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 239452E144D;
 Wed, 20 May 2020 11:07:09 +0300 (MSK)
Received: from vla5-58875c36c028.qloud-c.yandex.net
 (vla5-58875c36c028.qloud-c.yandex.net [2a02:6b8:c18:340b:0:640:5887:5c36])
 by mxbackcorp2j.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id
 ZD7dbzirRf-77dKTI2e; Wed, 20 May 2020 11:07:09 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1589962029; bh=LMBAjhO8Am8MgxyaHiqZh88YBwFhqLoSCDETIncrUVo=;
 h=In-Reply-To:Message-Id:References:Date:Subject:To:From:Cc;
 b=lnFfEsotmlBEh3NUwVJLHH0Mz0C8mCrbAiJQetYtaHa+f7xbmnIGcuUfAw3+u7E1K
 5GVm4LwVt+APPjMo5DzeIBvNxLRQdT4hqIoCDL8IFm5mKZK1SVnCoAhx9WFpFkFXqE
 OGd6BVdDZfLiJ2zCXLIQNZS0XpX1UKT0RKKrKbF8=
Authentication-Results: mxbackcorp2j.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net
 [2a02:6b8:b081:1519::1:a])
 by vla5-58875c36c028.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 HRdUjo6D3m-77XmDAtN; Wed, 20 May 2020 11:07:07 +0300
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (Client certificate not present)
From: Roman Kagan <rvkagan@yandex-team.ru>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 3/3] block: make BlockConf.*_size properties 32-bit
Date: Wed, 20 May 2020 11:06:57 +0300
Message-Id: <20200520080657.29080-4-rvkagan@yandex-team.ru>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200520080657.29080-1-rvkagan@yandex-team.ru>
References: <20200520080657.29080-1-rvkagan@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:0:1472:2741:0:8b6:217;
 envelope-from=rvkagan@yandex-team.ru; helo=forwardcorp1p.mail.yandex.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 04:07:09
X-ACL-Warn: Detected OS   = ???
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, John Snow <jsnow@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Keith Busch <kbusch@kernel.org>,
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
appears to be good enough for everybody, and matches the qcow2 cluster
size limit.

As the values can now be fairly big and awkward to type, make the
property setter accept common size suffixes (k, m).

Also as the devices which use min_io_size (virtio-blk and scsi) pass its
value to the guest in units of logical blocks in a 16bit field, to
prevent its silent truncation add a corresponding check to
blkconf_blocksizes.

Signed-off-by: Roman Kagan <rvkagan@yandex-team.ru>
---
v3 -> v4:
- check min_io_size against truncation [Kevin]

v2 -> v3:
- mention qcow2 cluster size limit in the log and comment [Eric]

v1 -> v2:
- cap the property at 2 MiB [Eric]
- accept size suffixes

 include/hw/block/block.h     |  8 ++++----
 include/hw/qdev-properties.h |  2 +-
 hw/block/block.c             | 11 +++++++++++
 hw/core/qdev-properties.c    | 34 ++++++++++++++++++++++++----------
 4 files changed, 40 insertions(+), 15 deletions(-)

diff --git a/include/hw/block/block.h b/include/hw/block/block.h
index 784953a237..2fa09aa0b1 100644
--- a/include/hw/block/block.h
+++ b/include/hw/block/block.h
@@ -18,9 +18,9 @@
 
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
@@ -51,7 +51,7 @@ static inline unsigned int get_physical_block_exp(BlockConf *conf)
                           _conf.logical_block_size),                    \
     DEFINE_PROP_BLOCKSIZE("physical_block_size", _state,                \
                           _conf.physical_block_size),                   \
-    DEFINE_PROP_UINT16("min_io_size", _state, _conf.min_io_size, 0),    \
+    DEFINE_PROP_UINT32("min_io_size", _state, _conf.min_io_size, 0),    \
     DEFINE_PROP_UINT32("opt_io_size", _state, _conf.opt_io_size, 0),    \
     DEFINE_PROP_UINT32("discard_granularity", _state,                   \
                        _conf.discard_granularity, -1),                  \
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
     DEFINE_PROP(_n, _s, _f, qdev_prop_pci_host_devaddr, PCIHostDeviceAddress)
 #define DEFINE_PROP_OFF_AUTO_PCIBAR(_n, _s, _f, _d) \
diff --git a/hw/block/block.c b/hw/block/block.c
index 5f8ebff59c..cd95e7e38f 100644
--- a/hw/block/block.c
+++ b/hw/block/block.c
@@ -96,6 +96,17 @@ bool blkconf_blocksizes(BlockConf *conf, Error **errp)
         return false;
     }
 
+    /*
+     * all devices which support min_io_size (scsi and virtio-blk) expose it to
+     * the guest as a uint16_t in units of logical blocks
+     */
+    if ((conf->min_io_size / conf->logical_block_size) > UINT16_MAX) {
+        error_setg(errp,
+                   "min_io_size must be no more than " stringify(UINT16_MAX)
+                   " of logical_block_size");
+        return false;
+    }
+
     if (conf->opt_io_size % conf->logical_block_size) {
         error_setg(errp,
                    "opt_io_size must be a multple of logical_block_size");
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index cc924815da..fd03cc7597 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -14,6 +14,7 @@
 #include "qapi/visitor.h"
 #include "chardev/char.h"
 #include "qemu/uuid.h"
+#include "qemu/units.h"
 
 void qdev_prop_set_after_realize(DeviceState *dev, const char *name,
                                   Error **errp)
@@ -729,30 +730,42 @@ const PropertyInfo qdev_prop_pci_devfn = {
 
 /* --- blocksize --- */
 
+/* lower limit is sector size */
+#define MIN_BLOCK_SIZE          512
+#define MIN_BLOCK_SIZE_STR      "512 B"
+/*
+ * upper limit is arbitrary, 2 MiB looks sufficient for all sensible uses, and
+ * matches qcow2 cluster size limit
+ */
+#define MAX_BLOCK_SIZE          (2 * MiB)
+#define MAX_BLOCK_SIZE_STR      "2 MiB"
+
 static void set_blocksize(Object *obj, Visitor *v, const char *name,
                           void *opaque, Error **errp)
 {
     DeviceState *dev = DEVICE(obj);
     Property *prop = opaque;
-    uint16_t value, *ptr = qdev_get_prop_ptr(dev, prop);
+    uint32_t *ptr = qdev_get_prop_ptr(dev, prop);
+    uint64_t value;
     Error *local_err = NULL;
-    const int64_t min = 512;
-    const int64_t max = 32768;
 
     if (dev->realized) {
         qdev_prop_set_after_realize(dev, name, errp);
         return;
     }
 
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
 
@@ -768,9 +781,10 @@ static void set_blocksize(Object *obj, Visitor *v, const char *name,
 }
 
 const PropertyInfo qdev_prop_blocksize = {
-    .name  = "uint16",
-    .description = "A power of two between 512 and 32768",
-    .get   = get_uint16,
+    .name  = "size",
+    .description = "A power of two between " MIN_BLOCK_SIZE_STR
+                   " and " MAX_BLOCK_SIZE_STR,
+    .get   = get_uint32,
     .set   = set_blocksize,
     .set_default_value = set_default_value_uint,
 };
-- 
2.26.2


