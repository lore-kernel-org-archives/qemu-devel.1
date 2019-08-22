Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1823C3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 22:01:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BD2121655
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 22:01:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="eBe97Q0Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BD2121655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0v8t-0007cY-7X
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 18:01:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43204)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <5415baa3955c354d9f1e6aab39270ab2abca662a@lizzy.crudebyte.com>)
 id 1i0v6x-0006sf-Db
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 17:59:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <5415baa3955c354d9f1e6aab39270ab2abca662a@lizzy.crudebyte.com>)
 id 1i0v6v-0006xo-TS
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 17:59:15 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:46489)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71)
 (envelope-from <5415baa3955c354d9f1e6aab39270ab2abca662a@lizzy.crudebyte.com>)
 id 1i0v6v-0006ay-Mz
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 17:59:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Subject:Date:Cc:To:From:References:In-Reply-To:
 Message-Id:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ATo9ZxD30LpwfiShVhASAlgxgIkm/nBKSWUfpzx5kYM=; b=eBe97Q0QXsj2cq1LNaAo0KPdh
 4rLwOdBM+BK9Ao3ZRYJCQNQUYG7XBo+QmH9nsTH4kKqurHIQ0lTuLqDnLWFng9QjowBsygMoxQPfN
 YttwewU6jwE10vlyaKWCPW6lNcYU7EzAJUbSW0pa87UnwWoAP1NvEltHlWBwczG9P10g/D3U6zjxs
 S+i8AeYv50/4C0RIa/MJUc9Q9YQuhw56dmWJXMCjpZWD+Ciu8qwjBqVeKbgVWrlZMAQtdJZXU6Z7U
 WaYrgyKgCj3Qq9175134gl3DKbOVIiaRvFWiyYwLL0VBv6mkQ1zn7Ok8oLFhnmDZ0J5U2QyXB7k0S
 Pv0+yeS0Q==;
Message-Id: <5415baa3955c354d9f1e6aab39270ab2abca662a.1566503584.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1566503584.git.qemu_oss@crudebyte.com>
References: <cover.1566503584.git.qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Date: Thu, 22 Aug 2019 21:28:19 +0200
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.194.90.13
Subject: [Qemu-devel] [PATCH v6 1/4] 9p: Treat multiple devices on one
 export as an error
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
From: Christian Schoenebeck via Qemu-devel <qemu-devel@nongnu.org>
Reply-To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Greg Kurz <groug@kaod.org>, Antonios Motakis <antonios.motakis@huawei.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The QID path should uniquely identify a file. However, the
inode of a file is currently used as the QID path, which
on its own only uniquely identifies files within a device.
Here we track the device hosting the 9pfs share, in order
to prevent security issues with QID path collisions from
other devices.

Signed-off-by: Antonios Motakis <antonios.motakis@huawei.com>
[CS: - Assign dev_id to export root's device already in
       v9fs_device_realize_common(), not postponed in
       stat_to_qid().
     - error_report_once() if more than one device was
       shared by export.
     - Return -ENODEV instead of -ENOSYS in stat_to_qid().
     - Fixed typo in log comment. ]
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 hw/9pfs/9p.c | 69 ++++++++++++++++++++++++++++++++++++++++++++++++------------
 hw/9pfs/9p.h |  1 +
 2 files changed, 56 insertions(+), 14 deletions(-)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 586a6dccba..8cc65c2c67 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -572,10 +572,18 @@ static void coroutine_fn virtfs_reset(V9fsPDU *pdu)
                                 P9_STAT_MODE_SOCKET)
 
 /* This is the algorithm from ufs in spfs */
