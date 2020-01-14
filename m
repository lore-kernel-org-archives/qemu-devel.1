Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAC80C33C9E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 19:41:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8929B24655
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 19:41:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LIy4w+9z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8929B24655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irS3y-0002He-2N
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 14:41:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38528)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1irRya-0003b7-JV
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 14:35:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1irRyW-00080G-Kb
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 14:35:44 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55045
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1irRyW-0007zv-Gb
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 14:35:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579030540;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=izlfqHc08rG9gHbMwis+3j53B7tLvK5Fku3G4K6KUXI=;
 b=LIy4w+9zV6FeMwO2ue/MEsv5j5ZgehcUKmcUrTtuvbQTaq00ZI9/zPEJ9LH9n+r03ycsDg
 8RNyBzG6vCIWnZAUJiHxIN6PCR5QXwbRMGEOIWdpuc1a9HGziCH2hk/p2jv2rWVLwpRODD
 oC1i7ZeIqGWQTKAaiuiUt9CWDhMrM+E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-5_ds7tx_POK8wwztIMbbIg-1; Tue, 14 Jan 2020 14:34:35 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2E63A800D41;
 Tue, 14 Jan 2020 19:34:34 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.41])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7D52D7C83A;
 Tue, 14 Jan 2020 19:34:29 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 12/13] block/qcow2: implement blockdev-amend
Date: Tue, 14 Jan 2020 21:33:49 +0200
Message-Id: <20200114193350.10830-13-mlevitsk@redhat.com>
In-Reply-To: <20200114193350.10830-1-mlevitsk@redhat.com>
References: <20200114193350.10830-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: 5_ds7tx_POK8wwztIMbbIg-1
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently the implementation only supports amending the encryption
options, unlike the qemu-img version

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 block/qcow2.c        | 39 +++++++++++++++++++++++++++++++++++++++
 qapi/block-core.json | 16 +++++++++++++++-
 2 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 1b01174aed..8b74471bc6 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -5444,6 +5444,44 @@ static int qcow2_amend_options(BlockDriverState *bs,=
 QemuOpts *opts,
     return 0;
 }
=20
+static int coroutine_fn qcow2_co_amend(BlockDriverState *bs,
+                                       BlockdevAmendOptions *opts,
+                                       bool force,
+                                       Error **errp)
+{
+    BlockdevAmendOptionsQcow2 *qopts =3D &opts->u.qcow2;
+    BDRVQcow2State *s =3D bs->opaque;
+    int ret =3D 0;
+
+    if (qopts->has_encrypt) {
+        if (!s->crypto) {
+            error_setg(errp, "image is not encrypted, can't amend");
+            return -EOPNOTSUPP;
+        }
+
+        if (qopts->encrypt->format !=3D Q_CRYPTO_BLOCK_FORMAT_LUKS) {
+            error_setg(errp,
+                       "Amend can't be used to change the qcow2 encryption=
 format");
+            return -EOPNOTSUPP;
+        }
+
+        if (s->crypt_method_header !=3D QCOW_CRYPT_LUKS) {
+            error_setg(errp,
+                       "Only LUKS encryption options can be amended for qc=
ow2 with blockdev-amend");
+            return -EOPNOTSUPP;
+        }
+
+        ret =3D qcrypto_block_amend_options(s->crypto,
+                                          qcow2_crypto_hdr_read_func,
+                                          qcow2_crypto_hdr_write_func,
+                                          bs,
+                                          qopts->encrypt,
+                                          force,
+                                          errp);
+    }
+    return ret;
+}
+
 /*
  * If offset or size are negative, respectively, they will not be included=
 in
  * the BLOCK_IMAGE_CORRUPTED event emitted.
@@ -5656,6 +5694,7 @@ BlockDriver bdrv_qcow2 =3D {
     .mutable_opts        =3D mutable_opts,
     .bdrv_co_check       =3D qcow2_co_check,
     .bdrv_amend_options  =3D qcow2_amend_options,
+    .bdrv_co_amend       =3D qcow2_co_amend,
=20
     .bdrv_detach_aio_context  =3D qcow2_detach_aio_context,
     .bdrv_attach_aio_context  =3D qcow2_attach_aio_context,
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 790aa40991..2cf1f443e5 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -4755,6 +4755,19 @@
   'data': { }
 }
=20
+##
+# @BlockdevAmendOptionsQcow2:
+#
+# Driver specific image amend options for qcow2.
+# For now, only encryption options can be amended
+#
+# @encrypt          Encryption options to be amended
+#
+# Since: 5.0
+##
+{ 'struct': 'BlockdevAmendOptionsQcow2',
+  'data': { '*encrypt':         'QCryptoBlockAmendOptions' } }
+
 ##
 # @BlockdevAmendOptions:
 #
@@ -4769,7 +4782,8 @@
       'driver':         'BlockdevDriver' },
   'discriminator': 'driver',
   'data': {
-      'luks':           'BlockdevAmendOptionsLUKS' } }
+      'luks':           'BlockdevAmendOptionsLUKS',
+      'qcow2':          'BlockdevAmendOptionsQcow2' } }
=20
 ##
 # @x-blockdev-amend:
--=20
2.17.2


