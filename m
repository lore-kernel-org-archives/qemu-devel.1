Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A32A6C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 19:48:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68A36206DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 19:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fo1RCabv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68A36206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtcXO-0007vT-KM
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 15:48:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58634)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1jtcSd-0007dU-6M
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 15:43:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37184
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1jtcSb-0000SU-Jt
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 15:43:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594323836;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pk3jIQFr9iRGsjTDLaCnZKtMC1NMpbKjg4fliRW6U+4=;
 b=fo1RCabvnpBMAbik8YsJjBs/frH4sfaNt64uCtxtIRXaDdg1EDS4MTj0Va3pumLKiS93xK
 Vyh8FnO8sqB5bKTS2oHzH23q8gU0MtZeJSbaWYqErFwp0VjKwubk4DMHOynltPqye6OerF
 fSYKSTEfXEYyHUcMZ1pS/d7NURlF/xY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-TmxEc6QKOAmjWnysWdc2uw-1; Thu, 09 Jul 2020 15:43:53 -0400
X-MC-Unique: TmxEc6QKOAmjWnysWdc2uw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0FB80100A8E7;
 Thu,  9 Jul 2020 19:43:52 +0000 (UTC)
Received: from localhost (unknown [10.36.110.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0901E5C1C3;
 Thu,  9 Jul 2020 19:43:47 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 09/13] nbd: add GUri-based URI parsing version
Date: Thu,  9 Jul 2020 23:42:30 +0400
Message-Id: <20200709194234.2117650-10-marcandre.lureau@redhat.com>
In-Reply-To: <20200709194234.2117650-1-marcandre.lureau@redhat.com>
References: <20200709194234.2117650-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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
 block/nbd.c        | 86 +++++++++++++++++++++++++++++++++++-----------
 util/Makefile.objs |  2 +-
 2 files changed, 66 insertions(+), 22 deletions(-)

diff --git a/block/nbd.c b/block/nbd.c
index faadcab442b..fdc4a53a98f 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -31,7 +31,10 @@
 #include "qemu/osdep.h"
 
 #include "trace.h"
+#ifndef HAVE_GLIB_GURI
 #include "qemu/uri.h"
+#endif
+#include "qemu/error-report.h"
 #include "qemu/option.h"
 #include "qemu/cutils.h"
 #include "qemu/main-loop.h"
@@ -1513,71 +1516,112 @@ static int nbd_client_connect(BlockDriverState *bs, Error **errp)
 /*
  * Parse nbd_open options
  */
-
 static int nbd_parse_uri(const char *filename, QDict *options)
 {
+    const char *p, *scheme, *server, *socket = NULL;
+    int port;
+    bool is_unix;
+
+#ifdef HAVE_GLIB_GURI
+    g_autoptr(GUri) uri = NULL;
+    g_autoptr(GHashTable) params = NULL;
+    g_autoptr(GError) err = NULL;
+
+    uri = g_uri_parse(filename, G_URI_FLAGS_ENCODED_QUERY, &err);
+    if (!uri) {
+        error_report("Failed to parse NBD URI: %s", err->message);
+        return -EINVAL;
+    }
+
+    p = g_uri_get_path(uri);
+    scheme = g_uri_get_scheme(uri);
+    server = g_uri_get_host(uri);
+    port = g_uri_get_port(uri);
+#else
     g_autoptr(URI) uri = NULL;
     g_autoptr(QueryParams) qp = NULL;
-    const char *p;
-    bool is_unix;
 
     uri = uri_parse(filename);
     if (!uri) {
         return -EINVAL;
     }
 
+    p = uri->path ? uri->path : "";
+    scheme = uri->scheme;
+    server = uri->server;
+    port = uri->port;
+#endif
     /* transport */
-    if (!g_strcmp0(uri->scheme, "nbd")) {
+    if (!g_strcmp0(scheme, "nbd")) {
         is_unix = false;
-    } else if (!g_strcmp0(uri->scheme, "nbd+tcp")) {
+    } else if (!g_strcmp0(scheme, "nbd+tcp")) {
         is_unix = false;
-    } else if (!g_strcmp0(uri->scheme, "nbd+unix")) {
+    } else if (!g_strcmp0(scheme, "nbd+unix")) {
         is_unix = true;
     } else {
         return -EINVAL;
     }
-
-    p = uri->path ? uri->path : "";
-    if (p[0] == '/') {
-        p++;
+#ifdef HAVE_GLIB_GURI
+    params = g_uri_parse_params(g_uri_get_query(uri), -1,
+                                "&;", G_URI_PARAMS_NONE, &err);
+    if (err) {
+        error_report("Failed to parse NBD URI query: %s", err->message);
+        return -EINVAL;
     }
-    if (p[0]) {
-        qdict_put_str(options, "export", p);
+    if ((is_unix && g_hash_table_size(params) != 1) ||
+        (!is_unix && g_hash_table_size(params) != 0)) {
+        return -EINVAL;
     }
-
+    if (is_unix) {
+        socket = g_hash_table_lookup(params, "socket");
+    }
+#else
     qp = query_params_parse(uri->query);
     if (qp->n > 1 || (is_unix && !qp->n) || (!is_unix && qp->n)) {
         return -EINVAL;
     }
+    if (is_unix) {
+        if (!g_str_equal(qp->p[0].name, "socket")) {
+            return -EINVAL;
+        }
+        socket = qp->p[0].value;
+    }
+#endif
+    if (p[0] == '/') {
+        p++;
+    }
+    if (p[0]) {
+        qdict_put_str(options, "export", p);
+    }
 
     if (is_unix) {
         /* nbd+unix:///export?socket=path */
-        if (uri->server || uri->port || strcmp(qp->p[0].name, "socket")) {
+        if (server || port > 0) {
             return -EINVAL;
         }
         qdict_put_str(options, "server.type", "unix");
-        qdict_put_str(options, "server.path", qp->p[0].value);
+        qdict_put_str(options, "server.path", socket);
     } else {
         QString *host;
         g_autofree char *port_str = NULL;
 
         /* nbd[+tcp]://host[:port]/export */
-        if (!uri->server) {
+        if (!server) {
             return -EINVAL;
         }
 
         /* strip braces from literal IPv6 address */
-        if (uri->server[0] == '[') {
-            host = qstring_from_substr(uri->server, 1,
-                                       strlen(uri->server) - 1);
+        if (server[0] == '[') {
+            host = qstring_from_substr(server, 1,
+                                       strlen(server) - 1);
         } else {
-            host = qstring_from_str(uri->server);
+            host = qstring_from_str(server);
         }
 
         qdict_put_str(options, "server.type", "inet");
         qdict_put(options, "server.host", host);
 
-        port_str = g_strdup_printf("%d", uri->port ?: NBD_DEFAULT_PORT);
+        port_str = g_strdup_printf("%d", port > 0 ? port : NBD_DEFAULT_PORT);
         qdict_put_str(options, "server.port", port_str);
     }
 
diff --git a/util/Makefile.objs b/util/Makefile.objs
index cc5e37177af..5a162178ae9 100644
--- a/util/Makefile.objs
+++ b/util/Makefile.objs
@@ -73,7 +73,7 @@ util-obj-y += qemu-timer.o
 util-obj-y += thread-pool.o
 util-obj-y += throttle.o
 util-obj-y += timed-average.o
-util-obj-y += uri.o
+util-obj-$(call lnot,$(HAVE_GLIB_GURI)) += uri.o
 
 util-obj-$(CONFIG_LINUX) += vfio-helpers.o
 util-obj-$(CONFIG_INOTIFY1) += filemonitor-inotify.o
-- 
2.27.0.221.ga08a83db2b


