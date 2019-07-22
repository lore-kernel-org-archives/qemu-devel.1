Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A65C76190
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 17:27:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 467DE217D4
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 17:27:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 467DE217D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpc5t-0002zU-3E
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 13:27:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51191)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hpc5Z-00020b-5y
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 13:27:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hpc5Y-0004W6-0q
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 13:27:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58658)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hpc5N-0004Mh-Q8; Mon, 22 Jul 2019 13:26:55 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B644985538;
 Mon, 22 Jul 2019 17:26:45 +0000 (UTC)
Received: from localhost (unknown [10.40.205.2])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CC75B61377;
 Mon, 22 Jul 2019 17:26:44 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Mon, 22 Jul 2019 19:26:13 +0200
Message-Id: <20190722172616.28797-3-mreitz@redhat.com>
In-Reply-To: <20190722172616.28797-1-mreitz@redhat.com>
References: <20190722172616.28797-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Mon, 22 Jul 2019 17:26:45 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 2/5] block/nvme: support larger that 512 bytes
 sector devices
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Maxim Levitsky <mlevitsk@redhat.com>

Currently the driver hardcodes the sector size to 512,
and doesn't check the underlying device. Fix that.

Also fail if underlying nvme device is formatted with metadata
as this needs special support.

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
Message-id: 20190716163020.13383-3-mlevitsk@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/nvme.c | 45 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 40 insertions(+), 5 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index 82fdefccd6..35ce10dc79 100644
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
=20
@@ -418,8 +421,9 @@ static void nvme_identify(BlockDriverState *bs, int n=
amespace, Error **errp)
     BDRVNVMeState *s =3D bs->opaque;
     NvmeIdCtrl *idctrl;
     NvmeIdNs *idns;
+    NvmeLBAF *lbaf;
     uint8_t *resp;
-    int r;
+    int r, hwsect_size;
     uint64_t iova;
     NvmeCmd cmd =3D {
         .opcode =3D NVME_ADM_CMD_IDENTIFY,
@@ -466,7 +470,22 @@ static void nvme_identify(BlockDriverState *bs, int =
namespace, Error **errp)
     }
=20
     s->nsze =3D le64_to_cpu(idns->nsze);
+    lbaf =3D &idns->lbaf[NVME_ID_NS_FLBAS_INDEX(idns->flbas)];
+
+    if (lbaf->ms) {
+        error_setg(errp, "Namespaces with metadata are not yet supported=
");
+        goto out;
+    }
+
+    hwsect_size =3D 1 << lbaf->ds;
+
+    if (hwsect_size < BDRV_SECTOR_SIZE || hwsect_size > s->page_size) {
+        error_setg(errp, "Namespace has unsupported block size (%d)",
+                hwsect_size);
+        goto out;
+    }
=20
+    s->blkshift =3D lbaf->ds;
 out:
     qemu_vfio_dma_unmap(s->vfio, resp);
     qemu_vfree(resp);
@@ -785,8 +804,22 @@ fail:
 static int64_t nvme_getlength(BlockDriverState *bs)
 {
     BDRVNVMeState *s =3D bs->opaque;
+    return s->nsze << s->blkshift;
+}
=20
-    return s->nsze << BDRV_SECTOR_BITS;
+static int64_t nvme_get_blocksize(BlockDriverState *bs)
+{
+    BDRVNVMeState *s =3D bs->opaque;
+    assert(s->blkshift >=3D BDRV_SECTOR_BITS);
+    return 1 << s->blkshift;
+}
+
+static int nvme_probe_blocksizes(BlockDriverState *bs, BlockSizes *bsz)
+{
+    int64_t blocksize =3D nvme_get_blocksize(bs);
+    bsz->phys =3D blocksize;
+    bsz->log =3D blocksize;
+    return 0;
 }
=20
 /* Called with s->dma_map_lock */
@@ -917,13 +950,14 @@ static coroutine_fn int nvme_co_prw_aligned(BlockDr=
iverState *bs,
     BDRVNVMeState *s =3D bs->opaque;
     NVMeQueuePair *ioq =3D s->queues[1];
     NVMeRequest *req;
-    uint32_t cdw12 =3D (((bytes >> BDRV_SECTOR_BITS) - 1) & 0xFFFF) |
+
+    uint32_t cdw12 =3D (((bytes >> s->blkshift) - 1) & 0xFFFF) |
                        (flags & BDRV_REQ_FUA ? 1 << 30 : 0);
     NvmeCmd cmd =3D {
         .opcode =3D is_write ? NVME_CMD_WRITE : NVME_CMD_READ,
         .nsid =3D cpu_to_le32(s->nsid),
-        .cdw10 =3D cpu_to_le32((offset >> BDRV_SECTOR_BITS) & 0xFFFFFFFF=
),
-        .cdw11 =3D cpu_to_le32(((offset >> BDRV_SECTOR_BITS) >> 32) & 0x=
FFFFFFFF),
+        .cdw10 =3D cpu_to_le32((offset >> s->blkshift) & 0xFFFFFFFF),
+        .cdw11 =3D cpu_to_le32(((offset >> s->blkshift) >> 32) & 0xFFFFF=
FFF),
         .cdw12 =3D cpu_to_le32(cdw12),
     };
     NVMeCoData data =3D {
@@ -1154,6 +1188,7 @@ static BlockDriver bdrv_nvme =3D {
     .bdrv_file_open           =3D nvme_file_open,
     .bdrv_close               =3D nvme_close,
     .bdrv_getlength           =3D nvme_getlength,
+    .bdrv_probe_blocksizes    =3D nvme_probe_blocksizes,
=20
     .bdrv_co_preadv           =3D nvme_co_preadv,
     .bdrv_co_pwritev          =3D nvme_co_pwritev,
--=20
2.21.0


