Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A155C742D2
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 17:37:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3459F20838
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 17:37:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3459F20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlzTu-00023X-PK
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 13:37:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39673)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hlzSq-0006Ap-Ss
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 13:36:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hlzSp-0004B9-Su
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 13:36:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41506)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hlzSn-000469-Qd; Fri, 12 Jul 2019 13:36:05 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 23B31300194A;
 Fri, 12 Jul 2019 17:36:05 +0000 (UTC)
Received: from localhost (unknown [10.40.205.208])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B307919C58;
 Fri, 12 Jul 2019 17:36:04 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Fri, 12 Jul 2019 19:35:54 +0200
Message-Id: <20190712173600.14554-2-mreitz@redhat.com>
In-Reply-To: <20190712173600.14554-1-mreitz@redhat.com>
References: <20190712173600.14554-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Fri, 12 Jul 2019 17:36:05 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 1/7] block/nbd: Fix hang in .bdrv_close()
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

When nbd_close() is called from a coroutine, the connection_co never
gets to run, and thus nbd_teardown_connection() hangs.

This is because aio_co_enter() only puts the connection_co into the main
coroutine's wake-up queue, so this main coroutine needs to yield and
wait for connection_co to terminate.

Suggested-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/nbd.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/block/nbd.c b/block/nbd.c
index 81edabbf35..8f5ee86842 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -61,6 +61,7 @@ typedef struct BDRVNBDState {
     CoMutex send_mutex;
     CoQueue free_sema;
     Coroutine *connection_co;
+    Coroutine *teardown_co;
     int in_flight;
=20
     NBDClientRequest requests[MAX_NBD_REQUESTS];
@@ -135,7 +136,15 @@ static void nbd_teardown_connection(BlockDriverState=
 *bs)
     qio_channel_shutdown(s->ioc,
                          QIO_CHANNEL_SHUTDOWN_BOTH,
                          NULL);
-    BDRV_POLL_WHILE(bs, s->connection_co);
+    if (qemu_in_coroutine()) {
+        s->teardown_co =3D qemu_coroutine_self();
+        /* connection_co resumes us when it terminates */
+        qemu_coroutine_yield();
+        s->teardown_co =3D NULL;
+    } else {
+        BDRV_POLL_WHILE(bs, s->connection_co);
+    }
+    assert(!s->connection_co);
=20
     nbd_client_detach_aio_context(bs);
     object_unref(OBJECT(s->sioc));
@@ -207,6 +216,9 @@ static coroutine_fn void nbd_connection_entry(void *o=
paque)
     bdrv_dec_in_flight(s->bs);
=20
     s->connection_co =3D NULL;
+    if (s->teardown_co) {
+        aio_co_wake(s->teardown_co);
+    }
     aio_wait_kick();
 }
=20
--=20
2.21.0


