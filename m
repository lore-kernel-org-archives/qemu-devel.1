Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96924C3A589
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 12:12:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B89A2086C
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 12:12:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B89A2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyEc1-0003yg-7B
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 08:12:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37007)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hyEah-0002Ux-5u
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 08:10:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hyEaf-00031M-Ns
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 08:10:51 -0400
Received: from relay.sw.ru ([185.231.240.75]:35644)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hyEac-0002vI-AA; Thu, 15 Aug 2019 08:10:46 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1hyEaZ-00060k-4k; Thu, 15 Aug 2019 15:10:43 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Date: Thu, 15 Aug 2019 15:10:40 +0300
Message-Id: <20190815121042.121309-3-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190815121042.121309-1-vsementsov@virtuozzo.com>
References: <20190815121042.121309-1-vsementsov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v3 2/4] block/qcow2: refactor
 qcow2_co_preadv_part
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, armbru@redhat.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Further patch will run partial requests of iterations of
qcow2_co_preadv in parallel for performance reasons. To prepare for
this, separate part which may be parallelized into separate function
(qcow2_co_preadv_task).

While being here, also separate encrypted clusters reading to own
function, like it is done for compressed reading.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 qapi/block-core.json |   2 +-
 block/qcow2.c        | 205 +++++++++++++++++++++++--------------------
 2 files changed, 111 insertions(+), 96 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 0d43d4f37c..dd80aa11db 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3266,7 +3266,7 @@
             'pwritev_rmw_tail', 'pwritev_rmw_after_tail', 'pwritev',
             'pwritev_zero', 'pwritev_done', 'empty_image_prepare',
             'l1_shrink_write_table', 'l1_shrink_free_l2_clusters',
-            'cor_write', 'cluster_alloc_space', 'none'] }
+            'cor_write', 'cluster_alloc_space', 'none', 'read_encrypted'] }
 
 ##
 # @BlkdebugIOType:
diff --git a/block/qcow2.c b/block/qcow2.c
index 93ab7edcea..89afb4272e 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1967,17 +1967,114 @@ out:
     return ret;
 }
 
