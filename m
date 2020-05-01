Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8680BC47253
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 15:54:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EA4E216FD
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 15:54:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CEp8CmDk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EA4E216FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUXzO-0001RR-0V
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 11:54:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59856)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jUXwf-0005nd-0k
 for qemu-devel@nongnu.org; Fri, 01 May 2020 11:51:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1jUXwR-0006tV-4G
 for qemu-devel@nongnu.org; Fri, 01 May 2020 11:51:20 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:38257)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jUXwQ-0006q0-Nn; Fri, 01 May 2020 11:51:06 -0400
Received: by mail-pj1-x1044.google.com with SMTP id t40so50239pjb.3;
 Fri, 01 May 2020 08:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=uJA64DlQQdrU8SYfFsnJOCDlr49qq6ib4zkHrW6VhfQ=;
 b=CEp8CmDk6tx20ddYF82vHMNF9CTQXidBPpS/lHJFy68sAE0dyAZu70UkcPZf2Lcyev
 7ziQe9M2Phke+v4Ixc85szz7dDK4wkmR+KlHs447TFEy1uFO1S9YU36/Hxo3AdWt57DY
 l04mTnT6NNSyJTAcP4dK75Gx8m8lHYFab5Te3sF3dUpp4awcYtgxnWN9Jf7kdznOr7gn
 ZLuQnx/8icxA3tGrnmFBnajoAHzwRnml3FI6nw7CQQbWIi1RgzAXr840UjwhGNnJXW8j
 YYwiP5L5Z0JxBv8IDyRWIIPHLayEU3Cyfwm+uTUi5A+CWQoIOr7Ty+j26V+hGn6eIL1S
 HYow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=uJA64DlQQdrU8SYfFsnJOCDlr49qq6ib4zkHrW6VhfQ=;
 b=mdyPrRQ7p6f+kewXXLhekuO1Ss0LLYXTD7DCDwi4LaFFdoudyskc2dxUAvTRdwTc8j
 WrW0wlj+D+2SWg6bLj0QMI2DBfEO5oDqduxHGKrzPa5NvLwi6ybLZ2WXRPqYBx+VhLh0
 a/HdcdDKfP7EnW8YeJu3V9RlKf8Wk4amn2vElPrNLJImpnxXjb/FQOVSwhkqW+Dyei51
 oYr4tEbMllRnPlnT0JsupG1YbLtF/yo41AA1Kv2dj4ohUGu0QP+NI2w3hMUXZGau+7qK
 xDCqMgUw+XcmtVcSm9s+a6qpMj2Zu422ugv83v8BO2pet+u1LaCpWFsQ6q+1gUXTy1Fu
 qhZg==
X-Gm-Message-State: AGi0PuZigpMy9fpNDzV8cKFXRutzwfyFqRJ40mVOZbuj1jhRTRqLnYNH
 JhPXYgZZWaHLNhYbzkYFfPk=
X-Google-Smtp-Source: APiQypLtUQsDePBjvuswL+LESlQP370heeRUBhiQc604bLer/K2q3ms6SAbC8BFPGYo+lGeJUKbUJQ==
X-Received: by 2002:a17:90a:1743:: with SMTP id 3mr267938pjm.106.1588348265175; 
 Fri, 01 May 2020 08:51:05 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id e4sm2385968pge.45.2020.05.01.08.51.04
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Fri, 01 May 2020 08:51:04 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH 5/5] riscv: Suppress the error report for QEMU testing with
 riscv_find_firmware()
Date: Fri,  1 May 2020 08:50:54 -0700
Message-Id: <1588348254-7241-6-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1588348254-7241-1-git-send-email-bmeng.cn@gmail.com>
References: <1588348254-7241-1-git-send-email-bmeng.cn@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=bmeng.cn@gmail.com; helo=mail-pj1-x1044.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::1044
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
Cc: Bin Meng <bin.meng@windriver.com>, Anup Patel <Anup.Patel@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bin.meng@windriver.com>

We only ship plain binary bios images in the QEMU source. With Spike
machine that uses ELF images as the default bios, running QEMU test
will complain hence let's suppress the error report for QEMU testing.

Signed-off-by: Bin Meng <bin.meng@windriver.com>

---

 hw/riscv/boot.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index b76b2f3..adb421b 100644
--- a/hw/riscv/boot.c
+++ b/hw/riscv/boot.c
@@ -65,9 +65,17 @@ char *riscv_find_firmware(const char *firmware_filename)
 
     filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, firmware_filename);
     if (filename == NULL) {
-        error_report("Unable to load the RISC-V firmware \"%s\"",
-                     firmware_filename);
-        exit(1);
+        if (!qtest_enabled()) {
+            /*
+             * We only ship plain binary bios images in the QEMU source.
+             * With Spike machine that uses ELF images as the default bios,
+             * running QEMU test will complain hence let's suppress the error
+             * report for QEMU testing.
+             */
+            error_report("Unable to load the RISC-V firmware \"%s\"",
+                         firmware_filename);
+            exit(1);
+        }
     }
 
     return filename;
-- 
2.7.4


