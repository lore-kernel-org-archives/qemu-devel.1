Received: from eggs.gnu.org ([2001:4830:134:3::10]:39705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1evTp0-0004FO-E4
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 16:13:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1evTox-00075W-D4
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 16:13:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35846 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1evTox-00075K-7O
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 16:13:23 -0400
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Mon, 12 Mar 2018 20:13:01 +0000
Message-Id: <20180312201305.16972-6-berrange@redhat.com>
In-Reply-To: <20180312201305.16972-1-berrange@redhat.com>
References: <20180312201305.16972-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 5/9] sockets: move fd_is_socket() into common
 sockets code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

From: "Daniel P. Berrange" <berrange@redhat.com>

The fd_is_socket() helper method is useful in a few places, so put it in
the common sockets code. Make the code more compact while moving it.

Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 include/qemu/sockets.h    |  1 +
 io/channel-util.c         | 13 --------
 tests/.gitignore          |  1 +
 tests/Makefile.include    |  3 ++
 tests/test-util-sockets.c | 77 +++++++++++++++++++++++++++++++++++++++++=
++++++
 util/qemu-sockets.c       |  8 +++++
 6 files changed, 90 insertions(+), 13 deletions(-)
 create mode 100644 tests/test-util-sockets.c

diff --git a/include/qemu/sockets.h b/include/qemu/sockets.h
index e88d4c37ab..8140fea685 100644
--- a/include/qemu/sockets.h
+++ b/include/qemu/sockets.h
@@ -12,6 +12,7 @@ int inet_aton(const char *cp, struct in_addr *ia);
 #include "qapi/qapi-types-sockets.h"
=20
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
=20
=20
-static bool fd_is_socket(int fd)
-{
-    int optval;
-    socklen_t optlen;
-    optlen =3D sizeof(optval);
-    return qemu_getsockopt(fd,
-                           SOL_SOCKET,
-                           SO_TYPE,
-                           (char *)&optval,
-                           &optlen) =3D=3D 0;
-}
-
-
 QIOChannel *qio_channel_new_fd(int fd,
                                Error **errp)
 {
diff --git a/tests/.gitignore b/tests/.gitignore
index 18e58b2183..fb62d2299b 100644
--- a/tests/.gitignore
+++ b/tests/.gitignore
@@ -86,6 +86,7 @@ test-thread-pool
 test-throttle
 test-timed-average
 test-uuid
+test-util-sockets
 test-visitor-serialization
 test-vmstate
 test-write-threshold
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 3d5b6174a8..42fd426cd0 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -146,6 +146,7 @@ ifneq (,$(findstring qemu-ga,$(TOOLS)))
 check-unit-$(CONFIG_LINUX) +=3D tests/test-qga$(EXESUF)
 endif
 check-unit-y +=3D tests/test-timed-average$(EXESUF)
+check-unit-y +=3D tests/test-util-sockets$(EXESUF)
 check-unit-y +=3D tests/test-io-task$(EXESUF)
 check-unit-y +=3D tests/test-io-channel-socket$(EXESUF)
 check-unit-y +=3D tests/test-io-channel-file$(EXESUF)
@@ -713,6 +714,8 @@ tests/test-crypto-tlscredsx509$(EXESUF): tests/test-c=
rypto-tlscredsx509.o \
 tests/test-crypto-tlssession.o-cflags :=3D $(TASN1_CFLAGS)
 tests/test-crypto-tlssession$(EXESUF): tests/test-crypto-tlssession.o \
 	tests/crypto-tls-x509-helpers.o tests/pkix_asn1_tab.o $(test-crypto-obj=
-y)
+tests/test-util-sockets$(EXESUF): tests/test-util-sockets.o \
+	tests/socket-helpers.o $(test-util-obj-y)
 tests/test-io-task$(EXESUF): tests/test-io-task.o $(test-io-obj-y)
 tests/test-io-channel-socket$(EXESUF): tests/test-io-channel-socket.o \
         tests/io-channel-helpers.o tests/socket-helpers.o $(test-io-obj-=
y)
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
+    char *tmp =3D g_strdup("qemu-test-util-sockets-XXXXXX");
+    int fd =3D mkstemp(tmp);
+    if (fd !=3D 0) {
+        unlink(tmp);
+    }
+    g_free(tmp);
+
+    g_assert(fd >=3D 0);
+
+    g_assert(!fd_is_socket(fd));
+    close(fd);
+}
+
+static void test_fd_is_socket_good(void)
+{
+    int fd =3D qemu_socket(PF_INET, SOCK_STREAM, 0);
+
+    g_assert(fd >=3D 0);
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
index 7f13e8a338..fa79471647 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -91,6 +91,14 @@ NetworkAddressFamily inet_netfamily(int family)
     return NETWORK_ADDRESS_FAMILY_UNKNOWN;
 }
=20
+bool fd_is_socket(int fd)
+{
+    int optval;
+    socklen_t optlen =3D sizeof(optval);
+    return !qemu_getsockopt(fd, SOL_SOCKET, SO_TYPE, &optval, &optlen);
+}
+
+
 /*
  * Matrix we're trying to apply
  *
--=20
2.14.3
