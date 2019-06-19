Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A9DC31E5B
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 15:29:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C07F921721
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 15:29:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C07F921721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39410 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdcWC-0005WX-W2
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 11:29:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42463)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hdcTw-0003GA-43
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 11:26:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hdcTv-0002Bq-3u
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 11:26:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58844)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hdcTs-00024W-Oy; Wed, 19 Jun 2019 11:26:36 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C27AE81DE1;
 Wed, 19 Jun 2019 15:26:27 +0000 (UTC)
Received: from localhost (ovpn-116-121.ams2.redhat.com [10.36.116.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 643CB60FAB;
 Wed, 19 Jun 2019 15:26:27 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Wed, 19 Jun 2019 17:26:00 +0200
Message-Id: <20190619152603.5937-7-mreitz@redhat.com>
In-Reply-To: <20190619152603.5937-1-mreitz@redhat.com>
References: <20190619152603.5937-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Wed, 19 Jun 2019 15:26:27 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 6/9] block: Add bdrv_drained_end_no_poll()
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
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In contrast to bdrv_drained_end(), which does poll and may thus lead to
graph changes, this new interface to bdrv_do_drained_end() will not
poll.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 include/block/block.h | 12 +++++++++++-
 block/io.c            |  5 +++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/include/block/block.h b/include/block/block.h
index d98237f0f1..422448d773 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -680,10 +680,20 @@ void bdrv_subtree_drained_begin(BlockDriverState *b=
s);
 /**
  * bdrv_drained_end:
  *
- * End a quiescent section started by bdrv_drained_begin().
+ * End a quiescent section started by bdrv_drained_begin().  This may
+ * result in block graph changes.
  */
 void bdrv_drained_end(BlockDriverState *bs);
=20
+/**
+ * bdrv_drained_end_no_poll:
+ *
+ * Same as bdrv_drained_end(), but do not poll for the subgraph to
+ * actually become unquiesced.  Therefore, no graph changes will occur
+ * with this function.
+ */
+void bdrv_drained_end_no_poll(BlockDriverState *bs);
+
 /**
  * End a quiescent section started by bdrv_subtree_drained_begin().
  */
diff --git a/block/io.c b/block/io.c
index 5f30baa8e5..188dea22bc 100644
--- a/block/io.c
+++ b/block/io.c
@@ -539,6 +539,11 @@ void bdrv_drained_end(BlockDriverState *bs)
     bdrv_do_drained_end(bs, false, NULL, false, true, NULL);
 }
=20
+void bdrv_drained_end_no_poll(BlockDriverState *bs)
+{
+    bdrv_do_drained_end(bs, false, NULL, false, false, NULL);
+}
+
 void bdrv_subtree_drained_end(BlockDriverState *bs)
 {
     bdrv_do_drained_end(bs, true, NULL, false, true, NULL);
--=20
2.21.0


