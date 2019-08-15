Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C931C3A589
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 18:05:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11D052083B
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 18:05:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11D052083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyK7v-0004Dl-4c
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 14:05:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32791)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1hyK2L-0008N5-SA
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 13:59:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1hyK2G-0001VU-QG
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 13:59:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52276)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1hyK2G-0001Tt-G2
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 13:59:40 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CA3633007F3A;
 Thu, 15 Aug 2019 17:59:39 +0000 (UTC)
Received: from thuth.com (ovpn-116-65.ams2.redhat.com [10.36.116.65])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9C56C17ADA;
 Thu, 15 Aug 2019 17:59:37 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Date: Thu, 15 Aug 2019 19:59:17 +0200
Message-Id: <20190815175922.3475-5-thuth@redhat.com>
In-Reply-To: <20190815175922.3475-1-thuth@redhat.com>
References: <20190815175922.3475-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Thu, 15 Aug 2019 17:59:39 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 4/9] tests/libqos: Make generic virtio code
 independent from global_qtest
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The libqos library functions should never depend on global_qtest,
since these functions might be used in tests that track multiple
test states. Pass around a pointer to the QTestState instead.

Message-Id: <20190814195920.32023-1-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/libqos/virtio.c    |  81 +++++++++++----------
 tests/libqos/virtio.h    |  30 ++++----
 tests/virtio-9p-test.c   |  16 +++--
 tests/virtio-blk-test.c  | 151 ++++++++++++++++++++-------------------
 tests/virtio-net-test.c  |  33 +++++----
 tests/virtio-scsi-test.c |  13 ++--
 6 files changed, 176 insertions(+), 148 deletions(-)

