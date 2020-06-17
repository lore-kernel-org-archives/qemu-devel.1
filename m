Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AAE3C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 14:51:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE01B2073E
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 14:51:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZH+HNl/6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE01B2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlZPc-0005nb-RW
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 10:51:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45016)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jlZNd-0002rU-7X
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 10:49:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22852
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jlZNW-0001eF-RH
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 10:49:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592405364;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1OkAX3Snq8ZE3zFbYQJi9tGeAS9Ynk5O0dFhCFpVXKQ=;
 b=ZH+HNl/6PWM1M6Z7vY1ZN9vc+rmxJGcEO6vVr7gMpd8MXt24jRNBOsE9/ZfDFlB9bzu0kF
 h7UgKbNVE6gH7X7AFJCrt2LVexYS1jhvaiIvK28zXUrcUuT0lhwhhQOuHOilLnHFugcOyu
 iPY4KG/J9qSgIKsGr/eksaGe/IAFdYE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-pcuWkRTbPbOX5YG3ia0liA-1; Wed, 17 Jun 2020 10:49:19 -0400
X-MC-Unique: pcuWkRTbPbOX5YG3ia0liA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BEBCA100CCC9;
 Wed, 17 Jun 2020 14:49:18 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-44.ams2.redhat.com [10.36.114.44])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C61BF7CAA0;
 Wed, 17 Jun 2020 14:49:17 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 04/43] virtio-blk: On restart,
 process queued requests in the proper context
Date: Wed, 17 Jun 2020 16:48:30 +0200
Message-Id: <20200617144909.192176-5-kwolf@redhat.com>
In-Reply-To: <20200617144909.192176-1-kwolf@redhat.com>
References: <20200617144909.192176-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 01:42:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Sergio Lopez <slp@redhat.com>

On restart, we were scheduling a BH to process queued requests, which
would run before starting up the data plane, leading to those requests
being assigned and started on coroutines on the main context.

This could cause requests to be wrongly processed in parallel from
different threads (the main thread and the iothread managing the data
plane), potentially leading to multiple issues.

For example, stopping and resuming a VM multiple times while the guest
is generating I/O on a virtio_blk device can trigger a crash with a
stack tracing looking like this one:

