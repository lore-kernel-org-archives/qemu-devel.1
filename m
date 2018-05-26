Received: from eggs.gnu.org ([2001:4830:134:3::10]:35749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <keno@juliacomputing.com>) id 1fMRgW-0006GO-Fr
	for qemu-devel@nongnu.org; Sat, 26 May 2018 01:24:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <keno@juliacomputing.com>) id 1fMRgV-0004WZ-Hs
	for qemu-devel@nongnu.org; Sat, 26 May 2018 01:24:08 -0400
Received: from mail-qt0-x229.google.com ([2607:f8b0:400d:c0d::229]:33228)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <keno@juliacomputing.com>)
	id 1fMRgV-0004W1-Db
	for qemu-devel@nongnu.org; Sat, 26 May 2018 01:24:07 -0400
Received: by mail-qt0-x229.google.com with SMTP id e8-v6so9196376qth.0
	for <qemu-devel@nongnu.org>; Fri, 25 May 2018 22:24:07 -0700 (PDT)
From: keno@juliacomputing.com
Date: Sat, 26 May 2018 01:23:08 -0400
Message-Id: <17b8b06c00e359d1cb71b883371ad8c677a0e477.1527310210.git.keno@alumni.harvard.edu>
In-Reply-To: <cover.1527310210.git.keno@alumni.harvard.edu>
References: <cover.1527310210.git.keno@alumni.harvard.edu>
In-Reply-To: <cover.1527310210.git.keno@alumni.harvard.edu>
References: <cover.1527310210.git.keno@alumni.harvard.edu>
Subject: [Qemu-devel] [PATCH 06/13] 9p: darwin: Address minor differences
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Keno Fischer <keno@alumni.harvard.edu>, groug@kaod.org, Keno Fischer <keno@juliacomputing.com>

From: Keno Fischer <keno@alumni.harvard.edu>

- Darwin doesn't have strchrnul
- Comparisons of mode_t with -1 require an explicit cast, since mode_t
  is unsigned on Darwin.

Signed-off-by: Keno Fischer <keno@juliacomputing.com>
---
 hw/9pfs/9p-local.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index fd65d04..6e0b2e8 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -67,7 +67,10 @@ int local_open_nofollow(FsContext *fs_ctx, const char *path, int flags,
         assert(*path != '/');
 
         head = g_strdup(path);
-        c = strchrnul(path, '/');
+        /* equivalent to strchrnul(), but that is not available on Darwin */
+        c = strchr(path, '/');
+        if (!c)
+            c = path + strlen(path);
         if (*c) {
             /* Intermediate path element */
             head[c - path] = 0;
@@ -310,7 +313,7 @@ update_map_file:
     if (credp->fc_gid != -1) {
         gid = credp->fc_gid;
     }
-    if (credp->fc_mode != -1) {
+    if (credp->fc_mode != (mode_t)-1) {
         mode = credp->fc_mode;
     }
     if (credp->fc_rdev != -1) {
@@ -416,7 +419,7 @@ static int local_set_xattrat(int dirfd, const char *path, FsCred *credp)
             return err;
         }
     }
-    if (credp->fc_mode != -1) {
+    if (credp->fc_mode != (mode_t)-1) {
         uint32_t tmp_mode = cpu_to_le32(credp->fc_mode);
         err = fsetxattrat_nofollow(dirfd, path, "user.virtfs.mode", &tmp_mode,
                                    sizeof(mode_t), 0);
-- 
2.8.1
