Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C011CC3A5A5
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 06:23:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 979B920882
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 06:23:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 979B920882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i52Dy-0003Io-MB
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 02:23:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57034)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1i529i-0007EL-RS
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 02:19:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1i529h-0003aH-Hr
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 02:19:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34076)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1i529h-0003ZG-AF
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 02:19:05 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C8D5FC054C52
 for <qemu-devel@nongnu.org>; Tue,  3 Sep 2019 06:19:03 +0000 (UTC)
Received: from thuth.com (ovpn-116-80.ams2.redhat.com [10.36.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 57B2460127;
 Tue,  3 Sep 2019 06:19:02 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>,
	qemu-devel@nongnu.org
Date: Tue,  3 Sep 2019 08:18:46 +0200
Message-Id: <20190903061849.21493-4-thuth@redhat.com>
In-Reply-To: <20190903061849.21493-1-thuth@redhat.com>
References: <20190903061849.21493-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Tue, 03 Sep 2019 06:19:03 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 3/6] tests/libqos: Replace clock_step with
 qtest_clock_step in virtio code
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Library functions should not rely on functions that require global_qtest
(since they might get used in tests that deal with multiple states).
Commit 1999a70a05ad603d ("Make generic virtio code independent from
global_qtest") already tried to clean the libqos virtio code, but I
missed to replace the clock_step() function. Thus change it now to
qtest_clock_step() instead.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/libqos/virtio.c   | 15 ++++++++-------
 tests/libqos/virtio.h   |  5 +++--
 tests/virtio-blk-test.c |  8 +++++---
 3 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/tests/libqos/virtio.c b/tests/libqos/virtio.c
index 91ce06954b..5a2ed7a1a5 100644
--- a/tests/libqos/virtio.c
+++ b/tests/libqos/virtio.c
@@ -82,13 +82,13 @@ void qvirtio_set_driver_ok(QVirtioDevice *d)
                     VIRTIO_CONFIG_S_DRIVER | VIRTIO_CONFIG_S_ACKNOWLEDGE);
 }
 
