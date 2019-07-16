Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC90C76195
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 08:14:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10E4721721
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 08:14:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aN22qr0C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10E4721721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnIb8-0002CV-QB
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 04:14:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59998)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hnIYh-000056-4o
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 04:11:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hnIYe-0003I1-Do
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 04:11:34 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:52474)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1hnIYe-0003H9-60
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 04:11:32 -0400
Received: by mail-wm1-x331.google.com with SMTP id s3so17662748wms.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2019 01:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4hRVM+k2vb0KY/USDpjU+G8mA47ikDVkV4soPANDuFE=;
 b=aN22qr0Cnq9KG2bwQGY2l4oHqrReUKiaJUSfiRTSRCq1rf2zgLHwt86Ik1CsxItlgq
 JyasKJSJNPr6+5ikue8zkNS2Wh1Djlt5masDLc0HulRCnzab2kgT7k3lzy9/KcZgfMLx
 ovztYLxdNNRkJHDPRrKc1JTpHUvHlzohGAhoYCxHEG5QNTSAZQeoWgmGfAxwsTfK5W+p
 +e6B3JXopUWkrGJodgI0HIIKkviWWBewcuP9AaYUYcYyopgk7ocPOMBKn6ELZqFa0rg8
 +wQsZggxTCnNquZude7hpcnsFmGqtLYw68z6kPQ9tc4VHr+UXc1JfsN+ay2omOeP08Mr
 xjIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=4hRVM+k2vb0KY/USDpjU+G8mA47ikDVkV4soPANDuFE=;
 b=RSOzN0fm7Vt/a4jhZ87HnVw7lcpWms57I6A4xVJ7eflezb1sX7OuoFFOOGOFRVWhqw
 BRG6jdA5mo5OyVzaQr4olYmyPINW3VFQOrW1tyG/34CK2Dcq2ZwxdFVuS3DPiEgEf2r9
 Jc4JJhLPv/v6+5O6AduqRW0ukV+vd0ZA2rC0EiWRG9kOAkYw69JKudV8W+COupQ04QvT
 ljRyD7NfFUNvBd5wikDfDQApfQfx9ui3KnUcOV9bb4UA2jA8QjXMuCUZ5djN8J5HK514
 33YtoIs8M8sxekI9+KnyK2u2c/ZDhp9GWrt0WgpfjRAwcUPiYTFvcWezB+j7eE76/OPK
 M+5Q==
X-Gm-Message-State: APjAAAUz2jhyBrrg4nifcKxG4l4ImBl3KK3NB0l1Hs4ZTh0Nqhike0L+
 lVH6jqep7EhlHc/aMFcr1upxplp4Ugs=
X-Google-Smtp-Source: APXvYqzdyLvdVRzbhgEm0GZBzJjPCQj9mkhxAeU3XHSGfcPEFVdV1RzJyXQuIlmOlY+1pp4Z3Z5EAw==
X-Received: by 2002:a1c:6643:: with SMTP id a64mr29964000wmc.154.1563264690770; 
 Tue, 16 Jul 2019 01:11:30 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id c1sm37723879wrh.1.2019.07.16.01.11.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 16 Jul 2019 01:11:30 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 16 Jul 2019 10:11:09 +0200
Message-Id: <1563264677-39718-12-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1563264677-39718-1-git-send-email-pbonzini@redhat.com>
References: <1563264677-39718-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::331
Subject: [Qemu-devel] [PULL 11/19] util: merge main-loop.c and iohandler.c
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

main-loop.c has a dependency on iohandler.c, and everything breaks
if that dependency is instead satisfied by stubs/iohandler.c.
Just put everything in the same file to avoid strange dependencies
on the order of files in util-obj-y.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <1562952875-53702-1-git-send-email-pbonzini@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 util/Makefile.objs |   2 +-
 util/iohandler.c   | 135 -----------------------------------------------------
 util/main-loop.c   | 110 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 111 insertions(+), 136 deletions(-)
 delete mode 100644 util/iohandler.c

diff --git a/util/Makefile.objs b/util/Makefile.objs
index 68af3cd..41bf59d 100644
--- a/util/Makefile.objs
+++ b/util/Makefile.objs
@@ -2,7 +2,7 @@ util-obj-y = osdep.o cutils.o unicode.o qemu-timer-common.o
 util-obj-y += bufferiszero.o
 util-obj-y += lockcnt.o
 util-obj-y += aiocb.o async.o aio-wait.o thread-pool.o qemu-timer.o
