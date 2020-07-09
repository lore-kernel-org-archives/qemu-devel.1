Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6331C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 19:46:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DC7D206DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 19:46:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L6Dfo7bF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DC7D206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtcUo-0003tv-LQ
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 15:46:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58870)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1jtcTA-0000hJ-Iz
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 15:44:32 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:32723
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1jtcT8-0000Y6-TM
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 15:44:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594323868;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tmQOmzoXNPFy7lvbkX3U0bBsr3nZbOM0fdmkkek9Xik=;
 b=L6Dfo7bFrpgwLoJsGchw0vEJfCYsCZCN9m1hMqCAeoOpzcq6HVdUFf/4wjURftJmXbZwS6
 tvbA1zTsgeyHsknqJxc8Jv7gubL8A0X6atTLtzz0P12gfriF502O0PDlh4a3TZ3y31s5nO
 edGO9rLXB1+Ia4rsjbq0Abse9W05pPc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-449-gX9a53mlOiyRFrluW6_zJQ-1; Thu, 09 Jul 2020 15:44:26 -0400
X-MC-Unique: gX9a53mlOiyRFrluW6_zJQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 825DF100A8E7;
 Thu,  9 Jul 2020 19:44:25 +0000 (UTC)
Received: from localhost (unknown [10.36.110.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3385C5D9C9;
 Thu,  9 Jul 2020 19:44:20 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 13/13] ssh: add GUri-based URI parsing
Date: Thu,  9 Jul 2020 23:42:34 +0400
Message-Id: <20200709194234.2117650-14-marcandre.lureau@redhat.com>
In-Reply-To: <20200709194234.2117650-1-marcandre.lureau@redhat.com>
References: <20200709194234.2117650-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 11:02:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
 block/ssh.c | 75 +++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 58 insertions(+), 17 deletions(-)

diff --git a/block/ssh.c b/block/ssh.c
index c8f6ad79e3c..d2bc6277613 100644
--- a/block/ssh.c
+++ b/block/ssh.c
@@ -180,9 +180,37 @@ static void sftp_error_trace(BDRVSSHState *s, const char *op)
 
 static int parse_uri(const char *filename, QDict *options, Error **errp)
 {
+    g_autofree char *port_str = NULL;
+    const char *scheme, *server, *path, *user, *key, *value;
+    gint port;
+
+#ifdef HAVE_GLIB_GURI
+    g_autoptr(GUri) uri = NULL;
+    g_autoptr(GHashTable) params = NULL;
+    g_autoptr(GError) err = NULL;
+    GHashTableIter iter;
+
+    uri = g_uri_parse(filename, G_URI_FLAGS_ENCODED_QUERY, &err);
+    if (!uri) {
+        error_setg(errp, "Failed to parse SSH URI: %s", err->message);
+        return -EINVAL;
+    }
+
+    params = g_uri_parse_params(g_uri_get_query(uri), -1,
+                                "&;", G_URI_PARAMS_NONE, &err);
+    if (err) {
+        error_report("Failed to parse SSH URI query: %s", err->message);
+        return -EINVAL;
+    }
+
+    scheme = g_uri_get_scheme(uri);
+    user = g_uri_get_user(uri);
+    server = g_uri_get_host(uri);
+    path = g_uri_get_path(uri);
+    port = g_uri_get_port(uri);
+#else
     g_autoptr(URI) uri = NULL;
     g_autoptr(QueryParams) qp = NULL;
-    g_autofree char *port_str = NULL;
     int i;
 
     uri = uri_parse(filename);
@@ -190,44 +218,57 @@ static int parse_uri(const char *filename, QDict *options, Error **errp)
         return -EINVAL;
     }
 
-    if (g_strcmp0(uri->scheme, "ssh") != 0) {
-        error_setg(errp, "URI scheme must be 'ssh'");
+    qp = query_params_parse(uri->query);
+    if (!qp) {
+        error_setg(errp, "could not parse query parameters");
         return -EINVAL;
     }
 
-    if (!uri->server || strcmp(uri->server, "") == 0) {
-        error_setg(errp, "missing hostname in URI");
+    scheme = uri->scheme;
+    user = uri->user;
+    server = uri->server;
+    path = uri->path;
+    port = uri->port;
+#endif
+    if (g_strcmp0(scheme, "ssh") != 0) {
+        error_setg(errp, "URI scheme must be 'ssh'");
         return -EINVAL;
     }
 
-    if (!uri->path || strcmp(uri->path, "") == 0) {
-        error_setg(errp, "missing remote path in URI");
+    if (!server || strcmp(server, "") == 0) {
+        error_setg(errp, "missing hostname in URI");
         return -EINVAL;
     }
 
-    qp = query_params_parse(uri->query);
-    if (!qp) {
-        error_setg(errp, "could not parse query parameters");
+    if (!path || strcmp(path, "") == 0) {
+        error_setg(errp, "missing remote path in URI");
         return -EINVAL;
     }
 
-    if(uri->user && strcmp(uri->user, "") != 0) {
-        qdict_put_str(options, "user", uri->user);
+    if (user && strcmp(user, "") != 0) {
+        qdict_put_str(options, "user", user);
     }
 
-    qdict_put_str(options, "server.host", uri->server);
+    qdict_put_str(options, "server.host", server);
 
-    port_str = g_strdup_printf("%d", uri->port ?: 22);
+    port_str = g_strdup_printf("%d", port ?: 22);
     qdict_put_str(options, "server.port", port_str);
 
-    qdict_put_str(options, "path", uri->path);
+    qdict_put_str(options, "path", path);
 
     /* Pick out any query parameters that we understand, and ignore
      * the rest.
      */
+#ifdef HAVE_GLIB_GURI
+    g_hash_table_iter_init(&iter, params);
+    while (g_hash_table_iter_next(&iter, (void **)&key, (void **)&value)) {
+#else
     for (i = 0; i < qp->n; ++i) {
-        if (strcmp(qp->p[i].name, "host_key_check") == 0) {
-            qdict_put_str(options, "host_key_check", qp->p[i].value);
+        key = qp->p[i].name;
+        value = qp->p[i].value;
+#endif
+        if (g_strcmp0(key, "host_key_check") == 0) {
+            qdict_put_str(options, "host_key_check", value);
         }
     }
 
-- 
2.27.0.221.ga08a83db2b


