Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 918A4C433E7
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 19:02:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01E05207DE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 19:02:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JQKAHuhQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01E05207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQbBZ-0001SV-Oc
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 15:02:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46778)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kQb92-0007rf-3f
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 15:00:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38224)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kQb8y-0003ec-Nf
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 15:00:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602183600;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4qktdI4uhc6c69sTTM2Fdk9uN3AishJ8gqSG4A3JvRE=;
 b=JQKAHuhQNfJLWpQpjNv3EFE/6d9rSomHR2/Z3tw35WUIRd2b8j82nHAaMB+I8EOVkE8jzp
 VzN9grLx9FH87SK6TzZWYArqfbeeJACxWML0+KOb+ZMatlkgaH8HNzSYgceCt5EfIF5+9q
 URCHcsakOY9MPA77J3i0eqBxqz60CkI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-GvQG1q3ePGWM-Gprbc_8cg-1; Thu, 08 Oct 2020 14:59:57 -0400
X-MC-Unique: GvQG1q3ePGWM-Gprbc_8cg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A6F10109106C;
 Thu,  8 Oct 2020 18:59:56 +0000 (UTC)
Received: from blue.redhat.com (ovpn-113-14.phx2.redhat.com [10.3.113.14])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3A4545D9E8;
 Thu,  8 Oct 2020 18:59:56 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 4/8] block/nbd: fix reconnect-delay
Date: Thu,  8 Oct 2020 13:59:47 -0500
Message-Id: <20201008185951.1026052-5-eblake@redhat.com>
In-Reply-To: <20201008185951.1026052-1-eblake@redhat.com>
References: <20201008185951.1026052-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/08 02:56:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

reconnect-delay has a design flaw: we handle it in the same loop where
we do connection attempt. So, reconnect-delay may be exceeded by
unpredictable time of connection attempt.

Let's instead use separate timer.

How to reproduce the bug:

1. Create an image on node1:
   qemu-img create -f qcow2 xx 100M

2. Start NBD server on node1:
   qemu-nbd xx

3. On node2 start qemu-io:

./build/qemu-io --image-opts \
driver=nbd,server.type=inet,server.host=192.168.100.5,server.port=10809,reconnect-delay=15

4. Type 'read 0 512' in qemu-io interface to check that connection
   works

Be careful: you should make steps 5-7 in a short time, less than 15
seconds.

5. Kill nbd server on node1

6. Run 'read 0 512' in qemu-io interface again, to be sure that nbd
client goes to reconnect loop.

7. On node1 run the following command

   sudo iptables -A INPUT -p tcp --dport 10809 -j DROP

This will make the connect() call of qemu-io at node2 take a long time.

And you'll see that read command in qemu-io will hang for a long time,
more than 15 seconds specified by reconnect-delay parameter. It's the
bug.

8. Don't forget to drop iptables rule on node1:

   sudo iptables -D INPUT -p tcp --dport 10809 -j DROP

Important note: Step [5] is necessary to reproduce _this_ bug. If we
miss step [5], the read command (step 6) will hang for a long time and
this commit doesn't help, because there will be not long connect() to
unreachable host, but long sendmsg() to unreachable host, which should
be fixed by enabling and adjusting keep-alive on the socket, which is a
thing for further patch set.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20200903190301.367620-4-vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/nbd.c | 59 +++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 50 insertions(+), 9 deletions(-)

diff --git a/block/nbd.c b/block/nbd.c
index a495ad7ddff8..caae0e6d311c 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -122,6 +122,8 @@ typedef struct BDRVNBDState {
     Error *connect_err;
     bool wait_in_flight;

+    QEMUTimer *reconnect_delay_timer;
+
     NBDClientRequest requests[MAX_NBD_REQUESTS];
     NBDReply reply;
     BlockDriverState *bs;
@@ -188,10 +190,49 @@ static void nbd_recv_coroutines_wake_all(BDRVNBDState *s)
     }
 }

