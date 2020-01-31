Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6AE2C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 17:48:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8359B214D8
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 17:48:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aIgfrVii"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8359B214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixaP5-0007rd-L4
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 12:48:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41180)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1ixaLV-0002c1-SZ
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 12:44:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1ixaLT-0004Ga-Vy
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 12:44:45 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:59560
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ixaLT-0004G4-Rv
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 12:44:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580492683;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NECrzhLnAJqisY5S+eozbIOoiheU/vYYbDCkaJ8l/Y4=;
 b=aIgfrViieS9hm4aZVU27vBArdy6IDQE7T4OIm+l0BzXfwtX2FNNWijCRfwn26104O8387b
 JjBEhdQqkedpFF4Ot1CXV2MNo8NMIMJY5D+1/jjIwrjpAP9iYuT57AkYCpprEp+OI5X2A7
 nETfBOvTBbrnrlfoT0mUcbAUQXWMfeE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351-WJgYAmB_Ns-NgI9iyCbNKA-1; Fri, 31 Jan 2020 12:44:41 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 79C7D801E67;
 Fri, 31 Jan 2020 17:44:40 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-181.phx2.redhat.com [10.3.116.181])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 079FC7FB60;
 Fri, 31 Jan 2020 17:44:39 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 02/17] qcow2: List autoclear bit names in header
Date: Fri, 31 Jan 2020 11:44:21 -0600
Message-Id: <20200131174436.2961874-3-eblake@redhat.com>
In-Reply-To: <20200131174436.2961874-1-eblake@redhat.com>
References: <20200131174436.2961874-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: WJgYAmB_Ns-NgI9iyCbNKA-1
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
 qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The feature table is supposed to advertise the name of all feature
bits that we support; however, we forgot to update the table for
autoclear bits.  While at it, move the table to read-only memory in
code, and tweak the qcow2 spec to name the second autoclear bit.
Update iotests that are affected by the longer header length.

Fixes: 88ddffae
Fixes: 93c24936
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/qcow2.c              | 12 +++++++++++-
 docs/interop/qcow2.txt     |  3 ++-
 tests/qemu-iotests/031.out |  8 ++++----
 tests/qemu-iotests/036.out |  4 ++--
 tests/qemu-iotests/061.out | 14 +++++++-------
 5 files changed, 26 insertions(+), 15 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 30fd3d13032a..d3e7709ac2b4 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2821,7 +2821,7 @@ int qcow2_update_header(BlockDriverState *bs)

     /* Feature table */
     if (s->qcow_version >=3D 3) {
-        Qcow2Feature features[] =3D {
+        static const Qcow2Feature features[] =3D {
             {
                 .type =3D QCOW2_FEAT_TYPE_INCOMPATIBLE,
                 .bit  =3D QCOW2_INCOMPAT_DIRTY_BITNR,
@@ -2842,6 +2842,16 @@ int qcow2_update_header(BlockDriverState *bs)
                 .bit  =3D QCOW2_COMPAT_LAZY_REFCOUNTS_BITNR,
                 .name =3D "lazy refcounts",
             },
+            {
+                .type =3D QCOW2_FEAT_TYPE_AUTOCLEAR,
+                .bit  =3D QCOW2_AUTOCLEAR_BITMAPS_BITNR,
+                .name =3D "consistent bitmaps",
+            },
+            {
+                .type =3D QCOW2_FEAT_TYPE_AUTOCLEAR,
+                .bit  =3D QCOW2_AUTOCLEAR_DATA_FILE_RAW_BITNR,
+                .name =3D "raw external data",
+            },
         };

         ret =3D header_ext_add(buf, QCOW2_EXT_MAGIC_FEATURE_TABLE,
diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
index af5711e53371..8510d74c8079 100644
--- a/docs/interop/qcow2.txt
+++ b/docs/interop/qcow2.txt
@@ -138,7 +138,8 @@ in the description of a field.
                                 bit is unset, the bitmaps extension data m=
ust be
                                 considered inconsistent.

-                    Bit 1:      If this bit is set, the external data file=
 can
+                    Bit 1:      Raw external data bit
+                                If this bit is set, the external data file=
 can
                                 be read as a consistent standalone raw ima=
ge
                                 without looking at the qcow2 metadata.

diff --git a/tests/qemu-iotests/031.out b/tests/qemu-iotests/031.out
index d535e407bc30..46f97c5a4ea4 100644
--- a/tests/qemu-iotests/031.out
+++ b/tests/qemu-iotests/031.out
@@ -117,7 +117,7 @@ header_length             104

 Header extension:
 magic                     0x6803f857
-length                    192
+length                    288
 data                      <binary>

 Header extension:
@@ -150,7 +150,7 @@ header_length             104

 Header extension:
 magic                     0x6803f857
-length                    192
+length                    288
 data                      <binary>

 Header extension:
@@ -164,7 +164,7 @@ No errors were found on the image.

 magic                     0x514649fb
 version                   3
-backing_file_offset       0x178
+backing_file_offset       0x1d8
 backing_file_size         0x17
 cluster_bits              16
 size                      67108864
@@ -188,7 +188,7 @@ data                      'host_device'

 Header extension:
 magic                     0x6803f857
-length                    192
+length                    288
 data                      <binary>

 Header extension:
diff --git a/tests/qemu-iotests/036.out b/tests/qemu-iotests/036.out
index 0b52b934e115..23b699ce0622 100644
--- a/tests/qemu-iotests/036.out
+++ b/tests/qemu-iotests/036.out
@@ -26,7 +26,7 @@ compatible_features       []
 autoclear_features        [63]
 Header extension:
 magic                     0x6803f857
-length                    192
+length                    288
 data                      <binary>


@@ -38,7 +38,7 @@ compatible_features       []
 autoclear_features        []
 Header extension:
 magic                     0x6803f857
-length                    192
+length                    288
 data                      <binary>

 *** done
diff --git a/tests/qemu-iotests/061.out b/tests/qemu-iotests/061.out
index 8b3091a412bc..413cc4e0f4ab 100644
--- a/tests/qemu-iotests/061.out
+++ b/tests/qemu-iotests/061.out
@@ -26,7 +26,7 @@ header_length             104

 Header extension:
 magic                     0x6803f857
-length                    192
+length                    288
 data                      <binary>

 magic                     0x514649fb
@@ -84,7 +84,7 @@ header_length             104

 Header extension:
 magic                     0x6803f857
-length                    192
+length                    288
 data                      <binary>

 magic                     0x514649fb
@@ -140,7 +140,7 @@ header_length             104

 Header extension:
 magic                     0x6803f857
-length                    192
+length                    288
 data                      <binary>

 ERROR cluster 5 refcount=3D0 reference=3D1
@@ -195,7 +195,7 @@ header_length             104

 Header extension:
 magic                     0x6803f857
-length                    192
+length                    288
 data                      <binary>

 magic                     0x514649fb
@@ -264,7 +264,7 @@ header_length             104

 Header extension:
 magic                     0x6803f857
-length                    192
+length                    288
 data                      <binary>

 read 65536/65536 bytes at offset 44040192
@@ -298,7 +298,7 @@ header_length             104

 Header extension:
 magic                     0x6803f857
-length                    192
+length                    288
 data                      <binary>

 ERROR cluster 5 refcount=3D0 reference=3D1
@@ -327,7 +327,7 @@ header_length             104

 Header extension:
 magic                     0x6803f857
-length                    192
+length                    288
 data                      <binary>

 read 131072/131072 bytes at offset 0
--=20
2.24.1