<------>
 Thread 2 (Thread 0x7ff736765700 (LWP 1062503)):
 #0  0x00005567a13b99d6 in iov_memset
     (iov=0x6563617073206f4e, iov_cnt=1717922848, offset=516096, fillc=0, bytes=7018105756081554803)
     at util/iov.c:69
 #1  0x00005567a13bab73 in qemu_iovec_memset
     (qiov=0x7ff73ec99748, offset=516096, fillc=0, bytes=7018105756081554803) at util/iov.c:530
 #2  0x00005567a12f411c in qemu_laio_process_completion (laiocb=0x7ff6512ee6c0) at block/linux-aio.c:86
 #3  0x00005567a12f42ff in qemu_laio_process_completions (s=0x7ff7182e8420) at block/linux-aio.c:217
 #4  0x00005567a12f480d in ioq_submit (s=0x7ff7182e8420) at block/linux-aio.c:323
 #5  0x00005567a12f43d9 in qemu_laio_process_completions_and_submit (s=0x7ff7182e8420)
     at block/linux-aio.c:236
 #6  0x00005567a12f44c2 in qemu_laio_poll_cb (opaque=0x7ff7182e8430) at block/linux-aio.c:267
 #7  0x00005567a13aed83 in run_poll_handlers_once (ctx=0x5567a2b58c70, timeout=0x7ff7367645f8)
     at util/aio-posix.c:520
 #8  0x00005567a13aee9f in run_poll_handlers (ctx=0x5567a2b58c70, max_ns=16000, timeout=0x7ff7367645f8)
     at util/aio-posix.c:562
 #9  0x00005567a13aefde in try_poll_mode (ctx=0x5567a2b58c70, timeout=0x7ff7367645f8)
     at util/aio-posix.c:597
 #10 0x00005567a13af115 in aio_poll (ctx=0x5567a2b58c70, blocking=true) at util/aio-posix.c:639
 #11 0x00005567a109acca in iothread_run (opaque=0x5567a2b29760) at iothread.c:75
 #12 0x00005567a13b2790 in qemu_thread_start (args=0x5567a2b694c0) at util/qemu-thread-posix.c:519
 #13 0x00007ff73eedf2de in start_thread () at /lib64/libpthread.so.0
 #14 0x00007ff73ec10e83 in clone () at /lib64/libc.so.6

 Thread 1 (Thread 0x7ff743986f00 (LWP 1062500)):
 #0  0x00005567a13b99d6 in iov_memset
     (iov=0x6563617073206f4e, iov_cnt=1717922848, offset=516096, fillc=0, bytes=7018105756081554803)
     at util/iov.c:69
 #1  0x00005567a13bab73 in qemu_iovec_memset
     (qiov=0x7ff73ec99748, offset=516096, fillc=0, bytes=7018105756081554803) at util/iov.c:530
 #2  0x00005567a12f411c in qemu_laio_process_completion (laiocb=0x7ff6512ee6c0) at block/linux-aio.c:86
 #3  0x00005567a12f42ff in qemu_laio_process_completions (s=0x7ff7182e8420) at block/linux-aio.c:217
 #4  0x00005567a12f480d in ioq_submit (s=0x7ff7182e8420) at block/linux-aio.c:323
 #5  0x00005567a12f4a2f in laio_do_submit (fd=19, laiocb=0x7ff5f4ff9ae0, offset=472363008, type=2)
     at block/linux-aio.c:375
 #6  0x00005567a12f4af2 in laio_co_submit
     (bs=0x5567a2b8c460, s=0x7ff7182e8420, fd=19, offset=472363008, qiov=0x7ff5f4ff9ca0, type=2)
     at block/linux-aio.c:394
 #7  0x00005567a12f1803 in raw_co_prw
     (bs=0x5567a2b8c460, offset=472363008, bytes=20480, qiov=0x7ff5f4ff9ca0, type=2)
     at block/file-posix.c:1892
 #8  0x00005567a12f1941 in raw_co_pwritev
     (bs=0x5567a2b8c460, offset=472363008, bytes=20480, qiov=0x7ff5f4ff9ca0, flags=0)
     at block/file-posix.c:1925
 #9  0x00005567a12fe3e1 in bdrv_driver_pwritev
     (bs=0x5567a2b8c460, offset=472363008, bytes=20480, qiov=0x7ff5f4ff9ca0, qiov_offset=0, flags=0)
     at block/io.c:1183
 #10 0x00005567a1300340 in bdrv_aligned_pwritev
     (child=0x5567a2b5b070, req=0x7ff5f4ff9db0, offset=472363008, bytes=20480, align=512, qiov=0x7ff72c0425b8, qiov_offset=0, flags=0) at block/io.c:1980
 #11 0x00005567a1300b29 in bdrv_co_pwritev_part
     (child=0x5567a2b5b070, offset=472363008, bytes=20480, qiov=0x7ff72c0425b8, qiov_offset=0, flags=0)
     at block/io.c:2137
 #12 0x00005567a12baba1 in qcow2_co_pwritev_task
     (bs=0x5567a2b92740, file_cluster_offset=472317952, offset=487305216, bytes=20480, qiov=0x7ff72c0425b8, qiov_offset=0, l2meta=0x0) at block/qcow2.c:2444
 #13 0x00005567a12bacdb in qcow2_co_pwritev_task_entry (task=0x5567a2b48540) at block/qcow2.c:2475
 #14 0x00005567a13167d8 in aio_task_co (opaque=0x5567a2b48540) at block/aio_task.c:45
 #15 0x00005567a13cf00c in coroutine_trampoline (i0=738245600, i1=32759) at util/coroutine-ucontext.c:115
 #16 0x00007ff73eb622e0 in __start_context () at /lib64/libc.so.6
 #17 0x00007ff6626f1350 in  ()
 #18 0x0000000000000000 in  ()
<------>

This is also known to cause crashes with this message (assertion
failed):

 aio_co_schedule: Co-routine was already scheduled in 'aio_co_schedule'