+static coroutine_fn int
+qcow2_co_preadv_encrypted(BlockDriverState *bs,
+                           uint64_t file_cluster_offset,
+                           uint64_t offset,
+                           uint64_t bytes,
+                           QEMUIOVector *qiov,
+                           uint64_t qiov_offset)
+{
+    int ret;
+    BDRVQcow2State *s = bs->opaque;
+    uint8_t *buf;
+
+    assert(bs->encrypted && s->crypto);
+    assert(bytes <= QCOW_MAX_CRYPT_CLUSTERS * s->cluster_size);
+
+    /*
+     * For encrypted images, read everything into a temporary
+     * contiguous buffer on which the AES functions can work.
+     * Also, decryption in a separate buffer is better as it
+     * prevents the guest from learning information about the
+     * encrypted nature of the virtual disk.
+     */
+
+    buf = qemu_try_blockalign(s->data_file->bs, bytes);
+    if (buf == NULL) {
+        return -ENOMEM;
+    }
+
+    BLKDBG_EVENT(bs->file, BLKDBG_READ_ENCRYPTED);
+    ret = bdrv_co_pread(s->data_file,
+                        file_cluster_offset + offset_into_cluster(s, offset),
+                        bytes, buf, 0);
+    if (ret < 0) {
+        goto fail;
+    }
+
+    assert((offset & (BDRV_SECTOR_SIZE - 1)) == 0);
+    assert((bytes & (BDRV_SECTOR_SIZE - 1)) == 0);
+    if (qcow2_co_decrypt(bs, file_cluster_offset, offset, buf, bytes) < 0) {
+        ret = -EIO;
+        goto fail;
+    }
+    qemu_iovec_from_buf(qiov, qiov_offset, buf, bytes);
+
+fail:
+    qemu_vfree(buf);
+
+    return ret;
+}
+
+static coroutine_fn int qcow2_co_preadv_task(BlockDriverState *bs,
+                                             QCow2ClusterType cluster_type,
+                                             uint64_t file_cluster_offset,
+                                             uint64_t offset, uint64_t bytes,
+                                             QEMUIOVector *qiov,
+                                             size_t qiov_offset)
+{
+    BDRVQcow2State *s = bs->opaque;
+    int offset_in_cluster = offset_into_cluster(s, offset);
+
+    switch (cluster_type) {
+    case QCOW2_CLUSTER_ZERO_PLAIN:
+    case QCOW2_CLUSTER_ZERO_ALLOC:
+        /* Both zero types are handled in qcow2_co_preadv_part */
+        g_assert_not_reached();
+
+    case QCOW2_CLUSTER_UNALLOCATED:
+        assert(bs->backing); /* otherwise handled in qcow2_co_preadv_part */
+
+        BLKDBG_EVENT(bs->file, BLKDBG_READ_BACKING_AIO);
+        return bdrv_co_preadv_part(bs->backing, offset, bytes,
+                                   qiov, qiov_offset, 0);
+
+    case QCOW2_CLUSTER_COMPRESSED:
+        return qcow2_co_preadv_compressed(bs, file_cluster_offset,
+                                          offset, bytes, qiov, qiov_offset);
+
+    case QCOW2_CLUSTER_NORMAL:
+        if ((file_cluster_offset & 511) != 0) {
+            return -EIO;
+        }
+
+        if (bs->encrypted) {
+            return qcow2_co_preadv_encrypted(bs, file_cluster_offset,
+                                             offset, bytes, qiov, qiov_offset);
+        }
+
+        BLKDBG_EVENT(bs->file, BLKDBG_READ_AIO);
+        return bdrv_co_preadv_part(s->data_file,
+                                   file_cluster_offset + offset_in_cluster,
+                                   bytes, qiov, qiov_offset, 0);
+
+    default:
+        g_assert_not_reached();
+    }
+
+    g_assert_not_reached();
+}
+
 static coroutine_fn int qcow2_co_preadv_part(BlockDriverState *bs,
                                              uint64_t offset, uint64_t bytes,
                                              QEMUIOVector *qiov,
                                              size_t qiov_offset, int flags)
 {
     BDRVQcow2State *s = bs->opaque;
-    int offset_in_cluster;
     int ret;
     unsigned int cur_bytes; /* number of bytes in current iteration */
     uint64_t cluster_offset = 0;
-    uint8_t *cluster_data = NULL;
 
     while (bytes != 0) {
 
@@ -1992,111 +2089,29 @@ static coroutine_fn int qcow2_co_preadv_part(BlockDriverState *bs,
         ret = qcow2_get_cluster_offset(bs, offset, &cur_bytes, &cluster_offset);
         qemu_co_mutex_unlock(&s->lock);
         if (ret < 0) {
-            goto fail;
+            return ret;
         }
 
-        offset_in_cluster = offset_into_cluster(s, offset);
-
-        switch (ret) {
-        case QCOW2_CLUSTER_UNALLOCATED:
-
-            if (bs->backing) {
-                BLKDBG_EVENT(bs->file, BLKDBG_READ_BACKING_AIO);
-                ret = bdrv_co_preadv_part(bs->backing, offset, cur_bytes,
-                                          qiov, qiov_offset, 0);
-                if (ret < 0) {
-                    goto fail;
-                }
-            } else {
-                /* Note: in this case, no need to wait */
-                qemu_iovec_memset(qiov, qiov_offset, 0, cur_bytes);
-            }
-            break;
-
-        case QCOW2_CLUSTER_ZERO_PLAIN:
-        case QCOW2_CLUSTER_ZERO_ALLOC:
+        if (ret == QCOW2_CLUSTER_ZERO_PLAIN ||
+            ret == QCOW2_CLUSTER_ZERO_ALLOC ||
+            (ret == QCOW2_CLUSTER_UNALLOCATED && !bs->backing))
+        {
             qemu_iovec_memset(qiov, qiov_offset, 0, cur_bytes);
-            break;
-
-        case QCOW2_CLUSTER_COMPRESSED:
-            ret = qcow2_co_preadv_compressed(bs, cluster_offset,
-                                             offset, cur_bytes,
-                                             qiov, qiov_offset);
+        } else {
+            ret = qcow2_co_preadv_task(bs, ret,
+                                       cluster_offset, offset, cur_bytes,
+                                       qiov, qiov_offset);
             if (ret < 0) {
-                goto fail;
-            }
-
-            break;
-
-        case QCOW2_CLUSTER_NORMAL:
-            if ((cluster_offset & 511) != 0) {
-                ret = -EIO;
-                goto fail;
-            }
-
-            if (bs->encrypted) {
-                assert(s->crypto);
-
-                /*
-                 * For encrypted images, read everything into a temporary
-                 * contiguous buffer on which the AES functions can work.
-                 */
-                if (!cluster_data) {
-                    cluster_data =
-                        qemu_try_blockalign(s->data_file->bs,
-                                            QCOW_MAX_CRYPT_CLUSTERS
-                                            * s->cluster_size);
-                    if (cluster_data == NULL) {
-                        ret = -ENOMEM;
-                        goto fail;
-                    }
-                }
-
-                assert(cur_bytes <= QCOW_MAX_CRYPT_CLUSTERS * s->cluster_size);
-
-                BLKDBG_EVENT(bs->file, BLKDBG_READ_AIO);
-                ret = bdrv_co_pread(s->data_file,
-                                    cluster_offset + offset_in_cluster,
-                                    cur_bytes, cluster_data, 0);
-                if (ret < 0) {
-                    goto fail;
-                }
-
-                assert((offset & (BDRV_SECTOR_SIZE - 1)) == 0);
-                assert((cur_bytes & (BDRV_SECTOR_SIZE - 1)) == 0);
-                if (qcow2_co_decrypt(bs, cluster_offset, offset,
-                                     cluster_data, cur_bytes) < 0) {
-                    ret = -EIO;
-                    goto fail;
-                }
-                qemu_iovec_from_buf(qiov, qiov_offset, cluster_data, cur_bytes);
-            } else {
-                BLKDBG_EVENT(bs->file, BLKDBG_READ_AIO);
-                ret = bdrv_co_preadv_part(s->data_file,
-                                          cluster_offset + offset_in_cluster,
-                                          cur_bytes, qiov, qiov_offset, 0);
-                if (ret < 0) {
-                    goto fail;
-                }
+                return ret;
             }
-            break;
-
-        default:
-            g_assert_not_reached();
-            ret = -EIO;
-            goto fail;
         }
 
         bytes -= cur_bytes;
         offset += cur_bytes;
         qiov_offset += cur_bytes;
     }
-    ret = 0;
-
-fail:
-    qemu_vfree(cluster_data);
 
-    return ret;
+    return 0;
 }
 
 /* Check if it's possible to merge a write request with the writing of
-- 
2.18.0


