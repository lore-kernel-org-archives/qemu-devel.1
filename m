Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB48C10DCE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 20:33:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75890208D5
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 20:33:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NzR5eIBh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75890208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEfNr-0003Ln-JL
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 16:33:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57444)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1jEfFl-00084v-Sa
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 16:25:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1jEfFk-0004RW-Du
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 16:25:25 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:59165)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1jEfFk-0004QL-94
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 16:25:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584563123;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JHxH1i/K0GH7hBo2Xl83uRZs9D8rNYlhtL+6rGnwWgY=;
 b=NzR5eIBhhUVO4e1O/gBJU1WX8swef5YZQoDqPj7k2gKvmtiuExaXxFfq+qK1iWBYmrhyua
 gD9k1MUZFBDVf17YB5AblvihyT1PsF3MF32DYzDlcfWAJQve/rVN3MCnarCDKUF8lgxYjJ
 2PxRsz7KvHg40RPrQx9dxZQ3xBUzP/w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-e2OcXVAiOXyzoNsG9cgYbA-1; Wed, 18 Mar 2020 16:25:21 -0400
X-MC-Unique: e2OcXVAiOXyzoNsG9cgYbA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 51FBF1857C03;
 Wed, 18 Mar 2020 20:25:19 +0000 (UTC)
Received: from probe.redhat.com (ovpn-112-191.rdu2.redhat.com [10.10.112.191])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 741C360BF1;
 Wed, 18 Mar 2020 20:25:14 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org, jsnow@redhat.com,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL v2 11/11] block/qcow2-bitmap: use bdrv_dirty_bitmap_next_dirty
Date: Wed, 18 Mar 2020 16:23:41 -0400
Message-Id: <20200318202341.6961-12-jsnow@redhat.com>
In-Reply-To: <20200318202341.6961-1-jsnow@redhat.com>
References: <20200318202341.6961-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, libvir-list@redhat.com,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

store_bitmap_data() loop does bdrv_set_dirty_iter() on each iteration,
which means that we actually don't need iterator itself and we can use
simpler bitmap API.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Message-id: 20200205112041.6003-11-vsementsov@virtuozzo.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/qcow2-bitmap.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index 8cccc2c9f3..cb06954b4a 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -1288,7 +1288,6 @@ static uint64_t *store_bitmap_data(BlockDriverState *=
bs,
     uint64_t bm_size =3D bdrv_dirty_bitmap_size(bitmap);
     const char *bm_name =3D bdrv_dirty_bitmap_name(bitmap);
     uint8_t *buf =3D NULL;
-    BdrvDirtyBitmapIter *dbi;
     uint64_t *tb;
     uint64_t tb_size =3D
             size_to_clusters(s,
@@ -1307,12 +1306,14 @@ static uint64_t *store_bitmap_data(BlockDriverState=
 *bs,
         return NULL;
     }
=20
-    dbi =3D bdrv_dirty_iter_new(bitmap);
     buf =3D g_malloc(s->cluster_size);
     limit =3D bytes_covered_by_bitmap_cluster(s, bitmap);
     assert(DIV_ROUND_UP(bm_size, limit) =3D=3D tb_size);
=20
-    while ((offset =3D bdrv_dirty_iter_next(dbi)) >=3D 0) {
+    offset =3D 0;
+    while ((offset =3D bdrv_dirty_bitmap_next_dirty(bitmap, offset, INT64_=
MAX))
+           >=3D 0)
+    {
         uint64_t cluster =3D offset / limit;
         uint64_t end, write_size;
         int64_t off;
@@ -1355,23 +1356,17 @@ static uint64_t *store_bitmap_data(BlockDriverState=
 *bs,
             goto fail;
         }
=20
-        if (end >=3D bm_size) {
-            break;
-        }
-
-        bdrv_set_dirty_iter(dbi, end);
+        offset =3D end;
     }
=20
     *bitmap_table_size =3D tb_size;
     g_free(buf);
-    bdrv_dirty_iter_free(dbi);
=20
     return tb;
=20
 fail:
     clear_bitmap_table(bs, tb, tb_size);
     g_free(buf);
-    bdrv_dirty_iter_free(dbi);
     g_free(tb);
=20
     return NULL;
--=20
2.21.1


