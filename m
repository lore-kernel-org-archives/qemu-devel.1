Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E14C33CB7
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 17:55:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3CDF206D5
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 17:55:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ebsTzS/D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3CDF206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixaVz-0004D9-TG
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 12:55:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41579)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1ixaLl-0003Dc-NG
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 12:45:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1ixaLj-0004hx-Pk
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 12:45:01 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:42752
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ixaLj-0004gr-Jn
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 12:44:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580492699;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r15KjtoTfDHDeFA/sMgNA1KjglEt1D7DEzNP6tGdv84=;
 b=ebsTzS/D41xCCV1MH0PFd4PGJbPr0rkb2bQ2ojbHI7/x1g2NUbDvWtkROjmmbla4ZPL1CZ
 yFueSOsIZpQfAc961sfjSg15+NilGyvMY1x9Ac7Za4DUTqc2zddVnQZXlk7fHorRCt0mMk
 Hydqi1kVX5BZFW4l+GFkF910RaVFhyI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-lVqnbjmUMqqE3ODxGSAN9w-1; Fri, 31 Jan 2020 12:44:56 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 77BB1100550E;
 Fri, 31 Jan 2020 17:44:55 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-181.phx2.redhat.com [10.3.116.181])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EBD3B7FB60;
 Fri, 31 Jan 2020 17:44:54 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 13/17] qcow2: Add new autoclear feature for all zero image
Date: Fri, 31 Jan 2020 11:44:32 -0600
Message-Id: <20200131174436.2961874-14-eblake@redhat.com>
In-Reply-To: <20200131174436.2961874-1-eblake@redhat.com>
References: <20200131174436.2961874-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: lVqnbjmUMqqE3ODxGSAN9w-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: david.edmondson@oracle.com, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

With the recent introduction of BDRV_ZERO_OPEN, we can optimize
various qemu-img operations if we know the destination starts life
with all zero content.  For an image with no cluster allocations and
no backing file, this was already trivial with BDRV_ZERO_CREATE; but
for a fully preallocated image, it does not scale to crawl through the
entire L1/L2 tree to see if every cluster is currently marked as a
zero cluster.  But it is quite easy to add an autoclear bit to the
qcow2 file itself: the bit will be set after newly creating an image
or after qcow2_make_empty, and cleared on any other modification
(including by an older qemu that doesn't recognize the bit).

This patch documents the new bit, independently of implementing the
places in code that should set it (which means that for bisection
purposes, it is safer to still mask the bit out when opening an image
with the bit set).

A few iotests have updated output due to the larger number of named
header features.

Signed-off-by: Eric Blake <eblake@redhat.com>

---
RFC: As defined in this patch, I defined the bit to be clear if any
cluster defers to a backing file. But the block layer would handle
things just fine if we instead allowed the bit to be set if all
clusters allocated in this image are zero, even if there are other
clusters not allocated.  Or maybe we want TWO bits: one if all
clusters allocated here are known zero, and a second if we know that
there are any clusters that defer to a backing image.
---
 block/qcow2.c              |  9 +++++++++
 block/qcow2.h              |  3 +++
 docs/interop/qcow2.txt     | 12 +++++++++++-
 qapi/block-core.json       |  4 ++++
 tests/qemu-iotests/031.out |  8 ++++----
 tests/qemu-iotests/036.out |  4 ++--
 tests/qemu-iotests/061.out | 14 +++++++-------
 7 files changed, 40 insertions(+), 14 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 9f2371925737..20cce9410c84 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2859,6 +2859,11 @@ int qcow2_update_header(BlockDriverState *bs)
                 .bit  =3D QCOW2_AUTOCLEAR_DATA_FILE_RAW_BITNR,
                 .name =3D "raw external data",
             },
