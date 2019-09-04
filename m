Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED99C3A5A7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 06:34:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 858AF2087E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 06:34:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 858AF2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5OsZ-0000L4-Do
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 02:34:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42896)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1i5Onl-0006Te-SM
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 02:29:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1i5Onj-0003rX-VS
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 02:29:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50346)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>)
 id 1i5OnV-0003K1-HI; Wed, 04 Sep 2019 02:29:42 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0C4704E924;
 Wed,  4 Sep 2019 06:29:28 +0000 (UTC)
Received: from secure.mitica (ovpn-116-17.ams2.redhat.com [10.36.116.17])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CEBC719D70;
 Wed,  4 Sep 2019 06:29:24 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 08:29:11 +0200
Message-Id: <20190904062915.6488-2-quintela@redhat.com>
In-Reply-To: <20190904062915.6488-1-quintela@redhat.com>
References: <20190904062915.6488-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Wed, 04 Sep 2019 06:29:28 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 1/5] socket: Add backlog parameter to
 socket_listen
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Current parameter was always one.  We continue with that value for now
in all callers.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
Moved trace to socket_listen
---
 include/qemu/sockets.h    |  2 +-
 io/channel-socket.c       |  2 +-
 qga/channel-posix.c       |  2 +-
 tests/test-util-sockets.c | 12 ++++++------
 util/qemu-sockets.c       | 33 ++++++++++++++++++++++-----------
 util/trace-events         |  3 +++
 6 files changed, 34 insertions(+), 20 deletions(-)

diff --git a/include/qemu/sockets.h b/include/qemu/sockets.h
index 8140fea685..57cd049d6e 100644
--- a/include/qemu/sockets.h
+++ b/include/qemu/sockets.h
@@ -41,7 +41,7 @@ int unix_connect(const char *path, Error **errp);
=20
 SocketAddress *socket_parse(const char *str, Error **errp);
 int socket_connect(SocketAddress *addr, Error **errp);
