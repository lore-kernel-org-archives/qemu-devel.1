Return-Path: <SRS0=6DzB=ZD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFAE7C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 17:08:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBE4C20656
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 17:08:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YA4rv04v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBE4C20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUDB9-0003lb-JU
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 12:08:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48544)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <danielhb413@gmail.com>) id 1iUD4b-0006IL-VM
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 12:01:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <danielhb413@gmail.com>) id 1iUD4a-0006B7-IU
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 12:01:53 -0500
Received: from mail-qv1-xf42.google.com ([2607:f8b0:4864:20::f42]:33547)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <danielhb413@gmail.com>)
 id 1iUD4a-0006B1-Ec
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 12:01:52 -0500
Received: by mail-qv1-xf42.google.com with SMTP id x14so5170784qvu.0
 for <qemu-devel@nongnu.org>; Mon, 11 Nov 2019 09:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=o+37rkLSugI95LpgNThRWPsnUABBwxEDt0ZiwnaoT3I=;
 b=YA4rv04vyx2F4LHr4HP0It2hhAqLDGEGCm5Tg/f6V1m8gmjPZUbdFDCFuvjyx9ya2J
 J6Ja6xkteZptCqic42+Ee9CA9oLVq1pfy8CTqhutRkb8t10kG1sFsEGSKtiS04rfFPWq
 jD8UAkZsixDx1A0YfN9NBBZ0kpcggMM4jRUbYy3M/qb3FfI3v2iHlzp2nLPWvM/+n043
 5cP4Z3MHH604L3/DJOg5CVFh04JC+QfWKVepapM3bmzgSCDMPHQ2LOtFJKAfsXvuQgFv
 ++g5YBiF9bRWAGw8SXfAR9BR5fAf48ddgDgLOqFNGrThyvfkQhJUlJFi9UD3jNFsnHqu
 InnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=o+37rkLSugI95LpgNThRWPsnUABBwxEDt0ZiwnaoT3I=;
 b=JivH7f4nfrUgJDlTEU8E692qyBr3Ju6KsJnpLVe/JO0Hwl2FNsPUsNEiSQJExdQZOy
 hM7l1k/0CYPfH1PCnuNZMdjnxZQ+7YKAj2KpRq1IkmTqwOd4oJizyTm5yCgsnjGfZfJQ
 B2868tFAizbMJQDaaBXxwDv1pgcumQyfMaDeBjc9fs6NrqUDNq3J/vFc2hqvIsso6UVp
 FRwuYrEmsAbgvQBXEfphEjhOozfToXQQdkq5yvKrrzH0KEZ9r9m5rHUBXld5j/kKbC1T
 QIyvOzejf6gGDXBV9yHVOGy4z9qzeAlggy+l47lQoO+v/gdYP70C5QIAbWIAxZqWCLFS
 tlPQ==
X-Gm-Message-State: APjAAAWifUGYqGlrHxzPihsq1EZNtKf366L9n8DLkyhmFAy0e5l9yqRH
 7J6oTgd9JmIRXkdg3TZTQs3CAhFAqG8=
X-Google-Smtp-Source: APXvYqw9bLWEpCHdqjLXwcm0Wu2S691CJ4o55YttaVt7GDSW/GJFUHLKUWYyy0xKxnBb20l98fRw+Q==
X-Received: by 2002:ad4:538b:: with SMTP id i11mr20167656qvv.211.1573491711676; 
 Mon, 11 Nov 2019 09:01:51 -0800 (PST)
Received: from rekt.ibmuc.com ([2804:431:c7c6:980:1591:e29e:17a4:d484])
 by smtp.gmail.com with ESMTPSA id n20sm8572462qkn.118.2019.11.11.09.01.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Nov 2019 09:01:51 -0800 (PST)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 3/4] crypto.c: cleanup created file when
 block_crypto_co_create_opts_luks fails
Date: Mon, 11 Nov 2019 14:01:30 -0300
Message-Id: <20191111170131.13742-4-danielhb413@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191111170131.13742-1-danielhb413@gmail.com>
References: <20191111170131.13742-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::f42
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
 block/crypto.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/block/crypto.c b/block/crypto.c
index 24823835c1..00e8ec537d 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -30,6 +30,7 @@
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "qemu/option.h"
+#include "qemu/cutils.h"
 #include "crypto.h"
 
 typedef struct BlockCrypto BlockCrypto;
@@ -596,6 +597,23 @@ static int coroutine_fn block_crypto_co_create_opts_luks(const char *filename,
 
     ret = 0;
 fail:
+    /*
+     * If an error occurred, delete 'filename'. Even if the file existed
+     * beforehand, it has been truncated and corrupted in the process.
+     */
+    if (ret && bs) {
+        Error *local_delete_err = NULL;
+        int r_del = bdrv_co_delete_file(bs, &local_delete_err);
+        /*
+         * ENOTSUP will happen if the block driver doesn't support
+         * the 'bdrv_co_delete_file' interface. This is a predictable
+         * scenario and shouldn't be reported back to the user.
+         */
+        if ((r_del < 0) && (r_del != -ENOTSUP)) {
+            error_report_err(local_delete_err);
+        }
+    }
+
     bdrv_unref(bs);
     qapi_free_QCryptoBlockCreateOptions(create_opts);
     qobject_unref(cryptoopts);
-- 
2.21.0


