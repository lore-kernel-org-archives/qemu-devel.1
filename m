Received: from eggs.gnu.org ([2001:4830:134:3::10]:33361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <keno@juliacomputing.com>) id 1fOYr3-00033l-3Q
	for qemu-devel@nongnu.org; Thu, 31 May 2018 21:27:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <keno@juliacomputing.com>) id 1fOYr1-00034X-1q
	for qemu-devel@nongnu.org; Thu, 31 May 2018 21:27:45 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:32772)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <keno@juliacomputing.com>)
	id 1fOYr0-000348-SC
	for qemu-devel@nongnu.org; Thu, 31 May 2018 21:27:42 -0400
Received: by mail-qk0-x244.google.com with SMTP id h7-v6so11577115qkm.0
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 18:27:42 -0700 (PDT)
From: Keno Fischer <keno@juliacomputing.com>
Date: Thu, 31 May 2018 21:26:05 -0400
Message-Id: <0257b0ef53ac4c12f1ca29a86b2ff3276853be32.1527814874.git.keno@juliacomputing.com>
In-Reply-To: <cover.1527814874.git.keno@juliacomputing.com>
References: <cover.1527814874.git.keno@juliacomputing.com>
In-Reply-To: <cover.1527814874.git.keno@juliacomputing.com>
References: <cover.1527814874.git.keno@juliacomputing.com>
Subject: [Qemu-devel] [PATCH v2 10/20] 9p: darwin: Handle struct stat(fs)
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
Cc: Keno Fischer <keno@juliacomputing.com>, groug@kaod.org

Signed-off-by: Keno Fischer <keno@juliacomputing.com>
---

Changes since v1:
 * Now also covers fsdev/virtfs-proxy-helper.c

 fsdev/virtfs-proxy-helper.c | 14 +++++++++++---
 hw/9pfs/9p-proxy.c          | 17 ++++++++++++++---
 hw/9pfs/9p-synth.c          |  2 ++
 hw/9pfs/9p.c                | 16 ++++++++++++++--
 4 files changed, 41 insertions(+), 8 deletions(-)

diff --git a/fsdev/virtfs-proxy-helper.c b/fsdev/virtfs-proxy-helper.c
index 94fb069..3bc1269 100644
--- a/fsdev/virtfs-proxy-helper.c
+++ b/fsdev/virtfs-proxy-helper.c
@@ -506,12 +506,15 @@ static void stat_to_prstat(ProxyStat *pr_stat, struct stat *stat)
     pr_stat->st_size = stat->st_size;
     pr_stat->st_blksize = stat->st_blksize;
     pr_stat->st_blocks = stat->st_blocks;
+#ifdef CONFIG_DARWIN
+    pr_stat->st_atim_nsec = stat->st_atimespec.tv_nsec;
+    pr_stat->st_mtim_nsec = stat->st_mtimespec.tv_nsec;
+    pr_stat->st_ctim_nsec = stat->st_ctimespec.tv_nsec;
+#else
     pr_stat->st_atim_sec = stat->st_atim.tv_sec;
-    pr_stat->st_atim_nsec = stat->st_atim.tv_nsec;
     pr_stat->st_mtim_sec = stat->st_mtim.tv_sec;
-    pr_stat->st_mtim_nsec = stat->st_mtim.tv_nsec;
     pr_stat->st_ctim_sec = stat->st_ctim.tv_sec;
-    pr_stat->st_ctim_nsec = stat->st_ctim.tv_nsec;
+#endif
 }
 
 static void statfs_to_prstatfs(ProxyStatFS *pr_stfs, struct statfs *stfs)
@@ -524,10 +527,15 @@ static void statfs_to_prstatfs(ProxyStatFS *pr_stfs, struct statfs *stfs)
     pr_stfs->f_bavail = stfs->f_bavail;
     pr_stfs->f_files = stfs->f_files;
     pr_stfs->f_ffree = stfs->f_ffree;
+#ifdef CONFIG_DARWIN
+    pr_stfs->f_fsid[0] = stfs->f_fsid.val[0];
+    pr_stfs->f_fsid[1] = stfs->f_fsid.val[1];
+#else
     pr_stfs->f_fsid[0] = stfs->f_fsid.__val[0];
     pr_stfs->f_fsid[1] = stfs->f_fsid.__val[1];
     pr_stfs->f_namelen = stfs->f_namelen;
     pr_stfs->f_frsize = stfs->f_frsize;
+#endif
 }
 
 /*
diff --git a/hw/9pfs/9p-proxy.c b/hw/9pfs/9p-proxy.c
index 47a94e0..8a2c174 100644
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
index a757374..212f569 100644
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
 
@@ -2959,9 +2965,15 @@ static int v9fs_fill_statfs(V9fsState *s, V9fsPDU *pdu, struct statfs *stbuf)
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
