Received: from eggs.gnu.org ([2001:4830:134:3::10]:35726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <keno@juliacomputing.com>) id 1fMRgU-0006Ea-0G
	for qemu-devel@nongnu.org; Sat, 26 May 2018 01:24:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <keno@juliacomputing.com>) id 1fMRgS-0004Uy-Qe
	for qemu-devel@nongnu.org; Sat, 26 May 2018 01:24:05 -0400
Received: from mail-qt0-x230.google.com ([2607:f8b0:400d:c0d::230]:33908)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <keno@juliacomputing.com>)
	id 1fMRgS-0004Un-LU
	for qemu-devel@nongnu.org; Sat, 26 May 2018 01:24:04 -0400
Received: by mail-qt0-x230.google.com with SMTP id m5-v6so9196917qti.1
	for <qemu-devel@nongnu.org>; Fri, 25 May 2018 22:24:04 -0700 (PDT)
From: keno@juliacomputing.com
Date: Sat, 26 May 2018 01:23:06 -0400
Message-Id: <f7eee8a830f0f651b115f57196658c5e24931872.1527310210.git.keno@alumni.harvard.edu>
In-Reply-To: <cover.1527310210.git.keno@alumni.harvard.edu>
References: <cover.1527310210.git.keno@alumni.harvard.edu>
In-Reply-To: <cover.1527310210.git.keno@alumni.harvard.edu>
References: <cover.1527310210.git.keno@alumni.harvard.edu>
Subject: [Qemu-devel] [PATCH 04/13] 9p: darwin: Handle struct stat(fs)
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
 fsdev/file-op-9p.h |  4 ++++
 hw/9pfs/9p-proxy.c | 17 ++++++++++++++---
 hw/9pfs/9p-synth.c |  2 ++
 hw/9pfs/9p.c       | 16 ++++++++++++++--
 4 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/fsdev/file-op-9p.h b/fsdev/file-op-9p.h
index a13e729..cf9d18d 100644
--- a/fsdev/file-op-9p.h
+++ b/fsdev/file-op-9p.h
@@ -19,6 +19,10 @@
 #ifdef CONFIG_LINUX
 #include <sys/vfs.h>
 #endif
+#ifdef CONFIG_DARWIN
+# include <sys/param.h>
+# include <sys/mount.h>
+#endif
 #include "qemu-fsdev-throttle.h"
 
 #define SM_LOCAL_MODE_BITS    0600
diff --git a/hw/9pfs/9p-proxy.c b/hw/9pfs/9p-proxy.c
index e2e0329..d4572fb 100644
--- a/hw/9pfs/9p-proxy.c
+++ b/hw/9pfs/9p-proxy.c
@@ -117,10 +117,15 @@ static void prstatfs_to_statfs(struct statfs *stfs, ProxyStatFS *prstfs)
     stfs->f_bavail = prstfs->f_bavail;
     stfs->f_files = prstfs->f_files;
     stfs->f_ffree = prstfs->f_ffree;
+#ifdef CONFIG_DARWIN
+    stfs->f_fsid.val[0] = prstfs->f_fsid[0] & 0xFFFFFFFFU;
+    stfs->f_fsid.val[1] = prstfs->f_fsid[1] >> 32 & 0xFFFFFFFFU;
+#else
     stfs->f_fsid.__val[0] = prstfs->f_fsid[0] & 0xFFFFFFFFU;
     stfs->f_fsid.__val[1] = prstfs->f_fsid[1] >> 32 & 0xFFFFFFFFU;
     stfs->f_namelen = prstfs->f_namelen;
     stfs->f_frsize = prstfs->f_frsize;
+#endif
 }
 
 /* Converts proxy_stat structure to VFS stat structure */
@@ -137,12 +142,18 @@ static void prstat_to_stat(struct stat *stbuf, ProxyStat *prstat)
    stbuf->st_size = prstat->st_size;
    stbuf->st_blksize = prstat->st_blksize;
    stbuf->st_blocks = prstat->st_blocks;
