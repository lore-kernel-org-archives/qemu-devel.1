Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45E62C2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 13:01:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12E72217BA
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 13:01:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NELOLgqH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12E72217BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izgmd-0006zm-6w
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 08:01:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57910)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1izgdk-00048Z-JX
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 07:52:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1izgdj-0002GD-Et
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 07:52:16 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46281
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1izgdj-0002Ef-AW
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 07:52:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580993535;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mP+nNpAcdiBs92E8MUmJ6ArcZRiK8Dip4hFYun9uhac=;
 b=NELOLgqHjZf+01KlZEFRzwMXmngPPdpgY7ih1/tLQAPRaaci/VM83IOG3Z1WIFmFEJi5Mh
 kTgsUluKxMGHBArYYAcSj335Bln1Gk2x9/WW3wkQhxwLxD71ZId6tFPTfdHnrJkBPFH6TJ
 nRC3PQqJjaBnFSuqJx029rHgglN41y0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-186-XP2PixYYPNSTmR3nmI14FQ-1; Thu, 06 Feb 2020 07:52:08 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 887981137841;
 Thu,  6 Feb 2020 12:52:07 +0000 (UTC)
Received: from localhost (unknown [10.36.118.15])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2AFFB863A5;
 Thu,  6 Feb 2020 12:52:07 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 16/17] block/backup-top: fix failure path
Date: Thu,  6 Feb 2020 13:51:31 +0100
Message-Id: <20200206125132.594625-17-mreitz@redhat.com>
In-Reply-To: <20200206125132.594625-1-mreitz@redhat.com>
References: <20200206125132.594625-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: XP2PixYYPNSTmR3nmI14FQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

We can't access top after call bdrv_backup_top_drop, as it is already
freed at this time.

Also, no needs to unref target child by hand, it will be unrefed on
bdrv_close() automatically.

So, just do bdrv_backup_top_drop if append succeed and one bdrv_unref
otherwise.

Note, that in !appended case bdrv_unref(top) moved into drained section
on source. It doesn't really matter, but just for code simplicity.

Fixes: 7df7868b96404
Cc: qemu-stable@nongnu.org # v4.2.0
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-id: 20200121142802.21467-2-vsementsov@virtuozzo.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/backup-top.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/block/backup-top.c b/block/backup-top.c
index 9aed2eb4c0..fa78f3256d 100644
--- a/block/backup-top.c
+++ b/block/backup-top.c
@@ -190,6 +190,7 @@ BlockDriverState *bdrv_backup_top_append(BlockDriverSta=
te *source,
     BlockDriverState *top =3D bdrv_new_open_driver(&bdrv_backup_top_filter=
,
                                                  filter_node_name,
                                                  BDRV_O_RDWR, errp);
+    bool appended =3D false;
=20
     if (!top) {
         return NULL;
@@ -212,8 +213,9 @@ BlockDriverState *bdrv_backup_top_append(BlockDriverSta=
te *source,
     bdrv_append(top, source, &local_err);
     if (local_err) {
         error_prepend(&local_err, "Cannot append backup-top filter: ");
-        goto append_failed;
+        goto fail;
     }
+    appended =3D true;
=20
     /*
      * bdrv_append() finished successfully, now we can require permissions
@@ -224,14 +226,14 @@ BlockDriverState *bdrv_backup_top_append(BlockDriverS=
tate *source,
     if (local_err) {
         error_prepend(&local_err,
                       "Cannot set permissions for backup-top filter: ");
-        goto failed_after_append;
+        goto fail;
     }
=20
     state->bcs =3D block_copy_state_new(top->backing, state->target,
                                       cluster_size, write_flags, &local_er=
r);
     if (local_err) {
         error_prepend(&local_err, "Cannot create block-copy-state: ");
-        goto failed_after_append;
+        goto fail;
     }
     *bcs =3D state->bcs;
=20
@@ -239,14 +241,15 @@ BlockDriverState *bdrv_backup_top_append(BlockDriverS=
tate *source,
=20
     return top;
=20
-failed_after_append:
-    state->active =3D false;
-    bdrv_backup_top_drop(top);
+fail:
+    if (appended) {
+        state->active =3D false;
+        bdrv_backup_top_drop(top);
+    } else {
+        bdrv_unref(top);
+    }
=20
-append_failed:
     bdrv_drained_end(source);
-    bdrv_unref_child(top, state->target);
-    bdrv_unref(top);
     error_propagate(errp, local_err);
=20
     return NULL;
--=20
2.24.1


