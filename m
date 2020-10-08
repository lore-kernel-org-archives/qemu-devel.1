Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28469C433E7
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 19:07:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E4FB21789
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 19:07:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Me5gh8t8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E4FB21789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQbGY-0006sz-9r
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 15:07:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46850)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kQb94-0007wS-GP
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 15:00:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41138)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kQb90-0003fO-Cp
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 15:00:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602183601;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gY3Y6Sxj0tbyVRafvnFkR174lw2Nu8m6GWmsr3M3YtM=;
 b=Me5gh8t8i0yCMO/u/oQAjyY19RN7LyGeuHe9bqNo03gE9u5yuzhDZEAado2jrTgftdlgj2
 wQ4vfUpnT/ZT4AAxP9lnyZqTijf4O/DbdX2H4oYGe16ViI23/gXoREcHcD9spT/CBgzhi+
 wXSlmqpacmTOawvx5DO41UljCUuNfYM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-584-3xpA4Gh9N2yPj_ED_0v7dQ-1; Thu, 08 Oct 2020 14:59:59 -0400
X-MC-Unique: 3xpA4Gh9N2yPj_ED_0v7dQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 55E3157052;
 Thu,  8 Oct 2020 18:59:58 +0000 (UTC)
Received: from blue.redhat.com (ovpn-113-14.phx2.redhat.com [10.3.113.14])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0605A5D9E8;
 Thu,  8 Oct 2020 18:59:57 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 7/8] nbd/server: Reject embedded NUL in NBD strings
Date: Thu,  8 Oct 2020 13:59:50 -0500
Message-Id: <20201008185951.1026052-8-eblake@redhat.com>
In-Reply-To: <20201008185951.1026052-1-eblake@redhat.com>
References: <20201008185951.1026052-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/08 01:56:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The NBD spec is clear that any string sent from the client must not
contain embedded NUL characters.  If the client passes "a\0", we
should reject that option request rather than act on "a".

Testing this is not possible with a compliant client, but I was able
to use gdb to coerce libnbd into temporarily behaving as such a
client.

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20200930121105.667049-3-eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 nbd/server.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index f25cffa334fa..50f95abe3168 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -301,10 +301,11 @@ nbd_opt_invalid(NBDClient *client, Error **errp, const char *fmt, ...)
 }

 /* Read size bytes from the unparsed payload of the current option.
+ * If @check_nul, require that no NUL bytes appear in buffer.
  * Return -errno on I/O error, 0 if option was completely handled by
  * sending a reply about inconsistent lengths, or 1 on success. */
 static int nbd_opt_read(NBDClient *client, void *buffer, size_t size,
-                        Error **errp)
+                        bool check_nul, Error **errp)
 {
     if (size > client->optlen) {
         return nbd_opt_invalid(client, errp,
@@ -312,7 +313,16 @@ static int nbd_opt_read(NBDClient *client, void *buffer, size_t size,
                                nbd_opt_lookup(client->opt));
     }
     client->optlen -= size;
-    return qio_channel_read_all(client->ioc, buffer, size, errp) < 0 ? -EIO : 1;
+    if (qio_channel_read_all(client->ioc, buffer, size, errp) < 0) {
+        return -EIO;
+    }
+
+    if (check_nul && strnlen(buffer, size) != size) {
+        return nbd_opt_invalid(client, errp,
+                               "Unexpected embedded NUL in option %s",
+                               nbd_opt_lookup(client->opt));
+    }
+    return 1;
 }

 /* Drop size bytes from the unparsed payload of the current option.
@@ -349,7 +359,7 @@ static int nbd_opt_read_name(NBDClient *client, char **name, uint32_t *length,
     g_autofree char *local_name = NULL;

     *name = NULL;
-    ret = nbd_opt_read(client, &len, sizeof(len), errp);
+    ret = nbd_opt_read(client, &len, sizeof(len), false, errp);
     if (ret <= 0) {
         return ret;
     }
@@ -361,7 +371,7 @@ static int nbd_opt_read_name(NBDClient *client, char **name, uint32_t *length,
     }

     local_name = g_malloc(len + 1);
-    ret = nbd_opt_read(client, local_name, len, errp);
+    ret = nbd_opt_read(client, local_name, len, true, errp);
     if (ret <= 0) {
         return ret;
     }
@@ -576,14 +586,14 @@ static int nbd_negotiate_handle_info(NBDClient *client, Error **errp)
     }
     trace_nbd_negotiate_handle_export_name_request(name);

-    rc = nbd_opt_read(client, &requests, sizeof(requests), errp);
+    rc = nbd_opt_read(client, &requests, sizeof(requests), false, errp);
     if (rc <= 0) {
         return rc;
     }
     requests = be16_to_cpu(requests);
     trace_nbd_negotiate_handle_info_requests(requests);
     while (requests--) {
-        rc = nbd_opt_read(client, &request, sizeof(request), errp);
+        rc = nbd_opt_read(client, &request, sizeof(request), false, errp);
         if (rc <= 0) {
             return rc;
         }
@@ -806,7 +816,7 @@ static int nbd_meta_pattern(NBDClient *client, const char *pattern, bool *match,
     assert(len);

     query = g_malloc(len);
-    ret = nbd_opt_read(client, query, len, errp);
+    ret = nbd_opt_read(client, query, len, true, errp);
     if (ret <= 0) {
         g_free(query);
         return ret;
@@ -943,7 +953,7 @@ static int nbd_negotiate_meta_query(NBDClient *client,
     char ns[5];
     uint32_t len;

-    ret = nbd_opt_read(client, &len, sizeof(len), errp);
+    ret = nbd_opt_read(client, &len, sizeof(len), false, errp);
     if (ret <= 0) {
         return ret;
     }
@@ -959,7 +969,7 @@ static int nbd_negotiate_meta_query(NBDClient *client,
     }

     len -= ns_len;
-    ret = nbd_opt_read(client, ns, ns_len, errp);
+    ret = nbd_opt_read(client, ns, ns_len, true, errp);
     if (ret <= 0) {
         return ret;
     }
@@ -1016,7 +1026,7 @@ static int nbd_negotiate_meta_queries(NBDClient *client,
                             "export '%s' not present", sane_name);
     }

-    ret = nbd_opt_read(client, &nb_queries, sizeof(nb_queries), errp);
+    ret = nbd_opt_read(client, &nb_queries, sizeof(nb_queries), false, errp);
     if (ret <= 0) {
         return ret;
     }
-- 
2.28.0


