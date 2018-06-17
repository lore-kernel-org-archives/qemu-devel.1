Received: from eggs.gnu.org ([2001:4830:134:3::10]:56825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <keno@juliacomputing.com>) id 1fUM0T-0005hp-0c
	for qemu-devel@nongnu.org; Sat, 16 Jun 2018 20:57:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <keno@juliacomputing.com>) id 1fUM0S-0003GC-6z
	for qemu-devel@nongnu.org; Sat, 16 Jun 2018 20:57:25 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:38513)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <keno@juliacomputing.com>)
	id 1fUM0S-0003Fm-1h
	for qemu-devel@nongnu.org; Sat, 16 Jun 2018 20:57:24 -0400
Received: by mail-qk0-x244.google.com with SMTP id y4-v6so7674844qka.5
	for <qemu-devel@nongnu.org>; Sat, 16 Jun 2018 17:57:23 -0700 (PDT)
From: Keno Fischer <keno@juliacomputing.com>
Date: Sat, 16 Jun 2018 20:56:50 -0400
Message-Id: <823a49a8771e3214dc953ed9d7facd02df3060e4.1529196703.git.keno@juliacomputing.com>
In-Reply-To: <cover.1529196703.git.keno@juliacomputing.com>
References: <cover.1529196703.git.keno@juliacomputing.com>
In-Reply-To: <cover.1529196703.git.keno@juliacomputing.com>
References: <cover.1529196703.git.keno@juliacomputing.com>
Subject: [Qemu-devel] [PATCH v3 06/13] 9p: darwin: Ignore O_{NOATIME, DIRECT}
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

Darwin doesn't have either of these flags. Darwin does have
F_NOCACHE, which is similar to O_DIRECT, but has different
enough semantics that other projects don't generally map
them automatically. In any case, we don't support O_DIRECT
on Linux at the moment either.

Signed-off-by: Keno Fischer <keno@juliacomputing.com>
---
 hw/9pfs/9p.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 06139c9..e650459 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -123,11 +123,18 @@ static int dotl_to_open_flags(int flags)
         { P9_DOTL_NONBLOCK, O_NONBLOCK } ,
         { P9_DOTL_DSYNC, O_DSYNC },
         { P9_DOTL_FASYNC, FASYNC },
+#ifndef CONFIG_DARWIN
+        { P9_DOTL_NOATIME, O_NOATIME },
+        /* On Darwin, we could map to F_NOCACHE, which is
+           similar, but doesn't quite have the same
+           semantics. However, we don't support O_DIRECT
+           even on linux at the moment, so we just ignore
+           it here. */
         { P9_DOTL_DIRECT, O_DIRECT },
+#endif
         { P9_DOTL_LARGEFILE, O_LARGEFILE },
         { P9_DOTL_DIRECTORY, O_DIRECTORY },
         { P9_DOTL_NOFOLLOW, O_NOFOLLOW },
-        { P9_DOTL_NOATIME, O_NOATIME },
         { P9_DOTL_SYNC, O_SYNC },
     };
 
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
