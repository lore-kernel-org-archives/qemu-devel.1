Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC7CDC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:15:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98B4B21883
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 21:15:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FXuMrH/a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98B4B21883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlfOs-0006w8-NH
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 17:15:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37574)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfEB-0003Oi-Um
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:04:11 -0400
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844]:43959)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfEA-00005O-0p
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:04:11 -0400
Received: by mail-qt1-x844.google.com with SMTP id v19so301336qtq.10
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 14:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OzUdSzbvDHrAdBgz7T3QQ9Qj/8hER0zlUjzEzhKy+Cs=;
 b=FXuMrH/ayFieQeNBk58pBYu631HqHSlzSzfND2T+mxHfKeUhQVTf3u8CJd2e9tPV5L
 ki1uVigHNioK4v6sTW7g1KGdY7sCT/FuxItCNa/SmM+hnc6L7WpLGbbzUX3/Gfkbqkwh
 6Bqw4zuOZpBlFas1ci0kqwt8xTXBaIs1CATSNfaJYdT61mUBiCYj0fxsTa0uQ47z1GoH
 YMxzb+k7L6kFvZnTKOY6FLhAiyKALfCBUknuAXfUnG2Usg7XheyXZilfOeJXMWqrk3Dp
 g5MdItvGr3bvtnbcpTQ60Wxj32vDgbd7pbJt59G5hqnZK1neKhA5Dtl3RE1mrW9bxy35
 QqVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OzUdSzbvDHrAdBgz7T3QQ9Qj/8hER0zlUjzEzhKy+Cs=;
 b=uXzeDlphY5uaM3xVw9jpuAweAL8rDPQmd8jPSzHwXk+7iea9HAlaIJbpkpLSCQlQQw
 toXEVzPUNx7ysJe4fUcorsGqZ3igO05y8a1S+uzIaIZORbE4zrN224hTaJEQ/0PXELv3
 +x7PZpkqJ7K4XXKWeLo75gSe7RyuGiqgBrkcBPkRvSY5y7VmLvREj/IlwTjCkTwkjkfE
 UhC4KkmQcWoGvD8imT5CodC/J6lJm9wA/NiYEPMuDGf7JJGK3ILoGBjDUQr+jpjIlV59
 80QbbkyIrrf9KcKooLlHLQkyINK3cRHZ2U9iK0rF+zsgKhgXX06lnPQ4VFM1cBWx3O1G
 QIxg==
X-Gm-Message-State: AOAM5325A1P7nFlcXdYbVVJrTeDMLr/ZtMm4LW1zJUR69kbjimrbhZuW
 X4CazGkklfF4pL+yEEQmcZZ4PzzDpxMlxw==
X-Google-Smtp-Source: ABdhPJyF16sG7NBWpMntU37cYM/KPisBoMQLSRvrWGinFdgmeLhsWdNSr+DC3UzuzyILis+im0HDUg==
X-Received: by 2002:ac8:341a:: with SMTP id u26mr1164523qtb.36.1592427848788; 
 Wed, 17 Jun 2020 14:04:08 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fc79:714c:9711:2e9c])
 by smtp.gmail.com with ESMTPSA id w13sm997245qkb.91.2020.06.17.14.04.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 14:04:08 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 36/73] s390x: use cpu_reset_interrupt
Date: Wed, 17 Jun 2020 17:01:54 -0400
Message-Id: <20200617210231.4393-37-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200617210231.4393-1-robert.foley@linaro.org>
References: <20200617210231.4393-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::844;
 envelope-from=robert.foley@linaro.org; helo=mail-qt1-x844.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Thomas Huth <thuth@redhat.com>, robert.foley@linaro.org,
 David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-s390x@nongnu.org, cota@braap.org, Paolo Bonzini <pbonzini@redhat.com>,
 peter.puhov@linaro.org, alex.bennee@linaro.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Paolo Bonzini <pbonzini@redhat.com>

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


