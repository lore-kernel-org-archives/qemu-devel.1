Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 153F5C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 19:41:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF66D20714
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 19:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PoU98qel"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF66D20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHYNY-0004EV-0e
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 15:41:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58428)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1jHYK1-00067B-8a
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:37:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1jHYK0-0001Ok-5t
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:37:45 -0400
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:34715)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1jHYK0-0001OY-1N
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:37:44 -0400
Received: by mail-qk1-x742.google.com with SMTP id i6so8205090qke.1
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 12:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wu18ytPvx1d0kVanWp/H7LPvrM4VUoBEe+P8kb9ryLo=;
 b=PoU98qelE5c7Q3AyXhh58/Azbvhdnb3oeQjWfDvCS+PSJ0PPMNNTk4gT/itHENC8Df
 ogfbcAA2j+a4Evcca+338ude7PtEKVNVp1jE0TxJDiQNuZQyytsluMyhYmLYO/2pdYHl
 JlE0LPpMCKjiXDMZ4GYFwR1ynh3FLftmeS+oTkfJ6vVSuMS4RjhLh/HNrkptztYsS+CV
 IMtGFjzLzm7zzylFK0WUiposvC8+TToLJ6vCwBoFPBNg/EZpBBaXpXynayXHyIz5UbJh
 wAlJ2bOpRc/FdumalUHpBOH1vM8uHsBg+zwx1DGqwI8RUW2DY8tQHauzKL/ogjmLg0db
 8DQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wu18ytPvx1d0kVanWp/H7LPvrM4VUoBEe+P8kb9ryLo=;
 b=hm/f1lGIaazZTD+Gq40GP8nQGI1G+qPb3n+XxhgXR3Np4C15k/Z3ADry5EIoBxVds1
 l60fif++mYn2Aw+RyuUQZwROStJibtsMN4Zqf0TZ59DIU2SpE5oWlW3yFXl7Fvjv94TT
 K2xAcBgR5cXouxwKD9c6KOrX7Z95bNQpOhfIG1Y15ZfIfx8DZG1h9RmtHgeJf+jDnU6L
 wU2ZRGO09rZMuDal5vB9iZGAWeDHTmyjj2dLIMNn2ivEYyT39Ane4bPh0/30O6VCi+MS
 hHf9zIbsHcLzlMXJK04xYG91ppNe9KboIL/Ll78aqul1vGHxspTLqDNcBOk4a66gukDT
 b2uQ==
X-Gm-Message-State: ANhLgQ1jRMV7n9r9/rV51BbuDrP772cRp6LpJmIzkuy+BwhVBOVQLSBP
 v5Fa0Ae6KpzelNa2w8BNbLAVHhZg2aJSHQ==
X-Google-Smtp-Source: ADFU+vsqXmPPyUX/My2BZX/cc1GUKnam4NNcCbffA0JJ96mSM2oXhiw3HJzK8jyDMrqo6UhnQ+3t2w==
X-Received: by 2002:a37:b4c1:: with SMTP id
 d184mr10451802qkf.452.1585251463106; 
 Thu, 26 Mar 2020 12:37:43 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fd55:4e67:1038:8302])
 by smtp.gmail.com with ESMTPSA id u51sm2161916qth.46.2020.03.26.12.37.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 12:37:42 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 08/74] tcg-runtime: define helper_cpu_halted_set
Date: Thu, 26 Mar 2020 15:30:50 -0400
Message-Id: <20200326193156.4322-9-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200326193156.4322-1-robert.foley@linaro.org>
References: <20200326193156.4322-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::742
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
Cc: richard.henderson@linaro.org, "Emilio G. Cota" <cota@braap.org>,
 alex.bennee@linaro.org, robert.foley@linaro.org, peter.puhov@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 accel/tcg/tcg-runtime.c | 7 +++++++
 accel/tcg/tcg-runtime.h | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/accel/tcg/tcg-runtime.c b/accel/tcg/tcg-runtime.c
index 446465a09a..32ec18fe40 100644
--- a/accel/tcg/tcg-runtime.c
+++ b/accel/tcg/tcg-runtime.c
@@ -168,3 +168,10 @@ void HELPER(exit_atomic)(CPUArchState *env)
 {
     cpu_loop_exit_atomic(env_cpu(env), GETPC());
 }
+
+void HELPER(cpu_halted_set)(CPUArchState *env, uint32_t val)
+{
+    CPUState *cpu = env_cpu(env);
+
+    cpu->halted = val;
+}
diff --git a/accel/tcg/tcg-runtime.h b/accel/tcg/tcg-runtime.h
index 4fa61b49b4..433b6bc88e 100644
--- a/accel/tcg/tcg-runtime.h
+++ b/accel/tcg/tcg-runtime.h
@@ -28,6 +28,8 @@ DEF_HELPER_FLAGS_1(lookup_tb_ptr, TCG_CALL_NO_WG_SE, ptr, env)
 
 DEF_HELPER_FLAGS_1(exit_atomic, TCG_CALL_NO_WG, noreturn, env)
 
+DEF_HELPER_FLAGS_2(cpu_halted_set, TCG_CALL_NO_RWG, void, env, i32)
+
 #ifdef CONFIG_SOFTMMU
 
 DEF_HELPER_FLAGS_5(atomic_cmpxchgb, TCG_CALL_NO_WG,
-- 
2.17.1


