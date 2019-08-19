Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F88C3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 16:23:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A24022CE3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 16:23:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A24022CE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzkR8-000065-3S
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 12:23:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35235)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1hzkLg-0002gg-Bf
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 12:17:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hzkLf-0006E0-Bu
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 12:17:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42422)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hzkLd-0006CB-4R; Mon, 19 Aug 2019 12:17:33 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 347661FAA69;
 Mon, 19 Aug 2019 16:17:32 +0000 (UTC)
Received: from localhost (ovpn-204-64.brq.redhat.com [10.40.204.64])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 64822863A0;
 Mon, 19 Aug 2019 16:17:31 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Mon, 19 Aug 2019 18:17:08 +0200
Message-Id: <20190819161723.7746-3-mreitz@redhat.com>
In-Reply-To: <20190819161723.7746-1-mreitz@redhat.com>
References: <20190819161723.7746-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.71]); Mon, 19 Aug 2019 16:17:32 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 02/17] qemu-img: Fix bdrv_has_zero_init() use in
 convert
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

bdrv_has_zero_init() only has meaning for newly created images or image
areas.  If qemu-img convert did not create the image itself, it cannot
rely on bdrv_has_zero_init()'s result to carry any meaning.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-id: 20190724171239.8764-2-mreitz@redhat.com
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qemu-img.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index c920e3564c..7daa05e51a 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -1578,6 +1578,7 @@ typedef struct ImgConvertState {
     bool has_zero_init;
     bool compressed;
     bool unallocated_blocks_are_zero;
+    bool target_is_new;
     bool target_has_backing;
     int64_t target_backing_sectors; /* negative if unknown */
     bool wr_in_order;
@@ -1975,9 +1976,11 @@ static int convert_do_copy(ImgConvertState *s)
     int64_t sector_num =3D 0;
=20
     /* Check whether we have zero initialisation or can get it efficient=
ly */
-    s->has_zero_init =3D s->min_sparse && !s->target_has_backing
-                     ? bdrv_has_zero_init(blk_bs(s->target))
-                     : false;
+    if (s->target_is_new && s->min_sparse && !s->target_has_backing) {
+        s->has_zero_init =3D bdrv_has_zero_init(blk_bs(s->target));
+    } else {
+        s->has_zero_init =3D false;
+    }
=20
     if (!s->has_zero_init && !s->target_has_backing &&
         bdrv_can_write_zeroes_with_unmap(blk_bs(s->target)))
@@ -2428,6 +2431,8 @@ static int img_convert(int argc, char **argv)
         }
     }
=20
+    s.target_is_new =3D !skip_create;
+
     flags =3D s.min_sparse ? (BDRV_O_RDWR | BDRV_O_UNMAP) : BDRV_O_RDWR;
     ret =3D bdrv_parse_cache_mode(cache, &flags, &writethrough);
     if (ret < 0) {
--=20
2.21.0


