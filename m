Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 675B7C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 14:23:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31DF0205CB
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 14:23:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y8yJUkpp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31DF0205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juzME-0000wF-FH
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 10:23:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38142)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1juzKW-0006Sz-6L
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 10:21:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57748
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1juzKU-00084V-45
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 10:21:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594650073;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ksW9NEbGcbCFsYzLrywmAnxhLCHKW+VH0kaIFBT1NXc=;
 b=Y8yJUkppFm0doHjFaDOIqkl7kS2o6Qs3kirdk6YEmYiKaQv/nCF8+szPyk6QqykpQk3bLA
 T8xkpw/XEMZGkXLrXAh8b6rc+6Ud785ACMlsMfPgNalJbEQdH2vQqD0vF45DE7xQbpjw3I
 1lTjyepPK09Kx5iG1yliFTfu0gFhsUY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-1j4MktGkMAWRmOlPAyZN1A-1; Mon, 13 Jul 2020 10:21:10 -0400
X-MC-Unique: 1j4MktGkMAWRmOlPAyZN1A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 65F0E8014D4;
 Mon, 13 Jul 2020 14:21:09 +0000 (UTC)
Received: from blue.redhat.com (ovpn-112-134.phx2.redhat.com [10.3.112.134])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CE22376203;
 Mon, 13 Jul 2020 14:21:08 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/5] nbd: Avoid off-by-one in long export name truncation
Date: Mon, 13 Jul 2020 09:21:02 -0500
Message-Id: <20200713142106.261809-2-eblake@redhat.com>
In-Reply-To: <20200713142106.261809-1-eblake@redhat.com>
References: <20200713142106.261809-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 02:19:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When snprintf returns the same value as the buffer size, the final
byte was truncated to ensure a NUL terminator.  Fortunately, such long
export names are unusual enough, with no real impact other than what
is displayed to the user.

Fixes: 5c86bdf12089
Reported-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20200622210355.414941-1-eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/nbd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/nbd.c b/block/nbd.c
index c297336ffc5f..65a4f56924ec 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -2002,7 +2002,7 @@ static void nbd_refresh_filename(BlockDriverState *bs)
         len = snprintf(bs->exact_filename, sizeof(bs->exact_filename),
                        "nbd://%s:%s", host, port);
     }
-    if (len > sizeof(bs->exact_filename)) {
+    if (len >= sizeof(bs->exact_filename)) {
         /* Name is too long to represent exactly, so leave it empty. */
         bs->exact_filename[0] = '\0';
     }
-- 
2.27.0


