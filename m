Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EBEBC072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 17:33:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7680821848
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 17:33:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7680821848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57883 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUE3v-0000jv-Jl
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 13:32:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hUE23-0007Ea-VF
	for qemu-devel@nongnu.org; Fri, 24 May 2019 13:31:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hUDzg-0004SL-7v
	for qemu-devel@nongnu.org; Fri, 24 May 2019 13:28:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40850)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hUDze-0004RO-VN; Fri, 24 May 2019 13:28:35 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4610030C1AE6;
	Fri, 24 May 2019 17:28:29 +0000 (UTC)
Received: from localhost (ovpn-204-150.brq.redhat.com [10.40.204.150])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id CEBA510027B6;
	Fri, 24 May 2019 17:28:26 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Fri, 24 May 2019 19:28:12 +0200
Message-Id: <20190524172812.27308-4-mreitz@redhat.com>
In-Reply-To: <20190524172812.27308-1-mreitz@redhat.com>
References: <20190524172812.27308-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.40]);
	Fri, 24 May 2019 17:28:34 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [RFC 3/3] qcow2: Evaluate rotational info
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
Cc: Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
	Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org,
	Max Reitz <mreitz@redhat.com>,
	Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The new handle_alloc_space() function only speeds up the allocation of
new ranges on solid-state drives.  We should skip it if we know that the
file is stored on a rotating disk.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2.h |  3 +++
 block/qcow2.c | 34 ++++++++++++++++++++++++++++++----
 2 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index fc1b0d3c1e..5052ab187f 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -359,6 +359,9 @@ typedef struct BDRVQcow2State {
=20
     bool metadata_preallocation_checked;
     bool metadata_preallocation;
+
+    /* True if the image is stored on a rotating disk */
+    bool optimize_for_rotating;
 } BDRVQcow2State;
=20
 typedef struct Qcow2COWRegion {
diff --git a/block/qcow2.c b/block/qcow2.c
index 14f914117f..b4df6d5085 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1197,6 +1197,22 @@ static int qcow2_update_options(BlockDriverState *=
bs, QDict *options,
     return ret;
 }
=20
+static void qcow2_update_rotational_info(BlockDriverState *bs)
+{
+    BDRVQcow2State *s =3D bs->opaque;
+    BlockDriverInfo file_bdi;
+
+    s->optimize_for_rotating =3D false;
+
+    if (bdrv_get_info(bs->file->bs, &file_bdi) < 0) {
+        return;
+    }
+
+    s->optimize_for_rotating =3D
+        file_bdi.has_rotational_info &&
+        file_bdi.rotational_info =3D=3D IMAGE_ROTATIONAL_INFO_ROTATING;
+}
+
 /* Called with s->lock held.  */
 static int coroutine_fn qcow2_do_open(BlockDriverState *bs, QDict *optio=
ns,
                                       int flags, Error **errp)
@@ -1461,6 +1477,8 @@ static int coroutine_fn qcow2_do_open(BlockDriverSt=
ate *bs, QDict *options,
         }
     }
=20
+    qcow2_update_rotational_info(bs);
+
     /* Parse driver-specific options */
     ret =3D qcow2_update_options(bs, options, flags, errp);
     if (ret < 0) {
@@ -1829,6 +1847,8 @@ static void qcow2_reopen_commit(BDRVReopenState *st=
ate)
 {
     qcow2_update_options_commit(state->bs, state->opaque);
     g_free(state->opaque);
+
+    qcow2_update_rotational_info(state->bs);
 }
=20
 static void qcow2_reopen_abort(BDRVReopenState *state)
@@ -2297,10 +2317,16 @@ static coroutine_fn int qcow2_co_pwritev(BlockDri=
verState *bs, uint64_t offset,
             qemu_iovec_add(&hd_qiov, cluster_data, cur_bytes);
         }
=20
-        /* Try to efficiently initialize the physical space with zeroes =
*/
-        ret =3D handle_alloc_space(bs, l2meta);
-        if (ret < 0) {
-            goto out_unlocked;
+        /*
+         * Try to efficiently initialize the physical space with zeroes.
+         * This incurs a performance penalty on rotating disks, so
+         * avoid doing it there.
+         */
+        if (!s->optimize_for_rotating) {
+            ret =3D handle_alloc_space(bs, l2meta);
+            if (ret < 0) {
+                goto out_unlocked;
+            }
         }
=20
         /* If we need to do COW, check if it's possible to merge the
--=20
2.21.0


