Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEFCFC10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 04:42:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B959206EC
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 04:42:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E3NzlhTc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B959206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE43g-0006pe-PW
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 00:42:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52143)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1jE40I-00016x-Ji
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 00:38:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1jE40H-0000Q0-9p
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 00:38:58 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:33138)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1jE40H-0000Ni-5b
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 00:38:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584419936;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7S4pvEvRq43tAOJ+VoWTNYoKkV9GHiGO1EgDeCec5QM=;
 b=E3NzlhTcUsN6PEIlkCfUM5EPpoAxCHen84PW92j2wsNoHlQDMV/T/O/6fSNKvYEerkrQ/w
 ZoyPw5E8aM5t7L7xXNWnBf/Rn67BR9qn2FWkNPr5Gk9BtEPYFzLM4AepR2dDfEiUuxCUnO
 teqxZ067Hx0RMB5XfuGOT5M4hIRDl/8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-127-lNV5h5bYONCQ9h5D63ffdg-1; Tue, 17 Mar 2020 00:38:54 -0400
X-MC-Unique: lNV5h5bYONCQ9h5D63ffdg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6E8751005516;
 Tue, 17 Mar 2020 04:38:53 +0000 (UTC)
Received: from probe.redhat.com (ovpn-112-191.rdu2.redhat.com [10.10.112.191])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6D7CD1009ABB;
 Tue, 17 Mar 2020 04:38:51 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 jsnow@redhat.com
Subject: [PULL 09/10] nbd/server: use bdrv_dirty_bitmap_next_dirty_area
Date: Tue, 17 Mar 2020 00:38:18 -0400
Message-Id: <20200317043819.20197-10-jsnow@redhat.com>
In-Reply-To: <20200317043819.20197-1-jsnow@redhat.com>
References: <20200317043819.20197-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Use bdrv_dirty_bitmap_next_dirty_area for bitmap_to_extents. Since
bdrv_dirty_bitmap_next_dirty_area is very accurate in its interface,
we'll never exceed requested region with last chunk. So, we don't need
dont_fragment, and bitmap_to_extents() interface becomes clean enough
to not require any comment.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-id: 20200205112041.6003-10-vsementsov@virtuozzo.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 nbd/server.c | 59 +++++++++++++++++-----------------------------------
 1 file changed, 19 insertions(+), 40 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index f90bb33a75..02b1ed0801 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -2068,57 +2068,36 @@ static int nbd_co_send_block_status(NBDClient *clie=
nt, uint64_t handle,
     return nbd_co_send_extents(client, handle, ea, last, context_id, errp)=
;
 }
=20
-/*
- * Populate @ea from a dirty bitmap. Unless @dont_fragment, the
- * final extent may exceed the original @length.
- */
+/* Populate @ea from a dirty bitmap. */
 static void bitmap_to_extents(BdrvDirtyBitmap *bitmap,
                               uint64_t offset, uint64_t length,
-                              NBDExtentArray *ea, bool dont_fragment)
+                              NBDExtentArray *es)
 {
-    uint64_t begin =3D offset, end =3D offset;
-    uint64_t overall_end =3D offset + length;
-    BdrvDirtyBitmapIter *it;
-    bool dirty;
+    int64_t start, dirty_start, dirty_count;
+    int64_t end =3D offset + length;
+    bool full =3D false;
=20
     bdrv_dirty_bitmap_lock(bitmap);
=20
-    it =3D bdrv_dirty_iter_new(bitmap);
-    dirty =3D bdrv_dirty_bitmap_get_locked(bitmap, offset);
-
-    while (begin < overall_end) {
-        bool next_dirty =3D !dirty;
-
-        if (dirty) {
-            end =3D bdrv_dirty_bitmap_next_zero(bitmap, begin, INT64_MAX);
-        } else {
-            bdrv_set_dirty_iter(it, begin);
-            end =3D bdrv_dirty_iter_next(it);
-        }
-        if (end =3D=3D -1 || end - begin > UINT32_MAX) {
-            /* Cap to an aligned value < 4G beyond begin. */
-            end =3D MIN(bdrv_dirty_bitmap_size(bitmap),
-                      begin + UINT32_MAX + 1 -
-                      bdrv_dirty_bitmap_granularity(bitmap));
-            next_dirty =3D dirty;
-        }
-        if (dont_fragment && end > overall_end) {
-            end =3D overall_end;
-        }
-
-        if (nbd_extent_array_add(ea, end - begin,
-                                 dirty ? NBD_STATE_DIRTY : 0) < 0) {
+    for (start =3D offset;
+         bdrv_dirty_bitmap_next_dirty_area(bitmap, start, end, INT32_MAX,
+                                           &dirty_start, &dirty_count);
+         start =3D dirty_start + dirty_count)
+    {
+        if ((nbd_extent_array_add(es, dirty_start - start, 0) < 0) ||
+            (nbd_extent_array_add(es, dirty_count, NBD_STATE_DIRTY) < 0))
+        {
+            full =3D true;
             break;
         }
-        begin =3D end;
-        dirty =3D next_dirty;
     }
=20
-    bdrv_dirty_iter_free(it);
+    if (!full) {
+        /* last non dirty extent */
+        nbd_extent_array_add(es, end - start, 0);
+    }
=20
     bdrv_dirty_bitmap_unlock(bitmap);
-
-    assert(offset < end);
 }
=20
 static int nbd_co_send_bitmap(NBDClient *client, uint64_t handle,
@@ -2129,7 +2108,7 @@ static int nbd_co_send_bitmap(NBDClient *client, uint=
64_t handle,
     unsigned int nb_extents =3D dont_fragment ? 1 : NBD_MAX_BLOCK_STATUS_E=
XTENTS;
     g_autoptr(NBDExtentArray) ea =3D nbd_extent_array_new(nb_extents);
=20
-    bitmap_to_extents(bitmap, offset, length, ea, dont_fragment);
+    bitmap_to_extents(bitmap, offset, length, ea);
=20
     return nbd_co_send_extents(client, handle, ea, last, context_id, errp)=
;
 }
--=20
2.21.1


