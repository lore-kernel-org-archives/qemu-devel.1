Received: from eggs.gnu.org ([2001:4830:134:3::10]:55284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eiif0-00068U-OS
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 10:26:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eiiew-0001xq-J4
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 10:26:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55720)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eiiew-0001wK-AJ
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 10:26:18 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 928508CF55
	for <qemu-devel@nongnu.org>; Mon,  5 Feb 2018 15:26:17 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Mon,  5 Feb 2018 15:24:49 +0000
Message-Id: <20180205152455.12088-4-berrange@redhat.com>
In-Reply-To: <20180205152455.12088-1-berrange@redhat.com>
References: <20180205152455.12088-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 3/9] sockets: pull code for testing IP
 availability out of specific test
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

The test-io-channel-socket.c file has some useful helper functions for
checking if a specific IP protocol is available. Other tests need to
perform similar kinds of checks to avoid running tests that will fail
due to missing IP protocols.

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 tests/Makefile.include         |   2 +-
 tests/socket-helpers.c         | 104 +++++++++++++++++++++++++++++++++++=
++++++
 tests/socket-helpers.h         |  42 +++++++++++++++++
 tests/test-io-channel-socket.c |  72 +---------------------------
 4 files changed, 149 insertions(+), 71 deletions(-)
 create mode 100644 tests/socket-helpers.c
 create mode 100644 tests/socket-helpers.h

diff --git a/tests/Makefile.include b/tests/Makefile.include
index ca82e0c0cc..7bfdabeb6d 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -708,7 +708,7 @@ tests/test-crypto-tlssession$(EXESUF): tests/test-cry=
pto-tlssession.o \
 	tests/crypto-tls-x509-helpers.o tests/pkix_asn1_tab.o $(test-crypto-obj=
-y)
 tests/test-io-task$(EXESUF): tests/test-io-task.o $(test-io-obj-y)
 tests/test-io-channel-socket$(EXESUF): tests/test-io-channel-socket.o \
-        tests/io-channel-helpers.o $(test-io-obj-y)
+        tests/io-channel-helpers.o tests/socket-helpers.o $(test-io-obj-=
y)
 tests/tpm-crb-test$(EXESUF): tests/tpm-crb-test.o $(test-io-obj-y)
 tests/test-io-channel-file$(EXESUF): tests/test-io-channel-file.o \
         tests/io-channel-helpers.o $(test-io-obj-y)
diff --git a/tests/socket-helpers.c b/tests/socket-helpers.c
new file mode 100644
index 0000000000..13b6bb38eb
--- /dev/null
+++ b/tests/socket-helpers.c
@@ -0,0 +1,104 @@
+/*
+ * Helper functions for tests using sockets
+ *
+ * Copyright 2015-2018 Red Hat, Inc.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 or
+ * (at your option) version 3 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "qemu/sockets.h"
+#include "socket-helpers.h"
+
+#ifndef AI_ADDRCONFIG
+# define AI_ADDRCONFIG 0
+#endif
+#ifndef EAI_ADDRFAMILY
+# define EAI_ADDRFAMILY 0
+#endif
+
+int socket_can_bind(const char *hostname)
+{
+    int fd =3D -1;
+    struct addrinfo ai, *res =3D NULL;
+    int rc;
+    int ret =3D -1;
+
+    memset(&ai, 0, sizeof(ai));
+    ai.ai_flags =3D AI_CANONNAME | AI_ADDRCONFIG;
+    ai.ai_family =3D AF_UNSPEC;
+    ai.ai_socktype =3D SOCK_STREAM;
+
+    /* lookup */
+    rc =3D getaddrinfo(hostname, NULL, &ai, &res);
+    if (rc !=3D 0) {
+        if (rc =3D=3D EAI_ADDRFAMILY ||
+            rc =3D=3D EAI_FAMILY) {
+            errno =3D EADDRNOTAVAIL;
+            goto done;
+        }
+        errno =3D EINVAL;
+        goto cleanup;
+    }
+
+    fd =3D qemu_socket(res->ai_family, res->ai_socktype, res->ai_protoco=
l);
+    if (fd < 0) {
+        goto cleanup;
+    }
+
+    if (bind(fd, res->ai_addr, res->ai_addrlen) < 0) {
+        if (errno =3D=3D EADDRNOTAVAIL) {
+            goto done;
+        }
+        goto cleanup;
+    }
+
+ done:
+    ret =3D 0;
+
+ cleanup:
+    if (fd !=3D -1) {
+        close(fd);
+    }
+    if (res) {
+        freeaddrinfo(res);
+    }
+    return ret;
+}
+
+
+int socket_check_protocol_support(bool *has_ipv4, bool *has_ipv6)
+{
+    *has_ipv4 =3D *has_ipv6 =3D false;
+
+    if (socket_can_bind("127.0.0.1") < 0) {
+        if (errno !=3D EADDRNOTAVAIL) {
+            return -1;
+        }
+    } else {
+        *has_ipv4 =3D true;
+    }
+
+    if (socket_can_bind("::1") < 0) {
+        if (errno !=3D EADDRNOTAVAIL) {
+            return -1;
+        }
+    } else {
+        *has_ipv6 =3D true;
+    }
+
+    return 0;
+}
diff --git a/tests/socket-helpers.h b/tests/socket-helpers.h
new file mode 100644
index 0000000000..efa96eddc2
--- /dev/null
+++ b/tests/socket-helpers.h
@@ -0,0 +1,42 @@
+/*
+ * Helper functions for tests using sockets
+ *
+ * Copyright 2015-2018 Red Hat, Inc.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 or
+ * (at your option) version 3 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ */
+
+/*
+ * @hostname: a DNS name or numeric IP address
+ *
+ * Check whether it is possible to bind to ports
+ * on the DNS name or IP address @hostname. If an IP address
+ * is used, it must not be a wildcard address.
+ *
+ * Returns 0 on success, -1 on error with errno set
+ */
+int socket_can_bind(const char *hostname);
+
+/*
+ * @has_ipv4: set to true on return if IPv4 is available
+ * @has_ipv6: set to true on return if IPv6 is available
+ *
+ * Check whether IPv4 and/or IPv6 are available for use.
+ * On success, @has_ipv4 and @has_ipv6 will be set to
+ * indicate whether the respective protocols are available.
+ *
+ * Returns 0 on success, -1 on fatal error
+ */
+int socket_check_protocol_support(bool *has_ipv4, bool *has_ipv6);
diff --git a/tests/test-io-channel-socket.c b/tests/test-io-channel-socke=
t.c
index d357cd2a8e..b0b69e8ad0 100644
--- a/tests/test-io-channel-socket.c
+++ b/tests/test-io-channel-socket.c
@@ -22,77 +22,9 @@
 #include "io/channel-socket.h"
 #include "io/channel-util.h"
 #include "io-channel-helpers.h"
