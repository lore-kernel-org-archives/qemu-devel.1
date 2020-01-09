Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B7FC32771
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 11:12:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBABD20656
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 11:12:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C2zVSGex"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBABD20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipVjl-00086S-1G
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 06:12:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53262)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1ipVhx-0005Wo-3M
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 06:10:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1ipVhv-0006WW-LX
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 06:10:32 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:55849
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ipVhv-0006Ub-FG
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 06:10:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578568230;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3BKwdXPeqAkkgjJfXs2SspNUxdi108NJ8vBtjj44fXY=;
 b=C2zVSGexi2xYD8ior5h7VB9W912K8FK3yJ4Rt+GMpmvLSMqraKFf8Pk6fSrG41o4ADUtCD
 6Odn54d1ysqeILiS3fPSqnNcAc0c0wbzH57PbrtMEjkosNl2Ggf+ukmc6Lk90YXD38fT9v
 sHW6sRH+th8cOpLLh6ukIjc6wVQc2Yg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-KyKxbbOfMl-r6W2tgjrOiA-1; Thu, 09 Jan 2020 06:10:27 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4850D800D48;
 Thu,  9 Jan 2020 11:10:26 +0000 (UTC)
Received: from localhost (unknown [10.36.118.69])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2644660C88;
 Thu,  9 Jan 2020 11:10:21 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/4] luks: implement .bdrv_measure()
Date: Thu,  9 Jan 2020 11:10:10 +0000
Message-Id: <20200109111012.559052-3-stefanha@redhat.com>
In-Reply-To: <20200109111012.559052-1-stefanha@redhat.com>
References: <20200109111012.559052-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: KyKxbbOfMl-r6W2tgjrOiA-1
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add qemu-img measure support in the "luks" block driver.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/crypto.c | 82 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/block/crypto.c b/block/crypto.c
index ed32202fa2..51f37bb1f6 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -548,6 +548,87 @@ static int64_t block_crypto_getlength(BlockDriverState=
 *bs)
 }
=20
=20
+static BlockMeasureInfo *block_crypto_measure(QemuOpts *opts,
+                                              BlockDriverState *in_bs,
+                                              Error **errp)
+{
+    Error *local_err =3D NULL;
+    BlockMeasureInfo *info;
+    uint64_t required =3D 0; /* bytes that contribute to required size */
+    uint64_t virtual_size; /* disk size as seen by guest */
+    size_t luks_payload_size;
+    char *optstr;
+    PreallocMode prealloc;
+
+    optstr =3D qemu_opt_get_del(opts, BLOCK_OPT_PREALLOC);
+    prealloc =3D qapi_enum_parse(&PreallocMode_lookup, optstr,
+                               PREALLOC_MODE_OFF, &local_err);
+    g_free(optstr);
+    if (local_err) {
+        goto err;
+    }
+
+    virtual_size =3D qemu_opt_get_size_del(opts, BLOCK_OPT_SIZE, 0);
+
+    if (!block_crypto_calculate_payload_offset(opts, NULL, &luks_payload_s=
ize,
+                                               &local_err)) {
+        goto err;
+    }
+
+    if (in_bs) {
+        int64_t ssize;
+        int64_t offset;
+        int64_t pnum =3D 0;
+
+        ssize =3D bdrv_getlength(in_bs);
+        if (ssize < 0) {
+            error_setg_errno(&local_err, -ssize,
+                             "Unable to get image virtual_size");
+            goto err;
+        }
+
+        virtual_size =3D ssize;
+
+        for (offset =3D 0; offset < ssize; offset +=3D pnum) {
+            int ret;
+
+            ret =3D bdrv_block_status_above(in_bs, NULL, offset,
+                                          ssize - offset, &pnum, NULL,
+                                          NULL);
+            if (ret < 0) {
+                error_setg_errno(&local_err, -ret,
+                                 "Unable to get block status");
+                goto err;
+            }
+
+            if (ret & BDRV_BLOCK_ZERO) {
+                /* Skip zero regions */
+            } else if ((ret & (BDRV_BLOCK_DATA | BDRV_BLOCK_ALLOCATED)) =
=3D=3D
+                       (BDRV_BLOCK_DATA | BDRV_BLOCK_ALLOCATED)) {
+                /* Count clusters we've seen */
+                required +=3D pnum;
+            }
+        }
+    }
+
+    /* Take into account preallocation.  Nothing special is needed for
+     * PREALLOC_MODE_METADATA since metadata is always counted.
+     */
+    if (prealloc =3D=3D PREALLOC_MODE_FULL || prealloc =3D=3D PREALLOC_MOD=
E_FALLOC) {
+        required =3D virtual_size;
+    }
+
+    info =3D g_new(BlockMeasureInfo, 1);
+    info->fully_allocated =3D luks_payload_size + virtual_size;
+    info->required =3D luks_payload_size + required;
+    return info;
+
+err:
+    error_propagate(errp, local_err);
+    return NULL;
+}
+
+
 static int block_crypto_probe_luks(const uint8_t *buf,
                                    int buf_size,
                                    const char *filename) {
@@ -734,6 +815,7 @@ static BlockDriver bdrv_crypto_luks =3D {
     .bdrv_co_preadv     =3D block_crypto_co_preadv,
     .bdrv_co_pwritev    =3D block_crypto_co_pwritev,
     .bdrv_getlength     =3D block_crypto_getlength,
+    .bdrv_measure       =3D block_crypto_measure,
     .bdrv_get_info      =3D block_crypto_get_info_luks,
     .bdrv_get_specific_info =3D block_crypto_get_specific_info_luks,
=20
--=20
2.24.1


