Return-Path: <SRS0=RqUc=6D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FED5C38A30
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Apr 2020 16:27:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBEFC206A2
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Apr 2020 16:27:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="Tir/AJZe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBEFC206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQCmx-0006XQ-1z
	for qemu-devel@archiver.kernel.org; Sun, 19 Apr 2020 12:27:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42128 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fdb0e29a86d1df6005021a08078d7e69ed0de1a2@lizzy.crudebyte.com>)
 id 1jQCmK-0005mA-1w
 for qemu-devel@nongnu.org; Sun, 19 Apr 2020 12:26:44 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <fdb0e29a86d1df6005021a08078d7e69ed0de1a2@lizzy.crudebyte.com>)
 id 1jQCmJ-00063z-Ax
 for qemu-devel@nongnu.org; Sun, 19 Apr 2020 12:26:43 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:41361)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <fdb0e29a86d1df6005021a08078d7e69ed0de1a2@lizzy.crudebyte.com>)
 id 1jQCmI-0004j9-RE
 for qemu-devel@nongnu.org; Sun, 19 Apr 2020 12:26:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=Exi2eVU0aC9WtbkX7/D0N5Fl28ExllAxepKnldAijZ4=; b=Tir/A
 JZeE15PgLCj9TJ9cnqGNbRPqWNEfyzo5o0uidD98GZ9XjSiEP5eUOfX44gG+4byZVQOD2C+pG0Lg8
 d+gN4MyPKhH9C9/CNn2J9rnfRFtKGWUTX3U7OWCRclXP3Lyc7/2F44pcHO2VCBCiHQJNTW9pFNMPq
 SagxeWPFJrsJY7AzLktP5/i5oiWelfmJyMYJjfYp6tbHdZrCOQYNuHDW/ySKnsHwGs6u3Z6LDguuo
 srGNPmqn3Hl5fQGNi/pgGCw8im2Nt8P2gATRLN+J6wtrOJLYOMS5fIajCuk4ZDzX4HdA9/DKseevj
 W+MrY5syL4L3Soq9i/iuiTn77fxvw==;
Message-Id: <fdb0e29a86d1df6005021a08078d7e69ed0de1a2.1587309014.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1587309014.git.qemu_oss@crudebyte.com>
References: <cover.1587309014.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Sun, 19 Apr 2020 17:02:27 +0200
Subject: [PATCH v6 3/5] 9pfs: add new function v9fs_co_readdir_many()
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
Received-SPF: none client-ip=91.194.90.13;
 envelope-from=fdb0e29a86d1df6005021a08078d7e69ed0de1a2@lizzy.crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs1p.gnu.org: Linux 3.11 and newer
X-Received-From: 91.194.90.13
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

The newly added function v9fs_co_readdir_many() retrieves multiple
directory entries with a single fs driver request. It is intended to
replace uses of v9fs_co_readdir(), the latter only retrives a single
directory entry per fs driver request instead.

The reason for this planned replacement is that for every fs driver
request the coroutine is dispatched from main I/O thread to a
background I/O thread and eventually dispatched back to main I/O
thread. Hopping between threads adds latency. So if a 9pfs Treaddir
request reads a large amount of directory entries, this currently
sums up to huge latencies of several hundred ms or even more. So
using v9fs_co_readdir_many() instead of v9fs_co_readdir() will
provide significant performance improvements.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 hw/9pfs/9p.h    |  22 ++++++
 hw/9pfs/codir.c | 181 +++++++++++++++++++++++++++++++++++++++++++++---
 hw/9pfs/coth.h  |   3 +
 3 files changed, 195 insertions(+), 11 deletions(-)

diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
index 9553700dbb..116977939b 100644
--- a/hw/9pfs/9p.h
+++ b/hw/9pfs/9p.h
@@ -215,6 +215,28 @@ static inline void v9fs_readdir_init(V9fsDir *dir)
     qemu_mutex_init(&dir->readdir_mutex);
 }
 
