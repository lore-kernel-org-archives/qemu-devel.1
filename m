Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5786ACA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 12:58:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 211EF20873
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 12:58:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hxgoSgZd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 211EF20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP4bl-00027Q-Kp
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 08:58:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50724)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iP3wt-0002lY-V1
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:16:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iP3wq-0001wX-Jj
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:16:38 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:26956
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iP3wq-0001vn-FR
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:16:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572264995;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MxBajAlKda7hh+AywwwSzXruhU7iGlOEpLawksUo4Uo=;
 b=hxgoSgZdLgWxJG5uNFsM5FaAToGPTRmDdtd5FH+EyI9Gf12E2ByQdMfcoQUfEusDox2s+s
 qtNiXzz08jqtdTlZf3Z3aooU2YOKQNbN6CTNOfXi8vgO5QbG3PsGCkHY82MgSihXbWDDQ/
 mWJC/LRMl+Mphv1WfXyQdh5+3VSc0TI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-80-49kPFR0pOOi9lILjD0HoGw-1; Mon, 28 Oct 2019 08:16:31 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 60C00800FF1;
 Mon, 28 Oct 2019 12:16:30 +0000 (UTC)
Received: from localhost (ovpn-117-83.ams2.redhat.com [10.36.117.83])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CFF8E60BF7;
 Mon, 28 Oct 2019 12:16:29 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 42/69] block/nvme: add support for write zeros
Date: Mon, 28 Oct 2019 13:14:34 +0100
Message-Id: <20191028121501.15279-43-mreitz@redhat.com>
In-Reply-To: <20191028121501.15279-1-mreitz@redhat.com>
References: <20191028121501.15279-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 49kPFR0pOOi9lILjD0HoGw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
Message-id: 20190913133627.28450-2-mlevitsk@redhat.com
Reviewed-by: John Snow <jsnow@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 include/block/nvme.h | 19 +++++++++++-
 block/nvme.c         | 72 +++++++++++++++++++++++++++++++++++++++++++-
 block/trace-events   |  1 +
 3 files changed, 90 insertions(+), 2 deletions(-)

diff --git a/include/block/nvme.h b/include/block/nvme.h
index 3ec8efcc43..ab5943b90a 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -653,12 +653,29 @@ typedef struct NvmeIdNs {
     uint8_t     mc;
     uint8_t     dpc;
     uint8_t     dps;
-    uint8_t     res30[98];
+
+    uint8_t     nmic;
+    uint8_t     rescap;
+    uint8_t     fpi;
+    uint8_t     dlfeat;
+
+    uint8_t     res34[94];
     NvmeLBAF    lbaf[16];
     uint8_t     res192[192];
     uint8_t     vs[3712];
 } NvmeIdNs;
=20
+
+/*Deallocate Logical Block Features*/
+#define NVME_ID_NS_DLFEAT_GUARD_CRC(dlfeat)       ((dlfeat) & 0x10)
+#define NVME_ID_NS_DLFEAT_WRITE_ZEROES(dlfeat)    ((dlfeat) & 0x08)
+
+#define NVME_ID_NS_DLFEAT_READ_BEHAVIOR(dlfeat)     ((dlfeat) & 0x7)
+#define NVME_ID_NS_DLFEAT_READ_BEHAVIOR_UNDEFINED   0
+#define NVME_ID_NS_DLFEAT_READ_BEHAVIOR_ZEROES      1
+#define NVME_ID_NS_DLFEAT_READ_BEHAVIOR_ONES        2
+
+
 #define NVME_ID_NS_NSFEAT_THIN(nsfeat)      ((nsfeat & 0x1))
 #define NVME_ID_NS_FLBAS_EXTENDED(flbas)    ((flbas >> 4) & 0x1)
 #define NVME_ID_NS_FLBAS_INDEX(flbas)       ((flbas & 0xf))
