Received: from eggs.gnu.org ([2001:4830:134:3::10]:53610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gNBsb-0001P2-AX
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 02:16:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gNBsQ-0003tg-M6
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 02:15:53 -0500
Received: from 17.mo3.mail-out.ovh.net ([87.98.178.58]:45515)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gNBsH-0003b6-O0
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 02:15:38 -0500
Received: from player771.ha.ovh.net (unknown [10.109.160.230])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 0F90D1E964C
	for <qemu-devel@nongnu.org>; Thu, 15 Nov 2018 08:15:27 +0100 (CET)
From: Greg Kurz <groug@kaod.org>
Date: Thu, 15 Nov 2018 08:15:23 +0100
Message-ID: <154226612321.706352.2726376089201743065.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] 9p: take write lock on fid path updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, Prasad J Pandit <prasad@redhat.com>, zhibin hu <noirfate@gmail.com>

Recent commit 5b76ef50f62079a fixed a race where v9fs_co_open2() could
possibly overwrite a fid path with v9fs_path_copy() while it is being
accessed by some other thread, ie, use-after-free that can be detected
by ASAN with a custom 9p client.

It turns out that the same can happen at several locations where
v9fs_path_copy() is used to set the fid path. The fix is again to
take the write lock.

Cc: P J P <ppandit@redhat.com>
Reported-by: zhibin hu <noirfate@gmail.com>
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p.c |   15 +++++++++++++++
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
