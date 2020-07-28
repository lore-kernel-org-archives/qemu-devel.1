Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7331FC43467
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 15:14:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41870206D8
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 15:14:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dXKQBtSm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41870206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0RJ2-0006cU-GV
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 11:14:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40078)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k0R9d-0006S2-5b
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 11:04:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58350
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k0R9b-0006vt-FE
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 11:04:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595948670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ud/U6DKMNFT/byf9RgFHSOlNS0KW7MtFl8y7LTDHIqw=;
 b=dXKQBtSmvE03oj8jc1lVuDyF33RDVTGSlDMwmdMlXxSxZYPl98wRnBiQtxwbVEIRBgLVpj
 D6SeT40wpd6QpKIOwlg2TbBufIogRITTMAhcdRppc2t1ks1VikZ2RB626Sbwj5i2g1APZn
 BU2EZrcfCZz+p/WpAWXjmn5FIiBLl6U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-165-2Js8r9QKM2-YhU9KrQGpMQ-1; Tue, 28 Jul 2020 11:04:27 -0400
X-MC-Unique: 2Js8r9QKM2-YhU9KrQGpMQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1D7CA800460;
 Tue, 28 Jul 2020 15:04:26 +0000 (UTC)
Received: from blue.redhat.com (ovpn-118-248.rdu2.redhat.com [10.10.118.248])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D2EDB19C71;
 Tue, 28 Jul 2020 15:04:22 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 9/9] block/nbd: nbd_co_reconnect_loop(): don't sleep if drained
Date: Tue, 28 Jul 2020 10:04:07 -0500
Message-Id: <20200728150408.291299-10-eblake@redhat.com>
In-Reply-To: <20200728150408.291299-1-eblake@redhat.com>
References: <20200728150408.291299-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 10:28:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

We try to go to wakeable sleep, so that, if drain begins it will break
the sleep. But what if nbd_client_co_drain_begin() already called and
s->drained is already true? We'll go to sleep, and drain will have to
wait for the whole timeout. Let's improve it.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20200727184751.15704-5-vsementsov@virtuozzo.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/nbd.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/block/nbd.c b/block/nbd.c
index 620c97be6ba2..7bb881fef49c 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -341,8 +341,6 @@ static coroutine_fn void nbd_co_reconnect_loop(BDRVNBDState *s)
             qemu_co_queue_restart_all(&s->free_sema);
         }

-        qemu_co_sleep_ns_wakeable(QEMU_CLOCK_REALTIME, timeout,
-                                  &s->connection_co_sleep_ns_state);
         if (s->drained) {
             bdrv_dec_in_flight(s->bs);
             s->wait_drained_end = true;
@@ -354,9 +352,12 @@ static coroutine_fn void nbd_co_reconnect_loop(BDRVNBDState *s)
                 qemu_coroutine_yield();
             }
             bdrv_inc_in_flight(s->bs);
-        }
-        if (timeout < max_timeout) {
-            timeout *= 2;
+        } else {
+            qemu_co_sleep_ns_wakeable(QEMU_CLOCK_REALTIME, timeout,
+                                      &s->connection_co_sleep_ns_state);
+            if (timeout < max_timeout) {
+                timeout *= 2;
+            }
         }

         nbd_reconnect_attempt(s);
-- 
2.27.0


