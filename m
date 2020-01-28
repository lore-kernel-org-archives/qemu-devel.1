Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CEDEC2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 15:19:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1997624683
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 15:19:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aftfcSVC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1997624683
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwSe7-0005Nu-AP
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 10:19:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33275)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iwSdD-0004ML-7T
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 10:18:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iwSdA-0003dr-Ts
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 10:18:22 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48365
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iwSdA-0003d1-Jv
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 10:18:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580224699;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zjC0WJacR+CukA9vSHIb1ajtg0i3wEuf7gyGAcSjcxY=;
 b=aftfcSVCIwDfcjrmEYP0+2sPwFVeY4AeG2PfETe+3UjthjXXZXrH0CdRFQqvUT3hKw3DKW
 gUPfmZxVP4kppPqIuPpIQBG7Wx28xAyP6KLSf5ZxqdE7Qb6DAK9kEk35VhjUQLvr4pf7S8
 1jeC85g7/rCqtqVNPAu4tcqY3JlnWAk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-298-OfeGEKmGNI6C074GOxKJKQ-1; Tue, 28 Jan 2020 10:18:17 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A8CF21019129;
 Tue, 28 Jan 2020 15:18:16 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-117-106.ams2.redhat.com
 [10.36.117.106])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3116489D2E;
 Tue, 28 Jan 2020 15:18:14 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 2/2] mirror: Don't let an operation wait for itself
Date: Tue, 28 Jan 2020 16:17:55 +0100
Message-Id: <20200128151755.25162-3-kwolf@redhat.com>
In-Reply-To: <20200128151755.25162-1-kwolf@redhat.com>
References: <20200128151755.25162-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: OfeGEKmGNI6C074GOxKJKQ-1
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
Cc: kwolf@redhat.com, jsnow@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

mirror_wait_for_free_in_flight_slot() just picks a random operation to
wait for. However, when mirror_co_read() waits for free slots, its
MirrorOp is already in s->ops_in_flight, so if not enough slots are
immediately available, an operation can end up waiting for itself to
complete, which results in a hang.

Fix this by passing the current MirrorOp and skipping this operation
when picking an operation to wait for.

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=3D1794692
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/mirror.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index 8959e4255f..cacbc70014 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -283,11 +283,14 @@ static int mirror_cow_align(MirrorBlockJob *s, int64_=
t *offset,
 }
=20
 static inline void coroutine_fn
-mirror_wait_for_any_operation(MirrorBlockJob *s, bool active)
+mirror_wait_for_any_operation(MirrorBlockJob *s, MirrorOp *self, bool acti=
ve)
 {
     MirrorOp *op;
=20
     QTAILQ_FOREACH(op, &s->ops_in_flight, next) {
+        if (self =3D=3D op) {
+            continue;
+        }
         /* Do not wait on pseudo ops, because it may in turn wait on
          * some other operation to start, which may in fact be the
          * caller of this function.  Since there is only one pseudo op
@@ -302,10 +305,10 @@ mirror_wait_for_any_operation(MirrorBlockJob *s, bool=
 active)
 }
=20
 static inline void coroutine_fn
-mirror_wait_for_free_in_flight_slot(MirrorBlockJob *s)
+mirror_wait_for_free_in_flight_slot(MirrorBlockJob *s, MirrorOp *self)
 {
     /* Only non-active operations use up in-flight slots */
-    mirror_wait_for_any_operation(s, false);
+    mirror_wait_for_any_operation(s, self, false);
 }
=20
 /* Perform a mirror copy operation.
@@ -348,7 +351,7 @@ static void coroutine_fn mirror_co_read(void *opaque)
=20
     while (s->buf_free_count < nb_chunks) {
         trace_mirror_yield_in_flight(s, op->offset, s->in_flight);
-        mirror_wait_for_free_in_flight_slot(s);
+        mirror_wait_for_free_in_flight_slot(s, op);
     }
=20
     /* Now make a QEMUIOVector taking enough granularity-sized chunks
@@ -555,7 +558,7 @@ static uint64_t coroutine_fn mirror_iteration(MirrorBlo=
ckJob *s)
=20
         while (s->in_flight >=3D MAX_IN_FLIGHT) {
             trace_mirror_yield_in_flight(s, offset, s->in_flight);
-            mirror_wait_for_free_in_flight_slot(s);
+            mirror_wait_for_free_in_flight_slot(s, pseudo_op);
         }
=20
         if (s->ret < 0) {
@@ -609,7 +612,7 @@ static void mirror_free_init(MirrorBlockJob *s)
 static void coroutine_fn mirror_wait_for_all_io(MirrorBlockJob *s)
 {
     while (s->in_flight > 0) {
-        mirror_wait_for_free_in_flight_slot(s);
+        mirror_wait_for_free_in_flight_slot(s, NULL);
     }
 }
=20
@@ -794,7 +797,7 @@ static int coroutine_fn mirror_dirty_init(MirrorBlockJo=
b *s)
             if (s->in_flight >=3D MAX_IN_FLIGHT) {
                 trace_mirror_yield(s, UINT64_MAX, s->buf_free_count,
                                    s->in_flight);
-                mirror_wait_for_free_in_flight_slot(s);
+                mirror_wait_for_free_in_flight_slot(s, NULL);
                 continue;
             }
=20
@@ -947,7 +950,7 @@ static int coroutine_fn mirror_run(Job *job, Error **er=
rp)
         /* Do not start passive operations while there are active
          * writes in progress */
         while (s->in_active_write_counter) {
-            mirror_wait_for_any_operation(s, true);
+            mirror_wait_for_any_operation(s, NULL, true);
         }
=20
         if (s->ret < 0) {
@@ -973,7 +976,7 @@ static int coroutine_fn mirror_run(Job *job, Error **er=
rp)
             if (s->in_flight >=3D MAX_IN_FLIGHT || s->buf_free_count =3D=
=3D 0 ||
                 (cnt =3D=3D 0 && s->in_flight > 0)) {
                 trace_mirror_yield(s, cnt, s->buf_free_count, s->in_flight=
);
-                mirror_wait_for_free_in_flight_slot(s);
+                mirror_wait_for_free_in_flight_slot(s, NULL);
                 continue;
             } else if (cnt !=3D 0) {
                 delay_ns =3D mirror_iteration(s);
--=20
2.20.1