diff --git a/block/nvme.c b/block/nvme.c
index 910872ec59..0ac38c24e6 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -112,6 +112,8 @@ typedef struct {
     uint64_t max_transfer;
     bool plugged;
=20
+    bool supports_write_zeroes;
+
     CoMutex dma_map_lock;
     CoQueue dma_flush_queue;
=20
@@ -423,6 +425,7 @@ static void nvme_identify(BlockDriverState *bs, int nam=
espace, Error **errp)
     NvmeIdNs *idns;
     NvmeLBAF *lbaf;
     uint8_t *resp;
+    uint16_t oncs;
     int r;
     uint64_t iova;
     NvmeCmd cmd =3D {
@@ -460,6 +463,9 @@ static void nvme_identify(BlockDriverState *bs, int nam=
espace, Error **errp)
     s->max_transfer =3D MIN_NON_ZERO(s->max_transfer,
                           s->page_size / sizeof(uint64_t) * s->page_size);
=20
+    oncs =3D le16_to_cpu(idctrl->oncs);
+    s->supports_write_zeroes =3D !!(oncs & NVME_ONCS_WRITE_ZEROS);
+
     memset(resp, 0, 4096);
=20
     cmd.cdw10 =3D 0;
@@ -472,6 +478,12 @@ static void nvme_identify(BlockDriverState *bs, int na=
mespace, Error **errp)
     s->nsze =3D le64_to_cpu(idns->nsze);
     lbaf =3D &idns->lbaf[NVME_ID_NS_FLBAS_INDEX(idns->flbas)];
=20
+    if (NVME_ID_NS_DLFEAT_WRITE_ZEROES(idns->dlfeat) &&
+            NVME_ID_NS_DLFEAT_READ_BEHAVIOR(idns->dlfeat) =3D=3D
+                    NVME_ID_NS_DLFEAT_READ_BEHAVIOR_ZEROES) {
+        bs->supported_write_flags |=3D BDRV_REQ_MAY_UNMAP;
+    }
+
     if (lbaf->ms) {
         error_setg(errp, "Namespaces with metadata are not yet supported")=
;
         goto out;
@@ -766,6 +778,8 @@ static int nvme_file_open(BlockDriverState *bs, QDict *=
options, int flags,
     int ret;
     BDRVNVMeState *s =3D bs->opaque;
=20
+    bs->supported_write_flags =3D BDRV_REQ_FUA;
+
     opts =3D qemu_opts_create(&runtime_opts, NULL, 0, &error_abort);
     qemu_opts_absorb_qdict(opts, options, &error_abort);
     device =3D qemu_opt_get(opts, NVME_BLOCK_OPT_DEVICE);
@@ -794,7 +808,6 @@ static int nvme_file_open(BlockDriverState *bs, QDict *=
options, int flags,
             goto fail;
         }
     }
-    bs->supported_write_flags =3D BDRV_REQ_FUA;
     return 0;
 fail:
     nvme_close(bs);
@@ -1088,6 +1101,60 @@ static coroutine_fn int nvme_co_flush(BlockDriverSta=
te *bs)
 }
=20
=20
+static coroutine_fn int nvme_co_pwrite_zeroes(BlockDriverState *bs,
+                                              int64_t offset,
+                                              int bytes,
+                                              BdrvRequestFlags flags)
+{
+    BDRVNVMeState *s =3D bs->opaque;
+    NVMeQueuePair *ioq =3D s->queues[1];
+    NVMeRequest *req;
+
+    uint32_t cdw12 =3D ((bytes >> s->blkshift) - 1) & 0xFFFF;
+
+    if (!s->supports_write_zeroes) {
+        return -ENOTSUP;
+    }
+
+    NvmeCmd cmd =3D {
+        .opcode =3D NVME_CMD_WRITE_ZEROS,
+        .nsid =3D cpu_to_le32(s->nsid),
+        .cdw10 =3D cpu_to_le32((offset >> s->blkshift) & 0xFFFFFFFF),
+        .cdw11 =3D cpu_to_le32(((offset >> s->blkshift) >> 32) & 0xFFFFFFF=
F),
+    };
+
+    NVMeCoData data =3D {
+        .ctx =3D bdrv_get_aio_context(bs),
+        .ret =3D -EINPROGRESS,
+    };
+
+    if (flags & BDRV_REQ_MAY_UNMAP) {
+        cdw12 |=3D (1 << 25);
+    }
+
+    if (flags & BDRV_REQ_FUA) {
+        cdw12 |=3D (1 << 30);
+    }
+
+    cmd.cdw12 =3D cpu_to_le32(cdw12);
+
+    trace_nvme_write_zeroes(s, offset, bytes, flags);
+    assert(s->nr_queues > 1);
+    req =3D nvme_get_free_req(ioq);
+    assert(req);
+
+    nvme_submit_command(s, ioq, req, &cmd, nvme_rw_cb, &data);
+
+    data.co =3D qemu_coroutine_self();
+    while (data.ret =3D=3D -EINPROGRESS) {
+        qemu_coroutine_yield();
+    }
+
+    trace_nvme_rw_done(s, true, offset, bytes, data.ret);
+    return data.ret;
+}
+
+
 static int nvme_reopen_prepare(BDRVReopenState *reopen_state,
                                BlockReopenQueue *queue, Error **errp)
 {
@@ -1192,6 +1259,9 @@ static BlockDriver bdrv_nvme =3D {
=20
     .bdrv_co_preadv           =3D nvme_co_preadv,
     .bdrv_co_pwritev          =3D nvme_co_pwritev,
+
+    .bdrv_co_pwrite_zeroes    =3D nvme_co_pwrite_zeroes,
+
     .bdrv_co_flush_to_disk    =3D nvme_co_flush,
     .bdrv_reopen_prepare      =3D nvme_reopen_prepare,
=20
diff --git a/block/trace-events b/block/trace-events
index ccde15a14c..8706eab170 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -152,6 +152,7 @@ nvme_submit_command_raw(int c0, int c1, int c2, int c3,=
 int c4, int c5, int c6,
 nvme_handle_event(void *s) "s %p"
 nvme_poll_cb(void *s) "s %p"
 nvme_prw_aligned(void *s, int is_write, uint64_t offset, uint64_t bytes, i=
nt flags, int niov) "s %p is_write %d offset %"PRId64" bytes %"PRId64" flag=
s %d niov %d"
+nvme_write_zeroes(void *s, uint64_t offset, uint64_t bytes, int flags) "s =
%p offset %"PRId64" bytes %"PRId64" flags %d"
 nvme_qiov_unaligned(const void *qiov, int n, void *base, size_t size, int =
align) "qiov %p n %d base %p size 0x%zx align 0x%x"
 nvme_prw_buffered(void *s, uint64_t offset, uint64_t bytes, int niov, int =
is_write) "s %p offset %"PRId64" bytes %"PRId64" niov %d is_write %d"
 nvme_rw_done(void *s, int is_write, uint64_t offset, uint64_t bytes, int r=
et) "s %p is_write %d offset %"PRId64" bytes %"PRId64" ret %d"
--=20
2.21.0


