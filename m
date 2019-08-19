Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA93C3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 19:01:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A11D4214DA
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 19:01:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A11D4214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzmue-0008N5-FK
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 15:01:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32829)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1hzmpg-0002JV-5q
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 14:56:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hzmpf-0002Bg-4X
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 14:56:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56816)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hzmpc-00029i-Ni; Mon, 19 Aug 2019 14:56:40 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F3D16A38184;
 Mon, 19 Aug 2019 18:56:39 +0000 (UTC)
Received: from localhost (ovpn-204-64.brq.redhat.com [10.40.204.64])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 897B111766B;
 Mon, 19 Aug 2019 18:56:39 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Mon, 19 Aug 2019 20:55:57 +0200
Message-Id: <20190819185602.4267-12-mreitz@redhat.com>
In-Reply-To: <20190819185602.4267-1-mreitz@redhat.com>
References: <20190819185602.4267-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.68]); Mon, 19 Aug 2019 18:56:40 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 11/16] qcow2: Keep track of the snapshot
 table length
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

When repairing the snapshot table, we truncate entries that have too
much extra data.  This frees up space that we do not have to count
towards the snapshot table size.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2-snapshot.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/block/qcow2-snapshot.c b/block/qcow2-snapshot.c
index 53dc1635ec..582eb3386a 100644
--- a/block/qcow2-snapshot.c
+++ b/block/qcow2-snapshot.c
@@ -68,6 +68,7 @@ static int qcow2_do_read_snapshots(BlockDriverState *bs=
, bool repair,
     QCowSnapshot *sn;
     int i, id_str_size, name_size;
     int64_t offset;
+    uint64_t table_length =3D 0;
     int ret;
=20
     if (!s->nb_snapshots) {
@@ -82,6 +83,8 @@ static int qcow2_do_read_snapshots(BlockDriverState *bs=
, bool repair,
     for(i =3D 0; i < s->nb_snapshots; i++) {
         bool truncate_unknown_extra_data =3D false;
=20
+        table_length =3D ROUND_UP(table_length, 8);
+
         /* Read statically sized part of the snapshot header */
         offset =3D ROUND_UP(offset, 8);
         ret =3D bdrv_pread(bs->file, offset, &h, sizeof(h));
@@ -184,7 +187,16 @@ static int qcow2_do_read_snapshots(BlockDriverState =
*bs, bool repair,
         offset +=3D name_size;
         sn->name[name_size] =3D '\0';
=20
-        if (offset - s->snapshots_offset > QCOW_MAX_SNAPSHOTS_SIZE) {
+        /* Note that the extra data may have been truncated */
+        table_length +=3D sizeof(h) + sn->extra_data_size + id_str_size =
+
+                        name_size;
+        if (!repair) {
+            assert(table_length =3D=3D offset - s->snapshots_offset);
+        }
+
+        if (table_length > QCOW_MAX_SNAPSHOTS_SIZE ||
+            offset - s->snapshots_offset > INT_MAX)
+        {
             ret =3D -EFBIG;
             error_setg(errp, "Snapshot table is too big");
             goto fail;
--=20
2.21.0


