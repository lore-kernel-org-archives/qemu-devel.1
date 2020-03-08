Return-Path: <SRS0=qQQb=4Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C87CC10DCE
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2020 15:20:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1606720848
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2020 15:20:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XgcBUpE2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1606720848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAxjY-0002Nw-8b
	for qemu-devel@archiver.kernel.org; Sun, 08 Mar 2020 11:20:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36934)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1jAxiB-0000JN-3l
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 11:19:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1jAxi9-0001bn-BE
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 11:19:27 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:29729
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1jAxi9-0001bS-67
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 11:19:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583680764;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+IGfhqlIB3ODtxz8DQL8sU/UqbClpWvI0y57Wfr0ymU=;
 b=XgcBUpE2B0cK1SVHQ6olgtjtVCmfgp5hJ0NoUqIsOGsyklrrh1gZGVRRN1n4xquUsen+TD
 VSqHQqYVfqUl881nrOPKCrK70VoCPa+tg2GY664IILuflfx4eWS0SXsUhix0xgwgZSk4LW
 aYs3Ahe2sxLsuzdGrj+cxAdkQ+MFj+k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-dFpdSZkeP2uP9AAbn1_S2w-1; Sun, 08 Mar 2020 11:19:22 -0400
X-MC-Unique: dFpdSZkeP2uP9AAbn1_S2w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A55B2107ACC9;
 Sun,  8 Mar 2020 15:19:21 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.96])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4A96B5C1B0;
 Sun,  8 Mar 2020 15:19:19 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 04/14] block/amend: separate amend and create options for
 qemu-img
Date: Sun,  8 Mar 2020 17:18:53 +0200
Message-Id: <20200308151903.25941-5-mlevitsk@redhat.com>
In-Reply-To: <20200308151903.25941-1-mlevitsk@redhat.com>
References: <20200308151903.25941-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Some options are only useful for creation
(or hard to be amended, like cluster size for qcow2), while some other
options are only useful for amend, like upcoming keyslot management
options for luks

Since currently only qcow2 supports amend, move all its options
to a common macro and then include it in each action option list.

In future it might be useful to remove some options which are
not supported anyway from amend list, which currently
cause an error message if amended.

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 block/qcow2.c             | 160 +++++++++++++++++++++-----------------
 include/block/block_int.h |   4 +
 qemu-img.c                |  18 ++---
 3 files changed, 100 insertions(+), 82 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index b55e5b7c1f..9574085772 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -5440,83 +5440,96 @@ void qcow2_signal_corruption(BlockDriverState *bs, =
bool fatal, int64_t offset,
     s->signaled_corruption =3D true;
 }
