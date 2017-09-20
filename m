Received: from eggs.gnu.org ([2001:4830:134:3::10]:49086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dufP2-0006U5-M5
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:51:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dufOz-0004Fe-JS
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:51:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42394
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dufOz-0004FO-EM
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:50:57 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8KDn10g117724
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 09:50:57 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2d3r0pq40n-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 09:50:56 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Wed, 20 Sep 2017 14:50:54 +0100
From: Greg Kurz <groug@kaod.org>
Date: Wed, 20 Sep 2017 15:50:36 +0200
In-Reply-To: <20170920135038.21058-1-groug@kaod.org>
References: <20170920135038.21058-1-groug@kaod.org>
Message-Id: <20170920135038.21058-2-groug@kaod.org>
Subject: [Qemu-devel] [PULL 1/3] 9pfs: fix readdir() for 9p2000.u
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Greg Kurz <groug@kaod.org>, Jan Dakinevich <jan.dakinevich@gmail.com>

From: Jan Dakinevich <jan.dakinevich@gmail.com>

If the client is using 9p2000.u, the following occurs:

$ cd ${virtfs_shared_dir}
$ mkdir -p a/b/c
$ ls a/b
ls: cannot access 'a/b/a': No such file or directory
ls: cannot access 'a/b/b': No such file or directory
a  b  c

instead of the expected:

$ ls a/b
c

This is a regression introduced by commit f57f5878578a;
local_name_to_path() now resolves ".." and "." in paths,
and v9fs_do_readdir_with_stat()->stat_to_v9stat() then
copies the basename of the resulting path to the response.
With the example above, this means that "." and ".." are
turned into "b" and "a" respectively...

stat_to_v9stat() currently assumes it is passed a full
canonicalized path and uses it to do two different things:
1) to pass it to v9fs_co_readlink() in case the file is a symbolic
   link
2) to set the name field of the V9fsStat structure to the basename
   part of the given path

It only has two users: v9fs_stat() and v9fs_do_readdir_with_stat().

v9fs_stat() really needs 1) and 2) to be performed since it starts
with the full canonicalized path stored in the fid. It is different
for v9fs_do_readdir_with_stat() though because the name we want to
put into the V9fsStat structure is the d_name field of the dirent
actually (ie, we want to keep the "." and ".." special names). So,
we only need 1) in this case.

This patch hence adds a basename argument to stat_to_v9stat(), to
be used to set the name field of the V9fsStat structure, and moves
the basename logic to v9fs_stat().

Signed-off-by: Jan Dakinevich <jan.dakinevich@gmail.com>
(groug, renamed old name argument to path and updated changelog)
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 0a37c8bd1361..1078cfdaa4af 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -803,12 +803,12 @@ static uint32_t stat_to_v9mode(const struct stat *stbuf)
     return mode;
 }
 
-static int coroutine_fn stat_to_v9stat(V9fsPDU *pdu, V9fsPath *name,
+static int coroutine_fn stat_to_v9stat(V9fsPDU *pdu, V9fsPath *path,
+                                       const char *basename,
                                        const struct stat *stbuf,
                                        V9fsStat *v9stat)
 {
     int err;
-    const char *str;
 
     memset(v9stat, 0, sizeof(*v9stat));
 
@@ -829,7 +829,7 @@ static int coroutine_fn stat_to_v9stat(V9fsPDU *pdu, V9fsPath *name,
     v9fs_string_free(&v9stat->extension);
 
     if (v9stat->mode & P9_STAT_MODE_SYMLINK) {
-        err = v9fs_co_readlink(pdu, name, &v9stat->extension);
+        err = v9fs_co_readlink(pdu, path, &v9stat->extension);
         if (err < 0) {
             return err;
         }
@@ -842,14 +842,7 @@ static int coroutine_fn stat_to_v9stat(V9fsPDU *pdu, V9fsPath *name,
                 "HARDLINKCOUNT", (unsigned long)stbuf->st_nlink);
     }
 
-    str = strrchr(name->data, '/');
-    if (str) {
-        str += 1;
-    } else {
-        str = name->data;
-    }
-
-    v9fs_string_sprintf(&v9stat->name, "%s", str);
+    v9fs_string_sprintf(&v9stat->name, "%s", basename);
 
     v9stat->size = 61 +
         v9fs_string_size(&v9stat->name) +
@@ -1056,6 +1049,7 @@ static void coroutine_fn v9fs_stat(void *opaque)
     struct stat stbuf;
     V9fsFidState *fidp;
     V9fsPDU *pdu = opaque;
+    char *basename;
 
     err = pdu_unmarshal(pdu, offset, "d", &fid);
     if (err < 0) {
@@ -1072,7 +1066,9 @@ static void coroutine_fn v9fs_stat(void *opaque)
     if (err < 0) {
         goto out;
     }
-    err = stat_to_v9stat(pdu, &fidp->path, &stbuf, &v9stat);
+    basename = g_path_get_basename(fidp->path.data);
+    err = stat_to_v9stat(pdu, &fidp->path, basename, &stbuf, &v9stat);
+    g_free(basename);
     if (err < 0) {
         goto out;
     }
@@ -1748,7 +1744,7 @@ static int coroutine_fn v9fs_do_readdir_with_stat(V9fsPDU *pdu,
         if (err < 0) {
             break;
         }
-        err = stat_to_v9stat(pdu, &path, &stbuf, &v9stat);
+        err = stat_to_v9stat(pdu, &path, dent->d_name, &stbuf, &v9stat);
         if (err < 0) {
             break;
         }
-- 
2.13.5
