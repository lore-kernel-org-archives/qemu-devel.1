Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7073CC43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 16:12:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 427D720835
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 16:12:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 427D720835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49260 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLVMw-00074Y-CT
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 12:12:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hLUuw-00088z-3e
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:43:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hLUuu-0002Ay-H8
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:43:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49848)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hLUup-00025q-Pe; Tue, 30 Apr 2019 11:43:32 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D547A2D800;
	Tue, 30 Apr 2019 15:43:30 +0000 (UTC)
Received: from linux.fritz.box.com (unknown [10.36.118.15])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E24F44D5;
	Tue, 30 Apr 2019 15:43:29 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Tue, 30 Apr 2019 17:42:36 +0200
Message-Id: <20190430154244.30083-20-kwolf@redhat.com>
In-Reply-To: <20190430154244.30083-1-kwolf@redhat.com>
References: <20190430154244.30083-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.30]);
	Tue, 30 Apr 2019 15:43:30 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 19/27] block/qed: use buffer-based io
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
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190430154236.b6omBbokDOSNWUVkNGMQiZt8KlH8GunME745Wi3nyqI@z>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Move to _co_ versions of io functions qed_read_table() and
qed_write_table(), as we use qemu_co_mutex_unlock()
anyway.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qed-table.c | 12 +++++-------
 block/qed.c       |  6 ++----
 2 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/block/qed-table.c b/block/qed-table.c
index c497bd4aec..cf30edd977 100644
--- a/block/qed-table.c
+++ b/block/qed-table.c
@@ -21,22 +21,22 @@
 /* Called with table_lock held.  */
 static int qed_read_table(BDRVQEDState *s, uint64_t offset, QEDTable *ta=
ble)
 {
-    QEMUIOVector qiov =3D QEMU_IOVEC_INIT_BUF(
-        qiov, table->offsets, s->header.cluster_size * s->header.table_s=
ize);
+    unsigned int bytes =3D s->header.cluster_size * s->header.table_size=
;
+
     int noffsets;
     int i, ret;
=20
     trace_qed_read_table(s, offset, table);
=20
     qemu_co_mutex_unlock(&s->table_lock);
-    ret =3D bdrv_preadv(s->bs->file, offset, &qiov);
+    ret =3D bdrv_co_pread(s->bs->file, offset, bytes, table->offsets, 0)=
;
     qemu_co_mutex_lock(&s->table_lock);
     if (ret < 0) {
         goto out;
     }
=20
     /* Byteswap offsets */
-    noffsets =3D qiov.size / sizeof(uint64_t);
+    noffsets =3D bytes / sizeof(uint64_t);
     for (i =3D 0; i < noffsets; i++) {
         table->offsets[i] =3D le64_to_cpu(table->offsets[i]);
     }
@@ -66,7 +66,6 @@ static int qed_write_table(BDRVQEDState *s, uint64_t of=
fset, QEDTable *table,
     unsigned int sector_mask =3D BDRV_SECTOR_SIZE / sizeof(uint64_t) - 1=
;
     unsigned int start, end, i;
     QEDTable *new_table;
-    QEMUIOVector qiov;
     size_t len_bytes;
     int ret;
=20
@@ -79,7 +78,6 @@ static int qed_write_table(BDRVQEDState *s, uint64_t of=
fset, QEDTable *table,
     len_bytes =3D (end - start) * sizeof(uint64_t);
=20
     new_table =3D qemu_blockalign(s->bs, len_bytes);
-    qemu_iovec_init_buf(&qiov, new_table->offsets, len_bytes);
=20
     /* Byteswap table */
     for (i =3D start; i < end; i++) {
@@ -91,7 +89,7 @@ static int qed_write_table(BDRVQEDState *s, uint64_t of=
fset, QEDTable *table,
     offset +=3D start * sizeof(uint64_t);
=20
     qemu_co_mutex_unlock(&s->table_lock);
-    ret =3D bdrv_pwritev(s->bs->file, offset, &qiov);
+    ret =3D bdrv_co_pwrite(s->bs->file, offset, len_bytes, new_table->of=
fsets, 0);
     qemu_co_mutex_lock(&s->table_lock);
     trace_qed_write_table_cb(s, table, flush, ret);
     if (ret < 0) {
diff --git a/block/qed.c b/block/qed.c
index 89af05d524..912edaf56a 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -113,15 +113,13 @@ static int coroutine_fn qed_write_header(BDRVQEDSta=
te *s)
     int nsectors =3D DIV_ROUND_UP(sizeof(QEDHeader), BDRV_SECTOR_SIZE);
     size_t len =3D nsectors * BDRV_SECTOR_SIZE;
     uint8_t *buf;
-    QEMUIOVector qiov;
     int ret;
=20
     assert(s->allocating_acb || s->allocating_write_reqs_plugged);
=20
     buf =3D qemu_blockalign(s->bs, len);
-    qemu_iovec_init_buf(&qiov, buf, len);
=20
-    ret =3D bdrv_co_preadv(s->bs->file, 0, qiov.size, &qiov, 0);
+    ret =3D bdrv_co_pread(s->bs->file, 0, len, buf, 0);
     if (ret < 0) {
         goto out;
     }
@@ -129,7 +127,7 @@ static int coroutine_fn qed_write_header(BDRVQEDState=
 *s)
     /* Update header */
     qed_header_cpu_to_le(&s->header, (QEDHeader *) buf);
=20
-    ret =3D bdrv_co_pwritev(s->bs->file, 0, qiov.size,  &qiov, 0);
+    ret =3D bdrv_co_pwrite(s->bs->file, 0, len,  buf, 0);
     if (ret < 0) {
         goto out;
     }
--=20
2.20.1


