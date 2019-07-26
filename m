Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1732EC7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 17:53:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBCC922C7E
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 17:53:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OUdEzYa8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBCC922C7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr4P5-0003iQ-Mk
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 13:53:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57299)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hr4Mj-00029E-8e
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:50:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hr4Mh-0007ab-5f
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:50:48 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:44162)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hr4Mg-0007Tc-Vz
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:50:47 -0400
Received: by mail-pf1-x444.google.com with SMTP id t16so24825652pfe.11
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 10:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=aps50xe7CceEtOuNm5w6u+s65ojahSCeZEPTzeYb2Dc=;
 b=OUdEzYa8SNfl74dE7aT6MwUI/pOTiIrNiw17RqWvxMcwtWmNvLDxWFx+wt16lCxiYs
 eNE78fLQL1V/WgNjmGRWl0Yp8dfq36CS61hQRz6hSf/LOCki2+ptyYwwGifOoK2k0H8K
 ErHfEigw0OEW+/7MQ/xwXez7wLEOyZmt5KGCzVnhhU/oDJsEwaUfq9rumsHSZW+sDGRA
 vGQGGJF4hiGk78/M1Z8FE6Tuu2o+JJa59UibkAo0O1le2UrbjndcO4i+DmMBvsjHNcwN
 d9wmRS6fvhQGFwcO6AAWQk6xv/ZF+OM1Am788PuAyk4KGdxFb9aDxgwUNtfy3BK0jSEP
 ZZCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=aps50xe7CceEtOuNm5w6u+s65ojahSCeZEPTzeYb2Dc=;
 b=VC4+B6pW2LbDkedPj9cFY7oEjqhn4+xVa9fhQamP7AbTtcrvuVvWiWReQ/b8tuLS3M
 cUOfpxj/PllkHior2RxhfGPg2twtpGHwNxJIFRWGC8/Rp5dQB1tgoZ/+xeeAsL6NuNVI
 VVjckHMvygIIM3ED7UudEKSMQnxt83zvh8ptj192nP1BWm67fSWoLOv13m/DQ95+i7NS
 rMQzt3Fo2tCgdp9H8nG9hq1BlXSoCiHvYPl6yBXSnupXwSX6Ck1gGV7kOOohyK64ivVF
 7dyzI2O3cwzgik+UQeDmAG8JM6JhJJ9OXL+DMQOfF4qkPnVH/P6IrgwoIco5ox2ejKBl
 rIlg==
X-Gm-Message-State: APjAAAVJ6KbgKEw1OhdUk2MFKLqucsBrqw1bih6bbAmmFY2IQnmXAkM2
 OcmaeNOXfThqsQEMRfUnrgSwavgaJI4=
X-Google-Smtp-Source: APXvYqyDeOxLqtrMhdkYEat+40Q1Xq6S1xdyeEris1C1nlv2eW5tEqThEo9kY4QQSozlK9kQUqd30Q==
X-Received: by 2002:a62:ae01:: with SMTP id q1mr22905447pff.219.1564163443819; 
 Fri, 26 Jul 2019 10:50:43 -0700 (PDT)
Received: from localhost.localdomain (97-126-117-207.tukw.qwest.net.
 [97.126.117.207])
 by smtp.gmail.com with ESMTPSA id o24sm104287919pfp.135.2019.07.26.10.50.42
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 26 Jul 2019 10:50:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 26 Jul 2019 10:49:33 -0700
Message-Id: <20190726175032.6769-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190726175032.6769-1-richard.henderson@linaro.org>
References: <20190726175032.6769-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: [Qemu-devel] [PATCH 08/67] target/arm: Use store_reg_from_load in
 thumb2 code
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There is an extra always-true ARMv5 test, but this will
become more obvious once we start unifying the
implementation of A32+T32.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 5e2dd8bb16..e316eeb312 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -9773,13 +9773,11 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                         /* Load.  */
                         tmp = tcg_temp_new_i32();
                         gen_aa32_ld32u(s, tmp, addr, get_mem_index(s));
-                        if (i == 15) {
-                            gen_bx_excret(s, tmp);
-                        } else if (i == rn) {
+                        if (i == rn) {
                             loaded_var = tmp;
                             loaded_base = 1;
                         } else {
-                            store_reg(s, i, tmp);
+                            store_reg_from_load(s, i, tmp);
                         }
                     } else {
                         /* Store.  */
@@ -10914,11 +10912,7 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                 tcg_temp_free_i32(addr);
                 goto illegal_op;
             }
-            if (rs == 15) {
-                gen_bx_excret(s, tmp);
-            } else {
-                store_reg(s, rs, tmp);
-            }
+            store_reg_from_load(s, rs, tmp);
         } else {
             /* Store.  */
             tmp = load_reg(s, rs);
-- 
2.17.1


