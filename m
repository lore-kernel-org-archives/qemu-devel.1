Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99B1FC3A5A7
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 13:59:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6879E2341F
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 13:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fBdp8HcF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6879E2341F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i59LQ-0005pB-4B
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 09:59:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33796)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <danielhb413@gmail.com>) id 1i59JK-0003Nh-3Q
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 09:57:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <danielhb413@gmail.com>) id 1i59JI-0005lx-Vp
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 09:57:30 -0400
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744]:38627)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <danielhb413@gmail.com>)
 id 1i59JD-0005it-Fx
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 09:57:25 -0400
Received: by mail-qk1-x744.google.com with SMTP id x5so1898288qkh.5
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2019 06:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=VQHc2Ows/HevyIUsCH9uoWSWREQDTgPtdPClqT9JG70=;
 b=fBdp8HcFBZf8xRfN+wQNp0oWeJ9yZjxpS3nIw5NJodmtDzlfl1Dz652RlXna4aIcry
 o4oFUQPWbdq6xL2Lkt8ePJZhfXjI+eTEA+WebGAK31nEuf12rT6EEHSHh/wo2jBtEZEb
 5i8Rh8weZgwvwMq4wWh09K5R36HHA2bnudHECGcR86GMuaeMoZHO6iPxEe+VT8RUAXiL
 Tgl1tFWu0cz9iJzkKWZnmhxn4/fJEPretkrhFuCVqMyDFKGy8wIsGuH/rCFOgFJQftQU
 p0McwitjGtXHVmWBOXn8YIXF/ETDNuDzwhSqjOO5FKIXCFAzQK8CL3vker6ztiPcDVQu
 s9dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VQHc2Ows/HevyIUsCH9uoWSWREQDTgPtdPClqT9JG70=;
 b=VK6/ZJ/7Fe3t1nSl5A1horN5Ky02g4Iq3SHbC/bdn7bE7o7dai0EgK/AhUckxtJmHU
 493lKbxUbzTKHWDrJ5MuN2KK+A9uhT8BweoKHUrrDgd05zOvagPq+oSffEBDwiT+zC32
 VH0tNvNaA+9EXvCuWwSY72Ia810hXuf+bTroi5L0p+spUvANsLwAkxWraPOLbbmDAp0t
 KXT0ye7I+U7sWTP/z6m8nPp3PDcduG6IPBsi4La0QHAdbda4Mo+Gsk8s/I1ae4M7jvQc
 +A9mIikQw7Ym5HddreMJBWIrL1w7vCS6yZgC/nb3qB+ugzipsMbwC5+00rykwLjGzdpz
 /Qig==
X-Gm-Message-State: APjAAAWki1GTD6FQZlQuftXrIa7M9ClyugZXdCSY5wNx/NEyvX8LhjE0
 rs5ErzNaJ4sGMHNs1cpkT2k5iJQdLVc=
X-Google-Smtp-Source: APXvYqzpt50s4qr8Fz7mD+eHe76et6O8b/5kwtWHW0SS2uM92FRDA5kOXX7ZxTQ0V14VYQYYQyg4Zw==
X-Received: by 2002:a37:a44f:: with SMTP id n76mr22731968qke.414.1567519042547; 
 Tue, 03 Sep 2019 06:57:22 -0700 (PDT)
Received: from rekt.ibmuc.com ([2804:431:c7c7:5c9f:9471:e230:52b:8c93])
 by smtp.gmail.com with ESMTPSA id k49sm9211158qtc.9.2019.09.03.06.57.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2019 06:57:22 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Date: Tue,  3 Sep 2019 10:57:07 -0300
Message-Id: <20190903135708.21624-4-danielhb413@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190903135708.21624-1-danielhb413@gmail.com>
References: <20190903135708.21624-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::744
Subject: [Qemu-devel] [PATCH v7 3/4] crypto.c: cleanup created file when
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
Cc: kwolf@redhat.com, Srikanth Aithal <bssrikanth@in.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When using a non-UTF8 secret to create a volume using qemu-img, the
following error happens:

$ qemu-img create -f luks --object secret,id=vol_1_encrypt0,file=vol_resize_pool.vol_1.secret.qzVQrI -o key-secret=vol_1_encrypt0 /var/tmp/pool_target/vol_1 10240K

Formatting '/var/tmp/pool_target/vol_1', fmt=luks size=10485760 key-secret=vol_1_encrypt0
qemu-img: /var/tmp/pool_target/vol_1: Data from secret vol_1_encrypt0 is not valid UTF-8

However, the created file '/var/tmp/pool_target/vol_1' is left behind in the
file system after the failure. This behavior can be observed when creating
the volume using Libvirt, via 'virsh vol-create', and then getting "volume
target path already exist" errors when trying to re-create the volume.

The volume file is created inside block_crypto_co_create_opts_luks(), in
block/crypto.c. If the bdrv_create_file() call is successful but any
succeeding step fails*, the existing 'fail' label does not take into
account the created file, leaving it behind.

This patch changes block_crypto_co_create_opts_luks() to delete
'filename' in case of failure. A failure in this point means that
the volume is now truncated/corrupted, so even if 'filename' was an
existing volume before calling qemu-img, it is now unusable. Deleting
the file it is not much worse than leaving it in the filesystem in
this scenario, and we don't have to deal with checking the file
pre-existence in the code.

* in our case, block_crypto_co_create_generic calls qcrypto_block_create,
which calls qcrypto_block_luks_create, and this function fails when
calling qcrypto_secret_lookup_as_utf8.

Reported-by: Srikanth Aithal <bssrikanth@in.ibm.com>
Suggested-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 block/crypto.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/block/crypto.c b/block/crypto.c
index 7eb698774e..29496d247e 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -30,6 +30,7 @@
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "qemu/option.h"
+#include "qemu/cutils.h"
 #include "crypto.h"
 
 typedef struct BlockCrypto BlockCrypto;
@@ -596,9 +597,30 @@ static int coroutine_fn block_crypto_co_create_opts_luks(const char *filename,
 
     ret = 0;
 fail:
+    /*
+     * If an error occurred, delete 'filename'. Even if the file existed
+     * beforehand, it has been truncated and corrupted in the process.
+     */
+    if (ret) {
+        Error *local_err;
+        int r_del = bdrv_delete_file(bs, &local_err);
+        /*
+         * ENOTSUP will happen if the block driver doesn't support
+         * 'bdrv_co_delete_file'. ENOENT will be fired by
+         * 'raw_co_delete_file' if the file doesn't exist. Both are
+         * predictable (we're not verifying if the driver supports
+         * file deletion or if the file was created), thus we
+         * shouldn't report this back to the user.
+         */
+        if ((r_del < 0) && (r_del != -ENOTSUP) && (r_del != -ENOENT)) {
+            error_reportf_err(local_err, "%s: ", bs->filename);
+        }
+    }
+
     bdrv_unref(bs);
     qapi_free_QCryptoBlockCreateOptions(create_opts);
     qobject_unref(cryptoopts);
+
     return ret;
 }
 
-- 
2.21.0