-util-obj-y += main-loop.o iohandler.o
+util-obj-y += main-loop.o
 util-obj-$(call lnot,$(CONFIG_ATOMIC64)) += atomic64.o
 util-obj-$(CONFIG_POSIX) += aio-posix.o
 util-obj-$(CONFIG_POSIX) += compatfd.o
diff --git a/util/iohandler.c b/util/iohandler.c
deleted file mode 100644
index bece882..0000000
--- a/util/iohandler.c
+++ /dev/null
@@ -1,135 +0,0 @@
-/*
- * QEMU System Emulator - managing I/O handler
- *
- * Copyright (c) 2003-2008 Fabrice Bellard
- *
- * Permission is hereby granted, free of charge, to any person obtaining a copy
- * of this software and associated documentation files (the "Software"), to deal
- * in the Software without restriction, including without limitation the rights
- * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
- * copies of the Software, and to permit persons to whom the Software is
- * furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
- * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
- * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
- * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
- * THE SOFTWARE.
- */
-
-#include "qemu/osdep.h"
-#include "qapi/error.h"
-#include "qemu/queue.h"
-#include "block/aio.h"
-#include "qemu/main-loop.h"
-
-#ifndef _WIN32
-#include <sys/wait.h>
-#endif
-
-/* This context runs on top of main loop. We can't reuse qemu_aio_context
- * because iohandlers mustn't be polled by aio_poll(qemu_aio_context). */
-static AioContext *iohandler_ctx;
-
-static void iohandler_init(void)
-{
-    if (!iohandler_ctx) {
-        iohandler_ctx = aio_context_new(&error_abort);
-    }
-}
-
-AioContext *iohandler_get_aio_context(void)
-{
-    iohandler_init();
-    return iohandler_ctx;
-}
-
-GSource *iohandler_get_g_source(void)
-{
-    iohandler_init();
-    return aio_get_g_source(iohandler_ctx);
-}
-
-void qemu_set_fd_handler(int fd,
-                         IOHandler *fd_read,
-                         IOHandler *fd_write,
-                         void *opaque)
-{
-    iohandler_init();
-    aio_set_fd_handler(iohandler_ctx, fd, false,
-                       fd_read, fd_write, NULL, opaque);
-}
-
-void event_notifier_set_handler(EventNotifier *e,
-                                EventNotifierHandler *handler)
-{
-    iohandler_init();
-    aio_set_event_notifier(iohandler_ctx, e, false,
-                           handler, NULL);
-}
-
-/* reaping of zombies.  right now we're not passing the status to
-   anyone, but it would be possible to add a callback.  */
-#ifndef _WIN32
-typedef struct ChildProcessRecord {
-    int pid;
-    QLIST_ENTRY(ChildProcessRecord) next;
-} ChildProcessRecord;
-
-static QLIST_HEAD(, ChildProcessRecord) child_watches =
-    QLIST_HEAD_INITIALIZER(child_watches);
-
-static QEMUBH *sigchld_bh;
-
-static void sigchld_handler(int signal)
-{
-    qemu_bh_schedule(sigchld_bh);
-}
-
-static void sigchld_bh_handler(void *opaque)
-{
-    ChildProcessRecord *rec, *next;
-
-    QLIST_FOREACH_SAFE(rec, &child_watches, next, next) {
-        if (waitpid(rec->pid, NULL, WNOHANG) == rec->pid) {
-            QLIST_REMOVE(rec, next);
-            g_free(rec);
-        }
-    }
-}
-
-static void qemu_init_child_watch(void)
-{
-    struct sigaction act;
-    sigchld_bh = qemu_bh_new(sigchld_bh_handler, NULL);
-
-    memset(&act, 0, sizeof(act));
-    act.sa_handler = sigchld_handler;
-    act.sa_flags = SA_NOCLDSTOP;
-    sigaction(SIGCHLD, &act, NULL);
-}
-
-int qemu_add_child_watch(pid_t pid)
-{
-    ChildProcessRecord *rec;
-
-    if (!sigchld_bh) {
-        qemu_init_child_watch();
-    }
-
-    QLIST_FOREACH(rec, &child_watches, next) {
-        if (rec->pid == pid) {
-            return 1;
-        }
-    }
-    rec = g_malloc0(sizeof(ChildProcessRecord));
-    rec->pid = pid;
-    QLIST_INSERT_HEAD(&child_watches, rec, next);
-    return 0;
-}
-#endif
diff --git a/util/main-loop.c b/util/main-loop.c
index a9f4e8d..e3eaa55 100644
--- a/util/main-loop.c
+++ b/util/main-loop.c
@@ -32,6 +32,11 @@
 #include "qemu/main-loop.h"
 #include "block/aio.h"
 #include "qemu/error-report.h"
