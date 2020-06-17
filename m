Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB1AC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 15:09:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55B9120707
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 15:09:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MRYRn8Ih"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55B9120707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlZgz-00057p-FU
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 11:09:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45808)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jlZOF-0003eG-A4
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 10:50:11 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:20445
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jlZOC-0001qU-MK
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 10:50:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592405408;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IAboVCEopLwq/H63SkvV8dIYUxGkdBAmKaYWgBotN3k=;
 b=MRYRn8IhDFFrnFN5YuUFhfd5bpX2bodj1ezP90Kg8pAyAnyT3iPu4CjgAR7uBOL3orbEOQ
 6ECsWj74e6SNdV5AGbY/tBdaj4x7Y77teXhH0pY4m5mzeGnXHElONXuNIxKBN1lqILLO70
 UIyVceDfU8nkZ3oTwePWZUV3zaeJUGg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-258-UvroBpQIMWi60hesAX_y_Q-1; Wed, 17 Jun 2020 10:50:02 -0400
X-MC-Unique: UvroBpQIMWi60hesAX_y_Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 25CB081CBF3;
 Wed, 17 Jun 2020 14:50:01 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-44.ams2.redhat.com [10.36.114.44])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2B6A57CAB0;
 Wed, 17 Jun 2020 14:50:00 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 35/43] block: make BlockConf size props 32bit and accept size
 suffixes
Date: Wed, 17 Jun 2020 16:49:01 +0200
Message-Id: <20200617144909.192176-36-kwolf@redhat.com>
In-Reply-To: <20200617144909.192176-1-kwolf@redhat.com>
References: <20200617144909.192176-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 02:02:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Roman Kagan <rvkagan@yandex-team.ru>

Convert all size-related properties in BlockConf to 32bit.  This will
accommodate bigger block sizes (in a followup patch).  This also allows
to make them all accept size suffixes, either via DEFINE_PROP_BLOCKSIZE
or via DEFINE_PROP_SIZE32.

Also, since min_io_size is exposed to the guest by scsi and virtio-blk
devices as an uint16_t in units of logical blocks, introduce an
additional check in blkconf_blocksizes to prevent its silent truncation.

Signed-off-by: Roman Kagan <rvkagan@yandex-team.ru>
Message-Id: <20200528225516.1676602-7-rvkagan@yandex-team.ru>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/hw/block/block.h     | 12 ++++++------
 include/hw/qdev-properties.h |  2 +-
 hw/block/block.c             | 10 ++++++++++
 hw/core/qdev-properties.c    |  4 ++--
 4 files changed, 19 insertions(+), 9 deletions(-)

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
index c03eadfad6..5252bb6b1a 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -200,7 +200,7 @@ extern const PropertyInfo qdev_prop_pcie_link_width;
 #define DEFINE_PROP_SIZE32(_n, _s, _f, _d)                       \
     DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, qdev_prop_size32, uint32_t)
 #define DEFINE_PROP_BLOCKSIZE(_n, _s, _f) \
-    DEFINE_PROP_UNSIGNED(_n, _s, _f, 0, qdev_prop_blocksize, uint16_t)
+    DEFINE_PROP_UNSIGNED(_n, _s, _f, 0, qdev_prop_blocksize, uint32_t)
 #define DEFINE_PROP_PCI_HOST_DEVADDR(_n, _s, _f) \
     DEFINE_PROP(_n, _s, _f, qdev_prop_pci_host_devaddr, PCIHostDeviceAddress)
 #define DEFINE_PROP_OFF_AUTO_PCIBAR(_n, _s, _f, _d) \
diff --git a/hw/block/block.c b/hw/block/block.c
index b22207c921..1e34573da7 100644
--- a/hw/block/block.c
+++ b/hw/block/block.c
@@ -96,6 +96,16 @@ bool blkconf_blocksizes(BlockConf *conf, Error **errp)
         return false;
     }
 
+    /*
+     * all devices which support min_io_size (scsi and virtio-blk) expose it to
+     * the guest as a uint16_t in units of logical blocks
+     */
+    if (conf->min_io_size / conf->logical_block_size > UINT16_MAX) {
+        error_setg(errp, "min_io_size must not exceed %u logical blocks",
+                   UINT16_MAX);
+        return false;
+    }
+
     if (!QEMU_IS_ALIGNED(conf->opt_io_size, conf->logical_block_size)) {
         error_setg(errp,
                    "opt_io_size must be a multiple of logical_block_size");
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index c9af6a1341..bd4abdc1d1 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -782,7 +782,7 @@ static void set_blocksize(Object *obj, Visitor *v, const char *name,
 {
     DeviceState *dev = DEVICE(obj);
     Property *prop = opaque;
-    uint16_t *ptr = qdev_get_prop_ptr(dev, prop);
+    uint32_t *ptr = qdev_get_prop_ptr(dev, prop);
     uint64_t value;
     Error *local_err = NULL;
 
@@ -821,7 +821,7 @@ const PropertyInfo qdev_prop_blocksize = {
     .name  = "size",
     .description = "A power of two between " MIN_BLOCK_SIZE_STR
                    " and " MAX_BLOCK_SIZE_STR,
-    .get   = get_uint16,
+    .get   = get_uint32,
     .set   = set_blocksize,
     .set_default_value = set_default_value_uint,
 };
-- 
2.25.4


