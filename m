Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C5EC10F27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 14:06:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADE5020726
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 14:06:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a4fCWxNg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADE5020726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC20A-00051M-QR
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 10:06:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36463)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jC1n9-0004a8-L0
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 09:53:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1jC1n6-0002mX-N6
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 09:52:59 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46441
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1jC1n6-0002mI-Jh
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 09:52:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583934776;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0kektsXP0bBWlwkT7LISL9VsGVcoi+D3UJMsHcF90LM=;
 b=a4fCWxNgSTnsYCAcM+vvTrw7Cg96dDQ2LhBc+N5bznsCle6VDQ/9nWWT7z9sR3cXXARSN0
 ykhzH8ubmjA+o9nkLO6xGarhVKJOwsgJBB8wQF805B1WMK2NVsfqMV8JScnLq3qmKQ5226
 ZAHyO1WODs6zywTQglOnZJJrIWeYLdg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-244-Kuibd38tNrCsmQI87cQTeg-1; Wed, 11 Mar 2020 09:52:50 -0400
X-MC-Unique: Kuibd38tNrCsmQI87cQTeg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D630C8014D3;
 Wed, 11 Mar 2020 13:52:49 +0000 (UTC)
Received: from localhost (ovpn-117-216.ams2.redhat.com [10.36.117.216])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EB9CE5DA7C;
 Wed, 11 Mar 2020 13:52:48 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 11/19] job: refactor progress to separate object
Date: Wed, 11 Mar 2020 14:52:05 +0100
Message-Id: <20200311135213.1242028-12-mreitz@redhat.com>
In-Reply-To: <20200311135213.1242028-1-mreitz@redhat.com>
References: <20200311135213.1242028-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

We need it in separate to pass to the block-copy object in the next
commit.

Cc: qemu-stable@nongnu.org
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-Id: <20200311103004.7649-2-vsementsov@virtuozzo.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 blockjob.c                    | 16 +++++-----
 include/qemu/job.h            | 11 ++-----
 include/qemu/progress_meter.h | 58 +++++++++++++++++++++++++++++++++++
 job-qmp.c                     |  4 +--
 job.c                         |  6 ++--
 qemu-img.c                    |  6 ++--
 6 files changed, 76 insertions(+), 25 deletions(-)
 create mode 100644 include/qemu/progress_meter.h

diff --git a/blockjob.c b/blockjob.c
index 5d63b1e89d..fc850312c1 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -299,8 +299,8 @@ BlockJobInfo *block_job_query(BlockJob *job, Error **er=
rp)
     info->device    =3D g_strdup(job->job.id);
     info->busy      =3D atomic_read(&job->job.busy);
     info->paused    =3D job->job.pause_count > 0;
-    info->offset    =3D job->job.progress_current;
-    info->len       =3D job->job.progress_total;
+    info->offset    =3D job->job.progress.current;
+    info->len       =3D job->job.progress.total;
     info->speed     =3D job->speed;
     info->io_status =3D job->iostatus;
     info->ready     =3D job_is_ready(&job->job),
@@ -330,8 +330,8 @@ static void block_job_event_cancelled(Notifier *n, void=
 *opaque)
=20
     qapi_event_send_block_job_cancelled(job_type(&job->job),
                                         job->job.id,
-                                        job->job.progress_total,
-                                        job->job.progress_current,
+                                        job->job.progress.total,
+                                        job->job.progress.current,
                                         job->speed);
 }
=20
@@ -350,8 +350,8 @@ static void block_job_event_completed(Notifier *n, void=
 *opaque)
=20
     qapi_event_send_block_job_completed(job_type(&job->job),
                                         job->job.id,
-                                        job->job.progress_total,
-                                        job->job.progress_current,
+                                        job->job.progress.total,
+                                        job->job.progress.current,
                                         job->speed,
                                         !!msg,
                                         msg);
@@ -379,8 +379,8 @@ static void block_job_event_ready(Notifier *n, void *op=
aque)
=20
     qapi_event_send_block_job_ready(job_type(&job->job),
                                     job->job.id,
-                                    job->job.progress_total,
-                                    job->job.progress_current,
+                                    job->job.progress.total,
+                                    job->job.progress.current,
                                     job->speed);
 }
