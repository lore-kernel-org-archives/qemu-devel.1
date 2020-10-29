Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3226FC4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 13:48:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81F0A2076A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 13:48:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ejWjcSwm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81F0A2076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY8Hx-0008Ve-HM
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 09:48:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41306)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kY88s-00062E-VF
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 09:39:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49802)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kY88k-0008Lp-DP
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 09:39:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603978732;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G21g2Urc6so8DNLpRRUN8vW/Mk8zrUm7vuyny65EQoY=;
 b=ejWjcSwmuGbnmJO/zfXYUM0+vmPkpCuUv1XcDAaR7yd/ub/vfw5d3scbWzLcpOtQ/4X+hR
 VqYWDxzE4hbbg/Wmlk9qKWr7daB3WkmudAzPJa6iJoAeM9FP5K3tQc+VeCo1jB5io77NpU
 AkE8sODyjLPDU2NsOmDRZKOXkzY/Zl4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-530-gxi6Cz-FP_-3UbdPufrowg-1; Thu, 29 Oct 2020 09:38:50 -0400
X-MC-Unique: gxi6Cz-FP_-3UbdPufrowg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 11738188C12E;
 Thu, 29 Oct 2020 13:38:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-182.ams2.redhat.com
 [10.36.112.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0CFC455778;
 Thu, 29 Oct 2020 13:38:43 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BF00911326AE; Thu, 29 Oct 2020 14:38:33 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 11/11] sockets: Make abstract UnixSocketAddress depend on
 CONFIG_LINUX
Date: Thu, 29 Oct 2020 14:38:33 +0100
Message-Id: <20201029133833.3450220-12-armbru@redhat.com>
In-Reply-To: <20201029133833.3450220-1-armbru@redhat.com>
References: <20201029133833.3450220-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 01:47:28
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
Cc: kwolf@redhat.com, berrange@redhat.com, zxq_yx_007@163.com,
 kraxel@redhat.com, pbonzini@redhat.com, marcandre.lureau@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/sockets.json         | 14 ++++++++------
 chardev/char-socket.c     | 10 ++++++++++
 chardev/char.c            |  2 ++
 tests/test-util-sockets.c |  7 ++++---
 util/qemu-sockets.c       | 40 +++++++++++++++++++++++++++++----------
 5 files changed, 54 insertions(+), 19 deletions(-)

diff --git a/qapi/sockets.json b/qapi/sockets.json
index c0c640a5b0..db4019306a 100644
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
+    '*tight': { 'type': 'bool', 'if': 'defined(CONFIG_LINUX)' },
+    '*abstract': { 'type': 'bool', 'if': 'defined(CONFIG_LINUX)' } } }
 
 ##
 # @VsockSocketAddress:
diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index dc1cf86ecf..1d2b2efb13 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -444,14 +444,20 @@ static char *qemu_chr_socket_address(SocketChardev *s, const char *prefix)
         break;
     case SOCKET_ADDRESS_TYPE_UNIX:
     {
+#ifdef CONFIG_LINUX
         UnixSocketAddress *sa = &s->addr->u.q_unix;
+#endif
 
         return g_strdup_printf("%sunix:%s%s%s%s", prefix,
                                s->addr->u.q_unix.path,
+#ifdef CONFIG_LINUX
                                sa->has_abstract && sa->abstract
                                ? ",abstract" : "",
                                sa->has_tight && sa->tight
                                ? ",tight" : "",
+#else
+                               "", "",
+#endif
                                s->is_listen ? ",server" : "");
         break;
     }
@@ -1394,8 +1400,10 @@ static void qemu_chr_parse_socket(QemuOpts *opts, ChardevBackend *backend,
     const char *host = qemu_opt_get(opts, "host");
     const char *port = qemu_opt_get(opts, "port");
     const char *fd = qemu_opt_get(opts, "fd");
+#ifdef CONFIG_LINUX
     bool tight = qemu_opt_get_bool(opts, "tight", true);
     bool abstract = qemu_opt_get_bool(opts, "abstract", false);
+#endif
     SocketAddressLegacy *addr;
     ChardevSocket *sock;
 
@@ -1447,10 +1455,12 @@ static void qemu_chr_parse_socket(QemuOpts *opts, ChardevBackend *backend,
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
index 18c8de8cdb..f8553976e6 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -854,10 +854,29 @@ static int vsock_parse(VsockSocketAddress *addr, const char *str,
 
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
@@ -871,7 +890,7 @@ static int unix_listen_saddr(UnixSocketAddress *saddr,
         return -1;
     }
 
-    if (saddr->path[0] || saddr->abstract) {
+    if (saddr->path[0] || abstract) {
         path = saddr->path;
     } else {
         const char *tmpdir = getenv("TMPDIR");
@@ -881,10 +900,10 @@ static int unix_listen_saddr(UnixSocketAddress *saddr,
 
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
@@ -906,7 +925,7 @@ static int unix_listen_saddr(UnixSocketAddress *saddr,
         close(fd);
     }
 
-    if (!saddr->abstract && unlink(path) < 0 && errno != ENOENT) {
+    if (!abstract && unlink(path) < 0 && errno != ENOENT) {
         error_setg_errno(errp, errno,
                          "Failed to unlink socket %s", path);
         goto err;
@@ -916,10 +935,10 @@ static int unix_listen_saddr(UnixSocketAddress *saddr,
     un.sun_family = AF_UNIX;
     addrlen = sizeof(un);
 
-    if (saddr->abstract) {
+    if (abstract) {
         un.sun_path[0] = '\0';
         memcpy(&un.sun_path[1], path, pathlen);
-        if (!saddr->has_tight || saddr->tight) {
+        if (!saddr_is_tight(saddr)) {
             addrlen = offsetof(struct sockaddr_un, sun_path) + 1 + pathlen;
         }
     } else {
@@ -946,6 +965,7 @@ err:
 
 static int unix_connect_saddr(UnixSocketAddress *saddr, Error **errp)
 {
+    bool abstract = saddr_is_abstract(saddr);
     struct sockaddr_un un;
     int sock, rc;
     size_t pathlen;
@@ -964,10 +984,10 @@ static int unix_connect_saddr(UnixSocketAddress *saddr, Error **errp)
 
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
@@ -976,10 +996,10 @@ static int unix_connect_saddr(UnixSocketAddress *saddr, Error **errp)
     un.sun_family = AF_UNIX;
     addrlen = sizeof(un);
 
-    if (saddr->abstract) {
+    if (abstract) {
         un.sun_path[0] = '\0';
         memcpy(&un.sun_path[1], saddr->path, pathlen);
-        if (!saddr->has_tight || saddr->tight) {
+        if (!saddr_is_tight(saddr)) {
             addrlen = offsetof(struct sockaddr_un, sun_path) + 1 + pathlen;
         }
     } else {
-- 
2.26.2


