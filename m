Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CADA0C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 19:50:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96C4720748
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 19:50:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GF7To2tG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96C4720748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtcYm-00022v-Ri
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 15:50:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58710)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1jtcSk-0007xD-LO
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 15:44:06 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:55909
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1jtcSh-0000UE-N6
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 15:44:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594323843;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=orucUJs9BYwbheLQH90BU619ZShw7HpU2oMyGQO+ISQ=;
 b=GF7To2tGppuvQ63kun5952sbZiEM3H3q2Loa5RQa1X+VupkPnxaHm3cU+onnrRAuuJDPjZ
 9gYUtYFqyGoctbkUmfS5cFTMigcVeoqjU+BmGEMcYBPhH+m4PVWdD4TfcBXVCeSgJI6PEs
 2uUjL8xlDA/cJ57djDK1nryk6QdeTec=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404-SMNxH5eBM9mvJOnUQYAfdQ-1; Thu, 09 Jul 2020 15:44:01 -0400
X-MC-Unique: SMNxH5eBM9mvJOnUQYAfdQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 22B2F1B18BC0;
 Thu,  9 Jul 2020 19:44:00 +0000 (UTC)
Received: from localhost (unknown [10.36.110.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0E3F410013D4;
 Thu,  9 Jul 2020 19:43:55 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 10/13] sheepdog: add GUri-based URI parsing
Date: Thu,  9 Jul 2020 23:42:31 +0400
Message-Id: <20200709194234.2117650-11-marcandre.lureau@redhat.com>
In-Reply-To: <20200709194234.2117650-1-marcandre.lureau@redhat.com>
References: <20200709194234.2117650-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 block/sheepdog.c | 99 ++++++++++++++++++++++++++++++++++--------------
 1 file changed, 71 insertions(+), 28 deletions(-)

diff --git a/block/sheepdog.c b/block/sheepdog.c
index 3403adfc2cd..3f3f5b7dba9 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -1003,24 +1003,48 @@ static void sd_config_done(SheepdogConfig *cfg)
 static void sd_parse_uri(SheepdogConfig *cfg, const char *filename,
                          Error **errp)
 {
-    g_autoptr(QueryParams) qp = NULL;
-    g_autoptr(URI) uri = NULL;
+    const char *scheme, *server, *path, *fragment, *socket = NULL;
+    int port;
     bool is_unix;
 
-    memset(cfg, 0, sizeof(*cfg));
+#ifdef HAVE_GLIB_GURI
+    g_autoptr(GUri) uri = NULL;
+    g_autoptr(GHashTable) params = NULL;
+    g_autoptr(GError) err = NULL;
+
+    uri = g_uri_parse(filename, G_URI_FLAGS_ENCODED_QUERY, &err);
+    if (!uri) {
+        error_report("Failed to parse sheepdog URI: %s", err->message);
+        return;
+    }
+    scheme = g_uri_get_scheme(uri);
+    server = g_uri_get_host(uri);
+    port = g_uri_get_port(uri);
+    path = g_uri_get_path(uri);
+    fragment = g_uri_get_fragment(uri);
+#else
+    g_autoptr(QueryParams) qp = NULL;
+    g_autoptr(URI) uri = NULL;
 
     uri = uri_parse(filename);
     if (!uri) {
         error_setg(errp, "invalid URI '%s'", filename);
         return;
     }
+    scheme = uri->scheme;
+    server = uri->server;
+    port = uri->port;
+    path = uri->path;
+    fragment = uri->fragment;
+#endif
+    memset(cfg, 0, sizeof(*cfg));
 
     /* transport */
-    if (!g_strcmp0(uri->scheme, "sheepdog")) {
+    if (!g_strcmp0(scheme, "sheepdog")) {
         is_unix = false;
-    } else if (!g_strcmp0(uri->scheme, "sheepdog+tcp")) {
+    } else if (!g_strcmp0(scheme, "sheepdog+tcp")) {
         is_unix = false;
-    } else if (!g_strcmp0(uri->scheme, "sheepdog+unix")) {
+    } else if (!g_strcmp0(scheme, "sheepdog+unix")) {
         is_unix = true;
     } else {
         error_setg(errp, "URI scheme must be 'sheepdog', 'sheepdog+tcp',"
@@ -1028,52 +1052,71 @@ static void sd_parse_uri(SheepdogConfig *cfg, const char *filename,
         return;
     }
 
-    if (uri->path == NULL || !strcmp(uri->path, "/")) {
+#ifdef HAVE_GLIB_GURI
+    params = g_uri_parse_params(g_uri_get_query(uri), -1,
+                                "&;", G_URI_PARAMS_NONE, &err);
+    if (err) {
+        error_report("Failed to parse sheepdog URI query: %s", err->message);
+        return;
+    }
+    if ((is_unix && g_hash_table_size(params) != 1) ||
+        (!is_unix && g_hash_table_size(params) != 0)) {
+        error_setg(errp, "unexpected query parameters");
+        return;
+    }
+    if (is_unix) {
+        socket = g_hash_table_lookup(params, "socket");
+    }
+#else
+    qp = query_params_parse(uri->query);
+    if (qp->n > 1 || (is_unix && !qp->n) || (!is_unix && qp->n)) {
+        error_setg(errp, "unexpected query parameters");
+        return;
+    }
+    if (is_unix) {
+        if (!g_str_equal(qp->p[0].name, "socket")) {
+            error_setg(errp, "unexpected query parameters");
+            return;
+        }
+        socket = qp->p[0].value;
+    }
+#endif
+    if (path == NULL || !strcmp(path, "/")) {
         error_setg(errp, "missing file path in URI");
         return;
     }
-    if (g_strlcpy(cfg->vdi, uri->path + 1, SD_MAX_VDI_LEN)
+    if (g_strlcpy(cfg->vdi, path + 1, SD_MAX_VDI_LEN)
         >= SD_MAX_VDI_LEN) {
         error_setg(errp, "VDI name is too long");
         return;
     }
 
-    qp = query_params_parse(uri->query);
-
     if (is_unix) {
         /* sheepdog+unix:///vdiname?socket=path */
-        if (uri->server || uri->port) {
+        if (server || port > 0) {
             error_setg(errp, "URI scheme %s doesn't accept a server address",
-                       uri->scheme);
+                       scheme);
             return;
         }
-        if (!qp->n) {
+        if (!socket) {
             error_setg(errp,
                        "URI scheme %s requires query parameter 'socket'",
-                       uri->scheme);
-            return;
-        }
-        if (qp->n != 1 || strcmp(qp->p[0].name, "socket")) {
-            error_setg(errp, "unexpected query parameters");
+                       scheme);
             return;
         }
-        cfg->path = g_strdup(qp->p[0].value);
+        cfg->path = g_strdup(socket);
     } else {
         /* sheepdog[+tcp]://[host:port]/vdiname */
-        if (qp->n) {
-            error_setg(errp, "unexpected query parameters");
-            return;
-        }
-        cfg->host = g_strdup(uri->server);
-        cfg->port = uri->port;
+        cfg->host = g_strdup(server);
+        cfg->port = port;
     }
 
     /* snapshot tag */
-    if (uri->fragment) {
-        if (!sd_parse_snapid_or_tag(uri->fragment,
+    if (fragment) {
+        if (!sd_parse_snapid_or_tag(fragment,
                                     &cfg->snap_id, cfg->tag)) {
             error_setg(errp, "'%s' is not a valid snapshot ID",
-                       uri->fragment);
+                       fragment);
             return;
         }
     } else {
-- 
2.27.0.221.ga08a83db2b