-static void stat_to_qid(const struct stat *stbuf, V9fsQID *qidp)
+static int stat_to_qid(V9fsPDU *pdu, const struct stat *stbuf, V9fsQID *qidp)
 {
     size_t size;
 
+    if (pdu->s->dev_id != stbuf->st_dev) {
+        error_report_once(
+            "9p: Multiple devices detected in same VirtFS export. "
+            "You must use a separate export for each device."
+        );
+        return -ENODEV;
+    }
+
     memset(&qidp->path, 0, sizeof(qidp->path));
     size = MIN(sizeof(stbuf->st_ino), sizeof(qidp->path));
     memcpy(&qidp->path, &stbuf->st_ino, size);
@@ -587,6 +595,8 @@ static void stat_to_qid(const struct stat *stbuf, V9fsQID *qidp)
     if (S_ISLNK(stbuf->st_mode)) {
         qidp->type |= P9_QID_TYPE_SYMLINK;
     }
+
+    return 0;
 }
 
 static int coroutine_fn fid_to_qid(V9fsPDU *pdu, V9fsFidState *fidp,
@@ -599,7 +609,10 @@ static int coroutine_fn fid_to_qid(V9fsPDU *pdu, V9fsFidState *fidp,
     if (err < 0) {
         return err;
     }
-    stat_to_qid(&stbuf, qidp);
+    err = stat_to_qid(pdu, &stbuf, qidp);
+    if (err < 0) {
+        return err;
+    }
     return 0;
 }
 
@@ -830,7 +843,10 @@ static int coroutine_fn stat_to_v9stat(V9fsPDU *pdu, V9fsPath *path,
 
     memset(v9stat, 0, sizeof(*v9stat));
 
-    stat_to_qid(stbuf, &v9stat->qid);
+    err = stat_to_qid(pdu, stbuf, &v9stat->qid);
+    if (err < 0) {
+        return err;
+    }
     v9stat->mode = stat_to_v9mode(stbuf);
     v9stat->atime = stbuf->st_atime;
     v9stat->mtime = stbuf->st_mtime;
@@ -891,7 +907,7 @@ static int coroutine_fn stat_to_v9stat(V9fsPDU *pdu, V9fsPath *path,
 #define P9_STATS_ALL           0x00003fffULL /* Mask for All fields above */
 
 
-static void stat_to_v9stat_dotl(V9fsState *s, const struct stat *stbuf,
+static int stat_to_v9stat_dotl(V9fsPDU *pdu, const struct stat *stbuf,
                                 V9fsStatDotl *v9lstat)
 {
     memset(v9lstat, 0, sizeof(*v9lstat));
@@ -913,7 +929,7 @@ static void stat_to_v9stat_dotl(V9fsState *s, const struct stat *stbuf,
     /* Currently we only support BASIC fields in stat */
     v9lstat->st_result_mask = P9_STATS_BASIC;
 
-    stat_to_qid(stbuf, &v9lstat->qid);
+    return stat_to_qid(pdu, stbuf, &v9lstat->qid);
 }
 
 static void print_sg(struct iovec *sg, int cnt)
@@ -1115,7 +1131,6 @@ static void coroutine_fn v9fs_getattr(void *opaque)
     uint64_t request_mask;
     V9fsStatDotl v9stat_dotl;
     V9fsPDU *pdu = opaque;
-    V9fsState *s = pdu->s;
 
     retval = pdu_unmarshal(pdu, offset, "dq", &fid, &request_mask);
     if (retval < 0) {
@@ -1136,7 +1151,10 @@ static void coroutine_fn v9fs_getattr(void *opaque)
     if (retval < 0) {
         goto out;
     }
-    stat_to_v9stat_dotl(s, &stbuf, &v9stat_dotl);
+    retval = stat_to_v9stat_dotl(pdu, &stbuf, &v9stat_dotl);
+    if (retval < 0) {
+        goto out;
+    }
 
     /*  fill st_gen if requested and supported by underlying fs */
     if (request_mask & P9_STATS_GEN) {
@@ -1381,7 +1399,10 @@ static void coroutine_fn v9fs_walk(void *opaque)
             if (err < 0) {
                 goto out;
             }
-            stat_to_qid(&stbuf, &qid);
+            err = stat_to_qid(pdu, &stbuf, &qid);
+            if (err < 0) {
+                goto out;
+            }
             v9fs_path_copy(&dpath, &path);
         }
         memcpy(&qids[name_idx], &qid, sizeof(qid));
@@ -1483,7 +1504,10 @@ static void coroutine_fn v9fs_open(void *opaque)
     if (err < 0) {
         goto out;
     }
-    stat_to_qid(&stbuf, &qid);
+    err = stat_to_qid(pdu, &stbuf, &qid);
+    if (err < 0) {
+        goto out;
+    }
     if (S_ISDIR(stbuf.st_mode)) {
         err = v9fs_co_opendir(pdu, fidp);
         if (err < 0) {
@@ -1593,7 +1617,10 @@ static void coroutine_fn v9fs_lcreate(void *opaque)
         fidp->flags |= FID_NON_RECLAIMABLE;
     }
     iounit =  get_iounit(pdu, &fidp->path);
-    stat_to_qid(&stbuf, &qid);
+    err = stat_to_qid(pdu, &stbuf, &qid);
+    if (err < 0) {
+        goto out;
+    }
     err = pdu_marshal(pdu, offset, "Qd", &qid, iounit);
     if (err < 0) {
         goto out;
@@ -2327,7 +2354,10 @@ static void coroutine_fn v9fs_create(void *opaque)
         }
     }
     iounit = get_iounit(pdu, &fidp->path);
-    stat_to_qid(&stbuf, &qid);
+    err = stat_to_qid(pdu, &stbuf, &qid);
+    if (err < 0) {
+        goto out;
+    }
     err = pdu_marshal(pdu, offset, "Qd", &qid, iounit);
     if (err < 0) {
         goto out;
@@ -2384,7 +2414,10 @@ static void coroutine_fn v9fs_symlink(void *opaque)
     if (err < 0) {
         goto out;
     }
-    stat_to_qid(&stbuf, &qid);
+    err = stat_to_qid(pdu, &stbuf, &qid);
+    if (err < 0) {
+        goto out;
+    }
     err =  pdu_marshal(pdu, offset, "Q", &qid);
     if (err < 0) {
         goto out;
@@ -3064,7 +3097,10 @@ static void coroutine_fn v9fs_mknod(void *opaque)
     if (err < 0) {
         goto out;
     }
-    stat_to_qid(&stbuf, &qid);
+    err = stat_to_qid(pdu, &stbuf, &qid);
+    if (err < 0) {
+        goto out;
+    }
     err = pdu_marshal(pdu, offset, "Q", &qid);
     if (err < 0) {
         goto out;
@@ -3222,7 +3258,10 @@ static void coroutine_fn v9fs_mkdir(void *opaque)
     if (err < 0) {
         goto out;
     }
-    stat_to_qid(&stbuf, &qid);
+    err = stat_to_qid(pdu, &stbuf, &qid);
+    if (err < 0) {
+        goto out;
+    }
     err = pdu_marshal(pdu, offset, "Q", &qid);
     if (err < 0) {
         goto out;
@@ -3633,6 +3672,8 @@ int v9fs_device_realize_common(V9fsState *s, const V9fsTransport *t,
         goto out;
     }
 
+    s->dev_id = stat.st_dev;
+
     s->ctx.fst = &fse->fst;
     fsdev_throttle_init(s->ctx.fst);
 
diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
index 8883761b2c..5e316178d5 100644
--- a/hw/9pfs/9p.h
+++ b/hw/9pfs/9p.h
@@ -256,6 +256,7 @@ struct V9fsState
     Error *migration_blocker;
     V9fsConf fsconf;
     V9fsQID root_qid;
+    dev_t dev_id;
 };
 
 /* 9p2000.L open flags */
-- 
2.11.0


