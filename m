Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 974CEC4646D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 19:53:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 688412083B
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 19:53:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FiQgE6kk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 688412083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35993 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgwvn-0005VN-OE
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 15:53:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34396)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <danielhb413@gmail.com>) id 1hgwoP-0000cJ-Go
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 15:45:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <danielhb413@gmail.com>) id 1hgwoM-0000wS-Rr
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 15:45:33 -0400
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:44081)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <danielhb413@gmail.com>)
 id 1hgwoM-0000vW-M9
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 15:45:30 -0400
Received: by mail-qk1-x742.google.com with SMTP id p144so5866508qke.11
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2019 12:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=T3WLgtmuAu7cjJ7PRM9PUfqyVZbL0EGGzc5/L/cNNS4=;
 b=FiQgE6kkvyQ1iisedNDHbfVyjkNH8GUJUVv4fLKJ6yF+46ENvyowm5talKxYTHRrNS
 ywOBK0EFdbnLZqauu3Eu4IJFNo59yQzUVd+dI1K649/uCuUVlN2y/MzrcQp3O3ipWDDb
 Kk1O+GQrNFfbwG0D4hw2KuJlh6c3MpwfujjC9132woagOqJHnF4gFrtKjZW/xdpXSpum
 lf7yk60BbcTr2HYITZXfErTgjRN1eNFimKT6V73cWrrarAa7IqzysDtTfrrhXO1cfEtP
 JEc5sZUpKXpL1kElGBGSpsMNHR65sGknpmgGKCdagk7K5hqBxz1kNJo3o2kpWoGjaow2
 Tc4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=T3WLgtmuAu7cjJ7PRM9PUfqyVZbL0EGGzc5/L/cNNS4=;
 b=j1LEE/fwoh+Ves6Ufy1Tz1QJrFw4UwosCOJ4JA1XW9z5CcI3pF0QD5W20pa21R6gRo
 kSNqhXSqUpPyVB6eakD7rwwNPpmTD/1kP3TO2IqNMmpmEVL0eULovzJFdvy7W+Nu0HzN
 nzuxosv/KgfGsDPUq24kfDW000ZpSFF2oFS3j51daTTOzw/9i1i5WLWJx6t5em/Rj9GC
 RJtV01Rcq2F58mfQYWgt4VNTnbG9WzzSjBUrF0L8dFo7zHPp/x0zpZMwr+WGgO2en/Uq
 gxbsXEM3vfsz/999DqCWS+1JTZe0VpWXCion8YO//z4yogP/r7sSs7cDO63N80vAzzxd
 8xNQ==
X-Gm-Message-State: APjAAAWCBsrb+vUd4x/bhl9yZkmIs9P1bIdtowNVfuKsY+IK+I2gGgxq
 +sVwNYfUcgMCbdWHsMd7BtB7zU21
X-Google-Smtp-Source: APXvYqzcoPu9p59nvdDiMoYb9tIYVNEuAAwZ6U4GFCbbOsX6vUg3Wktx4BClMr7CQ6kNWJjIivYEcA==
X-Received: by 2002:a37:a692:: with SMTP id p140mr9965384qke.432.1561751129802; 
 Fri, 28 Jun 2019 12:45:29 -0700 (PDT)
Received: from rekt.ibmuc.com ([2804:431:c7c6:927e:501b:7135:21ca:8a87])
 by smtp.gmail.com with ESMTPSA id b69sm1602288qkg.105.2019.06.28.12.45.27
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 28 Jun 2019 12:45:29 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri, 28 Jun 2019 16:45:11 -0300
Message-Id: <20190628194512.21311-4-danielhb413@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190628194512.21311-1-danielhb413@gmail.com>
References: <20190628194512.21311-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::742
Subject: [Qemu-devel] [PATCH v4 3/4] crypto.c: cleanup created file when
 block_crypto_co_create_opts_luks fails
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
Cc: kwolf@redhat.com, berrange@redhat.com,
 Daniel Henrique Barboza <danielhb413@gmail.com>, mreitz@redhat.com,
 Srikanth Aithal <bssrikanth@in.ibm.com>, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When using a non-UTF8 secret to create a volume using qemu-img, the
