Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD9DC3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 19:51:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F03520856
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 19:51:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ztx41+Nt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F03520856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i33z0-0006p2-5W
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 15:51:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38355)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i33GX-0003py-FS
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:05:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i33GT-0000Pd-B1
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:05:56 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:34812)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i33GS-0000Ne-UO
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:05:53 -0400
Received: by mail-pf1-x441.google.com with SMTP id b24so408731pfp.1
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2019 12:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=89SQlaAeVhVp09ygtNMAn6vIdVWhYBgQFHPazRmvu08=;
 b=Ztx41+NtgB/AA9TuDP3LN7RA8e2+gh26+eXpSClG7BNawIO9uw+FhuCbhLmC75IYgZ
 REr5YxsDg3NfI4lsVsIyCUmnqX8EIdze91VE54I4FzmPr77o1YPoXFF8o3oAystB546/
 YhRzY2/XpJerWj8/r4fcIblHoyguh5Fy7azkhr4MBWvuLZOejj3SlavHvu794mQMehJE
 ZzigOoMYrntfc7W8W/VWDpmFcbWX9X3tSbX3riSL+dKKhp4IPyojPrd4KdkEoOHMvXXT
 gO0P/xPJtdlmYdYSg19chVjRe8D6eHkZjzCR9UVQiQDh7q7RsuyBggwKMMXtf3oarQqR
 GqFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=89SQlaAeVhVp09ygtNMAn6vIdVWhYBgQFHPazRmvu08=;
 b=ARByk15DsFjj+EzJOlGE4nJ7Olu7GdU7AKiSJGJzn9gvFWlGaY+Ai2jMNosIzU5OA9
 jmIPh/Fb9O1wc8zAujXwlrFYVYBh1BLDO4/28ScRYN7lMvmYPyQTacvS51L+IYI7UHN4
 wWafn/ayf6Qz4CxVxdVnp/xPOhAHoRn3emkCnP4Mng7RUt6Oo0FhpXjxgjzpJFbH85L4
 I+4YNny5oL8hG0NO/1EVv23WP+Cp42H+8g9w/JNjuZvlmdIMxqk/1ZZd/mWgrH8d9dgJ
 ZL1PPdnrx0nNHqbGmsCr5s+WtJNKeIfa44CLwTLpfrVoFB13qE3kZkI9BSz016TC1s32
 2hKQ==
X-Gm-Message-State: APjAAAWJ1rlNvlvOZEgn01mSMAzaWhH7w1G1bNaVr1p38UbOka5vNOt9
 qvNsZLC9aM/X1ZZPpRf8wpP+96b3i64=
X-Google-Smtp-Source: APXvYqxcyqNBPPS2By2m8Nj0Rlq9/+YfJeEgKwLK+jpE/7MG7EY+jc+w62sbWhCo9jbUtQ9cl43uow==
X-Received: by 2002:a62:1808:: with SMTP id 8mr6522592pfy.177.1567019149913;
 Wed, 28 Aug 2019 12:05:49 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id f27sm2967944pgm.60.2019.08.28.12.05.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2019 12:05:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 28 Aug 2019 12:04:26 -0700
Message-Id: <20190828190456.30315-40-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190828190456.30315-1-richard.henderson@linaro.org>
References: <20190828190456.30315-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: [Qemu-devel] [PATCH v3 39/69] target/arm: Convert Unallocated
 memory hint
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c       | 8 --------
 target/arm/a32-uncond.decode | 8 ++++++++
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index c55bd1e563..07547f7b6c 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10309,14 +10309,6 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
             }
             return;
         }
-        if (((insn & 0x0f700000) == 0x04100000) ||
-            ((insn & 0x0f700010) == 0x06100000)) {
-            if (!arm_dc_feature(s, ARM_FEATURE_V7MP)) {
-                goto illegal_op;
-            }
-            return; /* v7MP: Unallocated memory hint: must NOP */
-        }
-
         if ((insn & 0x0e000f00) == 0x0c000100) {
             if (arm_dc_feature(s, ARM_FEATURE_IWMMXT)) {
                 /* iWMMXt register transfer.  */
diff --git a/target/arm/a32-uncond.decode b/target/arm/a32-uncond.decode
index ddc5edfa5e..60ccfc598d 100644
--- a/target/arm/a32-uncond.decode
+++ b/target/arm/a32-uncond.decode
@@ -64,3 +64,11 @@ PLI              1111 0100 -101 ---- 1111 ---- ---- ----    # (imm, lit) 7
 PLD              1111 0111 -101 ---- 1111 ----- -- 0 ----   # (register) 5te
 PLDW             1111 0111 -001 ---- 1111 ----- -- 0 ----   # (register) 7mp
 PLI              1111 0110 -101 ---- 1111 ----- -- 0 ----   # (register) 7
+
+# Unallocated memory hints
+#
+# Since these are v7MP nops, and PLDW is v7MP and implemented as nop,
+# (ab)use the PLDW helper.
+
+PLDW             1111 0100 -001 ---- ---- ---- ---- ----
+PLDW             1111 0110 -001 ---- ---- ---- ---0 ----
-- 
2.17.1


