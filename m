Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CCC7C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 19:46:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 354F0206DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 19:46:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JgmrPsOg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 354F0206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtcVQ-0005Ke-GE
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 15:46:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58388)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1jtcS1-00069y-NM
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 15:43:21 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:51697
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1jtcS0-0000OY-15
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 15:43:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594323799;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nmjlxskDCNemjY9i5T2AIdzGVyyu8NbAXBMJEbycPOk=;
 b=JgmrPsOgPkWsH12KaRIpyVRrexd0E7K3xM3hcl119SY/0OtNDRo582CSqFf/SqT6nYAGty
 K83l6jtATFpB716XiCeWzAcKEfOR6lODoy13cK/UBJJUxfjCgfISziPsqeVb6TuHFzrN+3
 hY8y8CnkTI/U2ft4sKA49dzikhseJ2U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-380-M8iumT7oN4qMotzwYR6COg-1; Thu, 09 Jul 2020 15:43:15 -0400
X-MC-Unique: M8iumT7oN4qMotzwYR6COg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 730DCC7465;
 Thu,  9 Jul 2020 19:43:14 +0000 (UTC)
Received: from localhost (unknown [10.36.110.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 460F160C80;
 Thu,  9 Jul 2020 19:43:09 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 04/13] block/sheepdog: auto-ify URI parsing variables
Date: Thu,  9 Jul 2020 23:42:25 +0400
Message-Id: <20200709194234.2117650-5-marcandre.lureau@redhat.com>
In-Reply-To: <20200709194234.2117650-1-marcandre.lureau@redhat.com>
References: <20200709194234.2117650-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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

Since we are going to introduce URI parsing alternative, I changed the
way SheepdogConfig takes care of host/path & URI/QueryParams lifetimes.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 block/sheepdog.c | 72 ++++++++++++++++++++----------------------------
 1 file changed, 30 insertions(+), 42 deletions(-)

diff --git a/block/sheepdog.c b/block/sheepdog.c
index 27a30d17f4c..3403adfc2cd 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -986,39 +986,33 @@ static bool sd_parse_snapid_or_tag(const char *str,
 }
 
 typedef struct {
-    const char *path;           /* non-null iff transport is tcp */
-    const char *host;           /* valid when transport is tcp */
+    char *path;                 /* non-null iff transport is tcp */
+    char *host;                 /* valid when transport is tcp */
     int port;                   /* valid when transport is tcp */
     char vdi[SD_MAX_VDI_LEN];
     char tag[SD_MAX_VDI_TAG_LEN];
     uint32_t snap_id;
-    /* Remainder is only for sd_config_done() */
-    URI *uri;
-    QueryParams *qp;
 } SheepdogConfig;
 
 static void sd_config_done(SheepdogConfig *cfg)
 {
-    if (cfg->qp) {
-        query_params_free(cfg->qp);
-    }
-    uri_free(cfg->uri);
+    g_clear_pointer(&cfg->host, g_free);
+    g_clear_pointer(&cfg->path, g_free);
 }
 
 static void sd_parse_uri(SheepdogConfig *cfg, const char *filename,
                          Error **errp)
 {
-    Error *err = NULL;
-    QueryParams *qp = NULL;
+    g_autoptr(QueryParams) qp = NULL;
+    g_autoptr(URI) uri = NULL;
     bool is_unix;
-    URI *uri;
 
     memset(cfg, 0, sizeof(*cfg));
 
-    cfg->uri = uri = uri_parse(filename);
+    uri = uri_parse(filename);
     if (!uri) {
-        error_setg(&err, "invalid URI '%s'", filename);
-        goto out;
+        error_setg(errp, "invalid URI '%s'", filename);
+        return;
     }
 
     /* transport */
@@ -1029,48 +1023,48 @@ static void sd_parse_uri(SheepdogConfig *cfg, const char *filename,
     } else if (!g_strcmp0(uri->scheme, "sheepdog+unix")) {
         is_unix = true;
     } else {
-        error_setg(&err, "URI scheme must be 'sheepdog', 'sheepdog+tcp',"
+        error_setg(errp, "URI scheme must be 'sheepdog', 'sheepdog+tcp',"
                    " or 'sheepdog+unix'");
-        goto out;
+        return;
     }
 
     if (uri->path == NULL || !strcmp(uri->path, "/")) {
-        error_setg(&err, "missing file path in URI");
-        goto out;
+        error_setg(errp, "missing file path in URI");
+        return;
     }
     if (g_strlcpy(cfg->vdi, uri->path + 1, SD_MAX_VDI_LEN)
         >= SD_MAX_VDI_LEN) {
-        error_setg(&err, "VDI name is too long");
-        goto out;
+        error_setg(errp, "VDI name is too long");
+        return;
     }
 
-    cfg->qp = qp = query_params_parse(uri->query);
+    qp = query_params_parse(uri->query);
 
     if (is_unix) {
         /* sheepdog+unix:///vdiname?socket=path */
         if (uri->server || uri->port) {
-            error_setg(&err, "URI scheme %s doesn't accept a server address",
+            error_setg(errp, "URI scheme %s doesn't accept a server address",
                        uri->scheme);
-            goto out;
+            return;
         }
         if (!qp->n) {
-            error_setg(&err,
+            error_setg(errp,
                        "URI scheme %s requires query parameter 'socket'",
                        uri->scheme);
-            goto out;
+            return;
         }
         if (qp->n != 1 || strcmp(qp->p[0].name, "socket")) {
-            error_setg(&err, "unexpected query parameters");
-            goto out;
+            error_setg(errp, "unexpected query parameters");
+            return;
         }
-        cfg->path = qp->p[0].value;
+        cfg->path = g_strdup(qp->p[0].value);
     } else {
         /* sheepdog[+tcp]://[host:port]/vdiname */
         if (qp->n) {
-            error_setg(&err, "unexpected query parameters");
-            goto out;
+            error_setg(errp, "unexpected query parameters");
+            return;
         }
-        cfg->host = uri->server;
+        cfg->host = g_strdup(uri->server);
         cfg->port = uri->port;
     }
 
@@ -1078,19 +1072,13 @@ static void sd_parse_uri(SheepdogConfig *cfg, const char *filename,
     if (uri->fragment) {
         if (!sd_parse_snapid_or_tag(uri->fragment,
                                     &cfg->snap_id, cfg->tag)) {
-            error_setg(&err, "'%s' is not a valid snapshot ID",
+            error_setg(errp, "'%s' is not a valid snapshot ID",
                        uri->fragment);
-            goto out;
+            return;
         }
     } else {
         cfg->snap_id = CURRENT_VDI_ID; /* search current vdi */
     }
-
-out:
-    if (err) {
-        error_propagate(errp, err);
-        sd_config_done(cfg);
-    }
 }
 
 /*
@@ -1184,7 +1172,7 @@ static void sd_parse_filename(const char *filename, QDict *options,
     }
     if (err) {
         error_propagate(errp, err);
-        return;
+        goto end;
     }
 
     if (cfg.path) {
@@ -1203,7 +1191,7 @@ static void sd_parse_filename(const char *filename, QDict *options,
         snprintf(buf, sizeof(buf), "%d", cfg.snap_id);
         qdict_set_default_str(options, "snap-id", buf);
     }
-
+end:
     sd_config_done(&cfg);
 }
 
-- 
2.27.0.221.ga08a83db2b


