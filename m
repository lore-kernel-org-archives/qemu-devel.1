Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E1F4C4CEC7
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 22:42:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E09E20830
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 22:42:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E09E20830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8XnK-0003xJ-IF
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 18:42:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42073)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1i8XcW-0008Aw-6I
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 18:31:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1i8XcU-00060f-RH
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 18:31:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41070)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1i8XcS-0005y8-6l; Thu, 12 Sep 2019 18:31:16 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 86EECC065121;
 Thu, 12 Sep 2019 22:31:15 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 492C65C1B2;
 Thu, 12 Sep 2019 22:31:13 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 13 Sep 2019 01:30:26 +0300
Message-Id: <20190912223028.18496-10-mlevitsk@redhat.com>
In-Reply-To: <20190912223028.18496-1-mlevitsk@redhat.com>
References: <20190912223028.18496-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Thu, 12 Sep 2019 22:31:15 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 09/11] block/qcow2: implement blockdev-amend
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

Currently only for changing crypto parameters

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 block/qcow2.c        | 71 ++++++++++++++++++++++++++++++++++++++++++++
 qapi/block-core.json |  6 ++--
 2 files changed, 75 insertions(+), 2 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 26f83aeb44..c8847ec6e2 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3079,6 +3079,18 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
     assert(create_options->driver == BLOCKDEV_DRIVER_QCOW2);
     qcow2_opts = &create_options->u.qcow2;
 
+    if (!qcow2_opts->has_size) {
+        error_setg(errp, "Size is manadatory for image creation");
+        return -EINVAL;
+
+    }
+
+    if (!qcow2_opts->has_file) {
+        error_setg(errp, "'file' is manadatory for image creation");
+        return -EINVAL;
+
+    }
+
     bs = bdrv_open_blockdev_ref(qcow2_opts->file, errp);
     if (bs == NULL) {
         return -EIO;
@@ -5111,6 +5123,64 @@ static int qcow2_amend_options(BlockDriverState *bs, QemuOpts *opts,
     return 0;
 }
 
+
+static int coroutine_fn qcow2_co_amend(BlockDriverState *bs,
+                                       BlockdevCreateOptions *opts,
+                                       bool force,
+                                       Error **errp)
+{
+    BlockdevCreateOptionsQcow2 *qopts = &opts->u.qcow2;
+    BDRVQcow2State *s = bs->opaque;
+    int ret;
+
+    /*
+     * This is ugly as hell, in later versions of this patch
+     * something has to be done about this
+     */
+    if (qopts->has_file || qopts->has_size || qopts->has_data_file ||
+        qopts->has_data_file_raw || qopts->has_version ||
+        qopts->has_backing_file || qopts->has_backing_fmt ||
+        qopts->has_cluster_size || qopts->has_preallocation ||
+        qopts->has_lazy_refcounts || qopts->has_refcount_bits) {
+
+        error_setg(errp,
+                "Only LUKS encryption options can be amended for qcow2 with blockdev-amend");
+        return -EOPNOTSUPP;
+
+    }
+
+    if (qopts->has_encrypt) {
+        if (!s->crypto) {
+            error_setg(errp, "QCOW2 image is not encrypted, can't amend");
+            return -EOPNOTSUPP;
+        }
+
+        if (qopts->encrypt->format != Q_CRYPTO_BLOCK_FORMAT_LUKS) {
+            error_setg(errp,
+                       "Amend can't be used to change the qcow2 encryption format");
+            return -EOPNOTSUPP;
+        }
+
+        if (s->crypt_method_header != QCOW_CRYPT_LUKS) {
+            error_setg(errp,
+                       "Only LUKS encryption options can be amended for qcow2 with blockdev-amend");
+            return -EOPNOTSUPP;
+        }
+
+        ret = qcrypto_block_amend_options(s->crypto,
+                                          qcow2_crypto_hdr_read_func,
+                                          qcow2_crypto_hdr_write_func,
+                                          bs,
+                                          qopts->encrypt,
+                                          force,
+                                          errp);
+        if (ret) {
+            return ret;
+        }
+    }
+    return 0;
+}
+
 /*
  * If offset or size are negative, respectively, they will not be included in
  * the BLOCK_IMAGE_CORRUPTED event emitted.
@@ -5303,6 +5373,7 @@ BlockDriver bdrv_qcow2 = {
     .mutable_opts        = mutable_opts,
     .bdrv_co_check       = qcow2_co_check,
     .bdrv_amend_options  = qcow2_amend_options,
+    .bdrv_co_amend       = qcow2_co_amend,
 
     .bdrv_detach_aio_context  = qcow2_detach_aio_context,
     .bdrv_attach_aio_context  = qcow2_attach_aio_context,
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 4a6db98938..0eb4e45168 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -4294,6 +4294,7 @@
 # Driver specific image creation options for qcow2.
 #
 # @file             Node to create the image format on
+#                   Mandatory for create
 # @data-file        Node to use as an external data file in which all guest
 #                   data is stored so that only metadata remains in the qcow2
 #                   file (since: 4.0)
@@ -4301,6 +4302,7 @@
 #                   standalone (read-only) raw image without looking at qcow2
 #                   metadata (default: false; since: 4.0)
 # @size             Size of the virtual disk in bytes
+#                   Mandatory for create
 # @version          Compatibility level (default: v3)
 # @backing-file     File name of the backing file if a backing file
 #                   should be used
@@ -4315,10 +4317,10 @@
 # Since: 2.12
 ##
 { 'struct': 'BlockdevCreateOptionsQcow2',
-  'data': { 'file':             'BlockdevRef',
+  'data': { '*file':            'BlockdevRef',
             '*data-file':       'BlockdevRef',
             '*data-file-raw':   'bool',
-            'size':             'size',
+            '*size':            'size',
             '*version':         'BlockdevQcow2Version',
             '*backing-file':    'str',
             '*backing-fmt':     'BlockdevDriver',
-- 
2.17.2


