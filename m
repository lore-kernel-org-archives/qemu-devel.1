Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A32C10F27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 10:36:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C908920726
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 10:36:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C908920726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jByiW-0003yq-VV
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 06:36:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43595)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jByd9-0002vL-Bw
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 06:30:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jByd7-0001XQ-J3
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 06:30:27 -0400
Received: from relay.sw.ru ([185.231.240.75]:33078)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jByd3-0001Rk-IQ; Wed, 11 Mar 2020 06:30:21 -0400
Received: from vovaso.qa.sw.ru ([10.94.3.0] helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1jBycx-0005cJ-Ne; Wed, 11 Mar 2020 13:30:15 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 1/9] job: refactor progress to separate object
Date: Wed, 11 Mar 2020 13:29:56 +0300
Message-Id: <20200311103004.7649-2-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200311103004.7649-1-vsementsov@virtuozzo.com>
References: <20200311103004.7649-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 185.231.240.75
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-stable@nongnu.org,
 qemu-devel@nongnu.org, mreitz@redhat.com, andrey.shinkevich@virtuozzo.com,
 jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We need it in separate to pass to the block-copy object in the next
commit.

Cc: qemu-stable@nongnu.org
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 include/qemu/job.h            | 11 ++-----
 include/qemu/progress_meter.h | 58 +++++++++++++++++++++++++++++++++++
 blockjob.c                    | 16 +++++-----
 job-qmp.c                     |  4 +--
 job.c                         |  6 ++--
 qemu-img.c                    |  6 ++--
 6 files changed, 76 insertions(+), 25 deletions(-)
 create mode 100644 include/qemu/progress_meter.h

diff --git a/include/qemu/job.h b/include/qemu/job.h
index bd59cd8944..32aabb1c60 100644
--- a/include/qemu/job.h
+++ b/include/qemu/job.h
@@ -28,6 +28,7 @@
 
 #include "qapi/qapi-types-job.h"
 #include "qemu/queue.h"
+#include "qemu/progress_meter.h"
 #include "qemu/coroutine.h"
 #include "block/aio.h"
 
@@ -117,15 +118,7 @@ typedef struct Job {
     /** True if this job should automatically dismiss itself */
     bool auto_dismiss;
 
-    /**
-     * Current progress. The unit is arbitrary as long as the ratio between
-     * progress_current and progress_total represents the estimated percentage
-     * of work already done.
-     */
-    int64_t progress_current;
-
-    /** Estimated progress_current value at the completion of the job */
-    int64_t progress_total;
+    ProgressMeter progress;
 
     /**
      * Return code from @run and/or @prepare callback(s).
diff --git a/include/qemu/progress_meter.h b/include/qemu/progress_meter.h
new file mode 100644
index 0000000000..9a23ff071c
--- /dev/null
+++ b/include/qemu/progress_meter.h
@@ -0,0 +1,58 @@
+/*
+ * Helper functionality for some process progress tracking.
+ *
+ * Copyright (c) 2011 IBM Corp.
+ * Copyright (c) 2012, 2018 Red Hat, Inc.
+ * Copyright (c) 2020 Virtuozzo International GmbH
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#ifndef QEMU_PROGRESS_METER_H
+#define QEMU_PROGRESS_METER_H
+
+typedef struct ProgressMeter {
+    /**
+     * Current progress. The unit is arbitrary as long as the ratio between
+     * current and total represents the estimated percentage
+     * of work already done.
+     */
+    uint64_t current;
+
+    /** Estimated current value at the completion of the process */
+    uint64_t total;
+} ProgressMeter;
+
+static inline void progress_work_done(ProgressMeter *pm, uint64_t done)
+{
+    pm->current += done;
+}
+
+static inline void progress_set_remaining(ProgressMeter *pm, uint64_t remaining)
+{
+    pm->total = pm->current + remaining;
+}
+
+static inline void progress_increase_remaining(ProgressMeter *pm,
+                                               uint64_t delta)
+{
+    pm->total += delta;
+}
+
+#endif /* QEMU_PROGRESS_METER_H */
diff --git a/blockjob.c b/blockjob.c
index 5d63b1e89d..fc850312c1 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -299,8 +299,8 @@ BlockJobInfo *block_job_query(BlockJob *job, Error **errp)
     info->device    = g_strdup(job->job.id);
     info->busy      = atomic_read(&job->job.busy);
     info->paused    = job->job.pause_count > 0;
