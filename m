Received: from eggs.gnu.org ([2001:4830:134:3::10]:41085)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gP4lE-00056z-GE
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 07:04:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gP4l8-0006a2-K2
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 07:04:08 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58442)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gP4l8-0006Zd-C9
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 07:04:02 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wAKBwar5008013
	for <qemu-devel@nongnu.org>; Tue, 20 Nov 2018 07:04:01 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2nvg72n0wy-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 20 Nov 2018 07:04:01 -0500
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Tue, 20 Nov 2018 12:03:58 -0000
From: Greg Kurz <groug@kaod.org>
Date: Tue, 20 Nov 2018 13:03:26 +0100
In-Reply-To: <20181120120326.30879-1-groug@kaod.org>
References: <20181120120326.30879-1-groug@kaod.org>
Message-Id: <20181120120326.30879-2-groug@kaod.org>
Subject: [Qemu-devel] [PULL 1/1] 9p: take write lock on fid path updates
 (CVE-2018-19364)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Greg Kurz <groug@kaod.org>, P J P <ppandit@redhat.com>

Recent commit 5b76ef50f62079a fixed a race where v9fs_co_open2() could
possibly overwrite a fid path with v9fs_path_copy() while it is being
accessed by some other thread, ie, use-after-free that can be detected
by ASAN with a custom 9p client.

It turns out that the same can happen at several locations where
v9fs_path_copy() is used to set the fid path. The fix is again to
take the write lock.

Fixes CVE-2018-19364.

Cc: P J P <ppandit@redhat.com>
Reported-by: zhibin hu <noirfate@gmail.com>
Reviewed-by: Prasad J Pandit <pjp@fedoraproject.org>
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index eef289e394d4..267a25533b77 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -1391,7 +1391,9 @@ static void coroutine_fn v9fs_walk(void *opaque)
             err = -EINVAL;
             goto out;
         }
+        v9fs_path_write_lock(s);
         v9fs_path_copy(&fidp->path, &path);
+        v9fs_path_unlock(s);
     } else {
         newfidp = alloc_fid(s, newfid);
         if (newfidp == NULL) {
@@ -2160,6 +2162,7 @@ static void coroutine_fn v9fs_create(void *opaque)
     V9fsString extension;
     int iounit;
     V9fsPDU *pdu = opaque;
+    V9fsState *s = pdu->s;
 
     v9fs_path_init(&path);
     v9fs_string_init(&name);
@@ -2200,7 +2203,9 @@ static void coroutine_fn v9fs_create(void *opaque)
         if (err < 0) {
             goto out;
         }
+        v9fs_path_write_lock(s);
         v9fs_path_copy(&fidp->path, &path);
+        v9fs_path_unlock(s);
         err = v9fs_co_opendir(pdu, fidp);
         if (err < 0) {
             goto out;
@@ -2216,7 +2221,9 @@ static void coroutine_fn v9fs_create(void *opaque)
         if (err < 0) {
             goto out;
         }
+        v9fs_path_write_lock(s);
         v9fs_path_copy(&fidp->path, &path);
+        v9fs_path_unlock(s);
     } else if (perm & P9_STAT_MODE_LINK) {
         int32_t ofid = atoi(extension.data);
         V9fsFidState *ofidp = get_fid(pdu, ofid);
@@ -2234,7 +2241,9 @@ static void coroutine_fn v9fs_create(void *opaque)
             fidp->fid_type = P9_FID_NONE;
             goto out;
         }
+        v9fs_path_write_lock(s);
         v9fs_path_copy(&fidp->path, &path);
+        v9fs_path_unlock(s);
         err = v9fs_co_lstat(pdu, &fidp->path, &stbuf);
         if (err < 0) {
             fidp->fid_type = P9_FID_NONE;
@@ -2272,7 +2281,9 @@ static void coroutine_fn v9fs_create(void *opaque)
         if (err < 0) {
             goto out;
         }
+        v9fs_path_write_lock(s);
         v9fs_path_copy(&fidp->path, &path);
+        v9fs_path_unlock(s);
     } else if (perm & P9_STAT_MODE_NAMED_PIPE) {
         err = v9fs_co_mknod(pdu, fidp, &name, fidp->uid, -1,
                             0, S_IFIFO | (perm & 0777), &stbuf);
@@ -2283,7 +2294,9 @@ static void coroutine_fn v9fs_create(void *opaque)
         if (err < 0) {
             goto out;
         }
+        v9fs_path_write_lock(s);
         v9fs_path_copy(&fidp->path, &path);
+        v9fs_path_unlock(s);
     } else if (perm & P9_STAT_MODE_SOCKET) {
         err = v9fs_co_mknod(pdu, fidp, &name, fidp->uid, -1,
                             0, S_IFSOCK | (perm & 0777), &stbuf);
@@ -2294,7 +2307,9 @@ static void coroutine_fn v9fs_create(void *opaque)
         if (err < 0) {
             goto out;
         }
+        v9fs_path_write_lock(s);
         v9fs_path_copy(&fidp->path, &path);
+        v9fs_path_unlock(s);
     } else {
         err = v9fs_co_open2(pdu, fidp, &name, -1,
                             omode_to_uflags(mode)|O_CREAT, perm, &stbuf);
-- 
2.17.2
