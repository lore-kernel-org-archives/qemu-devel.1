Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8DBDC4724C
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 16:04:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A74720775
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 16:04:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A74720775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUBgA-00032h-LE
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 12:04:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44824)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1jUBX6-0007q8-De
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 11:58:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1jUBVS-0005Os-Ki
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 11:55:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42390)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jUBVS-0005Ob-2o
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 11:53:46 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 03UFX4oR108730; Thu, 30 Apr 2020 11:53:40 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.108])
 by mx0a-001b2d01.pphosted.com with ESMTP id 30mhqb0m9c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Apr 2020 11:53:39 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
 by ppma05fra.de.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 03UFoXYE030153;
 Thu, 30 Apr 2020 15:53:37 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by ppma05fra.de.ibm.com with ESMTP id 30mcu52svk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Apr 2020 15:53:37 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 03UFrZAe50856132
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Apr 2020 15:53:35 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1743311C052;
 Thu, 30 Apr 2020 15:53:35 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D9BC611C050;
 Thu, 30 Apr 2020 15:53:34 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.160.63])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 30 Apr 2020 15:53:34 +0000 (GMT)
Subject: [PATCH] 9pfs: Fix potential deadlock of QEMU mainloop
From: Greg Kurz <groug@kaod.org>
To: qemu-devel@nongnu.org
Date: Thu, 30 Apr 2020 17:53:34 +0200
Message-ID: <158826201391.1344781.9403916162733181811.stgit@bahia.lan>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-04-30_10:2020-04-30,
 2020-04-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0
 priorityscore=1501 phishscore=0 clxscore=1034 adultscore=0 suspectscore=3
 spamscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 mlxlogscore=999 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004300125
Received-SPF: softfail client-ip=148.163.156.1; envelope-from=groug@kaod.org;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 11:53:43
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Received-From: 148.163.156.1
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
Cc: Christian Schoenebeck <qemu_oss@crudebyte.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Locking was introduced to address the deprecation of readdir_r(3)
in glibc 2.24. It turns out that the frontend code is the worst
place to handle a critical section with a pthread mutex: the code
runs in a coroutine on behalf of the QEMU mainloop and then yields
control, waiting for the fsdev backend to process the request in a
worker thread. If the client resends another readdir request for the
same fid before the previous one finally unlocked the mutex, we're
deadlocked. This never bit us because the linux client serializes
readdir requests for the same fid, but the small qtest in this patch
demonstrates how easy it would be for a guest to hang QEMU.

A solution could be to use CoMutex instead of QemuMutex, but it seems
better to narrow the critical section to the worker thread code and to
return a copy of the dirent to the frontend.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p-synth.c           |   12 +++++++++++
 hw/9pfs/9p-synth.h           |    2 ++
 hw/9pfs/9p.c                 |   45 +++++++++++++-----------------------------
 hw/9pfs/codir.c              |   11 ++++++++--
 hw/9pfs/coth.h               |    3 ++-
 tests/qtest/virtio-9p-test.c |   33 +++++++++++++++++++++++++++++++
 6 files changed, 72 insertions(+), 34 deletions(-)

diff --git a/hw/9pfs/9p-synth.c b/hw/9pfs/9p-synth.c
index 7eb210ffa89b..fb0741569bcd 100644
--- a/hw/9pfs/9p-synth.c
+++ b/hw/9pfs/9p-synth.c
@@ -256,6 +256,13 @@ static struct dirent *synth_readdir(FsContext *ctx, V9fsFidOpenState *fs)
     if (entry) {
         synth_open->offset++;
     }
+
+    if (!strcmp(node->name, QTEST_V9FS_SYNTH_READDIR_DEADLOCK_DIR)) {
+        while (synth_open->offset != QTEST_V9FS_SYNTH_READDIR_DEADLOCK_OFFSET) {
+            sched_yield();
+        }
+    }
+
     return entry;
 }
 
@@ -596,6 +603,11 @@ static int synth_init(FsContext *ctx, Error **errp)
                 assert(!ret);
                 g_free(name);
             }
