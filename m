Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC1AC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 00:44:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B49C6227BF
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 00:44:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XH5DsxLz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B49C6227BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihjv9-0002wP-PZ
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 19:44:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58571)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sstabellini@kernel.org>) id 1ihjuC-000209-3O
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 19:43:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sstabellini@kernel.org>) id 1ihjuA-0007tz-42
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 19:43:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:39762)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sstabellini@kernel.org>)
 id 1ihju9-0007ru-SJ
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 19:43:02 -0500
Received: from sstabellini-ThinkPad-T480s.xilinx.com
 (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D93C2222C2;
 Thu, 19 Dec 2019 00:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1576716180;
 bh=xxQ3rULTdbi6V9jGGSTaa6JV/CZs5fmkdGPMNuweQNw=;
 h=From:To:Cc:Subject:Date:From;
 b=XH5DsxLz9qRqYqvkrmfTtR1RwR5i/V/glXGncbdzKwT6xDschSAEYFWGvZa4PwKBx
 CVkZ5KlnzvPZ+miCYSb9OZhvbcjGOxMqy/IuGFIwGJGtMNTHxNUWSjc/ybBZlxEhtd
 s5P0iSSDcEM/crAzi4kqgZ2ZOwXgMzhraAC3sQOs=
From: Stefano Stabellini <sstabellini@kernel.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] 9p: init_in_iov_from_pdu can truncate the size
Date: Wed, 18 Dec 2019 16:42:51 -0800
Message-Id: <20191219004251.23763-1-sstabellini@kernel.org>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 198.145.29.99
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
Cc: anthony.perard@citrix.com, sstabellini@kernel.org,
 Stefano Stabellini <stefano.stabellini@xilinx.com>, groug@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefano Stabellini <stefano.stabellini@xilinx.com>

init_in_iov_from_pdu might not be able to allocate the full buffer size
requested, which comes from the client and could be larger than the
transport has available at the time of the request. Specifically, this
can happen with read operations, with the client requesting a read up to
the max allowed, which might be more than the transport has available at
the time.

Today the implementation of init_in_iov_from_pdu throws an error, both
Xen and Virtio.

Instead, change the V9fsTransport interface so that the size becomes a
pointer and can be limited by the implementation of
init_in_iov_from_pdu.

Change both the Xen and Virtio implementations to set the size to the
size of the buffer they managed to allocate, instead of throwing an
error.

