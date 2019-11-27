Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D97A4C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 13:37:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2A2320678
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 13:37:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hvxG1qtl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2A2320678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZxVa-0004kC-Kz
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 08:37:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33640)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iZxBl-0003vw-6G
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 08:17:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iZxBj-0006cd-31
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 08:17:01 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21022
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iZxBd-0006Pq-Lt
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 08:16:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574860609;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i/9I8hclwnADOArvxL3CcJ/qqFH1snxCCHwJsgBOBpc=;
 b=hvxG1qtlRsq88OjrdxjanCIRAmXfjmzyiYL7J0goUUBSU09uN8u69upRgD0FLAo2LUAc1f
 yP2ptu1NtAy4s8Z996vJspEhFpFiYCo3UPfV04/591NnW9JVOQRITtmGMcO+uzYXnZU+/V
 0v6T1adtjnEbCh6LjBzOi80QQgL2P8E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-ggmB3li9O5qi1lA3b3r89w-1; Wed, 27 Nov 2019 08:16:48 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E80C9800D53;
 Wed, 27 Nov 2019 13:16:46 +0000 (UTC)
Received: from localhost (ovpn-205-186.brq.redhat.com [10.40.205.186])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5122967646;
 Wed, 27 Nov 2019 13:16:46 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH for-5.0 08/31] block: Unify bdrv_*inherited_options()
Date: Wed, 27 Nov 2019 14:16:01 +0100
Message-Id: <20191127131624.1062403-9-mreitz@redhat.com>
In-Reply-To: <20191127131624.1062403-1-mreitz@redhat.com>
References: <20191127131624.1062403-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: ggmB3li9O5qi1lA3b3r89w-1
X-Mimecast-Spam-Score: 0
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We can keep the logic for child_file, child_format, and child_backing in
a single function and differentiate based on the BdrvChildRole.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block.c | 96 +++++++++++++++++++++++++++++++++++----------------------
 1 file changed, 60 insertions(+), 36 deletions(-)

diff --git a/block.c b/block.c
index f42682478e..b3decde6c5 100644
--- a/block.c
+++ b/block.c
@@ -977,8 +977,8 @@ static void bdrv_temp_snapshot_options(int *child_flags=
, QDict *child_options,
 }
