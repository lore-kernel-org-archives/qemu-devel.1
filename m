Return-Path: <SRS0=KEGy=6R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B804C28CBC
	for <qemu-devel@archiver.kernel.org>; Sun,  3 May 2020 18:49:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5C5A206E9
	for <qemu-devel@archiver.kernel.org>; Sun,  3 May 2020 18:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qe2rMv5e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5C5A206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVJgV-0005OB-3A
	for qemu-devel@archiver.kernel.org; Sun, 03 May 2020 14:49:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59774)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jVJb5-000455-Kz
 for qemu-devel@nongnu.org; Sun, 03 May 2020 14:44:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42713
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jVJb3-0000Kq-K7
 for qemu-devel@nongnu.org; Sun, 03 May 2020 14:44:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588531452;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o450tvAR6DN72VeXuYF/wxV0rQiNozrUPlJWj3RTe0M=;
 b=Qe2rMv5ebQiHo+GQzA6NyFWSrA6TYSRwgw6nz9qXPU0uMYRmnZJnmZzn+WmO0NyiGfAJTo
 LTfRwyY18lCB8ACcRgJKQvRnPnbgvWu7NZ6vr6rjxh3ZkZogLhlJj9LU721ErqOfJMSlQs
 K9K6zZ5DxE7vZmGms5cF/ID8FGJqmTE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-366-8UrsFDDmNu2X2X7T9Zjxvw-1; Sun, 03 May 2020 14:44:05 -0400
X-MC-Unique: 8UrsFDDmNu2X2X7T9Zjxvw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B09581800D4A;
 Sun,  3 May 2020 18:44:04 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.195])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6BBEF5C1B2;
 Sun,  3 May 2020 18:44:02 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 13/14] block/qcow2: implement blockdev-amend
Date: Sun,  3 May 2020 21:43:23 +0300
Message-Id: <20200503184324.12506-14-mlevitsk@redhat.com>
In-Reply-To: <20200503184324.12506-1-mlevitsk@redhat.com>
References: <20200503184324.12506-1-mlevitsk@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/03 12:49:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 block/qcow2.c        | 39 +++++++++++++++++++++++++++++++++++++++
 qapi/block-core.json | 16 +++++++++++++++-
 2 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index ce1e25f341..a770b88a8f 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -5448,6 +5448,44 @@ static int qcow2_amend_options(BlockDriverState *bs,=
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
@@ -5658,6 +5696,7 @@ BlockDriver bdrv_qcow2 =3D {
     .mutable_opts        =3D mutable_opts,
     .bdrv_co_check       =3D qcow2_co_check,
     .bdrv_amend_options  =3D qcow2_amend_options,
+    .bdrv_co_amend       =3D qcow2_co_amend,
=20
     .bdrv_detach_aio_context  =3D qcow2_detach_aio_context,
     .bdrv_attach_aio_context  =3D qcow2_attach_aio_context,
diff --git a/qapi/block-core.json b/qapi/block-core.json
index a5f679ac17..0ffdc1c3d4 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -4661,6 +4661,19 @@
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
@@ -4675,7 +4688,8 @@
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


