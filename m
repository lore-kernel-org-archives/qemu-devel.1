Return-Path: <SRS0=8j4I=3W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1EF2C35249
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Feb 2020 01:10:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97D0520658
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Feb 2020 01:10:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qJQTwYxA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97D0520658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iy3ml-0007AZ-NV
	for qemu-devel@archiver.kernel.org; Sat, 01 Feb 2020 20:10:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45723)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iy3h6-0003rh-Us
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 20:05:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iy3h5-0002Ie-SF
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 20:05:00 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:33534)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iy3h5-0002HC-MJ
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 20:04:59 -0500
Received: by mail-pl1-x644.google.com with SMTP id ay11so4366513plb.0
 for <qemu-devel@nongnu.org>; Sat, 01 Feb 2020 17:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=n25wa1lNKzA3qMHXUq9DJlF06TNEvhgokWarr1Y211Q=;
 b=qJQTwYxARCZRy2tr365rmVLsk7PBL8w7RyM55/FVJyutM/vpW6hvX5iqgiAXWk5xab
 whX+Ok3xKf9rd2qp+Dik5/zzKNgKThOTz6hF7P92pK3RaBvOMfwdiaCZCG1A22m45Kg0
 cSFlFOY6fITRR4WQBcqiMkRo/J2S49ZW4FzLnd+IYXixaG3Diqb91FyDECR69AVr9MG2
 pVPMuSij+YdSwel0ktbbcXjnvAAE33RfvKsNAYEUfmKTtGCyuMFByNNkrWYoRHyDheCB
 Db0rp74ilO9HAz8hUjm4RJWiuhM9ammSJXER0aqpdx/0W51C+PiT92EVIynVcNeJxykk
 VlhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=n25wa1lNKzA3qMHXUq9DJlF06TNEvhgokWarr1Y211Q=;
 b=WoIC/9NxneGVKtDil5CtXCntH9KpJRYJd2jEFGkuEFhIICuWSAEDqrckNMN1Sy6+yR
 Zm8MFZUqJEDSEfrfMqg2DugnOnIeyHTbBesJmYGP/FtYLMB1ODjtLGwCMx8stEYgEN0d
 KGuIlgaaeOpHOYPD/ecydmBTrcFp0vEgRUrBX0/uGAu/rk6SmKS97PigxMgjpjtwEDbl
 3Y7qCP9SCRiNixkJ4zEpBW5kaix8YTlQOoCFSHSZwxv8uJxC5enpOBJRru6AwzjX41Jo
 TBeZphMvKGKNUFHY++F49F9FxePqJvFRn35u9sT0Cq4xYPNYog4ivOXMMtiCxDIARx30
 Z+Ug==
X-Gm-Message-State: APjAAAXtLdKJU1efX7psxy7Y4zNMrt/OSInR6N0fyhDlbxF2nSQg36v5
 Og9yGgccv68y7AXLhOwcHcS86f/JMUY=
X-Google-Smtp-Source: APXvYqzQhJr1/9xmDfSHPIUA7+JHbSa2Zq4zBHYPgpLqxbgCb+opFu+eye76tJh9Sub25BNyYXdAAg==
X-Received: by 2002:a17:902:7c87:: with SMTP id
 y7mr16881737pll.24.1580605498446; 
 Sat, 01 Feb 2020 17:04:58 -0800 (PST)
Received: from cloudburst.WiFi.IPv4InfoBelow
 (h210.212.133.40.static.ip.windstream.net. [40.133.212.210])
 by smtp.gmail.com with ESMTPSA id 13sm14678975pfi.78.2020.02.01.17.04.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Feb 2020 17:04:57 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 14/14] target/arm: Enable ARMv8.2-UAO in -cpu max
Date: Sat,  1 Feb 2020 17:04:39 -0800
Message-Id: <20200202010439.6410-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200202010439.6410-1-richard.henderson@linaro.org>
References: <20200202010439.6410-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu64.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 57fbc5eade..1359564c55 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -676,6 +676,10 @@ static void aarch64_max_initfn(Object *obj)
         t = FIELD_DP64(t, ID_AA64MMFR1, PAN, 2); /* ATS1E1 */
         cpu->isar.id_aa64mmfr1 = t;
 
+        t = cpu->isar.id_aa64mmfr2;
+        t = FIELD_DP64(t, ID_AA64MMFR2, UAO, 1);
+        cpu->isar.id_aa64mmfr2 = t;
+
         /* Replicate the same data to the 32-bit id registers.  */
         u = cpu->isar.id_isar5;
         u = FIELD_DP32(u, ID_ISAR5, AES, 2); /* AES + PMULL */
-- 
2.20.1