=20
+#define QCOW_COMMON_OPTIONS                                         \
+    {                                                               \
+        .name =3D BLOCK_OPT_SIZE,                                     \
+        .type =3D QEMU_OPT_SIZE,                                      \
+        .help =3D "Virtual disk size"                                 \
+    },                                                              \
+    {                                                               \
+        .name =3D BLOCK_OPT_COMPAT_LEVEL,                             \
+        .type =3D QEMU_OPT_STRING,                                    \
+        .help =3D "Compatibility level (v2 [0.10] or v3 [1.1])"       \
+    },                                                              \
+    {                                                               \
+        .name =3D BLOCK_OPT_BACKING_FILE,                             \
+        .type =3D QEMU_OPT_STRING,                                    \
+        .help =3D "File name of a base image"                         \
+    },                                                              \
+    {                                                               \
+        .name =3D BLOCK_OPT_BACKING_FMT,                              \
+        .type =3D QEMU_OPT_STRING,                                    \
+        .help =3D "Image format of the base image"                    \
+    },                                                              \
+    {                                                               \
+        .name =3D BLOCK_OPT_DATA_FILE,                                \
+        .type =3D QEMU_OPT_STRING,                                    \
+        .help =3D "File name of an external data file"                \
+    },                                                              \
+    {                                                               \
+        .name =3D BLOCK_OPT_DATA_FILE_RAW,                            \
+        .type =3D QEMU_OPT_BOOL,                                      \
+        .help =3D "The external data file must stay valid "           \
+                "as a raw image"                                    \
+    },                                                              \
+    {                                                               \
+        .name =3D BLOCK_OPT_ENCRYPT,                                  \
+        .type =3D QEMU_OPT_BOOL,                                      \
+        .help =3D "Encrypt the image with format 'aes'. (Deprecated " \
+                "in favor of " BLOCK_OPT_ENCRYPT_FORMAT "=3Daes)",    \
+    },                                                              \
+    {                                                               \
+        .name =3D BLOCK_OPT_ENCRYPT_FORMAT,                           \
+        .type =3D QEMU_OPT_STRING,                                    \
+        .help =3D "Encrypt the image, format choices: 'aes', 'luks'", \
+    },                                                              \
+    BLOCK_CRYPTO_OPT_DEF_KEY_SECRET("encrypt.",                     \
+        "ID of secret providing qcow AES key or LUKS passphrase"),  \
+    BLOCK_CRYPTO_OPT_DEF_LUKS_CIPHER_ALG("encrypt."),               \
+    BLOCK_CRYPTO_OPT_DEF_LUKS_CIPHER_MODE("encrypt."),              \
+    BLOCK_CRYPTO_OPT_DEF_LUKS_IVGEN_ALG("encrypt."),                \
+    BLOCK_CRYPTO_OPT_DEF_LUKS_IVGEN_HASH_ALG("encrypt."),           \
+    BLOCK_CRYPTO_OPT_DEF_LUKS_HASH_ALG("encrypt."),                 \
+    BLOCK_CRYPTO_OPT_DEF_LUKS_ITER_TIME("encrypt."),                \
+    {                                                               \
+        .name =3D BLOCK_OPT_CLUSTER_SIZE,                             \
+        .type =3D QEMU_OPT_SIZE,                                      \
+        .help =3D "qcow2 cluster size",                               \
+        .def_value_str =3D stringify(DEFAULT_CLUSTER_SIZE)            \
+    },                                                              \
+    {                                                               \
+        .name =3D BLOCK_OPT_PREALLOC,                                 \
+        .type =3D QEMU_OPT_STRING,                                    \
+        .help =3D "Preallocation mode (allowed values: off, "         \
+                "metadata, falloc, full)"                           \
+    },                                                              \
+    {                                                               \
+        .name =3D BLOCK_OPT_LAZY_REFCOUNTS,                           \
+        .type =3D QEMU_OPT_BOOL,                                      \
+        .help =3D "Postpone refcount updates",                        \
+        .def_value_str =3D "off"                                      \
+    },                                                              \
+    {                                                               \
+        .name =3D BLOCK_OPT_REFCOUNT_BITS,                            \
+        .type =3D QEMU_OPT_NUMBER,                                    \
+        .help =3D "Width of a reference count entry in bits",         \
+        .def_value_str =3D "16"                                       \
+    }                                                               \
+
 static QemuOptsList qcow2_create_opts =3D {
     .name =3D "qcow2-create-opts",
     .head =3D QTAILQ_HEAD_INITIALIZER(qcow2_create_opts.head),
     .desc =3D {
-        {
-            .name =3D BLOCK_OPT_SIZE,
-            .type =3D QEMU_OPT_SIZE,
-            .help =3D "Virtual disk size"
-        },
-        {
-            .name =3D BLOCK_OPT_COMPAT_LEVEL,
-            .type =3D QEMU_OPT_STRING,
-            .help =3D "Compatibility level (v2 [0.10] or v3 [1.1])"
-        },
-        {
-            .name =3D BLOCK_OPT_BACKING_FILE,
-            .type =3D QEMU_OPT_STRING,
-            .help =3D "File name of a base image"
-        },
-        {
-            .name =3D BLOCK_OPT_BACKING_FMT,
-            .type =3D QEMU_OPT_STRING,
-            .help =3D "Image format of the base image"
-        },
-        {
-            .name =3D BLOCK_OPT_DATA_FILE,
-            .type =3D QEMU_OPT_STRING,
-            .help =3D "File name of an external data file"
-        },
-        {
-            .name =3D BLOCK_OPT_DATA_FILE_RAW,
-            .type =3D QEMU_OPT_BOOL,
-            .help =3D "The external data file must stay valid as a raw ima=
ge"
-        },
-        {
-            .name =3D BLOCK_OPT_ENCRYPT,
-            .type =3D QEMU_OPT_BOOL,
-            .help =3D "Encrypt the image with format 'aes'. (Deprecated "
-                    "in favor of " BLOCK_OPT_ENCRYPT_FORMAT "=3Daes)",
-        },
-        {
-            .name =3D BLOCK_OPT_ENCRYPT_FORMAT,
-            .type =3D QEMU_OPT_STRING,
-            .help =3D "Encrypt the image, format choices: 'aes', 'luks'",
-        },
-        BLOCK_CRYPTO_OPT_DEF_KEY_SECRET("encrypt.",
-            "ID of secret providing qcow AES key or LUKS passphrase"),
-        BLOCK_CRYPTO_OPT_DEF_LUKS_CIPHER_ALG("encrypt."),
-        BLOCK_CRYPTO_OPT_DEF_LUKS_CIPHER_MODE("encrypt."),
-        BLOCK_CRYPTO_OPT_DEF_LUKS_IVGEN_ALG("encrypt."),
-        BLOCK_CRYPTO_OPT_DEF_LUKS_IVGEN_HASH_ALG("encrypt."),
-        BLOCK_CRYPTO_OPT_DEF_LUKS_HASH_ALG("encrypt."),
-        BLOCK_CRYPTO_OPT_DEF_LUKS_ITER_TIME("encrypt."),
-        {
-            .name =3D BLOCK_OPT_CLUSTER_SIZE,
-            .type =3D QEMU_OPT_SIZE,
-            .help =3D "qcow2 cluster size",
-            .def_value_str =3D stringify(DEFAULT_CLUSTER_SIZE)
-        },
-        {
-            .name =3D BLOCK_OPT_PREALLOC,
-            .type =3D QEMU_OPT_STRING,
-            .help =3D "Preallocation mode (allowed values: off, metadata, =
"
-                    "falloc, full)"
-        },
-        {
-            .name =3D BLOCK_OPT_LAZY_REFCOUNTS,
-            .type =3D QEMU_OPT_BOOL,
-            .help =3D "Postpone refcount updates",
-            .def_value_str =3D "off"
-        },
-        {
-            .name =3D BLOCK_OPT_REFCOUNT_BITS,
-            .type =3D QEMU_OPT_NUMBER,
-            .help =3D "Width of a reference count entry in bits",
-            .def_value_str =3D "16"
-        },
+        QCOW_COMMON_OPTIONS,
+        { /* end of list */ }
+    }
+};
+
+static QemuOptsList qcow2_amend_opts =3D {
+    .name =3D "qcow2-amend-opts",
+    .head =3D QTAILQ_HEAD_INITIALIZER(qcow2_amend_opts.head),
+    .desc =3D {
+        QCOW_COMMON_OPTIONS,
         { /* end of list */ }
     }
 };
