Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DAC1C32751
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 14:23:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E050521E70
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 14:23:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HX4HWE6/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E050521E70
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvMqO-0001Hl-80
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 10:23:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39018)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <danielhb413@gmail.com>) id 1hvMoo-00061r-O0
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 10:21:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <danielhb413@gmail.com>) id 1hvMon-00005D-6N
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 10:21:34 -0400
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741]:33998)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <danielhb413@gmail.com>)
 id 1hvMon-000054-2T
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 10:21:33 -0400
Received: by mail-qk1-x741.google.com with SMTP id t8so65900057qkt.1
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 07:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9epP7UsNCqbjxzCDIUUM8j75jBuiFJRy3qqtGTzHLVk=;
 b=HX4HWE6/5/Ks2Ubcp/8NLOuMnwuvPC5rrmOv37ezmUJy4SF2Ezz3HVUhhkJJ3OLOsc
 fFvXjZgp4qh3sKRaiqbRyHAqMn2sd5rM4LamrRjWuIUvGyEfGUkjbpa+Q8FWqvDl8pe2
 fG4L/SAQoVRn7/gZ2mbogNjMd9ZqzB0Nbaa4SrYZ7TkzlTKu4F8yK5md3e+kXBRE2nLo
 nxhOKVWjUQrqf+trTDvMyKNip2VeA1je1GbNOXDqMZuFHue3Gjs9d6cW+w+9v14EGDww
 HmkE2MaYe7OsNu+NUuxJbCIUs7zYcQOxa/AAiuRAswozirzvoB5FvOr5hYypAQKPTVMZ
 kl0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9epP7UsNCqbjxzCDIUUM8j75jBuiFJRy3qqtGTzHLVk=;
 b=VkzgLWMuk8/Q1SZRtczS2VLu6r4ajRYx5yWG63kTGSqtmyLmNk+c0n9Lb4mGLbxIzG
 ia8Srn3Y8jTiC0yd+YpDePAFQMyEwgsmHHYrDQ9GYWWVsovtDknTY3yUR/0PWgNq2sX1
 z535MS+HFrCbWDko2sVuHtwSHnFvhcIRsxy5uUIq8x8MuQ/n/tPNcJQZd224+TtgNQ58
 m+jXw4My/YVFZDC/qEguZZyKtJzUzukvkxEiF5LwTyiyIOmWO3RlhPQyGlM+CVRzl9aV
 k5Qs76AzZ5T5hFC0Mgkf6OPvJ/LPv/F/pMj9vrkGKd2WkAMQ6Gcihbt00YullTcAD/vy
 seTA==
X-Gm-Message-State: APjAAAXpDrRndUWzkGKilJkWdaw1l9RDKyUOpTgUyVf7/XJJrK7iYGwM
 vvJ9QeLpTGMIX9VsKDD36Z6S+An5
X-Google-Smtp-Source: APXvYqznVeecbHpwuNVYJxe6IIPtNIigC44qNTn0/sb1tpUMlJrsuO7MV+ctZiPp+1ffC0KdCehwJw==
X-Received: by 2002:a05:620a:10bc:: with SMTP id
 h28mr8350840qkk.289.1565187692452; 
 Wed, 07 Aug 2019 07:21:32 -0700 (PDT)
Received: from rekt.ibmuc.com ([2804:431:c7c7:5ef4:7266:b7a7:9def:f8fc])
 by smtp.gmail.com with ESMTPSA id e18sm31472034qkm.49.2019.08.07.07.21.30
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 07 Aug 2019 07:21:32 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed,  7 Aug 2019 11:21:12 -0300
Message-Id: <20190807142114.17569-3-danielhb413@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190807142114.17569-1-danielhb413@gmail.com>
References: <20190807142114.17569-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::741
Subject: [Qemu-devel] [PATCH v5 2/4] block.c: adding bdrv_delete_file
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
Cc: kwolf@redhat.com, jsnow@redhat.com,
 Daniel Henrique Barboza <danielhb413@gmail.com>, berrange@redhat.com,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Using the new 'bdrv_co_delete_file' interface, bdrv_delete_file
