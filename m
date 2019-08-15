Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37402C3A589
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 18:38:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EF9D2083B
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 18:38:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EF9D2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyKdj-0000RX-0l
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 14:38:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37564)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1hyKXC-00030j-Dt
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 14:31:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1hyKX6-0001s8-AA
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 14:31:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38313)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1hyKWz-0001f3-CH; Thu, 15 Aug 2019 14:31:25 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BB21FC04DBCD;
 Thu, 15 Aug 2019 18:31:23 +0000 (UTC)
Received: from blue.redhat.com (ovpn-117-22.phx2.redhat.com [10.3.117.22])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 48C1512A72;
 Thu, 15 Aug 2019 18:31:23 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 15 Aug 2019 13:30:35 -0500
Message-Id: <20190815183039.4264-6-eblake@redhat.com>
In-Reply-To: <20190815183039.4264-1-eblake@redhat.com>
References: <20190815183039.4264-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Thu, 15 Aug 2019 18:31:23 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 5/9] block/nbd: split connection_co start out of
 nbd_client_connect
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

nbd_client_connect is going to be used from connection_co, so, let's
refactor nbd_client_connect in advance, leaving io channel
configuration all in nbd_client_connect.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20190618114328.55249-2-vsementsov@virtuozzo.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/nbd.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/block/nbd.c b/block/nbd.c
index 57c1a205811a..c16d02528b2f 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -1231,14 +1231,8 @@ static int nbd_client_connect(BlockDriverState *bs=
,
         object_ref(OBJECT(s->ioc));
     }

-    /*
-     * Now that we're connected, set the socket to be non-blocking and
-     * kick the reply mechanism.
-     */
     qio_channel_set_blocking(QIO_CHANNEL(sioc), false, NULL);
-    s->connection_co =3D qemu_coroutine_create(nbd_connection_entry, s);
-    bdrv_inc_in_flight(bs);
-    nbd_client_attach_aio_context(bs, bdrv_get_aio_context(bs));
+    qio_channel_attach_aio_context(s->ioc, bdrv_get_aio_context(bs));

     trace_nbd_client_connect_success(export);

@@ -1269,14 +1263,24 @@ static int nbd_client_init(BlockDriverState *bs,
                            const char *x_dirty_bitmap,
                            Error **errp)
 {
+    int ret;
     BDRVNBDState *s =3D (BDRVNBDState *)bs->opaque;

     s->bs =3D bs;
     qemu_co_mutex_init(&s->send_mutex);
     qemu_co_queue_init(&s->free_sema);

-    return nbd_client_connect(bs, saddr, export, tlscreds, hostname,
-                              x_dirty_bitmap, errp);
+    ret =3D nbd_client_connect(bs, saddr, export, tlscreds, hostname,
+                             x_dirty_bitmap, errp);
+    if (ret < 0) {
+        return ret;
+    }
+
+    s->connection_co =3D qemu_coroutine_create(nbd_connection_entry, s);
+    bdrv_inc_in_flight(bs);
+    aio_co_schedule(bdrv_get_aio_context(bs), s->connection_co);
+
+    return 0;
 }

 static int nbd_parse_uri(const char *filename, QDict *options)
--=20
2.20.1