@@ -5576,6 +5589,7 @@ BlockDriver bdrv_qcow2 =3D {
     .bdrv_inactivate            =3D qcow2_inactivate,
=20
     .create_opts         =3D &qcow2_create_opts,
+    .amend_opts          =3D &qcow2_amend_opts,
     .strong_runtime_opts =3D qcow2_strong_runtime_opts,
     .mutable_opts        =3D mutable_opts,
     .bdrv_co_check       =3D qcow2_co_check,
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 24d00fbf48..48a4c2fa1c 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -406,6 +406,10 @@ struct BlockDriver {
=20
     /* List of options for creating images, terminated by name =3D=3D NULL=
 */
     QemuOptsList *create_opts;
+
+    /* List of options for image amend*/
+    QemuOptsList *amend_opts;
+
     /*
      * If this driver supports reopening images this contains a
      * NULL-terminated list of the runtime options that can be
diff --git a/qemu-img.c b/qemu-img.c
index 551388676f..2555aedee9 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -3898,11 +3898,11 @@ static int print_amend_option_help(const char *form=
at)
         return 1;
     }
=20
-    /* Every driver supporting amendment must have create_opts */
-    assert(drv->create_opts);
+    /* Every driver supporting amendment must have amend_opts */
+    assert(drv->amend_opts);
=20
     printf("Creation options for '%s':\n", format);
-    qemu_opts_print_help(drv->create_opts, false);
+    qemu_opts_print_help(drv->amend_opts, false);
     printf("\nNote that not all of these options may be amendable.\n");
     return 0;
 }
@@ -3912,7 +3912,7 @@ static int img_amend(int argc, char **argv)
     Error *err =3D NULL;
     int c, ret =3D 0;
     char *options =3D NULL;
-    QemuOptsList *create_opts =3D NULL;
+    QemuOptsList *amend_opts =3D NULL;
     QemuOpts *opts =3D NULL;
     const char *fmt =3D NULL, *filename, *cache;
     int flags;
@@ -4051,11 +4051,11 @@ static int img_amend(int argc, char **argv)
         goto out;
     }
=20
-    /* Every driver supporting amendment must have create_opts */
-    assert(bs->drv->create_opts);
+    /* Every driver supporting amendment must have amend_opts */
+    assert(bs->drv->amend_opts);
=20
-    create_opts =3D qemu_opts_append(create_opts, bs->drv->create_opts);
-    opts =3D qemu_opts_create(create_opts, NULL, 0, &error_abort);
+    amend_opts =3D qemu_opts_append(amend_opts, bs->drv->amend_opts);
+    opts =3D qemu_opts_create(amend_opts, NULL, 0, &error_abort);
     qemu_opts_do_parse(opts, options, NULL, &err);
     if (err) {
         error_report_err(err);
@@ -4078,7 +4078,7 @@ out:
 out_no_progress:
     blk_unref(blk);
     qemu_opts_del(opts);
-    qemu_opts_free(create_opts);
+    qemu_opts_free(amend_opts);
     g_free(options);
=20
     if (ret) {
--=20
2.17.2


