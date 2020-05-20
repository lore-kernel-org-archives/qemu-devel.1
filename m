Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE4EC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 13:02:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DCFB207D3
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 13:02:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iFcTB/f+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DCFB207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbOMy-0004fQ-7L
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 09:02:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44118)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jbOL6-0002QV-Sy
 for qemu-devel@nongnu.org; Wed, 20 May 2020 09:00:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37914
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jbOL5-0004rp-LQ
 for qemu-devel@nongnu.org; Wed, 20 May 2020 09:00:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589979650;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RSzRBZSrDZvf3d/ItUX679rPGM/XJ9GTRQNRCZFD0kc=;
 b=iFcTB/f+8TtdOpGzo9kLW7/7dSFU3SPGQGr52xMHHyLR6iVpOtwTHfRbL/LEqyt+S64hXy
 ln5PHkSpm0Xk6dYp52j5G2f6HQzF5PI0xCQdgd4SmmmWvRmAqo8QCRGuEkglyhWthA4Ydb
 /sO9fmS24qcVpfwo7smbIK19Buencs0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-EW2o-uf1MhmcoO2buVZXng-1; Wed, 20 May 2020 09:00:39 -0400
X-MC-Unique: EW2o-uf1MhmcoO2buVZXng-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2E4A58015D2;
 Wed, 20 May 2020 13:00:38 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.36.110.3])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 90E20101E678;
 Wed, 20 May 2020 13:00:35 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/3] qemu-sockets: add abstract UNIX domain socket support
Date: Wed, 20 May 2020 14:00:23 +0100
Message-Id: <20200520130025.2201467-2-berrange@redhat.com>
In-Reply-To: <20200520130025.2201467-1-berrange@redhat.com>
References: <20200520130025.2201467-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 22:48:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 xiaoqiang zhao <zxq_yx_007@163.com>, Markus Armbruster <armbru@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: xiaoqiang zhao <zxq_yx_007@163.com>

unix_listen/connect_saddr now support abstract address types

two aditional BOOL switches are introduced:
tight: whether to set @addrlen to the minimal string length,
       or the maximum sun_path length. default is TRUE
abstract: whether we use abstract address. default is FALSE

cli example:
-monitor unix:/tmp/unix.socket,abstract,tight=off
OR
-chardev socket,path=/tmp/unix.socket,id=unix1,abstract,tight=on

Signed-off-by: xiaoqiang zhao <zxq_yx_007@163.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 chardev/char-socket.c |  4 ++++
 chardev/char.c        |  7 +++++++
 qapi/sockets.json     |  8 +++++++-
 util/qemu-sockets.c   | 39 ++++++++++++++++++++++++++++++++-------
 4 files changed, 50 insertions(+), 8 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 232e0a8604..e77699db48 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -1380,6 +1380,8 @@ static void qemu_chr_parse_socket(QemuOpts *opts, ChardevBackend *backend,
     const char *host = qemu_opt_get(opts, "host");
     const char *port = qemu_opt_get(opts, "port");
     const char *fd = qemu_opt_get(opts, "fd");
+    bool tight = qemu_opt_get_bool(opts, "tight", true);
+    bool abstract = qemu_opt_get_bool(opts, "abstract", false);
     SocketAddressLegacy *addr;
     ChardevSocket *sock;
 
@@ -1431,6 +1433,8 @@ static void qemu_chr_parse_socket(QemuOpts *opts, ChardevBackend *backend,
         addr->type = SOCKET_ADDRESS_LEGACY_KIND_UNIX;
         q_unix = addr->u.q_unix.data = g_new0(UnixSocketAddress, 1);
         q_unix->path = g_strdup(path);
+        q_unix->tight = tight;
+        q_unix->abstract = abstract;
     } else if (host) {
         addr->type = SOCKET_ADDRESS_LEGACY_KIND_INET;
         addr->u.inet.data = g_new(InetSocketAddress, 1);
diff --git a/chardev/char.c b/chardev/char.c
index 0196e2887b..ea06c5ff4d 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -939,6 +939,13 @@ QemuOptsList qemu_chardev_opts = {
         },{
             .name = "logappend",
             .type = QEMU_OPT_BOOL,
+        },{
+            .name = "tight",
+            .type = QEMU_OPT_BOOL,
+            .def_value_str = "on",
+        },{
+            .name = "abstract",
+            .type = QEMU_OPT_BOOL,
         },
         { /* end of list */ }
     },
diff --git a/qapi/sockets.json b/qapi/sockets.json
index ea933ed4b2..cbd6ef35d0 100644
--- a/qapi/sockets.json
+++ b/qapi/sockets.json
@@ -73,12 +73,18 @@
 # Captures a socket address in the local ("Unix socket") namespace.
 #
 # @path: filesystem path to use
+# @tight: pass a socket address length confined to the minimum length of the
+#         abstract string, rather than the full sockaddr_un record length
+#         (only matters for abstract sockets, default true). (Since 5.1)
+# @abstract: whether this is an abstract address, default false. (Since 5.1)
 #
 # Since: 1.3
 ##
 { 'struct': 'UnixSocketAddress',
   'data': {
-    'path': 'str' } }
+    'path': 'str',
+    '*tight': 'bool',
+    '*abstract': 'bool' } }
 
 ##
 # @VsockSocketAddress:
diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index 86c48b9fa5..b37d288866 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -863,6 +863,7 @@ static int unix_listen_saddr(UnixSocketAddress *saddr,
     char *pathbuf = NULL;
     const char *path;
     size_t pathlen;
+    size_t addrlen;
 
     sock = qemu_socket(PF_UNIX, SOCK_STREAM, 0);
     if (sock < 0) {
@@ -879,9 +880,11 @@ static int unix_listen_saddr(UnixSocketAddress *saddr,
     }
 
     pathlen = strlen(path);
-    if (pathlen > sizeof(un.sun_path)) {
+    if (pathlen > sizeof(un.sun_path) ||
+        (saddr->abstract && pathlen > (sizeof(un.sun_path) - 1))) {
         error_setg(errp, "UNIX socket path '%s' is too long", path);
         error_append_hint(errp, "Path must be less than %zu bytes\n",
+                          saddr->abstract ? sizeof(un.sun_path) - 1 :
                           sizeof(un.sun_path));
         goto err;
     }
@@ -903,7 +906,7 @@ static int unix_listen_saddr(UnixSocketAddress *saddr,
         close(fd);
     }
 
-    if (unlink(path) < 0 && errno != ENOENT) {
+    if (!saddr->abstract && unlink(path) < 0 && errno != ENOENT) {
         error_setg_errno(errp, errno,
                          "Failed to unlink socket %s", path);
         goto err;
@@ -911,9 +914,19 @@ static int unix_listen_saddr(UnixSocketAddress *saddr,
 
     memset(&un, 0, sizeof(un));
     un.sun_family = AF_UNIX;
-    memcpy(un.sun_path, path, pathlen);
+    addrlen = sizeof(un);
 
-    if (bind(sock, (struct sockaddr*) &un, sizeof(un)) < 0) {
+    if (saddr->abstract) {
+        un.sun_path[0] = '\0';
+        memcpy(&un.sun_path[1], path, pathlen);
+        if (saddr->tight) {
+            addrlen = offsetof(struct sockaddr_un, sun_path) + 1 + pathlen;
+        }
+    } else {
+        memcpy(un.sun_path, path, pathlen);
+    }
+
+    if (bind(sock, (struct sockaddr *) &un, addrlen) < 0) {
         error_setg_errno(errp, errno, "Failed to bind socket to %s", path);
         goto err;
     }
@@ -936,6 +949,7 @@ static int unix_connect_saddr(UnixSocketAddress *saddr, Error **errp)
     struct sockaddr_un un;
     int sock, rc;
     size_t pathlen;
+    size_t addrlen;
 
     if (saddr->path == NULL) {
         error_setg(errp, "unix connect: no path specified");
@@ -949,21 +963,32 @@ static int unix_connect_saddr(UnixSocketAddress *saddr, Error **errp)
     }
 
     pathlen = strlen(saddr->path);
-    if (pathlen > sizeof(un.sun_path)) {
+    if (pathlen > sizeof(un.sun_path) ||
+        (saddr->abstract && pathlen > (sizeof(un.sun_path) - 1))) {
         error_setg(errp, "UNIX socket path '%s' is too long", saddr->path);
         error_append_hint(errp, "Path must be less than %zu bytes\n",
+                          saddr->abstract ? sizeof(un.sun_path) - 1 :
                           sizeof(un.sun_path));
         goto err;
     }
 
     memset(&un, 0, sizeof(un));
     un.sun_family = AF_UNIX;
-    memcpy(un.sun_path, saddr->path, pathlen);
+    addrlen = sizeof(un);
 
+    if (saddr->abstract) {
+        un.sun_path[0] = '\0';
+        memcpy(&un.sun_path[1], saddr->path, pathlen);
+        if (saddr->tight) {
+            addrlen = offsetof(struct sockaddr_un, sun_path) + 1 + pathlen;
+        }
+    } else {
+        memcpy(un.sun_path, saddr->path, pathlen);
+    }
     /* connect to peer */
     do {
         rc = 0;
-        if (connect(sock, (struct sockaddr *) &un, sizeof(un)) < 0) {
+        if (connect(sock, (struct sockaddr *) &un, addrlen) < 0) {
             rc = -errno;
         }
     } while (rc == -EINTR);
-- 
2.26.2


