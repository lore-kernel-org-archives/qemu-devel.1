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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA78C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 17:10:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 843CA214E0
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 17:10:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mvAC5Rqe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 843CA214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUDCt-0005XM-JC
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 12:10:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48527)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <danielhb413@gmail.com>) id 1iUD4a-0006Fn-1U
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 12:01:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <danielhb413@gmail.com>) id 1iUD4Y-0006Ao-Q5
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 12:01:51 -0500
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842]:38155)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <danielhb413@gmail.com>)
 id 1iUD4Y-0006AZ-MK
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 12:01:50 -0500
Received: by mail-qt1-x842.google.com with SMTP id p20so16394193qtq.5
 for <qemu-devel@nongnu.org>; Mon, 11 Nov 2019 09:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1+2lpgu3zdyL7nO6XorDplIsYsvqY/zmN6+JOXbDLAk=;
 b=mvAC5Rqe5bLIv86SrqVUisl6QYI6xqUQNsrBq1XdaR42YcfpzYzCYWcrWZHF1AoTwj
 hFJNGrLJpxdW0aA6JwOkDFo2sVhLXnQCkc/LnUg52RdV4sd6KPIkACRaKIlU0/yq9GN9
 4zHHdM97xS8v8iEP/4M7bknk2v5rutkPkK/Rj7C9ld1UpgopZAEuHJrJeZb1K80lrCNk
 6OyiqILnxlcfENSnDSPuK6SDD8OwkGkh9qh0CAu6XgZPw3+MA/0H+o98Jj0n3UvzqLGO
 AcreIhnkLKnzXlavpeCoCu9o0lJrneGgWwnjKbxtPIRGGSp1az0VtFWWUFJh4KkICVhH
 qyQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1+2lpgu3zdyL7nO6XorDplIsYsvqY/zmN6+JOXbDLAk=;
 b=Addaj5rx1NbN5L/u2j/em1WXd8P6xEO9lJuGS3yZXY7yzZzhinG9Uh9m6QR3zL+fI8
 RlTMY62tbKX7626XFCCUdWDPWaFfr8v+j2Dtn73I17IxtqfDo+7AyPlQIb68mWYnTWCA
 PPYfVbkNGrovjMUZ3+vCFk0RKQ5xJQujf3UyfRU64yP56/96iof8nWeo3vQUhKAmgnZr
 H5395U3VEsiIp/FbWrcf+T1GI2j+MzMsh1XwgLp6YK9CSCpdEpQxvs6zAKGFXMnGamYV
 sIWKnZdR7lAkoEXY/dXxBfvmVzQ5oI33lEq16oc33Wl7fNM1SZd7ApsodgklBEP/JFWM
 m6tg==
X-Gm-Message-State: APjAAAW/oRQP5+bRoBC74iw8b8gaFGKpHSTZo5dRxidYl5TL1UWONgJW
 vBQRUZTXlMUYEuVziue9ArgKorea
X-Google-Smtp-Source: APXvYqyDQhssQzACInutuxrgHlKwhOkFaItxRpF5Ej+aQ0EJcy0aakk9/77JjEBeCLHSQ1g2+l+bbg==
X-Received: by 2002:ac8:38e3:: with SMTP id g32mr26567848qtc.103.1573491709975; 
 Mon, 11 Nov 2019 09:01:49 -0800 (PST)
Received: from rekt.ibmuc.com ([2804:431:c7c6:980:1591:e29e:17a4:d484])
 by smtp.gmail.com with ESMTPSA id n20sm8572462qkn.118.2019.11.11.09.01.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Nov 2019 09:01:49 -0800 (PST)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 2/4] block.c: adding bdrv_co_delete_file
Date: Mon, 11 Nov 2019 14:01:29 -0300
Message-Id: <20191111170131.13742-3-danielhb413@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191111170131.13742-1-danielhb413@gmail.com>
References: <20191111170131.13742-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::842
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

Using the new 'bdrv_co_delete_file' interface, a pure co_routine function
'bdrv_co_delete_file' inside block.c can can be used in a way similar of
the existing bdrv_create_file to to clean up a created file.

We're creating a pure co_routine because the only caller of
'bdrv_co_delete_file' will be already in co_routine context, thus there
is no need to add all the machinery to check for qemu_in_coroutine() and
create a separated co_routine to do the job.

Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 block.c               | 26 ++++++++++++++++++++++++++
 include/block/block.h |  1 +
 2 files changed, 27 insertions(+)

diff --git a/block.c b/block.c
index 4cffc2bc35..c325104b8c 100644
--- a/block.c
+++ b/block.c
@@ -548,6 +548,32 @@ int bdrv_create_file(const char *filename, QemuOpts *opts, Error **errp)
     return ret;
 }
 
+int coroutine_fn bdrv_co_delete_file(BlockDriverState *bs, Error **errp)
+{
+    Error *local_err = NULL;
+    int ret;
+
+    assert(bs != NULL);
+
+    if (!bs->drv) {
+        error_setg(errp, "Block node '%s' is not opened", bs->filename);
+        return -ENOMEDIUM;
+    }
+
+    if (!bs->drv->bdrv_co_delete_file) {
+        error_setg(errp, "Driver '%s' does not support image deletion",
+                   bs->drv->format_name);
+        return -ENOTSUP;
+    }
+
+    ret = bs->drv->bdrv_co_delete_file(bs, &local_err);
+    if (ret < 0) {
+        error_propagate(errp, local_err);
+    }
+
+    return ret;
+}
+
 /**
  * Try to get @bs's logical and physical block size.
  * On success, store them in @bsz struct and return 0.
diff --git a/include/block/block.h b/include/block/block.h
index 1df9848e74..ec0d82f6b0 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -372,6 +372,7 @@ bool bdrv_is_backing_chain_frozen(BlockDriverState *bs, BlockDriverState *base,
 int bdrv_freeze_backing_chain(BlockDriverState *bs, BlockDriverState *base,
                               Error **errp);
 void bdrv_unfreeze_backing_chain(BlockDriverState *bs, BlockDriverState *base);
+int coroutine_fn bdrv_co_delete_file(BlockDriverState *bs, Error **errp);
 
 
 typedef struct BdrvCheckResult {
-- 
2.21.0


