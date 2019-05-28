Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D79C8C04AB6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 19:42:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0547208CB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 19:42:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0547208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41681 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVhzU-0002pm-00
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 15:42:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hVhow-0002JH-OI
	for qemu-devel@nongnu.org; Tue, 28 May 2019 15:31:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hVhou-0002Yb-PY
	for qemu-devel@nongnu.org; Tue, 28 May 2019 15:31:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42214)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hVhof-0000py-Tt; Tue, 28 May 2019 15:31:24 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BC7F5307E04E;
	Tue, 28 May 2019 19:29:17 +0000 (UTC)
Received: from localhost (unknown [10.40.205.223])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 52B855F9A6;
	Tue, 28 May 2019 19:29:17 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Tue, 28 May 2019 21:28:37 +0200
Message-Id: <20190528192847.2730-12-mreitz@redhat.com>
In-Reply-To: <20190528192847.2730-1-mreitz@redhat.com>
References: <20190528192847.2730-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.42]);
	Tue, 28 May 2019 19:29:22 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 11/21] block/backup: refactor and tolerate
 unallocated cluster skipping
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Split allocation checking to separate function and reduce nesting.
Consider bdrv_is_allocated() fail as allocated area, as copying more
than needed is not wrong (and we do it anyway) and seems better than
fail the whole job. And, most probably we will fail on the next read,
if there are real problem with source.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-id: 20190429090842.57910-4-vsementsov@virtuozzo.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/backup.c | 60 +++++++++++++++++++-------------------------------
 1 file changed, 23 insertions(+), 37 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index 98a2d2b070..78f1b79354 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -368,6 +368,22 @@ static bool coroutine_fn yield_and_check(BackupBlock=
Job *job)
     return false;
 }
=20
+static bool bdrv_is_unallocated_range(BlockDriverState *bs,
+                                      int64_t offset, int64_t bytes)
+{
+    int64_t end =3D offset + bytes;
+
+    while (offset < end && !bdrv_is_allocated(bs, offset, bytes, &bytes)=
) {
+        if (bytes =3D=3D 0) {
+            return true;
+        }
+        offset +=3D bytes;
+        bytes =3D end - offset;
+    }
+
+    return offset >=3D end;
+}
+
 static int coroutine_fn backup_run_incremental(BackupBlockJob *job)
 {
     int ret;
@@ -453,49 +469,19 @@ static int coroutine_fn backup_run(Job *job, Error =
**errp)
         for (offset =3D 0; offset < s->len;
              offset +=3D s->cluster_size) {
             bool error_is_read;
-            int alloced =3D 0;
=20
             if (yield_and_check(s)) {
                 break;
             }
=20
-            if (s->sync_mode =3D=3D MIRROR_SYNC_MODE_TOP) {
-                int i;
-                int64_t n;
-
-                /* Check to see if these blocks are already in the
-                 * backing file. */
-
-                for (i =3D 0; i < s->cluster_size;) {
-                    /* bdrv_is_allocated() only returns true/false based
-                     * on the first set of sectors it comes across that
-                     * are are all in the same state.
-                     * For that reason we must verify each sector in the
-                     * backup cluster length.  We end up copying more th=
an
-                     * needed but at some point that is always the case.=
 */
-                    alloced =3D
-                        bdrv_is_allocated(bs, offset + i,
-                                          s->cluster_size - i, &n);
-                    i +=3D n;
-
-                    if (alloced || n =3D=3D 0) {
-                        break;
-                    }
-                }
-
-                /* If the above loop never found any sectors that are in
-                 * the topmost image, skip this backup. */
-                if (alloced =3D=3D 0) {
-                    continue;
-                }
-            }
-            /* FULL sync mode we copy the whole drive. */
-            if (alloced < 0) {
-                ret =3D alloced;
-            } else {
-                ret =3D backup_do_cow(s, offset, s->cluster_size,
-                                    &error_is_read, false);
+            if (s->sync_mode =3D=3D MIRROR_SYNC_MODE_TOP &&
+                bdrv_is_unallocated_range(bs, offset, s->cluster_size))
+            {
+                continue;
             }
+
+            ret =3D backup_do_cow(s, offset, s->cluster_size,
+                                &error_is_read, false);
             if (ret < 0) {
                 /* Depending on error action, fail now or retry cluster =
*/
                 BlockErrorAction action =3D
--=20
2.21.0


