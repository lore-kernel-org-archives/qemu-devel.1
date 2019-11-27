Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D11C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 13:41:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C690520678
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 13:41:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fk2+LupF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C690520678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZxZl-0002Bo-EK
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 08:41:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34097)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iZxCE-0004Qd-Ld
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 08:17:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iZxCD-000764-F4
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 08:17:30 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59410
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iZxCD-00075b-Bn
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 08:17:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574860648;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hUcoJFZmL63uc2AX5HnnkY9UColT/h3fdc3ujtmCuKY=;
 b=fk2+LupF0RLFuJ8umbopbmIBIhclvINS/RXd+E9R6+4xICjrWDx7pvsbBnsjotIItOQdKz
 QcLkgIZcH82hgt/uuLZtwOoe22hFswAUZ5hJpxi6A4ft4uxcBMdbcBxff8gCmsx8cjD+Bw
 tIw/cJ00T3YD3segwPNox23FioYGtBU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-422-PS18mk0bM1Cb7aGYvCXqMQ-1; Wed, 27 Nov 2019 08:17:25 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D6B33106C00E;
 Wed, 27 Nov 2019 13:17:24 +0000 (UTC)
Received: from localhost (ovpn-205-186.brq.redhat.com [10.40.205.186])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 70DB6600C8;
 Wed, 27 Nov 2019 13:17:24 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH for-5.0 24/31] block: Use child_of_bds in remaining places
Date: Wed, 27 Nov 2019 14:16:17 +0100
Message-Id: <20191127131624.1062403-25-mreitz@redhat.com>
In-Reply-To: <20191127131624.1062403-1-mreitz@redhat.com>
References: <20191127131624.1062403-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: PS18mk0bM1Cb7aGYvCXqMQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Replace child_file by child_of_bds in all remaining places (excluding
tests).

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block.c              |  3 ++-
 block/backup-top.c   |  4 ++--
 block/blklogwrites.c |  3 ++-
 block/blkreplay.c    |  5 +++--
 block/raw-format.c   | 16 ++++++++++++++--
 5 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/block.c b/block.c
index 0530c81c6d..e800ce862e 100644
--- a/block.c
+++ b/block.c
@@ -3182,7 +3182,8 @@ static BlockDriverState *bdrv_open_inherit(const char=
 *filename,
         BlockDriverState *file_bs;
=20
         file_bs =3D bdrv_open_child_bs(filename, options, "file", bs,
-                                     &child_file, 0, true, &local_err);
+                                     &child_of_bds, BDRV_CHILD_IMAGE,
+                                     true, &local_err);
         if (local_err) {
             goto fail;
         }
diff --git a/block/backup-top.c b/block/backup-top.c
index ce97c0146a..eccd6bfae0 100644
--- a/block/backup-top.c
+++ b/block/backup-top.c
@@ -200,8 +200,8 @@ BlockDriverState *bdrv_backup_top_append(BlockDriverSta=
te *source,
     top->opaque =3D state =3D g_new0(BDRVBackupTopState, 1);
=20
     bdrv_ref(target);
-    state->target =3D bdrv_attach_child(top, target, "target", &child_file=
, 0,
-                                      errp);
+    state->target =3D bdrv_attach_child(top, target, "target", &child_of_b=
ds,
+                                      BDRV_CHILD_DATA, errp);
     if (!state->target) {
         bdrv_unref(target);
         bdrv_unref(top);
diff --git a/block/blklogwrites.c b/block/blklogwrites.c
index 78b0c49460..3ee991b38e 100644
--- a/block/blklogwrites.c
+++ b/block/blklogwrites.c
@@ -167,7 +167,8 @@ static int blk_log_writes_open(BlockDriverState *bs, QD=
ict *options, int flags,
     }
=20
     /* Open the log file */
-    s->log_file =3D bdrv_open_child(NULL, options, "log", bs, &child_file,=
 0,
+    s->log_file =3D bdrv_open_child(NULL, options, "log", bs, &child_of_bd=
s,
+                                  BDRV_CHILD_METADATA | BDRV_CHILD_PROTOCO=
L,
                                   false, &local_err);
     if (local_err) {
         ret =3D -EINVAL;
diff --git a/block/blkreplay.c b/block/blkreplay.c
index f97493f45a..71628f4d56 100644
--- a/block/blkreplay.c
+++ b/block/blkreplay.c
@@ -27,8 +27,9 @@ static int blkreplay_open(BlockDriverState *bs, QDict *op=
tions, int flags,
     int ret;
=20
     /* Open the image file */
-    bs->file =3D bdrv_open_child(NULL, options, "image",
-                               bs, &child_file, 0, false, &local_err);
+    bs->file =3D bdrv_open_child(NULL, options, "image", bs, &child_of_bds=
,
+                               BDRV_CHILD_DATA | BDRV_CHILD_PRIMARY,
+                               false, &local_err);
     if (local_err) {
         ret =3D -EINVAL;
         error_propagate(errp, local_err);
diff --git a/block/raw-format.c b/block/raw-format.c
index 4d47e59b7a..6c46dee996 100644
--- a/block/raw-format.c
+++ b/block/raw-format.c
@@ -444,6 +444,7 @@ static int raw_open(BlockDriverState *bs, QDict *option=
s, int flags,
     BDRVRawState *s =3D bs->opaque;
     bool has_size;
     uint64_t offset, size;
+    BdrvChildRole file_role;
     int ret;
=20
     ret =3D raw_read_options(options, &offset, &has_size, &size, errp);
@@ -451,8 +452,19 @@ static int raw_open(BlockDriverState *bs, QDict *optio=
ns, int flags,
         return ret;
     }
=20
-    bs->file =3D bdrv_open_child(NULL, options, "file", bs, &child_file, 0=
,
-                               false, errp);
+    /*
+     * Without offset and a size limit, this driver behaves very much
+     * like a filter.  With any such limit, it does not.
+     */
+    if (offset || has_size) {
+        file_role =3D BDRV_CHILD_DATA | BDRV_CHILD_PROTOCOL | BDRV_CHILD_P=
RIMARY;
+    } else {
+        file_role =3D BDRV_CHILD_FILTERED | BDRV_CHILD_PROTOCOL |
+                    BDRV_CHILD_PRIMARY;
+    }
+
+    bs->file =3D bdrv_open_child(NULL, options, "file", bs, &child_of_bds,
+                               file_role, false, errp);
     if (!bs->file) {
         return -EINVAL;
     }
--=20
2.23.0


