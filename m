Received: from eggs.gnu.org ([2001:4830:134:3::10]:41683)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1evMtr-00057j-KG
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 08:50:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1evMtn-0007lz-Ie
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 08:49:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48444 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1evMtn-0007lE-Cr
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 08:49:55 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E4FD4401C9AE
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 12:49:54 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Mon, 12 Mar 2018 12:49:34 +0000
Message-Id: <20180312124939.20562-5-berrange@redhat.com>
In-Reply-To: <20180312124939.20562-1-berrange@redhat.com>
References: <20180312124939.20562-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 4/9] sockets: strengthen test suite IP
 protocol availability checks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

From: "Daniel P. Berrange" <berrange@redhat.com>

Instead of just checking whether it is possible to bind() on a socket, al=
so
check that we can successfully connect() to the socket we bound to. This
more closely replicates the level of functionality that tests will actual=
ly
use.

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 tests/socket-helpers.c | 67 +++++++++++++++++++++++++++++++++++++++++++-=
------
 tests/socket-helpers.h |  4 +--
 2 files changed, 60 insertions(+), 11 deletions(-)

diff --git a/tests/socket-helpers.c b/tests/socket-helpers.c
index 13b6bb38eb..161aa5da09 100644
--- a/tests/socket-helpers.c
+++ b/tests/socket-helpers.c
@@ -30,10 +30,15 @@
 # define EAI_ADDRFAMILY 0
 #endif
=20
-int socket_can_bind(const char *hostname)
+int socket_can_bind_connect(const char *hostname)
 {
-    int fd =3D -1;
+    int lfd =3D -1, cfd =3D -1, afd =3D -1;
     struct addrinfo ai, *res =3D NULL;
+    struct sockaddr_storage ss;
+    socklen_t sslen =3D sizeof(ss);
+    int soerr;
+    socklen_t soerrlen =3D sizeof(soerr);
+    bool check_soerr =3D false;
     int rc;
     int ret =3D -1;
=20
@@ -54,24 +59,68 @@ int socket_can_bind(const char *hostname)
         goto cleanup;
     }
=20
-    fd =3D qemu_socket(res->ai_family, res->ai_socktype, res->ai_protoco=
l);
-    if (fd < 0) {
+    lfd =3D qemu_socket(res->ai_family, res->ai_socktype, res->ai_protoc=
ol);
+    if (lfd < 0) {
         goto cleanup;
     }
=20
-    if (bind(fd, res->ai_addr, res->ai_addrlen) < 0) {
+    cfd =3D qemu_socket(res->ai_family, res->ai_socktype, res->ai_protoc=
ol);
+    if (cfd < 0) {
+        goto cleanup;
+    }
+
+    if (bind(lfd, res->ai_addr, res->ai_addrlen) < 0) {
         if (errno =3D=3D EADDRNOTAVAIL) {
             goto done;
         }
         goto cleanup;
     }
=20
+    if (listen(lfd, 1) < 0) {
+        goto cleanup;
+    }
+
+    if (getsockname(lfd, (struct sockaddr *)&ss, &sslen) < 0) {
+        goto cleanup;
+    }
+
+    qemu_set_nonblock(cfd);
+    if (connect(cfd, (struct sockaddr *)&ss, sslen) < 0) {
+        if (errno =3D=3D EINPROGRESS) {
+            check_soerr =3D true;
+        } else {
+            goto cleanup;
+        }
+    }
+
+    sslen =3D sizeof(ss);
+    afd =3D accept(lfd,  (struct sockaddr *)&ss, &sslen);
+    if (afd < 0) {
+        goto cleanup;
+    }
+
+    if (check_soerr) {
+        if (qemu_getsockopt(cfd, SOL_SOCKET, SO_ERROR, &soerr, &soerrlen=
) < 0) {
+            goto cleanup;
+        }
+        if (soerr) {
+            errno =3D soerr;
+            goto cleanup;
+        }
+    }
+
  done:
     ret =3D 0;
=20
  cleanup:
-    if (fd !=3D -1) {
-        close(fd);
+    if (afd !=3D -1) {
+        close(afd);
+    }
+    if (cfd !=3D -1) {
+        close(cfd);
+    }
+    if (lfd !=3D -1) {
+        close(lfd);
     }
     if (res) {
         freeaddrinfo(res);
@@ -84,7 +133,7 @@ int socket_check_protocol_support(bool *has_ipv4, bool=
 *has_ipv6)
 {
     *has_ipv4 =3D *has_ipv6 =3D false;
=20
-    if (socket_can_bind("127.0.0.1") < 0) {
+    if (socket_can_bind_connect("127.0.0.1") < 0) {
         if (errno !=3D EADDRNOTAVAIL) {
             return -1;
         }
@@ -92,7 +141,7 @@ int socket_check_protocol_support(bool *has_ipv4, bool=
 *has_ipv6)
         *has_ipv4 =3D true;
     }
=20
-    if (socket_can_bind("::1") < 0) {
+    if (socket_can_bind_connect("::1") < 0) {
         if (errno !=3D EADDRNOTAVAIL) {
             return -1;
         }
diff --git a/tests/socket-helpers.h b/tests/socket-helpers.h
index efa96eddc2..1c07d6d656 100644
--- a/tests/socket-helpers.h
+++ b/tests/socket-helpers.h
@@ -21,13 +21,13 @@
 /*
  * @hostname: a DNS name or numeric IP address
  *
- * Check whether it is possible to bind to ports
+ * Check whether it is possible to bind & connect to ports
  * on the DNS name or IP address @hostname. If an IP address
  * is used, it must not be a wildcard address.
  *
  * Returns 0 on success, -1 on error with errno set
  */
-int socket_can_bind(const char *hostname);
+int socket_can_bind_connect(const char *hostname);
=20
 /*
  * @has_ipv4: set to true on return if IPv4 is available
--=20
2.14.3
