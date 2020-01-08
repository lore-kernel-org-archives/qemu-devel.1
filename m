Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B651C33C9E
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 11:23:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD4BA206DB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 11:23:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SNCa0sXk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD4BA206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip9RK-0005dy-Ot
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 06:23:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49731)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1ip9Q6-0003wq-Dg
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 06:22:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1ip9Q5-0004ZD-BE
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 06:22:38 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34017
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ip9Q5-0004Yb-7U
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 06:22:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578482556;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tf7eP6Hlno3E/cmbBYUVQX7SDxz/E3HxyT8pTZXeJF8=;
 b=SNCa0sXkIKH/+8aJoVfhzfPqmE5uA0k1/Z/W2kCn/6GagznIEElc6jlR3BXpi+K8zPSkBS
 js5LBuTc3tCnvTXnSY+Kk5y4/z6OUU72+rbSPEdl8wKXzn3ew9Bm4Vxccq2XBRUmy8UjBR
 q6WSclaronnlFmct93V2BA9dTWIkoqk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-nXH0xA89OK2-Gxbnmrc6YQ-1; Wed, 08 Jan 2020 06:22:35 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 99D73801E7A;
 Wed,  8 Jan 2020 11:22:34 +0000 (UTC)
Received: from localhost (ovpn-116-249.ams2.redhat.com [10.36.116.249])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E076F3A2;
 Wed,  8 Jan 2020 11:22:30 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/4] luks: implement .bdrv_measure()
Date: Wed,  8 Jan 2020 11:22:18 +0000
Message-Id: <20200108112220.499180-3-stefanha@redhat.com>
In-Reply-To: <20200108112220.499180-1-stefanha@redhat.com>
References: <20200108112220.499180-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: nXH0xA89OK2-Gxbnmrc6YQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
index ed32202fa2..94a24210ab 100644
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
+    uint64_t luks_payload_size;
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