+            {
+                .type =3D QCOW2_FEAT_TYPE_AUTOCLEAR,
+                .bit  =3D QCOW2_AUTOCLEAR_ALL_ZERO_BITNR,
+                .name =3D "all zero",
+            },
         };

         ret =3D header_ext_add(buf, QCOW2_EXT_MAGIC_FEATURE_TABLE,
@@ -4874,6 +4879,10 @@ static ImageInfoSpecific *qcow2_get_specific_info(Bl=
ockDriverState *bs,
             .corrupt            =3D s->incompatible_features &
                                   QCOW2_INCOMPAT_CORRUPT,
             .has_corrupt        =3D true,
+            .all_zero           =3D s->autoclear_features &
+                                  QCOW2_AUTOCLEAR_ALL_ZERO,
+            .has_all_zero       =3D s->autoclear_features &
+                                  QCOW2_AUTOCLEAR_ALL_ZERO,
             .refcount_bits      =3D s->refcount_bits,
             .has_bitmaps        =3D !!bitmaps,
             .bitmaps            =3D bitmaps,
diff --git a/block/qcow2.h b/block/qcow2.h
index 094212623257..6fc2d323d753 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -237,11 +237,14 @@ enum {
 enum {
     QCOW2_AUTOCLEAR_BITMAPS_BITNR       =3D 0,
     QCOW2_AUTOCLEAR_DATA_FILE_RAW_BITNR =3D 1,
+    QCOW2_AUTOCLEAR_ALL_ZERO_BITNR      =3D 2,
     QCOW2_AUTOCLEAR_BITMAPS             =3D 1 << QCOW2_AUTOCLEAR_BITMAPS_B=
ITNR,
     QCOW2_AUTOCLEAR_DATA_FILE_RAW       =3D 1 << QCOW2_AUTOCLEAR_DATA_FILE=
_RAW_BITNR,
+    QCOW2_AUTOCLEAR_ALL_ZERO            =3D 1 << QCOW2_AUTOCLEAR_ALL_ZERO_=
BITNR,

     QCOW2_AUTOCLEAR_MASK                =3D QCOW2_AUTOCLEAR_BITMAPS
                                         | QCOW2_AUTOCLEAR_DATA_FILE_RAW,
+    /* TODO: Add _ALL_ZERO to _MASK once it is handled correctly */
 };

 enum qcow2_discard_type {
diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
index 8510d74c8079..d435363a413c 100644
--- a/docs/interop/qcow2.txt
+++ b/docs/interop/qcow2.txt
@@ -153,7 +153,17 @@ in the description of a field.
                                 File bit (incompatible feature bit 1) is a=
lso
                                 set.

-                    Bits 2-63:  Reserved (set to 0)
+                    Bit 2:      All zero image bit
+                                If this bit is set, the entire image reads
+                                as all zeroes. This can be useful for
+                                detecting just-created images even when
+                                clusters are preallocated, which in turn
+                                can be used to optimize image copying.
+
+                                This bit should not be set if any cluster
+                                in the image defers to a backing file.
+
+                    Bits 3-63:  Reserved (set to 0)

          96 -  99:  refcount_order
                     Describes the width of a reference count block entry (=
width
diff --git a/qapi/block-core.json b/qapi/block-core.json
index ef94a296868f..af837ed5af33 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -71,6 +71,9 @@
 # @corrupt: true if the image has been marked corrupt; only valid for
 #           compat >=3D 1.1 (since 2.2)
 #
+# @all-zero: present and true only if the image is known to read as all
+#            zeroes (since 5.0)
+#
 # @refcount-bits: width of a refcount entry in bits (since 2.3)
 #
 # @encrypt: details about encryption parameters; only set if image
@@ -87,6 +90,7 @@
       '*data-file-raw': 'bool',
       '*lazy-refcounts': 'bool',
       '*corrupt': 'bool',
+      '*all-zero': 'bool',
       'refcount-bits': 'int',
       '*encrypt': 'ImageInfoSpecificQCow2Encryption',
       '*bitmaps': ['Qcow2BitmapInfo']
diff --git a/tests/qemu-iotests/031.out b/tests/qemu-iotests/031.out
index 46f97c5a4ea4..bb1afa7b87f6 100644
--- a/tests/qemu-iotests/031.out
+++ b/tests/qemu-iotests/031.out
@@ -117,7 +117,7 @@ header_length             104

 Header extension:
 magic                     0x6803f857
-length                    288
+length                    336
 data                      <binary>

 Header extension:
@@ -150,7 +150,7 @@ header_length             104

 Header extension:
 magic                     0x6803f857
-length                    288
+length                    336
 data                      <binary>

 Header extension:
@@ -164,7 +164,7 @@ No errors were found on the image.

 magic                     0x514649fb
 version                   3
-backing_file_offset       0x1d8
+backing_file_offset       0x208
 backing_file_size         0x17
 cluster_bits              16
 size                      67108864
@@ -188,7 +188,7 @@ data                      'host_device'

 Header extension:
 magic                     0x6803f857
-length                    288
+length                    336
 data                      <binary>

 Header extension:
diff --git a/tests/qemu-iotests/036.out b/tests/qemu-iotests/036.out
index 23b699ce0622..e409acf60e2b 100644
--- a/tests/qemu-iotests/036.out
+++ b/tests/qemu-iotests/036.out
@@ -26,7 +26,7 @@ compatible_features       []
 autoclear_features        [63]
 Header extension:
 magic                     0x6803f857
-length                    288
+length                    336
 data                      <binary>


@@ -38,7 +38,7 @@ compatible_features       []
 autoclear_features        []
 Header extension:
 magic                     0x6803f857
-length                    288
+length                    336
 data                      <binary>

 *** done
diff --git a/tests/qemu-iotests/061.out b/tests/qemu-iotests/061.out
index 413cc4e0f4ab..d873f79bb606 100644
--- a/tests/qemu-iotests/061.out
+++ b/tests/qemu-iotests/061.out
@@ -26,7 +26,7 @@ header_length             104

 Header extension:
 magic                     0x6803f857
-length                    288
+length                    336
 data                      <binary>

 magic                     0x514649fb
@@ -84,7 +84,7 @@ header_length             104

 Header extension:
 magic                     0x6803f857
-length                    288
+length                    336
 data                      <binary>

 magic                     0x514649fb
@@ -140,7 +140,7 @@ header_length             104

 Header extension:
 magic                     0x6803f857
-length                    288
+length                    336
 data                      <binary>

 ERROR cluster 5 refcount=3D0 reference=3D1
@@ -195,7 +195,7 @@ header_length             104

 Header extension:
 magic                     0x6803f857
-length                    288
+length                    336
 data                      <binary>

 magic                     0x514649fb
@@ -264,7 +264,7 @@ header_length             104

 Header extension:
 magic                     0x6803f857
-length                    288
+length                    336
 data                      <binary>

 read 65536/65536 bytes at offset 44040192
@@ -298,7 +298,7 @@ header_length             104

 Header extension:
 magic                     0x6803f857
-length                    288
+length                    336
 data                      <binary>

 ERROR cluster 5 refcount=3D0 reference=3D1
@@ -327,7 +327,7 @@ header_length             104

 Header extension:
 magic                     0x6803f857
-length                    288
+length                    336
 data                      <binary>

 read 131072/131072 bytes at offset 0
--=20
2.24.1


