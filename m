Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1255C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:51:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A345620738
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:51:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LIm50GH3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A345620738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbrDg-0000tM-Ur
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 15:51:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39160)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1jbqpq-0007s6-Tl
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:26:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:46332)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1jbqpp-0002Yo-Mo
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:26:30 -0400
Received: from sstabellini-ThinkPad-T480s.hsd1.ca.comcast.net
 (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2F7D3207D3;
 Thu, 21 May 2020 19:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1590089188;
 bh=4/W/Pzh2gymBGgKA7KnPmOduUQtI3QITX4oFPL4mDos=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=LIm50GH3gCsK1fkk/pcT0oUfmzGJez/VfeETMOP9gosq2QKQFyIaF6GGwLlIhxvmW
 k0cfMgHuugWpd6lpPnraWZdC3hRO0Y6AtCgJxUEz5QNGcsdUYB4ZvuUtv7kpLmOju2
 jkaEQ8eatNhlSvzbJWeSggy23+jDcxo6RtnDGVMg=
From: Stefano Stabellini <sstabellini@kernel.org>
To: groug@kaod.org
Subject: [PATCH v2 1/3] Revert "9p: init_in_iov_from_pdu can truncate the size"
Date: Thu, 21 May 2020 12:26:25 -0700
Message-Id: <20200521192627.15259-1-sstabellini@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <alpine.DEB.2.21.2005211225030.27502@sstabellini-ThinkPad-T480s>
References: <alpine.DEB.2.21.2005211225030.27502@sstabellini-ThinkPad-T480s>
Received-SPF: pass client-ip=198.145.29.99;
 envelope-from=sstabellini@kernel.org; helo=mail.kernel.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 15:26:19
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: sstabellini@kernel.org, paul@xen.org, qemu_oss@crudebyte.com,
 qemu-devel@nongnu.org, anthony.perard@citrix.com,
 Stefano Stabellini <stefano.stabellini@xilinx.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefano Stabellini <stefano.stabellini@xilinx.com>

This reverts commit 16724a173049ac29c7b5ade741da93a0f46edff7.
It causes https://bugs.launchpad.net/bugs/1877688.

Signed-off-by: Stefano Stabellini <stefano.stabellini@xilinx.com>
---
 hw/9pfs/9p.c               | 33 +++++++++++----------------------
 hw/9pfs/9p.h               |  2 +-
 hw/9pfs/virtio-9p-device.c | 11 ++++-------
 hw/9pfs/xen-9p-backend.c   | 15 ++++++---------
 4 files changed, 22 insertions(+), 39 deletions(-)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index a2a14b5979..d39bfee462 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -2102,29 +2102,22 @@ out_nofid:
  * with qemu_iovec_destroy().
  */
 static void v9fs_init_qiov_from_pdu(QEMUIOVector *qiov, V9fsPDU *pdu,
-                                    size_t skip, size_t *size,
+                                    size_t skip, size_t size,
                                     bool is_write)
 {
     QEMUIOVector elem;
     struct iovec *iov;
     unsigned int niov;
-    size_t alloc_size = *size + skip;
 
     if (is_write) {
-        pdu->s->transport->init_out_iov_from_pdu(pdu, &iov, &niov, alloc_size);
+        pdu->s->transport->init_out_iov_from_pdu(pdu, &iov, &niov, size + skip);
     } else {
-        pdu->s->transport->init_in_iov_from_pdu(pdu, &iov, &niov, &alloc_size);
-    }
-
-    if (alloc_size < skip) {
-        *size = 0;
-    } else {
-        *size = alloc_size - skip;
+        pdu->s->transport->init_in_iov_from_pdu(pdu, &iov, &niov, size + skip);
     }
 
     qemu_iovec_init_external(&elem, iov, niov);
     qemu_iovec_init(qiov, niov);
-    qemu_iovec_concat(qiov, &elem, skip, *size);
+    qemu_iovec_concat(qiov, &elem, skip, size);
 }
 
 static int v9fs_xattr_read(V9fsState *s, V9fsPDU *pdu, V9fsFidState *fidp,
@@ -2132,14 +2125,15 @@ static int v9fs_xattr_read(V9fsState *s, V9fsPDU *pdu, V9fsFidState *fidp,
 {
     ssize_t err;
     size_t offset = 7;
-    size_t read_count;
+    uint64_t read_count;
     QEMUIOVector qiov_full;
 
     if (fidp->fs.xattr.len < off) {
         read_count = 0;
-    } else if (fidp->fs.xattr.len - off < max_count) {
-        read_count = fidp->fs.xattr.len - off;
     } else {
+        read_count = fidp->fs.xattr.len - off;
+    }
+    if (read_count > max_count) {
         read_count = max_count;
     }
     err = pdu_marshal(pdu, offset, "d", read_count);
@@ -2148,7 +2142,7 @@ static int v9fs_xattr_read(V9fsState *s, V9fsPDU *pdu, V9fsFidState *fidp,
     }
     offset += err;
 
-    v9fs_init_qiov_from_pdu(&qiov_full, pdu, offset, &read_count, false);
+    v9fs_init_qiov_from_pdu(&qiov_full, pdu, offset, read_count, false);
     err = v9fs_pack(qiov_full.iov, qiov_full.niov, 0,
                     ((char *)fidp->fs.xattr.value) + off,
                     read_count);
@@ -2277,11 +2271,9 @@ static void coroutine_fn v9fs_read(void *opaque)
         QEMUIOVector qiov_full;
         QEMUIOVector qiov;
         int32_t len;
-        size_t size = max_count;
 
-        v9fs_init_qiov_from_pdu(&qiov_full, pdu, offset + 4, &size, false);
+        v9fs_init_qiov_from_pdu(&qiov_full, pdu, offset + 4, max_count, false);
         qemu_iovec_init(&qiov, qiov_full.niov);
-        max_count = size;
         do {
             qemu_iovec_reset(&qiov);
             qemu_iovec_concat(&qiov, &qiov_full, count, qiov_full.size - count);
@@ -2532,7 +2524,6 @@ static void coroutine_fn v9fs_write(void *opaque)
     int32_t len = 0;
     int32_t total = 0;
     size_t offset = 7;
-    size_t size;
     V9fsFidState *fidp;
     V9fsPDU *pdu = opaque;
     V9fsState *s = pdu->s;
@@ -2545,9 +2536,7 @@ static void coroutine_fn v9fs_write(void *opaque)
         return;
     }
     offset += err;
-    size = count;
-    v9fs_init_qiov_from_pdu(&qiov_full, pdu, offset, &size, true);
-    count = size;
+    v9fs_init_qiov_from_pdu(&qiov_full, pdu, offset, count, true);
     trace_v9fs_write(pdu->tag, pdu->id, fid, off, count, qiov_full.niov);
 
     fidp = get_fid(pdu, fid);
diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
index dd1c6cb8d2..1b9e110605 100644
--- a/hw/9pfs/9p.h
+++ b/hw/9pfs/9p.h
@@ -436,7 +436,7 @@ struct V9fsTransport {
     ssize_t     (*pdu_vunmarshal)(V9fsPDU *pdu, size_t offset, const char *fmt,
                                   va_list ap);
     void        (*init_in_iov_from_pdu)(V9fsPDU *pdu, struct iovec **piov,
-                                        unsigned int *pniov, size_t *size);
+                                        unsigned int *pniov, size_t size);
     void        (*init_out_iov_from_pdu)(V9fsPDU *pdu, struct iovec **piov,
                                          unsigned int *pniov, size_t size);
     void        (*push_and_notify)(V9fsPDU *pdu);
diff --git a/hw/9pfs/virtio-9p-device.c b/hw/9pfs/virtio-9p-device.c
index e5b44977c7..36f3aa9352 100644
--- a/hw/9pfs/virtio-9p-device.c
+++ b/hw/9pfs/virtio-9p-device.c
@@ -147,22 +147,19 @@ static ssize_t virtio_pdu_vunmarshal(V9fsPDU *pdu, size_t offset,
 }
 
 static void virtio_init_in_iov_from_pdu(V9fsPDU *pdu, struct iovec **piov,
-                                        unsigned int *pniov, size_t *size)
+                                        unsigned int *pniov, size_t size)
 {
     V9fsState *s = pdu->s;
     V9fsVirtioState *v = container_of(s, V9fsVirtioState, state);
     VirtQueueElement *elem = v->elems[pdu->idx];
     size_t buf_size = iov_size(elem->in_sg, elem->in_num);
 
-    if (buf_size < P9_IOHDRSZ) {
+    if (buf_size < size) {
         VirtIODevice *vdev = VIRTIO_DEVICE(v);
 
         virtio_error(vdev,
-                     "VirtFS reply type %d needs %zu bytes, buffer has %zu, less than minimum",
-                     pdu->id + 1, *size, buf_size);
-    }
-    if (buf_size < *size) {
-        *size = buf_size;
+                     "VirtFS reply type %d needs %zu bytes, buffer has %zu",
+                     pdu->id + 1, size, buf_size);
     }
 
     *piov = elem->in_sg;
diff --git a/hw/9pfs/xen-9p-backend.c b/hw/9pfs/xen-9p-backend.c
index f04caabfe5..fc197f6c8a 100644
--- a/hw/9pfs/xen-9p-backend.c
+++ b/hw/9pfs/xen-9p-backend.c
@@ -188,7 +188,7 @@ static void xen_9pfs_init_out_iov_from_pdu(V9fsPDU *pdu,
 static void xen_9pfs_init_in_iov_from_pdu(V9fsPDU *pdu,
                                           struct iovec **piov,
                                           unsigned int *pniov,
-                                          size_t *size)
+                                          size_t size)
 {
     Xen9pfsDev *xen_9pfs = container_of(pdu->s, Xen9pfsDev, state);
     Xen9pfsRing *ring = &xen_9pfs->rings[pdu->tag % xen_9pfs->num_rings];
@@ -198,19 +198,16 @@ static void xen_9pfs_init_in_iov_from_pdu(V9fsPDU *pdu,
     g_free(ring->sg);
 
     ring->sg = g_new0(struct iovec, 2);
-    xen_9pfs_in_sg(ring, ring->sg, &num, pdu->idx, *size);
+    xen_9pfs_in_sg(ring, ring->sg, &num, pdu->idx, size);
 
     buf_size = iov_size(ring->sg, num);
-    if (buf_size  < P9_IOHDRSZ) {
-        xen_pv_printf(&xen_9pfs->xendev, 0, "Xen 9pfs reply type %d needs "
-                      "%zu bytes, buffer has %zu, less than minimum\n",
-                      pdu->id + 1, *size, buf_size);
+    if (buf_size  < size) {
+        xen_pv_printf(&xen_9pfs->xendev, 0, "Xen 9pfs request type %d"
+                "needs %zu bytes, buffer has %zu\n", pdu->id, size,
+                buf_size);
         xen_be_set_state(&xen_9pfs->xendev, XenbusStateClosing);
         xen_9pfs_disconnect(&xen_9pfs->xendev);
     }
-    if (buf_size  < *size) {
-        *size = buf_size;
-    }
 
     *piov = ring->sg;
     *pniov = num;
-- 
2.17.1


