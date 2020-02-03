Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEEA1C35247
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 15:43:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB48321582
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 15:43:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qpy1MNqL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB48321582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iydt8-00063C-Vm
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 10:43:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34151)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iydrx-0003dn-BI
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 10:42:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iydrw-0003YR-4h
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 10:42:37 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:44138)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iydrv-0003Wj-NJ
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 10:42:35 -0500
Received: by mail-wr1-x444.google.com with SMTP id m16so18787055wrx.11
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 07:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=CubTYAdlw2JZ1kD9hOQqp0i2EbDYf9CKZbJcxpFI38I=;
 b=Qpy1MNqLN2ShDShR/N2Os6Ous8/b8mWSh0CzYors+Zq997H0ID/DGY5MM0ZiyBgTcN
 NWelZh+mCNw/V8rex38C4i6isZB8EGcmSL03mHopyW0r1CZ4ApYiaHTywQnBBkKvLV5A
 sfJtWK2pR1zKU/DytRRWflxjCsObNeEwFdCB9Lbp7k+bI8XOI3f5rDjozpZViedP2nWn
 HFebTokg5Z0Ok4u5A/CHRrwovUlT6xnxk47PnAra55AEmWfdN88u36OWTTOqGddhQzeJ
 HxjNOyoRuWgVLuYnFejuPVk4L00lB7bAf2W87jjDZG/+9fNwOdFLu3yQgxO9GtBcjiH6
 HCFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=CubTYAdlw2JZ1kD9hOQqp0i2EbDYf9CKZbJcxpFI38I=;
 b=SEvOcLujyWLEhj4gPfalKjfECXL1KjEW7L7nkEadCxlEALlJhSkTl5ksquLgz4fY6M
 8GYf25qMP/0i/6VFnzQ0ILG6Lht2I3d24mnZwdpIjkYdHrbvYciWNBCkTh9dpwAV+wiK
 KuOwC0npoIdxBgqrIPQQ4RvlWNq8A8p22RzgvaN8nr0FtlFP8s/TJZD9P7iyR1/0hNSe
 ovx8kLpmY0FKRnrxweYexecqoDJuQ7jKh8LLdjmAyFPLnjM5dRQ2bGlaJ9yKqyPvcMyP
 IwiGB9yogJ9gGwoqSq6AhOiVTPnHt4XCAXOBSp2Hf/YpuGfZ61BYoIS7Z1hfKsr1qETb
 6xSg==
X-Gm-Message-State: APjAAAUI0iADhcj7D/1YY/G4SlcZVgyBImkyZiwbcQbCJMxFvpybF1uN
 cZA1Uw052TlgY9k/SPFvPD8oWt1ObyjHIA==
X-Google-Smtp-Source: APXvYqyLA234ry0JdoGgx9hVGJW01KVbx8CCjjr+efe/eyRzmnwnf+raaLH5P3O1N91/HW08R5lzdQ==
X-Received: by 2002:a05:6000:4:: with SMTP id h4mr6390435wrx.403.1580744554316; 
 Mon, 03 Feb 2020 07:42:34 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id s139sm24914476wme.35.2020.02.03.07.42.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2020 07:42:33 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] Makefile: Fix typo in dependency list for interop manpages
Date: Mon,  3 Feb 2020 15:42:32 +0000
Message-Id: <20200203154232.10648-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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

Fix a typo in the dependency list for the manpages built from the
'interop' manual, which meant we were accidentally not including
the .hx file in the dependency list.

Fixes: e13c59fa4414215500e6
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Oops...
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 1f37523b528..588a2993d93 100644
--- a/Makefile
+++ b/Makefile
@@ -1052,7 +1052,7 @@ $(MANUAL_BUILDDIR)/system/index.html: $(call manual-deps,system)
 
 $(call define-manpage-rule,interop,\
        qemu-ga.8 qemu-img.1 qemu-nbd.8 qemu-trace-stap.1 virtfs-proxy-helper.1,\
-       $(SRC_PATH/qemu-img-cmds.hx))
+       $(SRC_PATH)/qemu-img-cmds.hx)
 
 $(call define-manpage-rule,system,qemu-block-drivers.7)
 
-- 
2.20.1


