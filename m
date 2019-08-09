Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F73C433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 16:20:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42C37214C6
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 16:20:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42C37214C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60893 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw7cc-0004yn-IG
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 12:20:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57290)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hw7Xh-0002Gx-D8
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 12:15:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hw7Xg-0004IK-Bv
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 12:15:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58998)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hw7Xe-0004Gq-8N; Fri, 09 Aug 2019 12:14:58 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 91657309E5B4;
 Fri,  9 Aug 2019 16:14:57 +0000 (UTC)
Received: from localhost (unknown [10.40.205.179])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2D7CC608C2;
 Fri,  9 Aug 2019 16:14:57 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Fri,  9 Aug 2019 18:13:46 +0200
Message-Id: <20190809161407.11920-22-mreitz@redhat.com>
In-Reply-To: <20190809161407.11920-1-mreitz@redhat.com>
References: <20190809161407.11920-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Fri, 09 Aug 2019 16:14:57 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v6 21/42] block: Use CAFs for debug breakpoints
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When looking for a blkdebug node (which implements debug breakpoints),
use bdrv_primary_bs() to iterate through the graph, because that is
where a blkdebug node would be.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/block.c b/block.c
index a467b175c6..1070aa1ba9 100644
--- a/block.c
+++ b/block.c
@@ -5218,7 +5218,7 @@ int bdrv_debug_breakpoint(BlockDriverState *bs, con=
st char *event,
                           const char *tag)
 {
     while (bs && bs->drv && !bs->drv->bdrv_debug_breakpoint) {
-        bs =3D bs->file ? bs->file->bs : NULL;
+        bs =3D bdrv_primary_bs(bs);
     }
=20
     if (bs && bs->drv && bs->drv->bdrv_debug_breakpoint) {
@@ -5231,7 +5231,7 @@ int bdrv_debug_breakpoint(BlockDriverState *bs, con=
st char *event,
 int bdrv_debug_remove_breakpoint(BlockDriverState *bs, const char *tag)
 {
     while (bs && bs->drv && !bs->drv->bdrv_debug_remove_breakpoint) {
-        bs =3D bs->file ? bs->file->bs : NULL;
+        bs =3D bdrv_primary_bs(bs);
     }
=20
     if (bs && bs->drv && bs->drv->bdrv_debug_remove_breakpoint) {
@@ -5244,7 +5244,7 @@ int bdrv_debug_remove_breakpoint(BlockDriverState *=
bs, const char *tag)
 int bdrv_debug_resume(BlockDriverState *bs, const char *tag)
 {
     while (bs && (!bs->drv || !bs->drv->bdrv_debug_resume)) {
-        bs =3D bs->file ? bs->file->bs : NULL;
+        bs =3D bdrv_primary_bs(bs);
     }
=20
     if (bs && bs->drv && bs->drv->bdrv_debug_resume) {
@@ -5257,7 +5257,7 @@ int bdrv_debug_resume(BlockDriverState *bs, const c=
har *tag)
 bool bdrv_debug_is_suspended(BlockDriverState *bs, const char *tag)
 {
     while (bs && bs->drv && !bs->drv->bdrv_debug_is_suspended) {
-        bs =3D bs->file ? bs->file->bs : NULL;
+        bs =3D bdrv_primary_bs(bs);
     }
=20
     if (bs && bs->drv && bs->drv->bdrv_debug_is_suspended) {
--=20
2.21.0