=20
 /*
- * Returns the options and flags that bs->file should get if a protocol dr=
iver
- * is expected, based on the given options and flags for the parent BDS
+ * Returns the options and flags that a generic child of a BDS should
+ * get, based on the given options and flags for the parent BDS.
  */
 static void bdrv_inherited_options(BdrvChildRole role,
                                    int *child_flags, QDict *child_options,
@@ -986,8 +986,16 @@ static void bdrv_inherited_options(BdrvChildRole role,
 {
     int flags =3D parent_flags;
=20
-    /* Enable protocol handling, disable format probing for bs->file */
-    flags |=3D BDRV_O_PROTOCOL;
+    assert((role & (BDRV_CHILD_PROTOCOL | BDRV_CHILD_FORMAT))
+                !=3D (BDRV_CHILD_PROTOCOL | BDRV_CHILD_FORMAT));
+
+    if (role & BDRV_CHILD_PROTOCOL) {
+        /* Enable protocol handling, disable format probing */
+        flags |=3D BDRV_O_PROTOCOL;
+    } else if (role & BDRV_CHILD_FORMAT) {
+        /* Enable format handling */
+        flags &=3D ~BDRV_O_PROTOCOL;
+    }
=20
     /* If the cache mode isn't explicitly set, inherit direct and no-flush=
 from
      * the parent. */
@@ -995,26 +1003,57 @@ static void bdrv_inherited_options(BdrvChildRole rol=
e,
     qdict_copy_default(child_options, parent_options, BDRV_OPT_CACHE_NO_FL=
USH);
     qdict_copy_default(child_options, parent_options, BDRV_OPT_FORCE_SHARE=
);
=20
-    /* Inherit the read-only option from the parent if it's not set */
-    qdict_copy_default(child_options, parent_options, BDRV_OPT_READ_ONLY);
-    qdict_copy_default(child_options, parent_options, BDRV_OPT_AUTO_READ_O=
NLY);
+    if (role & BDRV_CHILD_COW) {
+        /* backing files always opened read-only */
+        qdict_set_default_str(child_options, BDRV_OPT_READ_ONLY, "on");
+        qdict_set_default_str(child_options, BDRV_OPT_AUTO_READ_ONLY, "off=
");
+    } else {
+        /* Inherit the read-only option from the parent if it's not set */
+        qdict_copy_default(child_options, parent_options, BDRV_OPT_READ_ON=
LY);
+        qdict_copy_default(child_options, parent_options,
+                           BDRV_OPT_AUTO_READ_ONLY);
+    }
=20
-    /* Our block drivers take care to send flushes and respect unmap polic=
y,
-     * so we can default to enable both on lower layers regardless of the
-     * corresponding parent options. */
-    qdict_set_default_str(child_options, BDRV_OPT_DISCARD, "unmap");
+    if (role & BDRV_CHILD_PROTOCOL) {
+        /*
+         * Our format drivers (which expect protocol children underneath, =
hence
+         * the condition) take care to send flushes and respect unmap poli=
cy, so
+         * we can default to enable both on lower layers regardless of the
+         * corresponding parent options.
+         */
+        qdict_set_default_str(child_options, BDRV_OPT_DISCARD, "unmap");
+    }
=20
     /* Clear flags that only apply to the top layer */
-    flags &=3D ~(BDRV_O_SNAPSHOT | BDRV_O_NO_BACKING | BDRV_O_COPY_ON_READ=
 |
-               BDRV_O_NO_IO);
+    flags &=3D ~(BDRV_O_SNAPSHOT | BDRV_O_NO_BACKING | BDRV_O_COPY_ON_READ=
);
+
+    if (role & BDRV_CHILD_METADATA) {
+        flags &=3D ~BDRV_O_NO_IO;
+    }
+    if (role & BDRV_CHILD_COW) {
+        flags &=3D ~BDRV_O_TEMPORARY;
+    }
=20
     *child_flags =3D flags;
 }
=20
+/*
+ * Returns the options and flags that bs->file should get if a protocol dr=
iver
+ * is expected, based on the given options and flags for the parent BDS
+ */
+static void bdrv_inherited_file_options(BdrvChildRole role,
+                                        int *child_flags, QDict *child_opt=
ions,
+                                        int parent_flags, QDict *parent_op=
tions)
+{
+    bdrv_inherited_options(BDRV_CHILD_IMAGE,
+                           child_flags, child_options,
+                           parent_flags, parent_options);
+}
+
 const BdrvChildClass child_file =3D {
     .parent_is_bds   =3D true,
     .get_parent_desc =3D bdrv_child_get_parent_desc,
-    .inherit_options =3D bdrv_inherited_options,
+    .inherit_options =3D bdrv_inherited_file_options,
     .drained_begin   =3D bdrv_child_cb_drained_begin,
     .drained_poll    =3D bdrv_child_cb_drained_poll,
     .drained_end     =3D bdrv_child_cb_drained_end,
@@ -1034,10 +1073,9 @@ static void bdrv_inherited_fmt_options(BdrvChildRole=
 role,
                                        int *child_flags, QDict *child_opti=
ons,
                                        int parent_flags, QDict *parent_opt=
ions)
 {
-    child_file.inherit_options(role, child_flags, child_options,
-                               parent_flags, parent_options);
-
-    *child_flags &=3D ~BDRV_O_PROTOCOL;
+    bdrv_inherited_options(BDRV_CHILD_DATA | BDRV_CHILD_FORMAT,
+                           child_flags, child_options,
+                           parent_flags, parent_options);
 }
=20
 const BdrvChildClass child_format =3D {
@@ -1119,23 +1157,9 @@ static void bdrv_backing_options(BdrvChildRole role,
                                  int *child_flags, QDict *child_options,
                                  int parent_flags, QDict *parent_options)
 {
-    int flags =3D parent_flags;
-
-    /* The cache mode is inherited unmodified for backing files; except WC=
E,
-     * which is only applied on the top level (BlockBackend) */
-    qdict_copy_default(child_options, parent_options, BDRV_OPT_CACHE_DIREC=
T);
-    qdict_copy_default(child_options, parent_options, BDRV_OPT_CACHE_NO_FL=
USH);
-    qdict_copy_default(child_options, parent_options, BDRV_OPT_FORCE_SHARE=
);
-
-    /* backing files always opened read-only */
-    qdict_set_default_str(child_options, BDRV_OPT_READ_ONLY, "on");
-    qdict_set_default_str(child_options, BDRV_OPT_AUTO_READ_ONLY, "off");
-    flags &=3D ~BDRV_O_COPY_ON_READ;
-
-    /* snapshot=3Don is handled on the top layer */
-    flags &=3D ~(BDRV_O_SNAPSHOT | BDRV_O_TEMPORARY);
-
-    *child_flags =3D flags;
+    bdrv_inherited_options(BDRV_CHILD_COW,
+                           child_flags, child_options,
+                           parent_flags, parent_options);
 }
=20
 static int bdrv_backing_update_filename(BdrvChild *c, BlockDriverState *ba=
se,
@@ -3021,7 +3045,7 @@ static BlockDriverState *bdrv_open_inherit(const char=
 *filename,
                                    flags, options);
         /* Let bdrv_backing_options() override "read-only" */
         qdict_del(options, BDRV_OPT_READ_ONLY);
-        bdrv_backing_options(0, &flags, options, flags, options);
+        bdrv_inherited_options(BDRV_CHILD_COW, &flags, options, flags, opt=
ions);
     }
=20
     bs->open_flags =3D flags;
--=20
2.23.0


