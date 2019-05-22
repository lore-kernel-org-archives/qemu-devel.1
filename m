Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E43C282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 17:13:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89BB520851
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 17:13:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89BB520851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48058 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTUnV-00019W-QZ
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 13:13:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hTUjr-00076u-9t
	for qemu-devel@nongnu.org; Wed, 22 May 2019 13:09:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hTUjo-0003rQ-Sv
	for qemu-devel@nongnu.org; Wed, 22 May 2019 13:09:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46434)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hTUer-0007Nh-EH; Wed, 22 May 2019 13:04:05 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 01275330260;
	Wed, 22 May 2019 17:04:01 +0000 (UTC)
Received: from localhost (ovpn-204-123.brq.redhat.com [10.40.204.123])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 8DDAF19C4F;
	Wed, 22 May 2019 17:03:58 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Wed, 22 May 2019 19:03:45 +0200
Message-Id: <20190522170352.12020-2-mreitz@redhat.com>
In-Reply-To: <20190522170352.12020-1-mreitz@redhat.com>
References: <20190522170352.12020-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.29]);
	Wed, 22 May 2019 17:04:01 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 1/8] file-posix: Update open_flags in
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
	Max Reitz <mreitz@redhat.com>
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
index d018429672..5a54968183 100644
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
@@ -2783,6 +2784,7 @@ static int raw_check_perm(BlockDriverState *bs, uin=
t64_t perm, uint64_t shared,
         assert(s->reopen_state->shared_perm =3D=3D shared);
         rs =3D s->reopen_state->opaque;
         s->perm_change_fd =3D rs->fd;
+        s->perm_change_flags =3D rs->open_flags;
     } else {
         /* We may need a new fd if auto-read-only switches the mode */
         ret =3D raw_reconfigure_getfd(bs, bs->open_flags, &open_flags, p=
erm,
@@ -2791,6 +2793,7 @@ static int raw_check_perm(BlockDriverState *bs, uin=
t64_t perm, uint64_t shared,
             return ret;
         } else if (ret !=3D s->fd) {
             s->perm_change_fd =3D ret;
+            s->perm_change_flags =3D open_flags;
         }
     }
=20
@@ -2829,6 +2832,7 @@ static void raw_set_perm(BlockDriverState *bs, uint=
64_t perm, uint64_t shared)
     if (s->perm_change_fd && s->fd !=3D s->perm_change_fd) {
         qemu_close(s->fd);
         s->fd =3D s->perm_change_fd;
+        s->open_flags =3D s->perm_change_flags;
     }
     s->perm_change_fd =3D 0;
=20
--=20
2.21.0


