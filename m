Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F84C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 16:42:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96A7F20855
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 16:42:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OQTIR83k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96A7F20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6GJ1-00008n-Ru
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 12:42:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56228)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k6G95-00057f-SL
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 12:32:03 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:41232
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k6G94-0001du-98
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 12:32:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597336321;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0kP3JW4cQeIixcwieAnD96+eq8w2AIytt1Mm9Uer6yc=;
 b=OQTIR83kY7KDOzUKq1BqWa68vp+EEfasYAeY44s05fq+lPVPj1QrDhmvoKu7zZmCSvD5kA
 JP2bsT8dmTlpSK6U0KMfS6XhomlgIN4+c+W91jDuwi4eLG/+RR2hkC6SgnH969quMF+Jmn
 5PUHKVSzgNr3rAG0hCC0ItoJ/6lNAJo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-529-Rd_s3Bp8PomMAHaUfz7YjQ-1; Thu, 13 Aug 2020 12:30:10 -0400
X-MC-Unique: Rd_s3Bp8PomMAHaUfz7YjQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0874C1DDE9;
 Thu, 13 Aug 2020 16:30:09 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-113-97.ams2.redhat.com [10.36.113.97])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BD7CF5C1C2;
 Thu, 13 Aug 2020 16:30:05 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [RFC PATCH 12/22] nbd/server: Simplify export shutdown
Date: Thu, 13 Aug 2020 18:29:25 +0200
Message-Id: <20200813162935.210070-13-kwolf@redhat.com>
In-Reply-To: <20200813162935.210070-1-kwolf@redhat.com>
References: <20200813162935.210070-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 02:03:30
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Closing export is somewhat convoluted because nbd_export_close() and
nbd_export_put() call each other and the ways they actually end up being
nested is not necessarily obvious.

However, it is not really necessary to call nbd_export_close() from
nbd_export_put() when putting the last reference because it only does
three things:

1. Close all clients. We're going to refcount 0 and all clients hold a
   reference, so we know there is no active client any more.

2. Close the user reference (represented by exp->name being non-NULL).
   The same argument applies: If the export were still named, we would
   still have a reference.

3. Freeing exp->description. This is really cleanup work to be done when
   the export is finally freed. There is no reason to already clear it
   while clients are still in the process of shutting down.

So after moving the cleanup of exp->description, the code can be
simplified so that only nbd_export_close() calls nbd_export_put(), but
never the other way around.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 nbd/server.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index eadc5b9804..4c594e6558 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -1678,8 +1678,6 @@ void nbd_export_close(NBDExport *exp)
         QTAILQ_REMOVE(&exports, exp, next);
         QTAILQ_INSERT_TAIL(&closed_exports, exp, next);
     }
-    g_free(exp->description);
-    exp->description = NULL;
     nbd_export_put(exp);
 }
 
@@ -1706,19 +1704,12 @@ void nbd_export_get(NBDExport *exp)
 void nbd_export_put(NBDExport *exp)
 {
     assert(exp->refcount > 0);
-    if (exp->refcount == 1) {
-        nbd_export_close(exp);
-    }
-
-    /* nbd_export_close() may theoretically reduce refcount to 0. It may happen
-     * if someone calls nbd_export_put() on named export not through
-     * nbd_export_set_name() when refcount is 1. So, let's assert that
-     * it is > 0.
-     */
-    assert(exp->refcount > 0);
     if (--exp->refcount == 0) {
         assert(exp->name == NULL);
-        assert(exp->description == NULL);
+        assert(QTAILQ_EMPTY(&exp->clients));
+
+        g_free(exp->description);
+        exp->description = NULL;
 
         if (exp->blk) {
             if (exp->eject_notifier_blk) {
-- 
2.25.4


