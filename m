Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EDE6C2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 04:02:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90B6F206F7
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 04:02:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jL2nIjO5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90B6F206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kasxD-0003Yd-Iu
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 23:02:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52934)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <msys.mizuma@gmail.com>)
 id 1kaswA-0002Ga-8s
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 23:01:18 -0500
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744]:41993)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <msys.mizuma@gmail.com>)
 id 1kasw8-0007wW-8c
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 23:01:17 -0500
Received: by mail-qk1-x744.google.com with SMTP id b18so29546qkc.9
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 20:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=dN49RDrUvHwzDJ64CxwS9xQyMDw5g3qF6XQbqCTinsY=;
 b=jL2nIjO5hVcWoFolqkzlXg4WBxrqkIQbTNqC0F9II+/jJ9Z+q6S9SZGo8hSJQmd9xg
 oAh2LT09ecukCo9OCoLF2jhg6UqZSdUl6goaMmJhYACCOfy4Gp+PVoVQ+wtFO/Gz0eO0
 QjBWrB6nY1//TrUP2ejfG2X/cx46xvYLVgIxG3YtJhFmACkwJN76MsEXDInQP4nbH3iP
 Yyc6J2ufmkdaUmf/f78+b2M0C4mI6TvFakSRoSXhyLnZPQElS2GnAj/S8veD5ExvqsMb
 0DzhQ1P9sS97ehM4DRo4d+tnJ9Z077q1u8pGV71y4Ap1sX0UhT+p5b6xe8xof649IlnO
 /pFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=dN49RDrUvHwzDJ64CxwS9xQyMDw5g3qF6XQbqCTinsY=;
 b=OfpqamCT65U2ify1fIfqc49AdRZ7P10xkD+GBlnX8Y3KGd9tQbOGAqJLc8z/d9AnN7
 pWqeQunDObW3w5zG2t2hv98+zs9ZAqWb7ekPnibcIlLayY+dykKgtJarm+Oknyd0N3Ch
 PFc90PeP3GuQRO0ZTiSeLY6YbHsciabga84GleSTQVJMiUrzOEORgm24xVI/nuT6JjiY
 DPlX8/vZB71DuFgRd801ZfT9WQ7IZt8uJx5BDV6iD51z0b/FRjJLcYRVSC6daaIHvSfu
 /mShqPt8A94zOhSruV4HA5zkiM8G1wdvrJ3CTJP1J7jZWatMwR7Tc49ne7npsebuzfo5
 sVRQ==
X-Gm-Message-State: AOAM5325EEKY2Qx/kvi26bGtSIZyauABUiKr0nId++mxwcOKBz/iOjep
 cx/T8Stb16zMUMc/+NwkqrC//dJCsQ==
X-Google-Smtp-Source: ABdhPJwXw7gKcTstkoyRL6GZcmfslMuQmjk5sHkNuEJQGO8qaGtceJ9CvOcm+7hTdJYrdBHmf1IyWA==
X-Received: by 2002:a05:620a:20d8:: with SMTP id
 f24mr5162466qka.69.1604635274039; 
 Thu, 05 Nov 2020 20:01:14 -0800 (PST)
Received: from localhost
 (209-6-122-159.s2973.c3-0.arl-cbr1.sbo-arl.ma.cable.rcncustomer.com.
 [209.6.122.159])
 by smtp.gmail.com with ESMTPSA id q28sm6640qkn.39.2020.11.05.20.01.13
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 05 Nov 2020 20:01:13 -0800 (PST)
From: Masayoshi Mizuma <msys.mizuma@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] file-posix: Use OFD lock only if the filesystem supports
 the lock
Date: Thu,  5 Nov 2020 23:01:01 -0500
Message-Id: <20201106040102.13892-1-msys.mizuma@gmail.com>
X-Mailer: git-send-email 2.17.1
Received-SPF: pass client-ip=2607:f8b0:4864:20::744;
 envelope-from=msys.mizuma@gmail.com; helo=mail-qk1-x744.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
 Masayoshi Mizuma <msys.mizuma@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

locking=auto doesn't work if the filesystem doesn't support OFD lock.
In that situation, following error happens:

  qemu-system-x86_64: -blockdev driver=qcow2,node-name=disk,file.driver=file,file.filename=/mnt/guest.qcow2,file.locking=auto: Failed to lock byte 100

qemu_probe_lock_ops() judges whether qemu can use OFD lock
or not with doing fcntl(F_OFD_GETLK) to /dev/null. So the
error happens if /dev/null supports OFD lock, but the filesystem
doesn't support the lock.