+
+            ret = qemu_v9fs_synth_mkdir(
+                NULL, 0700, QTEST_V9FS_SYNTH_READDIR_DEADLOCK_DIR, &dir
+            );
+            assert(!ret);
         }
     }
 
diff --git a/hw/9pfs/9p-synth.h b/hw/9pfs/9p-synth.h
index 036d7e4a5b1c..c9a65b61ed45 100644
--- a/hw/9pfs/9p-synth.h
+++ b/hw/9pfs/9p-synth.h
@@ -59,6 +59,8 @@ int qemu_v9fs_synth_add_file(V9fsSynthNode *parent, int mode,
 #define QTEST_V9FS_SYNTH_READDIR_DIR "ReadDirDir"
 #define QTEST_V9FS_SYNTH_READDIR_FILE "ReadDirFile%d"
 #define QTEST_V9FS_SYNTH_READDIR_NFILES 100
+#define QTEST_V9FS_SYNTH_READDIR_DEADLOCK_DIR "ReadDirDeadLock"
+#define QTEST_V9FS_SYNTH_READDIR_DEADLOCK_OFFSET 3
 
 /* Any write to the "FLUSH" file is handled one byte at a time by the
  * backend. If the byte is zero, the backend returns success (ie, 1),
diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 9e046f7acb51..ac84ae804496 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -2170,7 +2170,7 @@ static int coroutine_fn v9fs_do_readdir_with_stat(V9fsPDU *pdu,
     int32_t count = 0;
     struct stat stbuf;
     off_t saved_dir_pos;
-    struct dirent *dent;
+    struct dirent dent;
 
     /* save the directory position */
     saved_dir_pos = v9fs_co_telldir(pdu, fidp);
@@ -2181,13 +2181,11 @@ static int coroutine_fn v9fs_do_readdir_with_stat(V9fsPDU *pdu,
     while (1) {
         v9fs_path_init(&path);
 
-        v9fs_readdir_lock(&fidp->fs.dir);
-
         err = v9fs_co_readdir(pdu, fidp, &dent);
-        if (err || !dent) {
+        if (err <= 0) {
             break;
         }
-        err = v9fs_co_name_to_path(pdu, &fidp->path, dent->d_name, &path);
+        err = v9fs_co_name_to_path(pdu, &fidp->path, dent.d_name, &path);
         if (err < 0) {
             break;
         }
@@ -2195,13 +2193,11 @@ static int coroutine_fn v9fs_do_readdir_with_stat(V9fsPDU *pdu,
         if (err < 0) {
             break;
         }
-        err = stat_to_v9stat(pdu, &path, dent->d_name, &stbuf, &v9stat);
+        err = stat_to_v9stat(pdu, &path, dent.d_name, &stbuf, &v9stat);
         if (err < 0) {
             break;
         }
         if ((count + v9stat.size + 2) > max_count) {
-            v9fs_readdir_unlock(&fidp->fs.dir);
-
             /* Ran out of buffer. Set dir back to old position and return */
             v9fs_co_seekdir(pdu, fidp, saved_dir_pos);
             v9fs_stat_free(&v9stat);
@@ -2212,8 +2208,6 @@ static int coroutine_fn v9fs_do_readdir_with_stat(V9fsPDU *pdu,
         /* 11 = 7 + 4 (7 = start offset, 4 = space for storing count) */
         len = pdu_marshal(pdu, 11 + count, "S", &v9stat);
 
-        v9fs_readdir_unlock(&fidp->fs.dir);
-
         if (len < 0) {
             v9fs_co_seekdir(pdu, fidp, saved_dir_pos);
             v9fs_stat_free(&v9stat);
@@ -2223,11 +2217,9 @@ static int coroutine_fn v9fs_do_readdir_with_stat(V9fsPDU *pdu,
         count += len;
         v9fs_stat_free(&v9stat);
         v9fs_path_free(&path);
-        saved_dir_pos = dent->d_off;
+        saved_dir_pos = dent.d_off;
     }
 
-    v9fs_readdir_unlock(&fidp->fs.dir);
-
     v9fs_path_free(&path);
     if (err < 0) {
         return err;
@@ -2340,7 +2332,7 @@ static int coroutine_fn v9fs_do_readdir(V9fsPDU *pdu, V9fsFidState *fidp,
     int len, err = 0;
     int32_t count = 0;
     off_t saved_dir_pos;
-    struct dirent *dent;
+    struct dirent dent;
 
     /* save the directory position */
     saved_dir_pos = v9fs_co_telldir(pdu, fidp);
@@ -2349,17 +2341,13 @@ static int coroutine_fn v9fs_do_readdir(V9fsPDU *pdu, V9fsFidState *fidp,
     }
 
     while (1) {
-        v9fs_readdir_lock(&fidp->fs.dir);
-
         err = v9fs_co_readdir(pdu, fidp, &dent);
-        if (err || !dent) {
+        if (err <= 0) {
             break;
         }
         v9fs_string_init(&name);
-        v9fs_string_sprintf(&name, "%s", dent->d_name);
+        v9fs_string_sprintf(&name, "%s", dent.d_name);
         if ((count + v9fs_readdir_data_size(&name)) > max_count) {
-            v9fs_readdir_unlock(&fidp->fs.dir);
-
             /* Ran out of buffer. Set dir back to old position and return */
             v9fs_co_seekdir(pdu, fidp, saved_dir_pos);
             v9fs_string_free(&name);
@@ -2374,9 +2362,8 @@ static int coroutine_fn v9fs_do_readdir(V9fsPDU *pdu, V9fsFidState *fidp,
              * different entries; we cannot make any assumption to avoid
              * that here.
              */
-            err = dirent_to_qid(pdu, fidp, dent, &qid);
+            err = dirent_to_qid(pdu, fidp, &dent, &qid);
             if (err < 0) {
-                v9fs_readdir_unlock(&fidp->fs.dir);
                 v9fs_co_seekdir(pdu, fidp, saved_dir_pos);
                 v9fs_string_free(&name);
                 return err;
@@ -2392,8 +2379,8 @@ static int coroutine_fn v9fs_do_readdir(V9fsPDU *pdu, V9fsFidState *fidp,
              * user would get that error anyway when accessing those
              * files/dirs through other ways.
              */
-            size = MIN(sizeof(dent->d_ino), sizeof(qid.path));
-            memcpy(&qid.path, &dent->d_ino, size);
+            size = MIN(sizeof(dent.d_ino), sizeof(qid.path));
+            memcpy(&qid.path, &dent.d_ino, size);
             /* Fill the other fields with dummy values */
             qid.type = 0;
             qid.version = 0;
@@ -2401,10 +2388,8 @@ static int coroutine_fn v9fs_do_readdir(V9fsPDU *pdu, V9fsFidState *fidp,
 
         /* 11 = 7 + 4 (7 = start offset, 4 = space for storing count) */
         len = pdu_marshal(pdu, 11 + count, "Qqbs",
-                          &qid, dent->d_off,
-                          dent->d_type, &name);
-
-        v9fs_readdir_unlock(&fidp->fs.dir);
+                          &qid, dent.d_off,
+                          dent.d_type, &name);
 
         if (len < 0) {
             v9fs_co_seekdir(pdu, fidp, saved_dir_pos);
@@ -2413,11 +2398,9 @@ static int coroutine_fn v9fs_do_readdir(V9fsPDU *pdu, V9fsFidState *fidp,
         }
         count += len;
         v9fs_string_free(&name);
-        saved_dir_pos = dent->d_off;
+        saved_dir_pos = dent.d_off;
     }
 
-    v9fs_readdir_unlock(&fidp->fs.dir);
-
     if (err < 0) {
         return err;
     }
diff --git a/hw/9pfs/codir.c b/hw/9pfs/codir.c
index 73f9a751e178..90356dc60140 100644
--- a/hw/9pfs/codir.c
+++ b/hw/9pfs/codir.c
@@ -19,7 +19,7 @@
 #include "coth.h"
 
 int coroutine_fn v9fs_co_readdir(V9fsPDU *pdu, V9fsFidState *fidp,
-                                 struct dirent **dent)
+                                 struct dirent *dent)
 {
     int err;
     V9fsState *s = pdu->s;
@@ -32,13 +32,20 @@ int coroutine_fn v9fs_co_readdir(V9fsPDU *pdu, V9fsFidState *fidp,
             struct dirent *entry;
 
             errno = 0;
+
+            v9fs_readdir_lock(&fidp->fs.dir);
+
             entry = s->ops->readdir(&s->ctx, &fidp->fs);
             if (!entry && errno) {
                 err = -errno;
+            } else if (entry) {
+                memcpy(dent, entry, sizeof(*dent));
+                err = 1;
             } else {
-                *dent = entry;
                 err = 0;
             }
+
+            v9fs_readdir_unlock(&fidp->fs.dir);
         });
     return err;
 }
diff --git a/hw/9pfs/coth.h b/hw/9pfs/coth.h
index c2cdc7a9eaac..696c90111261 100644
--- a/hw/9pfs/coth.h
+++ b/hw/9pfs/coth.h
@@ -48,7 +48,8 @@
 
 void co_run_in_worker_bh(void *);
 int coroutine_fn v9fs_co_readlink(V9fsPDU *, V9fsPath *, V9fsString *);
-int coroutine_fn v9fs_co_readdir(V9fsPDU *, V9fsFidState *, struct dirent **);
+/* Returns < 0 on error, 1 on success and 0 on end of directory */
+int coroutine_fn v9fs_co_readdir(V9fsPDU *, V9fsFidState *, struct dirent *);
 off_t coroutine_fn v9fs_co_telldir(V9fsPDU *, V9fsFidState *);
 void coroutine_fn v9fs_co_seekdir(V9fsPDU *, V9fsFidState *, off_t);
 void coroutine_fn v9fs_co_rewinddir(V9fsPDU *, V9fsFidState *);
diff --git a/tests/qtest/virtio-9p-test.c b/tests/qtest/virtio-9p-test.c
index 2167322985ec..f46ad888daa6 100644
--- a/tests/qtest/virtio-9p-test.c
+++ b/tests/qtest/virtio-9p-test.c
@@ -793,6 +793,38 @@ static void fs_flush_ignored(void *obj, void *data, QGuestAllocator *t_alloc)
     g_free(wnames[0]);
 }
 
+static void fs_readdir_deadlock(void *obj, void *data, QGuestAllocator *t_alloc)
+{
+    QVirtio9P *v9p = obj;
+    alloc = t_alloc;
+    char *const wnames[] = { g_strdup(QTEST_V9FS_SYNTH_READDIR_DEADLOCK_DIR) };
+    P9Req *req, *req2;
+
+    fs_attach(v9p, NULL, t_alloc);
+    req = v9fs_twalk(v9p, 0, 1, 1, wnames, 0);
+    v9fs_req_wait_for_reply(req, NULL);
+    v9fs_rwalk(req, NULL, NULL);
+
+    req = v9fs_tlopen(v9p, 1, O_WRONLY, 0);
+    v9fs_req_wait_for_reply(req, NULL);
+    v9fs_rlopen(req, NULL, NULL);
+
+    /*
+     * The first request will remain pending in the backend until
+     * a request with the magic offset is received. This deadlocks
+     * the mainloop of an older QEMU that still handles the critical
+     * section around readdir() in the frontend code.
+     */
+    req = v9fs_treaddir(v9p, 1, 0, 128, 0);
+    req2 = v9fs_treaddir(v9p, 1, QTEST_V9FS_SYNTH_READDIR_DEADLOCK_OFFSET, 128,
+                         1);
+    v9fs_req_wait_for_reply(req, NULL);
+    v9fs_req_free(req);
+    v9fs_req_free(req2);
+
+    g_free(wnames[0]);
+}
+
 static void register_virtio_9p_test(void)
 {
     qos_add_test("config", "virtio-9p", pci_config, NULL);
@@ -810,6 +842,7 @@ static void register_virtio_9p_test(void)
     qos_add_test("fs/flush/ignored", "virtio-9p", fs_flush_ignored,
                  NULL);
     qos_add_test("fs/readdir/basic", "virtio-9p", fs_readdir, NULL);
+    qos_add_test("fs/readdir/deadlock", "virtio-9p", fs_readdir_deadlock, NULL);
 }
 
 libqos_init(register_virtio_9p_test);


