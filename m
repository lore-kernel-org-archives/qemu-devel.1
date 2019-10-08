Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E91E9C10F14
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 14:57:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA25620659
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 14:57:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA25620659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHqvb-0002f0-Vr
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 10:57:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54596)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iHqth-0000tu-GS
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 10:55:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iHqtg-00043c-5m
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 10:55:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35414)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>)
 id 1iHqtd-0003wI-3D; Tue, 08 Oct 2019 10:55:29 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4021EC0546FF;
 Tue,  8 Oct 2019 14:55:28 +0000 (UTC)
Received: from localhost (ovpn-116-36.ams2.redhat.com [10.36.116.36])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CB6185C1D4;
 Tue,  8 Oct 2019 14:55:27 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 3/4] block: Skip COR for inactive nodes
Date: Tue,  8 Oct 2019 15:55:04 +0100
Message-Id: <20191008145505.3641-4-stefanha@redhat.com>
In-Reply-To: <20191008145505.3641-1-stefanha@redhat.com>
References: <20191008145505.3641-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Tue, 08 Oct 2019 14:55:28 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Max Reitz <mreitz@redhat.com>

We must not write data to inactive nodes, and a COR is certainly
something we can simply not do without upsetting anyone.  So skip COR
operations on inactive nodes.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-id: 20191001174827.11081-2-mreitz@redhat.com
Message-Id: <20191001174827.11081-2-mreitz@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/io.c | 41 +++++++++++++++++++++++++++--------------
 1 file changed, 27 insertions(+), 14 deletions(-)

diff --git a/block/io.c b/block/io.c
index f8c3596131..4f9ee97c2b 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1246,11 +1246,18 @@ static int coroutine_fn bdrv_co_do_copy_on_readv(=
BdrvChild *child,
     int max_transfer =3D MIN_NON_ZERO(bs->bl.max_transfer,
                                     BDRV_REQUEST_MAX_BYTES);
     unsigned int progress =3D 0;
+    bool skip_write;
=20
     if (!drv) {
         return -ENOMEDIUM;
     }
=20
+    /*
+     * Do not write anything when the BDS is inactive.  That is not
+     * allowed, and it would not help.
+     */
+    skip_write =3D (bs->open_flags & BDRV_O_INACTIVE);
+
     /* FIXME We cannot require callers to have write permissions when al=
l they
      * are doing is a read request. If we did things right, write permis=
sions
      * would be obtained anyway, but internally by the copy-on-read code=
. As
@@ -1274,23 +1281,29 @@ static int coroutine_fn bdrv_co_do_copy_on_readv(=
BdrvChild *child,
     while (cluster_bytes) {
         int64_t pnum;
=20
-        ret =3D bdrv_is_allocated(bs, cluster_offset,
-                                MIN(cluster_bytes, max_transfer), &pnum)=
;
-        if (ret < 0) {
-            /* Safe to treat errors in querying allocation as if
-             * unallocated; we'll probably fail again soon on the
-             * read, but at least that will set a decent errno.
-             */
+        if (skip_write) {
+            ret =3D 1; /* "already allocated", so nothing will be copied=
 */
             pnum =3D MIN(cluster_bytes, max_transfer);
-        }
+        } else {
+            ret =3D bdrv_is_allocated(bs, cluster_offset,
+                                    MIN(cluster_bytes, max_transfer), &p=
num);
+            if (ret < 0) {
+                /*
+                 * Safe to treat errors in querying allocation as if
+                 * unallocated; we'll probably fail again soon on the
+                 * read, but at least that will set a decent errno.
+                 */
+                pnum =3D MIN(cluster_bytes, max_transfer);
+            }
=20
-        /* Stop at EOF if the image ends in the middle of the cluster */
-        if (ret =3D=3D 0 && pnum =3D=3D 0) {
-            assert(progress >=3D bytes);
-            break;
-        }
+            /* Stop at EOF if the image ends in the middle of the cluste=
r */
+            if (ret =3D=3D 0 && pnum =3D=3D 0) {
+                assert(progress >=3D bytes);
+                break;
+            }
=20
-        assert(skip_bytes < pnum);
+            assert(skip_bytes < pnum);
+        }
=20
         if (ret <=3D 0) {
             QEMUIOVector local_qiov;
--=20
2.21.0


