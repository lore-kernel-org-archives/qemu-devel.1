Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCFEEC433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 18:27:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BC0520738
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 18:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bFS9AI6K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BC0520738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFLrJ-0001Br-81
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 14:27:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42566)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kFLlA-0005Pq-DY
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 14:20:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56643)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kFLl1-0004WI-5S
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 14:20:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599502846;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2gaxK56EDk7VojWTHKe7ayJitnEPvrQaYpIkJcOy7i0=;
 b=bFS9AI6KKPRYPa94hJFO4AtN2MQuNiKhaZYOiukXG5DJbu5BMKX55KNu6Aan8rrTMtfIgq
 Zv5unSWSr7YJOvHwwEFhyjV3oLeLfH4/7AFzfoHtNP3q3IQAmEO+NcXE4ftS/INlYa/k3U
 wScrKdTaAUKg4qxZbJDMfNFufwMke5s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-66-tFiy_V5cNNWFz222C3_U3Q-1; Mon, 07 Sep 2020 14:20:42 -0400
X-MC-Unique: tFiy_V5cNNWFz222C3_U3Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ACBAE1084C8D;
 Mon,  7 Sep 2020 18:20:41 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-154.ams2.redhat.com
 [10.36.114.154])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9368E60BF3;
 Mon,  7 Sep 2020 18:20:40 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 12/29] nbd/server: Simplify export shutdown
Date: Mon,  7 Sep 2020 20:19:54 +0200
Message-Id: <20200907182011.521007-13-kwolf@redhat.com>
In-Reply-To: <20200907182011.521007-1-kwolf@redhat.com>
References: <20200907182011.521007-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/07 13:43:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 nbd/server.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index 1cc915f01d..fb70374df5 100644
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


