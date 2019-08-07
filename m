Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A648C32751
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 14:49:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F0FA2199C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 14:49:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F0FA2199C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvNG0-0008MS-Nn
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 10:49:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44097)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hvNDC-0004Vs-GR
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 10:46:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hvNDB-0005Qq-FA
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 10:46:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45664)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hvND8-0005Np-SI; Wed, 07 Aug 2019 10:46:43 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2DBD5309321C;
 Wed,  7 Aug 2019 14:46:42 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-117-121.ams2.redhat.com
 [10.36.117.121])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 76FC85D717;
 Wed,  7 Aug 2019 14:46:40 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Wed,  7 Aug 2019 16:46:27 +0200
Message-Id: <20190807144628.4988-3-kwolf@redhat.com>
In-Reply-To: <20190807144628.4988-1-kwolf@redhat.com>
References: <20190807144628.4988-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Wed, 07 Aug 2019 14:46:42 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 2/3] mirror: Keep mirror_top_bs drained
 after dropping permissions
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, den@virtuozzo.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, dplotnikov@virtuozzo.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

mirror_top_bs is currently implicitly drained through its connection to
the source or the target node. However, the drain section for target_bs
ends early after moving mirror_top_bs from src to target_bs, so that
requests can already be restarted while mirror_top_bs is still present
in the chain, but has dropped all permissions and therefore runs into an
assertion failure like this:

    qemu-system-x86_64: block/io.c:1634: bdrv_co_write_req_prepare:
    Assertion `child->perm & BLK_PERM_WRITE' failed.

Keep mirror_top_bs drained until all graph changes have completed.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/mirror.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/block/mirror.c b/block/mirror.c
index 9f5c59ece1..642d6570cc 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -656,7 +656,10 @@ static int mirror_exit_common(Job *job)
     s->target =3D NULL;
=20
     /* We don't access the source any more. Dropping any WRITE/RESIZE is
-     * required before it could become a backing file of target_bs. */
+     * required before it could become a backing file of target_bs. Not =
having
+     * these permissions any more means that we can't allow any new requ=
ests on
+     * mirror_top_bs from now on, so keep it drained. */
+    bdrv_drained_begin(mirror_top_bs);
     bs_opaque->stop =3D true;
     bdrv_child_refresh_perms(mirror_top_bs, mirror_top_bs->backing,
                              &error_abort);
@@ -724,6 +727,7 @@ static int mirror_exit_common(Job *job)
     bs_opaque->job =3D NULL;
=20
     bdrv_drained_end(src);
+    bdrv_drained_end(mirror_top_bs);
     s->in_drain =3D false;
     bdrv_unref(mirror_top_bs);
     bdrv_unref(src);
--=20
2.20.1


