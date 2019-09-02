Return-Path: <SRS0=OFvx=W5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4BE5C3A59E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 21:02:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA42921670
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 21:02:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oPaHINxn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA42921670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i4tTP-0000Cf-PB
	for qemu-devel@archiver.kernel.org; Mon, 02 Sep 2019 17:02:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33429)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <danielhb413@gmail.com>) id 1i4tPf-0005rz-Bo
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 16:59:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <danielhb413@gmail.com>) id 1i4tPd-0004Mu-QL
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 16:58:59 -0400
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:44465)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <danielhb413@gmail.com>)
 id 1i4tPd-0004MG-Mb
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 16:58:57 -0400
Received: by mail-qk1-x742.google.com with SMTP id i78so12180622qke.11
 for <qemu-devel@nongnu.org>; Mon, 02 Sep 2019 13:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cqXvzeH9JGbK13wh2PF5LuHVAWopqM5fCsamJ7eRinw=;
 b=oPaHINxnFgmuXrpWzFMhoyWEZXP+9V2pMbLQt9juEQ88tbDdeStkCgOqZIcYdW+orD
 CIbrakIBSQjjsBvmbwlC9KEao2dwXRt9mxLuBW2cJkfTwRstrxA9ernAs1MKo/Jx7r7d
 6PH6rsYw9p4DFgbgfKyXv4qDtuPsCRgY8+Mb9kLIPjk7wu9rSakfbzjQfKnigw8lmGtL
 X24rt/3b9zB2K60gr/qUcyrVefExVBS0FPPmofGjoj8/+OiqizSo7fp0O4+mdwmSoY/W
 /qoyk/kcFwYZMosNeEtE4m29fZkQ583HrkpeC1SH2Q85vwJ+9dgpXY59crw3kI8MtdqD
 N85A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cqXvzeH9JGbK13wh2PF5LuHVAWopqM5fCsamJ7eRinw=;
 b=jzqoXrg4/PexmC1ZJjWFjUgYMatMhn90w/5uMSiVRBhKdAJRVDNkr+Ik8zsmryLGIh
 oYZ5tXag2e2WwPxLQKDrOJB3TmmGWnB8+ZjNSbLWZvZTX74lgE5pFXlUIYbzGmvgrmb1
 RS5qbDbbZfxdmgPpzqH8vljJKffjG6duHiibfsXuxY0/VVknzX7BLpFY899Z8wW/ggMy
 31qh8YeHRCT2xyuZe1NZgaGVXXhKcycbgssDKzthcSqfTS1BGvTudLLx7QXgjwmQa81T
 wyvzO7tbiDigFdlQ5OrWizYupJjKpSPJ4n6u4Tgf48d7xsngOhdszyzlpOv/b/iHI09V
 1rvA==
X-Gm-Message-State: APjAAAWFXysf6wYj7zGdUTd+un6JhJF8yXYlV5XaRHs63tEDP6jLB2yR
 zx78NSSiQwaAbqzO7VFV+MFtrQm2
X-Google-Smtp-Source: APXvYqyUMmVcYv1AW3X0C4NXs+rGJKFZRlm1deAqpvJmqASPdVJt/nrfzUtC7PLBHdyNMrAAR3YBpg==
X-Received: by 2002:a05:620a:1e4:: with SMTP id
 x4mr16266606qkn.150.1567457937206; 
 Mon, 02 Sep 2019 13:58:57 -0700 (PDT)
Received: from rekt.ibmuc.com ([2804:431:c7c6:9589:1351:c7eb:87b:c9d5])
 by smtp.gmail.com with ESMTPSA id w80sm4604038qka.62.2019.09.02.13.58.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Sep 2019 13:58:56 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon,  2 Sep 2019 17:58:41 -0300
Message-Id: <20190902205842.1884-4-danielhb413@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190902205842.1884-1-danielhb413@gmail.com>
References: <20190902205842.1884-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::742
Subject: [Qemu-devel] [PATCH v6 3/4] crypto.c: cleanup created file when
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
index 7eb698774e..fe2f0c42b0 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -30,6 +30,7 @@
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "qemu/option.h"
+#include "qemu/cutils.h"
 #include "crypto.h"
 
 typedef struct BlockCrypto BlockCrypto;
@@ -599,6 +600,27 @@ fail:
     bdrv_unref(bs);
     qapi_free_QCryptoBlockCreateOptions(create_opts);
     qobject_unref(cryptoopts);
+
+    /*
+     * If an error occurred, delete the file. Even if the file existed
+     * beforehand, it has been truncated and corrupted in the process.
+     */
+    if (ret) {
+        Error *local_err;
+        int r_del = bdrv_delete_file(filename, &local_err);
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
     return ret;
 }
 
-- 
2.21.0


