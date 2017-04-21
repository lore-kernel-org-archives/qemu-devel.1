Received: from eggs.gnu.org ([2001:4830:134:3::10]:54026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d1Xei-00029Z-55
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 08:27:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d1Xeg-0000cK-Op
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 08:27:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37354)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1d1Xeg-0000bj-Fs
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 08:27:18 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7B120C04B326
	for <qemu-devel@nongnu.org>; Fri, 21 Apr 2017 12:27:17 +0000 (UTC)
From: Fam Zheng <famz@redhat.com>
Date: Fri, 21 Apr 2017 20:26:58 +0800
Message-Id: <20170421122710.15373-3-famz@redhat.com>
In-Reply-To: <20170421122710.15373-1-famz@redhat.com>
References: <20170421122710.15373-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH 02/14] socket: Make errp the last parameter of
 inet_connect_saddr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/ssh.c            | 2 +-
 include/qemu/sockets.h | 5 +++--
 util/qemu-sockets.c    | 9 +++++----
 3 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/block/ssh.c b/block/ssh.c
index 471ba8a..df09f6c 100644
--- a/block/ssh.c
+++ b/block/ssh.c
@@ -681,7 +681,7 @@ static int connect_to_ssh(BDRVSSHState *s, QDict *options,
     }
 
     /* Open the socket and connect. */
-    s->sock = inet_connect_saddr(s->inet, errp, NULL, NULL);
+    s->sock = inet_connect_saddr(s->inet, NULL, NULL, errp);
     if (s->sock < 0) {
         ret = -EIO;
         goto err;
diff --git a/include/qemu/sockets.h b/include/qemu/sockets.h
index 567eef1..af28532 100644
--- a/include/qemu/sockets.h
+++ b/include/qemu/sockets.h
@@ -36,8 +36,9 @@ int inet_ai_family_from_address(InetSocketAddress *addr,
                                 Error **errp);
 InetSocketAddress *inet_parse(const char *str, Error **errp);
 int inet_connect(const char *str, Error **errp);
-int inet_connect_saddr(InetSocketAddress *saddr, Error **errp,
-                       NonBlockingConnectHandler *callback, void *opaque);
+int inet_connect_saddr(InetSocketAddress *saddr,
+                       NonBlockingConnectHandler *callback, void *opaque,
+                       Error **errp);
 
 NetworkAddressFamily inet_netfamily(int family);
 
diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index f79d334..8e11349 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -427,8 +427,9 @@ static struct addrinfo *inet_parse_connect_saddr(InetSocketAddress *saddr,
  * function succeeds, callback will be called when the connection
  * completes, with the file descriptor on success, or -1 on error.
  */
-int inet_connect_saddr(InetSocketAddress *saddr, Error **errp,
-                       NonBlockingConnectHandler *callback, void *opaque)
+int inet_connect_saddr(InetSocketAddress *saddr,
+                       NonBlockingConnectHandler *callback, void *opaque,
+                       Error **errp)
 {
     Error *local_err = NULL;
     struct addrinfo *res, *e;
@@ -659,7 +660,7 @@ int inet_connect(const char *str, Error **errp)
 
     addr = inet_parse(str, errp);
     if (addr != NULL) {
-        sock = inet_connect_saddr(addr, errp, NULL, NULL);
+        sock = inet_connect_saddr(addr, NULL, NULL, errp);
         qapi_free_InetSocketAddress(addr);
     }
     return sock;
@@ -1081,7 +1082,7 @@ int socket_connect(SocketAddress *addr, NonBlockingConnectHandler *callback,
 
     switch (addr->type) {
     case SOCKET_ADDRESS_KIND_INET:
-        fd = inet_connect_saddr(addr->u.inet.data, errp, callback, opaque);
+        fd = inet_connect_saddr(addr->u.inet.data, callback, opaque, errp);
         break;
 
     case SOCKET_ADDRESS_KIND_UNIX:
-- 
2.9.3
