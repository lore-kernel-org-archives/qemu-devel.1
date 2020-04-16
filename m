Return-Path: <SRS0=3HrQ=6A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F18FC352BE
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 21:24:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 381CB2223F
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 21:24:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z028o0yL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 381CB2223F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPC04-0004n4-Bt
	for qemu-devel@archiver.kernel.org; Thu, 16 Apr 2020 17:24:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38619)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jPBzK-0004IG-JO
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 17:24:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jPBzI-0007AL-OC
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 17:23:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26630
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jPBzI-00079k-HV
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 17:23:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587072235;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=OWPN0bnj5ROZ+/50hGVj8oHcrNJm1uaNdNQ7h/YOESE=;
 b=Z028o0yLsP/jGFft4F7tE2n3qiddMiLuaPVTsSH1AuWLtCxQLyGibtSa4sWen/DdJo4enI
 0Zp1B1VoNLIfuG3M37K2MmmFngCx6OBFrz0qb8b3UZ9RV+e2QkVDFM7ACC402XQL4RY6re
 QsK0SydpsNPy2l7SwVihIg8eKOLD3fw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-57-v8sTUDRxMQCB7azoBRA1jQ-1; Thu, 16 Apr 2020 17:23:54 -0400
X-MC-Unique: v8sTUDRxMQCB7azoBRA1jQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2BF8B800D53;
 Thu, 16 Apr 2020 21:23:53 +0000 (UTC)
Received: from blue.redhat.com (ovpn-115-59.phx2.redhat.com [10.3.115.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 654B219756;
 Thu, 16 Apr 2020 21:23:52 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] qcow2: Expose bitmaps' size during measure
Date: Thu, 16 Apr 2020 16:23:49 -0500
Message-Id: <20200416212349.731404-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 nsoffer@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It's useful to know how much space can be occupied by qcow2 persistent
bitmaps, even though such metadata is unrelated to the guest-visible
data.  Report this value as an additional field.

Reported-by: Nir Soffer <nsoffer@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---

This is independent from my 'qemu-img convert --bitmaps' series, but
highly related.  As an example, if I create a 100M image, then 2
persistent bitmaps, all with default cluster/granularity sizing, I now
see:

$ ./qemu-img measure -f qcow2 -O qcow2 build/img.top
required size: 52756480
fully allocated size: 105185280
bitmaps size: 327680

which argues that I should allocate 52756480 + 327680 bytes prior to
attempting qemu-img convert --bitmaps to a pre-sized destination.

If we like the idea, I probably need to submit a 2/1 patch adding
iotest coverage of the new measurement.

 qapi/block-core.json | 15 ++++++++++-----
 block/qcow2.c        | 25 +++++++++++++++++++++++++
 qemu-img.c           |  3 +++
 3 files changed, 38 insertions(+), 5 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 943df1926a91..b47c6d69ba27 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -633,18 +633,23 @@
 # efficiently so file size may be smaller than virtual disk size.
 #
 # The values are upper bounds that are guaranteed to fit the new image fil=
e.
-# Subsequent modification, such as internal snapshot or bitmap creation, m=
ay
-# require additional space and is not covered here.
+# Subsequent modification, such as internal snapshot or further bitmap
+# creation, may require additional space and is not covered here.
 #
-# @required: Size required for a new image file, in bytes.
+# @required: Size required for a new image file, in bytes, when copying ju=
st
+#            guest-visible contents.
 #
 # @fully-allocated: Image file size, in bytes, once data has been written
-#                   to all sectors.
+#                   to all sectors, when copying just guest-visible conten=
ts.
+#
+# @bitmaps: Additional size required for bitmap metadata not directly used
+#           for guest contents, when that metadata can be copied in additi=
on
+#           to guest contents. (since 5.1)
 #
 # Since: 2.10
 ##
 { 'struct': 'BlockMeasureInfo',
-  'data': {'required': 'int', 'fully-allocated': 'int'} }
+  'data': {'required': 'int', 'fully-allocated': 'int', '*bitmaps': 'int'}=
 }

 ##
 # @query-block:
diff --git a/block/qcow2.c b/block/qcow2.c
index b524b0c53f84..eba6c2511e60 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -4657,6 +4657,7 @@ static BlockMeasureInfo *qcow2_measure(QemuOpts *opts=
, BlockDriverState *in_bs,
     PreallocMode prealloc;
     bool has_backing_file;
     bool has_luks;
+    uint64_t bitmaps_size =3D 0; /* size occupied by bitmaps in in_bs */

     /* Parse image creation options */
     cluster_size =3D qcow2_opt_get_cluster_size_del(opts, &local_err);
@@ -4732,6 +4733,8 @@ static BlockMeasureInfo *qcow2_measure(QemuOpts *opts=
, BlockDriverState *in_bs,

     /* Account for input image */
     if (in_bs) {
+        BdrvDirtyBitmap *bm;
+        size_t bitmap_overhead =3D 0;
         int64_t ssize =3D bdrv_getlength(in_bs);
         if (ssize < 0) {
             error_setg_errno(&local_err, -ssize,
@@ -4739,6 +4742,26 @@ static BlockMeasureInfo *qcow2_measure(QemuOpts *opt=
s, BlockDriverState *in_bs,
             goto err;
         }

+        FOR_EACH_DIRTY_BITMAP(in_bs, bm) {
+            if (bdrv_dirty_bitmap_get_persistence(bm)) {
+                uint64_t bmsize =3D bdrv_dirty_bitmap_size(bm);
+                uint32_t granularity =3D bdrv_dirty_bitmap_granularity(bm)=
;
+                const char *name =3D bdrv_dirty_bitmap_name(bm);
+                uint64_t bmclusters =3D DIV_ROUND_UP(bmsize / granularity
+                                                   / CHAR_BIT, cluster_siz=
e);
+
+                /* Assume the entire bitmap is allocated */
+                bitmaps_size +=3D bmclusters * cluster_size;
+                /* Also reserve space for the bitmap table entries */
+                bitmaps_size +=3D ROUND_UP(bmclusters * sizeof(uint64_t),
+                                         cluster_size);
+                /* Guess at contribution to bitmap directory size */
+                bitmap_overhead +=3D ROUND_UP(strlen(name) + 24,
+                                            sizeof(uint64_t));
+            }
+        }
+        bitmaps_size +=3D ROUND_UP(bitmap_overhead, cluster_size);
+
         virtual_size =3D ROUND_UP(ssize, cluster_size);

         if (has_backing_file) {
@@ -4795,6 +4818,8 @@ static BlockMeasureInfo *qcow2_measure(QemuOpts *opts=
, BlockDriverState *in_bs,
      * still counted.
      */
     info->required =3D info->fully_allocated - virtual_size + required;
+    info->has_bitmaps =3D !!bitmaps_size;
+    info->bitmaps =3D bitmaps_size;
     return info;

 err:
diff --git a/qemu-img.c b/qemu-img.c
index 6541357179c2..d900bde89911 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -5084,6 +5084,9 @@ static int img_measure(int argc, char **argv)
     if (output_format =3D=3D OFORMAT_HUMAN) {
         printf("required size: %" PRIu64 "\n", info->required);
         printf("fully allocated size: %" PRIu64 "\n", info->fully_allocate=
d);
+        if (info->has_bitmaps) {
+            printf("bitmaps size: %" PRIu64 "\n", info->bitmaps);
+        }
     } else {
         dump_json_block_measure_info(info);
     }
--=20
2.26.1