-    info->offset    = job->job.progress_current;
-    info->len       = job->job.progress_total;
+    info->offset    = job->job.progress.current;
+    info->len       = job->job.progress.total;
     info->speed     = job->speed;
     info->io_status = job->iostatus;
     info->ready     = job_is_ready(&job->job),
@@ -330,8 +330,8 @@ static void block_job_event_cancelled(Notifier *n, void *opaque)
 
     qapi_event_send_block_job_cancelled(job_type(&job->job),
                                         job->job.id,
-                                        job->job.progress_total,
-                                        job->job.progress_current,
+                                        job->job.progress.total,
+                                        job->job.progress.current,
                                         job->speed);
 }
 
@@ -350,8 +350,8 @@ static void block_job_event_completed(Notifier *n, void *opaque)
 
     qapi_event_send_block_job_completed(job_type(&job->job),
                                         job->job.id,
-                                        job->job.progress_total,
-                                        job->job.progress_current,
+                                        job->job.progress.total,
+                                        job->job.progress.current,
                                         job->speed,
                                         !!msg,
                                         msg);
@@ -379,8 +379,8 @@ static void block_job_event_ready(Notifier *n, void *opaque)
 
     qapi_event_send_block_job_ready(job_type(&job->job),
                                     job->job.id,
-                                    job->job.progress_total,
-                                    job->job.progress_current,
+                                    job->job.progress.total,
+                                    job->job.progress.current,
                                     job->speed);
 }
 
diff --git a/job-qmp.c b/job-qmp.c
index fbfed25a00..fecc939ebd 100644
--- a/job-qmp.c
+++ b/job-qmp.c
@@ -143,8 +143,8 @@ static JobInfo *job_query_single(Job *job, Error **errp)
         .id                 = g_strdup(job->id),
         .type               = job_type(job),
         .status             = job->status,
-        .current_progress   = job->progress_current,
-        .total_progress     = job->progress_total,
+        .current_progress   = job->progress.current,
+        .total_progress     = job->progress.total,
         .has_error          = !!job->err,
         .error              = job->err ? \
                               g_strdup(error_get_pretty(job->err)) : NULL,
diff --git a/job.c b/job.c
index 04409b40aa..134a07b92e 100644
--- a/job.c
+++ b/job.c
@@ -369,17 +369,17 @@ void job_unref(Job *job)
 
 void job_progress_update(Job *job, uint64_t done)
 {
-    job->progress_current += done;
+    progress_work_done(&job->progress, done);
 }
 
 void job_progress_set_remaining(Job *job, uint64_t remaining)
 {
-    job->progress_total = job->progress_current + remaining;
+    progress_set_remaining(&job->progress, remaining);
 }
 
 void job_progress_increase_remaining(Job *job, uint64_t delta)
 {
-    job->progress_total += delta;
+    progress_increase_remaining(&job->progress, delta);
 }
 
 void job_event_cancelled(Job *job)
diff --git a/qemu-img.c b/qemu-img.c
index 804630a368..59a720abf6 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -882,9 +882,9 @@ static void run_block_job(BlockJob *job, Error **errp)
     do {
         float progress = 0.0f;
         aio_poll(aio_context, true);
-        if (job->job.progress_total) {
-            progress = (float)job->job.progress_current /
-                       job->job.progress_total * 100.f;
+        if (job->job.progress.total) {
+            progress = (float)job->job.progress.current /
+                       job->job.progress.total * 100.f;
         }
         qemu_progress_print(progress, 0);
     } while (!job_is_ready(&job->job) && !job_is_completed(&job->job));
-- 
2.21.0


