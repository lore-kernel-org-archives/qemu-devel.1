Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 115F2C31E51
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 11:45:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE06F2070B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 11:45:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE06F2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55844 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdCXw-0005sW-U6
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 07:45:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48334)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hdCWX-00041s-AF
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 07:43:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hdCWV-0000N3-6G
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 07:43:37 -0400
Received: from relay.sw.ru ([185.231.240.75]:58034)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hdCWU-0000Jn-Rc; Tue, 18 Jun 2019 07:43:35 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1hdCWO-00016b-Tv; Tue, 18 Jun 2019 14:43:29 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Tue, 18 Jun 2019 14:43:20 +0300
Message-Id: <20190618114328.55249-2-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190618114328.55249-1-vsementsov@virtuozzo.com>
References: <20190618114328.55249-1-vsementsov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v7 1/9] block/nbd: split connection_co start
 out of nbd_client_connect
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, armbru@redhat.com,
 mreitz@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

nbd_client_connect is going to be used from connection_co, so, let's
refactor nbd_client_connect in advance, leaving io channel
configuration all in nbd_client_connect.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block/nbd.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/block/nbd.c b/block/nbd.c
index 81edabbf35..46a1de7220 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -1232,14 +1232,8 @@ static int nbd_client_connect(BlockDriverState *bs,
         object_ref(OBJECT(s->ioc));
     }
 
-    /*
-     * Now that we're connected, set the socket to be non-blocking and
-     * kick the reply mechanism.
-     */
     qio_channel_set_blocking(QIO_CHANNEL(sioc), false, NULL);
-    s->connection_co = qemu_coroutine_create(nbd_connection_entry, s);
-    bdrv_inc_in_flight(bs);
-    nbd_client_attach_aio_context(bs, bdrv_get_aio_context(bs));
+    qio_channel_attach_aio_context(s->ioc, bdrv_get_aio_context(bs));
 
     trace_nbd_client_connect_success(export);
 
@@ -1270,14 +1264,24 @@ static int nbd_client_init(BlockDriverState *bs,
                            const char *x_dirty_bitmap,
                            Error **errp)
 {
+    int ret;
     BDRVNBDState *s = (BDRVNBDState *)bs->opaque;
 
     s->bs = bs;
     qemu_co_mutex_init(&s->send_mutex);
     qemu_co_queue_init(&s->free_sema);
 
-    return nbd_client_connect(bs, saddr, export, tlscreds, hostname,
-                              x_dirty_bitmap, errp);
+    ret = nbd_client_connect(bs, saddr, export, tlscreds, hostname,
+                             x_dirty_bitmap, errp);
+    if (ret < 0) {
+        return ret;
+    }
+
+    s->connection_co = qemu_coroutine_create(nbd_connection_entry, s);
+    bdrv_inc_in_flight(bs);
+    aio_co_schedule(bdrv_get_aio_context(bs), s->connection_co);
+
+    return 0;
 }
 
 static int nbd_parse_uri(const char *filename, QDict *options)
-- 
2.18.0


