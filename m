Received: from eggs.gnu.org ([2001:4830:134:3::10]:36213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dFGcw-0001id-Bq
	for qemu-devel@nongnu.org; Mon, 29 May 2017 05:06:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dFGcs-0006F3-BC
	for qemu-devel@nongnu.org; Mon, 29 May 2017 05:06:14 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41508
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dFGcs-0006Er-5x
	for qemu-devel@nongnu.org; Mon, 29 May 2017 05:06:10 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4T94D6X189269
	for <qemu-devel@nongnu.org>; Mon, 29 May 2017 05:06:09 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2arghb0m05-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 29 May 2017 05:06:09 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Mon, 29 May 2017 10:06:07 +0100
From: Greg Kurz <groug@kaod.org>
Date: Mon, 29 May 2017 11:05:37 +0200
In-Reply-To: <1496048740-26578-1-git-send-email-groug@kaod.org>
References: <1496048740-26578-1-git-send-email-groug@kaod.org>
Message-Id: <1496048740-26578-9-git-send-email-groug@kaod.org>
Subject: [Qemu-devel] [PULL 08/11] 9pfs: check return value of
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>, Greg Kurz <groug@kaod.org>

These v9fs_co_name_to_path() call sites have always been around. I guess
no care was taken to check the return value because the name_to_path
operation could never fail at the time. This is no longer true: the
handle and synth backends can already fail this operation, and so will the
local backend soon.

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 hw/9pfs/9p.c | 36 +++++++++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 11 deletions(-)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index a25d31e62f1c..96d268334865 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -2571,7 +2571,10 @@ static int coroutine_fn v9fs_complete_rename(V9fsPDU *pdu, V9fsFidState *fidp,
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
@@ -2583,8 +2586,11 @@ static int coroutine_fn v9fs_complete_rename(V9fsPDU *pdu, V9fsFidState *fidp,
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
@@ -2664,20 +2670,26 @@ out_nofid:
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
@@ -2689,8 +2701,10 @@ static void coroutine_fn v9fs_fix_fid_paths(V9fsPDU *pdu, V9fsPath *olddir,
             v9fs_fix_path(&tfidp->path, &newpath, strlen(oldpath.data));
         }
     }
+out:
     v9fs_path_free(&oldpath);
     v9fs_path_free(&newpath);
+    return err;
 }
 
 static int coroutine_fn v9fs_complete_renameat(V9fsPDU *pdu, int32_t olddirfid,
@@ -2724,8 +2738,8 @@ static int coroutine_fn v9fs_complete_renameat(V9fsPDU *pdu, int32_t olddirfid,
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
-- 
2.7.4
