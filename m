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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1604C5B579
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 19:49:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B387820828
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 19:49:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vTkidy8p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B387820828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgwrp-0002Rb-Uq
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 15:49:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34394)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <danielhb413@gmail.com>) id 1hgwoP-0000cI-Ge
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 15:45:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <danielhb413@gmail.com>) id 1hgwoM-0000w6-Ny
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 15:45:33 -0400
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844]:35538)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <danielhb413@gmail.com>)
 id 1hgwoK-0000tS-GH
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 15:45:30 -0400
Received: by mail-qt1-x844.google.com with SMTP id d23so7690651qto.2
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2019 12:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=fo3Hzp32nsqM8Vt21whJF5z18eDh+DMJbuyQcmDsrqE=;
 b=vTkidy8pFwISB+yI/LnHbWMmSTsqr067wxfE/72uxcR3FTQc5nbpg9ONNWIf08zi2L
 BF+Nmv7NxYgn86pSh+l+joyISty4zGUs0vaMlI+Z38RX43f+BxgOADoBsJr0l7a89biN
 DBIopTKpD+sxhpnTqct6+7JyUo8E7lPXYKXuOnqOh2yhO6C4hvvL9u5ewnyb8vcmoS/W
 Q4H6L1YGk1JcX8gjMD07YrhGr2w4Q8d0tDKobE5dSu8k1Ly1xd4uG6H//1kUcGF67ttB
 IWJmyf5IIjNlHOLMAxQbNzRdX+lj4qaDwfpdnNkXA7P0ybTZvV5EOiIPnxx7xDFEBZ1r
 aE1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=fo3Hzp32nsqM8Vt21whJF5z18eDh+DMJbuyQcmDsrqE=;
 b=MbD1HMSJhh8VzyGcyvnKamA8LrAP11s8iGTlG41nENzOLIYdtV94C9Oew7CzERd0l4
 hCDijTM3n6pIJQZ/gXL4ue7Z2U0b9SvppOczMBr/U+pbVRWiVa7T957tS9xjWl5zj7OI
 J0WwtapaG/r8GOf4lq2IWK8nt7NWt0IICJWlbd7PCBZJTn1G/ZWr56JC1CfQhtG5S0VJ
 NGMFeH98VmU/zDge4gwIvlj49ItPP6bDN5bUVwSR1BFr4o6ZBo0na2G3Kd+sym5A4HMY
 hhUmIVlaFD437e5O6xDez7qLGd6xZrZSY0+JzLplhhg+Zo96Oeix9a69eKTvsLn6uNMZ
 OSNg==
X-Gm-Message-State: APjAAAUerdB2SLaRCjiZeHpZe12QlFSrBpTdw4m/q3+B9j3UWeQ6x03u
 jjVNSLbLCTTmANq0x537qPcR3fuA
X-Google-Smtp-Source: APXvYqyaHEsEhQfpeTsQNjWd3SADfHr6m6c/1k/QQjBa31/NXH2+xjZ/BlmIQnUmqAnN52pKKImvWQ==
X-Received: by 2002:ac8:27d4:: with SMTP id x20mr9465269qtx.138.1561751125916; 
 Fri, 28 Jun 2019 12:45:25 -0700 (PDT)
Received: from rekt.ibmuc.com ([2804:431:c7c6:927e:501b:7135:21ca:8a87])
 by smtp.gmail.com with ESMTPSA id b69sm1602288qkg.105.2019.06.28.12.45.23
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 28 Jun 2019 12:45:25 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri, 28 Jun 2019 16:45:09 -0300
Message-Id: <20190628194512.21311-2-danielhb413@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190628194512.21311-1-danielhb413@gmail.com>
References: <20190628194512.21311-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::844
Subject: [Qemu-devel] [PATCH v4 1/4] block: introducing
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
Cc: kwolf@redhat.com, jsnow@redhat.com,
 Daniel Henrique Barboza <danielhb413@gmail.com>, berrange@redhat.com,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Adding to Block Drivers the capability of being able to clean up