-void qvirtio_wait_queue_isr(QVirtioDevice *d,
+void qvirtio_wait_queue_isr(QTestState *qts, QVirtioDevice *d,
                             QVirtQueue *vq, gint64 timeout_us)
 {
     gint64 start_time = g_get_monotonic_time();
 
     for (;;) {
-        clock_step(100);
+        qtest_clock_step(qts, 100);
         if (d->bus->get_queue_isr_status(d, vq)) {
             return;
         }
@@ -109,8 +109,8 @@ uint8_t qvirtio_wait_status_byte_no_isr(QTestState *qts, QVirtioDevice *d,
     gint64 start_time = g_get_monotonic_time();
     uint8_t val;
 
-    while ((val = readb(addr)) == 0xff) {
-        clock_step(100);
+    while ((val = qtest_readb(qts, addr)) == 0xff) {
+        qtest_clock_step(qts, 100);
         g_assert(!d->bus->get_queue_isr_status(d, vq));
         g_assert(g_get_monotonic_time() - start_time <= timeout_us);
     }
@@ -137,7 +137,7 @@ void qvirtio_wait_used_elem(QTestState *qts, QVirtioDevice *d,
     for (;;) {
         uint32_t got_desc_idx;
 
-        clock_step(100);
+        qtest_clock_step(qts, 100);
 
         if (d->bus->get_queue_isr_status(d, vq) &&
             qvirtqueue_get_buf(qts, vq, &got_desc_idx, len)) {
@@ -149,12 +149,13 @@ void qvirtio_wait_used_elem(QTestState *qts, QVirtioDevice *d,
     }
 }
 
-void qvirtio_wait_config_isr(QVirtioDevice *d, gint64 timeout_us)
+void qvirtio_wait_config_isr(QTestState *qts, QVirtioDevice *d,
+                             gint64 timeout_us)
 {
     gint64 start_time = g_get_monotonic_time();
 
     for (;;) {
-        clock_step(100);
+        qtest_clock_step(qts, 100);
         if (d->bus->get_config_isr_status(d)) {
             return;
         }
diff --git a/tests/libqos/virtio.h b/tests/libqos/virtio.h
index 037176dbd8..1a93f9b1de 100644
--- a/tests/libqos/virtio.h
+++ b/tests/libqos/virtio.h
@@ -112,7 +112,7 @@ void qvirtio_set_acknowledge(QVirtioDevice *d);
 void qvirtio_set_driver(QVirtioDevice *d);
 void qvirtio_set_driver_ok(QVirtioDevice *d);
 
-void qvirtio_wait_queue_isr(QVirtioDevice *d,
+void qvirtio_wait_queue_isr(QTestState *qts, QVirtioDevice *d,
                             QVirtQueue *vq, gint64 timeout_us);
 uint8_t qvirtio_wait_status_byte_no_isr(QTestState *qts, QVirtioDevice *d,
                                         QVirtQueue *vq,
@@ -123,7 +123,8 @@ void qvirtio_wait_used_elem(QTestState *qts, QVirtioDevice *d,
                             uint32_t desc_idx,
                             uint32_t *len,
                             gint64 timeout_us);
-void qvirtio_wait_config_isr(QVirtioDevice *d, gint64 timeout_us);
+void qvirtio_wait_config_isr(QTestState *qts, QVirtioDevice *d,
+                             gint64 timeout_us);
 QVirtQueue *qvirtqueue_setup(QVirtioDevice *d,
                              QGuestAllocator *alloc, uint16_t index);
 void qvirtqueue_cleanup(const QVirtioBus *bus, QVirtQueue *vq,
diff --git a/tests/virtio-blk-test.c b/tests/virtio-blk-test.c
index 982ff1538c..247fef0b0f 100644
--- a/tests/virtio-blk-test.c
+++ b/tests/virtio-blk-test.c
@@ -435,6 +435,7 @@ static void config(void *obj, void *data, QGuestAllocator *t_alloc)
     QVirtioDevice *dev = blk_if->vdev;
     int n_size = TEST_IMAGE_SIZE / 2;
     uint64_t capacity;
+    QTestState *qts = global_qtest;
 
     capacity = qvirtio_config_readq(dev, 0);
     g_assert_cmpint(capacity, ==, TEST_IMAGE_SIZE / 512);
@@ -444,7 +445,7 @@ static void config(void *obj, void *data, QGuestAllocator *t_alloc)
     qmp_discard_response("{ 'execute': 'block_resize', "
                          " 'arguments': { 'device': 'drive0', "
                          " 'size': %d } }", n_size);
-    qvirtio_wait_config_isr(dev, QVIRTIO_BLK_TIMEOUT_US);
+    qvirtio_wait_config_isr(qts, dev, QVIRTIO_BLK_TIMEOUT_US);
 
     capacity = qvirtio_config_readq(dev, 0);
     g_assert_cmpint(capacity, ==, n_size / 512);
@@ -494,7 +495,7 @@ static void msix(void *obj, void *u_data, QGuestAllocator *t_alloc)
                          " 'arguments': { 'device': 'drive0', "
                          " 'size': %d } }", n_size);
 
-    qvirtio_wait_config_isr(dev, QVIRTIO_BLK_TIMEOUT_US);
+    qvirtio_wait_config_isr(qts, dev, QVIRTIO_BLK_TIMEOUT_US);
 
     capacity = qvirtio_config_readq(dev, 0);
     g_assert_cmpint(capacity, ==, n_size / 512);
@@ -737,6 +738,7 @@ static void resize(void *obj, void *data, QGuestAllocator *t_alloc)
     int n_size = TEST_IMAGE_SIZE / 2;
     uint64_t capacity;
     QVirtQueue *vq;
+    QTestState *qts = global_qtest;
 
     vq = qvirtqueue_setup(dev, t_alloc, 0);
 
@@ -746,7 +748,7 @@ static void resize(void *obj, void *data, QGuestAllocator *t_alloc)
                          " 'arguments': { 'device': 'drive0', "
                          " 'size': %d } }", n_size);
 
-    qvirtio_wait_queue_isr(dev, vq, QVIRTIO_BLK_TIMEOUT_US);
+    qvirtio_wait_queue_isr(qts, dev, vq, QVIRTIO_BLK_TIMEOUT_US);
 
     capacity = qvirtio_config_readq(dev, 0);
     g_assert_cmpint(capacity, ==, n_size / 512);
-- 
2.18.1


