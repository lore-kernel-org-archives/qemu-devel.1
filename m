Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B089C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 16:24:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4109920882
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 16:24:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4109920882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46245 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP8K5-0003uy-EW
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 12:24:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hP8Cb-0004Pv-MC
	for qemu-devel@nongnu.org; Fri, 10 May 2019 12:16:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hP8Ca-0000GQ-FM
	for qemu-devel@nongnu.org; Fri, 10 May 2019 12:16:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54180)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hP8CV-000067-Nr; Fri, 10 May 2019 12:16:47 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0841C30842A9;
	Fri, 10 May 2019 16:16:47 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-116-183.ams2.redhat.com
	[10.36.116.183])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1BA1218504;
	Fri, 10 May 2019 16:16:45 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Fri, 10 May 2019 18:16:08 +0200
Message-Id: <20190510161614.23236-10-kwolf@redhat.com>
In-Reply-To: <20190510161614.23236-1-kwolf@redhat.com>
References: <20190510161614.23236-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.40]);
	Fri, 10 May 2019 16:16:47 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 09/15] vdi: Replace bdrv_{read,
 write}() with bdrv_{pread, pwrite}()
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alberto Garcia <berto@igalia.com>

There's only a couple of bdrv_read() and bdrv_write() calls left in
the vdi code, and they can be trivially replaced with the byte-based
bdrv_pread() and bdrv_pwrite().

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/vdi.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/block/vdi.c b/block/vdi.c
index e1c42ad732..d7ef6628e7 100644
--- a/block/vdi.c
+++ b/block/vdi.c
@@ -171,6 +171,8 @@ typedef struct {
     uint64_t unused2[7];
 } QEMU_PACKED VdiHeader;
=20
+QEMU_BUILD_BUG_ON(sizeof(VdiHeader) !=3D 512);
+
 typedef struct {
     /* The block map entries are little endian (even in memory). */
     uint32_t *bmap;
@@ -384,7 +386,7 @@ static int vdi_open(BlockDriverState *bs, QDict *opti=
ons, int flags,
=20
     logout("\n");
=20
-    ret =3D bdrv_read(bs->file, 0, (uint8_t *)&header, 1);
+    ret =3D bdrv_pread(bs->file, 0, &header, sizeof(header));
     if (ret < 0) {
         goto fail;
     }
@@ -484,8 +486,8 @@ static int vdi_open(BlockDriverState *bs, QDict *opti=
ons, int flags,
         goto fail;
     }
=20
-    ret =3D bdrv_read(bs->file, s->bmap_sector, (uint8_t *)s->bmap,
-                    bmap_size);
+    ret =3D bdrv_pread(bs->file, header.offset_bmap, s->bmap,
+                     bmap_size * SECTOR_SIZE);
     if (ret < 0) {
         goto fail_free_bmap;
     }
@@ -704,7 +706,7 @@ nonallocating_write:
         assert(VDI_IS_ALLOCATED(bmap_first));
         *header =3D s->header;
         vdi_header_to_le(header);
-        ret =3D bdrv_write(bs->file, 0, block, 1);
+        ret =3D bdrv_pwrite(bs->file, 0, block, sizeof(VdiHeader));
         g_free(block);
         block =3D NULL;
=20
@@ -722,10 +724,11 @@ nonallocating_write:
         base =3D ((uint8_t *)&s->bmap[0]) + bmap_first * SECTOR_SIZE;
         logout("will write %u block map sectors starting from entry %u\n=
",
                n_sectors, bmap_first);
-        ret =3D bdrv_write(bs->file, offset, base, n_sectors);
+        ret =3D bdrv_pwrite(bs->file, offset * SECTOR_SIZE, base,
+                          n_sectors * SECTOR_SIZE);
     }
=20
-    return ret;
+    return ret < 0 ? ret : 0;
 }
=20
 static int coroutine_fn vdi_co_do_create(BlockdevCreateOptions *create_o=
ptions,
--=20
2.20.1


