Received: from eggs.gnu.org ([2001:4830:134:3::10]:55340)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eiif5-0006Dz-RS
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 10:26:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eiif4-0002D6-Bw
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 10:26:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50922)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eiif4-0002Bb-2P
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 10:26:26 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5FF9210F3D6
	for <qemu-devel@nongnu.org>; Mon,  5 Feb 2018 15:26:25 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Mon,  5 Feb 2018 15:24:51 +0000
Message-Id: <20180205152455.12088-6-berrange@redhat.com>
In-Reply-To: <20180205152455.12088-1-berrange@redhat.com>
References: <20180205152455.12088-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v4 5/9] sockets: move fd_is_socket() into
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

From: "Daniel P. Berrange" <berrange@redhat.com>

The fd_is_socket() helper method is useful in a few places, so put it in
the common sockets code. Make the code more compact while moving it.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 include/qemu/sockets.h    |  1 +
 io/channel-util.c         | 13 --------
 tests/.gitignore          |  1 +
 tests/Makefile.include    |  3 ++
 tests/test-util-sockets.c | 77 +++++++++++++++++++++++++++++++++++++++++++++++
 util/qemu-sockets.c       |  8 +++++
 6 files changed, 90 insertions(+), 13 deletions(-)
 create mode 100644 tests/test-util-sockets.c

diff --git a/include/qemu/sockets.h b/include/qemu/sockets.h
index 8889bcb1ec..88777590dd 100644
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
diff --git a/tests/.gitignore b/tests/.gitignore
index e5c744b7ed..e2e3f71db7 100644
--- a/tests/.gitignore
+++ b/tests/.gitignore
@@ -87,6 +87,7 @@ test-thread-pool
 test-throttle
 test-timed-average
 test-uuid
+test-util-sockets
 test-visitor-serialization
 test-vmstate
 test-write-threshold
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 7bfdabeb6d..c2b51ef93c 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -136,6 +136,7 @@ ifneq (,$(findstring qemu-ga,$(TOOLS)))
 check-unit-$(CONFIG_LINUX) += tests/test-qga$(EXESUF)
 endif
 check-unit-y += tests/test-timed-average$(EXESUF)
+check-unit-y += tests/test-util-sockets$(EXESUF)
 check-unit-y += tests/test-io-task$(EXESUF)
 check-unit-y += tests/test-io-channel-socket$(EXESUF)
 check-unit-y += tests/test-io-channel-file$(EXESUF)
@@ -706,6 +707,8 @@ tests/test-crypto-tlscredsx509$(EXESUF): tests/test-crypto-tlscredsx509.o \
 tests/test-crypto-tlssession.o-cflags := $(TASN1_CFLAGS)
 tests/test-crypto-tlssession$(EXESUF): tests/test-crypto-tlssession.o \
 	tests/crypto-tls-x509-helpers.o tests/pkix_asn1_tab.o $(test-crypto-obj-y)
+tests/test-util-sockets$(EXESUF): tests/test-util-sockets.o \
+	tests/socket-helpers.o $(test-util-obj-y)
 tests/test-io-task$(EXESUF): tests/test-io-task.o $(test-io-obj-y)
 tests/test-io-channel-socket$(EXESUF): tests/test-io-channel-socket.o \
         tests/io-channel-helpers.o tests/socket-helpers.o $(test-io-obj-y)
diff --git a/tests/test-util-sockets.c b/tests/test-util-sockets.c
new file mode 100644
index 0000000000..65190e0530
--- /dev/null
+++ b/tests/test-util-sockets.c
@@ -0,0 +1,77 @@
+/*
+ * Tests for util/qemu-sockets.c
+ *
+ * Copyright 2018 Red Hat, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this library; if not, see <http://www.gnu.org/licenses/>.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "qemu/sockets.h"
+#include "qapi/error.h"
+#include "socket-helpers.h"
+
+static void test_fd_is_socket_bad(void)
+{
+    char *tmp = g_strdup("qemu-test-util-sockets-XXXXXX");
+    int fd = mkstemp(tmp);
+    if (fd != 0) {
+        unlink(tmp);
+    }
+    g_free(tmp);
+
+    g_assert(fd >= 0);
+
+    g_assert(!fd_is_socket(fd));
+    close(fd);
+}
+
+static void test_fd_is_socket_good(void)
+{
+    int fd = qemu_socket(PF_INET, SOCK_STREAM, 0);
+
+    g_assert(fd >= 0);
+
+    g_assert(fd_is_socket(fd));
+    close(fd);
+}
+
+int main(int argc, char **argv)
+{
+    bool has_ipv4, has_ipv6;
+
+    socket_init();
+
+    g_test_init(&argc, &argv, NULL);
+
+    /* We're creating actual IPv4/6 sockets, so we should
+     * check if the host running tests actually supports
+     * each protocol to avoid breaking tests on machines
+     * with either IPv4 or IPv6 disabled.
+     */
+    if (socket_check_protocol_support(&has_ipv4, &has_ipv6) < 0) {
+        return 1;
+    }
+
+    if (has_ipv4) {
+        g_test_add_func("/util/socket/is-socket/bad",
+                        test_fd_is_socket_bad);
+        g_test_add_func("/util/socket/is-socket/good",
+                        test_fd_is_socket_good);
+    }
+
+    return g_test_run();
+}
diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index d6a1e1759e..3e36584a00 100644
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
