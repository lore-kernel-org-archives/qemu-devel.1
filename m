Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65843C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 14:10:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DE1E20702
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 14:10:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="doiSvS/A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DE1E20702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqdRZ-0000cE-DK
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 10:10:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60800)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jqdKq-0004kG-1O
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 10:03:36 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:38633)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jqdKo-0006pA-6b
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 10:03:35 -0400
Received: by mail-wr1-x443.google.com with SMTP id z13so23991212wrw.5
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2020 07:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Hc/GcVPMTlu7EGTBmWJqWp3KNZYqt74iySDJhQWwxVM=;
 b=doiSvS/AcGDxLuuGZbW4HrBh69t+uEpuunpn0adkYBYU3cuD9QSvswtVFIqEzZQzk8
 Wc6dBgSZop6cCVG457kKNNSbKxNSqxM9elxj01O+pWq8RP4ytXRjPlKXxkJ+t3PK+eQs
 iKSx3Ns9Pr9LoSdJVVe6hg7tQvHiiMI4eIxRPNpADdJ72ZZUMDudyWSO1u0hbWUV46wi
 26l0UFlRxpLV8m8aLsDWppbjU/ixyRpIIzdfWbhtmEn4y/JoFtoUmzX4LH/9+iCjVKLj
 EUhP/Il+urPHW/zZxtjx0AnwMiNprMS+hUNVHgCKTcH+sieORX97OVTOVRiTs8lkuj6i
 mNPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Hc/GcVPMTlu7EGTBmWJqWp3KNZYqt74iySDJhQWwxVM=;
 b=kUXCvvgTAuw6Bc8yo7/IQsIDZTH9giAojqCm3Bxbv8HHrEZ3NKgVk5MO4X76fIm64f
 pSS6ExEIyFafqPHd1e84VVwX0q8TlMwTBZZexlG50hWlEZaNddbDNa39+LnpRjaKMBh2
 R6NMgPwPDnInp5klpq/rOaxYCkqraTBAkwSV0ZCRnqCSEtwYfp3q5oQ5+hVEpLe5Iv8g
 YJWzmt89TlcS2kGVoO4OSnBlQjQSoFvK3RjBaObHCEF6GyNTeyvilJ8dunXMQCYNiTZo
 C82emCySFFhI93Pn+lKJm6uOCArhFtaPxxwoXlMuu4DHGmwfBa+NPOFjFGVLyAckDvV6
 RHRQ==
X-Gm-Message-State: AOAM5320eK1mL8DaBLPvGKGnZOFAaKUK8AfAlwKNSU6N1d0yctaosxsT
 Pw65j409ykXQfO7kg+qau8JprA==
X-Google-Smtp-Source: ABdhPJx3nv0s8wCCqx/mV79f0gztcKbe55azUMHXXuxtJMumNe2Gh+13Hajcjz7MGZA83nWAjQkAMw==
X-Received: by 2002:adf:e484:: with SMTP id i4mr27695045wrm.246.1593612212715; 
 Wed, 01 Jul 2020 07:03:32 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id x124sm2330081wmx.16.2020.07.01.07.03.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2020 07:03:26 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6A18D1FF9F;
 Wed,  1 Jul 2020 14:56:54 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 16/40] tests/docker: check for an parameters not empty
 string
Date: Wed,  1 Jul 2020 14:56:28 +0100
Message-Id: <20200701135652.1366-17-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200701135652.1366-1-alex.bennee@linaro.org>
References: <20200701135652.1366-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x443.google.com
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
Cc: fam@euphon.net, Peter Maydell <peter.maydell@linaro.org>,
 berrange@redhat.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, cota@braap.org,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reported-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

---
v4
  - if [ $# == 0 ]; then -> if [ $# = 0 ]; then
---
 tests/docker/common.rc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/docker/common.rc b/tests/docker/common.rc
index 02cd67a8c5e..ebc5b97ecf9 100755
--- a/tests/docker/common.rc
+++ b/tests/docker/common.rc
@@ -47,7 +47,7 @@ build_qemu()
 check_qemu()
 {
     # default to make check unless the caller specifies
-    if test -z "$@"; then
+    if [ $# = 0 ]; then
         INVOCATION="check"
     else
         INVOCATION="$@"
-- 
2.20.1


