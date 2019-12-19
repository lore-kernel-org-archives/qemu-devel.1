Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13100C2D0D1
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 17:42:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6F32222C2
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 17:42:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P5RVGWNu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6F32222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihzov-0001iB-Rc
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 12:42:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45654)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1ihzY5-0006c6-BM
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 12:25:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1ihzY3-00076c-AP
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 12:25:16 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:21819
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1ihzY2-00073b-UF
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 12:25:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576776314;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NUTCLFW3Yth22AoaoD0n40NJcS3KSifraPDy20bZCjo=;
 b=P5RVGWNumwKBbq4xmZC9Im50KEr0kHDrQAfrnVBcCdTOuL7CqJ4LPvoDs4GgZtw2CrpX11
 35FgpzjA/T8Ybu1LNPlV8WmsvbuOwz0autxpsrvWN4aIVkag9cBXAuLazBYUOMpkm0Fgpb
 V/SSuTl2YZDIl/qdSnSeAljtPCTopvg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-bwOZaFOwMoKru7AMvRhkVA-1; Thu, 19 Dec 2019 12:25:07 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2A3C410054E3;
 Thu, 19 Dec 2019 17:25:06 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-117-53.ams2.redhat.com [10.36.117.53])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F346D63B8A;
 Thu, 19 Dec 2019 17:25:03 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 12/30] qcow2: Use offset_into_cluster()
Date: Thu, 19 Dec 2019 18:24:23 +0100
Message-Id: <20191219172441.7289-13-kwolf@redhat.com>
In-Reply-To: <20191219172441.7289-1-kwolf@redhat.com>
References: <20191219172441.7289-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: bwOZaFOwMoKru7AMvRhkVA-1
X-Mimecast-Spam-Score: 0
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alberto Garcia <berto@igalia.com>

There's a couple of places left in the qcow2 code that still do the
calculation manually, so let's replace them.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow2.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index de0e89cf25..375bbd0ad3 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -367,7 +367,7 @@ static int qcow2_read_extensions(BlockDriverState *bs, =
uint64_t start_offset,
                 return -EINVAL;
             }
=20
-            if (bitmaps_ext.bitmap_directory_offset & (s->cluster_size - 1=
)) {
+            if (offset_into_cluster(s, bitmaps_ext.bitmap_directory_offset=
)) {
                 error_setg(errp, "bitmaps_ext: "
                                  "invalid bitmap directory offset");
                 return -EINVAL;
@@ -1959,9 +1959,8 @@ static int coroutine_fn qcow2_co_block_status(BlockDr=
iverState *bs,
 {
     BDRVQcow2State *s =3D bs->opaque;
     uint64_t cluster_offset;
-    int index_in_cluster, ret;
     unsigned int bytes;
-    int status =3D 0;
+    int ret, status =3D 0;
=20
     qemu_co_mutex_lock(&s->lock);
=20
@@ -1982,8 +1981,7 @@ static int coroutine_fn qcow2_co_block_status(BlockDr=
iverState *bs,
=20
     if ((ret =3D=3D QCOW2_CLUSTER_NORMAL || ret =3D=3D QCOW2_CLUSTER_ZERO_=
ALLOC) &&
         !s->crypto) {
-        index_in_cluster =3D offset & (s->cluster_size - 1);
-        *map =3D cluster_offset | index_in_cluster;
+        *map =3D cluster_offset | offset_into_cluster(s, offset);
         *file =3D s->data_file->bs;
         status |=3D BDRV_BLOCK_OFFSET_VALID;
     }
--=20
2.20.1


