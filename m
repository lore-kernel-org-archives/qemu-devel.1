Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D43E1C0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 16:37:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE1DE2189E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 16:37:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE1DE2189E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiiG1-0004gH-Jv
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 12:37:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55222)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mlevitsk@redhat.com>) id 1hihgb-0007rc-IF
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 12:00:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1hihgZ-0002bA-JA
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 12:00:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42324)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1hihgT-0002Z6-CA; Wed, 03 Jul 2019 12:00:37 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A97BB21BAA;
 Wed,  3 Jul 2019 16:00:31 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (dhcp-4-67.tlv.redhat.com
 [10.35.4.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B59BB183B2;
 Wed,  3 Jul 2019 16:00:29 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed,  3 Jul 2019 18:59:42 +0300
Message-Id: <20190703155944.9637-5-mlevitsk@redhat.com>
In-Reply-To: <20190703155944.9637-1-mlevitsk@redhat.com>
References: <20190703155944.9637-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Wed, 03 Jul 2019 16:00:31 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 4/6] block/nvme: add support for image
 creation
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Tesed on a nvme device like that:

# create preallocated qcow2 image
$ qemu-img create -f qcow2 nvme://0000:06:00.0/1 10G -o preallocation=metadata
Formatting 'nvme://0000:06:00.0/1', fmt=qcow2 size=10737418240 cluster_size=65536 preallocation=metadata lazy_refcounts=off refcount_bits=16

# create an empty qcow2 image
$ qemu-img create -f qcow2 nvme://0000:06:00.0/1 10G -o preallocation=off
Formatting 'nvme://0000:06:00.0/1', fmt=qcow2 size=10737418240 cluster_size=65536 preallocation=off lazy_refcounts=off refcount_bits=16

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 block/nvme.c | 108 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 108 insertions(+)

diff --git a/block/nvme.c b/block/nvme.c
index 1f0d09349f..152d27b07f 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -1148,6 +1148,90 @@ static void nvme_aio_unplug(BlockDriverState *bs)
     }
 }
 
+static int coroutine_fn nvme_co_create_opts(const char *filename,
+        QemuOpts *opts, Error **errp)
+{
+
+    int64_t total_size = 0;
+    char *buf = NULL;
+    BlockDriverState *bs;
+    QEMUIOVector local_qiov;
+    int ret = 0;
+    int64_t blocksize;
+    QDict *options;
+    Error *local_err = NULL;
+    PreallocMode prealloc;
+
+    total_size = ROUND_UP(qemu_opt_get_size_del(opts, BLOCK_OPT_SIZE, 0),
+                              BDRV_SECTOR_SIZE);
+
+    buf = qemu_opt_get_del(opts, BLOCK_OPT_PREALLOC);
+    prealloc = qapi_enum_parse(&PreallocMode_lookup, buf,
+                                  PREALLOC_MODE_OFF, &local_err);
+    g_free(buf);
+
+    if (prealloc != PREALLOC_MODE_OFF) {
+        error_setg(errp, "Only prealloc=off is supported");
+        return -EINVAL;
+    }
+
+    options = qdict_new();
+    qdict_put_str(options, "driver", "nvme");
+    nvme_parse_filename(filename, options, &local_err);
+
+    if (local_err) {
+        error_propagate(errp, local_err);
+        qobject_unref(options);
+        return -EINVAL;
+    }
+
+    bs = bdrv_open(NULL, NULL, options,
+                       BDRV_O_RDWR | BDRV_O_RESIZE | BDRV_O_PROTOCOL, errp);
+    if (bs == NULL) {
+        return -EIO;
+    }
+
+    if (nvme_getlength(bs) < total_size) {
+        error_setg(errp, "Device is too small");
+        bdrv_unref(bs);
+        qobject_unref(options);
+        return -ENOSPC;
+    }
+
+    blocksize = nvme_get_blocksize(bs);
+    buf = qemu_try_blockalign0(bs, blocksize);
+    qemu_iovec_init(&local_qiov, 1);
+    qemu_iovec_add(&local_qiov, buf, blocksize);
+
+    ret = nvme_co_prw_aligned(bs, 0, blocksize,
+            &local_qiov, true, BDRV_REQ_FUA);
+    if (ret) {
+        error_setg(errp, "Write error to sector 0");
+    }
+
+    qemu_vfree(buf);
+    bdrv_unref(bs);
+    return ret;
+}
+
+
+static int coroutine_fn nvme_co_truncate(BlockDriverState *bs, int64_t offset,
+                                        PreallocMode prealloc, Error **errp)
+{
+    if (prealloc != PREALLOC_MODE_OFF) {
+        error_setg(errp, "Preallocation mode '%s' unsupported nvme devices",
+                PreallocMode_str(prealloc));
+        return -ENOTSUP;
+    }
+
+    if (offset > nvme_getlength(bs)) {
+        error_setg(errp, "Cannot grow nvme devices");
+        return -EINVAL;
+    }
+
+    return 0;
+}
+
 static void nvme_register_buf(BlockDriverState *bs, void *host, size_t size)
 {
     int ret;
@@ -1169,6 +1253,7 @@ static void nvme_unregister_buf(BlockDriverState *bs, void *host)
     qemu_vfio_dma_unmap(s->vfio, host);
 }
 
+
 static const char *const nvme_strong_runtime_opts[] = {
     NVME_BLOCK_OPT_DEVICE,
     NVME_BLOCK_OPT_NAMESPACE,
@@ -1176,6 +1261,25 @@ static const char *const nvme_strong_runtime_opts[] = {
     NULL
 };
 
+
+static QemuOptsList nvme_create_opts = {
+    .name = "nvme-create-opts",
+    .head = QTAILQ_HEAD_INITIALIZER(nvme_create_opts.head),
+    .desc = {
+        {
+            .name = BLOCK_OPT_SIZE,
+            .type = QEMU_OPT_SIZE,
+            .help = "Virtual disk size"
+        },
+        {
+            .name = BLOCK_OPT_PREALLOC,
+            .type = QEMU_OPT_STRING,
+            .help = "Preallocation mode (allowed values: off)",
+        },
+        { /* end of list */ }
+    }
+};
+
 static BlockDriver bdrv_nvme = {
     .format_name              = "nvme",
     .protocol_name            = "nvme",
@@ -1187,6 +1291,10 @@ static BlockDriver bdrv_nvme = {
     .bdrv_getlength           = nvme_getlength,
     .bdrv_probe_blocksizes    = nvme_probe_blocksizes,
 
+    .bdrv_co_create_opts      = nvme_co_create_opts,
+    .bdrv_co_truncate         = nvme_co_truncate,
+    .create_opts              = &nvme_create_opts,
+
     .bdrv_co_preadv           = nvme_co_preadv,
     .bdrv_co_pwritev          = nvme_co_pwritev,
     .bdrv_co_flush_to_disk    = nvme_co_flush,
-- 
2.17.2


