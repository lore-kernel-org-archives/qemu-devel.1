Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1370C433FF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 20:36:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E44421BE3
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 20:36:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E44421BE3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvSfc-0003Xs-OL
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 16:36:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34004)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <palmer@dabbelt.com>) id 1hvSf3-0002ls-7S
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 16:35:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1hvSf2-00076N-9v
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 16:35:53 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45057)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hvSf2-00074q-4t
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 16:35:52 -0400
Received: by mail-pl1-f196.google.com with SMTP id y8so371397plr.12
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 13:35:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:mime-version
 :content-transfer-encoding:cc:from:to;
 bh=R8xWP9Mxshej5PA8tCd2n8Cul5yLRtIaS9eOBFzo/ZQ=;
 b=KUyWjmUAbOC+J2jONqfzP2uIMNgkgs2g0HfmuWYJ/1M7rDGjKQsuoAovxiQhF+nNHv
 w6Lx1z/vHabGycNlkmKK8Pzr6+mNeynGToYOhWltSnoXIZ6UNgUtiTKH3SpMc6PmKysj
 U6l7ybPVw2ap6mEZBpKNjRIpZ3E3ZJmMWNGFcryomVeieoJXFfmLolp8GzcypsuYX1Oa
 h2LleLLrC0xvc48eFUH/SpZn3riX6rbXKIGA6SZ22GnlSlEJRRh//kZThvhP7Egt0Aj8
 ptINeI1bIcwTkRF8MN0qDYgdtEZ0kATdA2pJHrfLNaNt5wEIKUWBKrQbn9ov/3c/clMi
 mQoQ==
X-Gm-Message-State: APjAAAV1wAXRBohEFYufcXEVI9VBR/TdPY69shnBX/xsMM0zVUQvy/8B
 7fW94Mh7znEjQp1ChETpWyrU8Q==
X-Google-Smtp-Source: APXvYqxX5SLoJ8LCMG8hrdBU22+vVLN9GHqDo4HQr/WML2TFEw4hEbgiIF2ZxIqOC6C5Ikf2EfVGaQ==
X-Received: by 2002:a17:902:82c4:: with SMTP id
 u4mr9960400plz.196.1565210150735; 
 Wed, 07 Aug 2019 13:35:50 -0700 (PDT)
Received: from localhost ([12.206.222.5])
 by smtp.gmail.com with ESMTPSA id q22sm85567918pgh.49.2019.08.07.13.35.49
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 07 Aug 2019 13:35:50 -0700 (PDT)
Date: Wed,  7 Aug 2019 10:49:44 -0700
Message-Id: <20190807174944.17944-1-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: qemu-riscv@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.214.196
Subject: [Qemu-devel] [PATCH v2] RISC-V: Ignore the S and U extensions when
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
 target/riscv/cpu.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index f8d07bd20ad7..74f3449c4918 100644
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
+                *p++ = lower;
+                break;
+            }
         }
     }
     *p = '\0';
-- 
2.21.0


