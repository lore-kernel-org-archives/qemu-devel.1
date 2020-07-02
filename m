Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B821C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 12:58:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2484720772
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 12:58:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HztCZtJY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2484720772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqynf-0001u2-Em
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 08:58:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53508)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jqylP-0006BC-Gw
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 08:56:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45814
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jqylN-0004Uz-MY
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 08:56:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593694585;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H2C0jip9yx0d5KNdPg+4uWR6SBLh4fq/pQRfW5Z3ch0=;
 b=HztCZtJYhDS+KGr/5T3+CGyqfsiBkeren6cW21ezsKs+2zjpBVCMxPc8Fxc8SGkDAlEMRu
 PnBCyhHrWsF7o7duEkVRscqaLsrapGRyqpFMVWySeeLjCP9rOFkKx05wXp1VBrcEG1rtZV
 26k3aJKFKYAyy9p2XWy99p1LsCPvGAA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-16SZzdgoP8y4jbm-GlQVUg-1; Thu, 02 Jul 2020 08:56:23 -0400
X-MC-Unique: 16SZzdgoP8y4jbm-GlQVUg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E4D2E1015DAB;
 Thu,  2 Jul 2020 12:56:21 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.36.110.52])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 58E9F2B4CA;
 Thu,  2 Jul 2020 12:56:19 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/3] util: support detailed error reporting for qemu_open
Date: Thu,  2 Jul 2020 13:56:11 +0100
Message-Id: <20200702125612.2176194-3-berrange@redhat.com>
In-Reply-To: <20200702125612.2176194-1-berrange@redhat.com>
References: <20200702125612.2176194-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 03:23:40
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 P J P <ppandit@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Create a "qemu_open_err" method which does the same as "qemu_open",
but with a "Error **errp" for error reporting. There should be no
behavioural difference for existing callers at this stage.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/qemu/osdep.h |  2 ++
 util/osdep.c         | 66 +++++++++++++++++++++++++++++++++++---------
 2 files changed, 55 insertions(+), 13 deletions(-)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 0d26a1b9bd..8506a978fa 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -483,6 +483,8 @@ int qemu_madvise(void *addr, size_t len, int advice);
 int qemu_mprotect_rwx(void *addr, size_t size);
 int qemu_mprotect_none(void *addr, size_t size);
 
+/* This is preferred over qemu_open for its improved error reporting */
+int qemu_open_err(const char *name, int flags, Error **errp, ...);
 int qemu_open(const char *name, int flags, ...);
 int qemu_close(int fd);
 int qemu_unlink(const char *name);
diff --git a/util/osdep.c b/util/osdep.c
index e2b7507ee2..3de8bee463 100644
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
+            error_setg(errp, "Could not parse fdset %s", name);
             errno = EINVAL;
             return -1;
         }
 
         fd = monitor_fdset_get_fd(fdset_id, flags);
         if (fd < 0) {
+            error_setg_errno(errp, -fd, "Could not acquire FD for %s flags %x",
+                             name, flags);
             errno = -fd;
             return -1;
         }
 
         dupfd = qemu_dup_flags(fd, flags);
         if (dupfd == -1) {
+            error_setg_errno(errp, errno, "Could not dup FD for %s flags %x",
+                             name, flags);
             return -1;
         }
 
         ret = monitor_fdset_dup_fd_add(fdset_id, dupfd);
         if (ret == -1) {
             close(dupfd);
+            error_setg(errp, "Could not save FD for %s flags %x",
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
@@ -342,21 +346,57 @@ int qemu_open(const char *name, int flags, ...)
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
-        ret = open(name, newflags, mode);
-        if (ret != -1) {
-            close(ret);
-            error_report("file system does not support O_DIRECT");
-            errno = EINVAL;
+        if (errno == EINVAL && (flags & O_DIRECT)) {
+            int newflags = flags & ~O_DIRECT;
+            ret = open(name, newflags, mode);
+            if (ret != -1) {
+                close(ret);
+                error_setg(errp, "Could not %s '%s' flags 0x%x: "
+                           "filesystem does not support O_DIRECT",
+                           action, name, flags);
+                errno = EINVAL;
+                return -1;
+            }
         }
-    }
 #endif /* O_DIRECT */
+        error_setg_errno(errp, errno, "Could not %s '%s' flags 0x%x",
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


