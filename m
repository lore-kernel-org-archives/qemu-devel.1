Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F4CC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 14:54:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0F8A2083B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 14:54:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0F8A2083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k59Bk-0007cR-1S
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 10:54:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40744)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yezhenyu2@huawei.com>)
 id 1k59B0-0006Vq-EG; Mon, 10 Aug 2020 10:53:26 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4171 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yezhenyu2@huawei.com>)
 id 1k59Ax-0002ii-JS; Mon, 10 Aug 2020 10:53:26 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id AFB42ED14DB327769A69;
 Mon, 10 Aug 2020 22:53:07 +0800 (CST)
Received: from DESKTOP-KKJBAGG.china.huawei.com (10.174.186.173) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Mon, 10 Aug 2020 22:53:00 +0800
From: Zhenyu Ye <yezhenyu2@huawei.com>
To: <qemu-devel@nongnu.org>, <qemu-block@nongnu.org>
Subject: [PATCH v1 1/2] util: introduce aio_context_acquire_timeout
Date: Mon, 10 Aug 2020 22:52:45 +0800
Message-ID: <20200810145246.1049-2-yezhenyu2@huawei.com>
X-Mailer: git-send-email 2.22.0.windows.1
In-Reply-To: <20200810145246.1049-1-yezhenyu2@huawei.com>
References: <20200810145246.1049-1-yezhenyu2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.174.186.173]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.190; envelope-from=yezhenyu2@huawei.com;
 helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 10:53:08
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, fam@euphon.net, yezhenyu2@huawei.com, armbru@redhat.com,
 xiexiangyou@huawei.com, mreitz@redhat.com, stefanha@redhat.com,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently we only have the aio_context_acquire() to take the
ownership of the AioContext.  If the mutex is locked by other
threads, this function will wait util the mutex is released.

Sometimes we may want to get some return values after waiting
for some time.  So introduce aio_context_acquire_timeout(),
which will return ETIMEDOUT after @t seconds.

This will be used in next patch.

Signed-off-by: Zhenyu Ye <yezhenyu2@huawei.com>
---
 include/block/aio.h         |  5 +++++
 include/qemu/thread-posix.h |  1 +
 include/qemu/thread.h       |  1 +
 util/async.c                | 10 ++++++++++
 util/qemu-thread-posix.c    |  6 ++++++
 5 files changed, 23 insertions(+)

diff --git a/include/block/aio.h b/include/block/aio.h
index b2f703fa3f..cb178cdf5a 100644
--- a/include/block/aio.h
+++ b/include/block/aio.h
@@ -287,6 +287,11 @@ void aio_context_unref(AioContext *ctx);
  */
 void aio_context_acquire(AioContext *ctx);
 
+/* Add timeout to aio_context_acquire().  If the time for obtaining
+ * the lock exceeds @t, return ETIMEDOUT.
+ */
+int aio_context_acquire_timeout(AioContext *ctx, int t);
+
 /* Relinquish ownership of the AioContext. */
 void aio_context_release(AioContext *ctx);
 
diff --git a/include/qemu/thread-posix.h b/include/qemu/thread-posix.h
index c903525062..2e62181959 100644
--- a/include/qemu/thread-posix.h
+++ b/include/qemu/thread-posix.h
@@ -9,6 +9,7 @@ typedef QemuMutex QemuRecMutex;
 #define qemu_rec_mutex_lock_impl    qemu_mutex_lock_impl
 #define qemu_rec_mutex_trylock_impl qemu_mutex_trylock_impl
 #define qemu_rec_mutex_unlock qemu_mutex_unlock
+#define qemu_rec_mutex_timed_lock qemu_mutex_timed_lock
 
 struct QemuMutex {
     pthread_mutex_t lock;
diff --git a/include/qemu/thread.h b/include/qemu/thread.h
index 4baf4d1715..7a96a5df2a 100644
--- a/include/qemu/thread.h
+++ b/include/qemu/thread.h
@@ -27,6 +27,7 @@ void qemu_mutex_destroy(QemuMutex *mutex);
 int qemu_mutex_trylock_impl(QemuMutex *mutex, const char *file, const int line);
 void qemu_mutex_lock_impl(QemuMutex *mutex, const char *file, const int line);
 void qemu_mutex_unlock_impl(QemuMutex *mutex, const char *file, const int line);
+int qemu_mutex_timed_lock(QemuMutex *mutex, const struct timespec *tsptr);
 
 typedef void (*QemuMutexLockFunc)(QemuMutex *m, const char *f, int l);
 typedef int (*QemuMutexTrylockFunc)(QemuMutex *m, const char *f, int l);
diff --git a/util/async.c b/util/async.c
index 1319eee3bc..c478d3dbf5 100644
--- a/util/async.c
+++ b/util/async.c
@@ -605,6 +605,16 @@ void aio_context_acquire(AioContext *ctx)
     qemu_rec_mutex_lock(&ctx->lock);
 }
 
+int aio_context_acquire_timeout(AioContext *ctx, int t)
+{
+    struct timespec tout;
+
+    clock_gettime(CLOCK_REALTIME, &tout);
+    tout.tv_sec += t;
+
+    return qemu_rec_mutex_timed_lock(&ctx->lock, &tout);
+}
+
 void aio_context_release(AioContext *ctx)
 {
     qemu_rec_mutex_unlock(&ctx->lock);
diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
index b4c2359272..49fb98a2e8 100644
--- a/util/qemu-thread-posix.c
+++ b/util/qemu-thread-posix.c
@@ -82,6 +82,12 @@ void qemu_mutex_lock_impl(QemuMutex *mutex, const char *file, const int line)
     qemu_mutex_post_lock(mutex, file, line);
 }
 
+int qemu_mutex_timed_lock(QemuMutex *mutex, const struct timespec *tsptr)
+{
+    assert(mutex->initialized);
+    return pthread_mutex_timedlock(&mutex->lock, tsptr);
+}
+
 int qemu_mutex_trylock_impl(QemuMutex *mutex, const char *file, const int line)
 {
     int err;
-- 
2.22.0.windows.1



