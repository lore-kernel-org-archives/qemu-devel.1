Received: from eggs.gnu.org ([2001:4830:134:3::10]:56369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d6Ic2-00025y-Rp
	for qemu-devel@nongnu.org; Thu, 04 May 2017 11:24:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d6Ic0-0008Jt-6k
	for qemu-devel@nongnu.org; Thu, 04 May 2017 11:24:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41732)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1d6Ibz-0008Ia-Si
	for qemu-devel@nongnu.org; Thu, 04 May 2017 11:24:12 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E4F7861E4A
	for <qemu-devel@nongnu.org>; Thu,  4 May 2017 15:24:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-149.ams2.redhat.com
	[10.36.116.149])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B02E917963
	for <qemu-devel@nongnu.org>; Thu,  4 May 2017 15:24:10 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu,  4 May 2017 17:23:50 +0200
Message-Id: <1493911445-19568-14-git-send-email-armbru@redhat.com>
In-Reply-To: <1493911445-19568-1-git-send-email-armbru@redhat.com>
References: <1493911445-19568-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 13/28] sockets: Prepare vsock_parse() for
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

I'm going to flatten SocketAddress: rename SocketAddress to
SocketAddressLegacy, SocketAddressFlat to SocketAddress, eliminate
SocketAddressLegacy except in external interfaces.

vsock_parse() returns a newly allocated VsockSocketAddress.  Lift the
allocation from vsock_parse() into its caller socket_parse() to
prepare for flattening SocketAddress.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <1493192202-3184-2-git-send-email-armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
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
