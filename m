Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1205DC4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 15:26:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 974B7235F9
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 15:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nXEM8fOL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 974B7235F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLpcb-00071V-Kl
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 11:26:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59762)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kLpWr-0000yB-4q
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 11:20:57 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c]:43416)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kLpWp-0005R0-E4
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 11:20:56 -0400
Received: by mail-pf1-x42c.google.com with SMTP id f18so3499295pfa.10
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 08:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=TRndLkCMxWNns7qPLAeoWU7hdSJPyNTmzGBqCDb04fk=;
 b=nXEM8fOLG1Tb0+hXhrGrxw11JS7PRU7sqoRTjUOLanQONpskeLnwGEvg4Z+3p/OojD
 xTEaDaebTLPE6jJ7JZpQUPv69muEsQ76haj1fkGnnCcUK3RxLgf8tHyfEr67/8GYXXu9
 PeUN9YT3Z82K+ltRLbrEqP2uQhF18KaFlykK2/YRqmOF7Wxk5J26i6qd+F3bgpprALV5
 oKEvQsmubScFWU1l5QnytiBzgJitqTXqkju1U6HqgzzYpbQPREn8k4MJxWiKHvcLvM7A
 t5Ik3AlZGCEy3oYiWKEDp3Sxun0I1T22Fg4gU4BQeqPYn3bFuUsdGsGm/97nRLvVObiW
 p68Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=TRndLkCMxWNns7qPLAeoWU7hdSJPyNTmzGBqCDb04fk=;
 b=Gg6OR7nKJXf0q7KdIZFMqv3wfaSpPVdfvKAYgNtP3fWWuJ8uHkTrHatPv17qq4gw7D
 k50/9p8yHiBWu/hjSViI0DM58+/qvE40wKjdsEPdFN/9EusDI1Lv7PsUryTvH9n3i3fi
 9bkoxYHUlGK9XSSK2UXo8FySM7bxEwd1XLPgMJWaLA5j6OgDbzVuWzOgY3h7oH3sd7Dx
 0LlYRKnwWDfsC7xhsGbAAn/I9NuJji0psgleV19HKvE0yalBa3PS7OPMs9mTkupdTY4s
 9B1pXBsdhUvSzYOEAePwRf1G2osK5q0gmznl3brhODjhInWHqRoVyLtG1CcH0LmP+IKm
 am6g==
X-Gm-Message-State: AOAM532CdhH0UJqqSujYeUEF4T6Grgw2b72J63j+rMIEnGjVJ/4u49z2
 qEeI9CGpgRIF0Bpo/wxsPL6Z7JTEcbxJgA==
X-Google-Smtp-Source: ABdhPJxrc/9QZK8apML+2H7vI0n/LwuC05152Xoh5IO8jR7SMZ7x7C9Szs/t/+wEtXyqIxR4D+1jng==
X-Received: by 2002:a62:6444:0:b029:13e:d13d:a12d with SMTP id
 y65-20020a6264440000b029013ed13da12dmr4527850pfb.21.1601047253573; 
 Fri, 25 Sep 2020 08:20:53 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id a5sm2717859pgk.13.2020.09.25.08.20.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 08:20:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 03/10] softfloat: Tidy a * b + inf return
Date: Fri, 25 Sep 2020 08:20:40 -0700
Message-Id: <20200925152047.709901-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200925152047.709901-1-richard.henderson@linaro.org>
References: <20200925152047.709901-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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
Cc: bharata@linux.ibm.com, alex.bennee@linaro.org, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

No reason to set values in 'a', when we already
have float_class_inf in 'c', and can flip that sign.

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 67cfa0fd82..9db55d2b11 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -1380,9 +1380,8 @@ static FloatParts muladd_floats(FloatParts a, FloatParts b, FloatParts c,
             s->float_exception_flags |= float_flag_invalid;
             return parts_default_nan(s);
         } else {
-            a.cls = float_class_inf;
-            a.sign = c.sign ^ sign_flip;
-            return a;
+            c.sign ^= sign_flip;
+            return c;
         }
     }
 
-- 
2.25.1


