Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E68A7C35247
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 17:22:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B67DB2082E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 17:22:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VDKp2B9K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B67DB2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iz1u3-0001DB-TT
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 12:22:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53338)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iz1hq-0003Zo-5S
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 12:09:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iz1hn-0003Cf-HT
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 12:09:46 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:35916
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iz1hn-000351-Bp
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 12:09:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580836175;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DwpMirS9MT9wyGx9Gn9nyOIqGPgXfCI7XRMLnwX2BFo=;
 b=VDKp2B9Kh/wAlpRF3SSEcmAGU5hRQPQlCnyu1cmh1G6uh/lDz8COaZjlWH2YDPJTdSBabS
 gtLT3YoeC2cFlEAULYZ7bqtcYggUkYUMzXIp5BP4oxtNFqafQt+ttCPKGED/MbopufcIBE
 tZpgoDiGYmu6xD8Y0XgnTeBk+uS9r0s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-zNCZbPxWPGyHRKAdVdItnQ-1; Tue, 04 Feb 2020 12:09:21 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9E7618010CB;
 Tue,  4 Feb 2020 17:09:20 +0000 (UTC)
Received: from localhost (ovpn-117-98.ams2.redhat.com [10.36.117.98])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 271A4384;
 Tue,  4 Feb 2020 17:09:19 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 10/33] block: Use bdrv_inherited_options()
Date: Tue,  4 Feb 2020 18:08:25 +0100
Message-Id: <20200204170848.614480-11-mreitz@redhat.com>
In-Reply-To: <20200204170848.614480-1-mreitz@redhat.com>
References: <20200204170848.614480-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: zNCZbPxWPGyHRKAdVdItnQ-1
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Let child_file's, child_format's, and child_backing's .inherit_options()
implementations fall back to bdrv_inherited_options() to show that it
would really work for all of these cases, if only the parents passed the
appropriate BdrvChildRole and parent_is_format values.

(Also, make bdrv_open_inherit(), the only place to explicitly call
bdrv_backing_options(), call bdrv_inherited_options() instead.)

This patch should incur only two visible changes, both for child_format
children, both of which are effectively bug fixes:

First, they no longer have discard=3Dunmap set by default.  This reason it
was set is because bdrv_inherited_fmt_options() fell through to
bdrv_protocol_options(), and that set it because "format drivers take
care to send flushes and respect unmap policy".  None of the drivers
that use child_format for their children (quorum and blkverify) are
format drivers, though, so this reasoning does not apply here.

Second, they no longer have BDRV_O_NO_IO force-cleared.  child_format
was used solely for children that do not store any metadata and as such
will not be accessed by their parents as long as those parents do not
receive I/O themselves.  Thus, such children should inherit
BDRV_O_NO_IO.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block.c | 66 ++++++++++++---------------------------------------------
 1 file changed, 14 insertions(+), 52 deletions(-)

diff --git a/block.c b/block.c
index ab14d52a91..74abdd9a5d 100644
--- a/block.c
+++ b/block.c
@@ -980,10 +980,9 @@ static void bdrv_temp_snapshot_options(int *child_flag=
s, QDict *child_options,
  * Returns the options and flags that a generic child of a BDS should
  * get, based on the given options and flags for the parent BDS.
  */
-static void __attribute__((unused))
-    bdrv_inherited_options(BdrvChildRole role, bool parent_is_format,
-                           int *child_flags, QDict *child_options,
-                           int parent_flags, QDict *parent_options)
+static void bdrv_inherited_options(BdrvChildRole role, bool parent_is_form=
at,
+                                   int *child_flags, QDict *child_options,
+                                   int parent_flags, QDict *parent_options=
)
 {
     int flags =3D parent_flags;
=20
@@ -1068,31 +1067,9 @@ static void bdrv_protocol_options(BdrvChildRole role=
, bool parent_is_format,
                                   int *child_flags, QDict *child_options,
                                   int parent_flags, QDict *parent_options)
 {
-    int flags =3D parent_flags;
-
-    /* Enable protocol handling, disable format probing for bs->file */
-    flags |=3D BDRV_O_PROTOCOL;
-
-    /* If the cache mode isn't explicitly set, inherit direct and no-flush=
 from
-     * the parent. */
-    qdict_copy_default(child_options, parent_options, BDRV_OPT_CACHE_DIREC=
T);
-    qdict_copy_default(child_options, parent_options, BDRV_OPT_CACHE_NO_FL=
USH);
-    qdict_copy_default(child_options, parent_options, BDRV_OPT_FORCE_SHARE=
);
-
-    /* Inherit the read-only option from the parent if it's not set */
-    qdict_copy_default(child_options, parent_options, BDRV_OPT_READ_ONLY);
-    qdict_copy_default(child_options, parent_options, BDRV_OPT_AUTO_READ_O=
NLY);
-
-    /* Our block drivers take care to send flushes and respect unmap polic=
y,
-     * so we can default to enable both on lower layers regardless of the
-     * corresponding parent options. */
-    qdict_set_default_str(child_options, BDRV_OPT_DISCARD, "unmap");
-
-    /* Clear flags that only apply to the top layer */
-    flags &=3D ~(BDRV_O_SNAPSHOT | BDRV_O_NO_BACKING | BDRV_O_COPY_ON_READ=
 |
-               BDRV_O_NO_IO);
-
-    *child_flags =3D flags;
+    bdrv_inherited_options(BDRV_CHILD_IMAGE, true,
+                           child_flags, child_options,
+                           parent_flags, parent_options);
 }
=20
 const BdrvChildClass child_file =3D {
@@ -1119,11 +1096,9 @@ static void bdrv_inherited_fmt_options(BdrvChildRole=
 role,
                                        int *child_flags, QDict *child_opti=
ons,
                                        int parent_flags, QDict *parent_opt=
ions)
 {
-    child_file.inherit_options(role, parent_is_format,
-                               child_flags, child_options,
-                               parent_flags, parent_options);
-
-    *child_flags &=3D ~(BDRV_O_PROTOCOL | BDRV_O_NO_IO);
+    bdrv_inherited_options(BDRV_CHILD_DATA, false,
+                           child_flags, child_options,
+                           parent_flags, parent_options);
 }
=20
 const BdrvChildClass child_format =3D {
@@ -1205,23 +1180,9 @@ static void bdrv_backing_options(BdrvChildRole role,=
 bool parent_is_format,
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
+    bdrv_inherited_options(BDRV_CHILD_COW, true,
+                           child_flags, child_options,
+                           parent_flags, parent_options);
 }
=20
 static int bdrv_backing_update_filename(BdrvChild *c, BlockDriverState *ba=
se,
@@ -3122,7 +3083,8 @@ static BlockDriverState *bdrv_open_inherit(const char=
 *filename,
                                    flags, options);
         /* Let bdrv_backing_options() override "read-only" */
         qdict_del(options, BDRV_OPT_READ_ONLY);
-        bdrv_backing_options(0, true, &flags, options, flags, options);
+        bdrv_inherited_options(BDRV_CHILD_COW, true,
+                               &flags, options, flags, options);
     }
=20
     bs->open_flags =3D flags;
--=20
2.24.1


