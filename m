Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E74BC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 17:39:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 084C320656
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 17:39:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mZuY0QtE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 084C320656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAGwe-0003nS-5u
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 12:39:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50806)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jAGbo-0000d4-P3
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 12:18:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jAGbm-00080h-A1
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 12:18:00 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:36181)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jAGbm-0007we-3H
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 12:17:58 -0500
Received: by mail-wm1-x330.google.com with SMTP id i14so3195043wmb.1
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2020 09:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=0JgH8pZ7q1+DouQJLOPehKM2GAK95/4SWSv6MZSVrXk=;
 b=mZuY0QtEZh9y3+nkQokCCXg64VJR6qvzj84bSPLRMeB6aUxaHpQXPzUVoBd6f7j5iw
 9lz9DJvan7ytrBmEIhJg2y2UFRj5PNA3ULcuAcee84ZATAqN1X6BGq2G4hmJdUnVa1wo
 Oy9KYgzLuqaB2+717SQWtYZdJze5TRccU6WBLHtzjo1khe8LYRrF6mahgscHMWEghU+8
 LsVpaBO5bY2ESXo293RJ1BS87F9lt6XGe86aGY0dZ4C1U76MU26tnU097NGxUUFlWZZ0
 6VcAHK5wBSSAMd3YLdw5NmXBGhsvLFfyPjYqpFoexxyzGltNj0jRSKjYeCJTo0bEWB/F
 HNRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0JgH8pZ7q1+DouQJLOPehKM2GAK95/4SWSv6MZSVrXk=;
 b=jpNBTEutU1JfxZ44AtqlGhwws+xYiK0VG+HKXJhkeStNsUvSI1MDsj4w4Gb8jd3UqE
 aX405TLO64hvXZNN/L7FvZ1hu9coC4N4CPO2rwIoScC4eSO1gLmsEDO0FuQdTFViVNLr
 VLvLChY4N7zph9yiIRfE9B2V52f6x17Eh6nTaWkvyhtnTnVl4e4QBm7WFM7IydR6d+PC
 0UaIh0wI6fv1tVEX8zvkBIVi997d+XrrTNv3BZRMYXUVmONaCqcUKM5ux507ap4qIMKy
 3oy7qFmQcE8exnjFdkwmKRH3eamhP0cXGdk1ZZh1mk7w3JESGS21YnSYfW57NQ14nJQb
 7HAA==
X-Gm-Message-State: ANhLgQ0S/GaYCMsznKWuzQl2lV1Ko9PpPg6bx5blKfusVK00yB5L86RJ
 WjjzWn/qBYeGMw54IF+C4rvQDNivHVG/2A==
X-Google-Smtp-Source: ADFU+vt6mu3aHd96kcp5A19LPaZopY99eSpFT9JzzALHwQLGg3+fIQF08g7FU4QiLdqpNnPAl2xg2g==
X-Received: by 2002:a1c:9e51:: with SMTP id h78mr4810124wme.44.1583515076692; 
 Fri, 06 Mar 2020 09:17:56 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id f8sm6948346wmf.20.2020.03.06.09.17.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2020 09:17:56 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 5/7] Makefile: Make all Sphinx documentation depend on the
 extensions
Date: Fri,  6 Mar 2020 17:17:47 +0000
Message-Id: <20200306171749.10756-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200306171749.10756-1-peter.maydell@linaro.org>
References: <20200306171749.10756-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::330
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add the Python source files of our Sphinx extensions to the
dependencies of the Sphinx manuals, so that if we edit the
extension source code the manuals get rebuilt.

Adding this dependency unconditionally means that we'll rebuild
a manual even if it happens to not use the extension whose
source file was changed, but this is simpler and less error
prone, and it's unlikely that we'll be making frequent changes
to the extensions.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 2ccd80065b6..5847f8d41d9 100644
--- a/Makefile
+++ b/Makefile
@@ -1046,7 +1046,8 @@ build-manual = $(call quiet-command,CONFDIR="$(qemu_confdir)" $(SPHINX_BUILD) $(
 # We assume all RST files in the manual's directory are used in it
 manual-deps = $(wildcard $(SRC_PATH)/docs/$1/*.rst) \
               $(SRC_PATH)/docs/defs.rst.inc \
-              $(SRC_PATH)/docs/$1/conf.py $(SRC_PATH)/docs/conf.py
+              $(SRC_PATH)/docs/$1/conf.py $(SRC_PATH)/docs/conf.py \
+              $(SRC_PATH)/docs/sphinx/*.py
 # Macro to write out the rule and dependencies for building manpages
 # Usage: $(call define-manpage-rule,manualname,manpage1 manpage2...[,extradeps])
 # 'extradeps' is optional, and specifies extra files (eg .hx files) that
-- 
2.20.1


