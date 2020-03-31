Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1EBFC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 10:58:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B986E20772
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 10:58:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IXP39zqt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B986E20772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJEax-0001yQ-Tz
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 06:58:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53016)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jJEU9-0002YM-St
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 06:51:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jJEU8-0006PW-Nf
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 06:51:09 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:55607)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jJEU8-0006Op-HY
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 06:51:08 -0400
Received: by mail-wm1-x32b.google.com with SMTP id r16so1909120wmg.5
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2020 03:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qgAU0QvRTWi/e7o9YOkCjYOwtTnHaoxCvld4v/twtYk=;
 b=IXP39zqtXbhE9woqyKaxicyBMR6sptSrVaant6mSkoHsluQ+QRj8DbPZMrql2teZ5R
 FPjPV1Rvh30W44mXe4bERcCtTYwAb2c89EwUB1Y1U0ECUjRCwhv7/PKv5ULHzicyIHpT
 P0JDCccLoos8N+dcGrAlpPDz0I3aPfr+7TxR7T7gjVyQ3meFOCytW+3jf2mLvvmYzYpi
 oPPtJZiMFH96adfmaTdVxuS2nT5vfSGlT0M+UxxEyODqh1FC+toqfxdjdvx6UK7YqDNt
 WExFjxqg2uR66xCzfE0TFyyXG1q9ywddJ/oRUJhfRXCaqKjKElsNN4COiJZiTlybExjL
 F1HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=qgAU0QvRTWi/e7o9YOkCjYOwtTnHaoxCvld4v/twtYk=;
 b=Pa4NOJHEr2EN+yURPyOduZSp8QbubvQ7m5h5U4CoSKg1j+V68WZf8MDRrrR2Rhrkbg
 zrxsyYRBto9MCljszLxEI6flLOblNqO0aZ/pWouzvhndtE585wnv4HqH3LHP60Y74SKs
 fbIgWueW4biZKiM4NU2mtk5b7ZDU2/MTnpCtXkHBc//G85/rGDFycdT6W/IfLNrzM+pu
 Pb5rpuSD1kLEM12tAo2LFPRtn5J15w9/JkArvdqM3696PkQ7cVYWwbvQLIOn0JYu5JhD
 2Fk46ffwG4qvVGmSXgpciw7hm+S22n6zkgdSYPwljGs42jyNJqwslO50RyuNS/hd5GRG
 6A1g==
X-Gm-Message-State: ANhLgQ2ZdD4AK5kTXYMwROdW+GHUsdnX/Vk6KudJ1RevCyXusLJ9FQgo
 ukCZr8ES4Hax4I8vV6Z6P72GNnHlTgg=
X-Google-Smtp-Source: ADFU+vuhaCSeNpKyWRK2ZM1WY6YgUYgFtQbtX+TGPvZ44qLLHLTmfnfou73iEZvjaufS0cf8rkfR7A==
X-Received: by 2002:a7b:c5d8:: with SMTP id n24mr2233281wmk.158.1585651867337; 
 Tue, 31 Mar 2020 03:51:07 -0700 (PDT)
Received: from localhost.localdomain (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id w3sm26042830wrn.31.2020.03.31.03.51.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2020 03:51:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.1 7/7] target/sparc/int32_helper: Extract and use
 excp_name_str()
Date: Tue, 31 Mar 2020 12:50:48 +0200
Message-Id: <20200331105048.27989-8-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200331105048.27989-1-f4bug@amsat.org>
References: <20200331105048.27989-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32b
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Fabien Chouteau <chouteau@adacore.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>, Jiri Gaisler <jiri@gaisler.se>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Improve exception error report:

Before:

  qemu: fatal: Trap 0x06 while interrupts disabled, Error state

After:

  qemu: fatal: Trap 0x06 (Window Underflow) while interrupts disabled, Error state

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/sparc/int32_helper.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/target/sparc/int32_helper.c b/target/sparc/int32_helper.c
index c56dd3df18..9a71e1abd8 100644
--- a/target/sparc/int32_helper.c
+++ b/target/sparc/int32_helper.c
@@ -57,6 +57,14 @@ static const char * const excp_names[0x80] = {
     [TT_NCP_INSN] = "Coprocessor Disabled",
 };
 
+static const char *excp_name_str(int32_t exception_index)
+{
+    if (exception_index < 0 || exception_index >= ARRAY_SIZE(excp_names)) {
+        return "Unknown";
+    }
+    return excp_names[exception_index];
+}
+
 void sparc_cpu_do_interrupt(CPUState *cs)
 {
     SPARCCPU *cpu = SPARC_CPU(cs);
@@ -77,10 +85,7 @@ void sparc_cpu_do_interrupt(CPUState *cs)
         } else if (intno >= 0x80) {
             name = "Trap Instruction";
         } else {
-            name = excp_names[intno];
-            if (!name) {
-                name = "Unknown";
-            }
+            name = excp_name_str(intno);
         }
 
         qemu_log("%6d: %s (v=%02x)\n", count, name, intno);
@@ -106,8 +111,9 @@ void sparc_cpu_do_interrupt(CPUState *cs)
             env->def.features & CPU_FEATURE_TA0_SHUTDOWN) {
             qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
         } else {
-            cpu_abort(cs, "Trap 0x%02x while interrupts disabled, Error state",
-                      cs->exception_index);
+            cpu_abort(cs, "Trap 0x%02x (%s) while interrupts disabled, "
+                          "Error state",
+                      cs->exception_index, excp_name_str(cs->exception_index));
         }
         return;
     }
-- 
2.21.1


