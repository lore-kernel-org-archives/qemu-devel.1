Return-Path: <SRS0=s40H=2U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3689FC2D0C2
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2019 11:11:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01BD1206DB
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2019 11:11:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hQPvj1Oa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01BD1206DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ilsxZ-0007hV-IF
	for qemu-devel@archiver.kernel.org; Mon, 30 Dec 2019 06:11:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35313)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ilsvx-0005U3-I7
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 06:10:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ilsvw-00037v-HL
 for qemu-devel@nongnu.org; Mon, 30 Dec 2019 06:10:01 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:54521)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ilsvw-00037l-BH; Mon, 30 Dec 2019 06:10:00 -0500
Received: by mail-wm1-x343.google.com with SMTP id b19so13627679wmj.4;
 Mon, 30 Dec 2019 03:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+HcL6RtbH65y2vmENayC1ied30BzD+pn5ZQNQGLUrBQ=;
 b=hQPvj1OaisvygzpRuEp32g/qa0ZCf5LboT4oqXYdZ223T58Ji8kTSxBSy9rXFpl2Ss
 NgnO0ruPpOCdXexFf2Bc4Xe83kPnCkhaeCwxM8BJu7AkioUZ/YmMuHni6zIQfFPnsDX2
 kvOc0zoa7XxvlJpLUKN+VqOce5TGb0LlVkw5Lr+vq+FGQvqX1QAJmTOYa1SWlF4xRa3i
 QDAmYMuLtzB2RvC3f7+Ztnb/TiqJ7DtO4q9iMKxeuC1mdOK4eMS8EGSuFNtOHiEUVFRJ
 r/iE6P3g+Kl6K/vE1ltzq1TyRR2UqJKF7ki7MHtZz7FZepg9OznOPFXJ4QRz8YBsO/nm
 wcZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=+HcL6RtbH65y2vmENayC1ied30BzD+pn5ZQNQGLUrBQ=;
 b=gYuiXuHFtjRIyo4q9Lz5OMbx9rOOICGATpaKAACHicujsFOSpE2/lkixBkFFB5sfw2
 aw5BAe11GChXM6NVCfWCy6F3LnUUzSPN47wWT3PVi5FHVLFQAmX/w1X4QbQX02UIRb3k
 B+zc7P0q8SeV0TT3PsU7lKObiiXyQdJM3Z7ksw767gjtRdCU/DlDLja1RRtpJGTt9eEV
 bXOydnvdNT01gcOAUrbM3KLYx2XHwdHlBHgVdBc3VAP0jCjUQ/ErJAHKksegWmxkrSOw
 R93JN2JvrBwEpseEg3wEwKYj31HjiKaGoBCOm6cwddCwV/A1D6Ei/1xojor8wpap8KE0
 YjAQ==
X-Gm-Message-State: APjAAAVVtk2EG5cU5wPDg0ekdFeJeN5ACPDM3J6+qX3NWttn8ZkNA8Jn
 yDgfVMfjwIcF+Fn0yuCt7DOvN+8dWUQ=
X-Google-Smtp-Source: APXvYqxsmqQkY1HPJM7aueqp5klPFsLd8r9fDd5mZ4/txGE0UhDGbxiQx0jGeQMBm/sgQKMnoYok9Q==
X-Received: by 2002:a7b:c151:: with SMTP id z17mr33970422wmi.137.1577704199196; 
 Mon, 30 Dec 2019 03:09:59 -0800 (PST)
Received: from x1w.redhat.com ([2a01:cb18:8372:6b00:691b:aac5:8837:d4da])
 by smtp.gmail.com with ESMTPSA id p15sm20442738wma.40.2019.12.30.03.09.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Dec 2019 03:09:58 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/6] hw/arm/allwinner-a10: Move SoC definitions out of header
Date: Mon, 30 Dec 2019 12:09:50 +0100
Message-Id: <20191230110953.25496-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191230110953.25496-1-f4bug@amsat.org>
References: <20191230110953.25496-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 Willian Rampazzo <wrampazz@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These definitions are specific to the A10 SoC and don't need
to be exported to the different Allwinner peripherals.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/arm/allwinner-a10.h | 6 ------
 hw/arm/allwinner-a10.c         | 6 ++++++
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/hw/arm/allwinner-a10.h b/include/hw/arm/allwinner-a10.h
index 7d2d215630..941c61e533 100644
--- a/include/hw/arm/allwinner-a10.h
+++ b/include/hw/arm/allwinner-a10.h
@@ -12,12 +12,6 @@
 #include "target/arm/cpu.h"
 
 
-#define AW_A10_PIC_REG_BASE     0x01c20400
-#define AW_A10_PIT_REG_BASE     0x01c20c00
-#define AW_A10_UART0_REG_BASE   0x01c28000
-#define AW_A10_EMAC_BASE        0x01c0b000
-#define AW_A10_SATA_BASE        0x01c18000
-
 #define AW_A10_SDRAM_BASE       0x40000000
 
 #define TYPE_AW_A10 "allwinner-a10"
diff --git a/hw/arm/allwinner-a10.c b/hw/arm/allwinner-a10.c
index 118032c8c7..0f1af5a880 100644
--- a/hw/arm/allwinner-a10.c
+++ b/hw/arm/allwinner-a10.c
@@ -25,6 +25,12 @@
 #include "hw/misc/unimp.h"
 #include "sysemu/sysemu.h"
 
+#define AW_A10_PIC_REG_BASE     0x01c20400
+#define AW_A10_PIT_REG_BASE     0x01c20c00
+#define AW_A10_UART0_REG_BASE   0x01c28000
+#define AW_A10_EMAC_BASE        0x01c0b000
+#define AW_A10_SATA_BASE        0x01c18000
+
 static void aw_a10_init(Object *obj)
 {
     AwA10State *s = AW_A10(obj);
-- 
2.21.0


