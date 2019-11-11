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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C2D7C17441
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 17:05:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59F2820679
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 17:05:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AVQTYALo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59F2820679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUD7p-0000H8-2o
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 12:05:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48510)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <danielhb413@gmail.com>) id 1iUD4Y-0006DR-9v
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 12:01:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <danielhb413@gmail.com>) id 1iUD4X-0006A6-7E
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 12:01:50 -0500
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:39126)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <danielhb413@gmail.com>)
 id 1iUD4X-00069y-3i
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 12:01:49 -0500
Received: by mail-qk1-x743.google.com with SMTP id 15so11778724qkh.6
 for <qemu-devel@nongnu.org>; Mon, 11 Nov 2019 09:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uNJX0SlFEqt2tTbkGEN46Hc3OMmBWRvtaEqtJiCobJY=;
 b=AVQTYALosqoshT933GNwh/Fr2UE9UN0e5K07IZf3GvpTO5j6ZVzz9hXw6J0UT1XbCK
 EmWIBJDDPEen19UuPaS5e2YcZRU+EupfxhV7dpzziz/SNiiA9GqdymtFct6GnryCdbw9
 8Jpoh+LhzD5VHvEvyMEUvl4J0zvNofQ5eqqnpqYP7CYtrbSdoGL7Nsy0y1LOTTh7/M1D
 ZFALQ3toL9xTE7zsSzvXfYxJwSaI4tBoqtDtEnbt0lXBntscpskkQ8fMVq9GgqBl3tfK
 tisx0dBpaVidPu6I91+pSjbyjSBou0flkP7RhLhss5SziGpVzpIyNp2xQDdCPk3kw8V9
 hztg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uNJX0SlFEqt2tTbkGEN46Hc3OMmBWRvtaEqtJiCobJY=;
 b=W8zrTpPPgOlgzH6j8KUd/TF2PvwmS40ROmbBh2A860biFOQ2M8RIsuijT7nLcxTYjR
 SMFGgV4eWbXNtx4lGziJuIUwgoksDS5ataJO2+ajIrKNVSgj7shSVd6EhE5sb/YalyWE
 BfngQ4+zpZDvdr2ldFzsskCA9+RV3mz0P/x+4cGN9Nx/+0UWW1vhF9gVvGociR7Cxska
 s7Xve10vNEeGdnYD0oP8DWtGEd8VJJdU2ji5oOsruJMvqtPE5odIChgP+i427r/gIP5/
 36MhXoaLB0DOz3wE3blP+SGIH3GVH5Yql6KIW8YPonzGV8nHwhD/Jh3YyW1GQZ5mUwFP
 w0ew==
X-Gm-Message-State: APjAAAUghjwUrwTGl7MKflca2cp4R8kiv7lWfrLAQbbCnbXch/RYTw1s
 fVb9roMdfR9lRhLV5VNuF0ta4ATR
X-Google-Smtp-Source: APXvYqyzM9PBp+EN/5id1bXFNbkiFDQJAd7qhGVQuHjKH8dkNsRBb9/d8VdE/LyDnhDbWj0jniwXgQ==
X-Received: by 2002:a05:620a:16ba:: with SMTP id
 s26mr11458151qkj.107.1573491708277; 
 Mon, 11 Nov 2019 09:01:48 -0800 (PST)
Received: from rekt.ibmuc.com ([2804:431:c7c6:980:1591:e29e:17a4:d484])
 by smtp.gmail.com with ESMTPSA id n20sm8572462qkn.118.2019.11.11.09.01.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Nov 2019 09:01:47 -0800 (PST)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 1/4] block: introducing 'bdrv_co_delete_file' interface
Date: Mon, 11 Nov 2019 14:01:28 -0300
Message-Id: <20191111170131.13742-2-danielhb413@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191111170131.13742-1-danielhb413@gmail.com>
References: <20191111170131.13742-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::743
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
drivers and add it to the 'file' driver in file-posix.c. The
implementation is given by 'raw_co_delete_file'.

Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 block/file-posix.c        | 23 +++++++++++++++++++++++
 include/block/block_int.h |  4 ++++
 2 files changed, 27 insertions(+)

diff --git a/block/file-posix.c b/block/file-posix.c
index 1f0f61a02b..692a36a799 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -2386,6 +2386,28 @@ static int coroutine_fn raw_co_create_opts(const char *filename, QemuOpts *opts,
     return raw_co_create(&options, errp);
 }
 
+static int coroutine_fn raw_co_delete_file(BlockDriverState *bs,
+                                           Error **errp)
+{
+    struct stat st;
+    int ret;
+
+    if (!(stat(bs->filename, &st) == 0) || !S_ISREG(st.st_mode)) {
+        error_setg_errno(errp, ENOENT, "%s is not a regular file",
+                         bs->filename);
+        return -ENOENT;
+    }
+
+    ret = unlink(bs->filename);
+    if (ret < 0) {
+        ret = -errno;
+        error_setg_errno(errp, -ret, "Error when deleting file %s",
+                         bs->filename);
+    }
+
+    return ret;
+}
+
 /*
  * Find allocation range in @bs around offset @start.
  * May change underlying file descriptor's file offset.
@@ -3017,6 +3039,7 @@ BlockDriver bdrv_file = {
     .bdrv_co_block_status = raw_co_block_status,
     .bdrv_co_invalidate_cache = raw_co_invalidate_cache,
     .bdrv_co_pwrite_zeroes = raw_co_pwrite_zeroes,
+    .bdrv_co_delete_file = raw_co_delete_file,
 
     .bdrv_co_preadv         = raw_co_preadv,
     .bdrv_co_pwritev        = raw_co_pwritev,
diff --git a/include/block/block_int.h b/include/block/block_int.h
index dd033d0b37..d938d3e8d2 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -314,6 +314,10 @@ struct BlockDriver {
      */
     int coroutine_fn (*bdrv_co_flush)(BlockDriverState *bs);
 
+    /* Delete a created file. */
+    int coroutine_fn (*bdrv_co_delete_file)(BlockDriverState *bs,
+                                            Error **errp);
+
     /*
      * Flushes all data that was already written to the OS all the way down to
      * the disk (for example file-posix.c calls fsync()).
-- 
2.21.0


