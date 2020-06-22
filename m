Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 359E9C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 15:17:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2CC6206FA
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 15:17:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iWkTh4ci"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2CC6206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnOCr-0003JJ-N9
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 11:17:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51056)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jnO79-0000s8-Jo
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 11:12:04 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:45881
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jnO77-00064c-6p
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 11:12:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592838719;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gj98eBMjQ8Y9gSHoOf1w2VXvi0IRo7VNE0AcsD+Z034=;
 b=iWkTh4ci0L9irh6cWFZdq/wAHSkAEo24YEK58qpeI6TD6xzdA2HFo8L7gzrjtv8gDXC3XM
 tDGqkYjek8M+jeRlcTjmwl+beYmBgTG13GcBceLfbCELq34AhKyqbKyL9/uDV5H/Q+9+cx
 +G/bLyBxUIu02a/KPzHDtXSOqzc8Pzo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-317-UdLdP6YhMyWCryBllxflmg-1; Mon, 22 Jun 2020 11:11:36 -0400
X-MC-Unique: UdLdP6YhMyWCryBllxflmg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9AF641083E89;
 Mon, 22 Jun 2020 15:11:35 +0000 (UTC)
Received: from localhost (ovpn-114-85.ams2.redhat.com [10.36.114.85])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 34E3271676;
 Mon, 22 Jun 2020 15:11:35 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 14/18] block/crypto: implement blockdev-amend
Date: Mon, 22 Jun 2020 17:10:55 +0200
Message-Id: <20200622151059.921191-15-mreitz@redhat.com>
In-Reply-To: <20200622151059.921191-1-mreitz@redhat.com>
References: <20200622151059.921191-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 02:57:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Maxim Levitsky <mlevitsk@redhat.com>

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-Id: <20200608094030.670121-13-mlevitsk@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qapi/block-core.json | 14 ++++++++-
 block/crypto.c       | 72 ++++++++++++++++++++++++++++++++------------
 2 files changed, 66 insertions(+), 20 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index c22996282f..cd679ad435 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -4674,6 +4674,18 @@
   'data': { 'job-id': 'str',
             'options': 'BlockdevCreateOptions' } }
 
+##
+# @BlockdevAmendOptionsLUKS:
+#
+# Driver specific image amend options for LUKS.
+#
+# Since: 5.1
+##
+{ 'struct': 'BlockdevAmendOptionsLUKS',
+  'base': 'QCryptoBlockAmendOptionsLUKS',
+  'data': { }
+}
+
 ##
 # @BlockdevAmendOptions:
 #
@@ -4688,7 +4700,7 @@
       'driver':         'BlockdevDriver' },
   'discriminator': 'driver',
   'data': {
-  } }
+      'luks':           'BlockdevAmendOptionsLUKS' } }
 
 ##
 # @x-blockdev-amend:
diff --git a/block/crypto.c b/block/crypto.c
index b9c40e6922..3fbd68832b 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -791,32 +791,21 @@ block_crypto_get_specific_info_luks(BlockDriverState *bs, Error **errp)
 }
 
 static int
-block_crypto_amend_options_luks(BlockDriverState *bs,
-                                QemuOpts *opts,
-                                BlockDriverAmendStatusCB *status_cb,
-                                void *cb_opaque,
-                                bool force,
-                                Error **errp)
+block_crypto_amend_options_generic_luks(BlockDriverState *bs,
+                                        QCryptoBlockAmendOptions *amend_options,
+                                        bool force,
+                                        Error **errp)
 {
     BlockCrypto *crypto = bs->opaque;
-    QDict *cryptoopts = NULL;
-    QCryptoBlockAmendOptions *amend_options = NULL;
     int ret;
 
     assert(crypto);
     assert(crypto->block);
-    crypto->updating_keys = true;
 
+    /* apply for exclusive read/write permissions to the underlying file*/
+    crypto->updating_keys = true;
     ret = bdrv_child_refresh_perms(bs, bs->file, errp);
-    if (ret < 0) {
-        goto cleanup;
-    }
-
-    cryptoopts = qemu_opts_to_qdict(opts, NULL);
-    qdict_put_str(cryptoopts, "format", "luks");
-    amend_options = block_crypto_amend_opts_init(cryptoopts, errp);
-    if (!amend_options) {
-        ret = -EINVAL;
+    if (ret) {
         goto cleanup;
     }
 
@@ -828,13 +817,57 @@ block_crypto_amend_options_luks(BlockDriverState *bs,
                                       force,
                                       errp);
 cleanup:
+    /* release exclusive read/write permissions to the underlying file*/
     crypto->updating_keys = false;
     bdrv_child_refresh_perms(bs, bs->file, errp);
-    qapi_free_QCryptoBlockAmendOptions(amend_options);
+    return ret;
+}
+
+static int
+block_crypto_amend_options_luks(BlockDriverState *bs,
+                                QemuOpts *opts,
+                                BlockDriverAmendStatusCB *status_cb,
+                                void *cb_opaque,
+                                bool force,
+                                Error **errp)
+{
+    BlockCrypto *crypto = bs->opaque;
+    QDict *cryptoopts = NULL;
+    QCryptoBlockAmendOptions *amend_options = NULL;
+    int ret = -EINVAL;
+
+    assert(crypto);
+    assert(crypto->block);
+
+    cryptoopts = qemu_opts_to_qdict(opts, NULL);
+    qdict_put_str(cryptoopts, "format", "luks");
+    amend_options = block_crypto_amend_opts_init(cryptoopts, errp);
     qobject_unref(cryptoopts);
+    if (!amend_options) {
+        goto cleanup;
+    }
+    ret = block_crypto_amend_options_generic_luks(bs, amend_options,
+                                                  force, errp);
+cleanup:
+    qapi_free_QCryptoBlockAmendOptions(amend_options);
     return ret;
 }
 
+static int
+coroutine_fn block_crypto_co_amend_luks(BlockDriverState *bs,
+                                        BlockdevAmendOptions *opts,
+                                        bool force,
+                                        Error **errp)
+{
+    QCryptoBlockAmendOptions amend_opts;
+
+    amend_opts = (QCryptoBlockAmendOptions) {
+        .format = Q_CRYPTO_BLOCK_FORMAT_LUKS,
+        .u.luks = *qapi_BlockdevAmendOptionsLUKS_base(&opts->u.luks),
+    };
+    return block_crypto_amend_options_generic_luks(bs, &amend_opts,
+                                                   force, errp);
+}
 
 static void
 block_crypto_child_perms(BlockDriverState *bs, BdrvChild *c,
@@ -910,6 +943,7 @@ static BlockDriver bdrv_crypto_luks = {
     .bdrv_get_info      = block_crypto_get_info_luks,
     .bdrv_get_specific_info = block_crypto_get_specific_info_luks,
     .bdrv_amend_options = block_crypto_amend_options_luks,
+    .bdrv_co_amend      = block_crypto_co_amend_luks,
 
     .is_format          = true,
 
-- 
2.26.2