diff --git a/tests/libqos/virtio.c b/tests/libqos/virtio.c
index b4c01dc0c1..91ce06954b 100644
--- a/tests/libqos/virtio.c
+++ b/tests/libqos/virtio.c
@@ -101,7 +101,7 @@ void qvirtio_wait_queue_isr(QVirtioDevice *d,
  * The virtqueue interrupt must not be raised, making this useful for testing
  * event_index functionality.
  */
-uint8_t qvirtio_wait_status_byte_no_isr(QVirtioDevice *d,
+uint8_t qvirtio_wait_status_byte_no_isr(QTestState *qts, QVirtioDevice *d,
                                         QVirtQueue *vq,
                                         uint64_t addr,
                                         gint64 timeout_us)
@@ -126,7 +126,7 @@ uint8_t qvirtio_wait_status_byte_no_isr(QVirtioDevice *d,
  *
  * This function waits for the next completed request on the used ring.
  */
-void qvirtio_wait_used_elem(QVirtioDevice *d,
+void qvirtio_wait_used_elem(QTestState *qts, QVirtioDevice *d,
                             QVirtQueue *vq,
                             uint32_t desc_idx,
                             uint32_t *len,
@@ -140,7 +140,7 @@ void qvirtio_wait_used_elem(QVirtioDevice *d,
         clock_step(100);
 
         if (d->bus->get_queue_isr_status(d, vq) &&
-            qvirtqueue_get_buf(vq, &got_desc_idx, len)) {
+            qvirtqueue_get_buf(qts, vq, &got_desc_idx, len)) {
             g_assert_cmpint(got_desc_idx, ==, desc_idx);
             return;
         }
@@ -193,8 +193,9 @@ void qvring_init(QTestState *qts, const QGuestAllocator *alloc, QVirtQueue *vq,
                  0);
 }
 
-QVRingIndirectDesc *qvring_indirect_desc_setup(QVirtioDevice *d,
-                                        QGuestAllocator *alloc, uint16_t elem)
+QVRingIndirectDesc *qvring_indirect_desc_setup(QTestState *qs, QVirtioDevice *d,
+                                               QGuestAllocator *alloc,
+                                               uint16_t elem)
 {
     int i;
     QVRingIndirectDesc *indirect = g_malloc(sizeof(*indirect));
@@ -205,41 +206,41 @@ QVRingIndirectDesc *qvring_indirect_desc_setup(QVirtioDevice *d,
 
     for (i = 0; i < elem - 1; ++i) {
         /* indirect->desc[i].addr */
-        writeq(indirect->desc + (16 * i), 0);
+        qtest_writeq(qs, indirect->desc + (16 * i), 0);
         /* indirect->desc[i].flags */
-        writew(indirect->desc + (16 * i) + 12, VRING_DESC_F_NEXT);
+        qtest_writew(qs, indirect->desc + (16 * i) + 12, VRING_DESC_F_NEXT);
         /* indirect->desc[i].next */
-        writew(indirect->desc + (16 * i) + 14, i + 1);
+        qtest_writew(qs, indirect->desc + (16 * i) + 14, i + 1);
     }
 
     return indirect;
 }
 
-void qvring_indirect_desc_add(QVRingIndirectDesc *indirect, uint64_t data,
-                                                    uint32_t len, bool write)
+void qvring_indirect_desc_add(QTestState *qts, QVRingIndirectDesc *indirect,
+                              uint64_t data, uint32_t len, bool write)
 {
     uint16_t flags;
 
     g_assert_cmpint(indirect->index, <, indirect->elem);
 
-    flags = readw(indirect->desc + (16 * indirect->index) + 12);
+    flags = qtest_readw(qts, indirect->desc + (16 * indirect->index) + 12);
 
     if (write) {
         flags |= VRING_DESC_F_WRITE;
     }
 
     /* indirect->desc[indirect->index].addr */
-    writeq(indirect->desc + (16 * indirect->index), data);
+    qtest_writeq(qts, indirect->desc + (16 * indirect->index), data);
     /* indirect->desc[indirect->index].len */
-    writel(indirect->desc + (16 * indirect->index) + 8, len);
+    qtest_writel(qts, indirect->desc + (16 * indirect->index) + 8, len);
     /* indirect->desc[indirect->index].flags */
-    writew(indirect->desc + (16 * indirect->index) + 12, flags);
+    qtest_writew(qts, indirect->desc + (16 * indirect->index) + 12, flags);
 
     indirect->index++;
 }
 
-uint32_t qvirtqueue_add(QVirtQueue *vq, uint64_t data, uint32_t len, bool write,
-                                                                    bool next)
+uint32_t qvirtqueue_add(QTestState *qts, QVirtQueue *vq, uint64_t data,
+                        uint32_t len, bool write, bool next)
 {
     uint16_t flags = 0;
     vq->num_free--;
@@ -253,16 +254,17 @@ uint32_t qvirtqueue_add(QVirtQueue *vq, uint64_t data, uint32_t len, bool write,
     }
 
     /* vq->desc[vq->free_head].addr */
-    writeq(vq->desc + (16 * vq->free_head), data);
+    qtest_writeq(qts, vq->desc + (16 * vq->free_head), data);
     /* vq->desc[vq->free_head].len */
-    writel(vq->desc + (16 * vq->free_head) + 8, len);
+    qtest_writel(qts, vq->desc + (16 * vq->free_head) + 8, len);
     /* vq->desc[vq->free_head].flags */
-    writew(vq->desc + (16 * vq->free_head) + 12, flags);
+    qtest_writew(qts, vq->desc + (16 * vq->free_head) + 12, flags);
 
     return vq->free_head++; /* Return and increase, in this order */
 }
 
-uint32_t qvirtqueue_add_indirect(QVirtQueue *vq, QVRingIndirectDesc *indirect)
+uint32_t qvirtqueue_add_indirect(QTestState *qts, QVirtQueue *vq,
+                                 QVRingIndirectDesc *indirect)
 {
     g_assert(vq->indirect);
     g_assert_cmpint(vq->size, >=, indirect->elem);
@@ -271,34 +273,36 @@ uint32_t qvirtqueue_add_indirect(QVirtQueue *vq, QVRingIndirectDesc *indirect)
     vq->num_free--;
 
     /* vq->desc[vq->free_head].addr */
-    writeq(vq->desc + (16 * vq->free_head), indirect->desc);
+    qtest_writeq(qts, vq->desc + (16 * vq->free_head), indirect->desc);
     /* vq->desc[vq->free_head].len */
-    writel(vq->desc + (16 * vq->free_head) + 8,
+    qtest_writel(qts, vq->desc + (16 * vq->free_head) + 8,
            sizeof(struct vring_desc) * indirect->elem);
     /* vq->desc[vq->free_head].flags */
-    writew(vq->desc + (16 * vq->free_head) + 12, VRING_DESC_F_INDIRECT);
+    qtest_writew(qts, vq->desc + (16 * vq->free_head) + 12,
+                 VRING_DESC_F_INDIRECT);
 
     return vq->free_head++; /* Return and increase, in this order */
 }
 
-void qvirtqueue_kick(QVirtioDevice *d, QVirtQueue *vq, uint32_t free_head)
+void qvirtqueue_kick(QTestState *qts, QVirtioDevice *d, QVirtQueue *vq,
+                     uint32_t free_head)
 {
     /* vq->avail->idx */
-    uint16_t idx = readw(vq->avail + 2);
+    uint16_t idx = qtest_readw(qts, vq->avail + 2);
     /* vq->used->flags */
     uint16_t flags;
     /* vq->used->avail_event */
     uint16_t avail_event;
 
     /* vq->avail->ring[idx % vq->size] */
-    writew(vq->avail + 4 + (2 * (idx % vq->size)), free_head);
+    qtest_writew(qts, vq->avail + 4 + (2 * (idx % vq->size)), free_head);
     /* vq->avail->idx */
-    writew(vq->avail + 2, idx + 1);
+    qtest_writew(qts, vq->avail + 2, idx + 1);
 
     /* Must read after idx is updated */
-    flags = readw(vq->avail);
-    avail_event = readw(vq->used + 4 +
-                                sizeof(struct vring_used_elem) * vq->size);
+    flags = qtest_readw(qts, vq->avail);
+    avail_event = qtest_readw(qts, vq->used + 4 +
+                                   sizeof(struct vring_used_elem) * vq->size);
 
     /* < 1 because we add elements to avail queue one by one */
     if ((flags & VRING_USED_F_NO_NOTIFY) == 0 &&
@@ -317,12 +321,13 @@ void qvirtqueue_kick(QVirtioDevice *d, QVirtQueue *vq, uint32_t free_head)
  *
  * Returns: true if an element was ready, false otherwise
  */
-bool qvirtqueue_get_buf(QVirtQueue *vq, uint32_t *desc_idx, uint32_t *len)
+bool qvirtqueue_get_buf(QTestState *qts, QVirtQueue *vq, uint32_t *desc_idx,
+                        uint32_t *len)
 {
     uint16_t idx;
-    uint64_t elem_addr;
+    uint64_t elem_addr, addr;
 
-    idx = readw(vq->used + offsetof(struct vring_used, idx));
+    idx = qtest_readw(qts, vq->used + offsetof(struct vring_used, idx));
     if (idx == vq->last_used_idx) {
         return false;
     }
@@ -333,23 +338,25 @@ bool qvirtqueue_get_buf(QVirtQueue *vq, uint32_t *desc_idx, uint32_t *len)
         sizeof(struct vring_used_elem);
 
     if (desc_idx) {
-        *desc_idx = readl(elem_addr + offsetof(struct vring_used_elem, id));
+        addr = elem_addr + offsetof(struct vring_used_elem, id);
+        *desc_idx = qtest_readl(qts, addr);
     }
 
     if (len) {
-        *len = readw(elem_addr + offsetof(struct vring_used_elem, len));
+        addr = elem_addr + offsetof(struct vring_used_elem, len);
+        *len = qtest_readw(qts, addr);
     }
 
     vq->last_used_idx++;
     return true;
 }
 
-void qvirtqueue_set_used_event(QVirtQueue *vq, uint16_t idx)
+void qvirtqueue_set_used_event(QTestState *qts, QVirtQueue *vq, uint16_t idx)
 {
     g_assert(vq->event);
 
     /* vq->avail->used_event */
-    writew(vq->avail + 4 + (2 * vq->size), idx);
+    qtest_writew(qts, vq->avail + 4 + (2 * vq->size), idx);
 }
 
 void qvirtio_start_device(QVirtioDevice *vdev)
diff --git a/tests/libqos/virtio.h b/tests/libqos/virtio.h
index 7b97f5e567..037176dbd8 100644
--- a/tests/libqos/virtio.h
+++ b/tests/libqos/virtio.h
@@ -114,11 +114,11 @@ void qvirtio_set_driver_ok(QVirtioDevice *d);
 
 void qvirtio_wait_queue_isr(QVirtioDevice *d,
                             QVirtQueue *vq, gint64 timeout_us);
-uint8_t qvirtio_wait_status_byte_no_isr(QVirtioDevice *d,
+uint8_t qvirtio_wait_status_byte_no_isr(QTestState *qts, QVirtioDevice *d,
                                         QVirtQueue *vq,
                                         uint64_t addr,
                                         gint64 timeout_us);
-void qvirtio_wait_used_elem(QVirtioDevice *d,
+void qvirtio_wait_used_elem(QTestState *qts, QVirtioDevice *d,
                             QVirtQueue *vq,
                             uint32_t desc_idx,
                             uint32_t *len,
@@ -131,17 +131,21 @@ void qvirtqueue_cleanup(const QVirtioBus *bus, QVirtQueue *vq,
 
 void qvring_init(QTestState *qts, const QGuestAllocator *alloc, QVirtQueue *vq,
                  uint64_t addr);
-QVRingIndirectDesc *qvring_indirect_desc_setup(QVirtioDevice *d,
-                                        QGuestAllocator *alloc, uint16_t elem);
-void qvring_indirect_desc_add(QVRingIndirectDesc *indirect, uint64_t data,
-                                                    uint32_t len, bool write);
-uint32_t qvirtqueue_add(QVirtQueue *vq, uint64_t data, uint32_t len, bool write,
-                                                                    bool next);
-uint32_t qvirtqueue_add_indirect(QVirtQueue *vq, QVRingIndirectDesc *indirect);
-void qvirtqueue_kick(QVirtioDevice *d, QVirtQueue *vq, uint32_t free_head);
-bool qvirtqueue_get_buf(QVirtQueue *vq, uint32_t *desc_idx, uint32_t *len);
-
-void qvirtqueue_set_used_event(QVirtQueue *vq, uint16_t idx);
+QVRingIndirectDesc *qvring_indirect_desc_setup(QTestState *qs, QVirtioDevice *d,
+                                               QGuestAllocator *alloc,
+                                               uint16_t elem);
+void qvring_indirect_desc_add(QTestState *qts, QVRingIndirectDesc *indirect,
+                              uint64_t data, uint32_t len, bool write);
+uint32_t qvirtqueue_add(QTestState *qts, QVirtQueue *vq, uint64_t data,
+                        uint32_t len, bool write, bool next);
+uint32_t qvirtqueue_add_indirect(QTestState *qts, QVirtQueue *vq,
+                                 QVRingIndirectDesc *indirect);
+void qvirtqueue_kick(QTestState *qts, QVirtioDevice *d, QVirtQueue *vq,
+                     uint32_t free_head);
+bool qvirtqueue_get_buf(QTestState *qts, QVirtQueue *vq, uint32_t *desc_idx,
+                        uint32_t *len);
+
+void qvirtqueue_set_used_event(QTestState *qts, QVirtQueue *vq, uint16_t idx);
 
 void qvirtio_start_device(QVirtioDevice *vdev);
 
diff --git a/tests/virtio-9p-test.c b/tests/virtio-9p-test.c
index ac49bca991..30e6cf3e63 100644
--- a/tests/virtio-9p-test.c
+++ b/tests/virtio-9p-test.c
@@ -39,6 +39,7 @@ static void pci_config(void *obj, void *data, QGuestAllocator *t_alloc)
 #define P9_MAX_SIZE 4096 /* Max size of a T-message or R-message */
 
 typedef struct {
+    QTestState *qts;
     QVirtio9P *v9p;
     uint16_t tag;
     uint64_t t_msg;
@@ -52,7 +53,7 @@ typedef struct {
 
 static void v9fs_memwrite(P9Req *req, const void *addr, size_t len)
 {
-    memwrite(req->t_msg + req->t_off, addr, len);
+    qtest_memwrite(req->qts, req->t_msg + req->t_off, addr, len);
     req->t_off += len;
 }
 
@@ -63,7 +64,7 @@ static void v9fs_memskip(P9Req *req, size_t len)
 
 static void v9fs_memread(P9Req *req, void *addr, size_t len)
 {
-    memread(req->r_msg + req->r_off, addr, len);
+    qtest_memread(req->qts, req->r_msg + req->r_off, addr, len);
     req->r_off += len;
 }
 
@@ -158,6 +159,7 @@ static P9Req *v9fs_req_init(QVirtio9P *v9p, uint32_t size, uint8_t id,
 
     g_assert_cmpint(total_size, <=, P9_MAX_SIZE);
 
+    req->qts = global_qtest;
     req->v9p = v9p;
     req->t_size = total_size;
     req->t_msg = guest_alloc(alloc, req->t_size);
@@ -171,10 +173,10 @@ static void v9fs_req_send(P9Req *req)
     QVirtio9P *v9p = req->v9p;
 
     req->r_msg = guest_alloc(alloc, P9_MAX_SIZE);
-    req->free_head = qvirtqueue_add(v9p->vq, req->t_msg, req->t_size, false,
-                                    true);
-    qvirtqueue_add(v9p->vq, req->r_msg, P9_MAX_SIZE, true, false);
-    qvirtqueue_kick(v9p->vdev, v9p->vq, req->free_head);
+    req->free_head = qvirtqueue_add(req->qts, v9p->vq, req->t_msg, req->t_size,
+                                    false, true);
+    qvirtqueue_add(req->qts, v9p->vq, req->r_msg, P9_MAX_SIZE, true, false);
+    qvirtqueue_kick(req->qts, v9p->vdev, v9p->vq, req->free_head);
     req->t_off = 0;
 }
 
@@ -195,7 +197,7 @@ static void v9fs_req_wait_for_reply(P9Req *req, uint32_t *len)
 {
     QVirtio9P *v9p = req->v9p;
 
-    qvirtio_wait_used_elem(v9p->vdev, v9p->vq, req->free_head, len,
+    qvirtio_wait_used_elem(req->qts, v9p->vdev, v9p->vq, req->free_head, len,
                            QVIRTIO_9P_TIMEOUT_US);
 }
 
diff --git a/tests/virtio-blk-test.c b/tests/virtio-blk-test.c
index 1589ab0866..882b08ae29 100644
--- a/tests/virtio-blk-test.c
+++ b/tests/virtio-blk-test.c
@@ -123,6 +123,7 @@ static void test_basic(QVirtioDevice *dev, QGuestAllocator *alloc,
     uint32_t free_head;
     uint8_t status;
     char *data;
+    QTestState *qts = global_qtest;
 
     capacity = qvirtio_config_readq(dev, 0);
 
@@ -149,13 +150,14 @@ static void test_basic(QVirtioDevice *dev, QGuestAllocator *alloc,
 
     g_free(req.data);
 
-    free_head = qvirtqueue_add(vq, req_addr, 16, false, true);
-    qvirtqueue_add(vq, req_addr + 16, 512, false, true);
-    qvirtqueue_add(vq, req_addr + 528, 1, true, false);
+    free_head = qvirtqueue_add(qts, vq, req_addr, 16, false, true);
+    qvirtqueue_add(qts, vq, req_addr + 16, 512, false, true);
+    qvirtqueue_add(qts, vq, req_addr + 528, 1, true, false);
 
-    qvirtqueue_kick(dev, vq, free_head);
+    qvirtqueue_kick(qts, dev, vq, free_head);
 
-    qvirtio_wait_used_elem(dev, vq, free_head, NULL, QVIRTIO_BLK_TIMEOUT_US);
+    qvirtio_wait_used_elem(qts, dev, vq, free_head, NULL,
+                           QVIRTIO_BLK_TIMEOUT_US);
     status = readb(req_addr + 528);
     g_assert_cmpint(status, ==, 0);
 
@@ -171,13 +173,14 @@ static void test_basic(QVirtioDevice *dev, QGuestAllocator *alloc,
 
     g_free(req.data);
 
-    free_head = qvirtqueue_add(vq, req_addr, 16, false, true);
-    qvirtqueue_add(vq, req_addr + 16, 512, true, true);
-    qvirtqueue_add(vq, req_addr + 528, 1, true, false);
+    free_head = qvirtqueue_add(qts, vq, req_addr, 16, false, true);
+    qvirtqueue_add(qts, vq, req_addr + 16, 512, true, true);
+    qvirtqueue_add(qts, vq, req_addr + 528, 1, true, false);
 
-    qvirtqueue_kick(dev, vq, free_head);
+    qvirtqueue_kick(qts, dev, vq, free_head);
 
-    qvirtio_wait_used_elem(dev, vq, free_head, NULL, QVIRTIO_BLK_TIMEOUT_US);
+    qvirtio_wait_used_elem(qts, dev, vq, free_head, NULL,
+                           QVIRTIO_BLK_TIMEOUT_US);
     status = readb(req_addr + 528);
     g_assert_cmpint(status, ==, 0);
 
@@ -206,13 +209,14 @@ static void test_basic(QVirtioDevice *dev, QGuestAllocator *alloc,
 
         req_addr = virtio_blk_request(alloc, dev, &req, sizeof(dwz_hdr));
 
-        free_head = qvirtqueue_add(vq, req_addr, 16, false, true);
-        qvirtqueue_add(vq, req_addr + 16, sizeof(dwz_hdr), false, true);
-        qvirtqueue_add(vq, req_addr + 16 + sizeof(dwz_hdr), 1, true, false);
+        free_head = qvirtqueue_add(qts, vq, req_addr, 16, false, true);
+        qvirtqueue_add(qts, vq, req_addr + 16, sizeof(dwz_hdr), false, true);
+        qvirtqueue_add(qts, vq, req_addr + 16 + sizeof(dwz_hdr), 1, true,
+                       false);
 
-        qvirtqueue_kick(dev, vq, free_head);
+        qvirtqueue_kick(qts, dev, vq, free_head);
 
-        qvirtio_wait_used_elem(dev, vq, free_head, NULL,
+        qvirtio_wait_used_elem(qts, dev, vq, free_head, NULL,
                                QVIRTIO_BLK_TIMEOUT_US);
         status = readb(req_addr + 16 + sizeof(dwz_hdr));
         g_assert_cmpint(status, ==, 0);
@@ -229,13 +233,13 @@ static void test_basic(QVirtioDevice *dev, QGuestAllocator *alloc,
 
         g_free(req.data);
 
-        free_head = qvirtqueue_add(vq, req_addr, 16, false, true);
-        qvirtqueue_add(vq, req_addr + 16, 512, true, true);
-        qvirtqueue_add(vq, req_addr + 528, 1, true, false);
+        free_head = qvirtqueue_add(qts, vq, req_addr, 16, false, true);
+        qvirtqueue_add(qts, vq, req_addr + 16, 512, true, true);
+        qvirtqueue_add(qts, vq, req_addr + 528, 1, true, false);
 
-        qvirtqueue_kick(dev, vq, free_head);
+        qvirtqueue_kick(qts, dev, vq, free_head);
 
-        qvirtio_wait_used_elem(dev, vq, free_head, NULL,
+        qvirtio_wait_used_elem(qts, dev, vq, free_head, NULL,
                                QVIRTIO_BLK_TIMEOUT_US);
         status = readb(req_addr + 528);
         g_assert_cmpint(status, ==, 0);
@@ -263,13 +267,13 @@ static void test_basic(QVirtioDevice *dev, QGuestAllocator *alloc,
 
         req_addr = virtio_blk_request(alloc, dev, &req, sizeof(dwz_hdr));
 
-        free_head = qvirtqueue_add(vq, req_addr, 16, false, true);
-        qvirtqueue_add(vq, req_addr + 16, sizeof(dwz_hdr), false, true);
-        qvirtqueue_add(vq, req_addr + 16 + sizeof(dwz_hdr), 1, true, false);
+        free_head = qvirtqueue_add(qts, vq, req_addr, 16, false, true);
+        qvirtqueue_add(qts, vq, req_addr + 16, sizeof(dwz_hdr), false, true);
+        qvirtqueue_add(qts, vq, req_addr + 16 + sizeof(dwz_hdr), 1, true, false);
 
-        qvirtqueue_kick(dev, vq, free_head);
+        qvirtqueue_kick(qts, dev, vq, free_head);
 
-        qvirtio_wait_used_elem(dev, vq, free_head, NULL,
+        qvirtio_wait_used_elem(qts, dev, vq, free_head, NULL,
                                QVIRTIO_BLK_TIMEOUT_US);
         status = readb(req_addr + 16 + sizeof(dwz_hdr));
         g_assert_cmpint(status, ==, 0);
@@ -290,11 +294,11 @@ static void test_basic(QVirtioDevice *dev, QGuestAllocator *alloc,
 
         g_free(req.data);
 
-        free_head = qvirtqueue_add(vq, req_addr, 528, false, true);
-        qvirtqueue_add(vq, req_addr + 528, 1, true, false);
-        qvirtqueue_kick(dev, vq, free_head);
+        free_head = qvirtqueue_add(qts, vq, req_addr, 528, false, true);
+        qvirtqueue_add(qts, vq, req_addr + 528, 1, true, false);
+        qvirtqueue_kick(qts, dev, vq, free_head);
 
-        qvirtio_wait_used_elem(dev, vq, free_head, NULL,
+        qvirtio_wait_used_elem(qts, dev, vq, free_head, NULL,
                                QVIRTIO_BLK_TIMEOUT_US);
         status = readb(req_addr + 528);
         g_assert_cmpint(status, ==, 0);
@@ -311,12 +315,12 @@ static void test_basic(QVirtioDevice *dev, QGuestAllocator *alloc,
 
         g_free(req.data);
 
-        free_head = qvirtqueue_add(vq, req_addr, 16, false, true);
-        qvirtqueue_add(vq, req_addr + 16, 513, true, false);
+        free_head = qvirtqueue_add(qts, vq, req_addr, 16, false, true);
+        qvirtqueue_add(qts, vq, req_addr + 16, 513, true, false);
 
-        qvirtqueue_kick(dev, vq, free_head);
+        qvirtqueue_kick(qts, dev, vq, free_head);
 
-        qvirtio_wait_used_elem(dev, vq, free_head, NULL,
+        qvirtio_wait_used_elem(qts, dev, vq, free_head, NULL,
                                QVIRTIO_BLK_TIMEOUT_US);
         status = readb(req_addr + 528);
         g_assert_cmpint(status, ==, 0);
@@ -353,6 +357,7 @@ static void indirect(void *obj, void *u_data, QGuestAllocator *t_alloc)
     uint32_t free_head;
     uint8_t status;
     char *data;
+    QTestState *qts = global_qtest;
 
     capacity = qvirtio_config_readq(dev, 0);
     g_assert_cmpint(capacity, ==, TEST_IMAGE_SIZE / 512);
@@ -378,13 +383,13 @@ static void indirect(void *obj, void *u_data, QGuestAllocator *t_alloc)
 
     g_free(req.data);
 
-    indirect = qvring_indirect_desc_setup(dev, t_alloc, 2);
-    qvring_indirect_desc_add(indirect, req_addr, 528, false);
-    qvring_indirect_desc_add(indirect, req_addr + 528, 1, true);
-    free_head = qvirtqueue_add_indirect(vq, indirect);
-    qvirtqueue_kick(dev, vq, free_head);
+    indirect = qvring_indirect_desc_setup(qts, dev, t_alloc, 2);
+    qvring_indirect_desc_add(qts, indirect, req_addr, 528, false);
+    qvring_indirect_desc_add(qts, indirect, req_addr + 528, 1, true);
+    free_head = qvirtqueue_add_indirect(qts, vq, indirect);
+    qvirtqueue_kick(qts, dev, vq, free_head);
 
-    qvirtio_wait_used_elem(dev, vq, free_head, NULL,
+    qvirtio_wait_used_elem(qts, dev, vq, free_head, NULL,
                            QVIRTIO_BLK_TIMEOUT_US);
     status = readb(req_addr + 528);
     g_assert_cmpint(status, ==, 0);
@@ -403,13 +408,13 @@ static void indirect(void *obj, void *u_data, QGuestAllocator *t_alloc)
 
     g_free(req.data);
 
-    indirect = qvring_indirect_desc_setup(dev, t_alloc, 2);
-    qvring_indirect_desc_add(indirect, req_addr, 16, false);
-    qvring_indirect_desc_add(indirect, req_addr + 16, 513, true);
-    free_head = qvirtqueue_add_indirect(vq, indirect);
-    qvirtqueue_kick(dev, vq, free_head);
+    indirect = qvring_indirect_desc_setup(qts, dev, t_alloc, 2);
+    qvring_indirect_desc_add(qts, indirect, req_addr, 16, false);
+    qvring_indirect_desc_add(qts, indirect, req_addr + 16, 513, true);
+    free_head = qvirtqueue_add_indirect(qts, vq, indirect);
+    qvirtqueue_kick(qts, dev, vq, free_head);
 
-    qvirtio_wait_used_elem(dev, vq, free_head, NULL,
+    qvirtio_wait_used_elem(qts, dev, vq, free_head, NULL,
                            QVIRTIO_BLK_TIMEOUT_US);
     status = readb(req_addr + 528);
     g_assert_cmpint(status, ==, 0);
@@ -461,6 +466,7 @@ static void msix(void *obj, void *u_data, QGuestAllocator *t_alloc)
     char *data;
     QOSGraphObject *blk_object = obj;
     QPCIDevice *pci_dev = blk_object->get_driver(blk_object, "pci-device");
+    QTestState *qts = global_qtest;
 
     if (qpci_check_buggy_msi(pci_dev)) {
         return;
@@ -504,12 +510,12 @@ static void msix(void *obj, void *u_data, QGuestAllocator *t_alloc)
 
     g_free(req.data);
 
-    free_head = qvirtqueue_add(vq, req_addr, 16, false, true);
-    qvirtqueue_add(vq, req_addr + 16, 512, false, true);
-    qvirtqueue_add(vq, req_addr + 528, 1, true, false);
-    qvirtqueue_kick(dev, vq, free_head);
+    free_head = qvirtqueue_add(qts, vq, req_addr, 16, false, true);
+    qvirtqueue_add(qts, vq, req_addr + 16, 512, false, true);
+    qvirtqueue_add(qts, vq, req_addr + 528, 1, true, false);
+    qvirtqueue_kick(qts, dev, vq, free_head);
 
-    qvirtio_wait_used_elem(dev, vq, free_head, NULL,
+    qvirtio_wait_used_elem(qts, dev, vq, free_head, NULL,
                            QVIRTIO_BLK_TIMEOUT_US);
 
     status = readb(req_addr + 528);
@@ -527,14 +533,14 @@ static void msix(void *obj, void *u_data, QGuestAllocator *t_alloc)
 
     g_free(req.data);
 
-    free_head = qvirtqueue_add(vq, req_addr, 16, false, true);
-    qvirtqueue_add(vq, req_addr + 16, 512, true, true);
-    qvirtqueue_add(vq, req_addr + 528, 1, true, false);
+    free_head = qvirtqueue_add(qts, vq, req_addr, 16, false, true);
+    qvirtqueue_add(qts, vq, req_addr + 16, 512, true, true);
+    qvirtqueue_add(qts, vq, req_addr + 528, 1, true, false);
 
-    qvirtqueue_kick(dev, vq, free_head);
+    qvirtqueue_kick(qts, dev, vq, free_head);
 
 
-    qvirtio_wait_used_elem(dev, vq, free_head, NULL,
+    qvirtio_wait_used_elem(qts, dev, vq, free_head, NULL,
                            QVIRTIO_BLK_TIMEOUT_US);
 
     status = readb(req_addr + 528);
@@ -569,6 +575,7 @@ static void idx(void *obj, void *u_data, QGuestAllocator *t_alloc)
     char *data;
     QOSGraphObject *blk_object = obj;
     QPCIDevice *pci_dev = blk_object->get_driver(blk_object, "pci-device");
+    QTestState *qts = global_qtest;
 
     if (qpci_check_buggy_msi(pci_dev)) {
         return;
@@ -603,12 +610,12 @@ static void idx(void *obj, void *u_data, QGuestAllocator *t_alloc)
 
     g_free(req.data);
 
-    free_head = qvirtqueue_add(vq, req_addr, 16, false, true);
-    qvirtqueue_add(vq, req_addr + 16, 512, false, true);
-    qvirtqueue_add(vq, req_addr + 528, 1, true, false);
-    qvirtqueue_kick(dev, vq, free_head);
+    free_head = qvirtqueue_add(qts, vq, req_addr, 16, false, true);
+    qvirtqueue_add(qts, vq, req_addr + 16, 512, false, true);
+    qvirtqueue_add(qts, vq, req_addr + 528, 1, true, false);
+    qvirtqueue_kick(qts, dev, vq, free_head);
 
-    qvirtio_wait_used_elem(dev, vq, free_head, NULL,
+    qvirtio_wait_used_elem(qts, dev, vq, free_head, NULL,
                            QVIRTIO_BLK_TIMEOUT_US);
 
     /* Write request */
@@ -623,15 +630,15 @@ static void idx(void *obj, void *u_data, QGuestAllocator *t_alloc)
     g_free(req.data);
 
     /* Notify after processing the third request */
-    qvirtqueue_set_used_event(vq, 2);
-    free_head = qvirtqueue_add(vq, req_addr, 16, false, true);
-    qvirtqueue_add(vq, req_addr + 16, 512, false, true);
-    qvirtqueue_add(vq, req_addr + 528, 1, true, false);
-    qvirtqueue_kick(dev, vq, free_head);
+    qvirtqueue_set_used_event(qts, vq, 2);
+    free_head = qvirtqueue_add(qts, vq, req_addr, 16, false, true);
+    qvirtqueue_add(qts, vq, req_addr + 16, 512, false, true);
+    qvirtqueue_add(qts, vq, req_addr + 528, 1, true, false);
+    qvirtqueue_kick(qts, dev, vq, free_head);
     write_head = free_head;
 
     /* No notification expected */
-    status = qvirtio_wait_status_byte_no_isr(dev,
+    status = qvirtio_wait_status_byte_no_isr(qts, dev,
                                              vq, req_addr + 528,
                                              QVIRTIO_BLK_TIMEOUT_US);
     g_assert_cmpint(status, ==, 0);
@@ -648,16 +655,16 @@ static void idx(void *obj, void *u_data, QGuestAllocator *t_alloc)
 
     g_free(req.data);
 
-    free_head = qvirtqueue_add(vq, req_addr, 16, false, true);
-    qvirtqueue_add(vq, req_addr + 16, 512, true, true);
-    qvirtqueue_add(vq, req_addr + 528, 1, true, false);
+    free_head = qvirtqueue_add(qts, vq, req_addr, 16, false, true);
+    qvirtqueue_add(qts, vq, req_addr + 16, 512, true, true);
+    qvirtqueue_add(qts, vq, req_addr + 528, 1, true, false);
 
-    qvirtqueue_kick(dev, vq, free_head);
+    qvirtqueue_kick(qts, dev, vq, free_head);
 
     /* We get just one notification for both requests */
-    qvirtio_wait_used_elem(dev, vq, write_head, NULL,
+    qvirtio_wait_used_elem(qts, dev, vq, write_head, NULL,
                            QVIRTIO_BLK_TIMEOUT_US);
-    g_assert(qvirtqueue_get_buf(vq, &desc_idx, NULL));
+    g_assert(qvirtqueue_get_buf(qts, vq, &desc_idx, NULL));
     g_assert_cmpint(desc_idx, ==, free_head);
 
     status = readb(req_addr + 528);
diff --git a/tests/virtio-net-test.c b/tests/virtio-net-test.c
index 7aa9622f30..1071dd82c9 100644
--- a/tests/virtio-net-test.c
+++ b/tests/virtio-net-test.c
@@ -33,6 +33,7 @@ static void rx_test(QVirtioDevice *dev,
                     QGuestAllocator *alloc, QVirtQueue *vq,
                     int socket)
 {
+    QTestState *qts = global_qtest;
     uint64_t req_addr;
     uint32_t free_head;
     char test[] = "TEST";
@@ -51,13 +52,14 @@ static void rx_test(QVirtioDevice *dev,
 
     req_addr = guest_alloc(alloc, 64);
 
-    free_head = qvirtqueue_add(vq, req_addr, 64, true, false);
-    qvirtqueue_kick(dev, vq, free_head);
+    free_head = qvirtqueue_add(qts, vq, req_addr, 64, true, false);
+    qvirtqueue_kick(qts, dev, vq, free_head);
 
     ret = iov_send(socket, iov, 2, 0, sizeof(len) + sizeof(test));
     g_assert_cmpint(ret, ==, sizeof(test) + sizeof(len));
 
-    qvirtio_wait_used_elem(dev, vq, free_head, NULL, QVIRTIO_NET_TIMEOUT_US);
+    qvirtio_wait_used_elem(qts, dev, vq, free_head, NULL,
+                           QVIRTIO_NET_TIMEOUT_US);
     memread(req_addr + VNET_HDR_SIZE, buffer, sizeof(test));
     g_assert_cmpstr(buffer, ==, "TEST");
 
@@ -68,6 +70,7 @@ static void tx_test(QVirtioDevice *dev,
                     QGuestAllocator *alloc, QVirtQueue *vq,
                     int socket)
 {
+    QTestState *qts = global_qtest;
     uint64_t req_addr;
     uint32_t free_head;
     uint32_t len;
@@ -77,10 +80,11 @@ static void tx_test(QVirtioDevice *dev,
     req_addr = guest_alloc(alloc, 64);
     memwrite(req_addr + VNET_HDR_SIZE, "TEST", 4);
 
-    free_head = qvirtqueue_add(vq, req_addr, 64, false, false);
-    qvirtqueue_kick(dev, vq, free_head);
+    free_head = qvirtqueue_add(qts, vq, req_addr, 64, false, false);
+    qvirtqueue_kick(qts, dev, vq, free_head);
 
-    qvirtio_wait_used_elem(dev, vq, free_head, NULL, QVIRTIO_NET_TIMEOUT_US);
+    qvirtio_wait_used_elem(qts, dev, vq, free_head, NULL,
+                           QVIRTIO_NET_TIMEOUT_US);
     guest_free(alloc, req_addr);
 
     ret = qemu_recv(socket, &len, sizeof(len), 0);
@@ -95,6 +99,7 @@ static void rx_stop_cont_test(QVirtioDevice *dev,
                               QGuestAllocator *alloc, QVirtQueue *vq,
                               int socket)
 {
+    QTestState *qts = global_qtest;
     uint64_t req_addr;
     uint32_t free_head;
     char test[] = "TEST";
@@ -114,8 +119,8 @@ static void rx_stop_cont_test(QVirtioDevice *dev,
 
     req_addr = guest_alloc(alloc, 64);
 
-    free_head = qvirtqueue_add(vq, req_addr, 64, true, false);
-    qvirtqueue_kick(dev, vq, free_head);
+    free_head = qvirtqueue_add(qts, vq, req_addr, 64, true, false);
+    qvirtqueue_kick(qts, dev, vq, free_head);
 
     rsp = qmp("{ 'execute' : 'stop'}");
     qobject_unref(rsp);
@@ -131,7 +136,8 @@ static void rx_stop_cont_test(QVirtioDevice *dev,
     rsp = qmp("{ 'execute' : 'cont'}");
     qobject_unref(rsp);
 
-    qvirtio_wait_used_elem(dev, vq, free_head, NULL, QVIRTIO_NET_TIMEOUT_US);
+    qvirtio_wait_used_elem(qts, dev, vq, free_head, NULL,
+                           QVIRTIO_NET_TIMEOUT_US);
     memread(req_addr + VNET_HDR_SIZE, buffer, sizeof(test));
     g_assert_cmpstr(buffer, ==, "TEST");
 
@@ -283,19 +289,20 @@ static void large_tx(void *obj, void *data, QGuestAllocator *t_alloc)
     uint64_t req_addr;
     uint32_t free_head;
     size_t alloc_size = (size_t)data / 64;
+    QTestState *qts = global_qtest;
     int i;
 
     /* Bypass the limitation by pointing several descriptors to a single
      * smaller area */
     req_addr = guest_alloc(t_alloc, alloc_size);
-    free_head = qvirtqueue_add(vq, req_addr, alloc_size, false, true);
+    free_head = qvirtqueue_add(qts, vq, req_addr, alloc_size, false, true);
 
     for (i = 0; i < 64; i++) {
-        qvirtqueue_add(vq, req_addr, alloc_size, false, i != 63);
+        qvirtqueue_add(qts, vq, req_addr, alloc_size, false, i != 63);
     }
-    qvirtqueue_kick(dev->vdev, vq, free_head);
+    qvirtqueue_kick(qts, dev->vdev, vq, free_head);
 
-    qvirtio_wait_used_elem(dev->vdev, vq, free_head, NULL,
+    qvirtio_wait_used_elem(qts, dev->vdev, vq, free_head, NULL,
                            QVIRTIO_NET_TIMEOUT_US);
     guest_free(t_alloc, req_addr);
 }
diff --git a/tests/virtio-scsi-test.c b/tests/virtio-scsi-test.c
index ae6698ddb4..6393272149 100644
--- a/tests/virtio-scsi-test.c
+++ b/tests/virtio-scsi-test.c
@@ -72,6 +72,7 @@ static uint8_t virtio_scsi_do_command(QVirtioSCSIQueues *vs,
     uint64_t req_addr, resp_addr, data_in_addr = 0, data_out_addr = 0;
     uint8_t response;
     uint32_t free_head;
+    QTestState *qts = global_qtest;
 
     vq = vs->vq[2];
 
@@ -83,24 +84,24 @@ static uint8_t virtio_scsi_do_command(QVirtioSCSIQueues *vs,
 
     /* Add request header */
     req_addr = qvirtio_scsi_alloc(vs, sizeof(req), &req);
-    free_head = qvirtqueue_add(vq, req_addr, sizeof(req), false, true);
+    free_head = qvirtqueue_add(qts, vq, req_addr, sizeof(req), false, true);
 
     if (data_out_len) {
         data_out_addr = qvirtio_scsi_alloc(vs, data_out_len, data_out);
-        qvirtqueue_add(vq, data_out_addr, data_out_len, false, true);
+        qvirtqueue_add(qts, vq, data_out_addr, data_out_len, false, true);
     }
 
     /* Add response header */
     resp_addr = qvirtio_scsi_alloc(vs, sizeof(resp), &resp);
-    qvirtqueue_add(vq, resp_addr, sizeof(resp), true, !!data_in_len);
+    qvirtqueue_add(qts, vq, resp_addr, sizeof(resp), true, !!data_in_len);
 
     if (data_in_len) {
         data_in_addr = qvirtio_scsi_alloc(vs, data_in_len, data_in);
-        qvirtqueue_add(vq, data_in_addr, data_in_len, true, false);
+        qvirtqueue_add(qts, vq, data_in_addr, data_in_len, true, false);
     }
 
-    qvirtqueue_kick(vs->dev, vq, free_head);
-    qvirtio_wait_used_elem(vs->dev, vq, free_head, NULL,
+    qvirtqueue_kick(qts, vs->dev, vq, free_head);
+    qvirtio_wait_used_elem(qts, vs->dev, vq, free_head, NULL,
                            QVIRTIO_SCSI_TIMEOUT_US);
 
     response = readb(resp_addr +
-- 
2.18.1


