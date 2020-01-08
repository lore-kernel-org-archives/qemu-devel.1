Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F013AC00523
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 04:01:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B86FE20848
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 04:01:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sLNM0Yvv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B86FE20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip2Xa-0000Os-3j
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 23:01:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49945)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ip2JC-00056T-TU
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:47:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ip2JB-0003tB-Q4
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:47:02 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f]:44639)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ip2JB-0003ro-KM
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:47:01 -0500
Received: by mail-pl1-x62f.google.com with SMTP id az3so535368plb.11
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 19:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=oVEAuPQVi3GPH490Dgn06PxWdedtC6S15waZ9SOo96s=;
 b=sLNM0YvvHhXgT1k/B1PN0paV2le9fJmRGD+ACi8jKcBUpboGpvo25mNwv+eYmrM3/y
 DQq0IVxUZCVhG66wQw+tE/9F16pxk+HFdmYTrUxkYF+vB5Vn+q19NdvsHGxNnGIr5Kup
 CHvzsUTnqdLJna31gCy/ey1Pj9B91y6WylsmqfH3sjKlLGn85Z782s3ebb8XwyzCdWuD
 tvYkLjYSBF3nvIUvvrfMtBLM13R4pyZsl7bHg3PvK1ZzNeGqaQEzh3+IINLLAwVaO6z4
 QiQiK3Z+2XEvlUkn48JNFr3/YPIkZhxi+axyLLlV2l6dbCj5ATndZXKtZt8FLPMnrjGp
 igyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=oVEAuPQVi3GPH490Dgn06PxWdedtC6S15waZ9SOo96s=;
 b=TWsdRk6k5Qn2puom0nPF8SwAq62Ezf6oJOgF6NkggYzauHj76f3B3gxV0UwXP30hOO
 MD8EzguhEqQaEDUWqYqeW2pkPIQTqLhEbCe2D9w30Nqp4xt+Tb382BehL+ko18P5VYy+
 95k6btvWmBK/ciRP+sptviX61mJ1u3E10brryGp49vz2RjA0/jQovPj0GEFvcFzuplAp
 PM+ykzBZrYzAl7ntWSKu7sx68meleFpZWgGXipkXeLkY2qUApRp0P5unfKhl5/UK5Uw0
 Rg5xE3uTBp28jC4lPIOPR0TlxfnN/gsOFYJAmaDBcpgr5P49C8Y1WUc62Q485jf3Pooc
 91sA==
X-Gm-Message-State: APjAAAUpFrilId0F4+lu4d7hCxRhb150fy8RzmcvYH5NKQQAc9XV9tIf
 Ah6tTLIA8wEUFj0cnqdkyF+J+G2ZxvWgsg==
X-Google-Smtp-Source: APXvYqwInPIvCt3bFtWxTXYyWZKwtnjU72ell/zDr1pYFUt/3hyjmnozS816k4bci9WiXZ3cydqL/A==
X-Received: by 2002:a17:90a:8912:: with SMTP id
 u18mr2100717pjn.21.1578455219412; 
 Tue, 07 Jan 2020 19:46:59 -0800 (PST)
Received: from localhost.localdomain (alanje.lnk.telstra.net.
 [120.151.179.201])
 by smtp.gmail.com with ESMTPSA id f23sm1198433pgj.76.2020.01.07.19.46.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2020 19:46:58 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 29/41] target/unicore32: Remove MMU_MODE{0,1}_SUFFIX
Date: Wed,  8 Jan 2020 14:45:11 +1100
Message-Id: <20200108034523.17349-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200108034523.17349-1-richard.henderson@linaro.org>
References: <20200108034523.17349-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::62f
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 peter.maydell@linaro.org, Guan Xuetao <gxt@mprc.pku.edu.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The functions generated by these macros are unused.

Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/unicore32/cpu.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/unicore32/cpu.h b/target/unicore32/cpu.h
index 50ed9dd99c..7a32e086ed 100644
--- a/target/unicore32/cpu.h
+++ b/target/unicore32/cpu.h
@@ -133,8 +133,6 @@ void cpu_asr_write(CPUUniCore32State *env1, target_ulong val, target_ulong mask)
 int uc32_cpu_signal_handler(int host_signum, void *pinfo, void *puc);
 
 /* MMU modes definitions */
-#define MMU_MODE0_SUFFIX _kernel
-#define MMU_MODE1_SUFFIX _user
 #define MMU_USER_IDX 1
 static inline int cpu_mmu_index(CPUUniCore32State *env, bool ifetch)
 {
-- 
2.20.1


