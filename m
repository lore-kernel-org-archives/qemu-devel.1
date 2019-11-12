Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E00C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 15:12:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 575E421872
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 15:12:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hlIJxwMD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 575E421872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUXqe-0001hY-GF
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 10:12:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41249)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iUXor-00082A-GV
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 10:11:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iUXoq-0007F0-5t
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 10:11:01 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:35825)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iUXop-0007Ea-W0
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 10:11:00 -0500
Received: by mail-wm1-x334.google.com with SMTP id 8so3364096wmo.0
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2019 07:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=5WNDL2lokmvGs6pNFIyUYmSZANDD27WTJq6Cldgl7IE=;
 b=hlIJxwMD39RjYx4a77Xtbjr6EgLAbJK6XAzWlpc8F0hb97esyN8/dcZmZBfU7c5ZBo
 aHLj5CHWeweO3nlEnl9AqMRvGr6xnkBLeWQbWT6yf6/tV56E0Se4WuFsFx1M2oTDKB+Y
 XWA9sCOTr3IBe1a0djMEFcGrLNkd0WLlXdKPhPaADcbVFYHdumwn3YPH887lUzGjxgBb
 7xmdgu8Eb6Yfkm0ZlS+AdtKeS+XyPNoYKg9EEfxuYNZcxOBG45flmbZsnqRus1NiA0b2
 PgiNKs7jqPn+yJnPz5DwTjN0n1rgJ7qOjXBMJYJE4ErW/8JtLiXmuTSS17VoZLXIPmUc
 hmPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=5WNDL2lokmvGs6pNFIyUYmSZANDD27WTJq6Cldgl7IE=;
 b=dCb1qXinjCeNWliMjWLeX1bG2Q57gAA6wv9otg2cP4etvFXU71xefj+9htHBFlk8CF
 VkMTj4ZyEdkq1Fjf1M/nyjPTFJKToRWOyI3iPReeIzp+Kb2oLDxj11GBLxD1GeYGWPCF
 TSezXcpO2ZOLMSZ4meWoNzp9mdnc3eVObSy0p+tl19MpjDpXxaWqJL3o4ksYxF6OhTVk
 rDaWjqoI7fNejkCFEfhKZzTu2OySpMXN3ucCL+x29titRJiiof/TNmQSp0rDiZwY1B8S
 mRalUxgqC2ZiHQE/RS/LFqpZmQXHYYJ40i7XHNj1UHHaKs6KWH6PZO/hp++kYNXvpNRf
 vjNg==
X-Gm-Message-State: APjAAAVNc+w4bYY1YO1UiQN2pMMuZQmXdz+cgkD+8rohJPRUDTHB5WBX
 9FZs+5SBJhgdF+bimiGeg4KgGw==
X-Google-Smtp-Source: APXvYqz1SowmPxeQv+JommMs8WTKgC1QWOkW+qCI8bRh8q24/yrZnGUwME/mJ0xPzkdKh8oenTK6mg==
X-Received: by 2002:a7b:ce11:: with SMTP id m17mr3958194wmc.123.1573571458334; 
 Tue, 12 Nov 2019 07:10:58 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id n65sm5225445wmf.28.2019.11.12.07.10.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2019 07:10:57 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7A3041FF87;
 Tue, 12 Nov 2019 15:10:56 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [RFC PATCH] tests/vm: make --interactive (and therefor DEBUG=1)
 unconditional
Date: Tue, 12 Nov 2019 15:10:51 +0000
Message-Id: <20191112151051.2205-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::334
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

While the concepts of only dropping to ssh if a test fails is nice it
is more useful for this to be unconditional. You usually just want to
get the build up and running and then noodle around debugging or
attempting to replicate.

Cc: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/vm/basevm.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 91a9226026d..0b8c1b26576 100755
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -403,7 +403,7 @@ def main(vmcls):
     exitcode = 0
     if vm.ssh(*cmd) != 0:
         exitcode = 3
-    if exitcode != 0 and args.interactive:
+    if args.interactive:
         vm.ssh()
 
     if not args.snapshot:
-- 
2.20.1


