Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64828C32751
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 15:02:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 327E821E6C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 15:02:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 327E821E6C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvNSJ-0002pB-Du
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 11:02:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47286)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <palmer@dabbelt.com>) id 1hvNQF-00013j-LA
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 11:00:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1hvNQD-0005kj-DM
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 11:00:15 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40554)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hvNQB-0005j8-Ex
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 11:00:13 -0400
Received: by mail-pl1-f193.google.com with SMTP id a93so41164191pla.7
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 08:00:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:mime-version
 :content-transfer-encoding:cc:from:to;
 bh=/z3SaXELBbM1r0WgxX2Aa0ZqhKzjlwWQ5XV4JiXHSQc=;
 b=T+ifxtVXck/HQOtxRcOw8c0P/5ftMopRg4/oNKGho+MQzcQqbau/w25JQj6oAPX3KG
 osd65U6RCp+2tnJxO16qMYk8If5+rW1hvJqfzcEU6ZSz5tXwTZHOmg5CWzFRRGwF4MoY
 pJ8vSKLpyPaI+TkdMXb7k1rZI105XKLC9h+2qTAmVZVuTsvM6hnTLO1+GLw3mKO1XX4G
 H1Pj+hgV5PjVS/VbdWhh2X2fkgFM6KIIyjPfp00SQIWrH2HdaX72CoT3oHtKep8Wa8TP
 SMhAfw722jP+FRk8mhJ0Uxbbe3e44wXSr3Yeiv9JcjHi1kPVXxO5KY7PcvgcMuC6Hgr6
 g2HA==
X-Gm-Message-State: APjAAAWqEW8Su1zS/LOxEzvbUtHIioof9IAy8dwJaqkxgEVqj5VrgHcX
 o958tJizyQoo7l+fBz7J/UoX4g==
X-Google-Smtp-Source: APXvYqxpvrcPP1rXQEzW5s408YNpQQayr5I9ZkLIuETds3ak6LOeEHY0CdB/jHuNnjkwjNRqXoe3VA==
X-Received: by 2002:a62:e815:: with SMTP id c21mr10089381pfi.244.1565190008346; 
 Wed, 07 Aug 2019 08:00:08 -0700 (PDT)
Received: from localhost ([12.206.222.5])
 by smtp.gmail.com with ESMTPSA id 64sm93539840pfe.128.2019.08.07.08.00.07
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 07 Aug 2019 08:00:07 -0700 (PDT)
Date: Wed,  7 Aug 2019 07:59:39 -0700
Message-Id: <20190807145939.1281-1-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: qemu-riscv@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.214.193
Subject: [Qemu-devel] [PATCH for 4.1] RISC-V: Ignore the S and U extensions
 when formatting ISA strings
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
Cc: Atish Patra <Atish.Patra@wdc.com>, Palmer Dabbelt <palmer@sifive.com>,
 qemu-devel@nongnu.org, Paul Walmsley <paul.walmsley@sifive.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The ISA strings we're providing from QEMU aren't actually legal RISC-V
ISA strings, as both the S and U extensions cannot exist as
single-letter extensions and must instead be multi-letter strings.
We're still using the ISA strings inside QEMU to track the availiable
extensions, so this patch just strips out the S and U extensions when
formatting ISA strings.

This boots Linux on top of 4.1-rc3, which no longer has the U extension
in /proc/cpuinfo.

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
This is another late one, but I'd like to target it for 4.1 as we're
providing illegal ISA strings and I don't want to bake that into a bunch
of other code.
---
 target/riscv/cpu.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index f8d07bd20ad7..4df14433d789 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -501,7 +501,22 @@ char *riscv_isa_string(RISCVCPU *cpu)
     char *p = isa_str + snprintf(isa_str, maxlen, "rv%d", TARGET_LONG_BITS);
     for (i = 0; i < sizeof(riscv_exts); i++) {
         if (cpu->env.misa & RV(riscv_exts[i])) {
-            *p++ = qemu_tolower(riscv_exts[i]);
+            char lower = qemu_tolower(riscv_exts[i]);
+            switch (lower) {
+            case 's':
+            case 'u':
+                /*
+                 * The 's' and 'u' extensions shouldn't be passed in the device
+                 * tree, but we still use them internally to track extension
+                 * sets.  Here we just explicitly remove them when formatting
+                 * an ISA string.
+                 */
+                break;
+
+            default:
+                *p++ = qemu_tolower(riscv_exts[i]);
+                break;
+            }
         }
     }
     *p = '\0';
-- 
2.21.0


