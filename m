Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C058C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 13:50:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0ECFB206F6
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 13:50:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eIjn78ZR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ECFB206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGjxE-0002DZ-6Y
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 09:50:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52195)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jGjwG-0000t0-9G
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 09:49:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jGjwF-000261-Cr
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 09:49:52 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:51765)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jGjwF-00024w-6s
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 09:49:51 -0400
Received: by mail-wm1-x341.google.com with SMTP id c187so3267542wme.1
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2020 06:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=jwhEkemzIII9L6u5biTG+eNYmeN98eqT9fUUQ+VT1NU=;
 b=eIjn78ZRxmS5QVOAabVkIzkRsRfHn9T2OGUESA1SaUkCObGrzh/6VWMW1NZpL12dpG
 XJ78js96nt0kwLoDFSe+KcHt1At3U/FT9oXGq7BUMgqMZUBqvfyYPicLeT3aG4PxANfL
 OUsiAhqkT6Zgup0CjDh55Jl3fq0LwmKfkG5HMva4h9LXXU1pXWRdNWi7wvFrhLoulKhN
 jiJbYcx8sLcMB+QxBlDSXbqtMBE/qAzfLnuecRXUBKZsmKx7aHLZ0zwEucUlWz/3YSfR
 t4ClhSEpirMebqx2dyMR6jYyxJnJkg/xcvALdwMgFCfjrm8bXz37IQ8qEjJR3zEaCO68
 vMEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=jwhEkemzIII9L6u5biTG+eNYmeN98eqT9fUUQ+VT1NU=;
 b=rFf5/V3qi5xUuq65Ti0bGhvYvUu6DhLCsFQZlwwIsXPCfqP/pOG3WWnCQ8PoPsZ4rs
 pIQrYq9GMyrgCCc5JedgzwufEIGfYaG+U8CkH2DiYfwv+j8k1BZO5XFYnzjcqVRgyyjB
 4zCKBM0RBb9mcyzQTqnmygX6Feg3eV6ERVHYoAQV1CVsZTApfAMIgKlND0xo5SyfU7Bb
 ygbnzLo5ARB3vc9FoksdMyyse6ZdrqxeKTCzqWfYVUxAMer3mWiWpc32hrL0bZUH34E1
 2Ys1nKtfb+nCAYF6oTljWu0hWd2ujXXhb53ws2O6+VOH0wJ3hS67YgaTqebgePRlELDI
 bcRg==
X-Gm-Message-State: ANhLgQ32raOEw2vW8K7GXMqEhCE+qidp7kLfTJ2EdhxMe4TzUpPHv0s8
 FvSRZPfQz2LKqpF5MFOJ0BneXg==
X-Google-Smtp-Source: ADFU+vt6Hnp6WCdJJsi8/uRlhCcHkZeM1X9sCnHb3tTVh09+BIK3aXINvpUouTgmEqvkruAWNfCGbw==
X-Received: by 2002:a1c:48c1:: with SMTP id v184mr5760707wma.20.1585057789956; 
 Tue, 24 Mar 2020 06:49:49 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id k3sm4332067wmf.16.2020.03.24.06.49.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2020 06:49:49 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 0/2] hw/arm/xlnx-zynqmp.c: fix some error-handling code
Date: Tue, 24 Mar 2020 13:49:45 +0000
Message-Id: <20200324134947.15384-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series fixes some minor bugs in error-handling paths
in the xlnx-zynqmp device. The first is a memory leak spotted
by Coverity; the second is some missing error-propagation code
that I noticed while writing the first patch.

thanks
-- PMM

Peter Maydell (2):
  hw/arm/xlnx-zynqmp.c: Avoid memory leak in error-return path
  hw/arm/xlnx-zynqmp.c: Add missing error-propagation code

 hw/arm/xlnx-zynqmp.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

-- 
2.20.1


