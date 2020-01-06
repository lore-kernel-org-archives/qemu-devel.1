Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8751CC33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 15:15:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1023F20707
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 15:15:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JZGB72tn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1023F20707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioU69-00052K-1A
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 10:15:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44369)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1ioTbk-0007Uc-1x
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 09:43:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1ioTbi-0000ww-GE
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 09:43:51 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30320
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1ioTbi-0000wP-CC
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 09:43:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578321829;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hm6QfIxR3LaHwtOs1bSTrud2MauR+uxy3BxBrarzp/c=;
 b=JZGB72tn2ZXQSHQo044AOgad0lwyUvHg1M5z6VZPHUebyVSPaBjIeUifjAjyHpG0q3zGpB
 lVQFXEwEGIKc/nThG1LUuwlSruxKeQtvM6NUUZreP5i7fIDSIF990p41qCSy3wGzXz/RWA
 BZdKl+S5NBHatJcesGf+ESCRaQCW6dI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-1XabV9-wPWu4sIpw4fp7vQ-1; Mon, 06 Jan 2020 09:43:48 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 78CB0107BAA9;
 Mon,  6 Jan 2020 14:43:47 +0000 (UTC)
Received: from localhost (ovpn-117-91.ams2.redhat.com [10.36.117.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 16433100164D;
 Mon,  6 Jan 2020 14:43:46 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 31/34] qcow2: Allow writing compressed data of multiple clusters
Date: Mon,  6 Jan 2020 15:42:03 +0100
Message-Id: <20200106144206.698920-32-mreitz@redhat.com>
In-Reply-To: <20200106144206.698920-1-mreitz@redhat.com>
References: <20200106144206.698920-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: 1XabV9-wPWu4sIpw4fp7vQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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

From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>

QEMU currently supports writing compressed data of the size equal to
one cluster. This patch allows writing QCOW2 compressed data that
exceed one cluster. Now, we split buffered data into separate clusters
and write them compressed using the block/aio_task API.

Suggested-by: Pavel Butsykin <pbutsykin@virtuozzo.com>
Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-id: 1575288906-551879-3-git-send-email-andrey.shinkevich@virtuozzo.=
com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2.c | 102 +++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 75 insertions(+), 27 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 7fbaac8457..cef9d72b3a 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -4221,10 +4221,8 @@ fail:
     return ret;
 }
=20
-/* XXX: put compressed sectors first, then all the cluster aligned
-   tables to avoid losing bytes in alignment */
 static coroutine_fn int
-qcow2_co_pwritev_compressed_part(BlockDriverState *bs,
+qcow2_co_pwritev_compressed_task(BlockDriverState *bs,
                                  uint64_t offset, uint64_t bytes,
                                  QEMUIOVector *qiov, size_t qiov_offset)
 {
@@ -4234,32 +4232,11 @@ qcow2_co_pwritev_compressed_part(BlockDriverState *=
bs,
     uint8_t *buf, *out_buf;
     uint64_t cluster_offset;
=20
-    if (has_data_file(bs)) {
-        return -ENOTSUP;
-    }
-
-    if (bytes =3D=3D 0) {
-        /* align end of file to a sector boundary to ease reading with
-           sector based I/Os */
-        int64_t len =3D bdrv_getlength(bs->file->bs);
-        if (len < 0) {
-            return len;
-        }
-        return bdrv_co_truncate(bs->file, len, false, PREALLOC_MODE_OFF, N=
ULL);
-    }
-
-    if (offset_into_cluster(s, offset)) {
-        return -EINVAL;
-    }
+    assert(bytes =3D=3D s->cluster_size || (bytes < s->cluster_size &&
+           (offset + bytes =3D=3D bs->total_sectors << BDRV_SECTOR_BITS)))=
;
=20
     buf =3D qemu_blockalign(bs, s->cluster_size);
-    if (bytes !=3D s->cluster_size) {
-        if (bytes > s->cluster_size ||
-            offset + bytes !=3D bs->total_sectors << BDRV_SECTOR_BITS)
-        {
-            qemu_vfree(buf);
-            return -EINVAL;
-        }
+    if (bytes < s->cluster_size) {
         /* Zero-pad last write if image size is not cluster aligned */
         memset(buf + bytes, 0, s->cluster_size - bytes);
     }
@@ -4308,6 +4285,77 @@ fail:
     return ret;
 }
=20
+static coroutine_fn int qcow2_co_pwritev_compressed_task_entry(AioTask *ta=
sk)
+{
+    Qcow2AioTask *t =3D container_of(task, Qcow2AioTask, task);
+
+    assert(!t->cluster_type && !t->l2meta);
+
+    return qcow2_co_pwritev_compressed_task(t->bs, t->offset, t->bytes, t-=
>qiov,
+                                            t->qiov_offset);
+}
+
+/*
+ * XXX: put compressed sectors first, then all the cluster aligned
+ * tables to avoid losing bytes in alignment
+ */
+static coroutine_fn int
+qcow2_co_pwritev_compressed_part(BlockDriverState *bs,
+                                 uint64_t offset, uint64_t bytes,
+                                 QEMUIOVector *qiov, size_t qiov_offset)
+{
+    BDRVQcow2State *s =3D bs->opaque;
+    AioTaskPool *aio =3D NULL;
+    int ret =3D 0;
+
+    if (has_data_file(bs)) {
+        return -ENOTSUP;
+    }
+
+    if (bytes =3D=3D 0) {
+        /*
+         * align end of file to a sector boundary to ease reading with
+         * sector based I/Os
+         */
+        int64_t len =3D bdrv_getlength(bs->file->bs);
+        if (len < 0) {
+            return len;
+        }
+        return bdrv_co_truncate(bs->file, len, false, PREALLOC_MODE_OFF, N=
ULL);
+    }
+
+    if (offset_into_cluster(s, offset)) {
+        return -EINVAL;
+    }
+
+    while (bytes && aio_task_pool_status(aio) =3D=3D 0) {
+        uint64_t chunk_size =3D MIN(bytes, s->cluster_size);
+
+        if (!aio && chunk_size !=3D bytes) {
+            aio =3D aio_task_pool_new(QCOW2_MAX_WORKERS);
+        }
+
+        ret =3D qcow2_add_task(bs, aio, qcow2_co_pwritev_compressed_task_e=
ntry,
+                             0, 0, offset, chunk_size, qiov, qiov_offset, =
NULL);
+        if (ret < 0) {
+            break;
+        }
+        qiov_offset +=3D chunk_size;
+        offset +=3D chunk_size;
+        bytes -=3D chunk_size;
+    }
+
+    if (aio) {
+        aio_task_pool_wait_all(aio);
+        if (ret =3D=3D 0) {
+            ret =3D aio_task_pool_status(aio);
+        }
+        g_free(aio);
+    }
+
+    return ret;
+}
+
 static int coroutine_fn
 qcow2_co_preadv_compressed(BlockDriverState *bs,
                            uint64_t file_cluster_offset,
--=20
2.24.1


