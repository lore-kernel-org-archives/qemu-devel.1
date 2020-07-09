Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 017ABC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 19:44:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD111206DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 19:44:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A8RI5pv7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD111206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtcSn-0007b4-UA
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 15:44:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58280)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1jtcRk-0005p7-TF
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 15:43:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31261
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1jtcRj-0000Ls-DT
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 15:43:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594323782;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=te6tqsuUblZeB+laI3sr13z1brb8lvD5tZ2Ty4GUvwY=;
 b=A8RI5pv7JVpkg5pwcDgfjMcmG4NZod7px0JK+nKbmSgK9Ahkx9yljhcHP2EtTMvWdN9ssF
 LanNFnOcyJCfEQ6HWQVinCotgnTXVC92zuEpHb3Y7uRErJYkt/LgJM43b3he7/h5CGaTOU
 +h07aTlNOFj4fdnwPLaEJI5xJZGwsbU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-1Kj6Rd5yOd2B7XflZL25dA-1; Thu, 09 Jul 2020 15:42:58 -0400
X-MC-Unique: 1Kj6Rd5yOd2B7XflZL25dA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 887101B18BC1;
 Thu,  9 Jul 2020 19:42:57 +0000 (UTC)
Received: from localhost (unknown [10.36.110.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8F98619D7C;
 Thu,  9 Jul 2020 19:42:53 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 02/13] block/nbd: auto-ify URI parsing variables
Date: Thu,  9 Jul 2020 23:42:23 +0400
Message-Id: <20200709194234.2117650-3-marcandre.lureau@redhat.com>
In-Reply-To: <20200709194234.2117650-1-marcandre.lureau@redhat.com>
References: <20200709194234.2117650-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120;
 envelope-from=marcandre.lureau@redhat.com; helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 11:25:17
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
 block/nbd.c | 27 ++++++++-------------------
 1 file changed, 8 insertions(+), 19 deletions(-)

diff --git a/block/nbd.c b/block/nbd.c
index eed160c5cda..faadcab442b 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -1516,10 +1516,9 @@ static int nbd_client_connect(BlockDriverState *bs, Error **errp)
 
 static int nbd_parse_uri(const char *filename, QDict *options)
 {
-    URI *uri;
+    g_autoptr(URI) uri = NULL;
+    g_autoptr(QueryParams) qp = NULL;
     const char *p;
-    QueryParams *qp = NULL;
-    int ret = 0;
     bool is_unix;
 
     uri = uri_parse(filename);
@@ -1535,8 +1534,7 @@ static int nbd_parse_uri(const char *filename, QDict *options)
     } else if (!g_strcmp0(uri->scheme, "nbd+unix")) {
         is_unix = true;
     } else {
-        ret = -EINVAL;
-        goto out;
+        return -EINVAL;
     }
 
     p = uri->path ? uri->path : "";
@@ -1549,26 +1547,23 @@ static int nbd_parse_uri(const char *filename, QDict *options)
 
     qp = query_params_parse(uri->query);
     if (qp->n > 1 || (is_unix && !qp->n) || (!is_unix && qp->n)) {
-        ret = -EINVAL;
-        goto out;
+        return -EINVAL;
     }
 
     if (is_unix) {
         /* nbd+unix:///export?socket=path */
         if (uri->server || uri->port || strcmp(qp->p[0].name, "socket")) {
-            ret = -EINVAL;
-            goto out;
+            return -EINVAL;
         }
         qdict_put_str(options, "server.type", "unix");
         qdict_put_str(options, "server.path", qp->p[0].value);
     } else {
         QString *host;
-        char *port_str;
+        g_autofree char *port_str = NULL;
 
         /* nbd[+tcp]://host[:port]/export */
         if (!uri->server) {
-            ret = -EINVAL;
-            goto out;
+            return -EINVAL;
         }
 
         /* strip braces from literal IPv6 address */
@@ -1584,15 +1579,9 @@ static int nbd_parse_uri(const char *filename, QDict *options)
 
         port_str = g_strdup_printf("%d", uri->port ?: NBD_DEFAULT_PORT);
         qdict_put_str(options, "server.port", port_str);
-        g_free(port_str);
     }
 
-out:
-    if (qp) {
-        query_params_free(qp);
-    }
-    uri_free(uri);
-    return ret;
+    return 0;
 }
 
 static bool nbd_has_filename_options_conflict(QDict *options, Error **errp)
-- 
2.27.0.221.ga08a83db2b


