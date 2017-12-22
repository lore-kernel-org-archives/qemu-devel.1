Received: from eggs.gnu.org ([2001:4830:134:3::10]:47578)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eSNeA-0006MF-0r
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 08:45:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eSNe9-0002vA-1C
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 08:45:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44686)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eSNe8-0002uA-Nd
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 08:45:56 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D54A1267C4
	for <qemu-devel@nongnu.org>; Fri, 22 Dec 2017 13:45:55 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Fri, 22 Dec 2017 13:45:23 +0000
Message-Id: <20171222134527.14467-5-berrange@redhat.com>
In-Reply-To: <20171222134527.14467-1-berrange@redhat.com>
References: <20171222134527.14467-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v3 4/8] sockets: strengthen test suite IP
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

Instead of just checking whether it is possible to bind() on a socket, also
check that we can successfully connect() to the socket we bound to. This
more closely replicates the level of functionality that tests will actually
use.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 tests/socket-helpers.c | 67 +++++++++++++++++++++++++++++++++++++++++++-------
 tests/socket-helpers.h |  4 +--
 2 files changed, 60 insertions(+), 11 deletions(-)

diff --git a/tests/socket-helpers.c b/tests/socket-helpers.c
index 13b6bb38eb..161aa5da09 100644
--- a/tests/socket-helpers.c
+++ b/tests/socket-helpers.c
@@ -30,10 +30,15 @@
 # define EAI_ADDRFAMILY 0
 #endif
 
-int socket_can_bind(const char *hostname)
+int socket_can_bind_connect(const char *hostname)
 {
-    int fd = -1;
+    int lfd = -1, cfd = -1, afd = -1;
     struct addrinfo ai, *res = NULL;
+    struct sockaddr_storage ss;
+    socklen_t sslen = sizeof(ss);
+    int soerr;
+    socklen_t soerrlen = sizeof(soerr);
+    bool check_soerr = false;
     int rc;
     int ret = -1;
 
@@ -54,24 +59,68 @@ int socket_can_bind(const char *hostname)
         goto cleanup;
     }
 
-    fd = qemu_socket(res->ai_family, res->ai_socktype, res->ai_protocol);
-    if (fd < 0) {
+    lfd = qemu_socket(res->ai_family, res->ai_socktype, res->ai_protocol);
+    if (lfd < 0) {
         goto cleanup;
     }
 
-    if (bind(fd, res->ai_addr, res->ai_addrlen) < 0) {
+    cfd = qemu_socket(res->ai_family, res->ai_socktype, res->ai_protocol);
+    if (cfd < 0) {
+        goto cleanup;
+    }
+
+    if (bind(lfd, res->ai_addr, res->ai_addrlen) < 0) {
         if (errno == EADDRNOTAVAIL) {
             goto done;
         }
         goto cleanup;
     }
 
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
+        if (errno == EINPROGRESS) {
+            check_soerr = true;
+        } else {
+            goto cleanup;
+        }
+    }
+
+    sslen = sizeof(ss);
+    afd = accept(lfd,  (struct sockaddr *)&ss, &sslen);
+    if (afd < 0) {
+        goto cleanup;
+    }
+
+    if (check_soerr) {
+        if (qemu_getsockopt(cfd, SOL_SOCKET, SO_ERROR, &soerr, &soerrlen) < 0) {
+            goto cleanup;
+        }
+        if (soerr) {
+            errno = soerr;
+            goto cleanup;
+        }
+    }
+
  done:
     ret = 0;
 
  cleanup:
-    if (fd != -1) {
-        close(fd);
+    if (afd != -1) {
+        close(afd);
+    }
+    if (cfd != -1) {
+        close(cfd);
+    }
+    if (lfd != -1) {
+        close(lfd);
     }
     if (res) {
         freeaddrinfo(res);
@@ -84,7 +133,7 @@ int socket_check_protocol_support(bool *has_ipv4, bool *has_ipv6)
 {
     *has_ipv4 = *has_ipv6 = false;
 
-    if (socket_can_bind("127.0.0.1") < 0) {
+    if (socket_can_bind_connect("127.0.0.1") < 0) {
         if (errno != EADDRNOTAVAIL) {
             return -1;
         }
@@ -92,7 +141,7 @@ int socket_check_protocol_support(bool *has_ipv4, bool *has_ipv6)
         *has_ipv4 = true;
     }
 
-    if (socket_can_bind("::1") < 0) {
+    if (socket_can_bind_connect("::1") < 0) {
         if (errno != EADDRNOTAVAIL) {
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
 
 /*
  * @has_ipv4: set to true on return if IPv4 is available
-- 
2.14.3