-   stbuf->st_atim.tv_sec = prstat->st_atim_sec;
-   stbuf->st_atim.tv_nsec = prstat->st_atim_nsec;
+   stbuf->st_atime = prstat->st_atim_sec;
    stbuf->st_mtime = prstat->st_mtim_sec;
-   stbuf->st_mtim.tv_nsec = prstat->st_mtim_nsec;
    stbuf->st_ctime = prstat->st_ctim_sec;
+#ifdef CONFIG_DARWIN
+   stbuf->st_atimespec.tv_nsec = prstat->st_atim_nsec;
+   stbuf->st_mtimespec.tv_nsec = prstat->st_mtim_nsec;
+   stbuf->st_ctimespec.tv_nsec = prstat->st_ctim_nsec;
+#else
+   stbuf->st_atim.tv_nsec = prstat->st_atim_nsec;
+   stbuf->st_mtim.tv_nsec = prstat->st_mtim_nsec;
    stbuf->st_ctim.tv_nsec = prstat->st_ctim_nsec;
+#endif
 }
 
 /*
diff --git a/hw/9pfs/9p-synth.c b/hw/9pfs/9p-synth.c
index 54239c9..eb68b42 100644
--- a/hw/9pfs/9p-synth.c
+++ b/hw/9pfs/9p-synth.c
@@ -426,7 +426,9 @@ static int synth_statfs(FsContext *s, V9fsPath *fs_path,
     stbuf->f_bsize = 512;
     stbuf->f_blocks = 0;
     stbuf->f_files = synth_node_count;
+#ifndef CONFIG_DARWIN
     stbuf->f_namelen = NAME_MAX;
+#endif
     return 0;
 }
 
diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index d74302d..1cfdf7d 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -905,11 +905,17 @@ static void stat_to_v9stat_dotl(V9fsState *s, const struct stat *stbuf,
     v9lstat->st_blksize = stbuf->st_blksize;
     v9lstat->st_blocks = stbuf->st_blocks;
     v9lstat->st_atime_sec = stbuf->st_atime;
-    v9lstat->st_atime_nsec = stbuf->st_atim.tv_nsec;
     v9lstat->st_mtime_sec = stbuf->st_mtime;
-    v9lstat->st_mtime_nsec = stbuf->st_mtim.tv_nsec;
     v9lstat->st_ctime_sec = stbuf->st_ctime;
+#ifdef CONFIG_DARWIN
+    v9lstat->st_atime_nsec = stbuf->st_atimespec.tv_nsec;
+    v9lstat->st_mtime_nsec = stbuf->st_mtimespec.tv_nsec;
+    v9lstat->st_ctime_nsec = stbuf->st_ctimespec.tv_nsec;
+#else
+    v9lstat->st_atime_nsec = stbuf->st_atim.tv_nsec;
+    v9lstat->st_mtime_nsec = stbuf->st_mtim.tv_nsec;
     v9lstat->st_ctime_nsec = stbuf->st_ctim.tv_nsec;
+#endif
     /* Currently we only support BASIC fields in stat */
     v9lstat->st_result_mask = P9_STATS_BASIC;
 
@@ -2950,9 +2956,15 @@ static int v9fs_fill_statfs(V9fsState *s, V9fsPDU *pdu, struct statfs *stbuf)
     f_bavail = stbuf->f_bavail/bsize_factor;
     f_files  = stbuf->f_files;
     f_ffree  = stbuf->f_ffree;
+#ifdef CONFIG_DARWIN
+    fsid_val = (unsigned int)stbuf->f_fsid.val[0] |
+               (unsigned long long)stbuf->f_fsid.val[1] << 32;
+    f_namelen = MAXNAMLEN;
+#else
     fsid_val = (unsigned int) stbuf->f_fsid.__val[0] |
                (unsigned long long)stbuf->f_fsid.__val[1] << 32;
     f_namelen = stbuf->f_namelen;
+#endif
 
     return pdu_marshal(pdu, offset, "ddqqqqqqd",
                        f_type, f_bsize, f_blocks, f_bfree,
-- 
2.8.1
