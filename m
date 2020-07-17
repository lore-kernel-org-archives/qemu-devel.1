Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 070F2C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 15:16:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB151204EA
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 15:16:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aasuHjlK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB151204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwS6B-0001aJ-2x
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 11:16:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36476)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jwS52-0000aD-B2
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 11:15:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25314
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jwS4z-0004HI-Aw
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 11:15:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594998915;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BfoIaOMsSAV66f6T35BcXzPvDmkqchT24FliN0xinPU=;
 b=aasuHjlKwGzdapT/PH7lobIXgrGsPxi42aVmZ4i8HJ8hMQznVxlRW/c0GoTGnRd0f79Uwc
 sppzmjE/IQJiIIF6pX2EXPrBxb+Be4f9ksJrMl5XiN4ah3YtWCmMC/1laSPfu9HOWG3eIY
 Bkb8qS7DLSSIkAgeEHg69RF4YtoL658=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-193-iWGsAUcfOqqUFx3EEfS-Ug-1; Fri, 17 Jul 2020 11:15:13 -0400
X-MC-Unique: iWGsAUcfOqqUFx3EEfS-Ug-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E33D7108C283;
 Fri, 17 Jul 2020 15:15:11 +0000 (UTC)
Received: from blue.redhat.com (ovpn-113-239.phx2.redhat.com [10.3.113.239])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 697C87B439;
 Fri, 17 Jul 2020 15:14:59 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/1] migration/block-dirty-bitmap: fix add_bitmaps_to_list
Date: Fri, 17 Jul 2020 10:14:46 -0500
Message-Id: <20200717151446.655571-2-eblake@redhat.com>
In-Reply-To: <20200717151446.655571-1-eblake@redhat.com>
References: <20200717151446.655571-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/17 03:33:51
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
Cc: Fam Zheng <fam@euphon.net>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "open list:Block I/O path" <qemu-block@nongnu.org>,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

We shouldn't fail when finding an unnamed bitmap in a unnamed node or
node with auto-generated node name, as bitmap migration ignores such
bitmaps in the first place.

Fixes: 82640edb88faa
Fixes: 4ff5cc121b089
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20200626130658.76498-1-vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
[eblake: commit message grammar tweaks]
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 migration/block-dirty-bitmap.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
index 47bc0f650c1e..b0dbf9eeed43 100644
--- a/migration/block-dirty-bitmap.c
+++ b/migration/block-dirty-bitmap.c
@@ -274,7 +274,11 @@ static int add_bitmaps_to_list(BlockDriverState *bs, const char *bs_name)
     DirtyBitmapMigBitmapState *dbms;
     Error *local_err = NULL;

-    bitmap = bdrv_dirty_bitmap_first(bs);
+    FOR_EACH_DIRTY_BITMAP(bs, bitmap) {
+        if (bdrv_dirty_bitmap_name(bitmap)) {
+            break;
+        }
+    }
     if (!bitmap) {
         return 0;
     }
-- 
2.27.0


