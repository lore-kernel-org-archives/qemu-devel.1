Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0660C43457
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 17:02:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E0B722251
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 17:02:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kAI/AIWJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E0B722251
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQvmS-0005nR-Na
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 13:02:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38444)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQvJS-0000Ro-Eh
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 12:32:11 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:52355)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQvJQ-0005Bv-8k
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 12:32:10 -0400
Received: by mail-wm1-x334.google.com with SMTP id e23so3398033wme.2
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2020 09:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=MKOviPnveTRlrgxkZKgnWnxRJwnFTKYx0zlIqfHdr9k=;
 b=kAI/AIWJvU3BKU7v3yu7TVnHhoAmD2NB3+Q7/Ou5zStnMhiaQGexO3FGkjTjorQgCp
 ZCFciMad7q2vRTsC6yrkQ07CimOsJ1pYmPzovAmk0mrO13LrsHqpRUsxY43I62gKuRT3
 q5G1pREL9twYVLVPVmCDrVlRlFfnA81Ifr/b7xUHOjzp9ZXb05E3/cCn0/0hfZdQjRIN
 fFuoJPlj90mKqXzQDFHv5H29mN68CQjDEeaoIPD5y3qOtyTi8rYth7Oh3FitycaMxzAg
 NzL8+lPjGbmq5PUuK/9O8WaqyC4KLiIc0j+m2x/NS6hWPJNmbjT2HjvVfXk/kA1d975p
 MHKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=MKOviPnveTRlrgxkZKgnWnxRJwnFTKYx0zlIqfHdr9k=;
 b=La78t3UNa+V9jeGO4nYT2w3bYFKyXqpwVIk9As7gmP+HSh9duwN0HAWNdD0quYRmUJ
 rXsv08obp5BBZpUFxyIZzKW/xoIHnYs+NhGbl/327hsFSJMDcTcAQQgS/+PuU8yBcAb3
 NlO3r/Ih+4MFOnNay2qlMFmCaGENfhSNAjptS6ceTwjnIvDe3+oYkzSTNp6XShCthhe1
 UvlSwBuQ/EIlHg/2C2cm7xgr5NwqggKNSwUofZi7tMOMqVWmOkI/S3FK4dsHy9+Qz/U6
 5aZvoIKMWl63/xIkrF4CZwtqXaGogJoIZsWv4h1ZJ9wxcm0vElCuNZQJD6XdlLJeNQLl
 D9gA==
X-Gm-Message-State: AOAM530QyH7iFV4FpPJMuCZ2bDBz2FXBCHhYmMJ4NmnxcRO2vwjHe7Q7
 rfWfpJOusHAj8QtZLB4i3qFk1w==
X-Google-Smtp-Source: ABdhPJx2KQ4lNHAWkMB+MoSU50BnkMl8H01jW1DMSrOx3BD70nA9slblX2Iqzpf1A0WVRo+5jQ6j4w==
X-Received: by 2002:a7b:c09a:: with SMTP id r26mr15426707wmh.45.1602261125397; 
 Fri, 09 Oct 2020 09:32:05 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f14sm12997462wme.22.2020.10.09.09.31.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2020 09:31:53 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DF1611FF98;
 Fri,  9 Oct 2020 17:31:47 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 09/22] contrib/gitdm: Add Baidu to the domain map
Date: Fri,  9 Oct 2020 17:31:34 +0100
Message-Id: <20201009163147.28512-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201009163147.28512-1-alex.bennee@linaro.org>
References: <20201009163147.28512-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, Chai Wen <chaiwen@baidu.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

There is a number of contributors from this domain,
add its own entry to the gitdm domain map.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Chai Wen <chaiwen@baidu.com>
Message-Id: <20201006160653.2391972-4-f4bug@amsat.org>
Message-Id: <20201007160038.26953-10-alex.bennee@linaro.org>

diff --git a/contrib/gitdm/domain-map b/contrib/gitdm/domain-map
index dd79147c76..a4102154b6 100644
--- a/contrib/gitdm/domain-map
+++ b/contrib/gitdm/domain-map
@@ -5,6 +5,7 @@
 #
 
 amd.com         AMD
+baidu.com       Baidu
 cmss.chinamobile.com China Mobile
 citrix.com      Citrix
 greensocs.com   GreenSocs
-- 
2.20.1


