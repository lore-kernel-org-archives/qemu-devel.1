Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B81C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 22:10:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27F1C20878
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 22:10:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HDfNjoly"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27F1C20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXXAH-00017w-4V
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 18:10:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54688)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kXX0I-0006ny-G5
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 17:59:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40045)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kXX0A-0000iv-Na
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 17:59:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603835972;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b6S6JoQTvPYiVA1pN2mM8zEtLWbexYReFd8nbBK4TRg=;
 b=HDfNjolyAqOugmygfFvyKOGutZRAzr4WMKq2mSyLSwBWDT9uSPI6HR38PHPMnRgNyrDV8e
 yZjMe5OKF5a+LLH53EmW4xl7PzBW0mIoSC5IAETEgbwch7wfhxbwg012WFUWwMdo0bbTQ5
 /A7zGNvg851uWqEgPoXvb0DWPXQPimg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-367-8dgEZ3U5P7Cjv9Jr00Mzgg-1; Tue, 27 Oct 2020 17:59:29 -0400
X-MC-Unique: 8dgEZ3U5P7Cjv9Jr00Mzgg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A5B301882FA8;
 Tue, 27 Oct 2020 21:59:28 +0000 (UTC)
Received: from blue.redhat.com (ovpn-112-145.phx2.redhat.com [10.3.112.145])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 028E010013DB;
 Tue, 27 Oct 2020 21:59:27 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 08/12] nbd: Refactor counting of metadata contexts
Date: Tue, 27 Oct 2020 16:59:10 -0500
Message-Id: <20201027215914.619460-9-eblake@redhat.com>
In-Reply-To: <20201027215914.619460-1-eblake@redhat.com>
References: <20201027215914.619460-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Rather than open-code the count of negotiated contexts at several
sites, embed it directly into the struct.  This will make it easier
for upcoming commits to support even more simultaneous contexts.

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20201027050556.269064-7-eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 nbd/server.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index 77fdecdf9dec..42d494bc9616 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -104,8 +104,7 @@ static QTAILQ_HEAD(, NBDExport) exports = QTAILQ_HEAD_INITIALIZER(exports);
  * NBD_OPT_LIST_META_CONTEXT. */
 typedef struct NBDExportMetaContexts {
     NBDExport *exp;
-    bool valid; /* means that negotiation of the option finished without
-                   errors */
+    size_t count; /* number of negotiated contexts */
     bool base_allocation; /* export base:allocation context (block status) */
     bool bitmap; /* export qemu:dirty-bitmap:<export bitmap name> */
 } NBDExportMetaContexts;
@@ -445,7 +444,9 @@ static int nbd_negotiate_handle_list(NBDClient *client, Error **errp)

 static void nbd_check_meta_export(NBDClient *client)
 {
-    client->export_meta.valid &= client->exp == client->export_meta.exp;
+    if (client->exp != client->export_meta.exp) {
+        client->export_meta.count = 0;
+    }
 }

 /* Send a reply to NBD_OPT_EXPORT_NAME.
@@ -945,6 +946,7 @@ static int nbd_negotiate_meta_queries(NBDClient *client,
     NBDExportMetaContexts local_meta;
     uint32_t nb_queries;
     int i;
+    size_t count = 0;

     if (!client->structured_reply) {
         return nbd_opt_invalid(client, errp,
@@ -1001,6 +1003,7 @@ static int nbd_negotiate_meta_queries(NBDClient *client,
         if (ret < 0) {
             return ret;
         }
+        count++;
     }

     if (meta->bitmap) {
@@ -1014,11 +1017,12 @@ static int nbd_negotiate_meta_queries(NBDClient *client,
         if (ret < 0) {
             return ret;
         }
+        count++;
     }

     ret = nbd_negotiate_send_rep(client, NBD_REP_ACK, errp);
     if (ret == 0) {
-        meta->valid = true;
+        meta->count = count;
     }

     return ret;
@@ -2337,18 +2341,16 @@ static coroutine_fn int nbd_handle_request(NBDClient *client,
             return nbd_send_generic_reply(client, request->handle, -EINVAL,
                                           "need non-zero length", errp);
         }
-        if (client->export_meta.valid &&
-            (client->export_meta.base_allocation ||
-             client->export_meta.bitmap))
-        {
+        if (client->export_meta.count) {
             bool dont_fragment = request->flags & NBD_CMD_FLAG_REQ_ONE;
+            int contexts_remaining = client->export_meta.count;

             if (client->export_meta.base_allocation) {
                 ret = nbd_co_send_block_status(client, request->handle,
                                                blk_bs(exp->common.blk),
                                                request->from,
                                                request->len, dont_fragment,
-                                               !client->export_meta.bitmap,
+                                               !--contexts_remaining,
                                                NBD_META_ID_BASE_ALLOCATION,
                                                errp);
                 if (ret < 0) {
@@ -2360,13 +2362,15 @@ static coroutine_fn int nbd_handle_request(NBDClient *client,
                 ret = nbd_co_send_bitmap(client, request->handle,
                                          client->exp->export_bitmap,
                                          request->from, request->len,
-                                         dont_fragment,
-                                         true, NBD_META_ID_DIRTY_BITMAP, errp);
+                                         dont_fragment, !--contexts_remaining,
+                                         NBD_META_ID_DIRTY_BITMAP, errp);
                 if (ret < 0) {
                     return ret;
                 }
             }

+            assert(!contexts_remaining);
+
             return 0;
         } else {
             return nbd_send_generic_reply(client, request->handle, -EINVAL,
-- 
2.29.0


