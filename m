Received: from eggs.gnu.org ([2001:4830:134:3::10]:49723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ctvIN-0006tK-TD
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 08:04:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ctvIM-0005Vd-U8
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 08:04:47 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Fri, 31 Mar 2017 14:04:31 +0200
Message-Id: <20170331120431.1767-3-mreitz@redhat.com>
In-Reply-To: <20170331120431.1767-1-mreitz@redhat.com>
References: <20170331120431.1767-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.9 2/2] block/curl: Check protocol prefix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>

If the user has explicitly specified a block driver and thus a protocol,
we have to make sure the URL's protocol prefix matches. Otherwise the
latter will silently override the former which might catch some users by
surprise.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/curl.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/block/curl.c b/block/curl.c
index 34dbd335f4..2708d57c2f 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -659,6 +659,7 @@ static int curl_open(BlockDriverState *bs, QDict *options, int flags,
     const char *cookie;
     double d;
     const char *secretid;
+    const char *protocol_delimiter;
 
     static int inited = 0;
 
@@ -700,6 +701,15 @@ static int curl_open(BlockDriverState *bs, QDict *options, int flags,
         goto out_noclean;
     }
 
+    if (!strstart(file, bs->drv->protocol_name, &protocol_delimiter) ||
+        !strstart(protocol_delimiter, "://", NULL))
+    {
+        error_setg(errp, "%s curl driver cannot handle the URL '%s' (does not "
+                   "start with '%s://')", bs->drv->protocol_name, file,
+                   bs->drv->protocol_name);
+        goto out_noclean;
+    }
+
     s->username = g_strdup(qemu_opt_get(opts, CURL_BLOCK_OPT_USERNAME));
     secretid = qemu_opt_get(opts, CURL_BLOCK_OPT_PASSWORD_SECRET);
 
-- 
2.12.1
