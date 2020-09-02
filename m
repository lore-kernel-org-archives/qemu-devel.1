Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80237C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 16:49:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 489BE20767
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 16:49:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XwjztFV/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 489BE20767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDVx9-0006uK-FB
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 12:49:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41494)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kDVwM-0005N8-Dh
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 12:48:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60241
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kDVwK-0006rh-Vr
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 12:48:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599065332;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MGWVOZqO5sQSbVg4HnXyePdWDQ+gGvYfruwCmlWmsS4=;
 b=XwjztFV/dSXUFKj/pu0f7EanIUZ/K1oP5EWrrbgLDrcY8Hi1/UGUI6L8EMOXwFNg2bqE6G
 tbrCZryp2qROnjIawX5aFl/umb+SsNwoLMSVAXUUita4A6BZ3kZSDBr6Ftni7pt5CBED9j
 4O1QTGYonHRMLPDNop+MGC7B9cTe0RI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-pkDLpt6RMhez_T19b-VCrg-1; Wed, 02 Sep 2020 12:48:48 -0400
X-MC-Unique: pkDLpt6RMhez_T19b-VCrg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4F869100854F;
 Wed,  2 Sep 2020 16:48:47 +0000 (UTC)
Received: from localhost (ovpn-114-169.ams2.redhat.com [10.36.114.169])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E7E9E10098AC;
 Wed,  2 Sep 2020 16:48:46 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 2/3] mirror: Freeze backing chain for sync=top
Date: Wed,  2 Sep 2020 18:48:40 +0200
Message-Id: <20200902164841.214948-3-mreitz@redhat.com>
In-Reply-To: <20200902164841.214948-1-mreitz@redhat.com>
References: <20200902164841.214948-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 02:26:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reported-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/mirror.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index 11ebffdf99..27422ab7a5 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -649,8 +649,8 @@ static int mirror_exit_common(Job *job)
     src = mirror_top_bs->backing->bs;
     target_bs = blk_bs(s->target);
 
-    if (bdrv_chain_contains(src, target_bs)) {
-        bdrv_unfreeze_backing_chain(mirror_top_bs, target_bs);
+    if (s->base) {
+        bdrv_unfreeze_backing_chain(mirror_top_bs, s->base);
     }
 
     bdrv_release_dirty_bitmap(s->dirty_bitmap);
@@ -1780,8 +1780,22 @@ static BlockJob *mirror_start_job(
                 goto fail;
             }
         }
+    }
+
+    if (s->base) {
+        /*
+         * For active commit or mirror with sync=top, we need to
+         * freeze the backing chain down to the base, because we keep
+         * pointers to it and its overlay.  For other cases (mirror
+         * with sync=full or sync=none), we do not, so there is no
+         * need to freeze any part of the chain.
+         * (s->base is non-NULL only in these cases.)
+         */
+        if (target_is_backing) {
+            assert(s->base == target);
+        }
 
-        if (bdrv_freeze_backing_chain(mirror_top_bs, target, errp) < 0) {
+        if (bdrv_freeze_backing_chain(mirror_top_bs, s->base, errp) < 0) {
             goto fail;
         }
     }
-- 
2.26.2


