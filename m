Return-Path: <SRS0=vfNf=6Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F922C54E49
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2020 08:32:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 030C520820
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2020 08:32:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="FZlMZXdM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 030C520820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jXhNw-0003KL-0R
	for qemu-devel@archiver.kernel.org; Sun, 10 May 2020 04:32:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40642)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zxq_yx_007@163.com>)
 id 1jXhMG-0001cf-TD
 for qemu-devel@nongnu.org; Sun, 10 May 2020 04:30:48 -0400
Received: from mail-m971.mail.163.com ([123.126.97.1]:47414)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zxq_yx_007@163.com>) id 1jXhMB-0006eX-Th
 for qemu-devel@nongnu.org; Sun, 10 May 2020 04:30:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id; bh=Kr5tK/lJOCD/Lw7Hi7
 LPIehwjT6/hFwPvHylzYiwoO0=; b=FZlMZXdMjdmJIF+jY+hifnt09zCE7Exf3T
 kIxuu8lmsJB9pFXYt29Lq+C64lE+eO39Ub5yrAhhO/pqbujMNqzkyY2rFBl/eZy2
 maCK77q/to+6jCti++kXVtSFCKL5HxKmq/RnL6BTUVmVb3mMde/GONnBUfjc/9AH
 guR72+HI8=
Received: from localhost.localdomain (unknown [111.194.184.25])
 by smtp1 (Coremail) with SMTP id GdxpCgAHJ_UKuLdej37fBA--.10S3;
 Sun, 10 May 2020 16:15:16 +0800 (CST)
From: xiaoqiang zhao <zxq_yx_007@163.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RESEND v3 1/3] qemu-sockets: add abstract UNIX domain socket
 support
Date: Sun, 10 May 2020 16:14:51 +0800
Message-Id: <20200510081453.2915-2-zxq_yx_007@163.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200510081453.2915-1-zxq_yx_007@163.com>
References: <20200510081453.2915-1-zxq_yx_007@163.com>
X-CM-TRANSID: GdxpCgAHJ_UKuLdej37fBA--.10S3
X-Coremail-Antispam: 1Uf129KBjvJXoW3AF1xJFy3GFWfKF45ZF4fKrg_yoW7KF1kpr
 y5K3Z8KayrJw4Igrs3Xa1UCr1fA3ZYgryUW3y8JwnY9ws5Ww18Za4UKryYgry5JrW3W347
 urn0gr4UCF9xJw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UY9a9UUUUU=
X-Originating-IP: [111.194.184.25]
X-CM-SenderInfo: 520ts5t0bqili6rwjhhfrp/xtbBEAogxlUMQ9JU9QAAsV
Received-SPF: pass client-ip=123.126.97.1; envelope-from=zxq_yx_007@163.com;
 helo=mail-m971.mail.163.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/10 04:15:21
X-ACL-Warn: Detected OS   = Linux 3.1-3.10
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, berrange@redhat.com,
 xiaoqiang zhao <zxq_yx_007@163.com>, armbru@redhat.com, kraxel@redhat.com,
 pbonzini@redhat.com, marcandre.lureau@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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
---
 chardev/char-socket.c |  4 ++++
 chardev/char.c        |  7 +++++++
 qapi/sockets.json     |  9 ++++++++-
 util/qemu-sockets.c   | 39 ++++++++++++++++++++++++++++++++-------
 4 files changed, 51 insertions(+), 8 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 185fe38dda..16f2211091 100644
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
index e77564060d..f44fda3a92 100644
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
index ea933ed4b2..e7aa096cde 100644
--- a/qapi/sockets.json
+++ b/qapi/sockets.json
@@ -73,12 +73,19 @@
 # Captures a socket address in the local ("Unix socket") namespace.
 #
 # @path: filesystem path to use
+# @tight: pass a socket address length that does not include the whole
+#         struct sockaddr_un record but (besides other components) only
+#         the relevant part of the filename or abstract string.
+#         default value is 'true'
+# @abstract: whether this is a abstract address, default is 'false'
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
2.17.1


