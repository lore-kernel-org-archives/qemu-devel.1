Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E86DC3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 21:40:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 689D82087E
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 21:40:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bcDdgqJg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 689D82087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzpNu-0003Z5-KK
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 17:40:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58419)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1hzpLl-00019r-90
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:38:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hzpLk-0005ww-AX
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:38:01 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:41882)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hzpLk-0005wK-5I
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:38:00 -0400
Received: by mail-pf1-x442.google.com with SMTP id 196so1939693pfz.8
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 14:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=2Kulh9+xu3WIHTQp568/rqttxBdLC2HThk9gtIjvuts=;
 b=bcDdgqJgtfww91QUIwvYvDmy1SzpiaiU7oJ0yEBY+oshoiBQJ00X3efqYkGkapY2uT
 RkWzqYsT+io2tz0G/A0PbLYULvV8ZyJWpnmPgmgYXNJkWeHUI/OPTfinbfXINrpH1nyG
 74C0j15KycMM6MvVHsAVv4h+BLTKIPZ2rhi3yp1q2IIRMAW2yykbeJLLRAB1z5J8yzpC
 PhV3qIJ8mv8ONN75al+TKMLnvCTf+nyHbdRLlF1MSbSs6VXZga7n5WsskSNRUnk3K4cy
 Bq0VeuLzDZXL0KPko1KnXlQkRFAUN4KDyvCZQQf48vvKD9ziKjkeRNo0TVi5iInbfYdM
 T9aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=2Kulh9+xu3WIHTQp568/rqttxBdLC2HThk9gtIjvuts=;
 b=pWFi0uqCepJ6QoWNbGK0ztthQsML7JyZwpdMDAuB8dVIpkLMSb/4F7ZQPVytYdPRcK
 kmKNnLaKxJrFIpQbi48UlbWe4K/ppY+Oy4oIK4/iIOe6YOO6EwACwbh9RpKW2ERGeOnF
 si/KLsSb/YURLGGfSDkECNo+ISgTQyo//8WIvEJAawbbqmyNf2I0bMNmdNMKwZ3pGxUz
 1jGu9fL/YBzXKDrvY/ORL5pAJmP+T15wCTMhOMW8h3gizTnTTcGixnEizk32BskTYycV
 czplNQCLXEnaDi79FiBSQwuyQPiEX2pBZacVdcwFzW6YezTBGYoJZto8+gQUpQSi2T2p
 qI6w==
X-Gm-Message-State: APjAAAVU3+nn2+YuzxzyR4drU7vWdIQDA4hOSOzg1zvwNUCnCRoxrwnr
 1qkGb/CPl0MDgXBzow7ag4oJz6JDoZs=
X-Google-Smtp-Source: APXvYqyKJAHpJg7XEacRqWZFd6gkBoWMupi7CNCqdO3DF/zcD5RkEWtj0SXLqUsxmhO0yYSnUyvX+w==
X-Received: by 2002:a63:3203:: with SMTP id y3mr22150875pgy.191.1566250678807; 
 Mon, 19 Aug 2019 14:37:58 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id d2sm13446951pjs.21.2019.08.19.14.37.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2019 14:37:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 19 Aug 2019 14:36:48 -0700
Message-Id: <20190819213755.26175-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190819213755.26175-1-richard.henderson@linaro.org>
References: <20190819213755.26175-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: [Qemu-devel] [PATCH v2 01/68] target/arm: Use store_reg_from_load
 in thumb2 code
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

This function already includes the test for an interworking write
to PC from a load.  Change the T32 LDM implementation to match the
A32 LDM implementation.

For LDM, the reordering of the tests does not change valid
behaviour because the only case that differs is has rn == 15,
which is UNPREDICTABLE.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index d948757131..db69d998eb 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -9714,13 +9714,11 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
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
@@ -10854,11 +10852,7 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
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


