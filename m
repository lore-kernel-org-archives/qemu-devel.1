Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD9FDC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 15:07:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99C9920663
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 15:07:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DYevB8be"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99C9920663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0RCn-0002ks-Q6
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 11:07:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39946)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k0R9X-0006Ft-Qm
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 11:04:27 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:20205
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k0R9V-0006u1-2C
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 11:04:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595948664;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r/a1rGqjYWIyOxl6RfY6IwBJxZ5hlPtmnidW1TBR+C0=;
 b=DYevB8bevnY/QKT7vGiDPF85PUwfXgYBtzdq7ZXzKHpmoYrL8tDD2e8/zpFKk8IVQGOv8U
 cLYU5ew2Hlma9LWdf7S6UkI24jbaBMUyFoMXmEt85U1M0OF8iU3DHd2aXqKVajzi4n7J56
 0IWltmMvaS+rgGFPK62Nup2OjXsLQwA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-345-x95emFrtNk67EN07YTod7A-1; Tue, 28 Jul 2020 11:04:20 -0400
X-MC-Unique: x95emFrtNk67EN07YTod7A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3BC741030C22;
 Tue, 28 Jul 2020 15:04:19 +0000 (UTC)
Received: from blue.redhat.com (ovpn-118-248.rdu2.redhat.com [10.10.118.248])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 634F719C71;
 Tue, 28 Jul 2020 15:04:18 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 7/9] block/nbd: allow drain during reconnect attempt
Date: Tue, 28 Jul 2020 10:04:05 -0500
Message-Id: <20200728150408.291299-8-eblake@redhat.com>
In-Reply-To: <20200728150408.291299-1-eblake@redhat.com>
References: <20200728150408.291299-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 10:31:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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

It should be safe to reenter qio_channel_yield() on io/channel read/write
path, so it's safe to reduce in_flight and allow attaching new aio
context. And no problem to allow drain itself: connection attempt is
not a guest request. Moreover, if remote server is down, we can hang
in negotiation, blocking drain section and provoking a dead lock.

How to reproduce the dead lock:

1. Create nbd-fault-injector.conf with the following contents:

[inject-error "mega1"]
event=data
io=readwrite
when=before

2. In one terminal run nbd-fault-injector in a loop, like this:

n=1; while true; do
    echo $n; ((n++));
    ./nbd-fault-injector.py 127.0.0.1:10000 nbd-fault-injector.conf;
done

3. In another terminal run qemu-io in a loop, like this:

n=1; while true; do
    echo $n; ((n++));
    ./qemu-io -c 'read 0 512' nbd://127.0.0.1:10000;
done

After some time, qemu-io will hang trying to drain, for example, like
this:

 #3 aio_poll (ctx=0x55f006bdd890, blocking=true) at
    util/aio-posix.c:600
 #4 bdrv_do_drained_begin (bs=0x55f006bea710, recursive=false,
    parent=0x0, ignore_bds_parents=false, poll=true) at block/io.c:427
 #5 bdrv_drained_begin (bs=0x55f006bea710) at block/io.c:433
 #6 blk_drain (blk=0x55f006befc80) at block/block-backend.c:1710
 #7 blk_unref (blk=0x55f006befc80) at block/block-backend.c:498
 #8 bdrv_open_inherit (filename=0x7fffba1563bc
    "nbd+tcp://127.0.0.1:10000", reference=0x0, options=0x55f006be86d0,
    flags=24578, parent=0x0, child_class=0x0, child_role=0,
    errp=0x7fffba154620) at block.c:3491
 #9 bdrv_open (filename=0x7fffba1563bc "nbd+tcp://127.0.0.1:10000",
    reference=0x0, options=0x0, flags=16386, errp=0x7fffba154620) at
    block.c:3513
 #10 blk_new_open (filename=0x7fffba1563bc "nbd+tcp://127.0.0.1:10000",
    reference=0x0, options=0x0, flags=16386, errp=0x7fffba154620) at
    block/block-backend.c:421

