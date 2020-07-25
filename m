Return-Path: <SRS0=thXK=BE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B21AC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2020 16:08:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4634D206D7
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2020 16:08:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nHUPrYbA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4634D206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jzMio-0005JM-QO
	for qemu-devel@archiver.kernel.org; Sat, 25 Jul 2020 12:08:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54880)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jzMgP-0001tZ-Qb
 for qemu-devel@nongnu.org; Sat, 25 Jul 2020 12:05:57 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632]:33858)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jzMgN-0001si-TM
 for qemu-devel@nongnu.org; Sat, 25 Jul 2020 12:05:57 -0400
Received: by mail-pl1-x632.google.com with SMTP id o1so6064365plk.1
 for <qemu-devel@nongnu.org>; Sat, 25 Jul 2020 09:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Tn/0BiX/IEZ1RnYH9GODJ+VXClkGUOJZjcKmp7fXXkU=;
 b=nHUPrYbAyWW/qrnhxle3v9IaVNTptQIn0+Np29LdK3VhcMNM/69IfX+WkPNIS/k5xo
 f6CkqPasoGtKuKue+Y4OjOET5Mpd/OvfMNpZ6QvNu9Ds5zeKtTD0hQcA7oTjxXbQUOQR
 Zywonyjty/JVo+eW9s255rhVbzdpfM2j1pnV3t3JTeloINlxoIp0VqdJYIZssyK9Rq60
 cNlSBs71TO9KRNOw3hR14L/0syLz2az/HtnlDKUMA7NFWRMR0Yl+8Q3N6E6oTql1iMfg
 yz2vp5pv05W3UQtFIouN0AA5DDgMXJWPfympaQ5TtMnA+u4WPD2jT8JvOS1qRZq8Mwqc
 rP1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Tn/0BiX/IEZ1RnYH9GODJ+VXClkGUOJZjcKmp7fXXkU=;
 b=eWTAfSc1VrPOzyzOcEHSe5p/2H/Yo+IVQqG3qdyEqRjbSULpNHp3oB4x3SO9Bh++7u
 cF8fa3sC2qlDsXsk1cH6jLADbbx/2UTH8a0LVbQmElAXBTMYJgwEJGWvKfBFVrRgDb8o
 AGdJw3Ox5dpFe5FcxgEe0Oim9B0H86gQGKUArebUkLyFxZ8+IE21F6VZTqP1CmnX6hzj
 B2+aNn9t9OIs9sPVgjMnIstmthpH/oqnUd5sRpqWMwejhd+I+bWOtV6o97nAPxJfT3lF
 YtPB6Fdm5opEotVVAgTc1q6f0A7+zksogiaYN75iPKCXD+vyaXR6zL2ovmUg9fg0jJ+b
 PV1Q==
X-Gm-Message-State: AOAM533/6A9MOe9mzT6sF4zRlFC55I9Ek5qE9WBgdxz9cKi0uaxyDIlu
 GpYsQeemfMnGZl9Tx4WHbX3YGqI5MtY=
X-Google-Smtp-Source: ABdhPJwH1UAz3Th2al7YTuB1qcJtVKYQ8fVORrBkTFIkFrBtkF6YfoDys1QHhnN1ElBD1yfnQP5xwQ==
X-Received: by 2002:a17:90a:1589:: with SMTP id
 m9mr3308420pja.122.1595693153840; 
 Sat, 25 Jul 2020 09:05:53 -0700 (PDT)
Received: from localhost.localdomain (216-160-65-90.tukw.qwest.net.
 [216.160.65.90])
 by smtp.gmail.com with ESMTPSA id e18sm9731801pff.37.2020.07.25.09.05.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Jul 2020 09:05:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 3/3] target/i386: Save cc_op before loop insns
Date: Sat, 25 Jul 2020 09:05:48 -0700
Message-Id: <20200725160548.750749-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200725160548.750749-1-richard.henderson@linaro.org>
References: <20200725160548.750749-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We forgot to update cc_op before these branch insns,
which lead to losing track of the current eflags.

Buglink: https://bugs.launchpad.net/qemu/+bug/1888165
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200720154028.477457-1-richard.henderson@linaro.org>
---
 target/i386/translate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index a1d31f09c1..caea6f5fb1 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -7148,6 +7148,7 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             l1 = gen_new_label();
             l2 = gen_new_label();
             l3 = gen_new_label();
+            gen_update_cc_op(s);
             b &= 3;
             switch(b) {
             case 0: /* loopnz */
-- 
2.25.1


