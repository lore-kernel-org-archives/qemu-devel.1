Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 517A0C43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 23:31:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 238D52087B
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 23:31:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 238D52087B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55042 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLcDX-0004qA-8l
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 19:31:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1hLcBJ-0002jz-Gv
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 19:29:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1hLbyR-0001YQ-Ry
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 19:15:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49958)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>)
	id 1hLbyQ-0001Xo-Ms; Tue, 30 Apr 2019 19:15:42 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A450183F42;
	Tue, 30 Apr 2019 23:15:41 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-206.bos.redhat.com [10.18.17.206])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 991E219497;
	Tue, 30 Apr 2019 23:15:36 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 30 Apr 2019 19:15:36 -0400
Message-Id: <20190430231536.25353-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Tue, 30 Apr 2019 23:15:41 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH RFC] migration/dirty-bitmaps: change bitmap
 enumeration method
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
Cc: Fam Zheng <fam@euphon.net>, vsementsov@virtuozzo.com, qemu-block@nongnu.org,
	Juan Quintela <quintela@redhat.com>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190430231536.tl8caZ-YZr4EoJIEUZDPU-CUROzTCLWp9exYLZmJVr8@z>

Shift from looking at every root BDS to *every* BDS.
Tested only lightly via iotests.

Counter-examples that break this approach welcome.
---
 migration/block-dirty-bitmap.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitma=
p.c
index d1bb863cb6..4a896a09eb 100644
--- a/migration/block-dirty-bitmap.c
+++ b/migration/block-dirty-bitmap.c
@@ -273,7 +273,6 @@ static int init_dirty_bitmap_migration(void)
     BlockDriverState *bs;
     BdrvDirtyBitmap *bitmap;
     DirtyBitmapMigBitmapState *dbms;
-    BdrvNextIterator it;
     Error *local_err =3D NULL;
=20
     dirty_bitmap_mig_state.bulk_completed =3D false;
@@ -281,13 +280,8 @@ static int init_dirty_bitmap_migration(void)
     dirty_bitmap_mig_state.prev_bitmap =3D NULL;
     dirty_bitmap_mig_state.no_bitmaps =3D false;
=20
-    for (bs =3D bdrv_first(&it); bs; bs =3D bdrv_next(&it)) {
-        const char *drive_name =3D bdrv_get_device_or_node_name(bs);
-
-        /* skip automatically inserted nodes */
-        while (bs && bs->drv && bs->implicit) {
-            bs =3D backing_bs(bs);
-        }
+    for (bs =3D bdrv_next_all_states(NULL); bs; bs =3D bdrv_next_all_sta=
tes(bs)) {
+        const char *name =3D bdrv_get_device_or_node_name(bs);
=20
         for (bitmap =3D bdrv_dirty_bitmap_next(bs, NULL); bitmap;
              bitmap =3D bdrv_dirty_bitmap_next(bs, bitmap))
@@ -296,7 +290,7 @@ static int init_dirty_bitmap_migration(void)
                 continue;
             }
=20
-            if (drive_name =3D=3D NULL) {
+            if (!name || strcmp(name, "") =3D=3D 0) {
                 error_report("Found bitmap '%s' in unnamed node %p. It c=
an't "
                              "be migrated", bdrv_dirty_bitmap_name(bitma=
p), bs);
                 goto fail;
@@ -313,7 +307,7 @@ static int init_dirty_bitmap_migration(void)
=20
             dbms =3D g_new0(DirtyBitmapMigBitmapState, 1);
             dbms->bs =3D bs;
-            dbms->node_name =3D drive_name;
+            dbms->node_name =3D name;
             dbms->bitmap =3D bitmap;
             dbms->total_sectors =3D bdrv_nb_sectors(bs);
             dbms->sectors_per_chunk =3D CHUNK_SIZE * 8 *
--=20
2.20.1


