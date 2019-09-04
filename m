Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E65C3A5A9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 20:10:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 594C92077B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 20:10:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="onMzxY+o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 594C92077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5bcE-0005OP-AU
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 16:10:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41173)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i5b0t-0005V7-Lo
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:32:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i5b0r-000391-NG
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:32:19 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d]:45024)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i5b0r-00036P-8U
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:32:17 -0400
Received: by mail-pl1-x62d.google.com with SMTP id k1so2686615pls.11
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 12:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=hGHY6IsJM30Hyd1TOf3r4ZHdVokWmEQOpc5BWJnbF8A=;
 b=onMzxY+oCQs5KCsSNrpCHR3g/bkRgznJcy/vV5Ikpusi3H8nSvyIOEuaPgZB+H9FJt
 3fJf0F0AZ5LaGak8Zz8vSr8Dk13gdbfmxHieg6uniOhd0lv+BEYOlY3q6iMuvIk55bQL
 x1/NiYKuLpjKGecOupyBQRszNmBSwQ7xzlgKX+mnl7QWS2RZULZvNv+PufMWmINKcpDi
 wBup9iuMD71jfgVtP/kgaE6I6Vg7E23LAxbtq5I72JTrVCDDD6mdD/AkWLU4tLkAfvPY
 NnmgYc50p06ILrQis06aAcXdofo1IbqHyx5Pw6FOqIXswEYZnzw+u9q3QATm8eqlhcQ5
 8oUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=hGHY6IsJM30Hyd1TOf3r4ZHdVokWmEQOpc5BWJnbF8A=;
 b=Ca4NovejqF8kJ6J7pPzCNwlnhvCpw9UkYqGsP0thVhjpFRkaTipnMHQHjHK0j/agMI
 A0hHfMxRwvsWUlZNjckd+iwFwayNPY/1/SCK/bR5BXLl0xYkV30J4JEpRk3/LR+mkU/u
 KmNcfewkQJpSnteDMj+PsoSrRBEjkfIrWsA6HGcBs0u8My3l/a/o2VWgCJx3BGU6C04V
 cHzOHTmZLhfVNN4YNHKvQ3uZ8Zl0Z35MSBaFiWJ80F5rukVo8MXD6Ulx7DTyqSqQ/y2d
 2b72PAG/Zzh2bWMxwGJ5WIEKoMJcvwi7zaetTjDYOyfxhcjm/yvqMIejQ43O0Ut7Jt0P
 Z9ow==
X-Gm-Message-State: APjAAAUhteSYiQSTTj0NA7bAygiAaerwru8qITCe8nHnb8wO1VXNOE7d
 tAxyItNjliZ7xL8G/F2TbScEnbE9jbs=
X-Google-Smtp-Source: APXvYqzHhJDwTFPBhT2PDzczLJOPzqa3uQfz3g6Svn+MPdJLap9cOXsezRdcxXghpxjYbtNt+lkfEw==
X-Received: by 2002:a17:902:33a5:: with SMTP id
 b34mr41846656plc.286.1567625534794; 
 Wed, 04 Sep 2019 12:32:14 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id f6sm18999174pga.50.2019.09.04.12.32.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 12:32:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 12:30:48 -0700
Message-Id: <20190904193059.26202-59-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190904193059.26202-1-richard.henderson@linaro.org>
References: <20190904193059.26202-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::62d
Subject: [Qemu-devel] [PATCH v4 58/69] target/arm: Convert T16, Reverse bytes
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 18 +++---------------
 target/arm/t16.decode  |  9 +++++++++
 2 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index ce394ddb00..b70491d39e 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10730,7 +10730,7 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
 
 static void disas_thumb_insn(DisasContext *s, uint32_t insn)
 {
-    uint32_t val, op, rm, rn, rd, shift, cond;
+    uint32_t val, op, rm, rd, shift, cond;
     int32_t offset;
     int i;
     TCGv_i32 tmp;
@@ -10927,20 +10927,8 @@ static void disas_thumb_insn(DisasContext *s, uint32_t insn)
                 break;
             }
 
-            /* Otherwise this is rev */
-            ARCH(6);
-            rn = (insn >> 3) & 0x7;
-            rd = insn & 0x7;
-            tmp = load_reg(s, rn);
-            switch (op1) {
-            case 0: tcg_gen_bswap32_i32(tmp, tmp); break;
-            case 1: gen_rev16(tmp, tmp); break;
-            case 3: gen_revsh(tmp, tmp); break;
-            default:
-                g_assert_not_reached();
-            }
-            store_reg(s, rd, tmp);
-            break;
+            /* Otherwise this is rev, in decodetree */
+            goto illegal_op;
         }
 
         case 6: /* setend, cps; in decodetree */
diff --git a/target/arm/t16.decode b/target/arm/t16.decode
index 032902a1f4..19a442b894 100644
--- a/target/arm/t16.decode
+++ b/target/arm/t16.decode
@@ -24,6 +24,7 @@
 &s_rri_rot       !extern s rn rd imm rot
 &s_rrrr          !extern s rd rn rm ra
 &rrr_rot         !extern rd rn rm rot
+&rr              !extern rd rm
 &ri              !extern rd imm
 &r               !extern rm
 &ldst_rr         !extern p w u rn rt rm shimm shtype
@@ -195,3 +196,11 @@ SETEND          1011 0110 010 1 E:1 000         &setend
   CPS           1011 0110 011 . 0 A:1 I:1 F:1   &cps mode=0 M=0 %imod
   CPS_v7m       1011 0110 011 im:1 00 I:1 F:1
 }
+
+# Reverse bytes
+
+@rdm            .... .... .. rm:3 rd:3          &rr
+
+REV             1011 1010 00 ... ...            @rdm
+REV16           1011 1010 01 ... ...            @rdm
+REVSH           1011 1010 11 ... ...            @rdm
-- 
2.17.1


