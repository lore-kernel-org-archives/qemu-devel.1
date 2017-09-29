Received: from eggs.gnu.org ([2001:4830:134:3::10]:53491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <michael@fritscher.net>) id 1dxtF9-0005zp-UR
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 07:14:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <michael@fritscher.net>) id 1dxtF9-0007nv-4e
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 07:14:07 -0400
Received: from mifritscher.de ([188.40.170.105]:33006
	helo=mail.mifritscher.vserverkompetenz.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <michael@fritscher.net>)
	id 1dxtF8-0007nI-U5
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 07:14:07 -0400
From: Michael Fritscher <michael@fritscher.net>
Date: Fri, 29 Sep 2017 13:13:20 +0200
Message-Id: <20170929111323.6308-16-michael@fritscher.net>
In-Reply-To: <20170929111323.6308-1-michael@fritscher.net>
References: <20170929111323.6308-1-michael@fritscher.net>
Subject: [Qemu-devel] [PATCH 15/18] Fix unavailable fields in stbuf under
 Windows.
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: gkurz@linux.vnet.ibm.com, sw@weilnetz.de, aneesh.kumar@linux.vnet.ibm.com, mst@redhat.com, qemu-devel@nongnu.org
Cc: Michael Fritscher <michael@fritscher.net>
List-ID: <qemu-devel.nongnu.org>

Signed-off-by: Michael Fritscher <michael@fritscher.net>
---
 hw/9pfs/9p.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index e0ef1a2a6b..f4ccb45f64 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -886,14 +886,34 @@ static void stat_to_v9stat_dotl(V9fsState *s, const struct stat *stbuf,
     v9lstat->st_gid = stbuf->st_gid;
     v9lstat->st_rdev = stbuf->st_rdev;
     v9lstat->st_size = stbuf->st_size;
+#ifdef _WIN32
+    /* Blksize is the optimal EA-block,
+       while blocks always refers to 512 byte blocks
+    */
+    v9lstat->st_blksize = 4096;
+    v9lstat->st_blocks = ((stbuf->st_size + 1) / 512) + 1;
+#else
     v9lstat->st_blksize = stbuf->st_blksize;
     v9lstat->st_blocks = stbuf->st_blocks;
+#endif
     v9lstat->st_atime_sec = stbuf->st_atime;
+#ifdef _WIN32
+    v9lstat->st_atime_nsec = 0;
+#else
     v9lstat->st_atime_nsec = stbuf->st_atim.tv_nsec;
+#endif
     v9lstat->st_mtime_sec = stbuf->st_mtime;
+#ifdef _WIN32
+    v9lstat->st_mtime_nsec = 0;
+#else
     v9lstat->st_mtime_nsec = stbuf->st_mtim.tv_nsec;
+#endif
     v9lstat->st_ctime_sec = stbuf->st_ctime;
+#ifdef _WIN32
+    v9lstat->st_ctime_nsec = 0;
+#else
     v9lstat->st_ctime_nsec = stbuf->st_ctim.tv_nsec;
+#endif
     /* Currently we only support BASIC fields in stat */
     v9lstat->st_result_mask = P9_STATS_BASIC;
 
-- 
2.13.2.windows.1
