Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 160E4C0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 17:30:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E13FB21882
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 17:30:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E13FB21882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hij5c-0000z6-27
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 13:30:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48821)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hij3o-0007SA-VR
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 13:28:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hij3n-0008JI-UA
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 13:28:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49794)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hij3g-0007ut-Ma; Wed, 03 Jul 2019 13:28:41 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CFE0286671;
 Wed,  3 Jul 2019 17:28:24 +0000 (UTC)
Received: from localhost (ovpn-204-65.brq.redhat.com [10.40.204.65])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 69E6D19698;
 Wed,  3 Jul 2019 17:28:24 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Wed,  3 Jul 2019 19:28:05 +0200
Message-Id: <20190703172813.6868-5-mreitz@redhat.com>
In-Reply-To: <20190703172813.6868-1-mreitz@redhat.com>
References: <20190703172813.6868-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Wed, 03 Jul 2019 17:28:24 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 04/12] block: Keep subtree drained in
 drop_intermediate
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

bdrv_drop_intermediate() calls BdrvChildRole.update_filename().  That
may poll, thus changing the graph, which potentially breaks the
QLIST_FOREACH_SAFE() loop.

Just keep the whole subtree drained.  This is probably the right thing
to do anyway (dropping nodes while the subtree is not drained seems
wrong).

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block.c b/block.c
index a06f07347f..96b3dc7d53 100644
--- a/block.c
+++ b/block.c
@@ -4493,6 +4493,7 @@ int bdrv_drop_intermediate(BlockDriverState *top, B=
lockDriverState *base,
     int ret =3D -EIO;
=20
     bdrv_ref(top);
+    bdrv_subtree_drained_begin(top);
=20
     if (!top->drv || !base->drv) {
         goto exit;
@@ -4564,6 +4565,7 @@ int bdrv_drop_intermediate(BlockDriverState *top, B=
lockDriverState *base,
=20
     ret =3D 0;
 exit:
+    bdrv_subtree_drained_end(top);
     bdrv_unref(top);
     return ret;
 }
--=20
2.21.0


