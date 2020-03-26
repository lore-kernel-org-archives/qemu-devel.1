Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE86C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 19:52:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26498206E6
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 19:52:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jVdnGHFq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26498206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHYY0-00071Q-Be
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 15:52:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58923)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1jHYKh-0007Dq-7Z
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:38:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1jHYKg-0001oZ-3h
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:38:27 -0400
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744]:40098)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1jHYKg-0001oK-0F
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:38:26 -0400
Received: by mail-qk1-x744.google.com with SMTP id l25so8186638qki.7
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 12:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dhKwABjxRwU1BItR+iFdcDqbKoaPFQUDx67bS6N6p4w=;
 b=jVdnGHFq5RVtmIWLCFS25467xzv0DO5ySf9LfJDJrZSNW5JvM1CPsGdfz6mXweMdok
 a04buppbKd2UsLHxqBNZksnhcdi4wW3TQjgsqLqxiyioNdL5R1Cu+74VRvC359twJD2o
 4BdHaEw8yiEiaowuqu7LWugYtRoq9Wh/j43HRCiaaRqbI05HYPbNjn6xpMRqsERil2ks
 vHaxPfXbmMHE0TsXAUpKmAFry7iJKiErtpZtSU5FjZgh16HI74o77mJEDl/MmGs+lirs
 7F1D9NbcIZ7Ptsh55m+vl4BsslrZS43H4v72Sp+G0PiHIPq0Q/Dc2nakTf98d2qiRqeL
 Bvlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dhKwABjxRwU1BItR+iFdcDqbKoaPFQUDx67bS6N6p4w=;
 b=GB0U2sFDKmMaAmiXijWcw32BCMh19I7G1YfGf4VoArZIX1tst7JFh+PTrCQJlyvxcv
 xgWBwPiGulsIpwS+lVKckzksOCRYJBXaayJHlQxiOa4+SpR4X41UVHp9D0DG1izdtFGN
 1QpVFXfAjHGhogjNL8pvQ4cHJ3Slwe7n/qSuvXfA/CsZNP5tXuhSLGm2SMR0gAZi6JP3
 DZuz37UBvxxmyP7yF8b2jwLNwoL7snRmekJLbK+2FHr5Knzr4Xl3W+jZVc5FfCDE2cI1
 53M5UJQ6Wpd3K5yOH52LM195Sr3DZI6O5uVg4e1tMs1SkTdu6ZVYRmJvU4mGa7bTdDhc
 piaw==
X-Gm-Message-State: ANhLgQ2EAUSDOvotlSvqhThdR9S5MCpEocF7bJW9GfU3ld0f920Yn8yn
 zhBFptUBr2jiU89dc7Skta8yOafQUhoHlg==
X-Google-Smtp-Source: ADFU+vtzsh/2JyZh6zxpv89eXfgJgJOA5q/FY5b6Osg5lS31meemBtks7bDE3fAZdeVFhvLzUZljEA==
X-Received: by 2002:a37:8645:: with SMTP id i66mr9912348qkd.91.1585251505210; 
 Thu, 26 Mar 2020 12:38:25 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fd55:4e67:1038:8302])
 by smtp.gmail.com with ESMTPSA id u51sm2161916qth.46.2020.03.26.12.38.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 12:38:24 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 37/74] s390x: use cpu_reset_interrupt
Date: Thu, 26 Mar 2020 15:31:19 -0400
Message-Id: <20200326193156.4322-38-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200326193156.4322-1-robert.foley@linaro.org>
References: <20200326193156.4322-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::744
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
Cc: robert.foley@linaro.org, David Hildenbrand <david@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, richard.henderson@linaro.org,
 qemu-s390x@nongnu.org, "Emilio G . Cota" <cota@braap.org>,
 peter.puhov@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Paolo Bonzini <pbonzini@redhat.com>

Cc: Cornelia Huck <cohuck@redhat.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 target/s390x/excp_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/s390x/excp_helper.c b/target/s390x/excp_helper.c
index db6640ba2c..dde7afc2f0 100644
--- a/target/s390x/excp_helper.c
+++ b/target/s390x/excp_helper.c
@@ -530,7 +530,7 @@ try_deliver:
 
     /* we might still have pending interrupts, but not deliverable */
     if (!env->pending_int && !qemu_s390_flic_has_any(flic)) {
-        cs->interrupt_request &= ~CPU_INTERRUPT_HARD;
+        cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
     }
 
     /* WAIT PSW during interrupt injection or STOP interrupt */
-- 
2.17.1


