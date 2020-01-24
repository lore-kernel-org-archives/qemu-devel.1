Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A7AC2D0CE
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 23:23:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20E862075D
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 23:23:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jD6zXwNl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20E862075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iv8It-00023M-9r
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 18:23:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58784)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iv8FV-0004EW-Cd
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 18:20:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iv8FU-0005i5-Cb
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 18:20:25 -0500
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032]:34923)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iv8FU-0005gt-6J
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 18:20:24 -0500
Received: by mail-pj1-x1032.google.com with SMTP id q39so506203pjc.0
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 15:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jodrDJhZqqiGfDZYDnDeQ3K2xn0Ue4/C+awk7SofH44=;
 b=jD6zXwNla9C61gteyOKFU4/hhHQA7VMU3ZjTqRQt79lv5X3jIomxFouvkc2If7nkH5
 zBi4PmzFdQ3sJoAt4aWXW5SffrzN0BLfd5Q/bseaXKHvhp6HR52tM2J7NzQc+j52gkjQ
 zUCKKHD9W0rRSYCAjM9k+0EayvqUx14JaXUdx23R56rfTKOMRYNcJsyThE+ux1msMHMY
 TzrCsoJ9vHDOwmq5EyXba1EJC4ByVaySHEQR7MhvM5Fea7OOfDR+KAoTIKFxckmHide6
 mAZoL9AcHyQsBYPN/tjfhbsiQMEBvIJLDW1F1/fgwiQy2W7EZRpoaKJ8CsyMZiGJ1fdM
 YXiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jodrDJhZqqiGfDZYDnDeQ3K2xn0Ue4/C+awk7SofH44=;
 b=Y2l+JlFX+2Fbna4vIZgWhas5MQvTm7IcIf2FQEWa44CAqE4SeGz4Xx4lzLTaz2nZaZ
 /VeI56u66NQWX1pUB7EWWAeEx01hnfEHl0jX6PZoi263XdRvySEBdYlCM5WwCq3kvYzO
 O7d+qqd5kSjFnrDua8ioX+Fl0fKNSM6fT10ZcBzpGCs8cECGHJbzw14GtTf23+ztB1/T
 wX0bYeh9WDEewhBHjOlCto0rQbnduNTmS3BtH39AGbi4XIE/h/LMAxp9LhDABC9p5h99
 GiE3PKXk9q/FyFQbnntoTeianC6SjPI9LwubwCz3iy76yt6n0RHz0zP/X4zdniLu8HXr
 MvTw==
X-Gm-Message-State: APjAAAVFdtB4hbZvCHq3X8p0IklzXKC3ixZ9/1PTyMImzbRAgfPY1uGS
 qo4b7fBj5xz74fmFAPvSu9nm8J5ah5U=
X-Google-Smtp-Source: APXvYqwdsK1E53uj91Ies/illlX3PVk3t1cC4lX0wBl0a1Db+VhNMsT1Wsxkc+5qRcak3PDuuBKu8g==
X-Received: by 2002:a17:90a:3a86:: with SMTP id
 b6mr1852448pjc.96.1579908022883; 
 Fri, 24 Jan 2020 15:20:22 -0800 (PST)
Received: from localhost.localdomain (rrcs-173-198-77-92.west.biz.rr.com.
 [173.198.77.92])
 by smtp.gmail.com with ESMTPSA id v4sm8377880pgo.63.2020.01.24.15.20.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2020 15:20:22 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v3 05/11] hppa: Switch to tulip NIC by default
Date: Fri, 24 Jan 2020 13:20:03 -1000
Message-Id: <20200124232009.12928-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200124232009.12928-1-richard.henderson@linaro.org>
References: <20200124232009.12928-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1032
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
Cc: peter.maydell@linaro.org, deller@gmx.de, svens@stackframe.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Helge Deller <deller@gmx.de>

Most HP PA-RISC machines have a Digital DS21142/43 Tulip network card,
only some very latest generation machines have an e1000 NIC.
Since qemu now provides an emulated tulip card, use that one instead.

Signed-off-by: Helge Deller <deller@gmx.de>
Message-Id: <20191221222530.GB27803@ls3530.fritz.box>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/hppa/machine.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 33e3769d0b..c8b1830f88 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -127,10 +127,10 @@ static void machine_hppa_init(MachineState *machine)
     dev = DEVICE(pci_create_simple(pci_bus, -1, "lsi53c895a"));
     lsi53c8xx_handle_legacy_cmdline(dev);
 
-    /* Network setup.  e1000 is good enough, failing Tulip support.  */
+    /* Network setup. */
     for (i = 0; i < nb_nics; i++) {
         if (!enable_lasi_lan()) {
-            pci_nic_init_nofail(&nd_table[i], pci_bus, "e1000", NULL);
+            pci_nic_init_nofail(&nd_table[i], pci_bus, "tulip", NULL);
         }
     }
 
-- 
2.20.1


