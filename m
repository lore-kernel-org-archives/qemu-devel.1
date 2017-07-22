Received: from eggs.gnu.org ([2001:4830:134:3::10]:37127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <knut.omang@oracle.com>) id 1dYqlv-00083o-9q
	for qemu-devel@nongnu.org; Sat, 22 Jul 2017 05:32:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <knut.omang@oracle.com>) id 1dYqls-0005Uk-2T
	for qemu-devel@nongnu.org; Sat, 22 Jul 2017 05:32:27 -0400
Received: from aserp1040.oracle.com ([141.146.126.69]:42807)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <knut.omang@oracle.com>)
	id 1dYqlr-0005Ug-OY
	for qemu-devel@nongnu.org; Sat, 22 Jul 2017 05:32:24 -0400
From: Knut Omang <knut.omang@oracle.com>
Date: Sat, 22 Jul 2017 09:49:33 +0200
Message-Id: <ec9baca1bcdf385ea4b3e27fdbe2d35b6b0f687d.1500709594.git-series.knut.omang@oracle.com>
In-Reply-To: <cover.28627297ce9b47260986349ac22bf2de37bb9be6.1500709594.git-series.knut.omang@oracle.com>
References: <cover.28627297ce9b47260986349ac22bf2de37bb9be6.1500709594.git-series.knut.omang@oracle.com>
Subject: [Qemu-devel] [PATCH v5 4/4] sockets: Handle race condition between
 binds to the same port
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P . Berrange" <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Knut Omang <knut.omang@oracle.com>

If an offset of ports is specified to the inet_listen_saddr function(),
and two or more processes tries to bind from these ports at the same time,
occasionally more than one process may be able to bind to the same
port. The condition is detected by listen() but too late to avoid a failure.

This function is called by socket_listen() and used
by all socket listening code in QEMU, so all cases where any form of dynamic
port selection is used should be subject to this issue.

Add code to close and re-establish the socket when this
condition is observed, hiding the race condition from the user.

Also clean up some issues with error handling to allow more
accurate reporting of the cause of an error.

This has been developed and tested by means of the
test-listen unit test in the previous commit.
Enable the test for make check now that it passes.

Signed-off-by: Knut Omang <knut.omang@oracle.com>
Reviewed-by: Bhavesh Davda <bhavesh.davda@oracle.com>
Reviewed-by: Yuval Shaia <yuval.shaia@oracle.com>
Reviewed-by: Girish Moodalbail <girish.moodalbail@oracle.com>
Signed-off-by: Knut Omang <knut.omang@oracle.com>
---
 tests/Makefile.include |  2 +-
 util/qemu-sockets.c    | 51 ++++++++++++++++++++++++++++++++-----------
 2 files changed, 39 insertions(+), 14 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index b37c0c8..9d2131d 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -128,7 +128,7 @@ check-unit-y += tests/test-bufferiszero$(EXESUF)
 gcov-files-check-bufferiszero-y = util/bufferiszero.c
 check-unit-y += tests/test-uuid$(EXESUF)
 check-unit-y += tests/ptimer-test$(EXESUF)
-#check-unit-y += tests/test-listen$(EXESUF)
+check-unit-y += tests/test-listen$(EXESUF)
 gcov-files-ptimer-test-y = hw/core/ptimer.c
 check-unit-y += tests/test-qapi-util$(EXESUF)
 gcov-files-test-qapi-util-y = qapi/qapi-util.c
diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index 39f207c..8ca3ba6 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -210,7 +210,9 @@ static int inet_listen_saddr(InetSocketAddress *saddr,
     char port[33];
     char uaddr[INET6_ADDRSTRLEN+1];
     char uport[33];
-    int slisten, rc, port_min, port_max, p;
+    int rc, port_min, port_max, p;
+    int slisten = 0;
+    int saved_errno = 0;
     Error *err = NULL;
 
     memset(&ai,0, sizeof(ai));
@@ -277,27 +279,50 @@ static int inet_listen_saddr(InetSocketAddress *saddr,
         port_max = saddr->has_to ? saddr->to + port_offset : port_min;
         for (p = port_min; p <= port_max; p++) {
             inet_setport(e, p);
-            if (try_bind(slisten, saddr, e) >= 0) {
-                goto listen;
-            }
-            if (p == port_max) {
-                if (!e->ai_next) {
+            rc = try_bind(slisten, saddr, e);
+            if (rc) {
+                if (errno == EADDRINUSE) {
+                    continue;
+                } else {
                     error_setg_errno(errp, errno, "Failed to bind socket");
+                    goto listen_failed;
+                }
+            }
+            rc = listen(slisten, 1);
+            if (!rc) {
+                goto listen_ok;
+            } else if (errno == EADDRINUSE) {
+                /* Someone else managed to bind to the same port and beat us
+                 * to listen on it! Socket semantics does not allow us to
+                 * recover from this situation, so we need to recreate the
+                 * socket to allow bind attempts for subsequent ports:
+                 */
+                closesocket(slisten);
+                slisten = create_fast_reuse_socket(e, errp);
+                if (slisten >= 0) {
+                    continue;
                 }
             }
+            error_setg_errno(errp, errno, "Failed to listen on socket");
+            goto listen_failed;
         }
+    }
+    if (err) {
+        error_propagate(errp, err);
+    } else {
+        error_setg_errno(errp, errno, "Failed to find an available port");
+    }
+
+listen_failed:
+    saved_errno = errno;
+    if (slisten >= 0) {
         closesocket(slisten);
     }
     freeaddrinfo(res);
+    errno = saved_errno;
     return -1;
 
-listen:
-    if (listen(slisten,1) != 0) {
-        error_setg_errno(errp, errno, "Failed to listen on socket");
-        closesocket(slisten);
-        freeaddrinfo(res);
-        return -1;
-    }
+listen_ok:
     if (update_addr) {
         g_free(saddr->host);
         saddr->host = g_strdup(uaddr);
-- 
git-series 0.9.1