+/**
+ * Type for 9p fs drivers' (a.k.a. 9p backends) result of readdir requests,
+ * which is a chained list of directory entries.
+ */
+typedef struct V9fsDirEnt {
+    /* mandatory (must not be NULL) information for all readdir requests */
+    struct dirent *dent;
+    /*
+     * optional (may be NULL): A full stat of each directory entry is just
+     * done if explicitly told to fs driver.
+     */
+    struct stat *st;
+    /*
+     * instead of an array, directory entries are always returned as
+     * chained list, that's because the amount of entries retrieved by fs
+     * drivers is dependent on the individual entries' name (since response
+     * messages are size limited), so the final amount cannot be estimated
+     * before hand
+     */
+    struct V9fsDirEnt *next;
+} V9fsDirEnt;
+
 /*
  * Filled by fs driver on open and other
  * calls.
diff --git a/hw/9pfs/codir.c b/hw/9pfs/codir.c
index 73f9a751e1..45c65a8f5b 100644
--- a/hw/9pfs/codir.c
+++ b/hw/9pfs/codir.c
@@ -18,28 +18,187 @@
 #include "qemu/main-loop.h"
 #include "coth.h"
 
+/*
+ * This is solely executed on a background IO thread.
+ */
+static int do_readdir(V9fsPDU *pdu, V9fsFidState *fidp, struct dirent **dent)
+{
+    int err = 0;
+    V9fsState *s = pdu->s;
+    struct dirent *entry;
+
+    errno = 0;
+    entry = s->ops->readdir(&s->ctx, &fidp->fs);
+    if (!entry && errno) {
+        *dent = NULL;
+        err = -errno;
+    } else {
+        *dent = entry;
+    }
+    return err;
+}
+
+/*
+ * TODO: This will be removed for performance reasons.
+ * Use v9fs_co_readdir_many() instead.
+ */
 int coroutine_fn v9fs_co_readdir(V9fsPDU *pdu, V9fsFidState *fidp,
                                  struct dirent **dent)
 {
     int err;
-    V9fsState *s = pdu->s;
 
     if (v9fs_request_cancelled(pdu)) {
         return -EINTR;
     }
-    v9fs_co_run_in_worker(
-        {
-            struct dirent *entry;
+    v9fs_co_run_in_worker({
+        err = do_readdir(pdu, fidp, dent);
+    });
+    return err;
+}
+
+/*
+ * This is solely executed on a background IO thread.
+ *
+ * See v9fs_co_readdir_many() (as its only user) below for details.
+ */
+static int do_readdir_many(V9fsPDU *pdu, V9fsFidState *fidp,
+                             struct V9fsDirEnt **entries,
+                             int32_t maxsize, bool dostat)
+{
+    V9fsState *s = pdu->s;
+    V9fsString name;
+    int len, err = 0;
+    int32_t size = 0;
+    off_t saved_dir_pos;
+    struct dirent *dent;
+    struct V9fsDirEnt *e = NULL;
+    V9fsPath path;
+    struct stat stbuf;
 
-            errno = 0;
-            entry = s->ops->readdir(&s->ctx, &fidp->fs);
-            if (!entry && errno) {
+    *entries = NULL;
+    v9fs_path_init(&path);
+
+    /*
+     * TODO: Here should be a warn_report_once() if lock failed.
+     *
+     * With a good 9p client we should not get into concurrency here,
+     * because a good client would not use the same fid for concurrent
+     * requests. We do the lock here for safety reasons though. However
+     * the client would then suffer performance issues, so better log that
+     * issue here.
+     */
+    v9fs_readdir_lock(&fidp->fs.dir);
+
+    /* save the directory position */
+    saved_dir_pos = s->ops->telldir(&s->ctx, &fidp->fs);
+    if (saved_dir_pos < 0) {
+        err = saved_dir_pos;
+        goto out;
+    }
+
+    while (true) {
+        /* get directory entry from fs driver */
+        err = do_readdir(pdu, fidp, &dent);
+        if (err || !dent) {
+            break;
+        }
+
+        /*
+         * stop this loop as soon as it would exceed the allowed maximum
+         * response message size for the directory entries collected so far,
+         * because anything beyond that size would need to be discarded by
+         * 9p controller (main thread / top half) anyway
+         */
+        v9fs_string_init(&name);
+        v9fs_string_sprintf(&name, "%s", dent->d_name);
+        len = v9fs_readdir_response_size(&name);
+        v9fs_string_free(&name);
+        if (size + len > maxsize) {
+            /* this is not an error case actually */
+            break;
+        }
+
+        /* append next node to result chain */
+        if (!e) {
+            *entries = e = g_malloc0(sizeof(V9fsDirEnt));
+        } else {
+            e = e->next = g_malloc0(sizeof(V9fsDirEnt));
+        }
+        e->dent = g_malloc0(sizeof(struct dirent));
+        memcpy(e->dent, dent, sizeof(struct dirent));
+
+        /* perform a full stat() for directory entry if requested by caller */
+        if (dostat) {
+            err = s->ops->name_to_path(
+                &s->ctx, &fidp->path, dent->d_name, &path
+            );
+            if (err < 0) {
                 err = -errno;
-            } else {
-                *dent = entry;
-                err = 0;
+                break;
             }
-        });
+
+            err = s->ops->lstat(&s->ctx, &path, &stbuf);
+            if (err < 0) {
+                err = -errno;
+                break;
+            }
+
+            e->st = g_malloc0(sizeof(struct stat));
+            memcpy(e->st, &stbuf, sizeof(struct stat));
+        }
+
+        size += len;
+        saved_dir_pos = dent->d_off;
+    }
+
+    /* restore (last) saved position */
+    s->ops->seekdir(&s->ctx, &fidp->fs, saved_dir_pos);
+
+out:
+    v9fs_readdir_unlock(&fidp->fs.dir);
+    v9fs_path_free(&path);
+    if (err < 0) {
+        return err;
+    }
+    return size;
+}
+
+/**
+ * @brief Reads multiple directory entries in one rush.
+ *
+ * Retrieves the requested (max. amount of) directory entries from the fs
+ * driver. This function must only be called by the main IO thread (top half).
+ * Internally this function call will be dispatched to a background IO thread
+ * (bottom half) where it is eventually executed by the fs driver.
+ *
+ * Acquiring multiple directory entries in one rush from the fs driver,
+ * instead of retrieving each directory entry individually, is very beneficial
+ * from performance point of view. Because for every fs driver request latency
+ * is added, which in practice could lead to overall latencies of several
+ * hundred ms for reading all entries (of just a single directory) if every
+ * directory entry was individually requested from driver.
+ *
+ * @param pdu - the causing 9p (T_readdir) client request
+ * @param fidp - already opened directory where readdir shall be performed on
+ * @param entries - output for directory entries (must not be NULL)
+ * @param maxsize - maximum result message body size (in bytes)
+ * @param dostat - whether a stat() should be performed and returned for
+ *                 each directory entry
+ * @returns resulting response message body size (in bytes) on success,
+ *          negative error code otherwise
+ */
+int coroutine_fn v9fs_co_readdir_many(V9fsPDU *pdu, V9fsFidState *fidp,
+                                      struct V9fsDirEnt **entries,
+                                      int32_t maxsize, bool dostat)
+{
+    int err = 0;
+
+    if (v9fs_request_cancelled(pdu)) {
+        return -EINTR;
+    }
+    v9fs_co_run_in_worker({
+        err = do_readdir_many(pdu, fidp, entries, maxsize, dostat);
+    });
     return err;
 }
 
diff --git a/hw/9pfs/coth.h b/hw/9pfs/coth.h
index c2cdc7a9ea..a6851822d5 100644
--- a/hw/9pfs/coth.h
+++ b/hw/9pfs/coth.h
@@ -49,6 +49,9 @@
 void co_run_in_worker_bh(void *);
 int coroutine_fn v9fs_co_readlink(V9fsPDU *, V9fsPath *, V9fsString *);
 int coroutine_fn v9fs_co_readdir(V9fsPDU *, V9fsFidState *, struct dirent **);
+int coroutine_fn v9fs_co_readdir_many(V9fsPDU *, V9fsFidState *,
+                                      struct V9fsDirEnt **,
+                                      int32_t, bool);
 off_t coroutine_fn v9fs_co_telldir(V9fsPDU *, V9fsFidState *);
 void coroutine_fn v9fs_co_seekdir(V9fsPDU *, V9fsFidState *, off_t);
 void coroutine_fn v9fs_co_rewinddir(V9fsPDU *, V9fsFidState *);
-- 
2.20.1


