Received: from eggs.gnu.org ([2001:4830:134:3::10]:35765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <keno@juliacomputing.com>) id 1fMRgZ-0006JM-NN
	for qemu-devel@nongnu.org; Sat, 26 May 2018 01:24:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <keno@juliacomputing.com>) id 1fMRgY-0004Yc-D9
	for qemu-devel@nongnu.org; Sat, 26 May 2018 01:24:11 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:34353)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <keno@juliacomputing.com>)
	id 1fMRgY-0004YN-8B
	for qemu-devel@nongnu.org; Sat, 26 May 2018 01:24:10 -0400
Received: by mail-qt0-x243.google.com with SMTP id m5-v6so9197041qti.1
	for <qemu-devel@nongnu.org>; Fri, 25 May 2018 22:24:10 -0700 (PDT)
From: keno@juliacomputing.com
Date: Sat, 26 May 2018 01:23:10 -0400
Message-Id: <a648afd776c8eb50398524c6c8d53629f5141211.1527310210.git.keno@alumni.harvard.edu>
In-Reply-To: <cover.1527310210.git.keno@alumni.harvard.edu>
References: <cover.1527310210.git.keno@alumni.harvard.edu>
In-Reply-To: <cover.1527310210.git.keno@alumni.harvard.edu>
References: <cover.1527310210.git.keno@alumni.harvard.edu>
Subject: [Qemu-devel] [PATCH 08/13] 9p: darwin: Ignore O_{NOATIME, DIRECT}
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
 hw/9pfs/9p.c | 37 +++++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 49654ae..f5f00aa 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -115,20 +115,27 @@ static int dotl_to_open_flags(int flags)
     int oflags = flags & O_ACCMODE;
 
     DotlOpenflagMap dotl_oflag_map[] = {
-        { P9_DOTL_CREATE, O_CREAT },
-        { P9_DOTL_EXCL, O_EXCL },
-        { P9_DOTL_NOCTTY , O_NOCTTY },
-        { P9_DOTL_TRUNC, O_TRUNC },
-        { P9_DOTL_APPEND, O_APPEND },
-        { P9_DOTL_NONBLOCK, O_NONBLOCK } ,
-        { P9_DOTL_DSYNC, O_DSYNC },
-        { P9_DOTL_FASYNC, FASYNC },
-        { P9_DOTL_DIRECT, O_DIRECT },
-        { P9_DOTL_LARGEFILE, O_LARGEFILE },
-        { P9_DOTL_DIRECTORY, O_DIRECTORY },
-        { P9_DOTL_NOFOLLOW, O_NOFOLLOW },
-        { P9_DOTL_NOATIME, O_NOATIME },
-        { P9_DOTL_SYNC, O_SYNC },
+        {P9_DOTL_CREATE, O_CREAT},
+        {P9_DOTL_EXCL, O_EXCL},
+        {P9_DOTL_NOCTTY, O_NOCTTY},
+        {P9_DOTL_TRUNC, O_TRUNC},
+        {P9_DOTL_APPEND, O_APPEND},
+        {P9_DOTL_NONBLOCK, O_NONBLOCK},
+        {P9_DOTL_DSYNC, O_DSYNC},
+        {P9_DOTL_FASYNC, FASYNC},
+#ifndef CONFIG_DARWIN
+        {P9_DOTL_NOATIME, O_NOATIME},
+        /* On Darwin, we could map to F_NOCACHE, which is
+           similar, but doesn't quite have the same
+           semantics. However, we don't support O_DIRECT
+           even on linux at the moment, so we just ignore
+           it here. */
+        {P9_DOTL_DIRECT, O_DIRECT},
+#endif
+        {P9_DOTL_LARGEFILE, O_LARGEFILE},
+        {P9_DOTL_DIRECTORY, O_DIRECTORY},
+        {P9_DOTL_NOFOLLOW, O_NOFOLLOW},
+        {P9_DOTL_SYNC, O_SYNC},
     };
 
     for (i = 0; i < ARRAY_SIZE(dotl_oflag_map); i++) {
@@ -156,10 +163,12 @@ static int get_dotl_openflags(V9fsState *s, int oflags)
      */
     flags = dotl_to_open_flags(oflags);
     flags &= ~(O_NOCTTY | O_ASYNC | O_CREAT);
+#ifndef CONFIG_DARWIN
     /*
      * Ignore direct disk access hint until the server supports it.
      */
     flags &= ~O_DIRECT;
+#endif
     return flags;
 }
 
-- 
2.8.1
