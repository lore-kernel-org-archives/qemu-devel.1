Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77EACC433E1
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 16:14:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46638207FB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 16:14:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HEhdRz+G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46638207FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqfNF-0001ok-FX
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 12:14:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38184)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jqfEk-0003E7-Ds
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 12:05:26 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:20000)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jqfEd-000581-UX
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 12:05:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593619519;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6clJ9K3XBLp8GdGzUQ1X1i6FU4glV+t8wJxNhnZ6yNM=;
 b=HEhdRz+GzK3zAqthaogfKmBJ8YcW6RYs7HsHn+yBopau3hLnh6HsjxGf7UNg/O+c6mlmb3
 oMmCy91yKiclSty2AdyTJ6uiK0bP7RMfA76tEsDZGW3SfBrx2n+bBBdhXDGbhkpqnSN9hY
 CExXaqwfzDWBKvb6CHQ1zl03NmW/7nI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-tX6yP5cBNm6QU9ixWMuCCg-1; Wed, 01 Jul 2020 12:05:17 -0400
X-MC-Unique: tX6yP5cBNm6QU9ixWMuCCg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 721D41B18BE0;
 Wed,  1 Jul 2020 16:05:16 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.36.110.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C20F52B4B6;
 Wed,  1 Jul 2020 16:05:14 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/3] util: support detailed error reporting for qemu_open
Date: Wed,  1 Jul 2020 17:05:08 +0100
Message-Id: <20200701160509.1523847-3-berrange@redhat.com>
In-Reply-To: <20200701160509.1523847-1-berrange@redhat.com>
References: <20200701160509.1523847-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 01:05:53
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
Cc: Kevin Wolf <kwolf@redhat.com>, P J P <ppandit@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Create a "qemu_open_err" method which does the same as "qemu_open",
but with a "Error **errp" for error reporting. There should be no
behavioural difference for existing callers at this stage.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/qemu/osdep.h |  1 +
 util/osdep.c         | 71 +++++++++++++++++++++++++++++++++++---------
 2 files changed, 58 insertions(+), 14 deletions(-)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 0d26a1b9bd..e41701a308 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -483,6 +483,7 @@ int qemu_madvise(void *addr, size_t len, int advice);
 int qemu_mprotect_rwx(void *addr, size_t size);
 int qemu_mprotect_none(void *addr, size_t size);
 
+int qemu_open_err(const char *name, int flags, Error **errp, ...);
 int qemu_open(const char *name, int flags, ...);
 int qemu_close(int fd);
 int qemu_unlink(const char *name);
diff --git a/util/osdep.c b/util/osdep.c
index 4bdbe81cec..450b3a5da3 100644
--- a/util/osdep.c
+++ b/util/osdep.c
@@ -22,6 +22,7 @@
  * THE SOFTWARE.
  */
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 
 /* Needed early for CONFIG_BSD etc. */
 
@@ -282,7 +283,7 @@ int qemu_lock_fd_test(int fd, int64_t start, int64_t len, bool exclusive)
 /*
  * Opens a file with FD_CLOEXEC set
  */
-int qemu_open(const char *name, int flags, ...)
+static int qemu_openv(const char *name, int flags, Error **errp, va_list ap)
 {
     int ret;
     int mode = 0;
@@ -297,24 +298,31 @@ int qemu_open(const char *name, int flags, ...)
 
         fdset_id = qemu_parse_fdset(fdset_id_str);
         if (fdset_id == -1) {
+            error_setg(errp, "Unable to parse fdset %s", name);
             errno = EINVAL;
             return -1;
         }
 
         fd = monitor_fdset_get_fd(fdset_id, flags);
         if (fd < 0) {
+            error_setg_errno(errp, -fd, "Unable acquire FD for %s flags %x",
+                             name, flags);
             errno = -fd;
             return -1;
         }
 
         dupfd = qemu_dup_flags(fd, flags);
         if (dupfd == -1) {
+            error_setg_errno(errp, errno, "Unable dup FD for %s flags %x",
+                             name, flags);
             return -1;
         }
 
         ret = monitor_fdset_dup_fd_add(fdset_id, dupfd);
         if (ret == -1) {
             close(dupfd);
+            error_setg(errp, "Unable save FD for %s flags %x",
+                       name, flags);
             errno = EINVAL;
             return -1;
         }
@@ -324,11 +332,7 @@ int qemu_open(const char *name, int flags, ...)
 #endif
 
     if (flags & O_CREAT) {
-        va_list ap;
-
-        va_start(ap, flags);
         mode = va_arg(ap, int);
-        va_end(ap);
     }
 
 #ifdef O_CLOEXEC
@@ -340,25 +344,64 @@ int qemu_open(const char *name, int flags, ...)
     }
 #endif
 
+    if (ret == -1) {
+        const char *action = "open";
+        if (flags & O_CREAT) {
+            action = "create";
+        }
 #ifdef O_DIRECT
-    if (ret == -1 && errno == EINVAL && (flags & O_DIRECT)) {
-        int newflags = flags & ~O_DIRECT;
+        if (errno == EINVAL && (flags & O_DIRECT)) {
+            int newflags = flags & ~O_DIRECT;
 # ifdef O_CLOEXEC
-        ret = open(name, newflags | O_CLOEXEC, mode);
+            ret = open(name, newflags | O_CLOEXEC, mode);
 # else
-        ret = open(name, newflags, mode);
+            ret = open(name, newflags, mode);
 # endif
-        if (ret != -1) {
-            close(ret);
-            error_report("file system does not support O_DIRECT");
-            errno = EINVAL;
+            if (ret != -1) {
+                close(ret);
+                error_setg(errp, "Unable to %s '%s' flags 0x%x: "
+                           "filesystem does not support O_DIRECT",
+                           action, name, flags);
+                if (!errp) {
+                    error_report("file system does not support O_DIRECT");
+                }
+                errno = EINVAL;
+                return -1;
+            }
         }
-    }
 #endif /* O_DIRECT */
+        error_setg_errno(errp, errno, "Unable to %s '%s' flags 0x%x",
+                         action, name, flags);
+    }
+
 
     return ret;
 }
 
+int qemu_open_err(const char *name, int flags, Error **errp, ...)
+{
+    va_list ap;
+    int rv;
+
+    va_start(ap, errp);
+    rv = qemu_openv(name, flags, errp, ap);
+    va_end(ap);
+
+    return rv;
+}
+
+int qemu_open(const char *name, int flags, ...)
+{
+    va_list ap;
+    int rv;
+
+    va_start(ap, flags);
+    rv = qemu_openv(name, flags, NULL, ap);
+    va_end(ap);
+
+    return rv;
+}
+
 int qemu_close(int fd)
 {
     int64_t fdset_id;
-- 
2.26.2


