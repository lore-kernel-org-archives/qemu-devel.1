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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D76C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 19:49:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A08220828
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 19:49:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GZZbvRGq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A08220828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgwrp-0002R9-Gu
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 15:49:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34393)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <danielhb413@gmail.com>) id 1hgwoP-0000cH-Gr
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 15:45:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <danielhb413@gmail.com>) id 1hgwoM-0000wJ-Oa
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 15:45:33 -0400
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842]:45857)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <danielhb413@gmail.com>)
 id 1hgwoL-0000uB-7T
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 15:45:30 -0400
Received: by mail-qt1-x842.google.com with SMTP id j19so7638145qtr.12
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2019 12:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3dRB10KTGUHWpNRks8/1E0ikbIsIwvHCZ00Qw4pSDZU=;
 b=GZZbvRGqduvOz3B9qUnr4TnV05HDz4oUZMXERzuYI+jMa0QsF+3rMdcwGUHw34NHXd
 lITomlurNAGYbloUnSdKrHusUO+Cg4BexV4Lbj/cYUhqZPLc8ENS9QinY0RVwlrNqHRq
 hLH+VjaLa8Zov6MgbP6gA9I3fGturZrDpkFLzgBwn1o7t0byCgdueS9KuL1pH7FFV7PP
 wzUFhID0KnPPgWehA0Mnsi5ICBtEshGqJ71k2MA06I4h7HZoevjqPU/7+4fGO/Lhx6Wi
 kieA+kYP2K4wl7xJkK34/V8TmxtVgNxWdOK4UaucVWVxoS0GWWAGLBR9vjpH4OfGdE61
 4TYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3dRB10KTGUHWpNRks8/1E0ikbIsIwvHCZ00Qw4pSDZU=;
 b=r9LD6YCpwiEXYnVOQf6FBYm7vWTZfJ2YQJaPcQYpxZY9BUCH6iqx1iImo2wH1QBhPv
 171VL2oaMIzsU/B/CWT0D5AImyHoLYEIGl0yz7S8X7t1hgh/rnAvnWOkRuz0vQMm+Q70
 0+ZpFhtr85fsuWPFojO94T6IngOfKSW7HXv4qNrIEJ6H0Hj8wcRzcN55B40lnozxd0bf
 qwoEUvVuYWbvylnqEo4uhO/xgvBxUFoEg1WcBZWFxVxF8jDgWcAPFbOk61ownNj6Y8Zb
 7NubmFduPauHsG3D6x6z+2n8uREgxoWF9dRqKgYmzsd9Q3W3QKiYwbBKzNUwjDCXs8jB
 lD0g==
X-Gm-Message-State: APjAAAWdrQPLGF0lV3btersjCXRKUmwuF3WSMoGDZws6Y+qLF09sKguO
 poW+7X7U7Po865A9Xmql/EdazU3C
X-Google-Smtp-Source: APXvYqwQ+hvlU5il0QFnGfKApgU/hDkHqjUSCX1vzQvPS4L8x3YU65SOQJLOsP/td+9LPaUr/xYp/Q==
X-Received: by 2002:ac8:2dcf:: with SMTP id q15mr9785228qta.170.1561751127617; 
 Fri, 28 Jun 2019 12:45:27 -0700 (PDT)
Received: from rekt.ibmuc.com ([2804:431:c7c6:927e:501b:7135:21ca:8a87])
 by smtp.gmail.com with ESMTPSA id b69sm1602288qkg.105.2019.06.28.12.45.26
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 28 Jun 2019 12:45:27 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri, 28 Jun 2019 16:45:10 -0300
Message-Id: <20190628194512.21311-3-danielhb413@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190628194512.21311-1-danielhb413@gmail.com>
References: <20190628194512.21311-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::842
Subject: [Qemu-devel] [PATCH v4 2/4] block.c: adding bdrv_delete_file
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
 block.c               | 71 +++++++++++++++++++++++++++++++++++++++++++
 include/block/block.h |  2 ++
 2 files changed, 73 insertions(+)

diff --git a/block.c b/block.c
index 6e2b0f528d..11675cfcee 100644
--- a/block.c
+++ b/block.c
@@ -547,6 +547,77 @@ int bdrv_create_file(const char *filename, QemuOpts *opts, Error **errp)
     return ret;
 }
 
+static void coroutine_fn bdrv_delete_co_entry(void *opaque)
+{
+    Error *local_err = NULL;
+    int ret;
+
+    CreateCo *cco = opaque;
+    assert(cco->drv);
+
+    ret = cco->drv->bdrv_co_delete_file(cco->filename, &local_err);
+    error_propagate(&cco->err, local_err);
+    cco->ret = ret;
+}
+
+int bdrv_delete_file(const char *filename, Error **errp)
+{
+
+    BlockDriver *drv = bdrv_find_protocol(filename, true, errp);
+    CreateCo cco = {
+        .drv = drv,
+        .filename = g_strdup(filename),
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
+    if (!drv->bdrv_co_delete_file) {
+        error_setg(errp, "Driver '%s' does not support image delete",
+                   drv->format_name);
+        ret = -ENOTSUP;
+        goto out;
+    }
+
+    if (qemu_in_coroutine()) {
+        /* Fast-path if already in coroutine context */
+        bdrv_delete_co_entry(&cco);
+    } else {
+        co = qemu_coroutine_create(bdrv_delete_co_entry, &cco);
+        qemu_coroutine_enter(co);
+        while (cco.ret == NOT_DONE) {
+            aio_poll(qemu_get_aio_context(), true);
+        }
+    }
+
+    ret = cco.ret;
+    if (ret < 0) {
+        if (cco.err) {
+            error_propagate(errp, cco.err);
+        } else {
+            error_setg_errno(errp, -ret, "Could not delete image");
+        }
+    }
+
+out:
+    g_free(cco.filename);
+    return ret;
+}
+
 /**
  * Try to get @bs's logical and physical block size.
  * On success, store them in @bsz struct and return 0.
diff --git a/include/block/block.h b/include/block/block.h
index d287eaa9a6..5747f2a060 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -371,6 +371,8 @@ int bdrv_freeze_backing_chain(BlockDriverState *bs, BlockDriverState *base,
 void bdrv_unfreeze_backing_chain(BlockDriverState *bs, BlockDriverState *base);
 
 bool bdrv_path_is_regular_file(const char *path);
+int bdrv_delete_file(const char *filename, Error **errp);
+
 
 typedef struct BdrvCheckResult {
     int corruptions;
-- 
2.20.1


