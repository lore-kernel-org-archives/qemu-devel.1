Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D516DC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 13:28:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3863206D7
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 13:28:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZO8USNwy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3863206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyxk8-0004Cj-Ub
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 09:28:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45254)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jyxhp-0008NM-BU
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 09:25:45 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:47477
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jyxhl-0000yk-HG
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 09:25:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595597140;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FVLJQBlpzqBBVnliqAGNcm2SnVqNp/hd2S0oSd+u5cU=;
 b=ZO8USNwytS+Robb89ZTXU3HeouIT0XbW7BH2/uJp2RqBMBiPextCh8245N/4E4++2vAGdV
 k8hJR7dE6eNaDDlGfymUUPMr31f5yFvvsgOoeMtDMNV1QJaJmU9Osw2gmQFGhtkAzZXDHj
 AtE0NfrFHfM9mOAShdwsxvkZgwe5SnQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-NvykFi2-NbG1jOnfmzoVFQ-1; Fri, 24 Jul 2020 09:25:37 -0400
X-MC-Unique: NvykFi2-NbG1jOnfmzoVFQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 57C9E8064B6;
 Fri, 24 Jul 2020 13:25:36 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.36.110.43])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D2084101E1BF;
 Fri, 24 Jul 2020 13:25:29 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 2/4] util: introduce qemu_open and qemu_create with error
 reporting
Date: Fri, 24 Jul 2020 14:25:08 +0100
Message-Id: <20200724132510.3250311-3-berrange@redhat.com>
In-Reply-To: <20200724132510.3250311-1-berrange@redhat.com>
References: <20200724132510.3250311-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 06:44:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This introduces two new helper metohds

  int qemu_open(const char *name, int flags, Error **errp);
  int qemu_create(const char *name, int flags, mode_t mode, Error **errp);

Note that with this design we no longer require or even accept the
O_CREAT flag. Avoiding overloading the two distinct operations
means we can avoid variable arguments which would prevent 'errp' from
being the last argument. It also gives us a guarantee that the 'mode' is
given when creating files, avoiding a latent security bug.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/qemu/osdep.h |  6 ++++
 util/osdep.c         | 78 ++++++++++++++++++++++++++++++++++++--------
 2 files changed, 71 insertions(+), 13 deletions(-)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 3a16e58932..ca24ebe211 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -494,7 +494,13 @@ int qemu_madvise(void *addr, size_t len, int advice);
 int qemu_mprotect_rwx(void *addr, size_t size);
 int qemu_mprotect_none(void *addr, size_t size);
 
+/*
+ * Don't introduce new usage of this function, prefer the following
+ * qemu_open/qemu_create that take a "Error **errp"
+ */
 int qemu_open_old(const char *name, int flags, ...);
+int qemu_open(const char *name, int flags, Error **errp);
+int qemu_create(const char *name, int flags, mode_t mode, Error **errp);
 int qemu_close(int fd);
 int qemu_unlink(const char *name);
 #ifndef _WIN32
diff --git a/util/osdep.c b/util/osdep.c
index 9df1b6adec..5c0f4684b1 100644
--- a/util/osdep.c
+++ b/util/osdep.c
@@ -22,6 +22,7 @@
  * THE SOFTWARE.
  */
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 
 /* Needed early for CONFIG_BSD etc. */
 
@@ -282,10 +283,10 @@ int qemu_lock_fd_test(int fd, int64_t start, int64_t len, bool exclusive)
 /*
  * Opens a file with FD_CLOEXEC set
  */
-int qemu_open_old(const char *name, int flags, ...)
+static int
+qemu_open_internal(const char *name, int flags, mode_t mode, Error **errp)
 {
     int ret;
-    int mode = 0;
 
 #ifndef _WIN32
     const char *fdset_id_str;
@@ -297,24 +298,31 @@ int qemu_open_old(const char *name, int flags, ...)
 
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
@@ -323,22 +331,66 @@ int qemu_open_old(const char *name, int flags, ...)
     }
 #endif
 
-    if (flags & O_CREAT) {
-        va_list ap;
-
-        va_start(ap, flags);
-        mode = va_arg(ap, int);
-        va_end(ap);
-    }
-
 #ifdef O_CLOEXEC
-    ret = open(name, flags | O_CLOEXEC, mode);
-#else
+    flags |= O_CLOEXEC;
+#endif /* O_CLOEXEC */
+
     ret = open(name, flags, mode);
+
+#ifndef O_CLOEXEC
     if (ret >= 0) {
         qemu_set_cloexec(ret);
     }
-#endif
+#endif /* ! O_CLOEXEC */
+
+    if (ret == -1) {
+        const char *action = "open";
+        if (flags & O_CREAT) {
+            action = "create";
+        }
+        error_setg_errno(errp, errno, "Could not %s '%s' flags 0x%x",
+                         action, name, flags);
+    }
+
+
+    return ret;
+}
+
+
+int qemu_open(const char *name, int flags, Error **errp)
+{
+    if (flags & O_CREAT) {
+        error_setg(errp,
+                   "Invalid O_CREAT flag passed to qemu_open, use qemu_create");
+        return -1;
+    }
+    return qemu_open_internal(name, flags, 0, errp);
+}
+
+
+int qemu_create(const char *name, int flags, mode_t mode, Error **errp)
+{
+    if (flags & O_CREAT) {
+        error_setg(errp, "Redundant O_CREAT flag passed to qemu_create");
+        return -1;
+    }
+    return qemu_open_internal(name, flags | O_CREAT, mode, errp);
+}
+
+
+int qemu_open_old(const char *name, int flags, ...)
+{
+    va_list ap;
+    mode_t mode = 0;
+    int ret;
+
+    va_start(ap, flags);
+    if (flags & O_CREAT) {
+        mode = va_arg(ap, int);
+    }
+    va_end(ap);
+
+    ret = qemu_open_internal(name, flags, mode, NULL);
 
 #ifdef O_DIRECT
     if (ret == -1 && errno == EINVAL && (flags & O_DIRECT)) {
-- 
2.26.2


