Received: from eggs.gnu.org ([2001:4830:134:3::10]:44105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d80Ab-00085J-0s
	for qemu-devel@nongnu.org; Tue, 09 May 2017 04:06:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d80AV-0007Yy-FQ
	for qemu-devel@nongnu.org; Tue, 09 May 2017 04:06:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38540)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1d80AV-0007Xv-70
	for qemu-devel@nongnu.org; Tue, 09 May 2017 04:06:51 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 42700D7141
	for <qemu-devel@nongnu.org>; Tue,  9 May 2017 08:06:50 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-149.ams2.redhat.com
	[10.36.116.149])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 0B7C853C35
	for <qemu-devel@nongnu.org>; Tue,  9 May 2017 08:06:50 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue,  9 May 2017 10:06:36 +0200
Message-Id: <1494317205-2211-20-git-send-email-armbru@redhat.com>
In-Reply-To: <1494317205-2211-1-git-send-email-armbru@redhat.com>
References: <1494317205-2211-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL v3 19/28] sockets: Delete unused helper
 socket_address_crumple()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <1493192202-3184-8-git-send-email-armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
[Commit message typo fixed]
---
 include/qemu/sockets.h | 11 -----------
 util/qemu-sockets.c    | 31 -------------------------------
 2 files changed, 42 deletions(-)

diff --git a/include/qemu/sockets.h b/include/qemu/sockets.h
index a0b5cae..5c326db 100644
--- a/include/qemu/sockets.h
+++ b/include/qemu/sockets.h
@@ -121,17 +121,6 @@ SocketAddress *socket_remote_address(int fd, Error **errp);
 char *socket_address_to_string(struct SocketAddress *addr, Error **errp);
 
 /**
- * socket_address_crumple:
- * @addr_flat: the socket address to crumple
- *
- * Convert SocketAddress to SocketAddressLegacy.  Caller is responsible
- * for freeing with qapi_free_SocketAddressLegacy().
- *
- * Returns: the argument converted to SocketAddressLegacy.
- */
-SocketAddressLegacy *socket_address_crumple(SocketAddress *addr);
-
-/**
  * socket_address_flatten:
  * @addr: the socket address to flatten
  *
diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index 9e65ebe..d8183f7 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -1336,37 +1336,6 @@ char *socket_address_to_string(struct SocketAddress *addr, Error **errp)
     return buf;
 }
 
-SocketAddressLegacy *socket_address_crumple(SocketAddress *addr_flat)
-{
-    SocketAddressLegacy *addr = g_new(SocketAddressLegacy, 1);
-
-    switch (addr_flat->type) {
-    case SOCKET_ADDRESS_TYPE_INET:
-        addr->type = SOCKET_ADDRESS_LEGACY_KIND_INET;
-        addr->u.inet.data = QAPI_CLONE(InetSocketAddress,
-                                       &addr_flat->u.inet);
-        break;
-    case SOCKET_ADDRESS_TYPE_UNIX:
-        addr->type = SOCKET_ADDRESS_LEGACY_KIND_UNIX;
-        addr->u.q_unix.data = QAPI_CLONE(UnixSocketAddress,
-                                         &addr_flat->u.q_unix);
-        break;
-    case SOCKET_ADDRESS_TYPE_VSOCK:
-        addr->type = SOCKET_ADDRESS_LEGACY_KIND_VSOCK;
-        addr->u.vsock.data = QAPI_CLONE(VsockSocketAddress,
-                                        &addr_flat->u.vsock);
-        break;
-    case SOCKET_ADDRESS_TYPE_FD:
-        addr->type = SOCKET_ADDRESS_LEGACY_KIND_FD;
-        addr->u.fd.data = QAPI_CLONE(String, &addr_flat->u.fd);
-        break;
-    default:
-        abort();
-    }
-
-    return addr;
-}
-
 SocketAddress *socket_address_flatten(SocketAddressLegacy *addr_legacy)
 {
     SocketAddress *addr = g_new(SocketAddress, 1);
-- 
2.7.4
