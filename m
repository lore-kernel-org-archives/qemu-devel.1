Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 271D7C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 22:05:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5B5E22258
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 22:05:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uy/TN3dq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5B5E22258
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kR0Vi-0002WT-Lm
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 18:05:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50216)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kR0Mh-0002q2-OA
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 17:55:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40526)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kR0Md-0003R5-6j
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 17:55:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602280546;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0Eq/ITB/lBTrJF+4U2MK0ADeZ12u6qsK6QK2p7tcG2U=;
 b=Uy/TN3dqWBs4ZcDgc38vS7c7ahmIfhYMQVxMrQVf7Q16KpCZ5YaHb5upcycocXKUsMOPJU
 2Akhna1z6jFHlBAyj83csCoqwua+1uK4NLaSTVU9Vz2XlYRVfLS9XJrbFZhgXM6Wz1jz9p
 HKnmXzHznc1ExniB5E+G19CIyifwsOQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-256-uLDmrEnTPrqF6EeoK3mzFQ-1; Fri, 09 Oct 2020 17:55:44 -0400
X-MC-Unique: uLDmrEnTPrqF6EeoK3mzFQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9A8451DDE1;
 Fri,  9 Oct 2020 21:55:43 +0000 (UTC)
Received: from blue.redhat.com (ovpn-113-14.phx2.redhat.com [10.3.113.14])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1860210013C4;
 Fri,  9 Oct 2020 21:55:43 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 6/7] nbd: Refactor counting of metadata contexts
Date: Fri,  9 Oct 2020 16:55:32 -0500
Message-Id: <20201009215533.1194742-7-eblake@redhat.com>
In-Reply-To: <20201009215533.1194742-1-eblake@redhat.com>
References: <20201009215533.1194742-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 02:34:40
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, vsementsov@virtuozzo.com,
 rjones@redhat.com, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Rather than open-code the count of negotiated contexts at several
sites, embed it directly into the struct.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 nbd/server.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index 05a8154975a1..27d943529409 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -106,8 +106,7 @@ static QTAILQ_HEAD(, NBDExport) exports = QTAILQ_HEAD_INITIALIZER(exports);
  * NBD_OPT_LIST_META_CONTEXT. */
 typedef struct NBDExportMetaContexts {
     NBDExport *exp;
-    bool valid; /* means that negotiation of the option finished without
-                   errors */
+    size_t count; /* number of negotiated contexts */
     bool base_allocation; /* export base:allocation context (block status) */
     bool allocation_depth; /* export qemu:allocation-depth */
     bool bitmap; /* export qemu:dirty-bitmap:<export bitmap name> */
@@ -448,7 +447,9 @@ static int nbd_negotiate_handle_list(NBDClient *client, Error **errp)

 static void nbd_check_meta_export(NBDClient *client)
 {
-    client->export_meta.valid &= client->exp == client->export_meta.exp;
+    if (client->exp != client->export_meta.exp) {
+        client->export_meta.count = 0;
+    }
 }

 /* Send a reply to NBD_OPT_EXPORT_NAME.
@@ -956,6 +957,7 @@ static int nbd_negotiate_meta_queries(NBDClient *client,
     NBDExportMetaContexts local_meta;
     uint32_t nb_queries;
     int i;
+    size_t count = 0;

     if (!client->structured_reply) {
         return nbd_opt_invalid(client, errp,
@@ -1013,6 +1015,7 @@ static int nbd_negotiate_meta_queries(NBDClient *client,
         if (ret < 0) {
             return ret;
         }
+        count++;
     }

     if (meta->allocation_depth) {
@@ -1022,6 +1025,7 @@ static int nbd_negotiate_meta_queries(NBDClient *client,
         if (ret < 0) {
             return ret;
         }
+        count++;
     }

     if (meta->bitmap) {
@@ -1035,11 +1039,12 @@ static int nbd_negotiate_meta_queries(NBDClient *client,
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
@@ -2400,15 +2405,9 @@ static coroutine_fn int nbd_handle_request(NBDClient *client,
             return nbd_send_generic_reply(client, request->handle, -EINVAL,
                                           "need non-zero length", errp);
         }
-        if (client->export_meta.valid &&
-            (client->export_meta.base_allocation ||
-             client->export_meta.allocation_depth ||
-             client->export_meta.bitmap))
-        {
+        if (client->export_meta.count) {
             bool dont_fragment = request->flags & NBD_CMD_FLAG_REQ_ONE;
-            int contexts_remaining = client->export_meta.base_allocation +
-                client->export_meta.allocation_depth +
-                client->export_meta.bitmap;
+            int contexts_remaining = client->export_meta.count;

             if (client->export_meta.base_allocation) {
                 ret = nbd_co_send_block_status(client, request->handle,
-- 
2.28.0


