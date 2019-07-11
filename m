Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49419C742A1
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 19:58:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17501208E4
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 19:58:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17501208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlfD9-0004W9-U8
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 15:58:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51307)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hlfCt-0003kK-G7
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 15:58:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hlfCr-0000lm-4U
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 15:58:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:23784)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1hlfCp-0000jn-Nn
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 15:58:16 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AF3358762B;
 Thu, 11 Jul 2019 19:58:13 +0000 (UTC)
Received: from localhost (unknown [10.40.205.198])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EF2405DA65;
 Thu, 11 Jul 2019 19:58:10 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Thu, 11 Jul 2019 21:58:00 +0200
Message-Id: <20190711195804.30703-2-mreitz@redhat.com>
In-Reply-To: <20190711195804.30703-1-mreitz@redhat.com>
References: <20190711195804.30703-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Thu, 11 Jul 2019 19:58:13 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [RFC 1/5] block/nbd: Fix hang in .bdrv_close()
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

When nbd_close() is called from a coroutine, the connection_co never
gets to run, and thus nbd_teardown_connection() hangs.

This is because aio_co_enter() only puts the connection_co into the main
coroutine's wake-up queue, so this main coroutine needs to yield and
reschedule itself to let the connection_co run.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/nbd.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/block/nbd.c b/block/nbd.c
index 81edabbf35..b83b6cd43e 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -135,7 +135,17 @@ static void nbd_teardown_connection(BlockDriverState=
 *bs)
     qio_channel_shutdown(s->ioc,
                          QIO_CHANNEL_SHUTDOWN_BOTH,
                          NULL);
-    BDRV_POLL_WHILE(bs, s->connection_co);
+
+    if (qemu_in_coroutine()) {
+        /* Let our caller poll and just yield until connection_co is don=
e */
+        while (s->connection_co) {
+            aio_co_schedule(qemu_get_current_aio_context(),
+                            qemu_coroutine_self());
+            qemu_coroutine_yield();
+        }
+    } else {
+        BDRV_POLL_WHILE(bs, s->connection_co);
+    }
=20
     nbd_client_detach_aio_context(bs);
     object_unref(OBJECT(s->sioc));
--=20
2.21.0


