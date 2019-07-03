Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE1BC06513
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 16:30:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08E4F218A6
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 16:30:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08E4F218A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hii9R-0006YI-9p
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 12:30:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55166)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mlevitsk@redhat.com>) id 1hihgR-0007fy-9U
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 12:00:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1hihgP-0002Xd-Va
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 12:00:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35848)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1hihgM-0002UG-Ff; Wed, 03 Jul 2019 12:00:30 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6141C81DF1;
 Wed,  3 Jul 2019 16:00:29 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (dhcp-4-67.tlv.redhat.com
 [10.35.4.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D5DB73781;
 Wed,  3 Jul 2019 16:00:21 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed,  3 Jul 2019 18:59:41 +0300
Message-Id: <20190703155944.9637-4-mlevitsk@redhat.com>
In-Reply-To: <20190703155944.9637-1-mlevitsk@redhat.com>
References: <20190703155944.9637-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Wed, 03 Jul 2019 16:00:29 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 3/6] block/nvme: support larger that 512
 bytes sector devices
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

Currently the driver hardcodes the sector size to 512,
and doesn't check the underlying device. Fix that.

Also fail if underlying nvme device is formatted with metadata
as this needs special support.

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 block/nvme.c | 45 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 40 insertions(+), 5 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index 52798081b2..1f0d09349f 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -102,8 +102,11 @@ typedef struct {
     size_t doorbell_scale;
     bool write_cache_supported;
     EventNotifier irq_notifier;
+
     uint64_t nsze; /* Namespace size reported by identify command */
     int nsid;      /* The namespace id to read/write data. */
+    size_t blkshift;
+
     uint64_t max_transfer;
     bool plugged;
 
@@ -415,8 +418,9 @@ static void nvme_identify(BlockDriverState *bs, int namespace, Error **errp)
     BDRVNVMeState *s = bs->opaque;
     NvmeIdCtrl *idctrl;
     NvmeIdNs *idns;
+    NvmeLBAF *lbaf;
     uint8_t *resp;
-    int r;
+    int r, hwsect_size;
     uint64_t iova;
     NvmeCmd cmd = {
         .opcode = NVME_ADM_CMD_IDENTIFY,
@@ -463,7 +467,22 @@ static void nvme_identify(BlockDriverState *bs, int namespace, Error **errp)
     }
 
     s->nsze = le64_to_cpu(idns->nsze);
+    lbaf = &idns->lbaf[NVME_ID_NS_FLBAS_INDEX(idns->flbas)];
+
+    if (lbaf->ms) {
+        error_setg(errp, "Namespaces with metadata are not yet supported");
+        goto out;
+    }
+
+    hwsect_size = 1 << lbaf->ds;
+
+    if (hwsect_size < BDRV_SECTOR_BITS || hwsect_size > s->page_size) {
+        error_setg(errp, "Namespace has unsupported block size (%d)",
+                hwsect_size);
+        goto out;
+    }
 
+    s->blkshift = lbaf->ds;
 out:
     qemu_vfio_dma_unmap(s->vfio, resp);
     qemu_vfree(resp);
@@ -782,8 +801,22 @@ fail:
 static int64_t nvme_getlength(BlockDriverState *bs)
 {
     BDRVNVMeState *s = bs->opaque;
+    return s->nsze << s->blkshift;
+}
 
-    return s->nsze << BDRV_SECTOR_BITS;
+static int64_t nvme_get_blocksize(BlockDriverState *bs)
+{
+    BDRVNVMeState *s = bs->opaque;
+    assert(s->blkshift >= 9);
+    return 1 << s->blkshift;
+}
+
+static int nvme_probe_blocksizes(BlockDriverState *bs, BlockSizes *bsz)
+{
+    int64_t blocksize = nvme_get_blocksize(bs);
+    bsz->phys = blocksize;
+    bsz->log = blocksize;
+    return 0;
 }
 
 /* Called with s->dma_map_lock */
@@ -914,13 +947,14 @@ static coroutine_fn int nvme_co_prw_aligned(BlockDriverState *bs,
     BDRVNVMeState *s = bs->opaque;
     NVMeQueuePair *ioq = s->queues[1];
     NVMeRequest *req;
-    uint32_t cdw12 = (((bytes >> BDRV_SECTOR_BITS) - 1) & 0xFFFF) |
+
+    uint32_t cdw12 = (((bytes >> s->blkshift) - 1) & 0xFFFF) |
                        (flags & BDRV_REQ_FUA ? 1 << 30 : 0);
     NvmeCmd cmd = {
         .opcode = is_write ? NVME_CMD_WRITE : NVME_CMD_READ,
         .nsid = cpu_to_le32(s->nsid),
-        .cdw10 = cpu_to_le32((offset >> BDRV_SECTOR_BITS) & 0xFFFFFFFF),
-        .cdw11 = cpu_to_le32(((offset >> BDRV_SECTOR_BITS) >> 32) & 0xFFFFFFFF),
+        .cdw10 = cpu_to_le32((offset >> s->blkshift) & 0xFFFFFFFF),
+        .cdw11 = cpu_to_le32(((offset >> s->blkshift) >> 32) & 0xFFFFFFFF),
         .cdw12 = cpu_to_le32(cdw12),
     };
     NVMeCoData data = {
@@ -1151,6 +1185,7 @@ static BlockDriver bdrv_nvme = {
     .bdrv_file_open           = nvme_file_open,
     .bdrv_close               = nvme_close,
     .bdrv_getlength           = nvme_getlength,
+    .bdrv_probe_blocksizes    = nvme_probe_blocksizes,
 
     .bdrv_co_preadv           = nvme_co_preadv,
     .bdrv_co_pwritev          = nvme_co_pwritev,
-- 
2.17.2


