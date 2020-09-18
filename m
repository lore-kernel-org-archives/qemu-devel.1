Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DCC6C43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 19:31:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C12B021734
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 19:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZMAnrja1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C12B021734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJM65-0006HA-Qj
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 15:31:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49152)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJLIa-0001Qq-Id
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 14:39:56 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:44932)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJLIO-0007KD-Io
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 14:39:51 -0400
Received: by mail-pl1-x642.google.com with SMTP id j7so3419852plk.11
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 11:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4XHIUjh2oBWbEwnuE02Cz+2r9FHl4yCsiyFloX+fVF0=;
 b=ZMAnrja1m8Y6VXSQfSzs3oxknICpQ42HabfUfVxgFNQUU3n5tXw/LDNpLMHc3KrYFk
 +edzLvrDZBi1rr5G9tdZN0eNnihTfHss0FMHopb0W5zmatsHZFE9Ag1VZnXjUNC1n2ae
 mTMNql/rx2aMd2r2tBL6MQD3kpNcCAkUy/gkRB8bnZTti2RfJ8i6I++MtvJ4Kvc5l1nz
 QlUkHDG1nrK+a9dN2K4mGPq1f6YcSQLcVnwy0buqeDDTGSj90hbqN6wKqQZAwFHS2hqo
 PggcLPLxrTbsI58IytNc307lzZ9/M96zOHMKQAFWjbJQ7LRMR5v+gtd8bCZVk1Gwjj1J
 03Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4XHIUjh2oBWbEwnuE02Cz+2r9FHl4yCsiyFloX+fVF0=;
 b=cF7egUYRPHmF+5IEO8dIW9qmOqRcxuLX5fP/AXJq4KaLgErq/0nzGnc/cx2yiQnMOF
 rcg3uSj1e5J6dov53T1yC7x0Rk48vHDS/7gUxKUauRtt+nHszs38APuFV6Ru+ACo61K1
 ZNGJxMUZcflJ3jfmgH7RakzqD4tXdndPzxJbkDmIKKiJNm+VWQ5mlJpBrO8XcoqkAKqt
 E7w7/DVWrTbsojH8ps/Nw9xsNKolTpYMbOzhC2qpYF2h5NDAuLABBNNJ05TdFNLD/5hA
 4sbkGKvxQ/KGNjNxXSRMrCdwg4tZLu3tSNwwQ5i18ZxXxyc4yXSyzaVrwVyP7l4udOXJ
 zLOg==
X-Gm-Message-State: AOAM532pa73Jwcs84vGFsF/ZBpjWNRFXh05hlNwUhKwEi2KCzNpI5QfD
 CcjBaPJbl6nyf5VErwUo7HfSynNrgVyBvQ==
X-Google-Smtp-Source: ABdhPJyzD7nhYr+TLIhKUr8VubcHX0HcbTUWRpdVMMrl7WfObprLdSwK4Qg0aL96gl16UDhpXLJzvg==
X-Received: by 2002:a17:902:aa85:b029:d0:cbe1:e70d with SMTP id
 d5-20020a170902aa85b02900d0cbe1e70dmr34662636plr.27.1600454381254; 
 Fri, 18 Sep 2020 11:39:41 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id f4sm3680723pfj.147.2020.09.18.11.39.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 11:39:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 81/81] target/arm: Enable SVE2 and some extensions
Date: Fri, 18 Sep 2020 11:37:51 -0700
Message-Id: <20200918183751.2787647-82-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200918183751.2787647-1-richard.henderson@linaro.org>
References: <20200918183751.2787647-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu64.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 3c2b3d9599..46b8a3908c 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -667,6 +667,17 @@ static void aarch64_max_initfn(Object *obj)
         t = FIELD_DP64(t, ID_AA64MMFR2, CNP, 1); /* TTCNP */
         cpu->isar.id_aa64mmfr2 = t;
 
+        t = cpu->isar.id_aa64zfr0;
+        t = FIELD_DP64(t, ID_AA64ZFR0, SVEVER, 1);
+        t = FIELD_DP64(t, ID_AA64ZFR0, AES, 2);  /* PMULL */
+        t = FIELD_DP64(t, ID_AA64ZFR0, BITPERM, 1);
+        t = FIELD_DP64(t, ID_AA64ZFR0, SHA3, 1);
+        t = FIELD_DP64(t, ID_AA64ZFR0, SM4, 1);
+        t = FIELD_DP64(t, ID_AA64ZFR0, I8MM, 1);
+        t = FIELD_DP64(t, ID_AA64ZFR0, F32MM, 1);
+        t = FIELD_DP64(t, ID_AA64ZFR0, F64MM, 1);
+        cpu->isar.id_aa64zfr0 = t;
+
         /* Replicate the same data to the 32-bit id registers.  */
         u = cpu->isar.id_isar5;
         u = FIELD_DP32(u, ID_ISAR5, AES, 2); /* AES + PMULL */
-- 
2.25.1


