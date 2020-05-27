Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34BA3C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 12:48:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3D96207CB
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 12:48:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="tgMD0FVC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3D96207CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdvTs-0005AP-2S
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 08:48:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52998)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rvkagan@yandex-team.ru>)
 id 1jdvRI-0000Aa-Rj; Wed, 27 May 2020 08:45:44 -0400
Received: from forwardcorp1p.mail.yandex.net
 ([2a02:6b8:0:1472:2741:0:8b6:217]:36568)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rvkagan@yandex-team.ru>)
 id 1jdvRF-0001dS-Kz; Wed, 27 May 2020 08:45:44 -0400
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net
 [IPv6:2a02:6b8:0:1619::162])
 by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 5C7772E1590;
 Wed, 27 May 2020 15:45:37 +0300 (MSK)
Received: from iva4-7c3d9abce76c.qloud-c.yandex.net
 (iva4-7c3d9abce76c.qloud-c.yandex.net [2a02:6b8:c0c:4e8e:0:640:7c3d:9abc])
 by mxbackcorp1j.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id
 K4MuwlsXgC-jYFOeB5T; Wed, 27 May 2020 15:45:37 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1590583537; bh=5W8C5oYNbfwIbGSjpB4jp+1QNqqk5DONxp7cMMQxQ3c=;
 h=In-Reply-To:Message-Id:References:Date:Subject:To:From:Cc;
 b=tgMD0FVC6Kkk5pyhPXCpSm0/Ii7pxD/QYpWNlhB59EwghvJb4UkNXKIFy7US5RYtx
 12WH1B3QeOzy/c2E2TZtf4jWDI5VLqlNIVr2BgqTPudT3NdAx7ebMMNeDqaL9wcCtP
 +Z+itHy1FTjGj2Hr/HHhplRQcWLk9vj62ThvVMSc=
Authentication-Results: mxbackcorp1j.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net
 [2a02:6b8:b080:8308::1:12])
 by iva4-7c3d9abce76c.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 bzO5qPtczO-jXWODlkU; Wed, 27 May 2020 15:45:34 +0300
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (Client certificate not present)
From: Roman Kagan <rvkagan@yandex-team.ru>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 4/5] block: make size-related BlockConf properties accept
 size suffixes
Date: Wed, 27 May 2020 15:45:10 +0300
Message-Id: <20200527124511.986099-5-rvkagan@yandex-team.ru>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200527124511.986099-1-rvkagan@yandex-team.ru>
References: <20200527124511.986099-1-rvkagan@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:0:1472:2741:0:8b6:217;
 envelope-from=rvkagan@yandex-team.ru; helo=forwardcorp1p.mail.yandex.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 08:45:37
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
 Stefano Stabellini <sstabellini@kernel.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Paul Durrant <paul@xen.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Several BlockConf properties represent respective sizes in bytes so it
makes sense to accept size suffixes for them.

Turn them all into uint32_t and use size-suffix-capable setters/getters
on them; introduce DEFINE_PROP_SIZE32 and adjust DEFINE_PROP_BLOCKSIZE
for that. (Making them uint64_t and reusing DEFINE_PROP_SIZE isn't
justified because guests expect at most 32bit values.)

Also, since min_io_size is exposed to the guest by scsi and virtio-blk
devices as an uint16_t in units of logical blocks, introduce an
additional check in blkconf_blocksizes to prevent its silent truncation.

Signed-off-by: Roman Kagan <rvkagan@yandex-team.ru>
---
v5 -> v6:
- add prop_size32 instead of going with 64bit

v4 -> v5:
- make all BlockConf size props support suffixes
- move qdev_prop_blocksize after qdev_prop_size, to reuse get_size
- reword error messages [Kevin]

 include/hw/block/block.h     |  12 +-
 include/hw/qdev-properties.h |   5 +-
 hw/block/block.c             |  11 +
 hw/core/qdev-properties.c    |  63 ++++-
 tests/qemu-iotests/172.out   | 530 +++++++++++++++++------------------
 5 files changed, 344 insertions(+), 277 deletions(-)

diff --git a/include/hw/block/block.h b/include/hw/block/block.h
index 784953a237..1e8b6253dd 100644
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
@@ -51,9 +51,9 @@ static inline unsigned int get_physical_block_exp(BlockConf *conf)
                           _conf.logical_block_size),                    \
     DEFINE_PROP_BLOCKSIZE("physical_block_size", _state,                \
                           _conf.physical_block_size),                   \
