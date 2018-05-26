Received: from eggs.gnu.org ([2001:4830:134:3::10]:35783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <keno@juliacomputing.com>) id 1fMRga-0006KC-IX
	for qemu-devel@nongnu.org; Sat, 26 May 2018 01:24:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <keno@juliacomputing.com>) id 1fMRgZ-0004ZI-Oy
	for qemu-devel@nongnu.org; Sat, 26 May 2018 01:24:12 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:39266)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <keno@juliacomputing.com>)
	id 1fMRgZ-0004Z0-LD
	for qemu-devel@nongnu.org; Sat, 26 May 2018 01:24:11 -0400
Received: by mail-qt0-x243.google.com with SMTP id f1-v6so9181665qtj.6
	for <qemu-devel@nongnu.org>; Fri, 25 May 2018 22:24:11 -0700 (PDT)
From: keno@juliacomputing.com
Date: Sat, 26 May 2018 01:23:11 -0400
Message-Id: <305501d80a62cc12e0d82a2ffd656819badd0d4d.1527310210.git.keno@alumni.harvard.edu>
In-Reply-To: <cover.1527310210.git.keno@alumni.harvard.edu>
References: <cover.1527310210.git.keno@alumni.harvard.edu>
In-Reply-To: <cover.1527310210.git.keno@alumni.harvard.edu>
References: <cover.1527310210.git.keno@alumni.harvard.edu>
Subject: [Qemu-devel] [PATCH 09/13] 9p: darwin: Provide a compatibility
 definition for XATTR_SIZE_MAX
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
 hw/9pfs/9p.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index f5f00aa..4ae4da6 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -3351,6 +3351,13 @@ out_nofid:
     v9fs_string_free(&name);
 }
 
+#if defined(CONFIG_DARWIN) && !defined(XATTR_SIZE_MAX)
+/* Darwin doesn't seem to define a maximum xattr size in its user
+   user space header, but looking at the kernel source, HFS supports
+   up to INT32_MAX, so use that as the maximum.
+*/
+#define XATTR_SIZE_MAX INT32_MAX
+#endif
 static void coroutine_fn v9fs_xattrcreate(void *opaque)
 {
     int flags;
-- 
2.8.1
