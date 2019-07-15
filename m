Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F325C7618F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 10:46:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77AE82080A
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 10:46:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77AE82080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hmyV1-0006Fk-MT
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 06:46:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39329)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hmyTv-0002AU-CF
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 06:45:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hmyTu-0001fU-9P
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 06:45:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34530)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hmyTr-0001do-Ma; Mon, 15 Jul 2019 06:45:15 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0B5D6307D847;
 Mon, 15 Jul 2019 10:45:15 +0000 (UTC)
Received: from localhost (unknown [10.40.205.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5F8014505;
 Mon, 15 Jul 2019 10:45:14 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Mon, 15 Jul 2019 12:45:05 +0200
Message-Id: <20190715104508.7568-2-mreitz@redhat.com>
In-Reply-To: <20190715104508.7568-1-mreitz@redhat.com>
References: <20190715104508.7568-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Mon, 15 Jul 2019 10:45:15 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH for-4.1? 1/4] qcow2: Fix .bdrv_has_zero_init()
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
Cc: Kevin Wolf <kwolf@redhat.com>, Jeff Cody <codyprime@gmail.com>,
 Stefan Weil <sw@weilnetz.de>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If a qcow2 file is preallocated, it can no longer guarantee that it
initially appears as filled with zeroes.

So implement .bdrv_has_zero_init() by checking whether the file is
preallocated; if so, forward the call to the underlying storage node,
except for when it is encrypted: Encrypted preallocated images always
return effectively random data, so .bdrv_has_zero_init() must always
return 0 for them.

Reported-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2.c | 90 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 89 insertions(+), 1 deletion(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 039bdc2f7e..730fd53890 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -4631,6 +4631,94 @@ static ImageInfoSpecific *qcow2_get_specific_info(=
BlockDriverState *bs,
     return spec_info;
 }
=20
+/*
+ * Return 1 if the file only contains zero and unallocated clusters.
+ * Return 0 if it contains compressed or normal clusters.
+ * Return -errno on error.
+ */
+static int qcow2_is_zero(BlockDriverState *bs)
+{
+    BDRVQcow2State *s =3D bs->opaque;
+    int l1_i;
+    int ret;
+
+    if (bs->backing) {
+        return 0;
+    }
+
+    for (l1_i =3D 0; l1_i < s->l1_size; l1_i++) {
+        uint64_t l2_offset =3D s->l1_table[l1_i] & L1E_OFFSET_MASK;
+        int slice_start_i;
+
+        if (!l2_offset) {
+            continue;
+        }
+
+        for (slice_start_i =3D 0; slice_start_i < s->l2_size;
+             slice_start_i +=3D s->l2_slice_size)
+        {
+            uint64_t *l2_slice;
+            int l2_slice_i;
+
+            ret =3D qcow2_cache_get(bs, s->l2_table_cache,
+                                  l2_offset + slice_start_i * sizeof(uin=
t64_t),
+                                  (void **)&l2_slice);
+            if (ret < 0) {
+                return ret;
+            }
+
+            for (l2_slice_i =3D 0; l2_slice_i < s->l2_slice_size; l2_sli=
ce_i++) {
+                uint64_t l2_entry =3D be64_to_cpu(l2_slice[l2_slice_i]);
+
+                switch (qcow2_get_cluster_type(bs, l2_entry)) {
+                case QCOW2_CLUSTER_UNALLOCATED:
+                case QCOW2_CLUSTER_ZERO_PLAIN:
+                case QCOW2_CLUSTER_ZERO_ALLOC:
+                    break;
+
+                case QCOW2_CLUSTER_NORMAL:
+                case QCOW2_CLUSTER_COMPRESSED:
+                    qcow2_cache_put(s->l2_table_cache, (void **)&l2_slic=
e);
+                    return 0;
+
+                default:
+                    abort();
+                }
+            }
+
+            qcow2_cache_put(s->l2_table_cache, (void **)&l2_slice);
+        }
+    }
+
+    return 1;
+}
+
+static int qcow2_has_zero_init(BlockDriverState *bs)
+{
+    BDRVQcow2State *s =3D bs->opaque;
+    int ret;
+
+    if (qemu_in_coroutine()) {
+        qemu_co_mutex_lock(&s->lock);
+    }
+    /* Check preallocation status */
+    ret =3D qcow2_is_zero(bs);
+    if (qemu_in_coroutine()) {
+        qemu_co_mutex_unlock(&s->lock);
+    }
+    if (ret < 0) {
+        return 0;
+    }
+
+    if (ret =3D=3D 1) {
+        return 1;
+    } else if (bs->encrypted) {
+        return 0;
+    } else {
+        return bdrv_has_zero_init(s->data_file->bs);
+    }
+}
+
 static int qcow2_save_vmstate(BlockDriverState *bs, QEMUIOVector *qiov,
                               int64_t pos)
 {
@@ -5186,7 +5274,7 @@ BlockDriver bdrv_qcow2 =3D {
     .bdrv_child_perm      =3D bdrv_format_default_perms,
     .bdrv_co_create_opts  =3D qcow2_co_create_opts,
     .bdrv_co_create       =3D qcow2_co_create,
-    .bdrv_has_zero_init =3D bdrv_has_zero_init_1,
+    .bdrv_has_zero_init   =3D qcow2_has_zero_init,
     .bdrv_co_block_status =3D qcow2_co_block_status,
=20
     .bdrv_co_preadv         =3D qcow2_co_preadv,
--=20
2.21.0