-    DEFINE_PROP_UINT16("min_io_size", _state, _conf.min_io_size, 0),    \
-    DEFINE_PROP_UINT32("opt_io_size", _state, _conf.opt_io_size, 0),    \
-    DEFINE_PROP_UINT32("discard_granularity", _state,                   \
+    DEFINE_PROP_SIZE32("min_io_size", _state, _conf.min_io_size, 0),    \
+    DEFINE_PROP_SIZE32("opt_io_size", _state, _conf.opt_io_size, 0),    \
+    DEFINE_PROP_SIZE32("discard_granularity", _state,                   \
                        _conf.discard_granularity, -1),                  \
     DEFINE_PROP_ON_OFF_AUTO("write-cache", _state, _conf.wce,           \
                             ON_OFF_AUTO_AUTO),                          \
diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index f161604fb6..5252bb6b1a 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -29,6 +29,7 @@ extern const PropertyInfo qdev_prop_drive;
 extern const PropertyInfo qdev_prop_drive_iothread;
 extern const PropertyInfo qdev_prop_netdev;
 extern const PropertyInfo qdev_prop_pci_devfn;
+extern const PropertyInfo qdev_prop_size32;
 extern const PropertyInfo qdev_prop_blocksize;
 extern const PropertyInfo qdev_prop_pci_host_devaddr;
 extern const PropertyInfo qdev_prop_uuid;
@@ -196,8 +197,10 @@ extern const PropertyInfo qdev_prop_pcie_link_width;
                         BlockdevOnError)
 #define DEFINE_PROP_BIOS_CHS_TRANS(_n, _s, _f, _d) \
     DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_bios_chs_trans, int)
+#define DEFINE_PROP_SIZE32(_n, _s, _f, _d)                       \
+    DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, qdev_prop_size32, uint32_t)
 #define DEFINE_PROP_BLOCKSIZE(_n, _s, _f) \
-    DEFINE_PROP_UNSIGNED(_n, _s, _f, 0, qdev_prop_blocksize, uint16_t)
+    DEFINE_PROP_UNSIGNED(_n, _s, _f, 0, qdev_prop_blocksize, uint32_t)
 #define DEFINE_PROP_PCI_HOST_DEVADDR(_n, _s, _f) \
     DEFINE_PROP(_n, _s, _f, qdev_prop_pci_host_devaddr, PCIHostDeviceAddress)
 #define DEFINE_PROP_OFF_AUTO_PCIBAR(_n, _s, _f, _d) \
diff --git a/hw/block/block.c b/hw/block/block.c
index b22207c921..97c8129e60 100644
--- a/hw/block/block.c
+++ b/hw/block/block.c
@@ -96,6 +96,17 @@ bool blkconf_blocksizes(BlockConf *conf, Error **errp)
         return false;
     }
 
