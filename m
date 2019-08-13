Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B995CC433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 22:55:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F2F12067D
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 22:55:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F2F12067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxfhG-0006iL-IY
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 18:55:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56723)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <palmer@dabbelt.com>) id 1hxfgl-0005te-Dp
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 18:54:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1hxfgk-0006UT-Gx
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 18:54:47 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40316)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hxfgk-0006UB-CZ
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 18:54:46 -0400
Received: by mail-pf1-f195.google.com with SMTP id p184so52431713pfp.7
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2019 15:54:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:mime-version
 :content-transfer-encoding:cc:from:to;
 bh=9hzQDp4ZaD0ACnDOE3HEeTilvKbeiwOSKUnAotgimJQ=;
 b=udk6OMbyR0RLczvNKY2UdOoEsEyFyR0rHI4t/d3/qaZEI/ulcLeZzthuGm9fY107ah
 75wCTVXAeq2xHiT3iFuoOyWzSaGHeNtz94QTfijGyQ0R3BZwmjrBDkwuZEEjvoc9SqP3
 abp4aMzyIaFXdgv9bNTyCkdjAsxWnOJGMHLX0KLiqZLu3ZA0zeVTHvw0l0NIMQ1VF5AH
 mGvvrwJTwc+BJP7NQYAlP1WqCnIjjTLRX7sb5PD6uuG+MvO+FUN2m9UhrDl751yVmSQm
 sLW95LjAnlr3WDm4QdLKtBD4WMjzulHH27ffrPvZA3sIM5B+UjUc3QSURHt+NP0sBliO
 JwCQ==
X-Gm-Message-State: APjAAAWb/2NH5i/UrI6INvhYFeun3f4Rh7pcbIoRZkfGc8z/DQsaSj8J
 LwRukEPk7Qc93Qaa/UzWu4y5WgWNhRo=
X-Google-Smtp-Source: APXvYqxotfhbhfvjziG8ocdUpOtNFpDWKhIFFk8kTQRMLIb+3/PvuqOYJpTIBqfPScCSSuomLZXqUw==
X-Received: by 2002:a63:e70f:: with SMTP id b15mr36374923pgi.152.1565736884691; 
 Tue, 13 Aug 2019 15:54:44 -0700 (PDT)
Received: from localhost ([12.206.222.5])
 by smtp.gmail.com with ESMTPSA id w10sm3258290pjv.23.2019.08.13.15.54.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Aug 2019 15:54:44 -0700 (PDT)
Date: Tue, 13 Aug 2019 15:53:07 -0700
Message-Id: <20190813225307.5792-1-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,       qemu-riscv@nongnu.org
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.210.195
Subject: [Qemu-devel] [PATCH v2] RISC-V: Ignore the S and U letters when
 formatting ISA strings
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
Cc: Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The ISA strings we're providing from QEMU aren't actually legal RISC-V
ISA strings, as both S and U cannot exist as single-letter extensions
and must instead be multi-letter strings.  We're still using the ISA
strings inside QEMU to track the availiable extensions, so this patch
just strips out the S and U extensions when formatting ISA strings.

This boots Linux on top of 4.1-rc3, which no longer has the U extension
in /proc/cpuinfo.

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 target/riscv/cpu.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index f8d07bd20ad7..a67c54c738ba 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -501,7 +501,23 @@ char *riscv_isa_string(RISCVCPU *cpu)
     char *p = isa_str + snprintf(isa_str, maxlen, "rv%d", TARGET_LONG_BITS);
     for (i = 0; i < sizeof(riscv_exts); i++) {
         if (cpu->env.misa & RV(riscv_exts[i])) {
-            *p++ = qemu_tolower(riscv_exts[i]);
+            char lower = qemu_tolower(riscv_exts[i]);
+            switch (lower) {
+            case 's':
+            case 'u':
+                /*
+		 * The 's' and 'u' letters shouldn't show up in ISA strings as
+		 * they're not extensions, but they should show up in MISA.
+		 * Since we use these letters interally as a pseudo ISA string
+		 * to set MISA it's easier to just strip them out when
+		 * formatting the ISA string.
+		 */
+                break;
+
+            default:
+                *p++ = lower;
+                break;
+            }
         }
     }
     *p = '\0';
-- 
2.21.0


