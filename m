Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF8FC43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 15:38:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5713E20714
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 15:38:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TbbAxGUn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5713E20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHUae-0007Qg-Eh
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 11:38:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54458)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jHUYn-0005Vn-5p
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 11:36:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jHUYk-0002rO-M1
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 11:36:44 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:49948)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jHUYi-0002pW-Ou
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 11:36:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585236999;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/8wyeUj06KXeS38TLcF04SKwHtzws1PB37ZwA+U4vxc=;
 b=TbbAxGUnv74qSx9Kwo1eEg4JTcy4dUZnRvkjDAo4prnUu0IwOfvJnmnzUuTMD2mDPAZ8s1
 KPdTYWWbRb7YtQcqj27qWyWdc5W3s3XN6kMh38J5cPGmq7C2Cec9VDzks+WRLgTAXzdSYr
 d2dGL0dQ2AOdwVzW7S5x7lfB8RvzXY8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-NJixbO6bMdeyNjBOvkuDZw-1; Thu, 26 Mar 2020 11:36:37 -0400
X-MC-Unique: NJixbO6bMdeyNjBOvkuDZw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EEEB0A0CBF;
 Thu, 26 Mar 2020 15:36:36 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-112-205.ams2.redhat.com
 [10.36.112.205])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A4A2D5C1BA;
 Thu, 26 Mar 2020 15:36:35 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 1/2] Revert "mirror: Don't let an operation wait for itself"
Date: Thu, 26 Mar 2020 16:36:27 +0100
Message-Id: <20200326153628.4869-2-kwolf@redhat.com>
In-Reply-To: <20200326153628.4869-1-kwolf@redhat.com>
References: <20200326153628.4869-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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

This reverts commit 7e6c4ff792734e196c8ca82564c56b5e7c6288ca.

The fix was incomplete as it only protected against requests waiting for
themselves, but not against requests waiting for each other. We need a
different solution.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/mirror.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index 447051dbc6..393131b135 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -283,14 +283,11 @@ static int mirror_cow_align(MirrorBlockJob *s, int64_=
t *offset,
 }
=20
 static inline void coroutine_fn
-mirror_wait_for_any_operation(MirrorBlockJob *s, MirrorOp *self, bool acti=
ve)
+mirror_wait_for_any_operation(MirrorBlockJob *s, bool active)
 {
     MirrorOp *op;
=20
     QTAILQ_FOREACH(op, &s->ops_in_flight, next) {
-        if (self =3D=3D op) {
-            continue;
-        }
         /* Do not wait on pseudo ops, because it may in turn wait on
          * some other operation to start, which may in fact be the
          * caller of this function.  Since there is only one pseudo op
@@ -305,10 +302,10 @@ mirror_wait_for_any_operation(MirrorBlockJob *s, Mirr=
orOp *self, bool active)
 }
=20
 static inline void coroutine_fn
-mirror_wait_for_free_in_flight_slot(MirrorBlockJob *s, MirrorOp *self)
+mirror_wait_for_free_in_flight_slot(MirrorBlockJob *s)
 {
     /* Only non-active operations use up in-flight slots */
-    mirror_wait_for_any_operation(s, self, false);
+    mirror_wait_for_any_operation(s, false);
 }
=20
 /* Perform a mirror copy operation.
@@ -351,7 +348,7 @@ static void coroutine_fn mirror_co_read(void *opaque)
=20
     while (s->buf_free_count < nb_chunks) {
         trace_mirror_yield_in_flight(s, op->offset, s->in_flight);
-        mirror_wait_for_free_in_flight_slot(s, op);
+        mirror_wait_for_free_in_flight_slot(s);
     }
=20
     /* Now make a QEMUIOVector taking enough granularity-sized chunks
@@ -558,7 +555,7 @@ static uint64_t coroutine_fn mirror_iteration(MirrorBlo=
ckJob *s)
=20
         while (s->in_flight >=3D MAX_IN_FLIGHT) {
             trace_mirror_yield_in_flight(s, offset, s->in_flight);
-            mirror_wait_for_free_in_flight_slot(s, pseudo_op);
+            mirror_wait_for_free_in_flight_slot(s);
         }
=20
         if (s->ret < 0) {
@@ -612,7 +609,7 @@ static void mirror_free_init(MirrorBlockJob *s)
 static void coroutine_fn mirror_wait_for_all_io(MirrorBlockJob *s)
 {
     while (s->in_flight > 0) {
-        mirror_wait_for_free_in_flight_slot(s, NULL);
+        mirror_wait_for_free_in_flight_slot(s);
     }
 }
=20
@@ -809,7 +806,7 @@ static int coroutine_fn mirror_dirty_init(MirrorBlockJo=
b *s)
             if (s->in_flight >=3D MAX_IN_FLIGHT) {
                 trace_mirror_yield(s, UINT64_MAX, s->buf_free_count,
                                    s->in_flight);
-                mirror_wait_for_free_in_flight_slot(s, NULL);
+                mirror_wait_for_free_in_flight_slot(s);
                 continue;
             }
=20
@@ -962,7 +959,7 @@ static int coroutine_fn mirror_run(Job *job, Error **er=
rp)
         /* Do not start passive operations while there are active
          * writes in progress */
         while (s->in_active_write_counter) {
-            mirror_wait_for_any_operation(s, NULL, true);
+            mirror_wait_for_any_operation(s, true);
         }
=20
         if (s->ret < 0) {
@@ -988,7 +985,7 @@ static int coroutine_fn mirror_run(Job *job, Error **er=
rp)
             if (s->in_flight >=3D MAX_IN_FLIGHT || s->buf_free_count =3D=
=3D 0 ||
                 (cnt =3D=3D 0 && s->in_flight > 0)) {
                 trace_mirror_yield(s, cnt, s->buf_free_count, s->in_flight=
);
-                mirror_wait_for_free_in_flight_slot(s, NULL);
+                mirror_wait_for_free_in_flight_slot(s);
                 continue;
             } else if (cnt !=3D 0) {
                 delay_ns =3D mirror_iteration(s);
--=20
2.20.1


