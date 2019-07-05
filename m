Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03039C5B57D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 09:35:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD431218BC
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 09:35:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD431218BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjKcO-0003VT-5H
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 05:35:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41453)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <sgarzare@redhat.com>) id 1hjKb0-00021i-Sn
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 05:33:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1hjKaz-0002tf-9v
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 05:33:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39554)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>)
 id 1hjKan-0002U5-Lv; Fri, 05 Jul 2019 05:33:22 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4371759451;
 Fri,  5 Jul 2019 09:33:10 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-117-149.ams2.redhat.com
 [10.36.117.149])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2285B68C6B;
 Fri,  5 Jul 2019 09:32:58 +0000 (UTC)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri,  5 Jul 2019 11:32:58 +0200
Message-Id: <20190705093258.47856-1-sgarzare@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Fri, 05 Jul 2019 09:33:10 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3] block/rbd: implement
 .bdrv_get_allocated_file_size callback
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
Cc: Kevin Wolf <kwolf@redhat.com>, Josh Durgin <jdurgin@redhat.com>,
 qemu-block@nongnu.org, Jason Dillaman <jdillama@redhat.com>,
 Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch allows 'qemu-img info' to show the 'disk size' for
the RBD images that have the fast-diff feature enabled.

If this feature is enabled, we use the rbd_diff_iterate2() API
to calculate the allocated size for the image.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
v3:
  - return -ENOTSUP instead of -1 when fast-diff is not available
    [John, Jason]
v2:
  - calculate the actual usage only if the fast-diff feature is
    enabled [Jason]
---
 block/rbd.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/block/rbd.c b/block/rbd.c
index 59757b3120..b6bed683e5 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -1084,6 +1084,59 @@ static int64_t qemu_rbd_getlength(BlockDriverState=
 *bs)
     return info.size;
 }
=20
+static int rbd_allocated_size_cb(uint64_t offset, size_t len, int exists=
,
+                                 void *arg)
+{
+    int64_t *alloc_size =3D (int64_t *) arg;
+
+    if (exists) {
+        (*alloc_size) +=3D len;
+    }
+
+    return 0;
+}
+
+static int64_t qemu_rbd_get_allocated_file_size(BlockDriverState *bs)
+{
+    BDRVRBDState *s =3D bs->opaque;
+    uint64_t flags, features;
+    int64_t alloc_size =3D 0;
+    int r;
+
+    r =3D rbd_get_flags(s->image, &flags);
+    if (r < 0) {
+        return r;
+    }
+
+    r =3D rbd_get_features(s->image, &features);
+    if (r < 0) {
+        return r;
+    }
+
+    /*
+     * We use rbd_diff_iterate2() only if the RBD image have fast-diff
+     * feature enabled. If it is disabled, rbd_diff_iterate2() could be
+     * very slow on a big image.
+     */
+    if (!(features & RBD_FEATURE_FAST_DIFF) ||
+        (flags & RBD_FLAG_FAST_DIFF_INVALID)) {
+        return -ENOTSUP;
+    }
+
+    /*
+     * rbd_diff_iterate2(), if the source snapshot name is NULL, invokes
+     * the callback on all allocated regions of the image.
+     */
+    r =3D rbd_diff_iterate2(s->image, NULL, 0,
+                          bs->total_sectors * BDRV_SECTOR_SIZE, 0, 1,
+                          &rbd_allocated_size_cb, &alloc_size);
+    if (r < 0) {
+        return r;
+    }
+
+    return alloc_size;
+}
+
 static int coroutine_fn qemu_rbd_co_truncate(BlockDriverState *bs,
                                              int64_t offset,
                                              PreallocMode prealloc,
@@ -1291,6 +1344,7 @@ static BlockDriver bdrv_rbd =3D {
     .bdrv_get_info          =3D qemu_rbd_getinfo,
     .create_opts            =3D &qemu_rbd_create_opts,
     .bdrv_getlength         =3D qemu_rbd_getlength,
+    .bdrv_get_allocated_file_size =3D qemu_rbd_get_allocated_file_size,
     .bdrv_co_truncate       =3D qemu_rbd_co_truncate,
     .protocol_name          =3D "rbd",
=20
--=20
2.20.1