-int socket_listen(SocketAddress *addr, Error **errp);
+int socket_listen(SocketAddress *addr, int num, Error **errp);
 void socket_listen_cleanup(int fd, Error **errp);
 int socket_dgram(SocketAddress *remote, SocketAddress *local, Error **er=
rp);
=20
diff --git a/io/channel-socket.c b/io/channel-socket.c
index bec3d931d1..a533c8bc11 100644
--- a/io/channel-socket.c
+++ b/io/channel-socket.c
@@ -202,7 +202,7 @@ int qio_channel_socket_listen_sync(QIOChannelSocket *=
ioc,
     int fd;
=20
     trace_qio_channel_socket_listen_sync(ioc, addr);
-    fd =3D socket_listen(addr, errp);
+    fd =3D socket_listen(addr, 1, errp);
     if (fd < 0) {
         trace_qio_channel_socket_listen_fail(ioc);
         return -1;
diff --git a/qga/channel-posix.c b/qga/channel-posix.c
index 5a925a9818..8fc205ad21 100644
--- a/qga/channel-posix.c
+++ b/qga/channel-posix.c
@@ -215,7 +215,7 @@ static gboolean ga_channel_open(GAChannel *c, const g=
char *path,
                 return false;
             }
=20
-            fd =3D socket_listen(addr, &local_err);
+            fd =3D socket_listen(addr, 1, &local_err);
             qapi_free_SocketAddress(addr);
             if (local_err !=3D NULL) {
                 g_critical("%s", error_get_pretty(local_err));
diff --git a/tests/test-util-sockets.c b/tests/test-util-sockets.c
index e2a3a8a093..8ce55efe70 100644
--- a/tests/test-util-sockets.c
+++ b/tests/test-util-sockets.c
@@ -93,7 +93,7 @@ static void test_socket_fd_pass_name_good(void)
     g_assert_cmpint(fd, !=3D, mon_fd);
     close(fd);
=20
-    fd =3D socket_listen(&addr, &error_abort);
+    fd =3D socket_listen(&addr, 1, &error_abort);
     g_assert_cmpint(fd, !=3D, -1);
     g_assert_cmpint(fd, !=3D, mon_fd);
     close(fd);
@@ -124,7 +124,7 @@ static void test_socket_fd_pass_name_bad(void)
     g_assert_cmpint(fd, =3D=3D, -1);
     error_free_or_abort(&err);
=20
-    fd =3D socket_listen(&addr, &err);
+    fd =3D socket_listen(&addr, 1, &err);
     g_assert_cmpint(fd, =3D=3D, -1);
     error_free_or_abort(&err);
=20
@@ -151,7 +151,7 @@ static void test_socket_fd_pass_name_nomon(void)
     g_assert_cmpint(fd, =3D=3D, -1);
     error_free_or_abort(&err);
=20
-    fd =3D socket_listen(&addr, &err);
+    fd =3D socket_listen(&addr, 1, &err);
     g_assert_cmpint(fd, =3D=3D, -1);
     error_free_or_abort(&err);
=20
@@ -174,7 +174,7 @@ static void test_socket_fd_pass_num_good(void)
     fd =3D socket_connect(&addr, &error_abort);
     g_assert_cmpint(fd, =3D=3D, sfd);
=20
-    fd =3D socket_listen(&addr, &error_abort);
+    fd =3D socket_listen(&addr, 1, &error_abort);
     g_assert_cmpint(fd, =3D=3D, sfd);
=20
     g_free(addr.u.fd.str);
@@ -197,7 +197,7 @@ static void test_socket_fd_pass_num_bad(void)
     g_assert_cmpint(fd, =3D=3D, -1);
     error_free_or_abort(&err);
=20
-    fd =3D socket_listen(&addr, &err);
+    fd =3D socket_listen(&addr, 1, &err);
     g_assert_cmpint(fd, =3D=3D, -1);
     error_free_or_abort(&err);
=20
@@ -220,7 +220,7 @@ static void test_socket_fd_pass_num_nocli(void)
     g_assert_cmpint(fd, =3D=3D, -1);
     error_free_or_abort(&err);
=20
-    fd =3D socket_listen(&addr, &err);
+    fd =3D socket_listen(&addr, 1, &err);
     g_assert_cmpint(fd, =3D=3D, -1);
     error_free_or_abort(&err);
=20
diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index e3a1666578..98ff3a1cce 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -31,6 +31,7 @@
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/qobject-output-visitor.h"
 #include "qemu/cutils.h"
+#include "trace.h"
=20
 #ifndef AI_ADDRCONFIG
 # define AI_ADDRCONFIG 0
@@ -207,6 +208,7 @@ static int try_bind(int socket, InetSocketAddress *sa=
ddr, struct addrinfo *e)
=20
 static int inet_listen_saddr(InetSocketAddress *saddr,
                              int port_offset,
+                             int num,
                              Error **errp)
 {
     struct addrinfo ai,*res,*e;
@@ -309,7 +311,7 @@ static int inet_listen_saddr(InetSocketAddress *saddr=
,
                     goto listen_failed;
                 }
             } else {
-                if (!listen(slisten, 1)) {
+                if (!listen(slisten, num)) {
                     goto listen_ok;
                 }
                 if (errno !=3D EADDRINUSE) {
@@ -774,6 +776,7 @@ static int vsock_connect_saddr(VsockSocketAddress *va=
ddr, Error **errp)
 }
=20
 static int vsock_listen_saddr(VsockSocketAddress *vaddr,
+                              int num,
                               Error **errp)
 {
     struct sockaddr_vm svm;
@@ -795,7 +798,7 @@ static int vsock_listen_saddr(VsockSocketAddress *vad=
dr,
         return -1;
     }
=20
-    if (listen(slisten, 1) !=3D 0) {
+    if (listen(slisten, num) !=3D 0) {
         error_setg_errno(errp, errno, "Failed to listen on socket");
         closesocket(slisten);
         return -1;
@@ -836,6 +839,7 @@ static int vsock_connect_saddr(VsockSocketAddress *va=
ddr, Error **errp)
 }
=20
 static int vsock_listen_saddr(VsockSocketAddress *vaddr,
+                              int num,
                               Error **errp)
 {
     vsock_unsupported(errp);
@@ -853,6 +857,7 @@ static int vsock_parse(VsockSocketAddress *addr, cons=
t char *str,
 #ifndef _WIN32
=20
 static int unix_listen_saddr(UnixSocketAddress *saddr,
+                             int num,
                              Error **errp)
 {
     struct sockaddr_un un;
@@ -914,7 +919,7 @@ static int unix_listen_saddr(UnixSocketAddress *saddr=
,
         error_setg_errno(errp, errno, "Failed to bind socket to %s", pat=
h);
         goto err;
     }
-    if (listen(sock, 1) < 0) {
+    if (listen(sock, num) < 0) {
         error_setg_errno(errp, errno, "Failed to listen on socket");
         goto err;
     }
@@ -981,6 +986,7 @@ static int unix_connect_saddr(UnixSocketAddress *sadd=
r, Error **errp)
 #else
=20
 static int unix_listen_saddr(UnixSocketAddress *saddr,
+                             int num,
                              Error **errp)
 {
     error_setg(errp, "unix sockets are not available on windows");
@@ -1004,7 +1010,7 @@ int unix_listen(const char *str, Error **errp)
=20
     saddr =3D g_new0(UnixSocketAddress, 1);
     saddr->path =3D g_strdup(str);
-    sock =3D unix_listen_saddr(saddr, errp);
+    sock =3D unix_listen_saddr(saddr, 1, errp);
     qapi_free_UnixSocketAddress(saddr);
     return sock;
 }
@@ -1061,9 +1067,13 @@ fail:
     return NULL;
 }
=20
-static int socket_get_fd(const char *fdstr, Error **errp)
+static int socket_get_fd(const char *fdstr, int num, Error **errp)
 {
     int fd;
+    if (num !=3D 1) {
+        error_setg_errno(errp, EINVAL, "socket_get_fd: too many connecti=
ons");
+        return -1;
+    }
     if (cur_mon) {
         fd =3D monitor_get_fd(cur_mon, fdstr, errp);
         if (fd < 0) {
@@ -1099,7 +1109,7 @@ int socket_connect(SocketAddress *addr, Error **err=
p)
         break;
=20
     case SOCKET_ADDRESS_TYPE_FD:
-        fd =3D socket_get_fd(addr->u.fd.str, errp);
+        fd =3D socket_get_fd(addr->u.fd.str, 1, errp);
         break;
=20
     case SOCKET_ADDRESS_TYPE_VSOCK:
@@ -1112,25 +1122,26 @@ int socket_connect(SocketAddress *addr, Error **e=
rrp)
     return fd;
 }
=20
-int socket_listen(SocketAddress *addr, Error **errp)
+int socket_listen(SocketAddress *addr, int num, Error **errp)
 {
     int fd;
=20
+    trace_socket_listen(num);
     switch (addr->type) {
     case SOCKET_ADDRESS_TYPE_INET:
-        fd =3D inet_listen_saddr(&addr->u.inet, 0, errp);
+        fd =3D inet_listen_saddr(&addr->u.inet, 0, num, errp);
         break;
=20
     case SOCKET_ADDRESS_TYPE_UNIX:
-        fd =3D unix_listen_saddr(&addr->u.q_unix, errp);
+        fd =3D unix_listen_saddr(&addr->u.q_unix, num, errp);
         break;
=20
     case SOCKET_ADDRESS_TYPE_FD:
-        fd =3D socket_get_fd(addr->u.fd.str, errp);
+        fd =3D socket_get_fd(addr->u.fd.str, num, errp);
         break;
=20
     case SOCKET_ADDRESS_TYPE_VSOCK:
-        fd =3D vsock_listen_saddr(&addr->u.vsock, errp);
+        fd =3D vsock_listen_saddr(&addr->u.vsock, num, errp);
         break;
=20
     default:
diff --git a/util/trace-events b/util/trace-events
index 9dbd237dad..83b6639018 100644
--- a/util/trace-events
+++ b/util/trace-events
@@ -64,6 +64,9 @@ lockcnt_futex_wait(const void *lockcnt, int val) "lockc=
nt %p waiting on %d"
 lockcnt_futex_wait_resume(const void *lockcnt, int new) "lockcnt %p afte=
r wait: %d"
 lockcnt_futex_wake(const void *lockcnt) "lockcnt %p waking up one waiter=
"
=20
+# qemu-sockets.c
+socket_listen(int num) "backlog: %d"
+
 # qemu-thread-common.h
 qemu_mutex_lock(void *mutex, const char *file, const int line) "waiting =
on mutex %p (%s:%d)"
 qemu_mutex_locked(void *mutex, const char *file, const int line) "taken =
mutex %p (%s:%d)"
--=20
2.21.0


