Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D0AC433EA
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 15:05:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E1B4204EA
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 15:05:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NwrmcFVM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E1B4204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0RAw-0008Bn-Nm
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 11:05:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39916)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k0R9W-0006DE-DU
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 11:04:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22703
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k0R9U-0006tm-6C
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 11:04:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595948663;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SsgrxZXzr054DCT3tacjg72ARLC7VEvLE+gSU5BZj1k=;
 b=NwrmcFVMQZuy4k3H2SbadIbNX6FGNydDvZY41GOIUaYY+ydqG2KLmGiO6JoX4R9OBofOMZ
 0qPdkeW5qLdP77Cu2R0639tJGlNO6yzGCmKsJeSGtoxj56SJxywQkczUoWMVXsFrSv/NiK
 tfWXoGMphfttJCYtnh/hFYVHykgy0OU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-478-HK2DxJgPNXOqlkZAYXep-w-1; Tue, 28 Jul 2020 11:04:19 -0400
X-MC-Unique: HK2DxJgPNXOqlkZAYXep-w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 19D1358;
 Tue, 28 Jul 2020 15:04:18 +0000 (UTC)
Received: from blue.redhat.com (ovpn-118-248.rdu2.redhat.com [10.10.118.248])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4124319C71;
 Tue, 28 Jul 2020 15:04:17 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 6/9] block/nbd: split nbd_establish_connection out of
 nbd_client_connect
Date: Tue, 28 Jul 2020 10:04:04 -0500
Message-Id: <20200728150408.291299-7-eblake@redhat.com>
In-Reply-To: <20200728150408.291299-1-eblake@redhat.com>
References: <20200728150408.291299-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 10:31:20
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

We are going to implement non-blocking version of
nbd_establish_connection, which for a while will be used only for
nbd_reconnect_attempt, not for nbd_open, so we need to call it
separately.

Refactor nbd_reconnect_attempt in a way which makes next commit
simpler.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20200727184751.15704-2-vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/nbd.c        | 60 +++++++++++++++++++++++++++-------------------
 block/trace-events |  4 ++--
 2 files changed, 38 insertions(+), 26 deletions(-)

diff --git a/block/nbd.c b/block/nbd.c
index 8934bcb47901..3558c173e34b 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -93,7 +93,10 @@ typedef struct BDRVNBDState {
     char *x_dirty_bitmap;
 } BDRVNBDState;

