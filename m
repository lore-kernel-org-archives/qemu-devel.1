Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24DA9C34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 12:58:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E55B42067D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 12:58:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NE4LyeRz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E55B42067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j42S9-0005ZS-5G
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 07:58:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39365)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1j42EE-0005wS-Nv
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 07:43:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1j42ED-0001by-O1
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 07:43:54 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:59543)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1j42ED-0001bl-Ka
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 07:43:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582029833;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5wu4P+OYuoR99HutDLk8Thy7By0AAkzOBY0tAknvND8=;
 b=NE4LyeRzv/zY3Y0D3lhre4VQXnWFcvmGmVFSfAzcn2f4jR3iIeH7PMJnz1YNqzfC+FbLdN
 8/kyTAthnbNONY64v3xsQAVZN5rLb92wN1ObeXFVgHVkFfjRpSQ9zOu/nEX42EQecdgVrD
 MM3KFLWGLXEn+/JSnVlT+mIuKdnoGJ8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-17-VaKNiupOMJSxJ58bSNKtFQ-1; Tue, 18 Feb 2020 07:43:51 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6275B18A5500;
 Tue, 18 Feb 2020 12:43:50 +0000 (UTC)
Received: from localhost (unknown [10.36.118.17])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B847010001AE;
 Tue, 18 Feb 2020 12:43:49 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 20/33] block: Switch child_format users to child_of_bds
Date: Tue, 18 Feb 2020 13:42:29 +0100
Message-Id: <20200218124242.584644-21-mreitz@redhat.com>
In-Reply-To: <20200218124242.584644-1-mreitz@redhat.com>
References: <20200218124242.584644-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: VaKNiupOMJSxJ58bSNKtFQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

Both users (quorum and blkverify) use child_format for
not-really-filtered children, so the appropriate BdrvChildRole in both
cases is DATA.  (Note that this will cause bdrv_inherited_options() to
force-allow format probing.)

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/blkverify.c | 4 ++--
 block/quorum.c    | 6 ++++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/block/blkverify.c b/block/blkverify.c
index ba4f6d7b7c..1684b7aa2e 100644
--- a/block/blkverify.c
+++ b/block/blkverify.c
@@ -134,8 +134,8 @@ static int blkverify_open(BlockDriverState *bs, QDict *=
options, int flags,
=20
     /* Open the test file */
     s->test_file =3D bdrv_open_child(qemu_opt_get(opts, "x-image"), option=
s,
-                                   "test", bs, &child_format, 0, false,
-                                   &local_err);
+                                   "test", bs, &child_of_bds, BDRV_CHILD_D=
ATA,
+                                   false, &local_err);
     if (local_err) {
         ret =3D -EINVAL;
         error_propagate(errp, local_err);
diff --git a/block/quorum.c b/block/quorum.c
index d37b77a522..616ac3a927 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -977,7 +977,8 @@ static int quorum_open(BlockDriverState *bs, QDict *opt=
ions, int flags,
         assert(ret < 32);
=20
         s->children[i] =3D bdrv_open_child(NULL, options, indexstr, bs,
-                                         &child_format, 0, false, &local_e=
rr);
+                                         &child_of_bds, BDRV_CHILD_DATA, f=
alse,
+                                         &local_err);
         if (local_err) {
             ret =3D -EINVAL;
             goto close_exit;
@@ -1053,7 +1054,8 @@ static void quorum_add_child(BlockDriverState *bs, Bl=
ockDriverState *child_bs,
     /* We can safely add the child now */
     bdrv_ref(child_bs);
=20
-    child =3D bdrv_attach_child(bs, child_bs, indexstr, &child_format, 0, =
errp);
+    child =3D bdrv_attach_child(bs, child_bs, indexstr, &child_of_bds,
+                              BDRV_CHILD_DATA, errp);
     if (child =3D=3D NULL) {
         s->next_child_index--;
         goto out;
--=20
2.24.1


