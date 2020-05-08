Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF2CC38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 12:53:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 145BC24963
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 12:53:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MXf+3dqK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 145BC24963
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX2VK-0002rv-7K
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 08:53:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49506)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jX2Kj-0000Mf-AF
 for qemu-devel@nongnu.org; Fri, 08 May 2020 08:42:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28124
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jX2Kc-0000C2-QI
 for qemu-devel@nongnu.org; Fri, 08 May 2020 08:42:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588941742;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hnbb/sx78Ba81Y4kHzeVy4wmoW2WdPmnhMhUpgQwPnI=;
 b=MXf+3dqKsJQw+JsjjoGlusUm14EBSiQwi+OxItsP7OXhjmTQ803OwnAegp4Dadx9WQzA+v
 oYLWLXl5fNVuZeRaHOu60Wngcl0V78TDbomPqrxf8IKu8R4GIws7WdHX4xsHwYTY57ADbb
 skFzt+YXumGwrLMxftcZmrsIyzXEM+8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-eU7RytmvMuuigsPRCP8Xnw-1; Fri, 08 May 2020 08:42:20 -0400
X-MC-Unique: eU7RytmvMuuigsPRCP8Xnw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 087FF800687;
 Fri,  8 May 2020 12:42:19 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-113-190.ams2.redhat.com
 [10.36.113.190])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 064AC19167;
 Fri,  8 May 2020 12:42:17 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 28/30] parallels: Rework truncation logic
Date: Fri,  8 May 2020 14:41:33 +0200
Message-Id: <20200508124135.252565-29-kwolf@redhat.com>
In-Reply-To: <20200508124135.252565-1-kwolf@redhat.com>
References: <20200508124135.252565-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/08 02:23:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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

From: Eric Blake <eblake@redhat.com>

The parallels driver tries to use truncation for image growth, but can
only do so when reads are guaranteed as zero.  Now that we have a way
to request zero contents from truncation, we can defer the decision to
actual allocation attempts rather than up front, reducing the number
of places that still use bdrv_has_zero_init_truncate.

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20200428202905.770727-8-eblake@redhat.com>
Reviewed-by: Denis V. Lunev <den@openvz.org>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/parallels.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index 8db64a55e3..e7717c508e 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -166,7 +166,7 @@ static int64_t block_status(BDRVParallelsState *s, int6=
4_t sector_num,
 static int64_t allocate_clusters(BlockDriverState *bs, int64_t sector_num,
                                  int nb_sectors, int *pnum)
 {
-    int ret;
+    int ret =3D 0;
     BDRVParallelsState *s =3D bs->opaque;
     int64_t pos, space, idx, to_allocate, i, len;
=20
@@ -196,14 +196,24 @@ static int64_t allocate_clusters(BlockDriverState *bs=
, int64_t sector_num,
     }
     if (s->data_end + space > (len >> BDRV_SECTOR_BITS)) {
         space +=3D s->prealloc_size;
+        /*
+         * We require the expanded size to read back as zero. If the
+         * user permitted truncation, we try that; but if it fails, we
+         * force the safer-but-slower fallocate.
+         */
+        if (s->prealloc_mode =3D=3D PRL_PREALLOC_MODE_TRUNCATE) {
+            ret =3D bdrv_truncate(bs->file,
+                                (s->data_end + space) << BDRV_SECTOR_BITS,
+                                false, PREALLOC_MODE_OFF, BDRV_REQ_ZERO_WR=
ITE,
+                                NULL);
+            if (ret =3D=3D -ENOTSUP) {
+                s->prealloc_mode =3D PRL_PREALLOC_MODE_FALLOCATE;
+            }
+        }
         if (s->prealloc_mode =3D=3D PRL_PREALLOC_MODE_FALLOCATE) {
             ret =3D bdrv_pwrite_zeroes(bs->file,
                                      s->data_end << BDRV_SECTOR_BITS,
                                      space << BDRV_SECTOR_BITS, 0);
-        } else {
-            ret =3D bdrv_truncate(bs->file,
-                                (s->data_end + space) << BDRV_SECTOR_BITS,
-                                false, PREALLOC_MODE_OFF, 0, NULL);
         }
         if (ret < 0) {
             return ret;
@@ -828,6 +838,7 @@ static int parallels_open(BlockDriverState *bs, QDict *=
options, int flags,
         qemu_opt_get_size_del(opts, PARALLELS_OPT_PREALLOC_SIZE, 0);
     s->prealloc_size =3D MAX(s->tracks, s->prealloc_size >> BDRV_SECTOR_BI=
TS);
     buf =3D qemu_opt_get_del(opts, PARALLELS_OPT_PREALLOC_MODE);
+    /* prealloc_mode can be downgraded later during allocate_clusters */
     s->prealloc_mode =3D qapi_enum_parse(&prealloc_mode_lookup, buf,
                                        PRL_PREALLOC_MODE_FALLOCATE,
                                        &local_err);
@@ -836,10 +847,6 @@ static int parallels_open(BlockDriverState *bs, QDict =
*options, int flags,
         goto fail_options;
     }
=20
-    if (!bdrv_has_zero_init_truncate(bs->file->bs)) {
-        s->prealloc_mode =3D PRL_PREALLOC_MODE_FALLOCATE;
-    }
-
     if ((flags & BDRV_O_RDWR) && !(flags & BDRV_O_INACTIVE)) {
         s->header->inuse =3D cpu_to_le32(HEADER_INUSE_MAGIC);
         ret =3D parallels_update_header(bs);
--=20
2.25.3


