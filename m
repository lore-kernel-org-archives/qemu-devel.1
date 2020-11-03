Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ACB1C2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 14:13:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD0E622226
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 14:13:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DKTz+PxU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD0E622226
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZx41-0001vC-Jf
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 09:13:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49352)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kZwuK-00075j-GN
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 09:03:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39753)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kZwuD-0003U1-Ql
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 09:03:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604412203;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1UxIMHJakD89O+OSTzMMGSCr4uHHMTmhUZvf/n8y34I=;
 b=DKTz+PxUpVOQGAbzNEdPKlDn8Qs5f/LaWvtvN5JTr+arV55mJpCN1+jP087sijbDoyIIVK
 Ke98c39IatPaSbNveHwDxNdLURklgNDfGmej3eGIYQ83Qpi2qy0rB5SjWN1hrZuCAmRkJy
 X9c95OUuZei6wkXWHF/bRqyzLyWyiC4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-fe0jy6Y_MJWNQreaq6zooA-1; Tue, 03 Nov 2020 09:03:21 -0500
X-MC-Unique: fe0jy6Y_MJWNQreaq6zooA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 31E1C8058C6
 for <qemu-devel@nongnu.org>; Tue,  3 Nov 2020 14:03:20 +0000 (UTC)
Received: from fedora.redhat.com (ovpn-115-87.ams2.redhat.com [10.36.115.87])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 136745B4C7;
 Tue,  3 Nov 2020 14:03:11 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 11/11] sockets: Make abstract UnixSocketAddress depend on
 CONFIG_LINUX
Date: Tue,  3 Nov 2020 14:02:25 +0000
Message-Id: <20201103140225.496776-12-berrange@redhat.com>
In-Reply-To: <20201103140225.496776-1-berrange@redhat.com>
References: <20201103140225.496776-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 01:02:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Markus Armbruster <armbru@redhat.com>

The abstract socket namespace is a non-portable Linux extension.  An
attempt to use it elsewhere should fail with ENOENT (the abstract
address looks like a "" pathname, which does not resolve).  We report
this failure like

    Failed to connect socket abc: No such file or directory

Tolerable, although ENOTSUP would be better.

However, introspection lies: it has @abstract regardless of host
support.  Easy enough to fix: since Linux provides them since 2.2,
'if': 'defined(CONFIG_LINUX)' should do.

The above failure becomes

    Parameter 'backend.data.addr.data.abstract' is unexpected

I consider this an improvement.

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 chardev/char-socket.c     |  6 ++++++
 chardev/char.c            |  2 ++
 qapi/sockets.json         | 14 ++++++++------
 tests/test-util-sockets.c |  7 ++++---
 util/qemu-sockets.c       | 40 +++++++++++++++++++++++++++++----------
 5 files changed, 50 insertions(+), 19 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 27a2954f47..213a4c8dd0 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -447,12 +447,14 @@ static char *qemu_chr_socket_address(SocketChardev *s, const char *prefix)
         const char *tight = "", *abstract = "";
         UnixSocketAddress *sa = &s->addr->u.q_unix;
 
+#ifdef CONFIG_LINUX
         if (sa->has_abstract && sa->abstract) {
             abstract = ",abstract";
             if (sa->has_tight && sa->tight) {
                 tight = ",tight";
             }
         }
