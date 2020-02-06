Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C462CC2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 13:09:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87822214AF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 13:09:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VE2+DM13"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87822214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izgur-0006VH-KJ
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 08:09:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57694)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1izgdZ-0003d6-P3
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 07:52:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1izgdY-0001Y7-Ap
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 07:52:05 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41658
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1izgdY-0001WB-5o
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 07:52:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580993523;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I7J+RMMFdUQ6Uwh3RwaZNC8bnjHBvOR7LBoAUsefCtU=;
 b=VE2+DM13IQcgo8yw/fCS5wX/YiFcSE79RLzhrztG52ZAXtDZ2oZ4PSdTNnk0ZqscZAiz7n
 Rcjy3/Ni3kQ4dZwAk2otChpvMBVrbBLo+Q/RvqnaZ/uCq0FyLFSfHeD9ogMt0wOgfviIg7
 7WIUrc2h1eyxHcDDzVgGFpU4QpCnfSM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-375-NQj01UV3ODCuiIPC_Ivq3Q-1; Thu, 06 Feb 2020 07:51:58 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2B92B1800D42;
 Thu,  6 Feb 2020 12:51:57 +0000 (UTC)
Received: from localhost (unknown [10.36.118.15])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C4A108E5F8;
 Thu,  6 Feb 2020 12:51:56 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 11/17] qcow2: Don't round the L1 table allocation up to the
 sector size
Date: Thu,  6 Feb 2020 13:51:26 +0100
Message-Id: <20200206125132.594625-12-mreitz@redhat.com>
In-Reply-To: <20200206125132.594625-1-mreitz@redhat.com>
References: <20200206125132.594625-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: NQj01UV3ODCuiIPC_Ivq3Q-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alberto Garcia <berto@igalia.com>

The L1 table is read from disk using the byte-based bdrv_pread() and
is never accessed beyond its last element, so there's no need to
allocate more memory than that.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-id: b2e27214ec7b03a585931bcf383ee1ac3a641a10.1579374329.git.berto@i=
galia.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2-cluster.c  | 5 ++---
 block/qcow2-refcount.c | 2 +-
 block/qcow2-snapshot.c | 3 +--
 block/qcow2.c          | 2 +-
 4 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index e9431f6785..0384fb2339 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -124,12 +124,11 @@ int qcow2_grow_l1_table(BlockDriverState *bs, uint64_=
t min_size,
 #endif
=20
     new_l1_size2 =3D sizeof(uint64_t) * new_l1_size;
-    new_l1_table =3D qemu_try_blockalign(bs->file->bs,
-                                       ROUND_UP(new_l1_size2, 512));
+    new_l1_table =3D qemu_try_blockalign(bs->file->bs, new_l1_size2);
     if (new_l1_table =3D=3D NULL) {
         return -ENOMEM;
     }
-    memset(new_l1_table, 0, ROUND_UP(new_l1_size2, 512));
+    memset(new_l1_table, 0, new_l1_size2);
=20
     if (s->l1_size) {
         memcpy(new_l1_table, s->l1_table, s->l1_size * sizeof(uint64_t));
diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index f67ac6b2d8..c963bc8de1 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -1262,7 +1262,7 @@ int qcow2_update_snapshot_refcount(BlockDriverState *=
bs,
      * l1_table_offset when it is the current s->l1_table_offset! Be caref=
ul
      * when changing this! */
     if (l1_table_offset !=3D s->l1_table_offset) {
-        l1_table =3D g_try_malloc0(ROUND_UP(l1_size2, 512));
+        l1_table =3D g_try_malloc0(l1_size2);
         if (l1_size2 && l1_table =3D=3D NULL) {
             ret =3D -ENOMEM;
             goto fail;
diff --git a/block/qcow2-snapshot.c b/block/qcow2-snapshot.c
index 5ab64da1ec..82c32d4c9b 100644
--- a/block/qcow2-snapshot.c
+++ b/block/qcow2-snapshot.c
@@ -1024,8 +1024,7 @@ int qcow2_snapshot_load_tmp(BlockDriverState *bs,
         return ret;
     }
     new_l1_bytes =3D sn->l1_size * sizeof(uint64_t);
-    new_l1_table =3D qemu_try_blockalign(bs->file->bs,
-                                       ROUND_UP(new_l1_bytes, 512));
+    new_l1_table =3D qemu_try_blockalign(bs->file->bs, new_l1_bytes);
     if (new_l1_table =3D=3D NULL) {
         return -ENOMEM;
     }
diff --git a/block/qcow2.c b/block/qcow2.c
index e29fc07068..83db013814 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1491,7 +1491,7 @@ static int coroutine_fn qcow2_do_open(BlockDriverStat=
e *bs, QDict *options,
=20
     if (s->l1_size > 0) {
         s->l1_table =3D qemu_try_blockalign(bs->file->bs,
-            ROUND_UP(s->l1_size * sizeof(uint64_t), 512));
+                                          s->l1_size * sizeof(uint64_t));
         if (s->l1_table =3D=3D NULL) {
             error_setg(errp, "Could not allocate L1 table");
             ret =3D -ENOMEM;
--=20
2.24.1


