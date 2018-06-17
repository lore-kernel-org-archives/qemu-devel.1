Received: from eggs.gnu.org ([2001:4830:134:3::10]:56837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <keno@juliacomputing.com>) id 1fUM0T-0005iJ-Ut
	for qemu-devel@nongnu.org; Sat, 16 Jun 2018 20:57:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <keno@juliacomputing.com>) id 1fUM0T-0003Gc-9b
	for qemu-devel@nongnu.org; Sat, 16 Jun 2018 20:57:26 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:35378)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <keno@juliacomputing.com>)
	id 1fUM0T-0003GP-5N
	for qemu-devel@nongnu.org; Sat, 16 Jun 2018 20:57:25 -0400
Received: by mail-qk0-x241.google.com with SMTP id d130-v6so7676791qkc.2
	for <qemu-devel@nongnu.org>; Sat, 16 Jun 2018 17:57:25 -0700 (PDT)
From: Keno Fischer <keno@juliacomputing.com>
Date: Sat, 16 Jun 2018 20:56:51 -0400
Message-Id: <b8df01a2077daf301da4f3e3cd9c2fbbbd0fea5e.1529196703.git.keno@juliacomputing.com>
In-Reply-To: <cover.1529196703.git.keno@juliacomputing.com>
References: <cover.1529196703.git.keno@juliacomputing.com>
In-Reply-To: <cover.1529196703.git.keno@juliacomputing.com>
References: <cover.1529196703.git.keno@juliacomputing.com>
Subject: [Qemu-devel] [PATCH v3 07/13] 9p: darwin: Provide a compatibility
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
Cc: Keno Fischer <keno@juliacomputing.com>, groug@kaod.org

Signed-off-by: Keno Fischer <keno@juliacomputing.com>
---
 hw/9pfs/9p.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index e650459..abfb8dc 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -3374,6 +3374,13 @@ out_nofid:
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
     int flags, rflags = 0;
-- 
2.8.1