+#endif
 
         return g_strdup_printf("%sunix:%s%s%s%s", prefix, sa->path,
                                abstract, tight,
@@ -1398,8 +1400,10 @@ static void qemu_chr_parse_socket(QemuOpts *opts, ChardevBackend *backend,
     const char *host = qemu_opt_get(opts, "host");
     const char *port = qemu_opt_get(opts, "port");
     const char *fd = qemu_opt_get(opts, "fd");
+#ifdef CONFIG_LINUX
     bool tight = qemu_opt_get_bool(opts, "tight", true);
     bool abstract = qemu_opt_get_bool(opts, "abstract", false);
+#endif
     SocketAddressLegacy *addr;
     ChardevSocket *sock;
 
@@ -1451,10 +1455,12 @@ static void qemu_chr_parse_socket(QemuOpts *opts, ChardevBackend *backend,
         addr->type = SOCKET_ADDRESS_LEGACY_KIND_UNIX;
         q_unix = addr->u.q_unix.data = g_new0(UnixSocketAddress, 1);
         q_unix->path = g_strdup(path);
+#ifdef CONFIG_LINUX
         q_unix->has_tight = true;
         q_unix->tight = tight;
         q_unix->has_abstract = true;
         q_unix->abstract = abstract;
+#endif
     } else if (host) {
         addr->type = SOCKET_ADDRESS_LEGACY_KIND_INET;
         addr->u.inet.data = g_new(InetSocketAddress, 1);
diff --git a/chardev/char.c b/chardev/char.c
index 78553125d3..aa4282164a 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -928,6 +928,7 @@ QemuOptsList qemu_chardev_opts = {
         },{
             .name = "logappend",
             .type = QEMU_OPT_BOOL,
+#ifdef CONFIG_LINUX
         },{
             .name = "tight",
             .type = QEMU_OPT_BOOL,
@@ -935,6 +936,7 @@ QemuOptsList qemu_chardev_opts = {
         },{
             .name = "abstract",
             .type = QEMU_OPT_BOOL,
+#endif
         },
         { /* end of list */ }
     },
diff --git a/qapi/sockets.json b/qapi/sockets.json
index c0c640a5b0..2e83452797 100644
--- a/qapi/sockets.json
+++ b/qapi/sockets.json
@@ -74,18 +74,20 @@
 # Captures a socket address in the local ("Unix socket") namespace.
 #
 # @path: filesystem path to use
-# @tight: pass a socket address length confined to the minimum length of the
-#         abstract string, rather than the full sockaddr_un record length
-#         (only matters for abstract sockets, default true). (Since 5.1)
-# @abstract: whether this is an abstract address, default false. (Since 5.1)
+# @abstract: if true, this is a Linux abstract socket address.  @path
+#            will be prefixed by a null byte, and optionally padded
+#            with null bytes.  Defaults to false.  (Since 5.1)
+# @tight: if false, pad an abstract socket address with enough null
+#         bytes to make it fill struct sockaddr_un member sun_path.
+#         Defaults to true.  (Since 5.1)
 #
 # Since: 1.3
 ##
 { 'struct': 'UnixSocketAddress',
   'data': {
     'path': 'str',
-    '*tight': 'bool',
-    '*abstract': 'bool' } }
+    '*abstract': { 'type': 'bool', 'if': 'defined(CONFIG_LINUX)' },
+    '*tight': { 'type': 'bool', 'if': 'defined(CONFIG_LINUX)' } } }
 
 ##
 # @VsockSocketAddress:
diff --git a/tests/test-util-sockets.c b/tests/test-util-sockets.c
index 7ecf95579b..67486055ed 100644
--- a/tests/test-util-sockets.c
+++ b/tests/test-util-sockets.c
@@ -229,7 +229,7 @@ static void test_socket_fd_pass_num_nocli(void)
 }
 #endif
 
-#ifdef __linux__
+#ifdef CONFIG_LINUX
 
 #define ABSTRACT_SOCKET_VARIANTS 3
 
@@ -326,7 +326,8 @@ static void test_socket_unix_abstract(void)
 
     g_free(addr.u.q_unix.path);
 }
-#endif
+
+#endif  /* CONFIG_LINUX */
 
 int main(int argc, char **argv)
 {
@@ -368,7 +369,7 @@ int main(int argc, char **argv)
 #endif
     }
 
-#ifdef __linux__
+#ifdef CONFIG_LINUX
     g_test_add_func("/util/socket/unix-abstract",
                     test_socket_unix_abstract);
 #endif
diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index 671717499f..8af0278f15 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -860,10 +860,29 @@ static int vsock_parse(VsockSocketAddress *addr, const char *str,
 
 #ifndef _WIN32
 
+static bool saddr_is_abstract(UnixSocketAddress *saddr)
+{
+#ifdef CONFIG_LINUX
+    return saddr->abstract;
+#else
+    return false;
+#endif
+}
+
+static bool saddr_is_tight(UnixSocketAddress *saddr)
+{
+#ifdef CONFIG_LINUX
+    return !saddr->has_tight || saddr->tight;
+#else
+    return false;
+#endif
+}
+
 static int unix_listen_saddr(UnixSocketAddress *saddr,
                              int num,
                              Error **errp)
 {
+    bool abstract = saddr_is_abstract(saddr);
     struct sockaddr_un un;
     int sock, fd;
     char *pathbuf = NULL;
@@ -877,7 +896,7 @@ static int unix_listen_saddr(UnixSocketAddress *saddr,
         return -1;
     }
 
-    if (saddr->path[0] || saddr->abstract) {
+    if (saddr->path[0] || abstract) {
         path = saddr->path;
     } else {
         const char *tmpdir = getenv("TMPDIR");
@@ -887,10 +906,10 @@ static int unix_listen_saddr(UnixSocketAddress *saddr,
 
     pathlen = strlen(path);
     if (pathlen > sizeof(un.sun_path) ||
-        (saddr->abstract && pathlen > (sizeof(un.sun_path) - 1))) {
+        (abstract && pathlen > (sizeof(un.sun_path) - 1))) {
         error_setg(errp, "UNIX socket path '%s' is too long", path);
         error_append_hint(errp, "Path must be less than %zu bytes\n",
-                          saddr->abstract ? sizeof(un.sun_path) - 1 :
+                          abstract ? sizeof(un.sun_path) - 1 :
                           sizeof(un.sun_path));
         goto err;
     }
@@ -912,7 +931,7 @@ static int unix_listen_saddr(UnixSocketAddress *saddr,
         close(fd);
     }
 
-    if (!saddr->abstract && unlink(path) < 0 && errno != ENOENT) {
+    if (!abstract && unlink(path) < 0 && errno != ENOENT) {
         error_setg_errno(errp, errno,
                          "Failed to unlink socket %s", path);
         goto err;
@@ -922,10 +941,10 @@ static int unix_listen_saddr(UnixSocketAddress *saddr,
     un.sun_family = AF_UNIX;
     addrlen = sizeof(un);
 
-    if (saddr->abstract) {
+    if (abstract) {
         un.sun_path[0] = '\0';
         memcpy(&un.sun_path[1], path, pathlen);
-        if (!saddr->has_tight || saddr->tight) {
+        if (saddr_is_tight(saddr)) {
             addrlen = offsetof(struct sockaddr_un, sun_path) + 1 + pathlen;
         }
     } else {
@@ -952,6 +971,7 @@ err:
 
 static int unix_connect_saddr(UnixSocketAddress *saddr, Error **errp)
 {
+    bool abstract = saddr_is_abstract(saddr);
     struct sockaddr_un un;
     int sock, rc;
     size_t pathlen;
@@ -970,10 +990,10 @@ static int unix_connect_saddr(UnixSocketAddress *saddr, Error **errp)
 
     pathlen = strlen(saddr->path);
     if (pathlen > sizeof(un.sun_path) ||
-        (saddr->abstract && pathlen > (sizeof(un.sun_path) - 1))) {
+        (abstract && pathlen > (sizeof(un.sun_path) - 1))) {
         error_setg(errp, "UNIX socket path '%s' is too long", saddr->path);
         error_append_hint(errp, "Path must be less than %zu bytes\n",
-                          saddr->abstract ? sizeof(un.sun_path) - 1 :
+                          abstract ? sizeof(un.sun_path) - 1 :
                           sizeof(un.sun_path));
         goto err;
     }
@@ -982,10 +1002,10 @@ static int unix_connect_saddr(UnixSocketAddress *saddr, Error **errp)
     un.sun_family = AF_UNIX;
     addrlen = sizeof(un);
 
-    if (saddr->abstract) {
+    if (abstract) {
         un.sun_path[0] = '\0';
         memcpy(&un.sun_path[1], saddr->path, pathlen);
-        if (!saddr->has_tight || saddr->tight) {
+        if (saddr_is_tight(saddr)) {
             addrlen = offsetof(struct sockaddr_un, sun_path) + 1 + pathlen;
         }
     } else {
-- 
2.28.0


