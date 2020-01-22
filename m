Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9424AC2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 16:48:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FEF821835
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 16:48:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wfs5+G7u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FEF821835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuJB2-0000km-78
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 11:48:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50066)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iuJ8U-0007dl-Jj
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 11:45:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iuJ8S-0000gs-7k
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 11:45:45 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:43186
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iuJ8R-0000gI-Qk
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 11:45:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579711542;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8HKTKA/iNVLjRvLNsFLbeJb0kNCt11tIQ5v5MJ/xzbk=;
 b=Wfs5+G7uGrlfWvpmPtWQiuV56NSuGUn8DROjGA67McGfF2JH3qXfbfWZlj9fH45ZkxJFpB
 3nCcAHuisIlP5j7ST1f7HQiLdCRZJEURcTMWblvk5D9GXctro6O8i63aBI/6/kwGGGXofa
 b1hGLXJFeGYCGM3MCr0YBeaRMfSUwmk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-45VAGMhzNYmZjP4UinEIzg-1; Wed, 22 Jan 2020 11:45:38 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F01A7800D4E;
 Wed, 22 Jan 2020 16:45:37 +0000 (UTC)
Received: from localhost (unknown [10.36.118.2])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8F6B066834;
 Wed, 22 Jan 2020 16:45:37 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 1/5] block/nbd: Fix hang in .bdrv_close()
Date: Wed, 22 Jan 2020 17:45:28 +0100
Message-Id: <20200122164532.178040-2-mreitz@redhat.com>
In-Reply-To: <20200122164532.178040-1-mreitz@redhat.com>
References: <20200122164532.178040-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: 45VAGMhzNYmZjP4UinEIzg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Kevin Wolf <kwolf@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
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
index d085554f21..6d3b22f844 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -70,6 +70,7 @@ typedef struct BDRVNBDState {
     CoMutex send_mutex;
     CoQueue free_sema;
     Coroutine *connection_co;
+    Coroutine *teardown_co;
     QemuCoSleepState *connection_co_sleep_ns_state;
     bool drained;
     bool wait_drained_end;
@@ -203,7 +204,15 @@ static void nbd_teardown_connection(BlockDriverState *=
bs)
             qemu_co_sleep_wake(s->connection_co_sleep_ns_state);
         }
     }
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
 }
=20
 static bool nbd_client_connecting(BDRVNBDState *s)
@@ -395,6 +404,9 @@ static coroutine_fn void nbd_connection_entry(void *opa=
que)
         s->ioc =3D NULL;
     }
=20
+    if (s->teardown_co) {
+        aio_co_wake(s->teardown_co);
+    }
     aio_wait_kick();
 }
=20
--=20
2.24.1


