Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC600C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 19:50:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 884C120748
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 19:50:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IV+RFwxX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 884C120748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtcYo-00026w-QS
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 15:50:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58812)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1jtcT2-0000HH-7H
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 15:44:24 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:37399
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1jtcT0-0000XV-IE
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 15:44:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594323862;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EJsT5VH/Fb9a2nmYSvMGERjEPViTxmPmNzcRqMVTJYo=;
 b=IV+RFwxX59z6P5+gnn3zMvY0cJXa5/5FJFbrO/SlHfTVjiS5MkduW2ZOgCCbJzJLBekyHE
 dZD5G9rj9Na+OCBeqpflHk+Ze+ZbUnsAFqpf0ZwrGpiYpUpk0908XmFfHxSqShJna7/Ztu
 vqhRYtlnl/8JJ1ADN3Bdm/lDFQe0HYQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-514-_anDUwDIMlWwwH5XofTC3Q-1; Thu, 09 Jul 2020 15:44:18 -0400
X-MC-Unique: _anDUwDIMlWwwH5XofTC3Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C3FB0107ACCA;
 Thu,  9 Jul 2020 19:44:16 +0000 (UTC)
Received: from localhost (unknown [10.36.110.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9DF946FEE5;
 Thu,  9 Jul 2020 19:44:12 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 12/13] gluster: add GUri-based URI parsing
Date: Thu,  9 Jul 2020 23:42:33 +0400
Message-Id: <20200709194234.2117650-13-marcandre.lureau@redhat.com>
In-Reply-To: <20200709194234.2117650-1-marcandre.lureau@redhat.com>
References: <20200709194234.2117650-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 10:34:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, integration@gluster.org,
 sheepdog@lists.wpkg.org, qemu-block@nongnu.org, Peter Lieven <pl@kamp.de>,
 "Richard W.M. Jones" <rjones@redhat.com>, Max Reitz <mreitz@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Liu Yuan <namei.unix@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 block/gluster.c | 81 +++++++++++++++++++++++++++++++++++++------------
 1 file changed, 61 insertions(+), 20 deletions(-)

diff --git a/block/gluster.c b/block/gluster.c
index c06eca1c12f..2cad76deabf 100644
--- a/block/gluster.c
+++ b/block/gluster.c
@@ -288,9 +288,9 @@ static void glfs_clear_preopened(glfs_t *fs)
     }
 }
 
-static int parse_volume_options(BlockdevOptionsGluster *gconf, char *path)
+static int parse_volume_options(BlockdevOptionsGluster *gconf, const char *path)
 {
-    char *p, *q;
+    const char *p, *q;
 
     if (!path) {
         return -EINVAL;
@@ -349,56 +349,97 @@ static int qemu_gluster_parse_uri(BlockdevOptionsGluster *gconf,
                                   const char *filename)
 {
     SocketAddress *gsconf;
+    bool is_unix = false;
+    int ret, port;
+    const char *scheme, *server, *path, *key = NULL, *value = NULL;
+    size_t nparams;
+
+#ifdef HAVE_GLIB_GURI
+    g_autoptr(GUri) uri = NULL;
+    g_autoptr(GHashTable) params = NULL;
+    g_autoptr(GError) err = NULL;
+
+    uri = g_uri_parse(filename, G_URI_FLAGS_ENCODED_QUERY, &err);
+    if (!uri) {
+        error_report("Failed to parse gluster URI: %s", err->message);
+        return -EINVAL;
+    }
+
+    params = g_uri_parse_params(g_uri_get_query(uri), -1,
+                                "&;", G_URI_PARAMS_NONE, &err);
+    if (err) {
+        error_report("Failed to parse gluster URI query: %s", err->message);
+        return -EINVAL;
+    }
+
+    scheme = g_uri_get_scheme(uri);
+    server = g_uri_get_host(uri);
+    port = g_uri_get_port(uri);
+    path = g_uri_get_path(uri);
+    nparams = g_hash_table_size(params);
+    g_hash_table_lookup_extended(params, "socket",
+                                 (void **)&key, (void **)&value);
+#else
     g_autoptr(URI) uri = NULL;
     g_autoptr(QueryParams) qp = NULL;
-    bool is_unix = false;
-    int ret;
 
     uri = uri_parse(filename);
     if (!uri) {
         return -EINVAL;
     }
 
+    qp = query_params_parse(uri->query);
+
+    scheme = uri->scheme;
+    server = uri->server;
+    port = uri->port;
+    path = uri->path;
+    nparams = qp->n;
+    if (nparams > 0) {
+        key = qp->p[0].name;
+        value = qp->p[0].value;
+    }
+#endif
+
+    if (nparams > 1 || (is_unix && !nparams) || (!is_unix && nparams)) {
+        return -EINVAL;
+    }
+
     gconf->server = g_new0(SocketAddressList, 1);
     gconf->server->value = gsconf = g_new0(SocketAddress, 1);
 
     /* transport */
-    if (!uri->scheme || !strcmp(uri->scheme, "gluster")) {
+    if (!scheme || !strcmp(scheme, "gluster")) {
         gsconf->type = SOCKET_ADDRESS_TYPE_INET;
-    } else if (!strcmp(uri->scheme, "gluster+tcp")) {
+    } else if (!strcmp(scheme, "gluster+tcp")) {
         gsconf->type = SOCKET_ADDRESS_TYPE_INET;
-    } else if (!strcmp(uri->scheme, "gluster+unix")) {
+    } else if (!strcmp(scheme, "gluster+unix")) {
         gsconf->type = SOCKET_ADDRESS_TYPE_UNIX;
         is_unix = true;
-    } else if (!strcmp(uri->scheme, "gluster+rdma")) {
+    } else if (!strcmp(scheme, "gluster+rdma")) {
         gsconf->type = SOCKET_ADDRESS_TYPE_INET;
         warn_report("rdma feature is not supported, falling back to tcp");
     } else {
         return -EINVAL;
     }
 
-    ret = parse_volume_options(gconf, uri->path);
+    ret = parse_volume_options(gconf, path);
     if (ret < 0) {
         return ret;
     }
 
-    qp = query_params_parse(uri->query);
-    if (qp->n > 1 || (is_unix && !qp->n) || (!is_unix && qp->n)) {
-        return -EINVAL;
-    }
-
     if (is_unix) {
-        if (uri->server || uri->port) {
+        if (server || port) {
             return -EINVAL;
         }
-        if (strcmp(qp->p[0].name, "socket")) {
+        if (g_strcmp0(key, "socket")) {
             return -EINVAL;
         }
-        gsconf->u.q_unix.path = g_strdup(qp->p[0].value);
+        gsconf->u.q_unix.path = g_strdup(value);
     } else {
-        gsconf->u.inet.host = g_strdup(uri->server ? uri->server : "localhost");
-        if (uri->port) {
-            gsconf->u.inet.port = g_strdup_printf("%d", uri->port);
+        gsconf->u.inet.host = g_strdup(server ? server : "localhost");
+        if (port) {
+            gsconf->u.inet.port = g_strdup_printf("%d", port);
         } else {
             gsconf->u.inet.port = g_strdup_printf("%d", GLUSTER_DEFAULT_PORT);
         }
-- 
2.27.0.221.ga08a83db2b