can be used in a way similar of the existing bdrv_create_file to
to clean up a created file.

The logic is also similar to what is already done in bdrv_create_file:
a qemu_coroutine is created if needed, a specialized function
bdrv_delete_co_entry is used to call the bdrv_co_delete_file
co-routine of the driver, if the driver implements it.

Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 block.c               | 77 +++++++++++++++++++++++++++++++++++++++++++
 include/block/block.h |  1 +
 2 files changed, 78 insertions(+)

diff --git a/block.c b/block.c
index cbd8da5f3b..1e20250627 100644
--- a/block.c
+++ b/block.c
@@ -547,6 +547,83 @@ int bdrv_create_file(const char *filename, QemuOpts *opts, Error **errp)
     return ret;
 }
 
+typedef struct DeleteCo {
+    BlockDriver *drv;
+    BlockDriverState *bs;
+    int ret;
+    Error *err;
+} DeleteCo;
+
+static void coroutine_fn bdrv_delete_co_entry(void *opaque)
+{
+    Error *local_err = NULL;
+    DeleteCo *dco = opaque;
+
+    assert(dco->bs);
+
+    dco->ret = dco->drv->bdrv_co_delete_file(dco->bs, &local_err);
+    error_propagate(&dco->err, local_err);
+}
+
+int bdrv_delete_file(const char *filename, Error **errp)
+{
+    BlockDriver *drv = bdrv_find_protocol(filename, true, NULL);
+    BlockDriverState *bs = bdrv_open(filename, NULL, NULL,
+                                     BDRV_O_RDWR | BDRV_O_PROTOCOL, NULL);
+    DeleteCo dco = {
+        .drv = drv,
+        .bs = bs,
+        .ret = NOT_DONE,
+        .err = NULL,
+    };
+    Coroutine *co;
+    int ret;
+
+    if (!drv) {
+        error_setg(errp, "File '%s' has unknown format", filename);
+        ret = -ENOENT;
+        goto out;
+    }
+
+    if (!drv->bdrv_co_delete_file) {
+        error_setg(errp, "Driver '%s' does not support image delete",
+                   drv->format_name);
+        ret = -ENOTSUP;
+        goto out;
+    }
+
+    if (!bs) {
+        error_setg(errp, "Could not open image '%s' for erasing",
+                   filename);
+        ret = 1;
+        goto out;
+    }
+
+    if (qemu_in_coroutine()) {
+        /* Fast-path if already in coroutine context */
+        bdrv_delete_co_entry(&dco);
+    } else {
+        co = qemu_coroutine_create(bdrv_delete_co_entry, &dco);
+        qemu_coroutine_enter(co);
+        while (dco.ret == NOT_DONE) {
+            aio_poll(qemu_get_aio_context(), true);
+        }
+    }
+
+    ret = dco.ret;
+    if (ret < 0) {
+        if (dco.err) {
+            error_propagate(errp, dco.err);
+        } else {
+            error_setg_errno(errp, -ret, "Could not delete image");
+        }
+    }
+
+out:
+    bdrv_unref(bs);
+    return ret;
+}
+
 /**
  * Try to get @bs's logical and physical block size.
  * On success, store them in @bsz struct and return 0.
diff --git a/include/block/block.h b/include/block/block.h
index 50a07c1c33..5e83532364 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -369,6 +369,7 @@ bool bdrv_is_backing_chain_frozen(BlockDriverState *bs, BlockDriverState *base,
 int bdrv_freeze_backing_chain(BlockDriverState *bs, BlockDriverState *base,
                               Error **errp);
 void bdrv_unfreeze_backing_chain(BlockDriverState *bs, BlockDriverState *base);
+int bdrv_delete_file(const char *filename, Error **errp);
 
 
 typedef struct BdrvCheckResult {
-- 
2.21.0


