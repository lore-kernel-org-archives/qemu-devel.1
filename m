Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C8C5C2BB1D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 04:07:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CCCB20717
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 04:07:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s2xqYpjY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CCCB20717
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE3WI-00023a-Hq
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 00:07:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45480)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmerdabbelt@google.com>) id 1jE3Ua-0008AX-FA
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 00:06:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmerdabbelt@google.com>) id 1jE3UZ-0002ku-C7
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 00:06:12 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:40740)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmerdabbelt@google.com>)
 id 1jE3UZ-0002af-5O
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 00:06:11 -0400
Received: by mail-pl1-x642.google.com with SMTP id h11so9008298plk.7
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 21:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding:cc:from:to;
 bh=2h8EAiuDrspnzxr4GNpQ/1tZBmlKA5RBBaJwzzdSex0=;
 b=s2xqYpjYQ+CJLGk34Xrg/uwnXMHXlmaeWmB1lLf07wnf8ebIJ7XOxTWMRJttCGko2C
 P2lIgCAdg880xQHvksWI0hAAJFnG4RvlMfEHFCSyK3dYGzleTokr0XTiBTw26tkeHCnd
 7NBWejnFOdn3yymtaZbkFrUQbHMTQejNRsvUEDvko/+NfJrIydOS8XWxe0RtwDJ8KvM3
 dqxgpW5uzy3eZE+bL9JCZDjh5CzP0MGjywomhmAmkXXco36bipEJdR93vg3LPoDWhLX5
 0yomus015OcD+J3iQjHe5Dx0X1WXsjMGeamCZLBWMnzG+bix8B1c7JonxknCqO8LtbgK
 Jimw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=2h8EAiuDrspnzxr4GNpQ/1tZBmlKA5RBBaJwzzdSex0=;
 b=d+IrB/HtkMMjsexqA/NCvmYOkiUT8/MU/RQSUpR3B+ayKMglVV1hkqhqg3jnz7inFp
 vthqdMClst3ziQCZM6dk/RYqipV0PqKndcByq7yn0yTXj4WSlkQEiV7E6tY3XPG5fKYp
 jXPMh4WSa3pt5bq6YchiuC2g1Q52T5iD25qsbNhFgQx+RF3V0KGj2iKzJ46x51QoDUy2
 vu/rDqpgTKkmt0HMEJXFp56oJv88pFhWmzxDaLds/foxDAUSKI8QBljp7pxXZHHpXu4M
 S5j7Ff8Bj6fk7Fu5Ye9X5UX7BH/m6RtDo5d1JSR25LHcVKIrXiw7iXBRb4okxU4L992B
 fx4A==
X-Gm-Message-State: ANhLgQ2lJBz0aZlm/75tZhxi3wMIVyn+V2rAeWzOqxUxTo9r1bntrvMO
 xj5EZ0f1HCuKNqCW6CCwPJiljA==
X-Google-Smtp-Source: ADFU+vtArDFC1QGTHkxtH4OOgQu1L6KWdnnnoVYt+xwYoZHzvU4qDC8IPhdzetTb3iHClFx+MUcIqQ==
X-Received: by 2002:a17:90b:3692:: with SMTP id
 mj18mr3048427pjb.138.1584417970026; 
 Mon, 16 Mar 2020 21:06:10 -0700 (PDT)
Received: from localhost (c-67-161-15-180.hsd1.ca.comcast.net. [67.161.15.180])
 by smtp.gmail.com with ESMTPSA id 129sm1294079pfw.84.2020.03.16.21.06.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 21:06:09 -0700 (PDT)
Subject: [PULL 4/6] riscv: sifive_u: Update BIOS_FILENAME for 32-bit
Date: Mon, 16 Mar 2020 21:05:45 -0700
Message-Id: <20200317040547.222501-5-palmerdabbelt@google.com>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
In-Reply-To: <20200317040547.222501-1-palmerdabbelt@google.com>
References: <20200317040547.222501-1-palmerdabbelt@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: qemu-riscv@nongnu.org,          qemu-devel@nongnu.org,
 Bin Meng <bmeng.cn@gmail.com>, Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmerdabbelt@google.com>
From: Palmer Dabbelt <palmerdabbelt@google.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bmeng.cn@gmail.com>

Update BIOS_FILENAME to consider 32-bit bios image file name.

Tested booting Linux v5.5 32-bit image (built from rv32_defconfig
plus CONFIG_SOC_SIFIVE) with the default 32-bit bios image.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 hw/riscv/sifive_u.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 156a003642..4409ea1ccc 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -56,7 +56,11 @@
 
 #include <libfdt.h>
 
-#define BIOS_FILENAME "opensbi-riscv64-sifive_u-fw_jump.bin"
+#if defined(TARGET_RISCV32)
+# define BIOS_FILENAME "opensbi-riscv32-sifive_u-fw_jump.bin"
+#else
+# define BIOS_FILENAME "opensbi-riscv64-sifive_u-fw_jump.bin"
+#endif
 
 static const struct MemmapEntry {
     hwaddr base;
-- 
2.25.1.481.gfbce0eb801-goog


