Received: from eggs.gnu.org ([2001:4830:134:3::10]:47316)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eSNe2-0006Eq-TN
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 08:45:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eSNe2-0002nQ-0x
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 08:45:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33524)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eSNe1-0002mS-QW
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 08:45:49 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E60EC72D88
	for <qemu-devel@nongnu.org>; Fri, 22 Dec 2017 13:45:48 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Fri, 22 Dec 2017 13:45:21 +0000
Message-Id: <20171222134527.14467-3-berrange@redhat.com>
In-Reply-To: <20171222134527.14467-1-berrange@redhat.com>
References: <20171222134527.14467-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v3 2/8] sockets: move fd_is_socket() into
 common sockets code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

The fd_is_socket() helper method is useful in a few places, so put it in
the common sockets code. Make the code more compact while moving it.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 include/qemu/sockets.h |  1 +
 io/channel-util.c      | 13 -------------
 util/qemu-sockets.c    |  8 ++++++++
 3 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/include/qemu/sockets.h b/include/qemu/sockets.h
index 4f7311b52a..5680880f5a 100644
--- a/include/qemu/sockets.h
+++ b/include/qemu/sockets.h
@@ -12,6 +12,7 @@ int inet_aton(const char *cp, struct in_addr *ia);
 #include "qapi-types.h"
 
 /* misc helpers */
+bool fd_is_socket(int fd);
 int qemu_socket(int domain, int type, int protocol);
 int qemu_accept(int s, struct sockaddr *addr, socklen_t *addrlen);
 int socket_set_cork(int fd, int v);
diff --git a/io/channel-util.c b/io/channel-util.c
index 0fb4bd0837..423d79845a 100644
--- a/io/channel-util.c
+++ b/io/channel-util.c
@@ -24,19 +24,6 @@
 #include "io/channel-socket.h"
 
 
-static bool fd_is_socket(int fd)
-{
-    int optval;
-    socklen_t optlen;
-    optlen = sizeof(optval);
-    return qemu_getsockopt(fd,
-                           SOL_SOCKET,
-                           SO_TYPE,
-                           (char *)&optval,
-                           &optlen) == 0;
-}
-
-
 QIOChannel *qio_channel_new_fd(int fd,
                                Error **errp)
 {
diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index af4f01211a..5e42f6d88d 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -91,6 +91,14 @@ NetworkAddressFamily inet_netfamily(int family)
     return NETWORK_ADDRESS_FAMILY_UNKNOWN;
 }
 
+bool fd_is_socket(int fd)
+{
+    int optval;
+    socklen_t optlen = sizeof(optval);
+    return !qemu_getsockopt(fd, SOL_SOCKET, SO_TYPE, &optval, &optlen);
+}
+
+
 /*
  * Matrix we're trying to apply
  *
-- 
2.14.3
