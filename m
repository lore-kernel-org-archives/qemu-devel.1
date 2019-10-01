Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B53DECE587
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 17:50:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25C2121855
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 17:50:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25C2121855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFMHl-0004Ug-AR
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 13:50:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36458)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iFMGM-0002sP-9f
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 13:48:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iFMGL-0000dl-44
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 13:48:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37406)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iFMGI-0000bg-Q6; Tue, 01 Oct 2019 13:48:34 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1326810F2E96;
 Tue,  1 Oct 2019 17:48:34 +0000 (UTC)
Received: from localhost (unknown [10.40.205.251])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9E0B15D9C9;
 Tue,  1 Oct 2019 17:48:33 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 1/2] block: Skip COR for inactive nodes
Date: Tue,  1 Oct 2019 19:48:26 +0200
Message-Id: <20191001174827.11081-2-mreitz@redhat.com>
In-Reply-To: <20191001174827.11081-1-mreitz@redhat.com>
References: <20191001174827.11081-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.66]); Tue, 01 Oct 2019 17:48:34 +0000 (UTC)
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We must not write data to inactive nodes, and a COR is certainly
something we can simply not do without upsetting anyone.  So skip COR
operations on inactive nodes.

Signed-off-by: Max Reitz <mreitz@redhat.com>
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