And connection_co stack like this:

 #0 qemu_coroutine_switch (from_=0x55f006bf2650, to_=0x7fe96e07d918,
    action=COROUTINE_YIELD) at util/coroutine-ucontext.c:302
 #1 qemu_coroutine_yield () at util/qemu-coroutine.c:193
 #2 qio_channel_yield (ioc=0x55f006bb3c20, condition=G_IO_IN) at
    io/channel.c:472
 #3 qio_channel_readv_all_eof (ioc=0x55f006bb3c20, iov=0x7fe96d729bf0,
    niov=1, errp=0x7fe96d729eb0) at io/channel.c:110
 #4 qio_channel_readv_all (ioc=0x55f006bb3c20, iov=0x7fe96d729bf0,
    niov=1, errp=0x7fe96d729eb0) at io/channel.c:143
 #5 qio_channel_read_all (ioc=0x55f006bb3c20, buf=0x7fe96d729d28
    "\300.\366\004\360U", buflen=8, errp=0x7fe96d729eb0) at
    io/channel.c:247
 #6 nbd_read (ioc=0x55f006bb3c20, buffer=0x7fe96d729d28, size=8,
    desc=0x55f004f69644 "initial magic", errp=0x7fe96d729eb0) at
    /work/src/qemu/master/include/block/nbd.h:365
 #7 nbd_read64 (ioc=0x55f006bb3c20, val=0x7fe96d729d28,
    desc=0x55f004f69644 "initial magic", errp=0x7fe96d729eb0) at
    /work/src/qemu/master/include/block/nbd.h:391
 #8 nbd_start_negotiate (aio_context=0x55f006bdd890,
    ioc=0x55f006bb3c20, tlscreds=0x0, hostname=0x0,
    outioc=0x55f006bf19f8, structured_reply=true,
    zeroes=0x7fe96d729dca, errp=0x7fe96d729eb0) at nbd/client.c:904
 #9 nbd_receive_negotiate (aio_context=0x55f006bdd890,
    ioc=0x55f006bb3c20, tlscreds=0x0, hostname=0x0,
    outioc=0x55f006bf19f8, info=0x55f006bf1a00, errp=0x7fe96d729eb0) at
    nbd/client.c:1032
 #10 nbd_client_connect (bs=0x55f006bea710, errp=0x7fe96d729eb0) at
    block/nbd.c:1460
 #11 nbd_reconnect_attempt (s=0x55f006bf19f0) at block/nbd.c:287
 #12 nbd_co_reconnect_loop (s=0x55f006bf19f0) at block/nbd.c:309
 #13 nbd_connection_entry (opaque=0x55f006bf19f0) at block/nbd.c:360
 #14 coroutine_trampoline (i0=113190480, i1=22000) at
    util/coroutine-ucontext.c:173

Note, that the hang may be
triggered by another bug, so the whole case is fixed only together with
commit "block/nbd: on shutdown terminate connection attempt".

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20200727184751.15704-3-vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/nbd.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/block/nbd.c b/block/nbd.c
index 3558c173e34b..ee9ab7512b65 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -291,8 +291,22 @@ static coroutine_fn void nbd_reconnect_attempt(BDRVNBDState *s)
         goto out;
     }

+    bdrv_dec_in_flight(s->bs);
+
     ret = nbd_client_handshake(s->bs, sioc, &local_err);

+    if (s->drained) {
+        s->wait_drained_end = true;
+        while (s->drained) {
+            /*
+             * We may be entered once from nbd_client_attach_aio_context_bh
+             * and then from nbd_client_co_drain_end. So here is a loop.
+             */
+            qemu_coroutine_yield();
+        }
+    }
+    bdrv_inc_in_flight(s->bs);
+
 out:
     s->connect_status = ret;
     error_free(s->connect_err);
-- 
2.27.0


