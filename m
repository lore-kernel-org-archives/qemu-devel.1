Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E330AC4727E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 20:34:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39601206FC
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 20:34:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FO/Smi+E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39601206FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLuQN-0002jX-Ac
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 16:34:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46538)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kLuOs-0001P0-Br
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 16:33:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50433)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kLuOq-0004hH-6M
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 16:33:01 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601065979;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mPj7nn1jIF484UQtbNudZY2mWhzmnzITwVFl2WATscQ=;
 b=FO/Smi+E3vL3/IVLPiHHfHVL60B4dE1ibjRCeEYfDbaJEZBVzqnMZWMil2Sxw1LV1LDVNs
 H5tnFGAL6b5xDjZ8gmiK4VlYBk33uKHr7r8O6Qb2WDX7CVVgVI72qnurHeq7FwSy+He/RV
 itYgUc1q+AgME9iyjN5LfruBic1PFlc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-500-NRyy2JCZN-21PkHZfeVlVw-1; Fri, 25 Sep 2020 16:32:57 -0400
X-MC-Unique: NRyy2JCZN-21PkHZfeVlVw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 693341DE05;
 Fri, 25 Sep 2020 20:32:56 +0000 (UTC)
Received: from blue.redhat.com (ovpn-114-148.phx2.redhat.com [10.3.114.148])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B35E65C1BB;
 Fri, 25 Sep 2020 20:32:55 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/3] nbd: Simplify meta-context parsing
Date: Fri, 25 Sep 2020 15:32:47 -0500
Message-Id: <20200925203249.155705-2-eblake@redhat.com>
In-Reply-To: <20200925203249.155705-1-eblake@redhat.com>
References: <20200925203249.155705-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 01:07:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
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
Cc: pkrempa@redhat.com, vsementsov@virtuozzo.com, rjones@redhat.com,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We had a premature optimization of trying to read as little from the
wire as possible while handling NBD_OPT_SET_META_CONTEXT in phases.
But in reality, we HAVE to read the entire string from the client
before we can get to the next command, and it is easier to just read
it all at once than it is to read it in pieces.  And once we do that,
several functions end up no longer performing I/O, and no longer need
to return a value.

While simplifying this, take advantage of g_str_has_prefix for less
repetition of boilerplate string length computation.

Our iotests still pass; I also checked that libnbd's testsuite (which
covers more corner cases of odd meta context requests) still passes.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 nbd/server.c | 172 ++++++++++++++-------------------------------------
 1 file changed, 47 insertions(+), 125 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index 982de67816a7..0d2d7e52058f 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -1,5 +1,5 @@
 /*
- *  Copyright (C) 2016-2018 Red Hat, Inc.
+ *  Copyright (C) 2016-2020 Red Hat, Inc.
  *  Copyright (C) 2005  Anthony Liguori <anthony@codemonkey.ws>
  *
  *  Network Block Device Server Side
@@ -792,135 +792,64 @@ static int nbd_negotiate_send_meta_context(NBDClient *client,
     return qio_channel_writev_all(client->ioc, iov, 2, errp) < 0 ? -EIO : 0;
 }

-/* Read strlen(@pattern) bytes, and set @match to true if they match @pattern.
- * @match is never set to false.
- *
- * Return -errno on I/O error, 0 if option was completely handled by
- * sending a reply about inconsistent lengths, or 1 on success.
- *
- * Note: return code = 1 doesn't mean that we've read exactly @pattern.
- * It only means that there are no errors.
+
+/*
+ * Check @ns with @len bytes, and set @match to true if it matches @pattern,
+ * or if @len is 0 and the client is performing _LIST_. @match is never set
+ * to false.
  */
