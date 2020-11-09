Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78DB6C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 17:56:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E74582067D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 17:56:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qlp4k7aI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E74582067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kcBOj-0002jJ-Uw
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 12:56:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41056)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kcB8S-0006vf-0r
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 12:39:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48871)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kcB8Q-0000WA-0i
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 12:39:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604943557;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j8om9XNSXwWeEA8OUiHk+zMzsBdx8dojGcHQlkoGG6k=;
 b=Qlp4k7aIlZFMtaUq40OgctVvfGAd8ZbM802u+7ezPiCIVtLvj8k6EvwIuYbnb5ZlQz5qWI
 iYosRMb3gTLX4/k1on2MY40AktZIa0ta/TK46clBeOKJZUhakYy/dBWYqEXkJKuUkEZIgn
 cSdLIElwbLfrpa4sFlkJgBbmfkrRyCM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-576-MPUVI4TKO6q6sWvR6wu1Bg-1; Mon, 09 Nov 2020 12:39:14 -0500
X-MC-Unique: MPUVI4TKO6q6sWvR6wu1Bg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D0C938CD261;
 Mon,  9 Nov 2020 17:39:13 +0000 (UTC)
Received: from localhost (ovpn-113-179.ams2.redhat.com [10.36.113.179])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7555260E1C;
 Mon,  9 Nov 2020 17:39:13 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 14/15] block: add bdrv_replace_node_common()
Date: Mon,  9 Nov 2020 18:38:38 +0100
Message-Id: <20201109173839.2135984-15-mreitz@redhat.com>
In-Reply-To: <20201109173839.2135984-1-mreitz@redhat.com>
References: <20201109173839.2135984-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 01:25:23
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Add new parameter to bdrv_replace_node(): auto_skip. With
auto_skip=false we'll have stricter behavior: update _all_ from
parents or fail. New behaviour will be used in the following commit in
block.c, so keep original function name as public interface.

Note: new error message is a bit funny in contrast with further
"Cannot" in case of frozen child, but we'd better keep some difference
to make it possible to distinguish one from another on failure. Still,
actually we'd better refactor should_update_child() call to distinguish
also different kinds of "should not". Let's do it later.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20201106124241.16950-3-vsementsov@virtuozzo.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/block.c b/block.c
index 1e68bd2f5f..9a945a058d 100644
--- a/block.c
+++ b/block.c
@@ -4563,8 +4563,16 @@ static bool should_update_child(BdrvChild *c, BlockDriverState *to)
     return ret;
 }
 
-void bdrv_replace_node(BlockDriverState *from, BlockDriverState *to,
-                       Error **errp)
+/*
+ * With auto_skip=true bdrv_replace_node_common skips updating from parents
+ * if it creates a parent-child relation loop or if parent is block-job.
+ *
+ * With auto_skip=false the error is returned if from has a parent which should
+ * not be updated.
+ */
+static void bdrv_replace_node_common(BlockDriverState *from,
+                                     BlockDriverState *to,
+                                     bool auto_skip, Error **errp)
 {
     BdrvChild *c, *next;
     GSList *list = NULL, *p;
@@ -4583,7 +4591,12 @@ void bdrv_replace_node(BlockDriverState *from, BlockDriverState *to,
     QLIST_FOREACH_SAFE(c, &from->parents, next_parent, next) {
         assert(c->bs == from);
         if (!should_update_child(c, to)) {
-            continue;
+            if (auto_skip) {
+                continue;
+            }
+            error_setg(errp, "Should not change '%s' link to '%s'",
+                       c->name, from->node_name);
+            goto out;
         }
         if (c->frozen) {
             error_setg(errp, "Cannot change '%s' link to '%s'",
@@ -4623,6 +4636,12 @@ out:
     bdrv_unref(from);
 }
 
+void bdrv_replace_node(BlockDriverState *from, BlockDriverState *to,
+                       Error **errp)
+{
+    return bdrv_replace_node_common(from, to, true, errp);
+}
+
 /*
  * Add new bs contents at the top of an image chain while the chain is
  * live, while keeping required fields on the top layer.
-- 
2.28.0


