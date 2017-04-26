Received: from eggs.gnu.org ([2001:4830:134:3::10]:36825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d3HVP-0003C7-0R
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 03:36:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d3HVN-0005er-Uv
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 03:36:55 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 26 Apr 2017 09:36:36 +0200
Message-Id: <1493192202-3184-2-git-send-email-armbru@redhat.com>
In-Reply-To: <1493192202-3184-1-git-send-email-armbru@redhat.com>
References: <1493192202-3184-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 1/7] sockets: Prepare vsock_parse() for
 flattened SocketAddress
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, kraxel@redhat.com, pbonzini@redhat.com, eblake@redhat.com, qemu-block@nongnu.org

I'm going to flatten SocketAddress: rename SocketAddress to
SocketAddressLegacy, SocketAddressFlat to SocketAddress, eliminate
SocketAddressLegacy except in external interfaces.

vsock_parse() returns a newly allocated VsockSocketAddress.  Lift the
allocation from vsock_parse() into its caller socket_parse() to
prepare for flattening SocketAddress.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 util/qemu-sockets.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index 8188d9a..1abe095 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -793,26 +793,25 @@ static int vsock_listen_saddr(VsockSocketAddress *vaddr,
     return slisten;
 }
 
-static VsockSocketAddress *vsock_parse(const char *str, Error **errp)
+static int vsock_parse(VsockSocketAddress *addr, const char *str,
+                       Error **errp)
 {
-    VsockSocketAddress *addr = NULL;
     char cid[33];
     char port[33];
     int n;
 
     if (sscanf(str, "%32[^:]:%32[^,]%n", cid, port, &n) != 2) {
         error_setg(errp, "error parsing address '%s'", str);
-        return NULL;
+        return -1;
     }
     if (str[n] != '\0') {
         error_setg(errp, "trailing characters in address '%s'", str);
-        return NULL;
+        return -1;
     }
 
-    addr = g_new0(VsockSocketAddress, 1);
     addr->cid = g_strdup(cid);
     addr->port = g_strdup(port);
-    return addr;
+    return 0;
 }
 #else
 static void vsock_unsupported(Error **errp)
@@ -835,10 +834,11 @@ static int vsock_listen_saddr(VsockSocketAddress *vaddr,
     return -1;
 }
 
-static VsockSocketAddress *vsock_parse(const char *str, Error **errp)
+static int vsock_parse(VsockSocketAddress *addr, const char *str,
+                        Error **errp)
 {
     vsock_unsupported(errp);
-    return NULL;
+    return -1;
 }
 #endif /* CONFIG_AF_VSOCK */
 
@@ -1060,8 +1060,8 @@ SocketAddress *socket_parse(const char *str, Error **errp)
         }
     } else if (strstart(str, "vsock:", NULL)) {
         addr->type = SOCKET_ADDRESS_KIND_VSOCK;
-        addr->u.vsock.data = vsock_parse(str + strlen("vsock:"), errp);
-        if (addr->u.vsock.data == NULL) {
+        addr->u.vsock.data = g_new(VsockSocketAddress, 1);
+        if (vsock_parse(addr->u.vsock.data, str + strlen("vsock:"), errp)) {
             goto fail;
         }
     } else {
-- 
2.7.4
