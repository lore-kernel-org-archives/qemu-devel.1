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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD2F1C3A59E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 20:59:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB6FF21670
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 20:59:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T8oZEohI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB6FF21670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i4tQZ-0006kz-Pq
	for qemu-devel@archiver.kernel.org; Mon, 02 Sep 2019 16:59:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33402)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <danielhb413@gmail.com>) id 1i4tPb-0005pe-Qp
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 16:58:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <danielhb413@gmail.com>) id 1i4tPa-0004Fc-PP
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 16:58:55 -0400
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844]:43907)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <danielhb413@gmail.com>)
 id 1i4tPa-0004EZ-L1
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 16:58:54 -0400
Received: by mail-qt1-x844.google.com with SMTP id l22so4715029qtp.10
 for <qemu-devel@nongnu.org>; Mon, 02 Sep 2019 13:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=VSXNt8Kn3icnDHyUvJOBRa++l6851CYhlNFBcR1U6UQ=;
 b=T8oZEohIrzAdd5PFQXwnFFz/IxZ4PpOwm7nxtbmXEb3mZsuYwU8aGee4iyHY4I7z/B
 wk2h9wQkUzbXjEvII9oeFmcbk6XGUXqxZ7cvAzD+2Kx1jpHBxiqK22giaGFeefdS6U7X
 RqyuaLhXPcl7pOpysNDtxlOTTjslA8j7FVJLLpvKuEZX8ZUg7mpi2KdVrz9chpaHvee6
 rjn613l6EqwoKzO+MPB4XlZeYSMnWzX3j2Ux3I26Pjb56LnZS2jOsNuM91T4LIf37G1I
 z7blZKuTiRWcKHVtgWjM1nhxCbqLlFBtwP7uYGz6RPFKy6Kf3QfqFfcBwGZ9ncrNfAwV
 XuUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VSXNt8Kn3icnDHyUvJOBRa++l6851CYhlNFBcR1U6UQ=;
 b=qZAd0K1WY2iBfRo27XcVQmHxt+mTL1ByQuFzPzsrN1SCQqLie7I3Krx402FEE1ukFZ
 4X9l3AmdST57c5JfQWvU05OMHdZ0I4dceWKvC1xo3znbU9RRvJqi40pUxAbDMCrcqXeX
 uQeEoEJRorvqvwVk6VE8TOydWBpKTCqHlwbgPzsTXQD+E6fh6lsJH0W6gPGkL4jtdCrB
 xXwvMcCOO7nm+DMvG/MPQnY2w5mPSG2eMQyaJJ1Dls0EC5F+4wlHUt3wM42ATfMAn13I
 CqmnEbHKnOWDvtMjTk1Aojang46aGHDTqKEINhdrjYAe3B6k85+VOkKIw/OAfbnGPJhs
 C00w==
X-Gm-Message-State: APjAAAWH6w6cgRvWuREuqcSwWE9YTdc5ITkuq7DxiRFuPwnn4mmQCMJr
 dWAhfSAcGhljXElAXECLrdHpW/r9
X-Google-Smtp-Source: APXvYqxRIDM0dRA3cFdzCsAhfcEZcFNcE/CSRHie+LUQNxhNl/MbmwDvUCvJ/fiHpSvCnRiHPdHGNQ==
X-Received: by 2002:ac8:6916:: with SMTP id e22mr29288521qtr.313.1567457933847; 
 Mon, 02 Sep 2019 13:58:53 -0700 (PDT)
Received: from rekt.ibmuc.com ([2804:431:c7c6:9589:1351:c7eb:87b:c9d5])
 by smtp.gmail.com with ESMTPSA id w80sm4604038qka.62.2019.09.02.13.58.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Sep 2019 13:58:53 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon,  2 Sep 2019 17:58:39 -0300
Message-Id: <20190902205842.1884-2-danielhb413@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190902205842.1884-1-danielhb413@gmail.com>
References: <20190902205842.1884-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::844
Subject: [Qemu-devel] [PATCH v6 1/4] block: introducing
 'bdrv_co_delete_file' interface
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

Adding to Block Drivers the capability of being able to clean up
its created files can be useful in certain situations. For the
LUKS driver, for instance, a failure in one of its authentication
steps can leave files in the host that weren't there before.

This patch adds the 'bdrv_co_delete_file' interface to block
drivers and add it to the 'file' driver in file-posix.c.The
implementation is given by 'raw_co_delete_file'.

Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 block/file-posix.c        | 28 ++++++++++++++++++++++++++++
 include/block/block_int.h |  6 ++++++
 2 files changed, 34 insertions(+)

diff --git a/block/file-posix.c b/block/file-posix.c
index fbeb0068db..52756de522 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -2390,6 +2390,33 @@ static int coroutine_fn raw_co_create_opts(const char *filename, QemuOpts *opts,
     return raw_co_create(&options, errp);
 }
 
+/**
+ * Co-routine function that erases a regular file.
+ */
+static int coroutine_fn raw_co_delete_file(BlockDriverState *bs,
+                                           Error **errp)
+{
+    struct stat st;
+    int ret;
+
+    if (!(stat(bs->filename, &st) == 0) || !S_ISREG(st.st_mode)) {
+        ret = -ENOENT;
+        error_setg_errno(errp, -ret, "%s is not a regular file",
+                         bs->filename);
+        goto done;
+    }
+
+    ret = unlink(bs->filename);
+    if (ret < 0) {
+        ret = -errno;
+        error_setg_errno(errp, -ret, "Error when deleting file %s",
+                         bs->filename);
+    }
+
+done:
+    return ret;
+}
+
 /*
  * Find allocation range in @bs around offset @start.
  * May change underlying file descriptor's file offset.
@@ -2942,6 +2969,7 @@ BlockDriver bdrv_file = {
     .bdrv_co_block_status = raw_co_block_status,
     .bdrv_co_invalidate_cache = raw_co_invalidate_cache,
     .bdrv_co_pwrite_zeroes = raw_co_pwrite_zeroes,
+    .bdrv_co_delete_file = raw_co_delete_file,
 
     .bdrv_co_preadv         = raw_co_preadv,
     .bdrv_co_pwritev        = raw_co_pwritev,
diff --git a/include/block/block_int.h b/include/block/block_int.h
index ceec8c2f56..1442c75e3c 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -308,6 +308,12 @@ struct BlockDriver {
      */
     int coroutine_fn (*bdrv_co_flush)(BlockDriverState *bs);
 
+    /*
+     * Delete a local created file.
+     */
+    int coroutine_fn (*bdrv_co_delete_file)(BlockDriverState *bs,
+                                            Error **errp);
+
     /*
      * Flushes all data that was already written to the OS all the way down to
      * the disk (for example file-posix.c calls fsync()).
-- 
2.21.0


