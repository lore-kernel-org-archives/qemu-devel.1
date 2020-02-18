Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC3DC34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 14:11:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0A6421D56
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 14:11:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V/hXx/gx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0A6421D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j43aV-0004Rl-VZ
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 09:11:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52814)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1j43Xi-0006s5-7Z
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 09:08:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1j43Xg-0001QZ-Vv
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 09:08:06 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:57985
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1j43Xg-0001Pq-Sv
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 09:08:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582034883;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nkOXPRIsDTQhN6JSN/pT5QywP8scoyncfNOfkExAeFM=;
 b=V/hXx/gxEvbLyroflYsh5Kd6aLNkIlMO4dtHf1BY6Lr63/1f/Iq7EwXOr33ftq+nuFOtu6
 nmt5Uh11LwY2m3eP5DgAtNRwhC5knkAriG0ntTn26hG8SZzyoEgeRxYO6YZBwa68uejE/d
 MKQnvsbkMpYsk2pGOtbi4QBBDvPaGwM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-EXUvw9HlOOWoSm1aVrbcsQ-1; Tue, 18 Feb 2020 09:07:58 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E88561005516;
 Tue, 18 Feb 2020 14:07:55 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-117-181.ams2.redhat.com
 [10.36.117.181])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E5AA28B563;
 Tue, 18 Feb 2020 14:07:54 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 03/36] qcow2: Fix alignment checks in encrypted images
Date: Tue, 18 Feb 2020 15:06:49 +0100
Message-Id: <20200218140722.23876-4-kwolf@redhat.com>
In-Reply-To: <20200218140722.23876-1-kwolf@redhat.com>
References: <20200218140722.23876-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: EXUvw9HlOOWoSm1aVrbcsQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alberto Garcia <berto@igalia.com>

I/O requests to encrypted media should be aligned to the sector size
used by the underlying encryption method, not to BDRV_SECTOR_SIZE.
Fortunately this doesn't break anything at the moment because
both existing QCRYPTO_BLOCK_*_SECTOR_SIZE have the same value as
BDRV_SECTOR_SIZE.

The checks in qcow2_co_preadv_encrypted() are also unnecessary because
they are repeated immediately afterwards in qcow2_co_encdec().

Signed-off-by: Alberto Garcia <berto@igalia.com>
Message-Id: <20200213171646.15876-1-berto@igalia.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow2-threads.c | 12 ++++++++----
 block/qcow2.c         |  2 --
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/block/qcow2-threads.c b/block/qcow2-threads.c
index 8f5a0d1ebe..77bb578cdf 100644
--- a/block/qcow2-threads.c
+++ b/block/qcow2-threads.c
@@ -246,12 +246,15 @@ qcow2_co_encdec(BlockDriverState *bs, uint64_t host_o=
ffset,
         .len =3D len,
         .func =3D func,
     };
+    uint64_t sector_size;
=20
-    assert(QEMU_IS_ALIGNED(guest_offset, BDRV_SECTOR_SIZE));
-    assert(QEMU_IS_ALIGNED(host_offset, BDRV_SECTOR_SIZE));
-    assert(QEMU_IS_ALIGNED(len, BDRV_SECTOR_SIZE));
     assert(s->crypto);
=20
+    sector_size =3D qcrypto_block_get_sector_size(s->crypto);
+    assert(QEMU_IS_ALIGNED(guest_offset, sector_size));
+    assert(QEMU_IS_ALIGNED(host_offset, sector_size));
+    assert(QEMU_IS_ALIGNED(len, sector_size));
+
     return len =3D=3D 0 ? 0 : qcow2_co_process(bs, qcow2_encdec_pool_func,=
 &arg);
 }
=20
@@ -270,7 +273,8 @@ qcow2_co_encdec(BlockDriverState *bs, uint64_t host_off=
set,
  *        will be written to the underlying storage device at
  *        @host_offset
  *
- * @len - length of the buffer (must be a BDRV_SECTOR_SIZE multiple)
+ * @len - length of the buffer (must be a multiple of the encryption
+ *        sector size)
  *
  * Depending on the encryption method, @host_offset and/or @guest_offset
  * may be used for generating the initialization vector for
diff --git a/block/qcow2.c b/block/qcow2.c
index ef96606f8d..8dcee5efec 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2068,8 +2068,6 @@ qcow2_co_preadv_encrypted(BlockDriverState *bs,
         goto fail;
     }
=20
-    assert(QEMU_IS_ALIGNED(offset, BDRV_SECTOR_SIZE));
-    assert(QEMU_IS_ALIGNED(bytes, BDRV_SECTOR_SIZE));
     if (qcow2_co_decrypt(bs,
                          file_cluster_offset + offset_into_cluster(s, offs=
et),
                          offset, buf, bytes) < 0)
--=20
2.20.1