Lock the actual file, not /dev/null, using F_OFD_SETLK and if that
fails, then fallback to F_SETLK.

Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
---
 block/file-posix.c   |  56 ++++++++--------
 include/qemu/osdep.h |   2 +-
 util/osdep.c         | 149 ++++++++++++++++++++++++++++---------------
 3 files changed, 125 insertions(+), 82 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index c63926d592..a568dbf125 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -584,34 +584,6 @@ static int raw_open_common(BlockDriverState *bs, QDict *options,
     s->use_linux_io_uring = (aio == BLOCKDEV_AIO_OPTIONS_IO_URING);
 #endif
 
-    locking = qapi_enum_parse(&OnOffAuto_lookup,
-                              qemu_opt_get(opts, "locking"),
-                              ON_OFF_AUTO_AUTO, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        ret = -EINVAL;
-        goto fail;
-    }
-    switch (locking) {
-    case ON_OFF_AUTO_ON:
-        s->use_lock = true;
-        if (!qemu_has_ofd_lock()) {
-            warn_report("File lock requested but OFD locking syscall is "
-                        "unavailable, falling back to POSIX file locks");
-            error_printf("Due to the implementation, locks can be lost "
-                         "unexpectedly.\n");
-        }
-        break;
-    case ON_OFF_AUTO_OFF:
-        s->use_lock = false;
-        break;
-    case ON_OFF_AUTO_AUTO:
-        s->use_lock = qemu_has_ofd_lock();
-        break;
-    default:
-        abort();
-    }
-
     str = qemu_opt_get(opts, "pr-manager");
     if (str) {
         s->pr_mgr = pr_manager_lookup(str, &local_err);
@@ -641,6 +613,34 @@ static int raw_open_common(BlockDriverState *bs, QDict *options,
     }
     s->fd = fd;
 
+    locking = qapi_enum_parse(&OnOffAuto_lookup,
+                              qemu_opt_get(opts, "locking"),
+                              ON_OFF_AUTO_AUTO, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        ret = -EINVAL;
+        goto fail;
+    }
+    switch (locking) {
+    case ON_OFF_AUTO_ON:
+        s->use_lock = true;
+        if (!qemu_has_ofd_lock(s->fd)) {
+            warn_report("File lock requested but OFD locking syscall is "
+                        "unavailable, falling back to POSIX file locks");
+            error_printf("Due to the implementation, locks can be lost "
+                         "unexpectedly.\n");
+        }
+        break;
+    case ON_OFF_AUTO_OFF:
+        s->use_lock = false;
+        break;
+    case ON_OFF_AUTO_AUTO:
+        s->use_lock = qemu_has_ofd_lock(s->fd);
+        break;
+    default:
+        abort();
+    }
+
     /* Check s->open_flags rather than bdrv_flags due to auto-read-only */
     if (s->open_flags & O_RDWR) {
         ret = check_hdev_writable(s->fd);
diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index f9ec8c84e9..222138a81a 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -512,7 +512,7 @@ int qemu_dup(int fd);
 int qemu_lock_fd(int fd, int64_t start, int64_t len, bool exclusive);
 int qemu_unlock_fd(int fd, int64_t start, int64_t len);
 int qemu_lock_fd_test(int fd, int64_t start, int64_t len, bool exclusive);
-bool qemu_has_ofd_lock(void);
+bool qemu_has_ofd_lock(int orig_fd);
 #endif
 
 #if defined(__HAIKU__) && defined(__i386__)
diff --git a/util/osdep.c b/util/osdep.c
index 66d01b9160..454e8ef9f4 100644
--- a/util/osdep.c
+++ b/util/osdep.c
@@ -117,9 +117,6 @@ int qemu_mprotect_none(void *addr, size_t size)
 
 #ifndef _WIN32
 
-static int fcntl_op_setlk = -1;
-static int fcntl_op_getlk = -1;
-
 /*
  * Dups an fd and sets the flags
  */
@@ -187,68 +184,87 @@ static int qemu_parse_fdset(const char *param)
     return qemu_parse_fd(param);
 }
 
-static void qemu_probe_lock_ops(void)
+bool qemu_has_ofd_lock(int orig_fd)
 {
-    if (fcntl_op_setlk == -1) {
 #ifdef F_OFD_SETLK
-        int fd;
-        int ret;
-        struct flock fl = {
-            .l_whence = SEEK_SET,
-            .l_start  = 0,
-            .l_len    = 0,
-            .l_type   = F_WRLCK,
-        };
-
-        fd = open("/dev/null", O_RDWR);
-        if (fd < 0) {
+    int fd;
+    int ret;
+    struct flock fl = {
+        .l_whence = SEEK_SET,
+        .l_start  = 0,
+        .l_len    = 0,
+        .l_type   = F_RDLCK,
+    };
+
+    fd = qemu_dup(orig_fd);
+    if (fd >= 0) {
+        ret = fcntl_setfl(fd, O_RDONLY);
+        if (ret) {
             fprintf(stderr,
-                    "Failed to open /dev/null for OFD lock probing: %s\n",
-                    strerror(errno));
-            fcntl_op_setlk = F_SETLK;
-            fcntl_op_getlk = F_GETLK;
-            return;
-        }
-        ret = fcntl(fd, F_OFD_GETLK, &fl);
-        close(fd);
-        if (!ret) {
-            fcntl_op_setlk = F_OFD_SETLK;
-            fcntl_op_getlk = F_OFD_GETLK;
-        } else {
-            fcntl_op_setlk = F_SETLK;
-            fcntl_op_getlk = F_GETLK;
+                    "Failed to fcntl for OFD lock probing.\n");
+            qemu_close(fd);
+            return false;
         }
+    }
+
+    ret = fcntl(fd, F_OFD_GETLK, &fl);
+    qemu_close(fd);
+
+    if (ret == 0) {
+        return true;
+    } else {
+        return false;
+    }
 #else
-        fcntl_op_setlk = F_SETLK;
-        fcntl_op_getlk = F_GETLK;
+    return false;
 #endif
-    }
 }
 
-bool qemu_has_ofd_lock(void)
-{
-    qemu_probe_lock_ops();
 #ifdef F_OFD_SETLK
-    return fcntl_op_setlk == F_OFD_SETLK;
+static int _qemu_lock_fcntl(int fd, struct flock *fl)
+{
+    int ret;
+    bool ofd_lock = true;
+
+    do {
+        if (ofd_lock) {
+            ret = fcntl(fd, F_OFD_SETLK, fl);
+            if ((ret == -1) && (errno == EINVAL)) {
+                ofd_lock = false;
+            }
+        }
+
+        if (!ofd_lock) {
+            /* Fallback to POSIX lock */
+            ret = fcntl(fd, F_SETLK, fl);
+        }
+    } while (ret == -1 && errno == EINTR);
+
+    return ret == -1 ? -errno : 0;
+}
 #else
-    return false;
-#endif
+static int _qemu_lock_fcntl(int fd, struct flock *fl)
+{
+    int ret;
+
+    do {
+        ret = fcntl(fd, F_SETLK, fl);
+    } while (ret == -1 && errno == EINTR);
+
+    return ret == -1 ? -errno : 0;
 }
+#endif
 
 static int qemu_lock_fcntl(int fd, int64_t start, int64_t len, int fl_type)
 {
-    int ret;
     struct flock fl = {
         .l_whence = SEEK_SET,
         .l_start  = start,
         .l_len    = len,
         .l_type   = fl_type,
     };
-    qemu_probe_lock_ops();
-    do {
-        ret = fcntl(fd, fcntl_op_setlk, &fl);
-    } while (ret == -1 && errno == EINTR);
-    return ret == -1 ? -errno : 0;
+
+    return _qemu_lock_fcntl(fd, &fl);
 }
 
 int qemu_lock_fd(int fd, int64_t start, int64_t len, bool exclusive)
@@ -261,22 +277,49 @@ int qemu_unlock_fd(int fd, int64_t start, int64_t len)
     return qemu_lock_fcntl(fd, start, len, F_UNLCK);
 }
 
-int qemu_lock_fd_test(int fd, int64_t start, int64_t len, bool exclusive)
+#ifdef F_OFD_SETLK
+static int _qemu_lock_fd_test(int fd, struct flock *fl)
 {
     int ret;
+
+    ret = fcntl(fd, F_OFD_GETLK, fl);
+    if ((ret == -1) && (errno != EINVAL)) {
+        return -errno;
+
+    } else if ((ret == -1) && (errno == EINVAL)) {
+        /* Fallback to POSIX lock */
+        ret = fcntl(fd, F_GETLK, fl);
+        if (ret == -1) {
+            return -errno;
+        }
+    }
+
+    return fl->l_type == F_UNLCK ? 0 : -EAGAIN;
+}
+#else
+static int _qemu_lock_fd_test(int fd, struct flock *fl)
+{
+    int ret;
+
+    ret = fcntl(fd, F_GETLK, fl);
+    if (ret == -1) {
+        return -errno;
+    } else {
+        return fl->l_type == F_UNLCK ? 0 : -EAGAIN;
+    }
+}
+#endif
+
+int qemu_lock_fd_test(int fd, int64_t start, int64_t len, bool exclusive)
+{
     struct flock fl = {
         .l_whence = SEEK_SET,
         .l_start  = start,
         .l_len    = len,
         .l_type   = exclusive ? F_WRLCK : F_RDLCK,
     };
-    qemu_probe_lock_ops();
-    ret = fcntl(fd, fcntl_op_getlk, &fl);
-    if (ret == -1) {
-        return -errno;
-    } else {
-        return fl.l_type == F_UNLCK ? 0 : -EAGAIN;
-    }
+
+    return _qemu_lock_fd_test(fd, &fl);
 }
 #endif
 
-- 
2.27.0


