Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7144C5DF60
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 14:40:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9164B214D8
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 14:40:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VdWxdVYt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9164B214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSixk-000116-AS
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 09:40:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48869)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iSirP-0002kH-KH
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 09:34:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iSirO-0004dI-C9
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 09:34:07 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:45578
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iSirO-0004cy-8F
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 09:34:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573137245;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QQoys9Fp0rlvDcgt58MGNDgLRHS46GURBKcm4JuCSHU=;
 b=VdWxdVYtrPHkKT9pfmCa29jGilQAeHBObswFwvzLCfxe6vdgSsc6mYX1zQAOgoPJxZm+Sj
 +bKUP114EY5SAUN76aiU7/AlXEuWuCSeABh46XCG7euegSV1Y3JGR0jjdHGyE1dLzulmDX
 jzFrz7TIZBBg7EsANVOjn28KGM6Aqf0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-zzj2RgM_OkmHGktzGrPFyg-1; Thu, 07 Nov 2019 09:34:02 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 01017800EB3;
 Thu,  7 Nov 2019 14:34:01 +0000 (UTC)
Received: from localhost (ovpn-117-149.ams2.redhat.com [10.36.117.149])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 96BB45DA7C;
 Thu,  7 Nov 2019 14:34:00 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 1/3] qcow2-bitmap: Fix uint64_t left-shift overflow
Date: Thu,  7 Nov 2019 15:33:54 +0100
Message-Id: <20191107143356.579334-2-mreitz@redhat.com>
In-Reply-To: <20191107143356.579334-1-mreitz@redhat.com>
References: <20191107143356.579334-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: zzj2RgM_OkmHGktzGrPFyg-1
X-Mimecast-Spam-Score: 0
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-stable@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Tuguoyi <tu.guoyi@h3c.com>

There are two issues in In check_constraints_on_bitmap(),
1) The sanity check on the granularity will cause uint64_t
integer left-shift overflow when cluster_size is 2M and the
granularity is BIGGER than 32K.
2) The way to calculate image size that the maximum bitmap
supported can map to is a bit incorrect.
This patch fix it by add a helper function to calculate the
number of bytes needed by a normal bitmap in image and compare
it to the maximum bitmap bytes supported by qemu.

Fixes: 5f72826e7fc62167cf3a
Signed-off-by: Guoyi Tu <tu.guoyi@h3c.com>
Message-id: 4ba40cd1e7ee4a708b40899952e49f22@h3c.com
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2-bitmap.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index 98294a7696..ef9ef628a0 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -142,6 +142,13 @@ static int check_table_entry(uint64_t entry, int clust=
er_size)
     return 0;
 }
=20
+static int64_t get_bitmap_bytes_needed(int64_t len, uint32_t granularity)
+{
+    int64_t num_bits =3D DIV_ROUND_UP(len, granularity);
+
+    return DIV_ROUND_UP(num_bits, 8);
+}
+
 static int check_constraints_on_bitmap(BlockDriverState *bs,
                                        const char *name,
                                        uint32_t granularity,
@@ -150,6 +157,7 @@ static int check_constraints_on_bitmap(BlockDriverState=
 *bs,
     BDRVQcow2State *s =3D bs->opaque;
     int granularity_bits =3D ctz32(granularity);
     int64_t len =3D bdrv_getlength(bs);
+    int64_t bitmap_bytes;
=20
     assert(granularity > 0);
     assert((granularity & (granularity - 1)) =3D=3D 0);
@@ -171,9 +179,9 @@ static int check_constraints_on_bitmap(BlockDriverState=
 *bs,
         return -EINVAL;
     }
=20
-    if ((len > (uint64_t)BME_MAX_PHYS_SIZE << granularity_bits) ||
-        (len > (uint64_t)BME_MAX_TABLE_SIZE * s->cluster_size <<
-               granularity_bits))
+    bitmap_bytes =3D get_bitmap_bytes_needed(len, granularity);
+    if ((bitmap_bytes > (uint64_t)BME_MAX_PHYS_SIZE) ||
+        (bitmap_bytes > (uint64_t)BME_MAX_TABLE_SIZE * s->cluster_size))
     {
         error_setg(errp, "Too much space will be occupied by the bitmap. "
                    "Use larger granularity");
--=20
2.23.0


