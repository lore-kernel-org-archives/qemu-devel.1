Received: from eggs.gnu.org ([2001:4830:134:3::10]:50521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eZPUI-0006T3-ML
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 18:08:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eZPUC-0006Ce-NE
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 18:08:50 -0500
From: Eric Blake <eblake@redhat.com>
Date: Wed, 10 Jan 2018 17:08:23 -0600
Message-Id: <20180110230825.18321-5-eblake@redhat.com>
In-Reply-To: <20180110230825.18321-1-eblake@redhat.com>
References: <20180110230825.18321-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 4/6] nbd/server: Add va_list form of
 nbd_negotiate_send_rep_err()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, vsementsov@virtuozzo.com, Paolo Bonzini <pbonzini@redhat.com>

This will be useful for the next patch.

Based on a patch by Vladimir Sementsov-Ogievskiy

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 nbd/server.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index 9943a911c3..d23bc2918a 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -186,18 +186,15 @@ static int nbd_negotiate_send_rep(NBDClient *client, uint32_t type,

 /* Send an error reply.
  * Return -errno on error, 0 on success. */
-static int GCC_FMT_ATTR(4, 5)
-nbd_negotiate_send_rep_err(NBDClient *client, uint32_t type,
-                           Error **errp, const char *fmt, ...)
+static int GCC_FMT_ATTR(4, 0)
+nbd_negotiate_send_rep_verr(NBDClient *client, uint32_t type,
+                            Error **errp, const char *fmt, va_list va)
 {
-    va_list va;
     char *msg;
     int ret;
     size_t len;

-    va_start(va, fmt);
     msg = g_strdup_vprintf(fmt, va);
-    va_end(va);
     len = strlen(msg);
     assert(len < 4096);
     trace_nbd_negotiate_send_rep_err(msg);
@@ -217,6 +214,21 @@ out:
     return ret;
 }

+/* Send an error reply.
+ * Return -errno on error, 0 on success. */
+static int GCC_FMT_ATTR(4, 5)
+nbd_negotiate_send_rep_err(NBDClient *client, uint32_t type,
+                           Error **errp, const char *fmt, ...)
+{
+    va_list va;
+    int ret;
+
+    va_start(va, fmt);
+    ret = nbd_negotiate_send_rep_verr(client, type, errp, fmt, va);
+    va_end(va);
+    return ret;
+}
+
 /* Send a single NBD_REP_SERVER reply to NBD_OPT_LIST, including payload.
  * Return -errno on error, 0 on success. */
 static int nbd_negotiate_send_rep_list(NBDClient *client, NBDExport *exp,
-- 
2.14.3
