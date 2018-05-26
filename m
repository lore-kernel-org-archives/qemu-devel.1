Received: from eggs.gnu.org ([2001:4830:134:3::10]:35737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <keno@juliacomputing.com>) id 1fMRgV-0006FX-92
	for qemu-devel@nongnu.org; Sat, 26 May 2018 01:24:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <keno@juliacomputing.com>) id 1fMRgU-0004Vc-2s
	for qemu-devel@nongnu.org; Sat, 26 May 2018 01:24:07 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:42997)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <keno@juliacomputing.com>)
	id 1fMRgT-0004VL-Ut
	for qemu-devel@nongnu.org; Sat, 26 May 2018 01:24:06 -0400
Received: by mail-qt0-x241.google.com with SMTP id c2-v6so9177445qtn.9
	for <qemu-devel@nongnu.org>; Fri, 25 May 2018 22:24:05 -0700 (PDT)
From: keno@juliacomputing.com
Date: Sat, 26 May 2018 01:23:07 -0400
Message-Id: <6205f39b495ee7356478cc53faf5e32289f57182.1527310210.git.keno@alumni.harvard.edu>
In-Reply-To: <cover.1527310210.git.keno@alumni.harvard.edu>
References: <cover.1527310210.git.keno@alumni.harvard.edu>
In-Reply-To: <cover.1527310210.git.keno@alumni.harvard.edu>
References: <cover.1527310210.git.keno@alumni.harvard.edu>
Subject: [Qemu-devel] [PATCH 05/13] 9p: darwin: Handle struct dirent
 differences
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

Signed-off-by: Keno Fischer <keno@juliacomputing.com>
---
 hw/9pfs/9p-synth.c |  4 ++++
 hw/9pfs/9p.c       | 18 ++++++++++++++++--
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/hw/9pfs/9p-synth.c b/hw/9pfs/9p-synth.c
index eb68b42..3c0a6d8 100644
--- a/hw/9pfs/9p-synth.c
+++ b/hw/9pfs/9p-synth.c
@@ -221,7 +221,11 @@ static void synth_direntry(V9fsSynthNode *node,
 {
     strcpy(entry->d_name, node->name);
     entry->d_ino = node->attr->inode;
+#ifdef CONFIG_DARWIN
+    entry->d_seekoff = off + 1;
+#else
     entry->d_off = off + 1;
+#endif
 }
 
 static struct dirent *synth_get_dentry(V9fsSynthNode *dir,
diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 1cfdf7d..49654ae 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -1801,7 +1801,11 @@ static int coroutine_fn v9fs_do_readdir_with_stat(V9fsPDU *pdu,
         count += len;
         v9fs_stat_free(&v9stat);
         v9fs_path_free(&path);
+#ifdef CONFIG_DARWIN
+        saved_dir_pos = v9fs_co_telldir(pdu, fidp);
+#else
         saved_dir_pos = dent->d_off;
+#endif
     }
 
     v9fs_readdir_unlock(&fidp->fs.dir);
@@ -1952,9 +1956,19 @@ static int coroutine_fn v9fs_do_readdir(V9fsPDU *pdu, V9fsFidState *fidp,
         qid.type = 0;
         qid.version = 0;
 
+#ifdef CONFIG_DARWIN
+        // Darwin has d_seekoff, which appears to function
+        // analogously to d_off. However, it does not appear
+        // to be supported on all file systems, so use
+        // telldir for correctness.
+        off_t off = v9fs_co_telldir(pdu, fidp);
+#else
+        off_t off = dent->d_off;
+#endif
+
         /* 11 = 7 + 4 (7 = start offset, 4 = space for storing count) */
         len = pdu_marshal(pdu, 11 + count, "Qqbs",
-                          &qid, dent->d_off,
+                          &qid, off,
                           dent->d_type, &name);
 
         v9fs_readdir_unlock(&fidp->fs.dir);
@@ -1966,7 +1980,7 @@ static int coroutine_fn v9fs_do_readdir(V9fsPDU *pdu, V9fsFidState *fidp,
         }
         count += len;
         v9fs_string_free(&name);
-        saved_dir_pos = dent->d_off;
+        saved_dir_pos = off;
     }
 
     v9fs_readdir_unlock(&fidp->fs.dir);
-- 
2.8.1
