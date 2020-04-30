Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A6EC8300A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 11:54:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F59020757
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 11:54:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q/mZ1ygE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F59020757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU7lp-0007se-NR
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 07:54:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33658)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jU7jK-0002X7-Si
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:51:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jU7jJ-0000Ij-UC
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:51:50 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:34399)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jU7jJ-0000DL-GC
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:51:49 -0400
Received: by mail-wr1-x435.google.com with SMTP id j1so6545601wrt.1
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 04:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=LRt+lYSZxICWhOZXCGhxNCm7v8wo6m7PPTzVoY8b3a0=;
 b=Q/mZ1ygEfsJcFYtfk8Rb6ns5vCKF7xqY11Uq4q2uL23rmKeVi93hgQRZpQeM1kJ03U
 VIg2cO97UkM8PRijFuAeEZ7DCiCV1ral3XglmVvIGslWpEhdaoN8bP+vaPFjPyWnyiAP
 DB4dZaW7CnabmlytA4H3scZ8J6lLEl23yCZxa8klMGb6pMHyooOBB3bE86cp5aY/Nh9x
 aRVLXVj+MEl85c+fDaOvaknm3+CJg2Gdg0o8x+Cb3cGfS0nAwYTklJuFJBwVyW6qLiFI
 5497vV4NLQVBrhuMeku0n1/pdW3ebQuHKJQs9qK+NR5zWQrdf4ji1jWCcrykXQy1de/D
 Sqqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LRt+lYSZxICWhOZXCGhxNCm7v8wo6m7PPTzVoY8b3a0=;
 b=iqp4EqR/l4klRf9kNHA7gs+ATpqHuWjTWuc9pn8ONoZBRR1AW3aQHpJp6eFW7FHTIt
 M9tvpZmEZT46cqRkxP2ZWLY+9vnodr+irk0mUBU4Yziau9azYP4DFEhGff5TJ1fLKN3Z
 gNoIk3nogabdtT2EqYZI1qbPVPYDdpHogbreRdOgAMLzk2GsSnfYi1RB/5cZIXH5Fy+x
 gVeyk4SrWHV7g8Mz8DU02HfXQE3O7tv4JQZeT2lC2Y1PsDosFPmwybkS5T1H8pVRrR2Y
 QE9AmpsDpZcfpOyKgfibS8aPqAwMWbx2T6r4rxWCfGwE1RQ6giAqFyjHOe6bAU9mcupQ
 LZMg==
X-Gm-Message-State: AGi0PuYHOIgwXg8sZnI6YOFcw8WTgXNGdiXg+nWFUOpd4wIfv9nMh7Nh
 uJxwXsM0QH5sjDC1m2Lc2HMuSJd/N/DwsQ==
X-Google-Smtp-Source: APiQypLwT2k7CDrajjpNsSq5DNhq9eBeJ0FWmPubpK4BK4frrckAWJ+ORqq5b9dE2y3c83lOiZ/EFA==
X-Received: by 2002:a5d:4cc2:: with SMTP id c2mr3643097wrt.130.1588247507744; 
 Thu, 30 Apr 2020 04:51:47 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id j22sm491518wre.84.2020.04.30.04.51.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 04:51:47 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/31] nrf51: Fix last GPIO CNF address
Date: Thu, 30 Apr 2020 12:51:14 +0100
Message-Id: <20200430115142.13430-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430115142.13430-1-peter.maydell@linaro.org>
References: <20200430115142.13430-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::435
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

From: Cameron Esfahani <dirty@apple.com>

NRF51_GPIO_REG_CNF_END doesn't actually refer to the start of the last
valid CNF register: it's referring to the last byte of the last valid
CNF register.

This hasn't been a problem up to now, as current implementation in
memory.c turns an unaligned 4-byte read from 0x77f to a single byte read
and the qtest only looks at the least-significant byte of the register.

But when running with patches which fix unaligned accesses in memory.c,
the qtest breaks.

Considering NRF51 doesn't support unaligned accesses, the simplest fix
is to actually set NRF51_GPIO_REG_CNF_END to the start of the last valid
CNF register: 0x77c.

Now, qtests work with or without the unaligned access patches.

Reviewed-by: Cédric Le Goater <clg@kaod.org>
Tested-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Cameron Esfahani <dirty@apple.com>
Message-id: 51b427f06838622da783d38ba56e3630d6d85c60.1586925392.git.dirty@apple.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/gpio/nrf51_gpio.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/gpio/nrf51_gpio.h b/include/hw/gpio/nrf51_gpio.h
index 337ee534bbc..1d62bbc9285 100644
--- a/include/hw/gpio/nrf51_gpio.h
+++ b/include/hw/gpio/nrf51_gpio.h
@@ -42,7 +42,7 @@
 #define NRF51_GPIO_REG_DIRSET       0x518
 #define NRF51_GPIO_REG_DIRCLR       0x51C
 #define NRF51_GPIO_REG_CNF_START    0x700
-#define NRF51_GPIO_REG_CNF_END      0x77F
+#define NRF51_GPIO_REG_CNF_END      0x77C
 
 #define NRF51_GPIO_PULLDOWN 1
 #define NRF51_GPIO_PULLUP 3
-- 
2.20.1


