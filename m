Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A918FC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 19:05:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A226207DE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 19:05:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BrIJMwuk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A226207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQbE6-0003xp-MJ
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 15:05:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46792)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kQb92-0007sy-M5
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 15:00:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55487)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kQb8z-0003eq-8f
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 15:00:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602183600;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=er1dq4UvrjPdK8E4Wjs2FYeYIdtl7Wpn3tEwzUuFp1w=;
 b=BrIJMwukwC8ScJprtRQk7Mt+BrywOJt6hOPgS9yBfdOF4HWOl+o2iwoUbk4W4m9GvAA9sq
 ThHGISRKN7jeDeQiJuAWJjM9Mqrd4agyqBx9sIiZFnkxSf2JSjfCY6i3N9XgKyaoXP+xC8
 5yRmkd7n9HRc0bevyFEQ/etCMoSEW4c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-593-z8VMtOJGMXag00_1_c6Teg-1; Thu, 08 Oct 2020 14:59:56 -0400
X-MC-Unique: z8VMtOJGMXag00_1_c6Teg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 552A48070E3;
 Thu,  8 Oct 2020 18:59:55 +0000 (UTC)
Received: from blue.redhat.com (ovpn-113-14.phx2.redhat.com [10.3.113.14])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DCB1F5D9E8;
 Thu,  8 Oct 2020 18:59:54 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 2/8] block/nbd: fix drain dead-lock because of nbd
 reconnect-delay
Date: Thu,  8 Oct 2020 13:59:45 -0500
Message-Id: <20201008185951.1026052-3-eblake@redhat.com>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

We pause reconnect process during drained section. So, if we have some
requests, waiting for reconnect we should cancel them, otherwise they
deadlock the drained section.

How to reproduce:

1. Create an image:
   qemu-img create -f qcow2 xx 100M

2. Start NBD server:
   qemu-nbd xx

3. Start vm with second nbd disk on node2, like this:

  ./build/x86_64-softmmu/qemu-system-x86_64 -nodefaults -drive \
     file=/work/images/cent7.qcow2 -drive \
     driver=nbd,server.type=inet,server.host=192.168.100.5,server.port=10809,reconnect-delay=60 \
     -vnc :0 -m 2G -enable-kvm -vga std

4. Access the vm through vnc (or some other way?), and check that NBD
   drive works:

   dd if=/dev/sdb of=/dev/null bs=1M count=10

   - the command should succeed.

5. Now, kill the nbd server, and run dd in the guest again:

   dd if=/dev/sdb of=/dev/null bs=1M count=10

Now Qemu is trying to reconnect, and dd-generated requests are waiting
for the connection (they will wait up to 60 seconds (see
reconnect-delay option above) and than fail). But suddenly, vm may
totally hang in the deadlock. You may need to increase reconnect-delay
period to catch the dead-lock.

VM doesn't respond because drain dead-lock happens in cpu thread with
global mutex taken. That's not good thing by itself and is not fixed
by this commit (true way is using iothreads). Still this commit fixes
drain dead-lock itself.

Note: probably, we can instead continue to reconnect during drained
section. To achieve this, we may move negotiation to the connect thread
to make it independent of bs aio context. But expanding drained section
doesn't seem good anyway. So, let's now fix the bug the simplest way.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20200903190301.367620-2-vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/nbd.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/block/nbd.c b/block/nbd.c
index 9daf003bea30..912ea27be7d8 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -242,6 +242,11 @@ static void coroutine_fn nbd_client_co_drain_begin(BlockDriverState *bs)
     }

     nbd_co_establish_connection_cancel(bs, false);
+
+    if (s->state == NBD_CLIENT_CONNECTING_WAIT) {
+        s->state = NBD_CLIENT_CONNECTING_NOWAIT;
+        qemu_co_queue_restart_all(&s->free_sema);
+    }
 }

 static void coroutine_fn nbd_client_co_drain_end(BlockDriverState *bs)
-- 
2.28.0