Signed-off-by: Stefano Stabellini <stefano.stabellini@xilinx.com>
CC: groug@kaod.org
CC: anthony.perard@citrix.com
---
 hw/9pfs/9p.c               | 22 +++++++++++++++-------
 hw/9pfs/9p.h               |  2 +-
 hw/9pfs/virtio-9p-device.c | 10 +++-------
 hw/9pfs/xen-9p-backend.c   | 12 ++++--------
 4 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index bdf7919abf..d6c89ce608 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -1682,22 +1682,30 @@ out_nofid:
  * with qemu_iovec_destroy().
  */
 static void v9fs_init_qiov_from_pdu(QEMUIOVector *qiov, V9fsPDU *pdu,
-                                    size_t skip, size_t size,
+                                    size_t skip, size_t *size,
                                     bool is_write)
 {
     QEMUIOVector elem;
     struct iovec *iov;
     unsigned int niov;
+    size_t alloc_size = *size + skip;
 
     if (is_write) {
-        pdu->s->transport->init_out_iov_from_pdu(pdu, &iov, &niov, size + skip);
+        pdu->s->transport->init_out_iov_from_pdu(pdu, &iov, &niov, alloc_size);
     } else {
-        pdu->s->transport->init_in_iov_from_pdu(pdu, &iov, &niov, size + skip);
+        pdu->s->transport->init_in_iov_from_pdu(pdu, &iov, &niov, &alloc_size);
+    }
+
+    if (alloc_size < skip)
+    {
+        *size = 0;
+    } else {
+        *size = alloc_size - skip;
     }
 
     qemu_iovec_init_external(&elem, iov, niov);
     qemu_iovec_init(qiov, niov);
-    qemu_iovec_concat(qiov, &elem, skip, size);
+    qemu_iovec_concat(qiov, &elem, skip, *size);
 }
 
 static int v9fs_xattr_read(V9fsState *s, V9fsPDU *pdu, V9fsFidState *fidp,
@@ -1722,7 +1730,7 @@ static int v9fs_xattr_read(V9fsState *s, V9fsPDU *pdu, V9fsFidState *fidp,
     }
     offset += err;
 
-    v9fs_init_qiov_from_pdu(&qiov_full, pdu, offset, read_count, false);
+    v9fs_init_qiov_from_pdu(&qiov_full, pdu, offset, &read_count, false);
     err = v9fs_pack(qiov_full.iov, qiov_full.niov, 0,
                     ((char *)fidp->fs.xattr.value) + off,
                     read_count);
@@ -1852,7 +1860,7 @@ static void coroutine_fn v9fs_read(void *opaque)
         QEMUIOVector qiov;
         int32_t len;
 
-        v9fs_init_qiov_from_pdu(&qiov_full, pdu, offset + 4, max_count, false);
+        v9fs_init_qiov_from_pdu(&qiov_full, pdu, offset + 4, &max_count, false);
         qemu_iovec_init(&qiov, qiov_full.niov);
         do {
             qemu_iovec_reset(&qiov);
@@ -2085,7 +2093,7 @@ static void coroutine_fn v9fs_write(void *opaque)
         return;
     }
     offset += err;
-    v9fs_init_qiov_from_pdu(&qiov_full, pdu, offset, count, true);
+    v9fs_init_qiov_from_pdu(&qiov_full, pdu, offset, &count, true);
     trace_v9fs_write(pdu->tag, pdu->id, fid, off, count, qiov_full.niov);
 
     fidp = get_fid(pdu, fid);
diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
index 8883761b2c..50f7e21da6 100644
--- a/hw/9pfs/9p.h
+++ b/hw/9pfs/9p.h
@@ -365,7 +365,7 @@ struct V9fsTransport {
     ssize_t     (*pdu_vunmarshal)(V9fsPDU *pdu, size_t offset, const char *fmt,
                                   va_list ap);
     void        (*init_in_iov_from_pdu)(V9fsPDU *pdu, struct iovec **piov,
-                                        unsigned int *pniov, size_t size);
+                                        unsigned int *pniov, size_t *size);
     void        (*init_out_iov_from_pdu)(V9fsPDU *pdu, struct iovec **piov,
                                          unsigned int *pniov, size_t size);
     void        (*push_and_notify)(V9fsPDU *pdu);
diff --git a/hw/9pfs/virtio-9p-device.c b/hw/9pfs/virtio-9p-device.c
index 775e8ff766..68873c3f5f 100644
--- a/hw/9pfs/virtio-9p-device.c
+++ b/hw/9pfs/virtio-9p-device.c
@@ -145,19 +145,15 @@ static ssize_t virtio_pdu_vunmarshal(V9fsPDU *pdu, size_t offset,
 }
 
 static void virtio_init_in_iov_from_pdu(V9fsPDU *pdu, struct iovec **piov,
-                                        unsigned int *pniov, size_t size)
+                                        unsigned int *pniov, size_t *size)
 {
     V9fsState *s = pdu->s;
     V9fsVirtioState *v = container_of(s, V9fsVirtioState, state);
     VirtQueueElement *elem = v->elems[pdu->idx];
     size_t buf_size = iov_size(elem->in_sg, elem->in_num);
 
-    if (buf_size < size) {
-        VirtIODevice *vdev = VIRTIO_DEVICE(v);
-
-        virtio_error(vdev,
-                     "VirtFS reply type %d needs %zu bytes, buffer has %zu",
-                     pdu->id + 1, size, buf_size);
+    if (buf_size < *size) {
+        *size = buf_size;
     }
 
     *piov = elem->in_sg;
diff --git a/hw/9pfs/xen-9p-backend.c b/hw/9pfs/xen-9p-backend.c
index 3f54a21c76..3994a356d4 100644
--- a/hw/9pfs/xen-9p-backend.c
+++ b/hw/9pfs/xen-9p-backend.c
@@ -187,7 +187,7 @@ static void xen_9pfs_init_out_iov_from_pdu(V9fsPDU *pdu,
 static void xen_9pfs_init_in_iov_from_pdu(V9fsPDU *pdu,
                                           struct iovec **piov,
                                           unsigned int *pniov,
-                                          size_t size)
+                                          size_t *size)
 {
     Xen9pfsDev *xen_9pfs = container_of(pdu->s, Xen9pfsDev, state);
     Xen9pfsRing *ring = &xen_9pfs->rings[pdu->tag % xen_9pfs->num_rings];
@@ -197,15 +197,11 @@ static void xen_9pfs_init_in_iov_from_pdu(V9fsPDU *pdu,
     g_free(ring->sg);
 
     ring->sg = g_malloc0(sizeof(*ring->sg) * 2);
-    xen_9pfs_in_sg(ring, ring->sg, &num, pdu->idx, size);
+    xen_9pfs_in_sg(ring, ring->sg, &num, pdu->idx, *size);
 
     buf_size = iov_size(ring->sg, num);
-    if (buf_size  < size) {
-        xen_pv_printf(&xen_9pfs->xendev, 0, "Xen 9pfs request type %d"
-                "needs %zu bytes, buffer has %zu\n", pdu->id, size,
-                buf_size);
-        xen_be_set_state(&xen_9pfs->xendev, XenbusStateClosing);
-        xen_9pfs_disconnect(&xen_9pfs->xendev);
+    if (buf_size  < *size) {
+        *size = buf_size;
     }
 
     *piov = ring->sg;
-- 
2.17.1