+#include "qemu/queue.h"
+
+#ifndef _WIN32
+#include <sys/wait.h>
+#endif
 
 #ifndef _WIN32
 
@@ -525,3 +530,108 @@ QEMUBH *qemu_bh_new(QEMUBHFunc *cb, void *opaque)
 {
     return aio_bh_new(qemu_aio_context, cb, opaque);
 }
+
+/*
+ * Functions to operate on the I/O handler AioContext.
+ * This context runs on top of main loop. We can't reuse qemu_aio_context
+ * because iohandlers mustn't be polled by aio_poll(qemu_aio_context).
+ */
+static AioContext *iohandler_ctx;
+
+static void iohandler_init(void)
+{
+    if (!iohandler_ctx) {
+        iohandler_ctx = aio_context_new(&error_abort);
+    }
+}
+
+AioContext *iohandler_get_aio_context(void)
+{
+    iohandler_init();
+    return iohandler_ctx;
+}
+
+GSource *iohandler_get_g_source(void)
+{
+    iohandler_init();
+    return aio_get_g_source(iohandler_ctx);
+}
+
+void qemu_set_fd_handler(int fd,
+                         IOHandler *fd_read,
+                         IOHandler *fd_write,
+                         void *opaque)
+{
+    iohandler_init();
+    aio_set_fd_handler(iohandler_ctx, fd, false,
+                       fd_read, fd_write, NULL, opaque);
+}
+
+void event_notifier_set_handler(EventNotifier *e,
+                                EventNotifierHandler *handler)
+{
+    iohandler_init();
+    aio_set_event_notifier(iohandler_ctx, e, false,
+                           handler, NULL);
+}
+
+/* reaping of zombies.  right now we're not passing the status to
+   anyone, but it would be possible to add a callback.  */
+#ifndef _WIN32
+typedef struct ChildProcessRecord {
+    int pid;
+    QLIST_ENTRY(ChildProcessRecord) next;
+} ChildProcessRecord;
+
+static QLIST_HEAD(, ChildProcessRecord) child_watches =
+    QLIST_HEAD_INITIALIZER(child_watches);
+
+static QEMUBH *sigchld_bh;
+
+static void sigchld_handler(int signal)
+{
+    qemu_bh_schedule(sigchld_bh);
+}
+
+static void sigchld_bh_handler(void *opaque)
+{
+    ChildProcessRecord *rec, *next;
+
+    QLIST_FOREACH_SAFE(rec, &child_watches, next, next) {
+        if (waitpid(rec->pid, NULL, WNOHANG) == rec->pid) {
+            QLIST_REMOVE(rec, next);
+            g_free(rec);
+        }
+    }
+}
+
+static void qemu_init_child_watch(void)
+{
+    struct sigaction act;
+    sigchld_bh = qemu_bh_new(sigchld_bh_handler, NULL);
+
+    memset(&act, 0, sizeof(act));
+    act.sa_handler = sigchld_handler;
+    act.sa_flags = SA_NOCLDSTOP;
+    sigaction(SIGCHLD, &act, NULL);
+}
+
+int qemu_add_child_watch(pid_t pid)
+{
+    ChildProcessRecord *rec;
+
+    if (!sigchld_bh) {
+        qemu_init_child_watch();
+    }
+
+    QLIST_FOREACH(rec, &child_watches, next) {
+        if (rec->pid == pid) {
+            return 1;
+        }
+    }
+    rec = g_malloc0(sizeof(ChildProcessRecord));
+    rec->pid = pid;
+    QLIST_INSERT_HEAD(&child_watches, rec, next);
+    return 0;
+}
+#endif
-- 
1.8.3.1



