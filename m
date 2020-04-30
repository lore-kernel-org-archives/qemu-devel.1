Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB75C8300A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 09:14:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F0A32137B
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 09:14:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F0A32137B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU5H4-0008Ak-H3
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 05:14:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46098)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Pavel.Dovgaluk@gmail.com>) id 1jU5GT-0007lD-NO
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 05:13:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <Pavel.Dovgaluk@gmail.com>) id 1jU5GS-0003kH-Vp
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 05:13:53 -0400
Received: from mail.ispras.ru ([83.149.199.45]:48140)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Pavel.Dovgaluk@gmail.com>) id 1jU5GS-0003k6-Eo
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 05:13:52 -0400
Received: from [127.0.1.1] (unknown [62.118.151.149])
 by mail.ispras.ru (Postfix) with ESMTPSA id 19F08CD467;
 Thu, 30 Apr 2020 12:13:50 +0300 (MSK)
Subject: [PATCH] replay: implement fair mutex
From: Pavel Dovgalyuk <Pavel.Dovgaluk@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu, 30 Apr 2020 12:13:49 +0300
Message-ID: <158823802979.28101.9340462887738957616.stgit@pasha-ThinkPad-X280>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Received-SPF: softfail client-ip=83.149.199.45;
 envelope-from=Pavel.Dovgaluk@gmail.com; helo=mail.ispras.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 05:02:52
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Received-From: 83.149.199.45
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
Cc: pbonzini@redhat.com, dovgaluk@ispras.ru, pavel.dovgaluk@ispras.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In record/replay icount mode main loop thread and vCPU thread
do not perform simultaneously. They take replay mutex to synchronize
the actions. Sometimes vCPU thread waits for locking the mutex for
very long time, because main loop releases the mutex and takes it
back again. Standard qemu mutex do not provide the ordering
capabilities.

This patch adds a "queue" for replay mutex. Therefore thread ordering
becomes more "fair". Threads are executed in the same order as
they are trying to take the mutex.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
---
 replay/replay-internal.c |   15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/replay/replay-internal.c b/replay/replay-internal.c
index eba8246aae..2e8a3e947a 100644
--- a/replay/replay-internal.c
+++ b/replay/replay-internal.c
@@ -22,6 +22,9 @@
    It also protects replay events queue which stores events to be
    written or read to the log. */
 static QemuMutex lock;
+/* Condition and queue for fair ordering of mutex lock requests. */
+static QemuCond mutex_cond;
+static unsigned long mutex_head, mutex_tail;
 
 /* File for replay writing */
 static bool write_error;
@@ -197,9 +200,10 @@ static __thread bool replay_locked;
 void replay_mutex_init(void)
 {
     qemu_mutex_init(&lock);
+    qemu_cond_init(&mutex_cond);
     /* Hold the mutex while we start-up */
-    qemu_mutex_lock(&lock);
     replay_locked = true;
+    ++mutex_tail;
 }
 
 bool replay_mutex_locked(void)
@@ -211,10 +215,16 @@ bool replay_mutex_locked(void)
 void replay_mutex_lock(void)
 {
     if (replay_mode != REPLAY_MODE_NONE) {
+        unsigned long id;
         g_assert(!qemu_mutex_iothread_locked());
         g_assert(!replay_mutex_locked());
         qemu_mutex_lock(&lock);
+        id = mutex_tail++;
+        while (id != mutex_head) {
+            qemu_cond_wait(&mutex_cond, &lock);
+        }
         replay_locked = true;
+        qemu_mutex_unlock(&lock);
     }
 }
 
@@ -222,7 +232,10 @@ void replay_mutex_unlock(void)
 {
     if (replay_mode != REPLAY_MODE_NONE) {
         g_assert(replay_mutex_locked());
+        qemu_mutex_lock(&lock);
+        ++mutex_head;
         replay_locked = false;
+        qemu_cond_broadcast(&mutex_cond);
         qemu_mutex_unlock(&lock);
     }
 }


