Received: from eggs.gnu.org ([2001:4830:134:3::10]:56327)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eRhyG-0004Yq-B6
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:15:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eRhyC-0007Aw-Pk
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:15:56 -0500
Received: from mail-wr0-x234.google.com ([2a00:1450:400c:c0c::234]:34283)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eRhyC-0007AQ-G1
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:15:52 -0500
Received: by mail-wr0-x234.google.com with SMTP id y21so22926268wrc.1
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 09:15:52 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 20 Dec 2017 18:14:28 +0100
Message-Id: <1513790098-9815-17-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1513790098-9815-1-git-send-email-pbonzini@redhat.com>
References: <1513790098-9815-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 16/46] sockets: remove obsolete code that
 updated listen address
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: "Daniel P. Berrange" <berrange@redhat.com>

When listening on unix/tcp sockets there was optional code that would update
the original SocketAddress struct with the info about the actual address that
was listened on. Since the conversion of everything to QIOChannelSocket, no
remaining caller made use of this feature. It has been replaced with the ability
to query the listen address after the fact using the function
qio_channel_socket_get_local_address. This is a better model when the input
address can result in listening on multiple distinct sockets.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Message-Id: <20171212111219.32601-1-berrange@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qemu/sockets.h |  2 +-
 qga/channel-posix.c    |  2 +-
 util/qemu-sockets.c    | 31 +++++--------------------------
 3 files changed, 7 insertions(+), 28 deletions(-)

diff --git a/include/qemu/sockets.h b/include/qemu/sockets.h
index 4f7311b..8889bcb 100644
--- a/include/qemu/sockets.h
+++ b/include/qemu/sockets.h
@@ -35,7 +35,7 @@ int inet_connect_saddr(InetSocketAddress *saddr, Error **errp);
 
 NetworkAddressFamily inet_netfamily(int family);
 
-int unix_listen(const char *path, char *ostr, int olen, Error **errp);
+int unix_listen(const char *path, Error **errp);
 int unix_connect(const char *path, Error **errp);
 
 SocketAddress *socket_parse(const char *str, Error **errp);
diff --git a/qga/channel-posix.c b/qga/channel-posix.c
index 3f34465..b812bf4 100644
--- a/qga/channel-posix.c
+++ b/qga/channel-posix.c
@@ -190,7 +190,7 @@ static gboolean ga_channel_open(GAChannel *c, const gchar *path,
         if (fd < 0) {
             Error *local_err = NULL;
 
-            fd = unix_listen(path, NULL, strlen(path), &local_err);
+            fd = unix_listen(path, &local_err);
             if (local_err != NULL) {
                 g_critical("%s", error_get_pretty(local_err));
                 error_free(local_err);
diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index af4f012..d6a1e17 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -198,7 +198,6 @@ static int try_bind(int socket, InetSocketAddress *saddr, struct addrinfo *e)
 
 static int inet_listen_saddr(InetSocketAddress *saddr,
                              int port_offset,
-                             bool update_addr,
                              Error **errp)
 {
     struct addrinfo ai,*res,*e;
@@ -326,15 +325,6 @@ listen_failed:
     return -1;
 
 listen_ok:
-    if (update_addr) {
-        g_free(saddr->host);
-        saddr->host = g_strdup(uaddr);
-        g_free(saddr->port);
-        saddr->port = g_strdup_printf("%d",
-                                      inet_getport(e) - port_offset);
-        saddr->has_ipv6 = saddr->ipv6 = e->ai_family == PF_INET6;
-        saddr->has_ipv4 = saddr->ipv4 = e->ai_family != PF_INET6;
-    }
     freeaddrinfo(res);
     return slisten;
 }
@@ -790,7 +780,6 @@ static int vsock_parse(VsockSocketAddress *addr, const char *str,
 #ifndef _WIN32
 
 static int unix_listen_saddr(UnixSocketAddress *saddr,
-                             bool update_addr,
                              Error **errp)
 {
     struct sockaddr_un un;
@@ -855,12 +844,7 @@ static int unix_listen_saddr(UnixSocketAddress *saddr,
         goto err;
     }
 
-    if (update_addr && pathbuf) {
-        g_free(saddr->path);
-        saddr->path = pathbuf;
-    } else {
-        g_free(pathbuf);
-    }
+    g_free(pathbuf);
     return sock;
 
 err:
@@ -920,7 +904,6 @@ static int unix_connect_saddr(UnixSocketAddress *saddr, Error **errp)
 #else
 
 static int unix_listen_saddr(UnixSocketAddress *saddr,
-                             bool update_addr,
                              Error **errp)
 {
     error_setg(errp, "unix sockets are not available on windows");
@@ -937,7 +920,7 @@ static int unix_connect_saddr(UnixSocketAddress *saddr, Error **errp)
 #endif
 
 /* compatibility wrapper */
-int unix_listen(const char *str, char *ostr, int olen, Error **errp)
+int unix_listen(const char *str, Error **errp)
 {
     char *path, *optstr;
     int sock, len;
@@ -957,11 +940,7 @@ int unix_listen(const char *str, char *ostr, int olen, Error **errp)
         saddr->path = g_strdup(str);
     }
 
-    sock = unix_listen_saddr(saddr, true, errp);
-
-    if (sock != -1 && ostr) {
-        snprintf(ostr, olen, "%s%s", saddr->path, optstr ? optstr : "");
-    }
+    sock = unix_listen_saddr(saddr, errp);
 
     qapi_free_UnixSocketAddress(saddr);
     return sock;
@@ -1052,11 +1031,11 @@ int socket_listen(SocketAddress *addr, Error **errp)
 
     switch (addr->type) {
     case SOCKET_ADDRESS_TYPE_INET:
-        fd = inet_listen_saddr(&addr->u.inet, 0, false, errp);
+        fd = inet_listen_saddr(&addr->u.inet, 0, errp);
         break;
 
     case SOCKET_ADDRESS_TYPE_UNIX:
-        fd = unix_listen_saddr(&addr->u.q_unix, false, errp);
+        fd = unix_listen_saddr(&addr->u.q_unix, errp);
         break;
 
     case SOCKET_ADDRESS_TYPE_FD:
-- 
1.8.3.1