RHBZ: https://bugzilla.redhat.com/show_bug.cgi?id=1812765
Signed-off-by: Sergio Lopez <slp@redhat.com>
Message-Id: <20200603093240.40489-3-slp@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/hw/virtio/virtio-blk.h  |  2 +-
 hw/block/dataplane/virtio-blk.c |  8 ++++++++
 hw/block/virtio-blk.c           | 18 ++++++++++++------
 3 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/include/hw/virtio/virtio-blk.h b/include/hw/virtio/virtio-blk.h
index f584ad9b86..b1334c3904 100644
--- a/include/hw/virtio/virtio-blk.h
+++ b/include/hw/virtio/virtio-blk.h
@@ -86,6 +86,6 @@ typedef struct MultiReqBuffer {
 } MultiReqBuffer;
 
 bool virtio_blk_handle_vq(VirtIOBlock *s, VirtQueue *vq);
-void virtio_blk_process_queued_requests(VirtIOBlock *s);
+void virtio_blk_process_queued_requests(VirtIOBlock *s, bool is_bh);
 
 #endif
diff --git a/hw/block/dataplane/virtio-blk.c b/hw/block/dataplane/virtio-blk.c
index 1b52e8159c..37499c5564 100644
--- a/hw/block/dataplane/virtio-blk.c
+++ b/hw/block/dataplane/virtio-blk.c
@@ -220,6 +220,9 @@ int virtio_blk_data_plane_start(VirtIODevice *vdev)
         goto fail_guest_notifiers;
     }
 
+    /* Process queued requests before the ones in vring */
+    virtio_blk_process_queued_requests(vblk, false);
+
     /* Kick right away to begin processing requests already in vring */
     for (i = 0; i < nvqs; i++) {
         VirtQueue *vq = virtio_get_queue(s->vdev, i);
@@ -239,6 +242,11 @@ int virtio_blk_data_plane_start(VirtIODevice *vdev)
     return 0;
 
   fail_guest_notifiers:
+    /*
+     * If we failed to set up the guest notifiers queued requests will be
+     * processed on the main context.
+     */
+    virtio_blk_process_queued_requests(vblk, false);
     vblk->dataplane_disabled = true;
     s->starting = false;
     vblk->dataplane_started = true;
diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 978574e4da..8882a1d1d4 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -819,7 +819,7 @@ static void virtio_blk_handle_output(VirtIODevice *vdev, VirtQueue *vq)
     virtio_blk_handle_output_do(s, vq);
 }
 
-void virtio_blk_process_queued_requests(VirtIOBlock *s)
+void virtio_blk_process_queued_requests(VirtIOBlock *s, bool is_bh)
 {
     VirtIOBlockReq *req = s->rq;
     MultiReqBuffer mrb = {};
@@ -847,7 +847,9 @@ void virtio_blk_process_queued_requests(VirtIOBlock *s)
     if (mrb.num_reqs) {
         virtio_blk_submit_multireq(s->blk, &mrb);
     }
-    blk_dec_in_flight(s->conf.conf.blk);
+    if (is_bh) {
+        blk_dec_in_flight(s->conf.conf.blk);
+    }
     aio_context_release(blk_get_aio_context(s->conf.conf.blk));
 }
 
@@ -858,21 +860,25 @@ static void virtio_blk_dma_restart_bh(void *opaque)
     qemu_bh_delete(s->bh);
     s->bh = NULL;
 
-    virtio_blk_process_queued_requests(s);
+    virtio_blk_process_queued_requests(s, true);
 }
 
 static void virtio_blk_dma_restart_cb(void *opaque, int running,
                                       RunState state)
 {
     VirtIOBlock *s = opaque;
+    BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(s)));
+    VirtioBusState *bus = VIRTIO_BUS(qbus);
 
     if (!running) {
         return;
     }
 
-    if (!s->bh) {
-        /* FIXME The data plane is not started yet, so these requests are
-         * processed in the main thread. */
+    /*
+     * If ioeventfd is enabled, don't schedule the BH here as queued
+     * requests will be processed while starting the data plane.
+     */
+    if (!s->bh && !virtio_bus_ioeventfd_enabled(bus)) {
         s->bh = aio_bh_new(blk_get_aio_context(s->conf.conf.blk),
                            virtio_blk_dma_restart_bh, s);
         blk_inc_in_flight(s->conf.conf.blk);
-- 
2.25.4