-static int nbd_meta_pattern(NBDClient *client, const char *pattern, bool *match,
-                            Error **errp)
+static void nbd_meta_empty_or_pattern(NBDClient *client, const char *pattern,
+                                      const char *ns, uint32_t len,
+                                      bool *match, Error **errp)
 {
-    int ret;
-    char *query;
-    size_t len = strlen(pattern);
-
-    assert(len);
-
-    query = g_malloc(len);
-    ret = nbd_opt_read(client, query, len, errp);
-    if (ret <= 0) {
-        g_free(query);
-        return ret;
-    }
-
-    if (strncmp(query, pattern, len) == 0) {
+    if (len == 0) {
+        if (client->opt == NBD_OPT_LIST_META_CONTEXT) {
+            *match = true;
+        }
+        trace_nbd_negotiate_meta_query_parse("empty");
+    } else if (strcmp(pattern, ns) == 0) {
         trace_nbd_negotiate_meta_query_parse(pattern);
         *match = true;
     } else {
         trace_nbd_negotiate_meta_query_skip("pattern not matched");
     }
-    g_free(query);
-
-    return 1;
-}
-
-/*
- * Read @len bytes, and set @match to true if they match @pattern, or if @len
- * is 0 and the client is performing _LIST_. @match is never set to false.
- *
- * Return -errno on I/O error, 0 if option was completely handled by
- * sending a reply about inconsistent lengths, or 1 on success.
- *
- * Note: return code = 1 doesn't mean that we've read exactly @pattern.
- * It only means that there are no errors.
- */
-static int nbd_meta_empty_or_pattern(NBDClient *client, const char *pattern,
-                                     uint32_t len, bool *match, Error **errp)
-{
-    if (len == 0) {
-        if (client->opt == NBD_OPT_LIST_META_CONTEXT) {
-            *match = true;
-        }
-        trace_nbd_negotiate_meta_query_parse("empty");
-        return 1;
-    }
-
-    if (len != strlen(pattern)) {
-        trace_nbd_negotiate_meta_query_skip("different lengths");
-        return nbd_opt_skip(client, len, errp);
-    }
-
-    return nbd_meta_pattern(client, pattern, match, errp);
 }

 /* nbd_meta_base_query
  *
  * Handle queries to 'base' namespace. For now, only the base:allocation
- * context is available.  'len' is the amount of text remaining to be read from
- * the current name, after the 'base:' portion has been stripped.
- *
- * Return -errno on I/O error, 0 if option was completely handled by
- * sending a reply about inconsistent lengths, or 1 on success.
+ * context is available.  @len is the length of @ns, including the 'base:'
+ * prefix.
  */
-static int nbd_meta_base_query(NBDClient *client, NBDExportMetaContexts *meta,
-                               uint32_t len, Error **errp)
+static void nbd_meta_base_query(NBDClient *client, NBDExportMetaContexts *meta,
+                                const char *ns, uint32_t len, Error **errp)
 {
-    return nbd_meta_empty_or_pattern(client, "allocation", len,
-                                     &meta->base_allocation, errp);
+    nbd_meta_empty_or_pattern(client, "allocation", ns + 5, len - 5,
+                              &meta->base_allocation, errp);
 }

 /* nbd_meta_bitmap_query
  *
  * Handle query to 'qemu:' namespace.
- * @len is the amount of text remaining to be read from the current name, after
- * the 'qemu:' portion has been stripped.
- *
- * Return -errno on I/O error, 0 if option was completely handled by
- * sending a reply about inconsistent lengths, or 1 on success. */
-static int nbd_meta_qemu_query(NBDClient *client, NBDExportMetaContexts *meta,
-                               uint32_t len, Error **errp)
+ * @len is the length of @ns, including the `qemu:' prefix.
+ */
+static void nbd_meta_qemu_query(NBDClient *client, NBDExportMetaContexts *meta,
+                                const char *ns, uint32_t len, Error **errp)
 {
-    bool dirty_bitmap = false;
-    size_t dirty_bitmap_len = strlen("dirty-bitmap:");
-    int ret;
-
     if (!meta->exp->export_bitmap) {
         trace_nbd_negotiate_meta_query_skip("no dirty-bitmap exported");
-        return nbd_opt_skip(client, len, errp);
-    }
-
-    if (len == 0) {
+    } else if (len == 0) {
         if (client->opt == NBD_OPT_LIST_META_CONTEXT) {
             meta->bitmap = true;
         }
         trace_nbd_negotiate_meta_query_parse("empty");
-        return 1;
-    }
-
-    if (len < dirty_bitmap_len) {
-        trace_nbd_negotiate_meta_query_skip("not dirty-bitmap:");
-        return nbd_opt_skip(client, len, errp);
-    }
-
-    len -= dirty_bitmap_len;
-    ret = nbd_meta_pattern(client, "dirty-bitmap:", &dirty_bitmap, errp);
-    if (ret <= 0) {
-        return ret;
-    }
-    if (!dirty_bitmap) {
+    } else if (!g_str_has_prefix(ns + 5, "dirty-bitmap:")) {
         trace_nbd_negotiate_meta_query_skip("not dirty-bitmap:");
-        return nbd_opt_skip(client, len, errp);
+    } else {
+        trace_nbd_negotiate_meta_query_parse("dirty-bitmap:");
+        nbd_meta_empty_or_pattern(client, meta->exp->export_bitmap_context,
+                                  ns, len, &meta->bitmap, errp);
     }
-
-    trace_nbd_negotiate_meta_query_parse("dirty-bitmap:");
-
-    return nbd_meta_empty_or_pattern(
-            client, meta->exp->export_bitmap_context +
-            strlen("qemu:dirty_bitmap:"), len, &meta->bitmap, errp);
 }

 /* nbd_negotiate_meta_query
@@ -930,22 +859,13 @@ static int nbd_meta_qemu_query(NBDClient *client, NBDExportMetaContexts *meta,
  *
  * The only supported namespaces are 'base' and 'qemu'.
  *
- * The function aims not wasting time and memory to read long unknown namespace
- * names.
- *
  * Return -errno on I/O error, 0 if option was completely handled by
  * sending a reply about inconsistent lengths, or 1 on success. */
 static int nbd_negotiate_meta_query(NBDClient *client,
                                     NBDExportMetaContexts *meta, Error **errp)
 {
-    /*
-     * Both 'qemu' and 'base' namespaces have length = 5 including a
-     * colon. If another length namespace is later introduced, this
-     * should certainly be refactored.
-     */
     int ret;
-    size_t ns_len = 5;
-    char ns[5];
+    g_autofree char *ns = NULL;
     uint32_t len;

     ret = nbd_opt_read(client, &len, sizeof(len), errp);
@@ -958,27 +878,29 @@ static int nbd_negotiate_meta_query(NBDClient *client,
         trace_nbd_negotiate_meta_query_skip("length too long");
         return nbd_opt_skip(client, len, errp);
     }
-    if (len < ns_len) {
-        trace_nbd_negotiate_meta_query_skip("length too short");
-        return nbd_opt_skip(client, len, errp);
-    }

-    len -= ns_len;
-    ret = nbd_opt_read(client, ns, ns_len, errp);
+    ns = g_malloc(len + 1);
+    ret = nbd_opt_read(client, ns, len, errp);
     if (ret <= 0) {
         return ret;
     }
+    ns[len] = '\0';
+    if (strlen(ns) != len) {
+        return nbd_opt_invalid(client, errp,
+                               "Embedded NUL in query for option %s",
+                               nbd_opt_lookup(client->opt));
+    }

-    if (!strncmp(ns, "base:", ns_len)) {
+    if (g_str_has_prefix(ns, "base:")) {
         trace_nbd_negotiate_meta_query_parse("base:");
-        return nbd_meta_base_query(client, meta, len, errp);
-    } else if (!strncmp(ns, "qemu:", ns_len)) {
+        nbd_meta_base_query(client, meta, ns, len, errp);
+    } else if (g_str_has_prefix(ns, "qemu:")) {
         trace_nbd_negotiate_meta_query_parse("qemu:");
-        return nbd_meta_qemu_query(client, meta, len, errp);
+        nbd_meta_qemu_query(client, meta, ns, len, errp);
+    } else {
+        trace_nbd_negotiate_meta_query_skip("unknown namespace");
     }
-
-    trace_nbd_negotiate_meta_query_skip("unknown namespace");
-    return nbd_opt_skip(client, len, errp);
+    return 1;
 }

 /* nbd_negotiate_meta_queries
-- 
2.28.0


