Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4DFFC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 12:52:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECFB4225A9
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 12:52:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TEzz8xju"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECFB4225A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSJmu-00077i-R5
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 08:52:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33120)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kSJlV-00063t-5U
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 08:50:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40148)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kSJlQ-0004W2-TU
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 08:50:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602593445;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=avFqmHepYDGFLumVby2C4H7xvnubxOsB6pbaaQUociU=;
 b=TEzz8xjuG0sAD4EKrTDy1ZEnVOyMhYC9TYHuI6DO6m/zBG+z9qTI4pNrbrIjGnTJwp+RlD
 AGP1K65YdUvxLoxjGMSvktR96aOoKeoCtvn4gSoK5sG4UXnA/GM6wM7MjTcW5LQrwGHi0a
 kHQ7m7iDATWAEG75oSob1FUwMD5p18w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-489-uG137OatPSaUkN27HPqF4Q-1; Tue, 13 Oct 2020 08:50:42 -0400
X-MC-Unique: uG137OatPSaUkN27HPqF4Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D819680732A;
 Tue, 13 Oct 2020 12:50:40 +0000 (UTC)
Received: from merkur.redhat.com (ovpn-114-201.ams2.redhat.com [10.36.114.201])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5ABA95DA33;
 Tue, 13 Oct 2020 12:50:38 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] monitor: Fix order in monitor_cleanup()
Date: Tue, 13 Oct 2020 14:50:27 +0200
Message-Id: <20201013125027.41003-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 02:06:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, alex.bennee@linaro.org, armbru@redhat.com,
 f4bug@amsat.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We can only destroy Monitor objects after we're sure that they are not
in use by the dispatcher coroutine any more. This fixes crashes like the
following where we tried to destroy a monitor mutex while the dispatcher
coroutine still holds it:

 (gdb) bt
 #0  0x00007fe541cf4bc5 in raise () at /lib64/libc.so.6
 #1  0x00007fe541cdd8a4 in abort () at /lib64/libc.so.6
 #2  0x000055c24e965327 in error_exit (err=16, msg=0x55c24eead3a0 <__func__.33> "qemu_mutex_destroy") at ../util/qemu-thread-posix.c:37
 #3  0x000055c24e9654c3 in qemu_mutex_destroy (mutex=0x55c25133e0f0) at ../util/qemu-thread-posix.c:70
 #4  0x000055c24e7cfaf1 in monitor_data_destroy_qmp (mon=0x55c25133dfd0) at ../monitor/qmp.c:439
 #5  0x000055c24e7d23bc in monitor_data_destroy (mon=0x55c25133dfd0) at ../monitor/monitor.c:615
 #6  0x000055c24e7d253a in monitor_cleanup () at ../monitor/monitor.c:644
 #7  0x000055c24e6cb002 in qemu_cleanup () at ../softmmu/vl.c:4549
 #8  0x000055c24e0d259b in main (argc=24, argv=0x7ffff66b0d58, envp=0x7ffff66b0e20) at ../softmmu/main.c:51

Reported-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 monitor/monitor.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/monitor/monitor.c b/monitor/monitor.c
index ceffe1a83b..84222cd130 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -632,23 +632,9 @@ void monitor_cleanup(void)
         iothread_stop(mon_iothread);
     }
 
-    /* Flush output buffers and destroy monitors */
-    qemu_mutex_lock(&monitor_lock);
-    monitor_destroyed = true;
-    while (!QTAILQ_EMPTY(&mon_list)) {
-        Monitor *mon = QTAILQ_FIRST(&mon_list);
-        QTAILQ_REMOVE(&mon_list, mon, entry);
-        /* Permit QAPI event emission from character frontend release */
-        qemu_mutex_unlock(&monitor_lock);
-        monitor_flush(mon);
-        monitor_data_destroy(mon);
-        qemu_mutex_lock(&monitor_lock);
-        g_free(mon);
-    }
-    qemu_mutex_unlock(&monitor_lock);
-
     /*
-     * The dispatcher needs to stop before destroying the I/O thread.
+     * The dispatcher needs to stop before destroying the monitor and
+     * the I/O thread.
      *
      * We need to poll both qemu_aio_context and iohandler_ctx to make
      * sure that the dispatcher coroutine keeps making progress and
@@ -665,6 +651,21 @@ void monitor_cleanup(void)
                    (aio_poll(iohandler_get_aio_context(), false),
                     qatomic_mb_read(&qmp_dispatcher_co_busy)));
 
+    /* Flush output buffers and destroy monitors */
+    qemu_mutex_lock(&monitor_lock);
+    monitor_destroyed = true;
+    while (!QTAILQ_EMPTY(&mon_list)) {
+        Monitor *mon = QTAILQ_FIRST(&mon_list);
+        QTAILQ_REMOVE(&mon_list, mon, entry);
+        /* Permit QAPI event emission from character frontend release */
+        qemu_mutex_unlock(&monitor_lock);
+        monitor_flush(mon);
+        monitor_data_destroy(mon);
+        qemu_mutex_lock(&monitor_lock);
+        g_free(mon);
+    }
+    qemu_mutex_unlock(&monitor_lock);
+
     if (mon_iothread) {
         iothread_destroy(mon_iothread);
         mon_iothread = NULL;
-- 
2.28.0