-static int nbd_client_connect(BlockDriverState *bs, Error **errp);
+static QIOChannelSocket *nbd_establish_connection(SocketAddress *saddr,
+                                                  Error **errp);
+static int nbd_client_handshake(BlockDriverState *bs, QIOChannelSocket *sioc,
+                                Error **errp);

 static void nbd_clear_bdrvstate(BDRVNBDState *s)
 {
@@ -241,7 +244,9 @@ static bool nbd_client_connecting_wait(BDRVNBDState *s)

 static coroutine_fn void nbd_reconnect_attempt(BDRVNBDState *s)
 {
+    int ret;
     Error *local_err = NULL;
+    QIOChannelSocket *sioc;

     if (!nbd_client_connecting(s)) {
         return;
@@ -280,19 +285,25 @@ static coroutine_fn void nbd_reconnect_attempt(BDRVNBDState *s)
         s->ioc = NULL;
     }

-    s->connect_status = nbd_client_connect(s->bs, &local_err);
+    sioc = nbd_establish_connection(s->saddr, &local_err);
+    if (!sioc) {
+        ret = -ECONNREFUSED;
+        goto out;
+    }
+
+    ret = nbd_client_handshake(s->bs, sioc, &local_err);
+
+out:
+    s->connect_status = ret;
     error_free(s->connect_err);
     s->connect_err = NULL;
     error_propagate(&s->connect_err, local_err);

-    if (s->connect_status < 0) {
-        /* failed attempt */
-        return;
+    if (ret >= 0) {
+        /* successfully connected */
+        s->state = NBD_CLIENT_CONNECTED;
+        qemu_co_queue_restart_all(&s->free_sema);
     }
-
-    /* successfully connected */
-    s->state = NBD_CLIENT_CONNECTED;
-    qemu_co_queue_restart_all(&s->free_sema);
 }

 static coroutine_fn void nbd_co_reconnect_loop(BDRVNBDState *s)
@@ -1425,24 +1436,15 @@ static QIOChannelSocket *nbd_establish_connection(SocketAddress *saddr,
     return sioc;
 }

-static int nbd_client_connect(BlockDriverState *bs, Error **errp)
+/* nbd_client_handshake takes ownership on sioc. On failure it is unref'ed. */
+static int nbd_client_handshake(BlockDriverState *bs, QIOChannelSocket *sioc,
+                                Error **errp)
 {
     BDRVNBDState *s = (BDRVNBDState *)bs->opaque;
     AioContext *aio_context = bdrv_get_aio_context(bs);
     int ret;

-    /*
-     * establish TCP connection, return error if it fails
-     * TODO: Configurable retry-until-timeout behaviour.
-     */
-    QIOChannelSocket *sioc = nbd_establish_connection(s->saddr, errp);
-
-    if (!sioc) {
-        return -ECONNREFUSED;
-    }
-
-    /* NBD handshake */
-    trace_nbd_client_connect(s->export);
+    trace_nbd_client_handshake(s->export);
     qio_channel_set_blocking(QIO_CHANNEL(sioc), false, NULL);
     qio_channel_attach_aio_context(QIO_CHANNEL(sioc), aio_context);

@@ -1489,7 +1491,7 @@ static int nbd_client_connect(BlockDriverState *bs, Error **errp)
         object_ref(OBJECT(s->ioc));
     }

-    trace_nbd_client_connect_success(s->export);
+    trace_nbd_client_handshake_success(s->export);

     return 0;

@@ -1894,6 +1896,7 @@ static int nbd_open(BlockDriverState *bs, QDict *options, int flags,
 {
     int ret;
     BDRVNBDState *s = (BDRVNBDState *)bs->opaque;
+    QIOChannelSocket *sioc;

     ret = nbd_process_options(bs, options, errp);
     if (ret < 0) {
@@ -1904,7 +1907,16 @@ static int nbd_open(BlockDriverState *bs, QDict *options, int flags,
     qemu_co_mutex_init(&s->send_mutex);
     qemu_co_queue_init(&s->free_sema);

-    ret = nbd_client_connect(bs, errp);
+    /*
+     * establish TCP connection, return error if it fails
+     * TODO: Configurable retry-until-timeout behaviour.
+     */
+    sioc = nbd_establish_connection(s->saddr, errp);
+    if (!sioc) {
+        return -ECONNREFUSED;
+    }
+
+    ret = nbd_client_handshake(bs, sioc, errp);
     if (ret < 0) {
         nbd_clear_bdrvstate(s);
         return ret;
diff --git a/block/trace-events b/block/trace-events
index d3533ca8963c..915833506189 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -168,8 +168,8 @@ nbd_parse_blockstatus_compliance(const char *err) "ignoring extra data from non-
 nbd_structured_read_compliance(const char *type) "server sent non-compliant unaligned read %s chunk"
 nbd_read_reply_entry_fail(int ret, const char *err) "ret = %d, err: %s"
 nbd_co_request_fail(uint64_t from, uint32_t len, uint64_t handle, uint16_t flags, uint16_t type, const char *name, int ret, const char *err) "Request failed { .from = %" PRIu64", .len = %" PRIu32 ", .handle = %" PRIu64 ", .flags = 0x%" PRIx16 ", .type = %" PRIu16 " (%s) } ret = %d, err: %s"
-nbd_client_connect(const char *export_name) "export '%s'"
-nbd_client_connect_success(const char *export_name) "export '%s'"
+nbd_client_handshake(const char *export_name) "export '%s'"
+nbd_client_handshake_success(const char *export_name) "export '%s'"

 # ssh.c
 ssh_restart_coroutine(void *co) "co=%p"
-- 
2.27.0


