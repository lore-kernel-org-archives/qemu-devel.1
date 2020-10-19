Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEBE6C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 12:59:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28BAF222C3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 12:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="cKpJOMic"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28BAF222C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUUkv-0003gj-TS
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 08:59:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35814)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <b036d9ac690943af93929ede376c4482c8f97bf2@lizzy.crudebyte.com>)
 id 1kUUiF-0000ph-5U
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 08:56:31 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:38859)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <b036d9ac690943af93929ede376c4482c8f97bf2@lizzy.crudebyte.com>)
 id 1kUUiD-00016d-8s
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 08:56:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=RjDWU12Vo0+sJWdQyous484JI53NVblvHVHec2R9FCY=; b=cKpJO
 Micp5k3kipnO2BOlam/Ci9EOLIJ+pH7zf1GMwz3oCbv9mvQm47ab72J6qbIM0mA9AwHoqcWcOv3d7
 TxpB7E0XmSskH5sxzF/5d9ed86c4XwMTwZktd61b7JpAvafDlN7LuJl4tZwzpaHu9fw2C18YIXd0S
 715WjkzaAJPCHipB08ALCektt+e+0qPv2IbXohpK1nNNhz/axSFT35kN9XCzJBvukCVHxfapUvS+y
 hG5CYZ6+MNI+tgx5/myNut6hR9ByhU6JoCCPZAh+k/qPn7L9XfDWUYw28K9ehJIaW5P0YxGiHGTiI
 s/WKUgmQFvlSV2epX6HO4C3bVdxjQ==;
Message-Id: <b036d9ac690943af93929ede376c4482c8f97bf2.1603111175.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1603111175.git.qemu_oss@crudebyte.com>
References: <cover.1603111175.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Mon, 19 Oct 2020 13:10:18 +0200
Subject: [PULL v3 1/6] 9pfs: suppress performance warnings on qtest runs
To: qemu-devel@nongnu.org,
    Peter Maydell <peter.maydell@linaro.org>
Cc: Greg Kurz <groug@kaod.org>
Received-SPF: none client-ip=91.194.90.13;
 envelope-from=b036d9ac690943af93929ede376c4482c8f97bf2@lizzy.crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 06:27:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Don't trigger any performance warning if we're just running test cases,
because tests intentionally run for edge cases.

So far performance warnings were suppressed for the 'synth' fs driver
backend only. This patch suppresses them for all 9p fs driver backends.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Message-Id: <a2d2ff2163f8853ea782a7a1d4e6f2afd7c29ffe.1603106145.git.qemu_oss@crudebyte.com>
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 hw/9pfs/9p-synth.c         | 2 --
 hw/9pfs/virtio-9p-device.c | 6 ++++++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/9pfs/9p-synth.c b/hw/9pfs/9p-synth.c
index cec8c0eefc..7eb210ffa8 100644
--- a/hw/9pfs/9p-synth.c
+++ b/hw/9pfs/9p-synth.c
@@ -541,8 +541,6 @@ static int synth_init(FsContext *ctx, Error **errp)
     QLIST_INIT(&synth_root.child);
     qemu_mutex_init(&synth_mutex);
 
-    ctx->export_flags |= V9FS_NO_PERF_WARN;
-
     /* Add "." and ".." entries for root */
     v9fs_add_dir_node(&synth_root, synth_root.attr->mode,
                       "..", synth_root.attr, synth_root.attr->inode);
diff --git a/hw/9pfs/virtio-9p-device.c b/hw/9pfs/virtio-9p-device.c
index 36f3aa9352..14371a78ef 100644
--- a/hw/9pfs/virtio-9p-device.c
+++ b/hw/9pfs/virtio-9p-device.c
@@ -21,6 +21,7 @@
 #include "hw/virtio/virtio-access.h"
 #include "qemu/iov.h"
 #include "qemu/module.h"
+#include "sysemu/qtest.h"
 
 static void virtio_9p_push_and_notify(V9fsPDU *pdu)
 {
@@ -199,6 +200,11 @@ static void virtio_9p_device_realize(DeviceState *dev, Error **errp)
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     V9fsVirtioState *v = VIRTIO_9P(dev);
     V9fsState *s = &v->state;
+    FsDriverEntry *fse = get_fsdev_fsentry(s->fsconf.fsdev_id);
+
+    if (qtest_enabled() && fse) {
+        fse->export_flags |= V9FS_NO_PERF_WARN;
+    }
 
     if (v9fs_device_realize_common(s, &virtio_9p_transport, errp)) {
         return;
-- 
2.20.1


