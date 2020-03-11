Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2268C10F27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 13:58:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8012721D56
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 13:58:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S/rSLpci"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8012721D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC1sr-0000z1-M0
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 09:58:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36008)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jC1mi-0003ez-CT
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 09:52:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1jC1md-0002Ei-8k
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 09:52:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38265
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1jC1md-0002Ds-3h
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 09:52:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583934745;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CnZJ4bZfLKCfJ7MiH+BGb4mcoIz52XTg0VJCr+4eAvM=;
 b=S/rSLpciTovRYqgODe4E9oGjTVcMQWP1k2yFDbcmXYEhoIP+KhJhTCHj6hPR35n6NfKOR0
 DsoGqIVsXzSPS2CC8qt0BaVEo2LPhD2k1TLFdZmS1SghgiQtwmJNH6QP/hI8aoJlB/B7Qf
 gvynugi9tty2/giZRzvpZm8q7QGWWTg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-55-oOWCA6IlPc6poYywWlaWjQ-1; Wed, 11 Mar 2020 09:52:23 -0400
X-MC-Unique: oOWCA6IlPc6poYywWlaWjQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0DD21800D5B;
 Wed, 11 Mar 2020 13:52:22 +0000 (UTC)
Received: from localhost (ovpn-117-216.ams2.redhat.com [10.36.117.216])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A200460C99;
 Wed, 11 Mar 2020 13:52:21 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 02/19] luks: implement .bdrv_measure()
Date: Wed, 11 Mar 2020 14:51:56 +0100
Message-Id: <20200311135213.1242028-3-mreitz@redhat.com>
In-Reply-To: <20200311135213.1242028-1-mreitz@redhat.com>
References: <20200311135213.1242028-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefan Hajnoczi <stefanha@redhat.com>

Add qemu-img measure support in the "luks" block driver.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-Id: <20200221112522.1497712-3-stefanha@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/crypto.c | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/block/crypto.c b/block/crypto.c
index 24823835c1..23e9c74d6f 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -484,6 +484,67 @@ static int64_t block_crypto_getlength(BlockDriverState=
 *bs)
 }
=20
=20
+static BlockMeasureInfo *block_crypto_measure(QemuOpts *opts,
+                                              BlockDriverState *in_bs,
+                                              Error **errp)
+{
+    g_autoptr(QCryptoBlockCreateOptions) create_opts =3D NULL;
+    Error *local_err =3D NULL;
+    BlockMeasureInfo *info;
+    uint64_t size;
+    size_t luks_payload_size;
+    QDict *cryptoopts;
+
+    /*
+     * Preallocation mode doesn't affect size requirements but we must con=
sume
+     * the option.
+     */
+    g_free(qemu_opt_get_del(opts, BLOCK_OPT_PREALLOC));
+
+    size =3D qemu_opt_get_size_del(opts, BLOCK_OPT_SIZE, 0);
+
+    if (in_bs) {
+        int64_t ssize =3D bdrv_getlength(in_bs);
+
+        if (ssize < 0) {
+            error_setg_errno(&local_err, -ssize,
+                             "Unable to get image virtual_size");
+            goto err;
+        }
+
+        size =3D ssize;
+    }
+
+    cryptoopts =3D qemu_opts_to_qdict_filtered(opts, NULL,
+            &block_crypto_create_opts_luks, true);
+    qdict_put_str(cryptoopts, "format", "luks");
+    create_opts =3D block_crypto_create_opts_init(cryptoopts, &local_err);
+    qobject_unref(cryptoopts);
+    if (!create_opts) {
+        goto err;
+    }
+
+    if (!qcrypto_block_calculate_payload_offset(create_opts, NULL,
+                                                &luks_payload_size,
+                                                &local_err)) {
+        goto err;
+    }
+
+    /*
+     * Unallocated blocks are still encrypted so allocation status makes n=
o
+     * difference to the file size.
+     */
+    info =3D g_new(BlockMeasureInfo, 1);
+    info->fully_allocated =3D luks_payload_size + size;
+    info->required =3D luks_payload_size + size;
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
@@ -670,6 +731,7 @@ static BlockDriver bdrv_crypto_luks =3D {
     .bdrv_co_preadv     =3D block_crypto_co_preadv,
     .bdrv_co_pwritev    =3D block_crypto_co_pwritev,
     .bdrv_getlength     =3D block_crypto_getlength,
+    .bdrv_measure       =3D block_crypto_measure,
     .bdrv_get_info      =3D block_crypto_get_info_luks,
     .bdrv_get_specific_info =3D block_crypto_get_specific_info_luks,
=20
--=20
2.24.1


