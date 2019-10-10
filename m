Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2005C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 12:35:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C59FF20659
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 12:35:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C59FF20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIXff-0000Me-HE
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 08:35:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52370)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iIWrq-0007RJ-Tc
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:44:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iIWro-0008V7-LM
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:44:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42956)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iIWrj-0008Sb-Ao; Thu, 10 Oct 2019 07:44:19 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E0483C049E17;
 Thu, 10 Oct 2019 11:44:17 +0000 (UTC)
Received: from localhost (unknown [10.36.118.5])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8511A5DA2C;
 Thu, 10 Oct 2019 11:44:17 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 34/36] nbd: add empty .bdrv_reopen_prepare
Date: Thu, 10 Oct 2019 13:42:58 +0200
Message-Id: <20191010114300.7746-35-mreitz@redhat.com>
In-Reply-To: <20191010114300.7746-1-mreitz@redhat.com>
References: <20191010114300.7746-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Thu, 10 Oct 2019 11:44:17 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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

From: Maxim Levitsky <mlevitsk@redhat.com>

Fixes commit job / qemu-img commit, when
commiting qcow2 file which is based on nbd export.

Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=3D1718727
Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
Message-id: 20190930213820.29777-2-mlevitsk@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/nbd.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/block/nbd.c b/block/nbd.c
index 813c40d8f0..fd78e5f330 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -1158,6 +1158,18 @@ static int coroutine_fn nbd_client_co_block_status=
(
         BDRV_BLOCK_OFFSET_VALID;
 }
=20
+static int nbd_client_reopen_prepare(BDRVReopenState *state,
+                                     BlockReopenQueue *queue, Error **er=
rp)
+{
+    BDRVNBDState *s =3D (BDRVNBDState *)state->bs->opaque;
+
+    if ((state->flags & BDRV_O_RDWR) && (s->info.flags & NBD_FLAG_READ_O=
NLY)) {
+        error_setg(errp, "Can't reopen read-only NBD mount as read/write=
");
+        return -EACCES;
+    }
+    return 0;
+}
+
 static void nbd_client_close(BlockDriverState *bs)
 {
     BDRVNBDState *s =3D (BDRVNBDState *)bs->opaque;
@@ -1798,6 +1810,7 @@ static BlockDriver bdrv_nbd =3D {
     .instance_size              =3D sizeof(BDRVNBDState),
     .bdrv_parse_filename        =3D nbd_parse_filename,
     .bdrv_file_open             =3D nbd_open,
+    .bdrv_reopen_prepare        =3D nbd_client_reopen_prepare,
     .bdrv_co_preadv             =3D nbd_client_co_preadv,
     .bdrv_co_pwritev            =3D nbd_client_co_pwritev,
     .bdrv_co_pwrite_zeroes      =3D nbd_client_co_pwrite_zeroes,
@@ -1820,6 +1833,7 @@ static BlockDriver bdrv_nbd_tcp =3D {
     .instance_size              =3D sizeof(BDRVNBDState),
     .bdrv_parse_filename        =3D nbd_parse_filename,
     .bdrv_file_open             =3D nbd_open,
+    .bdrv_reopen_prepare        =3D nbd_client_reopen_prepare,
     .bdrv_co_preadv             =3D nbd_client_co_preadv,
     .bdrv_co_pwritev            =3D nbd_client_co_pwritev,
     .bdrv_co_pwrite_zeroes      =3D nbd_client_co_pwrite_zeroes,
@@ -1842,6 +1856,7 @@ static BlockDriver bdrv_nbd_unix =3D {
     .instance_size              =3D sizeof(BDRVNBDState),
     .bdrv_parse_filename        =3D nbd_parse_filename,
     .bdrv_file_open             =3D nbd_open,
+    .bdrv_reopen_prepare        =3D nbd_client_reopen_prepare,
     .bdrv_co_preadv             =3D nbd_client_co_preadv,
     .bdrv_co_pwritev            =3D nbd_client_co_pwritev,
     .bdrv_co_pwrite_zeroes      =3D nbd_client_co_pwrite_zeroes,
--=20
2.21.0


