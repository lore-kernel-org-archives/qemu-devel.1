Received: from eggs.gnu.org ([2001:4830:134:3::10]:60996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1d6ezL-0007uK-6i
	for qemu-devel@nongnu.org; Fri, 05 May 2017 11:17:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1d6ezH-0007PE-V7
	for qemu-devel@nongnu.org; Fri, 05 May 2017 11:17:47 -0400
Received: from 13.mo5.mail-out.ovh.net ([87.98.182.191]:54644)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1d6ezH-0007OM-OB
	for qemu-devel@nongnu.org; Fri, 05 May 2017 11:17:43 -0400
Received: from player786.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 30FE3EC065
	for <qemu-devel@nongnu.org>; Fri,  5 May 2017 17:17:42 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Fri, 05 May 2017 16:37:04 +0200
Message-ID: <149399502436.29022.4452572475773635974.stgit@bahia.lan>
In-Reply-To: <149399500677.29022.12340124231191204194.stgit@bahia.lan>
References: <149399500677.29022.12340124231191204194.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 1/5] 9pfs: check return value of
 v9fs_co_name_to_path()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?L=C3=A9o?= Gaspard <leo@gaspard.io>, Eric Blake <eblake@redhat.com>, Greg Kurz <groug@kaod.org>

These v9fs_co_name_to_path() call sites have always been around. I guess
no care was taken to check the return value because the name_to_path
operation could never fail at the time. This is no longer true: the
handle and synth backends can already fail this operation, and so will the
local backend soon.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p.c |   36 +++++++++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 11 deletions(-)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index c80ba67389ce..dc5250b342fa 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -2576,7 +2576,10 @@ static int coroutine_fn v9fs_complete_rename(V9fsPDU *pdu, V9fsFidState *fidp,
             err = -EINVAL;
             goto out;
         }
-        v9fs_co_name_to_path(pdu, &dirfidp->path, name->data, &new_path);
+        err = v9fs_co_name_to_path(pdu, &dirfidp->path, name->data, &new_path);
+        if (err < 0) {
+            goto out;
+        }
     } else {
         old_name = fidp->path.data;
         end = strrchr(old_name, '/');
@@ -2588,8 +2591,11 @@ static int coroutine_fn v9fs_complete_rename(V9fsPDU *pdu, V9fsFidState *fidp,
         new_name = g_malloc0(end - old_name + name->size + 1);
         strncat(new_name, old_name, end - old_name);
         strncat(new_name + (end - old_name), name->data, name->size);
-        v9fs_co_name_to_path(pdu, NULL, new_name, &new_path);
+        err = v9fs_co_name_to_path(pdu, NULL, new_name, &new_path);
         g_free(new_name);
+        if (err < 0) {
+            goto out;
+        }
     }
     err = v9fs_co_rename(pdu, &fidp->path, &new_path);
     if (err < 0) {
@@ -2669,20 +2675,26 @@ out_nofid:
     v9fs_string_free(&name);
 }
 
-static void coroutine_fn v9fs_fix_fid_paths(V9fsPDU *pdu, V9fsPath *olddir,
-                                            V9fsString *old_name,
-                                            V9fsPath *newdir,
-                                            V9fsString *new_name)
+static int coroutine_fn v9fs_fix_fid_paths(V9fsPDU *pdu, V9fsPath *olddir,
+                                           V9fsString *old_name,
+                                           V9fsPath *newdir,
+                                           V9fsString *new_name)
 {
     V9fsFidState *tfidp;
     V9fsPath oldpath, newpath;
     V9fsState *s = pdu->s;
-
+    int err;
 
     v9fs_path_init(&oldpath);
     v9fs_path_init(&newpath);
-    v9fs_co_name_to_path(pdu, olddir, old_name->data, &oldpath);
-    v9fs_co_name_to_path(pdu, newdir, new_name->data, &newpath);
+    err = v9fs_co_name_to_path(pdu, olddir, old_name->data, &oldpath);
+    if (err < 0) {
+        goto out;
+    }
+    err = v9fs_co_name_to_path(pdu, newdir, new_name->data, &newpath);
+    if (err < 0) {
+        goto out;
+    }
 
     /*
      * Fixup fid's pointing to the old name to
@@ -2694,8 +2706,10 @@ static void coroutine_fn v9fs_fix_fid_paths(V9fsPDU *pdu, V9fsPath *olddir,
             v9fs_fix_path(&tfidp->path, &newpath, strlen(oldpath.data));
         }
     }
+out:
     v9fs_path_free(&oldpath);
     v9fs_path_free(&newpath);
+    return err;
 }
 
 static int coroutine_fn v9fs_complete_renameat(V9fsPDU *pdu, int32_t olddirfid,
@@ -2729,8 +2743,8 @@ static int coroutine_fn v9fs_complete_renameat(V9fsPDU *pdu, int32_t olddirfid,
     }
     if (s->ctx.export_flags & V9FS_PATHNAME_FSCONTEXT) {
         /* Only for path based fid  we need to do the below fixup */
-        v9fs_fix_fid_paths(pdu, &olddirfidp->path, old_name,
-                           &newdirfidp->path, new_name);
+        err = v9fs_fix_fid_paths(pdu, &olddirfidp->path, old_name,
+                                 &newdirfidp->path, new_name);
     }
 out:
     if (olddirfidp) {
