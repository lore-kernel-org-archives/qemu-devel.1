Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D63DC28CC0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 09:40:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 774F525668
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 09:40:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 774F525668
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50063 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWHXy-0000LE-Om
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 05:40:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hWHS3-0004HR-NK
	for qemu-devel@nongnu.org; Thu, 30 May 2019 05:34:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hWHS2-0008Vf-L3
	for qemu-devel@nongnu.org; Thu, 30 May 2019 05:34:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49734)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>)
	id 1hWHS0-0008KB-Aj; Thu, 30 May 2019 05:34:20 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A33B43082263;
	Thu, 30 May 2019 09:34:19 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-112-57.ams2.redhat.com
	[10.36.112.57])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B2C165D704;
	Thu, 30 May 2019 09:34:18 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 30 May 2019 11:34:17 +0200
Message-Id: <20190530093417.23370-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.45]);
	Thu, 30 May 2019 09:34:19 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH resend] test-thread-pool: be more reliable
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There is a rare race between the atomic_cmpxchg and
bdrv_aio_cancel/bdrv_aio_cancel_async invocations.  Detect it, the
only sensible we can do about it is to exit long_cb immediately.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/test-thread-pool.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/tests/test-thread-pool.c b/tests/test-thread-pool.c
index 9cdccb3a47..0b675923f6 100644
--- a/tests/test-thread-pool.c
+++ b/tests/test-thread-pool.c
@@ -27,9 +27,10 @@ static int worker_cb(void *opaque)
 static int long_cb(void *opaque)
 {
     WorkerTestData *data =3D opaque;
-    atomic_inc(&data->n);
-    g_usleep(2000000);
-    atomic_inc(&data->n);
+    if (atomic_cmpxchg(&data->n, 0, 1) =3D=3D 0) {
+        g_usleep(2000000);
+        atomic_or(&data->n, 2);
+    }
     return 0;
 }
=20
@@ -171,7 +172,7 @@ static void do_test_cancel(bool sync)
     /* Cancel the jobs that haven't been started yet.  */
     num_canceled =3D 0;
     for (i =3D 0; i < 100; i++) {
-        if (atomic_cmpxchg(&data[i].n, 0, 3) =3D=3D 0) {
+        if (atomic_cmpxchg(&data[i].n, 0, 4) =3D=3D 0) {
             data[i].ret =3D -ECANCELED;
             if (sync) {
                 bdrv_aio_cancel(data[i].aiocb);
@@ -185,7 +186,7 @@ static void do_test_cancel(bool sync)
     g_assert_cmpint(num_canceled, <, 100);
=20
     for (i =3D 0; i < 100; i++) {
-        if (data[i].aiocb && data[i].n !=3D 3) {
+        if (data[i].aiocb && atomic_read(&data[i].n) < 4) {
             if (sync) {
                 /* Canceling the others will be a blocking operation.  *=
/
                 bdrv_aio_cancel(data[i].aiocb);
@@ -201,13 +202,22 @@ static void do_test_cancel(bool sync)
     }
     g_assert_cmpint(active, =3D=3D, 0);
     for (i =3D 0; i < 100; i++) {
-        if (data[i].n =3D=3D 3) {
+        g_assert(data[i].aiocb =3D=3D NULL);
+        switch (data[i].n) {
+        case 0:
+            fprintf(stderr, "Callback not canceled but never started?\n"=
);
+            abort();
+        case 3:
+            /* Couldn't be canceled asynchronously, must have completed.=
  */
+            g_assert_cmpint(data[i].ret, =3D=3D, 0);
+            break;
+        case 4:
+            /* Could be canceled asynchronously, never started.  */
             g_assert_cmpint(data[i].ret, =3D=3D, -ECANCELED);
-            g_assert(data[i].aiocb =3D=3D NULL);
-        } else {
-            g_assert_cmpint(data[i].n, =3D=3D, 2);
-            g_assert(data[i].ret =3D=3D 0 || data[i].ret =3D=3D -ECANCEL=
ED);
-            g_assert(data[i].aiocb =3D=3D NULL);
+            break;
+        default:
+            fprintf(stderr, "Callback aborted while running?\n");
+            abort();
         }
     }
 }
--=20
2.21.0


