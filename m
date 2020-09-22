Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7630C4346E
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 02:56:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BDB42399A
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 02:56:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sbLM75QN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BDB42399A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKYTJ-0001lh-EY
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 22:56:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48026)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1kKYQR-0007CK-Kv
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 22:53:03 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b]:34561)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1kKYQP-0002jP-EA
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 22:53:03 -0400
Received: by mail-pg1-x52b.google.com with SMTP id u13so10753870pgh.1
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2020 19:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=VaLsq131cxSFLLb9dWpm2TOUowIQwdWIbjnurwZZe5I=;
 b=sbLM75QN94/7RLwTqXxePLORmgudZ5RHYu00soBRH8yLPWLCEcY3jCUj/vEAVq0g8r
 Y0mfw8TNsjShEnnj9Wzz9F3OjFbmd54ZXs8gvLTOUYOczR6jRfl/WPjFYrZOLr3/u/f8
 VukQQ158tSrXY3yDC+JkmrW1duBr5ggucm9j7y0TQRyuibfm/HeEdi/Sn3TeSoOL+8Ri
 EzWP0SA7TB3kfzcTNXtNcFOeKBwKToPgH3vzThpiQwvk172rd38nrbM0B4Pk5NsORElk
 iMGEYgnFfKiaEGOXaechoLTX0tYF76aqGFi4MSIALlA0q5rAYts1ho7BmWFCyp7+bqfT
 BBmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=VaLsq131cxSFLLb9dWpm2TOUowIQwdWIbjnurwZZe5I=;
 b=BxctthEGW+IfhHxdUEJniLQyHG9lM2k506MBz2/ZuMSwUlBiL0jbQOhBYyak2tJW1Z
 OCj/lhGCnZb6rZR7f4RQZ3vbMHchFrUL6GS7REzTIJJv2KKvsWpl0p7Qy9KESzy3ZQou
 mMDpQGys/B4m85W/eM0sQpZd5Lx/wEXREnXBc2iA3ne5f8aDgXFbWL1fPy3xeY+qydX/
 SZu4UWF8u5NpH+ElJc8jXSaPMW6+2JjOxEGd5W9u2Q4WRI8gQKHLDkKxOKWYg0muR6oK
 ZUn3jhRtzgOG/gufaZNrRDt9Hu5v0rjWKWwVrwvMhbArPlyeZDoqF2VJO9UPx23HT7Uz
 QJqA==
X-Gm-Message-State: AOAM530Y8Dy6c6tkrSBxDYI6P9tQFwtxItwjRUt+Qh2bJDPQUWSHZdcy
 zAYQnW9ELaYMLEmFMhUzLl4=
X-Google-Smtp-Source: ABdhPJxP85MgXWkuAd9O+SvVOP2HefQVLqzOc26057GiUZqNhpJfIABbWLx30RHbwZkESHvQHe40EQ==
X-Received: by 2002:a63:cb0a:: with SMTP id p10mr1976041pgg.314.1600743180112; 
 Mon, 21 Sep 2020 19:53:00 -0700 (PDT)
Received: from software.domain.org ([45.77.13.216])
 by smtp.gmail.com with ESMTPSA id q4sm13263677pfs.193.2020.09.21.19.52.56
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 21 Sep 2020 19:52:59 -0700 (PDT)
From: Huacai Chen <zltjiangshi@gmail.com>
X-Google-Original-From: Huacai Chen <chenhc@lemote.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Subject: [PATCH V10 8/8] docs/system: Update MIPS machine documentation
Date: Tue, 22 Sep 2020 10:49:27 +0800
Message-Id: <1600742967-12933-9-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1600742967-12933-1-git-send-email-chenhc@lemote.com>
References: <1600742967-12933-1-git-send-email-chenhc@lemote.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=zltjiangshi@gmail.com; helo=mail-pg1-x52b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Huacai Chen <chenhuacai@gmail.com>, qemu-devel@nongnu.org,
 Huacai Chen <chenhc@lemote.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add Loongson-3A CPU models and Loongson-3 based machine description.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 docs/system/cpu-models-mips.rst.inc | 10 ++++++++--
 docs/system/target-mips.rst         | 10 ++++++++++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/docs/system/cpu-models-mips.rst.inc b/docs/system/cpu-models-mips.rst.inc
index 499b5b6fed..02cc4bb884 100644
--- a/docs/system/cpu-models-mips.rst.inc
+++ b/docs/system/cpu-models-mips.rst.inc
@@ -48,11 +48,17 @@ across all desired hosts.
 ``I6400``
     MIPS64 Processor (Release 6, 2014)
 
+``Loongson-2E``
+    MIPS64 Processor (Loongson 2, 2006)
+
 ``Loongson-2F``
     MIPS64 Processor (Loongson 2, 2008)
 
-``Loongson-2E``
-    MIPS64 Processor (Loongson 2, 2006)
+``Loongson-3A1000``
+    MIPS64 Processor (Loongson 3, 2010)
+
+``Loongson-3A4000``
+    MIPS64 Processor (Loongson 3, 2018)
 
 ``mips64dspr2``
     MIPS64 Processor (Release 2, 2006)
diff --git a/docs/system/target-mips.rst b/docs/system/target-mips.rst
index cd2a931edf..1f86ccb697 100644
--- a/docs/system/target-mips.rst
+++ b/docs/system/target-mips.rst
@@ -84,6 +84,16 @@ The Fuloong 2E emulation supports:
 
 -  RTL8139D as a network card chipset
 
+The Loongson-3 virtual platform emulation supports:
+
+-  Loongson 3A CPU
+
+-  LIOINTC as interrupt controller
+
+-  GPEX and virtio as variable devices
+
+-  Both KVM and TCG supported
+
 The mipssim pseudo board emulation provides an environment similar to
 what the proprietary MIPS emulator uses for running Linux. It supports:
 
-- 
2.17.2


