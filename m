Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C3CC43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 15:38:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 577FE20714
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 15:38:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GNLj7mC6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 577FE20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHUaM-0006xR-Cv
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 11:38:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54459)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jHUYn-0005Vo-Bx
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 11:36:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jHUYk-0002re-OY
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 11:36:44 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:37985)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jHUYk-0002qd-JY
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 11:36:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585237001;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Nfo30rj6FM0R7h4c2RpNlC8JzNBVqLhSr60I3x2Ghys=;
 b=GNLj7mC64P4yXbpPmQXFGcxNxxhHz7J8C9AGRtkcp/luPoQe98vG71LDtEchr0KbIadgjy
 PH+POunPCCffTbIkN0iMADKW4GP+VPEeDvJ+eGw5WLt944WSjAvcghPfIPwiBTd+SRmxhD
 3HbCm1SUm6mYnLoaGpA4w3EriHi4M/E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-289-lH5Q5k4JM9GLuxaWldwAPg-1; Thu, 26 Mar 2020 11:36:39 -0400
X-MC-Unique: lH5Q5k4JM9GLuxaWldwAPg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8A167192D785;
 Thu, 26 Mar 2020 15:36:38 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-112-205.ams2.redhat.com
 [10.36.112.205])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4233F5C1BA;
 Thu, 26 Mar 2020 15:36:37 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 2/2] mirror: Wait only for in-flight operations
Date: Thu, 26 Mar 2020 16:36:28 +0100
Message-Id: <20200326153628.4869-3-kwolf@redhat.com>
In-Reply-To: <20200326153628.4869-1-kwolf@redhat.com>
References: <20200326153628.4869-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: kwolf@redhat.com, jsnow@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

mirror_wait_for_free_in_flight_slot() just picks a random operation to
wait for. However, a MirrorOp is already in s->ops_in_flight when
mirror_co_read() waits for free slots, so if not enough slots are
immediately available, an operation can end up waiting for itself, or
two or more operations can wait for each other to complete, which
results in a hang.

Fix this by adding a flag to MirrorOp that tells us if the request is
already in flight (and therefore occupies slots that it will later
free), and picking only such operations for waiting.

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=3D1794692
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/mirror.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/block/mirror.c b/block/mirror.c
index 393131b135..88414d1653 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -102,6 +102,7 @@ struct MirrorOp {
=20
     bool is_pseudo_op;
     bool is_active_write;
+    bool is_in_flight;
     CoQueue waiting_requests;
     Coroutine *co;
=20
@@ -293,7 +294,9 @@ mirror_wait_for_any_operation(MirrorBlockJob *s, bool a=
ctive)
          * caller of this function.  Since there is only one pseudo op
          * at any given time, we will always find some real operation
          * to wait on. */
-        if (!op->is_pseudo_op && op->is_active_write =3D=3D active) {
+        if (!op->is_pseudo_op && op->is_in_flight &&
+            op->is_active_write =3D=3D active)
+        {
             qemu_co_queue_wait(&op->waiting_requests, NULL);
             return;
         }
@@ -367,6 +370,7 @@ static void coroutine_fn mirror_co_read(void *opaque)
     /* Copy the dirty cluster.  */
     s->in_flight++;
     s->bytes_in_flight +=3D op->bytes;
+    op->is_in_flight =3D true;
     trace_mirror_one_iteration(s, op->offset, op->bytes);
=20
     ret =3D bdrv_co_preadv(s->mirror_top_bs->backing, op->offset, op->byte=
s,
@@ -382,6 +386,7 @@ static void coroutine_fn mirror_co_zero(void *opaque)
     op->s->in_flight++;
     op->s->bytes_in_flight +=3D op->bytes;
     *op->bytes_handled =3D op->bytes;
+    op->is_in_flight =3D true;
=20
     ret =3D blk_co_pwrite_zeroes(op->s->target, op->offset, op->bytes,
                                op->s->unmap ? BDRV_REQ_MAY_UNMAP : 0);
@@ -396,6 +401,7 @@ static void coroutine_fn mirror_co_discard(void *opaque=
)
     op->s->in_flight++;
     op->s->bytes_in_flight +=3D op->bytes;
     *op->bytes_handled =3D op->bytes;
+    op->is_in_flight =3D true;
=20
     ret =3D blk_co_pdiscard(op->s->target, op->offset, op->bytes);
     mirror_write_complete(op, ret);
@@ -1318,6 +1324,7 @@ static MirrorOp *coroutine_fn active_write_prepare(Mi=
rrorBlockJob *s,
         .offset             =3D offset,
         .bytes              =3D bytes,
         .is_active_write    =3D true,
+        .is_in_flight       =3D true,
     };
     qemu_co_queue_init(&op->waiting_requests);
     QTAILQ_INSERT_TAIL(&s->ops_in_flight, op, next);
--=20
2.20.1


