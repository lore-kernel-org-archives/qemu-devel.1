Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCEE5C004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 15:26:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B35E720578
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 15:26:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B35E720578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48576 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hO1yv-00068B-Tz
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 11:26:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hO1rj-000857-Am
	for qemu-devel@nongnu.org; Tue, 07 May 2019 11:18:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hO1ri-000440-E1
	for qemu-devel@nongnu.org; Tue, 07 May 2019 11:18:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50236)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hO1rg-00042E-8P; Tue, 07 May 2019 11:18:44 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8C086C05D3FD;
	Tue,  7 May 2019 15:18:43 +0000 (UTC)
Received: from localhost (unknown [10.40.205.217])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 24E5D3DA5;
	Tue,  7 May 2019 15:18:42 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Tue,  7 May 2019 17:18:17 +0200
Message-Id: <20190507151819.17401-10-mreitz@redhat.com>
In-Reply-To: <20190507151819.17401-1-mreitz@redhat.com>
References: <20190507151819.17401-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.32]);
	Tue, 07 May 2019 15:18:43 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 09/11] block: Assert that drv->bdrv_child_perm
 is set in bdrv_child_perm()
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alberto Garcia <berto@igalia.com>

There is no need to check for this because all block drivers that have
children implement bdrv_child_perm and all callers already ensure that
bs->drv is set.

Furthermore, if this check would fail then the callers would end up
with uninitialized values for nperm and nshared.

This patch replaces the check with an assertion.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Message-id: 20190404112953.4058-1-berto@igalia.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/block.c b/block.c
index 9ae5c0ed2f..7dc8fe289a 100644
--- a/block.c
+++ b/block.c
@@ -1743,11 +1743,10 @@ static void bdrv_child_perm(BlockDriverState *bs,=
 BlockDriverState *child_bs,
                             uint64_t parent_perm, uint64_t parent_shared=
,
                             uint64_t *nperm, uint64_t *nshared)
 {
-    if (bs->drv && bs->drv->bdrv_child_perm) {
-        bs->drv->bdrv_child_perm(bs, c, role, reopen_queue,
-                                 parent_perm, parent_shared,
-                                 nperm, nshared);
-    }
+    assert(bs->drv && bs->drv->bdrv_child_perm);
+    bs->drv->bdrv_child_perm(bs, c, role, reopen_queue,
+                             parent_perm, parent_shared,
+                             nperm, nshared);
     /* TODO Take force_share from reopen_queue */
     if (child_bs && child_bs->force_share) {
         *nshared =3D BLK_PERM_ALL;
--=20
2.20.1


