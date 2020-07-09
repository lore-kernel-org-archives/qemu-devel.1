Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC1C5C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 19:45:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84DE5206DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 19:45:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FpqFdxvL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84DE5206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtcUF-0002eY-LA
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 15:45:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58760)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1jtcSs-0008Gy-1E
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 15:44:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35571
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1jtcSq-0000VI-Ar
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 15:44:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594323851;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4nWAkxL+6X+c3wT2WAkpUYykog4EA/234RQqsdrw+6k=;
 b=FpqFdxvLog40xdlOX3OrC38EY+WJ2wz3fa5JjE3n6GEqWqy/o8z6A5it7Aaya2MpMETw09
 LRTA2+yHy0H2iyoPew5JTkKXnJsk5FCORpTvUQ3EbRifJ5f6GQVWgA6TDYHR7eSdXB+dC8
 yA7fMzBbEGQxLlBTyIO3u8kjYgaF7hE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-c1oawY6qOZ6IkrNwIHI7Ig-1; Thu, 09 Jul 2020 15:44:09 -0400
X-MC-Unique: c1oawY6qOZ6IkrNwIHI7Ig-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 82E5D100A8E9;
 Thu,  9 Jul 2020 19:44:08 +0000 (UTC)
Received: from localhost (unknown [10.36.110.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5414079CF4;
 Thu,  9 Jul 2020 19:44:03 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 11/13] nfs: add GUri-based URI parsing
Date: Thu,  9 Jul 2020 23:42:32 +0400
Message-Id: <20200709194234.2117650-12-marcandre.lureau@redhat.com>
In-Reply-To: <20200709194234.2117650-1-marcandre.lureau@redhat.com>
References: <20200709194234.2117650-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120;
 envelope-from=marcandre.lureau@redhat.com; helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 11:02:45
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
 block/nfs.c | 96 ++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 65 insertions(+), 31 deletions(-)

diff --git a/block/nfs.c b/block/nfs.c
index 93d719551d2..0b24044535d 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -77,6 +77,31 @@ typedef struct NFSRPC {
 
 static int nfs_parse_uri(const char *filename, QDict *options, Error **errp)
 {
+    const char *scheme, *server, *path, *key, *value;
+
+#ifdef HAVE_GLIB_GURI
+    g_autoptr(GUri) uri = NULL;
+    g_autoptr(GHashTable) params = NULL;
+    g_autoptr(GError) err = NULL;
+    GHashTableIter iter;
+
+    uri = g_uri_parse(filename, G_URI_FLAGS_ENCODED_QUERY, &err);
+    if (!uri) {
+        error_setg(errp, "Failed to parse NFS URI: %s", err->message);
+        return -EINVAL;
+    }
+
+    params = g_uri_parse_params(g_uri_get_query(uri), -1,
+                                "&;", G_URI_PARAMS_NONE, &err);
+    if (err) {
+        error_report("Failed to parse NFS URI query: %s", err->message);
+        return -EINVAL;
+    }
+
+    scheme = g_uri_get_scheme(uri);
+    server = g_uri_get_host(uri);
+    path = g_uri_get_path(uri);
+#else
     g_autoptr(URI) uri = NULL;
     g_autoptr(QueryParams) qp = NULL;
     int i;
@@ -86,58 +111,67 @@ static int nfs_parse_uri(const char *filename, QDict *options, Error **errp)
         error_setg(errp, "Invalid URI specified");
         return -EINVAL;
     }
-    if (g_strcmp0(uri->scheme, "nfs") != 0) {
-        error_setg(errp, "URI scheme must be 'nfs'");
+
+    qp = query_params_parse(uri->query);
+    if (!qp) {
+        error_setg(errp, "could not parse query parameters");
         return -EINVAL;
     }
 
-    if (!uri->server) {
-        error_setg(errp, "missing hostname in URI");
+    scheme = uri->scheme;
+    server = uri->server;
+    path = uri->path;
+#endif
+    if (g_strcmp0(scheme, "nfs") != 0) {
+        error_setg(errp, "URI scheme must be 'nfs'");
         return -EINVAL;
     }
 
-    if (!uri->path) {
-        error_setg(errp, "missing file path in URI");
+    if (!server) {
+        error_setg(errp, "missing hostname in URI");
         return -EINVAL;
     }
 
-    qp = query_params_parse(uri->query);
-    if (!qp) {
-        error_setg(errp, "could not parse query parameters");
+    if (!path) {
+        error_setg(errp, "missing file path in URI");
         return -EINVAL;
     }
 
-    qdict_put_str(options, "server.host", uri->server);
+    qdict_put_str(options, "server.host", server);
     qdict_put_str(options, "server.type", "inet");
-    qdict_put_str(options, "path", uri->path);
+    qdict_put_str(options, "path", path);
 
+#ifdef HAVE_GLIB_GURI
+    g_hash_table_iter_init(&iter, params);
+    while (g_hash_table_iter_next(&iter, (void **)&key, (void **)&value)) {
+#else
     for (i = 0; i < qp->n; i++) {
+        key = qp->p[i].name;
+        value = qp->p[i].value;
+#endif
         unsigned long long val;
-        if (!qp->p[i].value) {
-            error_setg(errp, "Value for NFS parameter expected: %s",
-                       qp->p[i].name);
+        if (!value) {
+            error_setg(errp, "Value for NFS parameter expected: %s", key);
             return -EINVAL;
         }
-        if (parse_uint_full(qp->p[i].value, &val, 0)) {
-            error_setg(errp, "Illegal value for NFS parameter: %s",
-                       qp->p[i].name);
+        if (parse_uint_full(value, &val, 0)) {
+            error_setg(errp, "Illegal value for NFS parameter: %s", key);
             return -EINVAL;
         }
-        if (!strcmp(qp->p[i].name, "uid")) {
-            qdict_put_str(options, "user", qp->p[i].value);
-        } else if (!strcmp(qp->p[i].name, "gid")) {
-            qdict_put_str(options, "group", qp->p[i].value);
-        } else if (!strcmp(qp->p[i].name, "tcp-syncnt")) {
-            qdict_put_str(options, "tcp-syn-count", qp->p[i].value);
-        } else if (!strcmp(qp->p[i].name, "readahead")) {
-            qdict_put_str(options, "readahead-size", qp->p[i].value);
-        } else if (!strcmp(qp->p[i].name, "pagecache")) {
-            qdict_put_str(options, "page-cache-size", qp->p[i].value);
-        } else if (!strcmp(qp->p[i].name, "debug")) {
-            qdict_put_str(options, "debug", qp->p[i].value);
+        if (!strcmp(key, "uid")) {
+            qdict_put_str(options, "user", value);
+        } else if (!strcmp(key, "gid")) {
+            qdict_put_str(options, "group", value);
+        } else if (!strcmp(key, "tcp-syncnt")) {
+            qdict_put_str(options, "tcp-syn-count", value);
+        } else if (!strcmp(key, "readahead")) {
+            qdict_put_str(options, "readahead-size", value);
+        } else if (!strcmp(key, "pagecache")) {
+            qdict_put_str(options, "page-cache-size", value);
+        } else if (!strcmp(key, "debug")) {
+            qdict_put_str(options, "debug", value);
         } else {
-            error_setg(errp, "Unknown NFS parameter name: %s",
-                       qp->p[i].name);
+            error_setg(errp, "Unknown NFS parameter name: %s", key);
             return -EINVAL;
         }
     }
-- 
2.27.0.221.ga08a83db2b


