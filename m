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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1799C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 14:01:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD11C233A1
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 14:01:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KTH5il9s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD11C233A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i59NM-0008M9-2j
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 10:01:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33758)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <danielhb413@gmail.com>) id 1i59JF-0003LT-AX
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 09:57:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <danielhb413@gmail.com>) id 1i59JC-0005ii-7I
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 09:57:25 -0400
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:43717)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <danielhb413@gmail.com>)
 id 1i59JB-0005i9-F5
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 09:57:22 -0400
Received: by mail-qk1-x743.google.com with SMTP id m2so15971093qkd.10
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2019 06:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=WpmpFg50u8+Zk9hRBw0p/auazvjnZ6BkfdcA2q6nNXs=;
 b=KTH5il9sfnCYCI/v6QvRyUGTSPP39h2MqaArraeRgdX8GsLGYaceGzZv4iTdJbglFa
 Hm6V3Yvl5buwprF76WMcrWHxRXuvmTvgfSVwhOsy20+q/1DsCX3GnwWyrs+Wdi0ozUj+
 EUjDtPZPPNbU6cEM8kgj6k3VAc67Wg3IuUQd2BsajASHioOl17hJ6yPrpKB0DE9sBpdR
 1JZOhqGYcJ0PKFUeMDOPJIXE6DJY16DuL856Q9DT3VoRJ82O3Cm6RJJA13wX2BXbNgwK
 HKbyMm1hYit9IeFRJ0ThvzJCvCgLNYXfu5SdkOdV2MXnyrcIE+SyY55ULZ3mbYe5zli4
 pgZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WpmpFg50u8+Zk9hRBw0p/auazvjnZ6BkfdcA2q6nNXs=;
 b=Phgdw0pJbe8LNyXeoZsLelPFyXV+s18s3T5RqJoIm4WcGhZsPp3lGrEUsH74ETnqln
 Z6oRVqtOdBsB2RMaciKXooAsgsduLf5jFXmMxqCdS2RAeuWnD6Akt6LC+XCNpPBsZHQj
 haqRPhhUERWfXWWLrGNrBhvcsH39sO8ofbRVtutKarh9zuGVV35JFUj8uP0VAbuWOy97
 9wMihvEj6NsYtN6I8jEgY7S6RvaqP/G8PmmCY5elO3bMmx/WW0m8gH1coinfqvPOxI5p
 fraVS82r0px4/Rjv/oa980cgu7QZ/GqSXwdD1aWQ3BeCg1V57hEv7yqKSsEkOGvCZQ+v
 1dkw==
X-Gm-Message-State: APjAAAVCn3JibCeWfroalPRZvAAmpD7GY7wm0ohIgsh2RgFBy+LPaqWV
 17q3RkXMY67402lQxyt0Vj+r98uE9kc=
X-Google-Smtp-Source: APXvYqwF4o5v7gBhCtkLCSn944+5ze06oG4fhar0GoUi/8wqReYT1dEobO26gDsZ8tg+Z+RBZeTMmA==
X-Received: by 2002:a37:9c81:: with SMTP id f123mr17201440qke.66.1567519040813; 
 Tue, 03 Sep 2019 06:57:20 -0700 (PDT)
Received: from rekt.ibmuc.com ([2804:431:c7c7:5c9f:9471:e230:52b:8c93])
 by smtp.gmail.com with ESMTPSA id k49sm9211158qtc.9.2019.09.03.06.57.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2019 06:57:20 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Date: Tue,  3 Sep 2019 10:57:06 -0300
Message-Id: <20190903135708.21624-3-danielhb413@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190903135708.21624-1-danielhb413@gmail.com>
References: <20190903135708.21624-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::743
Subject: [Qemu-devel] [PATCH v7 2/4] block.c: adding bdrv_delete_file
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
Cc: kwolf@redhat.com,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, jsnow@redhat.com
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
 block.c               | 73 +++++++++++++++++++++++++++++++++++++++++++
 include/block/block.h |  1 +
 2 files changed, 74 insertions(+)

diff --git a/block.c b/block.c
index 874a29a983..250c69ca7a 100644
--- a/block.c
+++ b/block.c
@@ -548,6 +548,79 @@ int bdrv_create_file(const char *filename, QemuOpts *opts, Error **errp)
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
+    BlockDriver *drv = dco->bs->drv;
+
+    assert(dco->bs);
+
+    dco->ret = drv->bdrv_co_delete_file(dco->bs, &local_err);
+    error_propagate(&dco->err, local_err);
+}
+
+int bdrv_delete_file(BlockDriverState *bs, Error **errp)
+{
+    DeleteCo dco = {
+        .bs = bs,
+        .ret = NOT_DONE,
+        .err = NULL,
+    };
+    Coroutine *co;
+    int ret;
+
+    if (!bs) {
+        error_setg(errp, "Could not open image '%s' for erasing",
+                   bs->filename);
+        ret = -1;
+        goto out;
+    }
+
+    if (!bs->drv) {
+        error_setg(errp, "File '%s' has unknown format", bs->filename);
+        ret = -ENOMEDIUM;
+        goto out;
+    }
+
+    if (!bs->drv->bdrv_co_delete_file) {
+        error_setg(errp, "Driver '%s' does not support image delete",
+                   bs->drv->format_name);
+        ret = -ENOTSUP;
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
+    return ret;
+}
+
 /**
  * Try to get @bs's logical and physical block size.
  * On success, store them in @bsz struct and return 0.
diff --git a/include/block/block.h b/include/block/block.h
index 124ad40809..00fe8d6534 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -374,6 +374,7 @@ bool bdrv_is_backing_chain_frozen(BlockDriverState *bs, BlockDriverState *base,
 int bdrv_freeze_backing_chain(BlockDriverState *bs, BlockDriverState *base,
                               Error **errp);
 void bdrv_unfreeze_backing_chain(BlockDriverState *bs, BlockDriverState *base);
+int bdrv_delete_file(BlockDriverState *bs, Error **errp);
 
 
 typedef struct BdrvCheckResult {
-- 
2.21.0


