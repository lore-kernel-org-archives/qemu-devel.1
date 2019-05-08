Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4882C04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 18:27:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 975AB216C4
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 18:27:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 975AB216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41456 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hORIA-00061d-TV
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 14:27:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hORGQ-0004N5-8z
	for qemu-devel@nongnu.org; Wed, 08 May 2019 14:25:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hORGP-0002yg-9A
	for qemu-devel@nongnu.org; Wed, 08 May 2019 14:25:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:31579)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hORGM-0002sR-J2; Wed, 08 May 2019 14:25:54 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D5D46301EA90;
	Wed,  8 May 2019 18:25:53 +0000 (UTC)
Received: from localhost (ovpn-204-94.brq.redhat.com [10.40.204.94])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 6283362672;
	Wed,  8 May 2019 18:25:53 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Wed,  8 May 2019 20:25:40 +0200
Message-Id: <20190508182546.2239-2-mreitz@redhat.com>
In-Reply-To: <20190508182546.2239-1-mreitz@redhat.com>
References: <20190508182546.2239-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.47]);
	Wed, 08 May 2019 18:25:53 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 1/7] file-posix: Update open_flags in
 raw_set_perm()
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
	qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

raw_check_perm() + raw_set_perm() can change the flags associated with
the current FD.  If so, we have to update BDRVRawState.open_flags
accordingly.  Otherwise, we may keep reopening the FD even though the
current one already has the correct flags.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
---
 block/file-posix.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/file-posix.c b/block/file-posix.c
index 1cf4ee49eb..3e859c4b9f 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -145,6 +145,7 @@ typedef struct BDRVRawState {
     uint64_t locked_shared_perm;
=20
     int perm_change_fd;
+    int perm_change_flags;
     BDRVReopenState *reopen_state;
=20
 #ifdef CONFIG_XFS
@@ -2754,6 +2755,7 @@ static int raw_check_perm(BlockDriverState *bs, uin=
t64_t perm, uint64_t shared,
         assert(s->reopen_state->shared_perm =3D=3D shared);
         rs =3D s->reopen_state->opaque;
         s->perm_change_fd =3D rs->fd;
+        s->perm_change_flags =3D rs->open_flags;
     } else {
         /* We may need a new fd if auto-read-only switches the mode */
         ret =3D raw_reconfigure_getfd(bs, bs->open_flags, &open_flags, p=
erm,
@@ -2762,6 +2764,7 @@ static int raw_check_perm(BlockDriverState *bs, uin=
t64_t perm, uint64_t shared,
             return ret;
         } else if (ret !=3D s->fd) {
             s->perm_change_fd =3D ret;
+            s->perm_change_flags =3D open_flags;
         }
     }
=20
@@ -2800,6 +2803,7 @@ static void raw_set_perm(BlockDriverState *bs, uint=
64_t perm, uint64_t shared)
     if (s->perm_change_fd && s->fd !=3D s->perm_change_fd) {
         qemu_close(s->fd);
         s->fd =3D s->perm_change_fd;
+        s->open_flags =3D s->perm_change_flags;
     }
     s->perm_change_fd =3D 0;
=20
--=20
2.20.1


