Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF825C73C7C
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 09:25:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C06F620838
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 09:25:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="S1g9Yt94"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C06F620838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hl8qo-0000j8-3h
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 05:25:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47446)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <yury-kotov@yandex-team.ru>) id 1hl8pe-0008B4-G8
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 05:24:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yury-kotov@yandex-team.ru>) id 1hl8pc-0007tK-Ti
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 05:24:10 -0400
Received: from forwardcorp1p.mail.yandex.net
 ([2a02:6b8:0:1472:2741:0:8b6:217]:37888)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yury-kotov@yandex-team.ru>)
 id 1hl8pb-0007l4-TE
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 05:24:08 -0400
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net
 [IPv6:2a02:6b8:0:1402::301])
 by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id CA4042E0466;
 Wed, 10 Jul 2019 12:24:02 +0300 (MSK)
Received: from smtpcorp1p.mail.yandex.net (smtpcorp1p.mail.yandex.net
 [2a02:6b8:0:1472:2741:0:8b6:10])
 by mxbackcorp1g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id
 t9gaglKD8z-O1tmQUTT; Wed, 10 Jul 2019 12:24:02 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1562750642; bh=h4G/QjfAJsFRsNw+o0CNfQMAlC3NaMMgRZUhG6VtW5Q=;
 h=In-Reply-To:Message-Id:References:Date:Subject:To:From:Cc;
 b=S1g9Yt94sJA9NVsnabY4OoRif89MqtKvc9fbLn5T5f2gXQwfyew9j6qlr+qTXfBWl
 yyGP8mczasIAJwN3cXM47CrAcQHnbnh1NjOMJrLikoO/AfoSLATkg/7sTusYmNfHuX
 VitFdfSAO7Lg0dtP2c0Unwxl5ksrlaRYYAHNQ078=
Authentication-Results: mxbackcorp1g.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net
 [2a02:6b8:0:40c:649c:ccd6:daab:d003])
 by smtpcorp1p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id
 c6HGiW8rtf-O1waakWw; Wed, 10 Jul 2019 12:24:01 +0300
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (Client certificate not present)
From: Yury Kotov <yury-kotov@yandex-team.ru>
To: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Stefan Weil <sw@weilnetz.de>, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Date: Wed, 10 Jul 2019 12:23:37 +0300
Message-Id: <20190710092338.23559-2-yury-kotov@yandex-team.ru>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190710092338.23559-1-yury-kotov@yandex-team.ru>
References: <20190710092338.23559-1-yury-kotov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a02:6b8:0:1472:2741:0:8b6:217
Subject: [Qemu-devel] [RFC PATCH 1/2] qemu-thread: Add qemu_cond_timedwait
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "open list:Overall" <qemu-devel@nongnu.org>, yc-core@yandex-team.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
---
 include/qemu/thread.h    | 12 ++++++++++++
 util/qemu-thread-posix.c | 40 ++++++++++++++++++++++++++++------------
 util/qemu-thread-win32.c | 16 ++++++++++++++++
 3 files changed, 56 insertions(+), 12 deletions(-)

diff --git a/include/qemu/thread.h b/include/qemu/thread.h
index 55d83a907c..80898c5db4 100644
--- a/include/qemu/thread.h
+++ b/include/qemu/thread.h
@@ -140,6 +140,18 @@ static inline void (qemu_cond_wait)(QemuCond *cond, =
QemuMutex *mutex)
     qemu_cond_wait(cond, mutex);
 }
=20
+void qemu_cond_timedwait_impl(QemuCond *cond, QemuMutex *mutex, int ms,
+                              const char *file, const int line);
+
+#define qemu_cond_timedwait(cond, mutex, ms) \
+        qemu_cond_timedwait_impl(cond, mutex, ms, __FILE__, __LINE__)
+
+static inline void (qemu_cond_timedwait)(QemuCond *cond, QemuMutex *mute=
x,
+                                         int ms)
+{
+    qemu_cond_timedwait(cond, mutex, ms);
+}
+
 void qemu_sem_init(QemuSemaphore *sem, int init);
 void qemu_sem_post(QemuSemaphore *sem);
 void qemu_sem_wait(QemuSemaphore *sem);
diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
index 1bf5e65dea..eed777d9ec 100644
--- a/util/qemu-thread-posix.c
+++ b/util/qemu-thread-posix.c
@@ -36,6 +36,18 @@ static void error_exit(int err, const char *msg)
     abort();
 }
=20
+static void compute_abs_deadline(struct timespec *ts, int ms)
+{
+    struct timeval tv;
+    gettimeofday(&tv, NULL);
+    ts->tv_nsec =3D tv.tv_usec * 1000 + (ms % 1000) * 1000000;
+    ts->tv_sec =3D tv.tv_sec + ms / 1000;
+    if (ts->tv_nsec >=3D 1000000000) {
+        ts->tv_sec++;
+        ts->tv_nsec -=3D 1000000000;
+    }
+}
+
 void qemu_mutex_init(QemuMutex *mutex)
 {
     int err;
@@ -164,6 +176,22 @@ void qemu_cond_wait_impl(QemuCond *cond, QemuMutex *=
mutex, const char *file, con
         error_exit(err, __func__);
 }
=20
+void qemu_cond_timedwait_impl(QemuCond *cond, QemuMutex *mutex, int ms,
+                              const char *file, const int line)
+{
+    int err;
+    struct timespec ts;
+
+    assert(cond->initialized);
+    trace_qemu_mutex_unlock(mutex, file, line);
+    compute_abs_deadline(&ts, ms);
+    err =3D pthread_cond_timedwait(&cond->cond, &mutex->lock, &ts);
+    trace_qemu_mutex_locked(mutex, file, line);
+    if (err && err !=3D ETIMEDOUT) {
+        error_exit(err, __func__);
+    }
+}
+
 void qemu_sem_init(QemuSemaphore *sem, int init)
 {
     int rc;
@@ -238,18 +266,6 @@ void qemu_sem_post(QemuSemaphore *sem)
 #endif
 }
=20
-static void compute_abs_deadline(struct timespec *ts, int ms)
-{
-    struct timeval tv;
-    gettimeofday(&tv, NULL);
-    ts->tv_nsec =3D tv.tv_usec * 1000 + (ms % 1000) * 1000000;
-    ts->tv_sec =3D tv.tv_sec + ms / 1000;
-    if (ts->tv_nsec >=3D 1000000000) {
-        ts->tv_sec++;
-        ts->tv_nsec -=3D 1000000000;
-    }
-}
-
 int qemu_sem_timedwait(QemuSemaphore *sem, int ms)
 {
     int rc;
diff --git a/util/qemu-thread-win32.c b/util/qemu-thread-win32.c
index 572f88535d..5faa01cb61 100644
--- a/util/qemu-thread-win32.c
+++ b/util/qemu-thread-win32.c
@@ -145,6 +145,22 @@ void qemu_cond_wait_impl(QemuCond *cond, QemuMutex *=
mutex, const char *file, con
     qemu_mutex_post_lock(mutex, file, line);
 }
=20
+void qemu_cond_timedwait_impl(QemuCond *cond, QemuMutex *mutex, int ms,
+                              const char *file, const int line)
+{
+    int rc =3D 0;
+
+    assert(cond->initialized);
+    trace_qemu_mutex_unlock(mutex, file, line);
+    if (!SleepConditionVariableSRW(&cond->var, &mutex->lock, ms, 0)) {
+        rc =3D GetLastError();
+    }
+    trace_qemu_mutex_locked(mutex, file, line);
+    if (rc && rc !=3D ERROR_TIMEOUT) {
+        error_exit(rc, __func__);
+    }
+}
+
 void qemu_sem_init(QemuSemaphore *sem, int init)
 {
     /* Manual reset.  */
--=20
2.22.0


