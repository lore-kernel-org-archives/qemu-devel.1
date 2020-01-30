Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09BE7C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 21:33:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA80B20674
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 21:33:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SOZCFPqV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA80B20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixHRb-0000aA-Tn
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 16:33:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55914)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1ixHPZ-0006ra-RG
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 16:31:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1ixHPY-00050T-Dr
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 16:31:41 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28565
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ixHPY-0004z4-96
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 16:31:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580419899;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pQP9OA32VCmZvu+nXMW5sTI/63FgkAGA9WupDP5WqyE=;
 b=SOZCFPqV0y1RrAsuFb4bJpsLUGi6+QGRl/44tZJJduLL0aVJSpFL/fIf/uVxPWgYNfkdtN
 IzrYXC94jkqsESvJLAYxbutpl7jsbr2qESeohkirN0KgcQmcJdjRoNAlAaELbjYIakqlCY
 bqZinMTOT+b4jsZvKXVqMacNTf02n4Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-4gZiXK0JMAyL8Qb98S8e2g-1; Thu, 30 Jan 2020 16:31:37 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7C9511005513;
 Thu, 30 Jan 2020 21:31:36 +0000 (UTC)
Received: from localhost (unknown [10.36.118.87])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CB43B19488;
 Thu, 30 Jan 2020 21:31:30 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 03/18] block/io: take bs->reqs_lock in
 bdrv_mark_request_serialising
Date: Thu, 30 Jan 2020 21:30:59 +0000
Message-Id: <20200130213114.325157-4-stefanha@redhat.com>
In-Reply-To: <20200130213114.325157-1-stefanha@redhat.com>
References: <20200130213114.325157-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 4gZiXK0JMAyL8Qb98S8e2g-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
 qemu-block@nongnu.org, Peter Lieven <pl@kamp.de>,
 Julia Suvorova <jusual@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Paolo Bonzini <pbonzini@redhat.com>

bdrv_mark_request_serialising is writing the overlap_offset and
overlap_bytes fields of BdrvTrackedRequest.  Take bs->reqs_lock
for the whole duration of it, and not just when waiting for
serialising requests, so that tracked_request_overlaps does not
look at a half-updated request.

The new code does not unlock/relock around retries.  This is unnecessary
because a retry is always preceded by a CoQueue wait, which already
releases and reacquires bs->reqs_lock.

Reported-by: Peter Lieven <pl@kamp.de>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-id: 1578495356-46219-4-git-send-email-pbonzini@redhat.com
Message-Id: <1578495356-46219-4-git-send-email-pbonzini@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/io.c | 112 ++++++++++++++++++++++++++++++-----------------------
 1 file changed, 63 insertions(+), 49 deletions(-)

diff --git a/block/io.c b/block/io.c
index c466df8ed5..1eb2b2bddc 100644
--- a/block/io.c
+++ b/block/io.c
@@ -41,7 +41,6 @@
 #define MAX_BOUNCE_BUFFER (32768 << BDRV_SECTOR_BITS)
=20
 static void bdrv_parent_cb_resize(BlockDriverState *bs);
-static bool coroutine_fn bdrv_wait_serialising_requests(BdrvTrackedRequest=
 *self);
 static int coroutine_fn bdrv_co_do_pwrite_zeroes(BlockDriverState *bs,
     int64_t offset, int bytes, BdrvRequestFlags flags);
=20
@@ -716,12 +715,69 @@ static void tracked_request_begin(BdrvTrackedRequest =
*req,
     qemu_co_mutex_unlock(&bs->reqs_lock);
 }
