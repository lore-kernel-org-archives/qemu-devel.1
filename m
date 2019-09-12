Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B50C4CEC6
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 22:39:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CFAB20830
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 22:39:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CFAB20830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8XkG-0008Hk-3c
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 18:39:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41886)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1i8XcJ-0007w8-7l
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 18:31:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1i8XcH-0005rm-S6
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 18:31:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60420)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1i8XcF-0005pm-6C; Thu, 12 Sep 2019 18:31:03 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 855B9308402D;
 Thu, 12 Sep 2019 22:31:02 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EE76A5C1B2;
 Thu, 12 Sep 2019 22:30:57 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 13 Sep 2019 01:30:23 +0300
Message-Id: <20190912223028.18496-7-mlevitsk@redhat.com>
In-Reply-To: <20190912223028.18496-1-mlevitsk@redhat.com>
References: <20190912223028.18496-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Thu, 12 Sep 2019 22:31:02 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 06/11] qcow2: implement crypto amend options
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

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 block/qcow2.c | 77 +++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 62 insertions(+), 15 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 0618a63793..26f83aeb44 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -172,6 +172,25 @@ static ssize_t qcow2_crypto_hdr_write_func(QCryptoBlock *block, size_t offset,
     return ret;
 }
 
+static QCryptoBlockCreateOptions*
+qcow2_extract_crypto_create_opts(QemuOpts *opts, const char *fmt, Error **errp)
+{
+    QDict *cryptoopts_qdict;
+    QCryptoBlockCreateOptions *cryptoopts;
+    QDict *opts_qdict;
+
+    /* Extract "encrypt." options into a qdict */
+    opts_qdict = qemu_opts_to_qdict(opts, NULL);
+    qdict_extract_subqdict(opts_qdict, &cryptoopts_qdict, "encrypt.");
+    qobject_unref(opts_qdict);
+
+    /* Build QCryptoBlockCreateOptions object from qdict */
+    qdict_put_str(cryptoopts_qdict, "format", "luks");
+    cryptoopts = block_crypto_create_opts_init(cryptoopts_qdict, errp);
+    qobject_unref(cryptoopts_qdict);
+    return cryptoopts;
+}
+
 
 /* 
  * read qcow2 extension and fill bs
@@ -4365,20 +4384,10 @@ static ssize_t qcow2_measure_crypto_hdr_write_func(QCryptoBlock *block,
 static bool qcow2_measure_luks_headerlen(QemuOpts *opts, size_t *len,
                                          Error **errp)
 {
-    QDict *opts_qdict;
-    QDict *cryptoopts_qdict;
     QCryptoBlockCreateOptions *cryptoopts;
     QCryptoBlock *crypto;
 
-    /* Extract "encrypt." options into a qdict */
-    opts_qdict = qemu_opts_to_qdict(opts, NULL);
-    qdict_extract_subqdict(opts_qdict, &cryptoopts_qdict, "encrypt.");
-    qobject_unref(opts_qdict);
-
-    /* Build QCryptoBlockCreateOptions object from qdict */
-    qdict_put_str(cryptoopts_qdict, "format", "luks");
-    cryptoopts = block_crypto_create_opts_init(cryptoopts_qdict, errp);
-    qobject_unref(cryptoopts_qdict);
+    cryptoopts = qcow2_extract_crypto_create_opts(opts, "luks", errp);
     if (!cryptoopts) {
         return false;
     }
@@ -4755,6 +4764,7 @@ typedef enum Qcow2AmendOperation {
      * invocation from an operation change */
     QCOW2_NO_OPERATION = 0,
 
+    QCOW2_UPDATING_ENCRYPTION,
     QCOW2_CHANGING_REFCOUNT_ORDER,
     QCOW2_DOWNGRADING,
 } Qcow2AmendOperation;
@@ -4839,6 +4849,7 @@ static int qcow2_amend_options(BlockDriverState *bs, QemuOpts *opts,
     int ret;
     QemuOptDesc *desc = opts->list->desc;
     Qcow2AmendHelperCBInfo helper_cb_info;
+    bool encryption_update = false;
 
     while (desc && desc->name) {
         if (!qemu_opt_find(opts, desc->name)) {
@@ -4887,9 +4898,22 @@ static int qcow2_amend_options(BlockDriverState *bs, QemuOpts *opts,
                 return -ENOTSUP;
             }
         } else if (g_str_has_prefix(desc->name, "encrypt.")) {
-            error_setg(errp,
-                       "Changing the encryption parameters is not supported");
-            return -ENOTSUP;
+
+            if (!s->crypto) {
+                error_setg(errp,
+                           "Can't amend encryption options - encryption not present");
+                return -EINVAL;
+
+            }
+
+            if (s->crypt_method_header != QCOW_CRYPT_LUKS) {
+                error_setg(errp,
+                           "Only LUKS encryption options can be amended");
+                return -ENOTSUP;
+            }
+
+            encryption_update = true;
+
         } else if (!strcmp(desc->name, BLOCK_OPT_CLUSTER_SIZE)) {
             cluster_size = qemu_opt_get_size(opts, BLOCK_OPT_CLUSTER_SIZE,
                                              cluster_size);
@@ -4939,7 +4963,8 @@ static int qcow2_amend_options(BlockDriverState *bs, QemuOpts *opts,
         .original_status_cb = status_cb,
         .original_cb_opaque = cb_opaque,
         .total_operations = (new_version < old_version)
-                          + (s->refcount_bits != refcount_bits)
+                          + (s->refcount_bits != refcount_bits) +
+                          (encryption_update == true)
     };
 
     /* Upgrade first (some features may require compat=1.1) */
@@ -4953,6 +4978,28 @@ static int qcow2_amend_options(BlockDriverState *bs, QemuOpts *opts,
         }
     }
 
+    if (encryption_update) {
+        QCryptoBlockCreateOptions *cryptoopts;
+
+        cryptoopts = qcow2_extract_crypto_create_opts(opts, "luks", errp);
+        if (!cryptoopts) {
+            return -EINVAL;
+        }
+
+        helper_cb_info.current_operation = QCOW2_UPDATING_ENCRYPTION;
+
+        ret = qcrypto_block_amend_options(s->crypto,
+                                          qcow2_crypto_hdr_read_func,
+                                          qcow2_crypto_hdr_write_func,
+                                          bs,
+                                          cryptoopts,
+                                          force,
+                                          errp);
+        if (ret < 0) {
+            return ret;
+        }
+    }
+
     if (s->refcount_bits != refcount_bits) {
         int refcount_order = ctz32(refcount_bits);
 
-- 
2.17.2