+static void reconnect_delay_timer_del(BDRVNBDState *s)
+{
+    if (s->reconnect_delay_timer) {
+        timer_del(s->reconnect_delay_timer);
+        timer_free(s->reconnect_delay_timer);
+        s->reconnect_delay_timer = NULL;
+    }
+}
+
+static void reconnect_delay_timer_cb(void *opaque)
+{
+    BDRVNBDState *s = opaque;
+
+    if (s->state == NBD_CLIENT_CONNECTING_WAIT) {
+        s->state = NBD_CLIENT_CONNECTING_NOWAIT;
+        while (qemu_co_enter_next(&s->free_sema, NULL)) {
+            /* Resume all queued requests */
+        }
+    }
+
+    reconnect_delay_timer_del(s);
+}
+
+static void reconnect_delay_timer_init(BDRVNBDState *s, uint64_t expire_time_ns)
+{
+    if (s->state != NBD_CLIENT_CONNECTING_WAIT) {
+        return;
+    }
+
+    assert(!s->reconnect_delay_timer);
+    s->reconnect_delay_timer = aio_timer_new(bdrv_get_aio_context(s->bs),
+                                             QEMU_CLOCK_REALTIME,
+                                             SCALE_NS,
+                                             reconnect_delay_timer_cb, s);
+    timer_mod(s->reconnect_delay_timer, expire_time_ns);
+}
+
 static void nbd_client_detach_aio_context(BlockDriverState *bs)
 {
     BDRVNBDState *s = (BDRVNBDState *)bs->opaque;

+    /* Timer is deleted in nbd_client_co_drain_begin() */
+    assert(!s->reconnect_delay_timer);
     qio_channel_detach_aio_context(QIO_CHANNEL(s->ioc));
 }

@@ -243,6 +284,8 @@ static void coroutine_fn nbd_client_co_drain_begin(BlockDriverState *bs)

     nbd_co_establish_connection_cancel(bs, false);

+    reconnect_delay_timer_del(s);
+
     if (s->state == NBD_CLIENT_CONNECTING_WAIT) {
         s->state = NBD_CLIENT_CONNECTING_NOWAIT;
         qemu_co_queue_restart_all(&s->free_sema);
@@ -593,21 +636,17 @@ out:

 static coroutine_fn void nbd_co_reconnect_loop(BDRVNBDState *s)
 {
-    uint64_t start_time_ns = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
-    uint64_t delay_ns = s->reconnect_delay * NANOSECONDS_PER_SECOND;
     uint64_t timeout = 1 * NANOSECONDS_PER_SECOND;
     uint64_t max_timeout = 16 * NANOSECONDS_PER_SECOND;

+    if (s->state == NBD_CLIENT_CONNECTING_WAIT) {
+        reconnect_delay_timer_init(s, qemu_clock_get_ns(QEMU_CLOCK_REALTIME) +
+                                   s->reconnect_delay * NANOSECONDS_PER_SECOND);
+    }
+
     nbd_reconnect_attempt(s);

     while (nbd_client_connecting(s)) {
-        if (s->state == NBD_CLIENT_CONNECTING_WAIT &&
-            qemu_clock_get_ns(QEMU_CLOCK_REALTIME) - start_time_ns > delay_ns)
-        {
-            s->state = NBD_CLIENT_CONNECTING_NOWAIT;
-            qemu_co_queue_restart_all(&s->free_sema);
-        }
-
         if (s->drained) {
             bdrv_dec_in_flight(s->bs);
             s->wait_drained_end = true;
@@ -629,6 +668,8 @@ static coroutine_fn void nbd_co_reconnect_loop(BDRVNBDState *s)

         nbd_reconnect_attempt(s);
     }
+
+    reconnect_delay_timer_del(s);
 }

 static coroutine_fn void nbd_connection_entry(void *opaque)
-- 
2.28.0