=20
+static bool tracked_request_overlaps(BdrvTrackedRequest *req,
+                                     int64_t offset, uint64_t bytes)
+{
+    /*        aaaa   bbbb */
+    if (offset >=3D req->overlap_offset + req->overlap_bytes) {
+        return false;
+    }
+    /* bbbb   aaaa        */
+    if (req->overlap_offset >=3D offset + bytes) {
+        return false;
+    }
+    return true;
+}
+
+static bool coroutine_fn
+bdrv_wait_serialising_requests_locked(BlockDriverState *bs,
+                                      BdrvTrackedRequest *self)
+{
+    BdrvTrackedRequest *req;
+    bool retry;
+    bool waited =3D false;
+
+    do {
+        retry =3D false;
+        QLIST_FOREACH(req, &bs->tracked_requests, list) {
+            if (req =3D=3D self || (!req->serialising && !self->serialisin=
g)) {
+                continue;
+            }
+            if (tracked_request_overlaps(req, self->overlap_offset,
+                                         self->overlap_bytes))
+            {
+                /* Hitting this means there was a reentrant request, for
+                 * example, a block driver issuing nested requests.  This =
must
+                 * never happen since it means deadlock.
+                 */
+                assert(qemu_coroutine_self() !=3D req->co);
+
+                /* If the request is already (indirectly) waiting for us, =
or
+                 * will wait for us as soon as it wakes up, then just go o=
n
+                 * (instead of producing a deadlock in the former case). *=
/
+                if (!req->waiting_for) {
+                    self->waiting_for =3D req;
+                    qemu_co_queue_wait(&req->wait_queue, &bs->reqs_lock);
+                    self->waiting_for =3D NULL;
+                    retry =3D true;
+                    waited =3D true;
+                    break;
+                }
+            }
+        }
+    } while (retry);
+    return waited;
+}
+
 bool bdrv_mark_request_serialising(BdrvTrackedRequest *req, uint64_t align=
)
 {
+    BlockDriverState *bs =3D req->bs;
     int64_t overlap_offset =3D req->offset & ~(align - 1);
     uint64_t overlap_bytes =3D ROUND_UP(req->offset + req->bytes, align)
                                - overlap_offset;
+    bool waited;
=20
+    qemu_co_mutex_lock(&bs->reqs_lock);
     if (!req->serialising) {
         atomic_inc(&req->bs->serialising_in_flight);
         req->serialising =3D true;
@@ -729,7 +785,9 @@ bool bdrv_mark_request_serialising(BdrvTrackedRequest *=
req, uint64_t align)
=20
     req->overlap_offset =3D MIN(req->overlap_offset, overlap_offset);
     req->overlap_bytes =3D MAX(req->overlap_bytes, overlap_bytes);
-    return bdrv_wait_serialising_requests(req);
+    waited =3D bdrv_wait_serialising_requests_locked(bs, req);
+    qemu_co_mutex_unlock(&bs->reqs_lock);
+    return waited;
 }
=20
 /**
@@ -783,20 +841,6 @@ static int bdrv_get_cluster_size(BlockDriverState *bs)
     }
 }
=20
-static bool tracked_request_overlaps(BdrvTrackedRequest *req,
-                                     int64_t offset, uint64_t bytes)
-{
-    /*        aaaa   bbbb */
-    if (offset >=3D req->overlap_offset + req->overlap_bytes) {
-        return false;
-    }
-    /* bbbb   aaaa        */
-    if (req->overlap_offset >=3D offset + bytes) {
-        return false;
-    }
-    return true;
-}
-
 void bdrv_inc_in_flight(BlockDriverState *bs)
 {
     atomic_inc(&bs->in_flight);
@@ -816,45 +860,15 @@ void bdrv_dec_in_flight(BlockDriverState *bs)
 static bool coroutine_fn bdrv_wait_serialising_requests(BdrvTrackedRequest=
 *self)
 {
     BlockDriverState *bs =3D self->bs;
-    BdrvTrackedRequest *req;
-    bool retry;
     bool waited =3D false;
=20
     if (!atomic_read(&bs->serialising_in_flight)) {
         return false;
     }
=20
-    do {
-        retry =3D false;
-        qemu_co_mutex_lock(&bs->reqs_lock);
-        QLIST_FOREACH(req, &bs->tracked_requests, list) {
-            if (req =3D=3D self || (!req->serialising && !self->serialisin=
g)) {
-                continue;
-            }
-            if (tracked_request_overlaps(req, self->overlap_offset,
-                                         self->overlap_bytes))
-            {
-                /* Hitting this means there was a reentrant request, for
-                 * example, a block driver issuing nested requests.  This =
must
-                 * never happen since it means deadlock.
-                 */
-                assert(qemu_coroutine_self() !=3D req->co);
-
-                /* If the request is already (indirectly) waiting for us, =
or
-                 * will wait for us as soon as it wakes up, then just go o=
n
-                 * (instead of producing a deadlock in the former case). *=
/
-                if (!req->waiting_for) {
-                    self->waiting_for =3D req;
-                    qemu_co_queue_wait(&req->wait_queue, &bs->reqs_lock);
-                    self->waiting_for =3D NULL;
-                    retry =3D true;
-                    waited =3D true;
-                    break;
-                }
-            }
-        }
-        qemu_co_mutex_unlock(&bs->reqs_lock);
-    } while (retry);
+    qemu_co_mutex_lock(&bs->reqs_lock);
+    waited =3D bdrv_wait_serialising_requests_locked(bs, self);
+    qemu_co_mutex_unlock(&bs->reqs_lock);
=20
     return waited;
 }
--=20
2.24.1