+    /*
+     * all devices which support min_io_size (scsi and virtio-blk) expose it to
+     * the guest as a uint16_t in units of logical blocks
+     */
+    if (conf->min_io_size > conf->logical_block_size * UINT16_MAX) {
+        error_setg(errp,
+                   "min_io_size must not exceed " stringify(UINT16_MAX)
+                   " logical blocks");
+        return false;
+    }
+
     if (!QEMU_IS_ALIGNED(conf->opt_io_size, conf->logical_block_size)) {
         error_setg(errp,
                    "opt_io_size must be a multiple of logical_block_size");
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 249dc69bd8..e7ccd4d276 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -14,6 +14,7 @@
 #include "qapi/visitor.h"
 #include "chardev/char.h"
 #include "qemu/uuid.h"
+#include "qemu/units.h"
 
 void qdev_prop_set_after_realize(DeviceState *dev, const char *name,
                                   Error **errp)
@@ -727,6 +728,57 @@ const PropertyInfo qdev_prop_pci_devfn = {
     .set_default_value = set_default_value_int,
 };
 
+/* --- 32bit unsigned int 'size' type --- */
+
+static void get_size32(Object *obj, Visitor *v, const char *name, void *opaque,
+                       Error **errp)
+{
+    DeviceState *dev = DEVICE(obj);
+    Property *prop = opaque;
+    uint32_t *ptr = qdev_get_prop_ptr(dev, prop);
+    uint64_t value = *ptr;
+
+    visit_type_size(v, name, &value, errp);
+}
+
+static void set_size32(Object *obj, Visitor *v, const char *name, void *opaque,
+                       Error **errp)
+{
+    DeviceState *dev = DEVICE(obj);
+    Property *prop = opaque;
+    uint32_t *ptr = qdev_get_prop_ptr(dev, prop);
+    uint64_t value;
+    Error *local_err = NULL;
+
+    if (dev->realized) {
+        qdev_prop_set_after_realize(dev, name, errp);
+        return;
+    }
+
+    visit_type_size(v, name, &value, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    if (value > UINT32_MAX) {
+        error_setg(errp,
+                   "Property %s.%s doesn't take value %" PRIu64
+                   " (maximum: " stringify(UINT32_MAX) ")",
+                   dev->id ? : "", name, value);
+        return;
+    }
+
+    *ptr = value;
+}
+
+const PropertyInfo qdev_prop_size32 = {
+    .name  = "size",
+    .get = get_size32,
+    .set = set_size32,
+    .set_default_value = set_default_value_uint,
+};
+
 /* --- blocksize --- */
 
 /* lower limit is sector size */
@@ -741,7 +793,8 @@ static void set_blocksize(Object *obj, Visitor *v, const char *name,
 {
     DeviceState *dev = DEVICE(obj);
     Property *prop = opaque;
-    uint16_t value, *ptr = qdev_get_prop_ptr(dev, prop);
+    uint32_t *ptr = qdev_get_prop_ptr(dev, prop);
+    uint64_t value;
     Error *local_err = NULL;
 
     if (dev->realized) {
@@ -749,7 +802,7 @@ static void set_blocksize(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    visit_type_uint16(v, name, &value, &local_err);
+    visit_type_size(v, name, &value, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
@@ -757,7 +810,7 @@ static void set_blocksize(Object *obj, Visitor *v, const char *name,
     /* value of 0 means "unset" */
     if (value && (value < MIN_BLOCK_SIZE || value > MAX_BLOCK_SIZE)) {
         error_setg(errp,
-                   "Property %s.%s doesn't take value %" PRIu16
+                   "Property %s.%s doesn't take value %" PRIu64
                    " (minimum: " MIN_BLOCK_SIZE_STR
                    ", maximum: " MAX_BLOCK_SIZE_STR ")",
                    dev->id ? : "", name, value);
@@ -776,10 +829,10 @@ static void set_blocksize(Object *obj, Visitor *v, const char *name,
 }
 
 const PropertyInfo qdev_prop_blocksize = {
-    .name  = "uint16",
+    .name  = "size",
     .description = "A power of two between " MIN_BLOCK_SIZE_STR
                    " and " MAX_BLOCK_SIZE_STR,
-    .get   = get_uint16,
+    .get   = get_size32,
     .set   = set_blocksize,
     .set_default_value = set_default_value_uint,
 };
diff --git a/tests/qemu-iotests/172.out b/tests/qemu-iotests/172.out
index 59cc70aebb..e782c5957e 100644
--- a/tests/qemu-iotests/172.out
+++ b/tests/qemu-iotests/172.out
@@ -24,11 +24,11 @@ Testing:
               dev: floppy, id ""
                 unit = 0 (0x0)
                 drive = "floppy0"
-                logical_block_size = 512 (0x200)
-                physical_block_size = 512 (0x200)
-                min_io_size = 0 (0x0)
-                opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                logical_block_size = 512 (512 B)
+                physical_block_size = 512 (512 B)
+                min_io_size = 0 (0 B)
+                opt_io_size = 0 (0 B)
+                discard_granularity = 4294967295 (4 GiB)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "288"
@@ -54,11 +54,11 @@ Testing: -fda TEST_DIR/t.qcow2
               dev: floppy, id ""
                 unit = 0 (0x0)
                 drive = "floppy0"
-                logical_block_size = 512 (0x200)
-                physical_block_size = 512 (0x200)
-                min_io_size = 0 (0x0)
-                opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                logical_block_size = 512 (512 B)
+                physical_block_size = 512 (512 B)
+                min_io_size = 0 (0 B)
+                opt_io_size = 0 (0 B)
+                discard_granularity = 4294967295 (4 GiB)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
@@ -81,22 +81,22 @@ Testing: -fdb TEST_DIR/t.qcow2
               dev: floppy, id ""
                 unit = 1 (0x1)
                 drive = "floppy1"
-                logical_block_size = 512 (0x200)
-                physical_block_size = 512 (0x200)
-                min_io_size = 0 (0x0)
-                opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                logical_block_size = 512 (512 B)
+                physical_block_size = 512 (512 B)
+                min_io_size = 0 (0 B)
+                opt_io_size = 0 (0 B)
+                discard_granularity = 4294967295 (4 GiB)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
               dev: floppy, id ""
                 unit = 0 (0x0)
                 drive = "floppy0"
-                logical_block_size = 512 (0x200)
-                physical_block_size = 512 (0x200)
-                min_io_size = 0 (0x0)
-                opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                logical_block_size = 512 (512 B)
+                physical_block_size = 512 (512 B)
+                min_io_size = 0 (0 B)
+                opt_io_size = 0 (0 B)
+                discard_granularity = 4294967295 (4 GiB)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "288"
@@ -119,22 +119,22 @@ Testing: -fda TEST_DIR/t.qcow2 -fdb TEST_DIR/t.qcow2.2
               dev: floppy, id ""
                 unit = 1 (0x1)
                 drive = "floppy1"
-                logical_block_size = 512 (0x200)
-                physical_block_size = 512 (0x200)
-                min_io_size = 0 (0x0)
-                opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                logical_block_size = 512 (512 B)
+                physical_block_size = 512 (512 B)
+                min_io_size = 0 (0 B)
+                opt_io_size = 0 (0 B)
+                discard_granularity = 4294967295 (4 GiB)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
               dev: floppy, id ""
                 unit = 0 (0x0)
                 drive = "floppy0"
-                logical_block_size = 512 (0x200)
-                physical_block_size = 512 (0x200)
-                min_io_size = 0 (0x0)
-                opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                logical_block_size = 512 (512 B)
+                physical_block_size = 512 (512 B)
+                min_io_size = 0 (0 B)
+                opt_io_size = 0 (0 B)
+                discard_granularity = 4294967295 (4 GiB)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
@@ -160,11 +160,11 @@ Testing: -drive if=floppy,file=TEST_DIR/t.qcow2
               dev: floppy, id ""
                 unit = 0 (0x0)
                 drive = "floppy0"
-                logical_block_size = 512 (0x200)
-                physical_block_size = 512 (0x200)
-                min_io_size = 0 (0x0)
-                opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                logical_block_size = 512 (512 B)
+                physical_block_size = 512 (512 B)
+                min_io_size = 0 (0 B)
+                opt_io_size = 0 (0 B)
+                discard_granularity = 4294967295 (4 GiB)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
@@ -187,22 +187,22 @@ Testing: -drive if=floppy,file=TEST_DIR/t.qcow2,index=1
               dev: floppy, id ""
                 unit = 1 (0x1)
                 drive = "floppy1"
-                logical_block_size = 512 (0x200)
-                physical_block_size = 512 (0x200)
-                min_io_size = 0 (0x0)
-                opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                logical_block_size = 512 (512 B)
+                physical_block_size = 512 (512 B)
+                min_io_size = 0 (0 B)
+                opt_io_size = 0 (0 B)
+                discard_granularity = 4294967295 (4 GiB)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
               dev: floppy, id ""
                 unit = 0 (0x0)
                 drive = "floppy0"
-                logical_block_size = 512 (0x200)
-                physical_block_size = 512 (0x200)
-                min_io_size = 0 (0x0)
-                opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                logical_block_size = 512 (512 B)
+                physical_block_size = 512 (512 B)
+                min_io_size = 0 (0 B)
+                opt_io_size = 0 (0 B)
+                discard_granularity = 4294967295 (4 GiB)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "288"
@@ -225,22 +225,22 @@ Testing: -drive if=floppy,file=TEST_DIR/t.qcow2 -drive if=floppy,file=TEST_DIR/t
               dev: floppy, id ""
                 unit = 1 (0x1)
                 drive = "floppy1"
-                logical_block_size = 512 (0x200)
-                physical_block_size = 512 (0x200)
-                min_io_size = 0 (0x0)
-                opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                logical_block_size = 512 (512 B)
+                physical_block_size = 512 (512 B)
+                min_io_size = 0 (0 B)
+                opt_io_size = 0 (0 B)
+                discard_granularity = 4294967295 (4 GiB)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
               dev: floppy, id ""
                 unit = 0 (0x0)
                 drive = "floppy0"
-                logical_block_size = 512 (0x200)
-                physical_block_size = 512 (0x200)
-                min_io_size = 0 (0x0)
-                opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                logical_block_size = 512 (512 B)
+                physical_block_size = 512 (512 B)
+                min_io_size = 0 (0 B)
+                opt_io_size = 0 (0 B)
+                discard_granularity = 4294967295 (4 GiB)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
@@ -266,11 +266,11 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -global isa-fdc.driveA=none0
               dev: floppy, id ""
                 unit = 0 (0x0)
                 drive = "none0"
-                logical_block_size = 512 (0x200)
-                physical_block_size = 512 (0x200)
-                min_io_size = 0 (0x0)
-                opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                logical_block_size = 512 (512 B)
+                physical_block_size = 512 (512 B)
+                min_io_size = 0 (0 B)
+                opt_io_size = 0 (0 B)
+                discard_granularity = 4294967295 (4 GiB)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
@@ -293,11 +293,11 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -global isa-fdc.driveB=none0
               dev: floppy, id ""
                 unit = 1 (0x1)
                 drive = "none0"
-                logical_block_size = 512 (0x200)
-                physical_block_size = 512 (0x200)
-                min_io_size = 0 (0x0)
-                opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                logical_block_size = 512 (512 B)
+                physical_block_size = 512 (512 B)
+                min_io_size = 0 (0 B)
+                opt_io_size = 0 (0 B)
+                discard_granularity = 4294967295 (4 GiB)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
@@ -320,22 +320,22 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qco
               dev: floppy, id ""
                 unit = 1 (0x1)
                 drive = "none1"
-                logical_block_size = 512 (0x200)
-                physical_block_size = 512 (0x200)
-                min_io_size = 0 (0x0)
-                opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                logical_block_size = 512 (512 B)
+                physical_block_size = 512 (512 B)
+                min_io_size = 0 (0 B)
+                opt_io_size = 0 (0 B)
+                discard_granularity = 4294967295 (4 GiB)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
               dev: floppy, id ""
                 unit = 0 (0x0)
                 drive = "none0"
-                logical_block_size = 512 (0x200)
-                physical_block_size = 512 (0x200)
-                min_io_size = 0 (0x0)
-                opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                logical_block_size = 512 (512 B)
+                physical_block_size = 512 (512 B)
+                min_io_size = 0 (0 B)
+                opt_io_size = 0 (0 B)
+                discard_granularity = 4294967295 (4 GiB)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
@@ -361,11 +361,11 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -device floppy,drive=none0
               dev: floppy, id ""
                 unit = 0 (0x0)
                 drive = "none0"
-                logical_block_size = 512 (0x200)
-                physical_block_size = 512 (0x200)
-                min_io_size = 0 (0x0)
-                opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                logical_block_size = 512 (512 B)
+                physical_block_size = 512 (512 B)
+                min_io_size = 0 (0 B)
+                opt_io_size = 0 (0 B)
+                discard_granularity = 4294967295 (4 GiB)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
@@ -388,11 +388,11 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -device floppy,drive=none0,unit=1
               dev: floppy, id ""
                 unit = 1 (0x1)
                 drive = "none0"
-                logical_block_size = 512 (0x200)
-                physical_block_size = 512 (0x200)
-                min_io_size = 0 (0x0)
-                opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                logical_block_size = 512 (512 B)
+                physical_block_size = 512 (512 B)
+                min_io_size = 0 (0 B)
+                opt_io_size = 0 (0 B)
+                discard_granularity = 4294967295 (4 GiB)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
@@ -415,22 +415,22 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qco
               dev: floppy, id ""
                 unit = 1 (0x1)
                 drive = "none1"
-                logical_block_size = 512 (0x200)
-                physical_block_size = 512 (0x200)
-                min_io_size = 0 (0x0)
-                opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                logical_block_size = 512 (512 B)
+                physical_block_size = 512 (512 B)
+                min_io_size = 0 (0 B)
+                opt_io_size = 0 (0 B)
+                discard_granularity = 4294967295 (4 GiB)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
               dev: floppy, id ""
                 unit = 0 (0x0)
                 drive = "none0"
-                logical_block_size = 512 (0x200)
-                physical_block_size = 512 (0x200)
-                min_io_size = 0 (0x0)
-                opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                logical_block_size = 512 (512 B)
+                physical_block_size = 512 (512 B)
+                min_io_size = 0 (0 B)
+                opt_io_size = 0 (0 B)
+                discard_granularity = 4294967295 (4 GiB)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
@@ -456,22 +456,22 @@ Testing: -fda TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -global is
               dev: floppy, id ""
                 unit = 1 (0x1)
                 drive = "none0"
-                logical_block_size = 512 (0x200)
-                physical_block_size = 512 (0x200)
-                min_io_size = 0 (0x0)
-                opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                logical_block_size = 512 (512 B)
+                physical_block_size = 512 (512 B)
+                min_io_size = 0 (0 B)
+                opt_io_size = 0 (0 B)
+                discard_granularity = 4294967295 (4 GiB)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
               dev: floppy, id ""
                 unit = 0 (0x0)
                 drive = "floppy0"
-                logical_block_size = 512 (0x200)
-                physical_block_size = 512 (0x200)
-                min_io_size = 0 (0x0)
-                opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                logical_block_size = 512 (512 B)
+                physical_block_size = 512 (512 B)
+                min_io_size = 0 (0 B)
+                opt_io_size = 0 (0 B)
+                discard_granularity = 4294967295 (4 GiB)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
@@ -494,22 +494,22 @@ Testing: -fdb TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -global is
               dev: floppy, id ""
                 unit = 1 (0x1)
                 drive = "floppy1"
-                logical_block_size = 512 (0x200)
-                physical_block_size = 512 (0x200)
-                min_io_size = 0 (0x0)
-                opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                logical_block_size = 512 (512 B)
+                physical_block_size = 512 (512 B)
+                min_io_size = 0 (0 B)
+                opt_io_size = 0 (0 B)
+                discard_granularity = 4294967295 (4 GiB)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
               dev: floppy, id ""
                 unit = 0 (0x0)
                 drive = "none0"
-                logical_block_size = 512 (0x200)
-                physical_block_size = 512 (0x200)
-                min_io_size = 0 (0x0)
-                opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                logical_block_size = 512 (512 B)
+                physical_block_size = 512 (512 B)
+                min_io_size = 0 (0 B)
+                opt_io_size = 0 (0 B)
+                discard_granularity = 4294967295 (4 GiB)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
@@ -532,11 +532,11 @@ Testing: -fda TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -global is
               dev: floppy, id ""
                 unit = 0 (0x0)
                 drive = "floppy0"
-                logical_block_size = 512 (0x200)
-                physical_block_size = 512 (0x200)
-                min_io_size = 0 (0x0)
-                opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                logical_block_size = 512 (512 B)
+                physical_block_size = 512 (512 B)
+                min_io_size = 0 (0 B)
+                opt_io_size = 0 (0 B)
+                discard_granularity = 4294967295 (4 GiB)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
@@ -559,11 +559,11 @@ Testing: -fdb TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -global is
               dev: floppy, id ""
                 unit = 1 (0x1)
                 drive = "floppy1"
-                logical_block_size = 512 (0x200)
-                physical_block_size = 512 (0x200)
-                min_io_size = 0 (0x0)
-                opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                logical_block_size = 512 (512 B)
+                physical_block_size = 512 (512 B)
+                min_io_size = 0 (0 B)
+                opt_io_size = 0 (0 B)
+                discard_granularity = 4294967295 (4 GiB)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
@@ -589,22 +589,22 @@ Testing: -fda TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -device fl
               dev: floppy, id ""
                 unit = 1 (0x1)
                 drive = "none0"
-                logical_block_size = 512 (0x200)
-                physical_block_size = 512 (0x200)
-                min_io_size = 0 (0x0)
-                opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                logical_block_size = 512 (512 B)
+                physical_block_size = 512 (512 B)
+                min_io_size = 0 (0 B)
+                opt_io_size = 0 (0 B)
+                discard_granularity = 4294967295 (4 GiB)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
               dev: floppy, id ""
                 unit = 0 (0x0)
                 drive = "floppy0"
-                logical_block_size = 512 (0x200)
-                physical_block_size = 512 (0x200)
-                min_io_size = 0 (0x0)
-                opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                logical_block_size = 512 (512 B)
+                physical_block_size = 512 (512 B)
+                min_io_size = 0 (0 B)
+                opt_io_size = 0 (0 B)
+                discard_granularity = 4294967295 (4 GiB)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
@@ -627,22 +627,22 @@ Testing: -fda TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -device fl
               dev: floppy, id ""
                 unit = 1 (0x1)
                 drive = "none0"
-                logical_block_size = 512 (0x200)
-                physical_block_size = 512 (0x200)
-                min_io_size = 0 (0x0)
-                opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                logical_block_size = 512 (512 B)
+                physical_block_size = 512 (512 B)
+                min_io_size = 0 (0 B)
+                opt_io_size = 0 (0 B)
+                discard_granularity = 4294967295 (4 GiB)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
               dev: floppy, id ""
                 unit = 0 (0x0)
                 drive = "floppy0"
-                logical_block_size = 512 (0x200)
-                physical_block_size = 512 (0x200)
-                min_io_size = 0 (0x0)
-                opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                logical_block_size = 512 (512 B)
+                physical_block_size = 512 (512 B)
+                min_io_size = 0 (0 B)
+                opt_io_size = 0 (0 B)
+                discard_granularity = 4294967295 (4 GiB)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
@@ -665,22 +665,22 @@ Testing: -fdb TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -device fl
               dev: floppy, id ""
                 unit = 0 (0x0)
                 drive = "none0"
-                logical_block_size = 512 (0x200)
-                physical_block_size = 512 (0x200)
-                min_io_size = 0 (0x0)
-                opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                logical_block_size = 512 (512 B)
+                physical_block_size = 512 (512 B)
+                min_io_size = 0 (0 B)
+                opt_io_size = 0 (0 B)
+                discard_granularity = 4294967295 (4 GiB)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
               dev: floppy, id ""
                 unit = 1 (0x1)
                 drive = "floppy1"
-                logical_block_size = 512 (0x200)
-                physical_block_size = 512 (0x200)
-                min_io_size = 0 (0x0)
-                opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                logical_block_size = 512 (512 B)
+                physical_block_size = 512 (512 B)
+                min_io_size = 0 (0 B)
+                opt_io_size = 0 (0 B)
+                discard_granularity = 4294967295 (4 GiB)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
@@ -703,22 +703,22 @@ Testing: -fdb TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -device fl
               dev: floppy, id ""
                 unit = 0 (0x0)
                 drive = "none0"
-                logical_block_size = 512 (0x200)
-                physical_block_size = 512 (0x200)
-                min_io_size = 0 (0x0)
-                opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                logical_block_size = 512 (512 B)
+                physical_block_size = 512 (512 B)
+                min_io_size = 0 (0 B)
+                opt_io_size = 0 (0 B)
+                discard_granularity = 4294967295 (4 GiB)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
               dev: floppy, id ""
                 unit = 1 (0x1)
                 drive = "floppy1"
-                logical_block_size = 512 (0x200)
-                physical_block_size = 512 (0x200)
-                min_io_size = 0 (0x0)
-                opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                logical_block_size = 512 (512 B)
+                physical_block_size = 512 (512 B)
+                min_io_size = 0 (0 B)
+                opt_io_size = 0 (0 B)
+                discard_granularity = 4294967295 (4 GiB)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
@@ -750,22 +750,22 @@ Testing: -drive if=floppy,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.q
               dev: floppy, id ""
                 unit = 1 (0x1)
                 drive = "none0"
-                logical_block_size = 512 (0x200)
-                physical_block_size = 512 (0x200)
-                min_io_size = 0 (0x0)
-                opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                logical_block_size = 512 (512 B)
+                physical_block_size = 512 (512 B)
+                min_io_size = 0 (0 B)
+                opt_io_size = 0 (0 B)
+                discard_granularity = 4294967295 (4 GiB)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
               dev: floppy, id ""
                 unit = 0 (0x0)
                 drive = "floppy0"
-                logical_block_size = 512 (0x200)
-                physical_block_size = 512 (0x200)
-                min_io_size = 0 (0x0)
-                opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                logical_block_size = 512 (512 B)
+                physical_block_size = 512 (512 B)
+                min_io_size = 0 (0 B)
+                opt_io_size = 0 (0 B)
+                discard_granularity = 4294967295 (4 GiB)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
@@ -788,22 +788,22 @@ Testing: -drive if=floppy,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.q
               dev: floppy, id ""
                 unit = 1 (0x1)
                 drive = "none0"
-                logical_block_size = 512 (0x200)
-                physical_block_size = 512 (0x200)
-                min_io_size = 0 (0x0)
-                opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                logical_block_size = 512 (512 B)
+                physical_block_size = 512 (512 B)
+                min_io_size = 0 (0 B)
+                opt_io_size = 0 (0 B)
+                discard_granularity = 4294967295 (4 GiB)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
               dev: floppy, id ""
                 unit = 0 (0x0)
                 drive = "floppy0"
-                logical_block_size = 512 (0x200)
-                physical_block_size = 512 (0x200)
-                min_io_size = 0 (0x0)
-                opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                logical_block_size = 512 (512 B)
+                physical_block_size = 512 (512 B)
+                min_io_size = 0 (0 B)
+                opt_io_size = 0 (0 B)
+                discard_granularity = 4294967295 (4 GiB)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
@@ -832,22 +832,22 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qco
               dev: floppy, id ""
                 unit = 1 (0x1)
                 drive = "none1"
-                logical_block_size = 512 (0x200)
-                physical_block_size = 512 (0x200)
-                min_io_size = 0 (0x0)
-                opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                logical_block_size = 512 (512 B)
+                physical_block_size = 512 (512 B)
+                min_io_size = 0 (0 B)
+                opt_io_size = 0 (0 B)
+                discard_granularity = 4294967295 (4 GiB)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
               dev: floppy, id ""
                 unit = 0 (0x0)
                 drive = "none0"
-                logical_block_size = 512 (0x200)
-                physical_block_size = 512 (0x200)
-                min_io_size = 0 (0x0)
-                opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                logical_block_size = 512 (512 B)
+                physical_block_size = 512 (512 B)
+                min_io_size = 0 (0 B)
+                opt_io_size = 0 (0 B)
+                discard_granularity = 4294967295 (4 GiB)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
@@ -870,22 +870,22 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qco
               dev: floppy, id ""
                 unit = 1 (0x1)
                 drive = "none1"
-                logical_block_size = 512 (0x200)
-                physical_block_size = 512 (0x200)
-                min_io_size = 0 (0x0)
-                opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                logical_block_size = 512 (512 B)
+                physical_block_size = 512 (512 B)
+                min_io_size = 0 (0 B)
+                opt_io_size = 0 (0 B)
+                discard_granularity = 4294967295 (4 GiB)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
               dev: floppy, id ""
                 unit = 0 (0x0)
                 drive = "none0"
-                logical_block_size = 512 (0x200)
-                physical_block_size = 512 (0x200)
-                min_io_size = 0 (0x0)
-                opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                logical_block_size = 512 (512 B)
+                physical_block_size = 512 (512 B)
+                min_io_size = 0 (0 B)
+                opt_io_size = 0 (0 B)
+                discard_granularity = 4294967295 (4 GiB)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
@@ -908,22 +908,22 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qco
               dev: floppy, id ""
                 unit = 0 (0x0)
                 drive = "none1"
-                logical_block_size = 512 (0x200)
-                physical_block_size = 512 (0x200)
-                min_io_size = 0 (0x0)
-                opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                logical_block_size = 512 (512 B)
+                physical_block_size = 512 (512 B)
+                min_io_size = 0 (0 B)
+                opt_io_size = 0 (0 B)
+                discard_granularity = 4294967295 (4 GiB)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
               dev: floppy, id ""
                 unit = 1 (0x1)
                 drive = "none0"
-                logical_block_size = 512 (0x200)
-                physical_block_size = 512 (0x200)
-                min_io_size = 0 (0x0)
-                opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                logical_block_size = 512 (512 B)
+                physical_block_size = 512 (512 B)
+                min_io_size = 0 (0 B)
+                opt_io_size = 0 (0 B)
+                discard_granularity = 4294967295 (4 GiB)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
@@ -946,22 +946,22 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qco
               dev: floppy, id ""
                 unit = 0 (0x0)
                 drive = "none1"
-                logical_block_size = 512 (0x200)
-                physical_block_size = 512 (0x200)
-                min_io_size = 0 (0x0)
-                opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                logical_block_size = 512 (512 B)
+                physical_block_size = 512 (512 B)
+                min_io_size = 0 (0 B)
+                opt_io_size = 0 (0 B)
+                discard_granularity = 4294967295 (4 GiB)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
               dev: floppy, id ""
                 unit = 1 (0x1)
                 drive = "none0"
-                logical_block_size = 512 (0x200)
-                physical_block_size = 512 (0x200)
-                min_io_size = 0 (0x0)
-                opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                logical_block_size = 512 (512 B)
+                physical_block_size = 512 (512 B)
+                min_io_size = 0 (0 B)
+                opt_io_size = 0 (0 B)
+                discard_granularity = 4294967295 (4 GiB)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
@@ -999,11 +999,11 @@ Testing: -device floppy
               dev: floppy, id ""
                 unit = 0 (0x0)
                 drive = ""
-                logical_block_size = 512 (0x200)
-                physical_block_size = 512 (0x200)
-                min_io_size = 0 (0x0)
-                opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                logical_block_size = 512 (512 B)
+                physical_block_size = 512 (512 B)
+                min_io_size = 0 (0 B)
+                opt_io_size = 0 (0 B)
+                discard_granularity = 4294967295 (4 GiB)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "288"
@@ -1026,11 +1026,11 @@ Testing: -device floppy,drive-type=120
               dev: floppy, id ""
                 unit = 0 (0x0)
                 drive = ""
-                logical_block_size = 512 (0x200)
-                physical_block_size = 512 (0x200)
-                min_io_size = 0 (0x0)
-                opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                logical_block_size = 512 (512 B)
+                physical_block_size = 512 (512 B)
+                min_io_size = 0 (0 B)
+                opt_io_size = 0 (0 B)
+                discard_granularity = 4294967295 (4 GiB)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "120"
@@ -1053,11 +1053,11 @@ Testing: -device floppy,drive-type=144
               dev: floppy, id ""
                 unit = 0 (0x0)
                 drive = ""
-                logical_block_size = 512 (0x200)
-                physical_block_size = 512 (0x200)
-                min_io_size = 0 (0x0)
-                opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                logical_block_size = 512 (512 B)
+                physical_block_size = 512 (512 B)
+                min_io_size = 0 (0 B)
+                opt_io_size = 0 (0 B)
+                discard_granularity = 4294967295 (4 GiB)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
@@ -1080,11 +1080,11 @@ Testing: -device floppy,drive-type=288
               dev: floppy, id ""
                 unit = 0 (0x0)
                 drive = ""
-                logical_block_size = 512 (0x200)
-                physical_block_size = 512 (0x200)
-                min_io_size = 0 (0x0)
-                opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                logical_block_size = 512 (512 B)
+                physical_block_size = 512 (512 B)
+                min_io_size = 0 (0 B)
+                opt_io_size = 0 (0 B)
+                discard_granularity = 4294967295 (4 GiB)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "288"
@@ -1110,11 +1110,11 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -device floppy,drive=none0,drive-t
               dev: floppy, id ""
                 unit = 0 (0x0)
                 drive = "none0"
-                logical_block_size = 512 (0x200)
-                physical_block_size = 512 (0x200)
-                min_io_size = 0 (0x0)
-                opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                logical_block_size = 512 (512 B)
+                physical_block_size = 512 (512 B)
+                min_io_size = 0 (0 B)
+                opt_io_size = 0 (0 B)
+                discard_granularity = 4294967295 (4 GiB)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "120"
@@ -1137,11 +1137,11 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -device floppy,drive=none0,drive-t
               dev: floppy, id ""
                 unit = 0 (0x0)
                 drive = "none0"
-                logical_block_size = 512 (0x200)
-                physical_block_size = 512 (0x200)
-                min_io_size = 0 (0x0)
-                opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                logical_block_size = 512 (512 B)
+                physical_block_size = 512 (512 B)
+                min_io_size = 0 (0 B)
+                opt_io_size = 0 (0 B)
+                discard_granularity = 4294967295 (4 GiB)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "288"
@@ -1167,11 +1167,11 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -device floppy,drive=none0,logical
               dev: floppy, id ""
                 unit = 0 (0x0)
                 drive = "none0"
-                logical_block_size = 512 (0x200)
-                physical_block_size = 512 (0x200)
-                min_io_size = 0 (0x0)
-                opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                logical_block_size = 512 (512 B)
+                physical_block_size = 512 (512 B)
+                min_io_size = 0 (0 B)
+                opt_io_size = 0 (0 B)
+                discard_granularity = 4294967295 (4 GiB)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
@@ -1194,11 +1194,11 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -device floppy,drive=none0,physica
               dev: floppy, id ""
                 unit = 0 (0x0)
                 drive = "none0"
-                logical_block_size = 512 (0x200)
-                physical_block_size = 512 (0x200)
-                min_io_size = 0 (0x0)
-                opt_io_size = 0 (0x0)
-                discard_granularity = 4294967295 (0xffffffff)
+                logical_block_size = 512 (512 B)
+                physical_block_size = 512 (512 B)
+                min_io_size = 0 (0 B)
+                opt_io_size = 0 (0 B)
+                discard_granularity = 4294967295 (4 GiB)
                 write-cache = "auto"
                 share-rw = false
                 drive-type = "144"
-- 
2.26.2