its created files can be useful in certain situations. For the
LUKS driver, for instance, a failure in one of its authentication
steps can leave files in the host that weren't there before.

This patch adds the 'bdrv_co_delete_file' interface to block
drivers and add it to the 'file' driver in file-posix.c. The
implementation is given by 'raw_co_delete_file'. The helper
'bdrv_path_is_regular_file' is being used only in raw_co_delete_file
at this moment, but it will be used inside LUKS in a later patch.
Foreseeing this future use, let's put it in block.c and make it
public.

Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 block.c                   | 11 +++++++++++
 block/file-posix.c        | 28 ++++++++++++++++++++++++++++
 include/block/block.h     |  1 +
 include/block/block_int.h |  6 ++++++
 4 files changed, 46 insertions(+)

diff --git a/block.c b/block.c
index c139540f2b..6e2b0f528d 100644
--- a/block.c
+++ b/block.c
@@ -621,6 +621,17 @@ int get_tmp_filename(char *filename, int size)
 #endif
 }
 
+/**
+ * Helper that checks if a given string represents a regular
+ * local file.
+ */
+bool bdrv_path_is_regular_file(const char *path)
+{
+    struct stat st;
+
+    return (stat(path, &st) == 0) && S_ISREG(st.st_mode);
+}
+
 /*
  * Detect host devices. By convention, /dev/cdrom[N] is always
  * recognized as a host CDROM.
diff --git a/block/file-posix.c b/block/file-posix.c
index ab05b51a66..c8a0b109c2 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -2374,6 +2374,33 @@ static int coroutine_fn raw_co_create_opts(const char *filename, QemuOpts *opts,
     return raw_co_create(&options, errp);
 }
 
+/**
+ * Co-routine function that erases a regular file.
+ */
+static int coroutine_fn raw_co_delete_file(const char *filename,
+                                           Error **errp)
+{
+    int ret;
+
+    /* Skip file: protocol prefix */
+    strstart(filename, "file:", &filename);
+
+    if (!bdrv_path_is_regular_file(filename)) {
+        ret = -ENOENT;
+        error_setg_errno(errp, -ret, "%s is not a regular file", filename);
+        goto done;
+    }
+
+    ret = unlink(filename);
+    if (ret < 0) {
+        ret = -errno;
+        error_setg_errno(errp, -ret, "Error when deleting file %s", filename);
+    }
+
+done:
+    return ret;
+}
+
 /*
  * Find allocation range in @bs around offset @start.
  * May change underlying file descriptor's file offset.
@@ -2925,6 +2952,7 @@ BlockDriver bdrv_file = {
     .bdrv_co_block_status = raw_co_block_status,
     .bdrv_co_invalidate_cache = raw_co_invalidate_cache,
     .bdrv_co_pwrite_zeroes = raw_co_pwrite_zeroes,
+    .bdrv_co_delete_file = raw_co_delete_file,
 
     .bdrv_co_preadv         = raw_co_preadv,
     .bdrv_co_pwritev        = raw_co_pwritev,
diff --git a/include/block/block.h b/include/block/block.h
index f9415ed740..d287eaa9a6 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -370,6 +370,7 @@ int bdrv_freeze_backing_chain(BlockDriverState *bs, BlockDriverState *base,
                               Error **errp);
 void bdrv_unfreeze_backing_chain(BlockDriverState *bs, BlockDriverState *base);
 
+bool bdrv_path_is_regular_file(const char *path);
 
 typedef struct BdrvCheckResult {
     int corruptions;
diff --git a/include/block/block_int.h b/include/block/block_int.h
index d6415b53c1..6d4135ff54 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -309,6 +309,12 @@ struct BlockDriver {
      */
     int coroutine_fn (*bdrv_co_flush)(BlockDriverState *bs);
 
+    /*
+     * Delete a local created file.
+     */
+    int coroutine_fn (*bdrv_co_delete_file)(const char *filename,
+                                            Error **errp);
+
     /*
      * Flushes all data that was already written to the OS all the way down to
      * the disk (for example file-posix.c calls fsync()).
-- 
2.20.1


