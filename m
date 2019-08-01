Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E5DFC433FF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 23:45:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 350B4206A3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 23:45:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nl7yPej3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 350B4206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htKkx-00038v-D1
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 19:45:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60442)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mehta.aaru20@gmail.com>) id 1htKhf-0006Ea-4G
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 19:41:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mehta.aaru20@gmail.com>) id 1htKhd-0002ti-W8
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 19:41:47 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:37744)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mehta.aaru20@gmail.com>)
 id 1htKhd-0002ss-Qd; Thu, 01 Aug 2019 19:41:45 -0400
Received: by mail-pf1-x441.google.com with SMTP id 19so34949034pfa.4;
 Thu, 01 Aug 2019 16:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=LR9iVRChMwWQAhc5h02KM+c31gdyfKaD2veUCMmmXek=;
 b=Nl7yPej316VPS/Y8Fo9dL6Wra7A9Wq7t6eL6hFmZuR3VmXdQ8Z19K9Wqd2jEOAQNq4
 875eL2uCzASxxfRHBAFVLwoW2h+VwigRcZtFW4a+8ykA/bo0RUGlZGv3QM6JfvK1uhrr
 fiGGmDUgJ41ZBFmH0UpsClagFw1URNBDduryybk+IJwkx4CfHrsaMTnwWdhwiO+LUYy0
 nv9aar6AIrTSY42eH1Om7eEITlOuXLttK6E7zMHswZyWqq8c2n0Mtdw3JGN6kttEdU0c
 5pGd1DMJYH7s76uSWJi+pIhDcc08+STVvNzXUy1P747vG5w4gZl89yMkbvWSFIXqiD/w
 7jUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LR9iVRChMwWQAhc5h02KM+c31gdyfKaD2veUCMmmXek=;
 b=et4w1fSrXVdOvQUTb5ENg65uhJ8gGoe1D9WscZfKqBQzm8DFDQDlJ6vm0YgvXNV+Su
 8PIkIqNokuzcJ94ers4O1SMTVo46nD2qjDlAanQsORALvCTKabQrX1ZNTptmLZyduQXn
 PKQlSFo74cjUGRqeIC+wnNB+HV+SoEijrjkgoVOShBPWv/VRoz+EQG4mdZ1UhgoMnDVb
 gV4A5KCYfKjOG1HuYjH/p8BlM6eBAkmN2OWgp8DPKCoGiBQe9e9XgC0FHE5FqYyu4jLj
 GNBMvUu+dEiRFNBZ++csWhY5rY/y7n3M4jB6sCQDfclj7z9NSqIIUvds8iJYAEUpZCox
 oMDQ==
X-Gm-Message-State: APjAAAU0D4ao+peSKYGSzezSOuUaz/4r/89b8kvAeb57yBwBgsglC0lV
 wFRbeMV92j2PkQeZVQu4R5CR5KF67zk/LQ==
X-Google-Smtp-Source: APXvYqxBfK02PR2ZSDa2jRkfg9Ax6fk2cwlKvVY5Lp/iDlZZ1w7fVlzALf0S1OqHUuKyR/kaJAJXDA==
X-Received: by 2002:a17:90a:fa07:: with SMTP id
 cm7mr1316344pjb.115.1564702904441; 
 Thu, 01 Aug 2019 16:41:44 -0700 (PDT)
Received: from localhost.localdomain ([2402:3a80:572:3de5:765:cb16:92cd:ee3e])
 by smtp.gmail.com with ESMTPSA id
 g18sm117975426pgm.9.2019.08.01.16.41.39
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 01 Aug 2019 16:41:43 -0700 (PDT)
From: Aarushi Mehta <mehta.aaru20@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri,  2 Aug 2019 05:10:21 +0530
Message-Id: <20190801234031.29561-8-mehta.aaru20@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190801234031.29561-1-mehta.aaru20@gmail.com>
References: <20190801234031.29561-1-mehta.aaru20@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: [Qemu-devel] [PATCH v9 07/17] blockdev: adds bdrv_parse_aio to use
 io_uring
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
Cc: Kevin Wolf <kwolf@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 Sergio Lopez <slp@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 saket.sinha89@gmail.com, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Stefan Hajnoczi <stefan@redhat.com>, Julia Suvorova <jusual@mail.ru>,
 Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block.c               | 22 ++++++++++++++++++++++
 blockdev.c            | 12 ++++--------
 include/block/block.h |  1 +
 3 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/block.c b/block.c
index cbd8da5f3b..401831e28d 100644
--- a/block.c
+++ b/block.c
@@ -844,6 +844,28 @@ static BlockdevDetectZeroesOptions bdrv_parse_detect_zeroes(QemuOpts *opts,
     return detect_zeroes;
 }
 
+/**
+ * Set open flags for aio engine
+ *
+ * Return 0 on success, -1 if the engine specified is invalid
+ */
+int bdrv_parse_aio(const char *mode, int *flags)
+{
+    if (!strcmp(mode, "threads")) {
+        /* do nothing, default */
+    } else if (!strcmp(mode, "native")) {
+        *flags |= BDRV_O_NATIVE_AIO;
+#ifdef CONFIG_LINUX_IO_URING
+    } else if (!strcmp(mode, "io_uring")) {
+        *flags |= BDRV_O_IO_URING;
+#endif
+    } else {
+        return -1;
+    }
+
+    return 0;
+}
+
 /**
  * Set open flags for a given discard mode
  *
diff --git a/blockdev.c b/blockdev.c
index 4d141e9a1f..a41623ae9a 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -383,13 +383,9 @@ static void extract_common_blockdev_options(QemuOpts *opts, int *bdrv_flags,
         }
 
         if ((aio = qemu_opt_get(opts, "aio")) != NULL) {
-            if (!strcmp(aio, "native")) {
-                *bdrv_flags |= BDRV_O_NATIVE_AIO;
-            } else if (!strcmp(aio, "threads")) {
-                /* this is the default */
-            } else {
-               error_setg(errp, "invalid aio option");
-               return;
+            if (bdrv_parse_aio(aio, bdrv_flags) < 0) {
+                error_setg(errp, "invalid aio option");
+                return;
             }
         }
     }
@@ -4574,7 +4570,7 @@ QemuOptsList qemu_common_drive_opts = {
         },{
             .name = "aio",
             .type = QEMU_OPT_STRING,
-            .help = "host AIO implementation (threads, native)",
+            .help = "host AIO implementation (threads, native, io_uring)",
         },{
             .name = BDRV_OPT_CACHE_WB,
             .type = QEMU_OPT_BOOL,
diff --git a/include/block/block.h b/include/block/block.h
index e29baa172c..ec6b9ea4c8 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -297,6 +297,7 @@ void bdrv_append(BlockDriverState *bs_new, BlockDriverState *bs_top,
 void bdrv_replace_node(BlockDriverState *from, BlockDriverState *to,
                        Error **errp);
 
+int bdrv_parse_aio(const char *mode, int *flags);
 int bdrv_parse_cache_mode(const char *mode, int *flags, bool *writethrough);
 int bdrv_parse_discard_flags(const char *mode, int *flags);
 BdrvChild *bdrv_open_child(const char *filename,
-- 
2.21.0


