Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE8EC35646
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:38:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB6AB208C4
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:38:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sece08w/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB6AB208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j58Vk-0004rH-6V
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 08:38:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57092)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j582m-0008DM-Me
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:08:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j582l-0003kc-Ks
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:08:36 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:41737)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j582l-0003jC-EN
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:08:35 -0500
Received: by mail-wr1-x42e.google.com with SMTP id c9so1987403wrw.8
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 05:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=xSiTZ3bbGCGd/uM9CAsKu9wKQwmjm99/Hgqy9CM1+t4=;
 b=sece08w/bOhVfcwMb3/YlVpUDibrQtTEizvqPiiDMaUO1UlQ0dzdCalD7ia4F/d+GR
 daaD/7FvqHJyQ704yQwPEuwcY27faVOKtxzSwbkcVaXP5W6uh4niGiErRWMwnBID5jJJ
 OZqyo0xkRIL1VJy6+7NgtuhXbbpH9UJlMeg6FCPIjUiP0W0+LDbIAKj0FPwtH13zvoBg
 c3tfmMiXybj7vIBAhCQg5gAutxVHrUQcKbWdcxMARn3QFIk1rEWWIFQj1Rg3pheercTT
 09vAjRzW/k3j8z53fmSH3FWJOBZrK3GsOu6xliRIPX3xulpezohBsilitV6hZ5Z5Zodv
 WBeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xSiTZ3bbGCGd/uM9CAsKu9wKQwmjm99/Hgqy9CM1+t4=;
 b=qEHTZEviocLOcvifWtBqUjpJ946MqdTBwAtOjgfhTus44EDW3eYA2ruO99BBFMq3+0
 Ch+JnwQMHlIRA8HZIxnBFDM49GO080m/DeGKQaliZlLg+tosgi42nR5VlkCafHwOoVas
 39SaXTD7CH7M6g9sNIfVvIZzxit5lTQ52r+Tj0uJ/diHmv6ei0TrmCNJGtMDXzWNvtyM
 gxkvxHEbQAuOD3Msbj/HzYZLgQosSx1DLyCeDSy6/mwb6nAQt+B/SrD+eSrCTbh0v/Nm
 3xqsCdPgpEVTNoRfPHTQnUM5ZooJEiNQn3pk/5NSXVWXxNPXwiX6AXDvOLzvBq9Fl9qH
 DZSg==
X-Gm-Message-State: APjAAAUHKMLK7pp7TCKpsnKbpTk83hJvnCvNr6xLFL7LSA6dUx8WpeDP
 VrphToUDFGlPQ49GomAGwbs0T+91QL0iyg==
X-Google-Smtp-Source: APXvYqw2tMfTk1f5N4RvatMFZ4VgSrxGSPD1F0FNqzRRLgOsT2j4E/w+ppMtZ3ymsAlnyYusvN98ZQ==
X-Received: by 2002:adf:b605:: with SMTP id f5mr46479361wre.383.1582290514004; 
 Fri, 21 Feb 2020 05:08:34 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id p15sm3598892wma.40.2020.02.21.05.08.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2020 05:08:33 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 42/52] xilinx_spips: Correct the number of dummy cycles for the
 FAST_READ_4 cmd
Date: Fri, 21 Feb 2020 13:07:30 +0000
Message-Id: <20200221130740.7583-43-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200221130740.7583-1-peter.maydell@linaro.org>
References: <20200221130740.7583-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42e
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

From: Francisco Iglesias <francisco.iglesias@xilinx.com>

Correct the number of dummy cycles required by the FAST_READ_4 command (to
be eight, one dummy byte).

Fixes: ef06ca3946 ("xilinx_spips: Add support for RX discard and RX drain")
Suggested-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Francisco Iglesias <frasse.iglesias@gmail.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Message-id: 20200218113350.6090-1-frasse.iglesias@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/ssi/xilinx_spips.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
index 6c9ef597796..c57850a5051 100644
--- a/hw/ssi/xilinx_spips.c
+++ b/hw/ssi/xilinx_spips.c
@@ -576,11 +576,11 @@ static int xilinx_spips_num_dummies(XilinxQSPIPS *qs, uint8_t command)
     case FAST_READ:
     case DOR:
     case QOR:
+    case FAST_READ_4:
     case DOR_4:
     case QOR_4:
         return 1;
     case DIOR:
-    case FAST_READ_4:
     case DIOR_4:
         return 2;
     case QIOR:
-- 
2.20.1


