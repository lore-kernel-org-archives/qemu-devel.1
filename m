Return-Path: <SRS0=fB5B=WK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D98D7C32753
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 20:35:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2DA2214C6
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 20:35:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2DA2214C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxzzQ-0000Ef-LI
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 16:35:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33465)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1hxzo2-0004ox-Kd
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 16:23:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1hxzo1-0004Tk-03
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 16:23:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58878)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1hxznx-0004Rj-Pr; Wed, 14 Aug 2019 16:23:33 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2069A30ADBA2;
 Wed, 14 Aug 2019 20:23:33 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.39])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AC4EF10016EB;
 Wed, 14 Aug 2019 20:23:25 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 14 Aug 2019 23:22:18 +0300
Message-Id: <20190814202219.1870-13-mlevitsk@redhat.com>
In-Reply-To: <20190814202219.1870-1-mlevitsk@redhat.com>
References: <20190814202219.1870-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Wed, 14 Aug 2019 20:23:33 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 12/13] qemu-img: implement key management
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 block/crypto.c   |  16 ++++++
 block/crypto.h   |   3 +
 qemu-img-cmds.hx |  13 +++++
 qemu-img.c       | 140 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 172 insertions(+)

diff --git a/block/crypto.c b/block/crypto.c
index 415b6db041..2fcdf9dd39 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -203,6 +203,22 @@ block_crypto_create_opts_init(QDict *opts, Error **errp)
     return ret;
 }
 
