Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 593BDC43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 15:21:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 221D0206F2
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 15:21:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QgwnxmLu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 221D0206F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHqnx-0000gl-8s
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 11:21:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41576)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jHqmP-00074L-8T
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 11:20:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jHqmN-0005VQ-MO
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 11:20:16 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:43404)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jHqmN-0005UD-IV
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 11:20:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585322415;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v9Dwt/l/3f/NkOpjSpxk8goKSC0gIUVj2nMxQnoV/Os=;
 b=QgwnxmLuDUsMX0gz6Lyl05MsNtSeBztRfA69JdMIwexBE5Hy3uBx3eneSdksmoGBwYzdJY
 NG5Vh7z0tTMMh8M+VjIn/yK3hYED/7DvWjylK9jErZfHn0bThcVHiEPatB/K66/FmuHb5F
 Kr6m9ZvEu+JAaqJJA+xKJ0cuosii9F4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-482-emo1VSGQPqOd-2MtOsgUAQ-1; Fri, 27 Mar 2020 11:20:11 -0400
X-MC-Unique: emo1VSGQPqOd-2MtOsgUAQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9E5AB1005512;
 Fri, 27 Mar 2020 15:20:10 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-113-253.ams2.redhat.com
 [10.36.113.253])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A13752CE63;
 Fri, 27 Mar 2020 15:20:09 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 4/6] Revert "mirror: Don't let an operation wait for itself"
Date: Fri, 27 Mar 2020 16:19:48 +0100
Message-Id: <20200327151950.11820-5-kwolf@redhat.com>
In-Reply-To: <20200327151950.11820-1-kwolf@redhat.com>
References: <20200327151950.11820-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This reverts commit 7e6c4ff792734e196c8ca82564c56b5e7c6288ca.

The fix was incomplete as it only protected against requests waiting for
themselves, but not against requests waiting for each other. We need a
different solution.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-Id: <20200326153628.4869-2-kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/mirror.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index 6203e5946e..5879e63473 100644
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
@@ -810,7 +807,7 @@ static int coroutine_fn mirror_dirty_init(MirrorBlockJo=
b *s)
             if (s->in_flight >=3D MAX_IN_FLIGHT) {
                 trace_mirror_yield(s, UINT64_MAX, s->buf_free_count,
                                    s->in_flight);
-                mirror_wait_for_free_in_flight_slot(s, NULL);
+                mirror_wait_for_free_in_flight_slot(s);
                 continue;
             }
=20
@@ -963,7 +960,7 @@ static int coroutine_fn mirror_run(Job *job, Error **er=
rp)
         /* Do not start passive operations while there are active
          * writes in progress */
         while (s->in_active_write_counter) {
-            mirror_wait_for_any_operation(s, NULL, true);
+            mirror_wait_for_any_operation(s, true);
         }
=20
         if (s->ret < 0) {
@@ -989,7 +986,7 @@ static int coroutine_fn mirror_run(Job *job, Error **er=
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


