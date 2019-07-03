Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDACBC0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 17:30:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9D9E21882
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 17:30:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9D9E21882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hij5h-0001L4-0S
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 13:30:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48891)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hij3q-0007VR-DQ
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 13:28:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hij3p-0008Lp-DP
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 13:28:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56242)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hij3l-0007qU-Gf; Wed, 03 Jul 2019 13:28:46 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 356D1308FC4E;
 Wed,  3 Jul 2019 17:28:20 +0000 (UTC)
Received: from localhost (ovpn-204-65.brq.redhat.com [10.40.204.65])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C551F6090E;
 Wed,  3 Jul 2019 17:28:19 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Wed,  3 Jul 2019 19:28:03 +0200
Message-Id: <20190703172813.6868-3-mreitz@redhat.com>
In-Reply-To: <20190703172813.6868-1-mreitz@redhat.com>
References: <20190703172813.6868-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Wed, 03 Jul 2019 17:28:20 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 02/12] block/stream: Fix error path
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As of commit c624b015bf14fe01f1e6452a36e63b3ea1ae4998, the stream job
only freezes the chain until the overlay of the base node.  The error
path must consider this.

Fixes: c624b015bf14fe01f1e6452a36e63b3ea1ae4998
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/stream.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/stream.c b/block/stream.c
index cd5e2ba9b0..b27e61625d 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -284,5 +284,5 @@ fail:
     if (bs_read_only) {
         bdrv_reopen_set_read_only(bs, true, NULL);
     }
-    bdrv_unfreeze_backing_chain(bs, base);
+    bdrv_unfreeze_backing_chain(bs, bottom);
 }
--=20
2.21.0