+QCryptoEncryptionSetupOptions *
+block_crypto_setup_opts_init(QDict *opts, Error **errp)
+{
+    Visitor *v;
+    QCryptoEncryptionSetupOptions *ret;
+
+    v = qobject_input_visitor_new_flat_confused(opts, errp);
+    if (!v) {
+        return NULL;
+    }
+
+    visit_type_QCryptoEncryptionSetupOptions(v, NULL, &ret, errp);
+
+    visit_free(v);
+    return ret;
+}
 
 static int block_crypto_open_generic(QCryptoBlockFormat format,
                                      QemuOptsList *opts_spec,
diff --git a/block/crypto.h b/block/crypto.h
index b935695e79..ece4d64aef 100644
--- a/block/crypto.h
+++ b/block/crypto.h
@@ -94,4 +94,7 @@ block_crypto_create_opts_init(QDict *opts, Error **errp);
 QCryptoBlockOpenOptions *
 block_crypto_open_opts_init(QDict *opts, Error **errp);
 
+QCryptoEncryptionSetupOptions *
+block_crypto_setup_opts_init(QDict *opts, Error **errp);
+
 #endif /* BLOCK_CRYPTO_H */
diff --git a/qemu-img-cmds.hx b/qemu-img-cmds.hx
index 1c93e6d185..7816a0adfb 100644
--- a/qemu-img-cmds.hx
+++ b/qemu-img-cmds.hx
@@ -19,6 +19,18 @@ STEXI
 @item amend [--object @var{objectdef}] [--image-opts] [-p] [-q] [-f @var{fmt}] [-t @var{cache}] -o @var{options} @var{filename}
 ETEXI
 
+DEF("add_encryption_key", img_add_encryption_key,
+    "add_encryption_key [--object objectdef] [--image-opts] [--force] -U --keydef key_definition filename")
+STEXI
+@item add_encryption_key [--object @var{objectdef}] [--image-opts] [--force] -U --keydef @var{key_definition} @var{filename}
+ETEXI
+
+DEF("erase_encryption_key", img_erase_encryption_key,
+    "erase_encryption_key [--object objectdef] [--image-opts] [--force] -U --keydef key_definition filename")
+STEXI
+@item erase_encryption_key [--object @var{objectdef}] [--image-opts] [--force] -U --keydef @var{key_definition} @var{filename}
+ETEXI
+
 DEF("bench", img_bench,
     "bench [-c count] [-d depth] [-f fmt] [--flush-interval=flush_interval] [-n] [--no-drain] [-o offset] [--pattern=pattern] [-q] [-s buffer_size] [-S step_size] [-t cache] [-w] [-U] filename")
 STEXI
@@ -97,6 +109,7 @@ STEXI
 @item resize [--object @var{objectdef}] [--image-opts] [-f @var{fmt}] [--preallocation=@var{prealloc}] [-q] [--shrink] @var{filename} [+ | -]@var{size}
 ETEXI
 
+
 STEXI
 @end table
 ETEXI
diff --git a/qemu-img.c b/qemu-img.c
index 79983772de..bc6cd60df1 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -47,6 +47,7 @@
 #include "block/blockjob.h"
 #include "block/qapi.h"
 #include "crypto/init.h"
+#include "block/crypto.h"
 #include "trace/control.h"
 
 #define QEMU_IMG_VERSION "qemu-img version " QEMU_FULL_VERSION \
@@ -70,6 +71,8 @@ enum {
     OPTION_PREALLOCATION = 265,
     OPTION_SHRINK = 266,
     OPTION_SALVAGE = 267,
+    OPTION_FORCE = 268,
+    OPTION_KEYDEF = 269,
 };
 
 typedef enum OutputFormat {
@@ -223,6 +226,14 @@ static QemuOptsList qemu_source_opts = {
     },
 };
 
+static QemuOptsList keydef_opts = {
+    .name = "encryption_opts",
+    .head = QTAILQ_HEAD_INITIALIZER(keydef_opts.head),
+    .desc = {
+        { }
+    },
+};
+
 static int GCC_FMT_ATTR(2, 3) qprintf(bool quiet, const char *fmt, ...)
 {
     int ret = 0;
@@ -4997,6 +5008,135 @@ out:
     return ret;
 }
 
+
+static QemuOptsList keydef_options_list = {
+    .name = "encryption",
+    .head = QTAILQ_HEAD_INITIALIZER(keydef_options_list.head),
+    .desc = {
+        { }
+    },
+};
+
+static int setup_encryption(int argc, char **argv,
+        enum BlkSetupEncryptionAction action)
+{
+    static const struct option long_options[] = {
+        {"help", no_argument, 0, 'h'},
+        {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
+        {"object", required_argument, 0, OPTION_OBJECT},
+        {"force", no_argument, 0, OPTION_FORCE},
+        {"force-share", no_argument, 0, 'U'},
+        {"keydef", required_argument, 0, OPTION_KEYDEF},
+        {0, 0, 0, 0}
+    };
+
+    BlockBackend *blk = NULL;
+    const char *filename = NULL;
+    bool force_share = false;
+    QemuOpts *keydef_opts = NULL;
+    bool image_opts = false;
+    Error *local_err = NULL;
+    QDict *keydef_dict = NULL;
+    QCryptoEncryptionSetupOptions *qcrypto_options = NULL;
+    bool force = false;
+
+    int ret = 1;
+    int c;
+
+    while ((c = getopt_long(argc, argv, "hU:", long_options, NULL)) != -1) {
+        switch (c) {
+        case '?':
+        case 'h':
+            help();
+            break;
+        case 'U':
+            force_share = true;
+            break;
+
+        case OPTION_KEYDEF:
+            if (keydef_opts) {
+                error_report("Only single --keydef argument is allowed.");
+                goto out;
+            }
+
+            keydef_opts = qemu_opts_parse_noisily(&keydef_options_list,
+                                                  optarg, false);
+            if (!keydef_opts) {
+                goto out;
+            }
+            break;
+
+        case OPTION_OBJECT: {
+            QemuOpts *object_opts = qemu_opts_parse_noisily(&qemu_object_opts,
+                                                  optarg, true);
+            if (!object_opts) {
+                goto out;
+            }
+            break;
+        }
+        case OPTION_IMAGE_OPTS:
+            image_opts = true;
+            break;
+        case OPTION_FORCE:
+            force = true;
+            break;
+        break;
+        }
+    }
+
+    if (qemu_opts_foreach(&qemu_object_opts,
+                          user_creatable_add_opts_foreach,
+                          NULL, &error_fatal)) {
+        goto out;
+    }
+
+    if (argc - optind > 1) {
+        error_report("At most one filename argument is allowed.");
+        goto out;
+    } else if (argc - optind == 1) {
+        filename = argv[optind];
+    } else {
+        error_report("filename is required");
+        goto out;
+
+    }
+
+    blk = img_open(image_opts, filename, NULL, BDRV_O_RDWR,
+                   false, false, force_share);
+    if (!blk) {
+        goto out;
+    }
+
+    keydef_dict = qemu_opts_to_qdict(keydef_opts, NULL);
+    qcrypto_options = block_crypto_setup_opts_init(keydef_dict, &local_err);
+    if (!qcrypto_options) {
+        error_report_err(local_err);
+        goto out;
+    }
+
+    if (blk_setup_encryption(blk, action, qcrypto_options, force, &local_err)) {
+        error_report_err(local_err);
+        goto out;
+    }
+    ret = 0;
+out:
+    qemu_opts_del(keydef_opts);
+    qobject_unref(keydef_dict);
+    qapi_free_QCryptoEncryptionSetupOptions(qcrypto_options);
+    blk_unref(blk);
+    return ret;
+}
+
+static int img_add_encryption_key(int argc, char **argv)
+{
+    return setup_encryption(argc, argv, BLK_UPDATE_ENCRYPTION);
+}
+
+static int img_erase_encryption_key(int argc, char **argv)
+{
+    return setup_encryption(argc, argv, BLK_ERASE_ENCRYPTION);
+}
+
 static const img_cmd_t img_cmds[] = {
 #define DEF(option, callback, arg_string)        \
     { option, callback },
-- 
2.17.2