+#include "socket-helpers.h"
 #include "qapi/error.h"
=20
-#ifndef AI_ADDRCONFIG
-# define AI_ADDRCONFIG 0
-#endif
-#ifndef EAI_ADDRFAMILY
-# define EAI_ADDRFAMILY 0
-#endif
-
-static int check_bind(const char *hostname, bool *has_proto)
-{
-    int fd =3D -1;
-    struct addrinfo ai, *res =3D NULL;
-    int rc;
-    int ret =3D -1;
-
-    memset(&ai, 0, sizeof(ai));
-    ai.ai_flags =3D AI_CANONNAME | AI_ADDRCONFIG;
-    ai.ai_family =3D AF_UNSPEC;
-    ai.ai_socktype =3D SOCK_STREAM;
-
-    /* lookup */
-    rc =3D getaddrinfo(hostname, NULL, &ai, &res);
-    if (rc !=3D 0) {
-        if (rc =3D=3D EAI_ADDRFAMILY ||
-            rc =3D=3D EAI_FAMILY) {
-            *has_proto =3D false;
-            goto done;
-        }
-        goto cleanup;
-    }
-
-    fd =3D qemu_socket(res->ai_family, res->ai_socktype, res->ai_protoco=
l);
-    if (fd < 0) {
-        goto cleanup;
-    }
-
-    if (bind(fd, res->ai_addr, res->ai_addrlen) < 0) {
-        if (errno =3D=3D EADDRNOTAVAIL) {
-            *has_proto =3D false;
-            goto done;
-        }
-        goto cleanup;
-    }
-
-    *has_proto =3D true;
- done:
-    ret =3D 0;
-
- cleanup:
-    if (fd !=3D -1) {
-        close(fd);
-    }
-    if (res) {
-        freeaddrinfo(res);
-    }
-    return ret;
-}
-
-static int check_protocol_support(bool *has_ipv4, bool *has_ipv6)
-{
-    if (check_bind("127.0.0.1", has_ipv4) < 0) {
-        return -1;
-    }
-    if (check_bind("::1", has_ipv6) < 0) {
-        return -1;
-    }
-
-    return 0;
-}
-
=20
 static void test_io_channel_set_socket_bufs(QIOChannel *src,
                                             QIOChannel *dst)
@@ -566,7 +498,7 @@ int main(int argc, char **argv)
      * each protocol to avoid breaking tests on machines
      * with either IPv4 or IPv6 disabled.
      */
-    if (check_protocol_support(&has_ipv4, &has_ipv6) < 0) {
+    if (socket_check_protocol_support(&has_ipv4, &has_ipv6) < 0) {
         return 1;
     }
=20
--=20
2.14.3
