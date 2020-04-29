Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBDB4C83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 09:19:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 844FD20731
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 09:19:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="mnqqBtU6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 844FD20731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTisV-0000Ib-Sm
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 05:19:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60890)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <rvkagan@yandex-team.ru>) id 1jTirN-0007Px-Ui
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 05:18:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <rvkagan@yandex-team.ru>) id 1jTirM-0003p8-Sv
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 05:18:29 -0400
Received: from forwardcorp1p.mail.yandex.net
 ([2a02:6b8:0:1472:2741:0:8b6:217]:37516)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rvkagan@yandex-team.ru>)
 id 1jTirH-0003kW-Qm; Wed, 29 Apr 2020 05:18:24 -0400
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net
 [IPv6:2a02:6b8:0:1619::119])
 by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 4B89E2E1544;
 Wed, 29 Apr 2020 12:18:16 +0300 (MSK)
Received: from vla5-58875c36c028.qloud-c.yandex.net
 (vla5-58875c36c028.qloud-c.yandex.net [2a02:6b8:c18:340b:0:640:5887:5c36])
 by mxbackcorp2j.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id
 mAf3dwBIGm-IEXelsRR; Wed, 29 Apr 2020 12:18:16 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1588151896; bh=CmMd/A5UKlERbFJXKyByrEk1M2V7VRbmZsEtqK6hpEI=;
 h=Message-Id:Date:Subject:To:From:Cc;
 b=mnqqBtU6naL/OCwvmMjXeIqH4YjDsPXenIh2qOCEK/6SNJUsT5iwp5ZWDILnuzeH1
 SCgPR+85ix2sZATFLU6VVZ2MwF2hLM9u/SGdciQxmrww9gt0nepDWEiITnMKrc7yj8
 VraF38CtkZlXLobXcdgSQ3VyNhwZk0XfA+Oxshb8=
Authentication-Results: mxbackcorp2j.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net
 [2a02:6b8:b081:1505::1:3])
 by vla5-58875c36c028.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 sGrKQXMj4l-IEYeFAAP; Wed, 29 Apr 2020 12:18:14 +0300
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (Client certificate not present)
From: Roman Kagan <rvkagan@yandex-team.ru>
To: qemu-devel@nongnu.org
Subject: [PATCH v3] block: make BlockConf.*_size properties 32-bit
Date: Wed, 29 Apr 2020 12:18:13 +0300
Message-Id: <20200429091813.1469510-1-rvkagan@yandex-team.ru>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:0:1472:2741:0:8b6:217;
 envelope-from=rvkagan@yandex-team.ru; helo=forwardcorp1p.mail.yandex.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 05:18:16
X-ACL-Warn: Detected OS   = ???
X-Received-From: 2a02:6b8:0:1472:2741:0:8b6:217
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
appears to be good enough for everybody, and matches the qcow2 cluster
size limit.

As the values can now be fairly big and awkward to type, make the
property setter accept common size suffixes (k, m).

Signed-off-by: Roman Kagan <rvkagan@yandex-team.ru>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
v2 -> v3:
- mention qcow2 cluster size limit in the log and comment [Eric]

v1 -> v2:
- cap the property at 2 MiB [Eric]
- accept size suffixes

 include/hw/block/block.h     |  8 ++++----
 include/hw/qdev-properties.h |  2 +-
 hw/core/qdev-properties.c    | 34 ++++++++++++++++++++++++----------
 3 files changed, 29 insertions(+), 15 deletions(-)

diff --git a/include/hw/block/block.h b/include/hw/block/block.h
index d7246f3862..9dd6bba56a 100644
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
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 2047114fca..e673f3c43f 100644
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
2.25.4