=20
diff --git a/include/qemu/job.h b/include/qemu/job.h
index bd59cd8944..32aabb1c60 100644
--- a/include/qemu/job.h
+++ b/include/qemu/job.h
@@ -28,6 +28,7 @@
=20
 #include "qapi/qapi-types-job.h"
 #include "qemu/queue.h"
+#include "qemu/progress_meter.h"
 #include "qemu/coroutine.h"
 #include "block/aio.h"
=20
@@ -117,15 +118,7 @@ typedef struct Job {
     /** True if this job should automatically dismiss itself */
     bool auto_dismiss;
=20
-    /**
-     * Current progress. The unit is arbitrary as long as the ratio betwee=
n
-     * progress_current and progress_total represents the estimated percen=
tage
-     * of work already done.
-     */
-    int64_t progress_current;
-
-    /** Estimated progress_current value at the completion of the job */
-    int64_t progress_total;
+    ProgressMeter progress;
=20
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
+ * Permission is hereby granted, free of charge, to any person obtaining a=
 copy
+ * of this software and associated documentation files (the "Software"), t=
o deal
+ * in the Software without restriction, including without limitation the r=
ights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or se=
ll
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included=
 in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS=
 OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY=
,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OT=
HER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING=
 FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS =
IN
+ * THE SOFTWARE.
+ */
+
+#ifndef QEMU_PROGRESS_METER_H
+#define QEMU_PROGRESS_METER_H
+
+typedef struct ProgressMeter {
+    /**
+     * Current progress. The unit is arbitrary as long as the ratio betwee=
n
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
+    pm->current +=3D done;
+}
+
+static inline void progress_set_remaining(ProgressMeter *pm, uint64_t rema=
ining)
+{
+    pm->total =3D pm->current + remaining;
+}
+
+static inline void progress_increase_remaining(ProgressMeter *pm,
+                                               uint64_t delta)
+{
+    pm->total +=3D delta;
+}
+
+#endif /* QEMU_PROGRESS_METER_H */
diff --git a/job-qmp.c b/job-qmp.c
index fbfed25a00..fecc939ebd 100644
--- a/job-qmp.c
+++ b/job-qmp.c
@@ -143,8 +143,8 @@ static JobInfo *job_query_single(Job *job, Error **errp=
)
         .id                 =3D g_strdup(job->id),
         .type               =3D job_type(job),
         .status             =3D job->status,
-        .current_progress   =3D job->progress_current,
-        .total_progress     =3D job->progress_total,
+        .current_progress   =3D job->progress.current,
+        .total_progress     =3D job->progress.total,
         .has_error          =3D !!job->err,
         .error              =3D job->err ? \
                               g_strdup(error_get_pretty(job->err)) : NULL,
diff --git a/job.c b/job.c
index 04409b40aa..134a07b92e 100644
--- a/job.c
+++ b/job.c
@@ -369,17 +369,17 @@ void job_unref(Job *job)
=20
 void job_progress_update(Job *job, uint64_t done)
 {
-    job->progress_current +=3D done;
+    progress_work_done(&job->progress, done);
 }
=20
 void job_progress_set_remaining(Job *job, uint64_t remaining)
 {
-    job->progress_total =3D job->progress_current + remaining;
+    progress_set_remaining(&job->progress, remaining);
 }
=20
 void job_progress_increase_remaining(Job *job, uint64_t delta)
 {
-    job->progress_total +=3D delta;
+    progress_increase_remaining(&job->progress, delta);
 }
=20
 void job_event_cancelled(Job *job)
diff --git a/qemu-img.c b/qemu-img.c
index 7b7087dd60..afddf33f08 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -884,9 +884,9 @@ static void run_block_job(BlockJob *job, Error **errp)
     do {
         float progress =3D 0.0f;
         aio_poll(aio_context, true);
-        if (job->job.progress_total) {
-            progress =3D (float)job->job.progress_current /
-                       job->job.progress_total * 100.f;
+        if (job->job.progress.total) {
+            progress =3D (float)job->job.progress.current /
+                       job->job.progress.total * 100.f;
         }
         qemu_progress_print(progress, 0);
     } while (!job_is_ready(&job->job) && !job_is_completed(&job->job));
--=20
2.24.1


