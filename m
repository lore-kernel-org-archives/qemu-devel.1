Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B6A8C10F27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 14:07:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 381A520726
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 14:07:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gMFeK+JI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 381A520726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC21e-0008Uq-Ew
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 10:07:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36593)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jC1nK-0004vK-S1
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 09:53:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1jC1nJ-00032z-P2
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 09:53:10 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:31483
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1jC1nJ-00031j-Iv
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 09:53:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583934787;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SR7ccQee2PC+SGrNBSxo7q7ndgv+qQ/0I0I0iqQSxn4=;
 b=gMFeK+JIgVpZNBehXP6ZBWJFZ0Igd4Zl5WmGZH1YPWoj0ZLtqFMhePN7A0WMue1gy+VQgk
 hIMgBJ7xRqUCKtY9ozfGHdQGxmrciaIR8EFj5w7yPQhl9OURhjgTpUlvkwef6RnUNCbczB
 iN8NsUjt3+Ht7nxy3c8ZkimpqgnFdbg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-O8fHF9uvOYelUXT_s0RhdA-1; Wed, 11 Mar 2020 09:53:03 -0400
X-MC-Unique: O8fHF9uvOYelUXT_s0RhdA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E5FDB1005510;
 Wed, 11 Mar 2020 13:53:01 +0000 (UTC)
Received: from localhost (ovpn-117-216.ams2.redhat.com [10.36.117.216])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6291F91D9B;
 Wed, 11 Mar 2020 13:53:01 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 15/19] block/block-copy: factor out
 find_conflicting_inflight_req
Date: Wed, 11 Mar 2020 14:52:09 +0100
Message-Id: <20200311135213.1242028-16-mreitz@redhat.com>
In-Reply-To: <20200311135213.1242028-1-mreitz@redhat.com>
References: <20200311135213.1242028-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Split find_conflicting_inflight_req to be used separately.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-Id: <20200311103004.7649-6-vsementsov@virtuozzo.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/block-copy.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/block/block-copy.c b/block/block-copy.c
index b075dba206..251d415a2c 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -24,23 +24,30 @@
 #define BLOCK_COPY_MAX_BUFFER (1 * MiB)
 #define BLOCK_COPY_MAX_MEM (128 * MiB)
=20
+static BlockCopyInFlightReq *find_conflicting_inflight_req(BlockCopyState =
*s,
+                                                           int64_t start,
+                                                           int64_t end)
+{
+    BlockCopyInFlightReq *req;
+
+    QLIST_FOREACH(req, &s->inflight_reqs, list) {
+        if (end > req->start_byte && start < req->end_byte) {
+            return req;
+        }
+    }
+
+    return NULL;
+}
+
 static void coroutine_fn block_copy_wait_inflight_reqs(BlockCopyState *s,
                                                        int64_t start,
                                                        int64_t end)
 {
     BlockCopyInFlightReq *req;
-    bool waited;
-
-    do {
-        waited =3D false;
-        QLIST_FOREACH(req, &s->inflight_reqs, list) {
-            if (end > req->start_byte && start < req->end_byte) {
-                qemu_co_queue_wait(&req->wait_queue, NULL);
-                waited =3D true;
-                break;
-            }
-        }
-    } while (waited);
+
+    while ((req =3D find_conflicting_inflight_req(s, start, end))) {
+        qemu_co_queue_wait(&req->wait_queue, NULL);
+    }
 }
=20
 static void block_copy_inflight_req_begin(BlockCopyState *s,
--=20
2.24.1


