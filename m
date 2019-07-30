Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D822C433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 17:42:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4135E2089E
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 17:42:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m+ytI4RJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4135E2089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsW9J-0002LV-Ix
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 13:42:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35957)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mehta.aaru20@gmail.com>) id 1hsW3C-0006DV-JC
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 13:36:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mehta.aaru20@gmail.com>) id 1hsW3B-0000VD-5z
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 13:36:38 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:42893)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mehta.aaru20@gmail.com>)
 id 1hsW3B-0000Ud-0o; Tue, 30 Jul 2019 13:36:37 -0400
Received: by mail-pg1-x542.google.com with SMTP id t132so30415569pgb.9;
 Tue, 30 Jul 2019 10:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=g0K4nld1/KlLZhCdPIvk0WNLZIE9E/uK4u0beC76QwY=;
 b=m+ytI4RJPZBikUfBrRcPS/JoOb6Ntd9Rxy9sd2lGuM3oWF2PFgYWoaLsWVFCuGFtoH
 tzAy4j77JPFSg8KJAjcYM5+gUM3yBBWxPyvMIso6urPlWnD0Iuxz2EVNfhh6aYlhOh7K
 iz+akdi9xp7+JFFuqWMCr7HMRK8owwdtTmISZEbpE0bX4PaJQCU9NyTgIuRjy7mBA4Y1
 tYCRr8AudHca/1vYi9N/9HBnIaSB0KQmNIKR5npTeA56Ng4CUyr0nGeRNyS43KMqnu0I
 4Xny0+JSfJqWhBWEryafq9Fdn5B9dW2k7QiZXjzFs3I9O2WxrESR73UaNH4PPHkbko5w
 fWoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=g0K4nld1/KlLZhCdPIvk0WNLZIE9E/uK4u0beC76QwY=;
 b=I4EY7wHuBqgrtZcYmqit9vpfx+q0Zi1J7VHoYcjK/JQ2zpTj5ftwEIq9IlVuI2ZDch
 y7Md0m1AzF1NtUprJchEtQ/DlS2OkCX1RcILw4zrd2QWIfccbYLRTLH8WBg2sQLi1rCq
 sddHwmJl15qgpBZBsdoE57Lpi47NZl6dDFfUj6EoqiirLkkr+jzd7iSV1VCyWOSyLC9u
 u/hTMKQFi+u0msTMQocxLnz4v536z3+DXuCdNjvVrpI8/1vpS/oJu3tymy3JQfnIJLgX
 PFS9CH/ZU5ViJVGIp+DHHiU7uzPTaXE3JZOWl93CTJfYkgbmiVsX3CKN6QIUvXdAk08r
 n5IA==
X-Gm-Message-State: APjAAAX3JTyrYGaPlp5gbfPDdMDP/TnQfss6e/G4ejGmJ3IHKtvio1UW
 c/Yybb0Yi7FmOphPi1SXb8vI/4YRZr905Q==
X-Google-Smtp-Source: APXvYqz9EKbjBA0G5zeSoD1utUUwwjD1rCLG06OqHI9J8i003v0u16m6/X+PY4FJ7r0/FrAravmKEQ==
X-Received: by 2002:a63:e54:: with SMTP id 20mr107554157pgo.244.1564508195481; 
 Tue, 30 Jul 2019 10:36:35 -0700 (PDT)
Received: from localhost.localdomain ([136.233.9.97])
 by smtp.gmail.com with ESMTPSA id q24sm59122895pjp.14.2019.07.30.10.36.30
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 30 Jul 2019 10:36:34 -0700 (PDT)
From: Aarushi Mehta <mehta.aaru20@gmail.com>
To: qemu-devel@nongnu.org
Date: Tue, 30 Jul 2019 23:04:38 +0530
Message-Id: <20190730173441.26486-14-mehta.aaru20@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190730173441.26486-1-mehta.aaru20@gmail.com>
References: <20190730173441.26486-1-mehta.aaru20@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: [Qemu-devel] [PATCH v8 13/16] qemu-nbd: adds option for aio engines
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Sergio Lopez <slp@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 saket.sinha89@gmail.com, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefan@redhat.com>, Julia Suvorova <jusual@mail.ru>,
 Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Acked-by: Eric Blake <eblake@redhat.com>
---
 qemu-nbd.c    | 12 ++++--------
 qemu-nbd.texi |  4 ++--
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/qemu-nbd.c b/qemu-nbd.c
index a8cb39e510..7bb479f3c0 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -135,7 +135,7 @@ static void usage(const char *name)
 "                            '[ID_OR_NAME]'\n"
 "  -n, --nocache             disable host cache\n"
 "      --cache=MODE          set cache mode (none, writeback, ...)\n"
-"      --aio=MODE            set AIO mode (native or threads)\n"
+"      --aio=MODE            set AIO mode (native, io_uring or threads)\n"
 "      --discard=MODE        set discard mode (ignore, unmap)\n"
 "      --detect-zeroes=MODE  set detect-zeroes mode (off, on, unmap)\n"
 "      --image-opts          treat FILE as a full set of image options\n"
@@ -718,13 +718,9 @@ int main(int argc, char **argv)
                 exit(EXIT_FAILURE);
             }
             seen_aio = true;
-            if (!strcmp(optarg, "native")) {
-                flags |= BDRV_O_NATIVE_AIO;
-            } else if (!strcmp(optarg, "threads")) {
-                /* this is the default */
-            } else {
-               error_report("invalid aio mode `%s'", optarg);
-               exit(EXIT_FAILURE);
+            if (bdrv_parse_aio(optarg, &flags) < 0) {
+                error_report("Invalid aio mode '%s'", optarg);
+                exit(EXIT_FAILURE);
             }
             break;
         case QEMU_NBD_OPT_DISCARD:
diff --git a/qemu-nbd.texi b/qemu-nbd.texi
index 7f55657722..3ee3e4bdee 100644
--- a/qemu-nbd.texi
+++ b/qemu-nbd.texi
@@ -77,8 +77,8 @@ as an read-only device, @var{snapshot_param} format is
 The cache mode to be used with the file.  See the documentation of
 the emulator's @code{-drive cache=...} option for allowed values.
 @item --aio=@var{aio}
-Set the asynchronous I/O mode between @samp{threads} (the default)
-and @samp{native} (Linux only).
+Set the asynchronous I/O mode between @samp{threads} (the default),
+@samp{native} (Linux only) and @samp{io_uring} (Linux 5.1+).
 @item --discard=@var{discard}
 Control whether @dfn{discard} (also known as @dfn{trim} or @dfn{unmap})
 requests are ignored or passed to the filesystem.  @var{discard} is one of
-- 
2.21.0