following error happens:

$ qemu-img create -f luks --object secret,id=vol_1_encrypt0,file=vol_resize_pool.vol_1.secret.qzVQrI -o key-secret=vol_1_encrypt0 /var/tmp/pool_target/vol_1 10240K

Formatting '/var/tmp/pool_target/vol_1', fmt=luks size=10485760 key-secret=vol_1_encrypt0
qemu-img: /var/tmp/pool_target/vol_1: Data from secret vol_1_encrypt0 is not valid UTF-8

However, the created file /var/tmp/pool_target/vol_1 is left behind in the
file system after the failure. This behavior can be observed when creating
the volume using Libvirt, via 'virsh vol-create', and then getting "volume
target path already exist" errors when trying to re-create the volume.

The volume file is created inside block_crypto_co_create_opts_luks, in
block/crypto.c. If the bdrv_create_file() call is successful but any
succeeding step fails*, the existing 'fail' label does not take into
account the created file, leaving it behind.

This patch changes block_crypto_co_create_opts_luks to check if @filename
is an existing file before bdrv_create_file is called. In case of failure,
if @filename didn't exist before, check again for its existence and,
if affirmative, erase it by calling bdrv_delete_file.

* in our case, block_crypto_co_create_generic calls qcrypto_block_create,
which calls qcrypto_block_luks_create, and this function fails when
calling qcrypto_secret_lookup_as_utf8.

Reported-by: Srikanth Aithal <bssrikanth@in.ibm.com>
Suggested-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 block/crypto.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/block/crypto.c b/block/crypto.c
index 8237424ae6..146f3eb721 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -30,6 +30,7 @@
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "qemu/option.h"
+#include "qemu/cutils.h"
 #include "crypto.h"
 
 typedef struct BlockCrypto BlockCrypto;
@@ -535,6 +536,8 @@ static int coroutine_fn block_crypto_co_create_opts_luks(const char *filename,
     BlockDriverState *bs = NULL;
     QDict *cryptoopts;
     int64_t size;
+    const char *path;
+    bool file_already_existed = false;
     int ret;
 
     /* Parse options */
@@ -551,6 +554,15 @@ static int coroutine_fn block_crypto_co_create_opts_luks(const char *filename,
         goto fail;
     }
 
+    /*
+     * Check if 'filename' represents a local file that already
+     * exists in the file system prior to bdrv_create_file. Strip
+     * the leading 'file:' from the filename if it exists.
+     */
+    path = filename;
+    strstart(path, "file:", &path);
+    file_already_existed = bdrv_path_is_regular_file(path);
+
     /* Create protocol layer */
     ret = bdrv_create_file(filename, opts, errp);
     if (ret < 0) {
@@ -575,6 +587,25 @@ fail:
     bdrv_unref(bs);
     qapi_free_QCryptoBlockCreateOptions(create_opts);
     qobject_unref(cryptoopts);
+
+    /*
+     * If an error occurred and we ended up creating a bogus
+     * 'filename' file, delete it
+     */
+    if (ret && !file_already_existed && bdrv_path_is_regular_file(path)) {
+        Error *local_err;
+        int r_del = bdrv_delete_file(path, &local_err);
+        /*
+         * ENOTSUP will happen if the block driver doesn't support
+         * 'bdrv_co_delete_file'. ENOENT will happen if the file
+         * doesn't exist. Both are predictable and shouldn't be
+         * reported back to the user.
+         */
+        if ((r_del < 0) && (r_del != -ENOTSUP) && (r_del != -ENOENT)) {
+            error_reportf_err(local_err, "%s: ", path);
+        }
+    }
+
     return ret;
 }
 
-- 
2.20.1


