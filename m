Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 805BCC76195
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 21:05:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D3452184E
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 21:05:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ftX9m6a7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D3452184E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoa48-0001if-Vy
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 17:05:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55229)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hoa3b-0008DX-4g
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 17:04:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hoa3V-0005Xq-Vp
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 17:04:46 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a]:45303)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hoa3V-0005DZ-HJ
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 17:04:41 -0400
Received: by mail-pl1-x62a.google.com with SMTP id y8so16176609plr.12
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2019 14:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=J6T0UaDoHOUvHQdeL0jaxXvQ3BPRU+bqa9M24JR56TM=;
 b=ftX9m6a7amh2lG2VgXdb5c50Tt1CJXPkB8mD6wJYX5ueB8jWKW6W/reQj4CuRd36E/
 JOQDs6uh2kMNVAffEJ1CUzS0KGs+LQIZALSi+zX2Tx/p8W2pW8tCiYfxKXmmb7CJdOF8
 56+tIHJi5FEUeSMxx597Cw8znF3Y4pNvcLljq2Z3Fpz4hkUfGplHq8xzUX35CgFJyYCC
 Q14IycFqtIt/KA94NiT66poSwOX0CPqnS/xiQx4AHme2u9n4PV0JaJG9KLJP/oGkGx7K
 HWQTIG5Ts1nLq0cOjGjZF0uUmakO2d6GiwMUuumaCIqfghoBIDtZ+cmSHTpTPKmmjU+S
 Jl5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=J6T0UaDoHOUvHQdeL0jaxXvQ3BPRU+bqa9M24JR56TM=;
 b=QGCa+fTlePJqZxW/jcKd67nLkBZZYPY+KgzRQMKVVPnjwlFJrgvpmSEntonSBQn2uk
 AR1nSewo2ZdV9GsKuCNRwH6zWZvhLmXzBb6tX8SbZUbT7O8Bwd/u7Bhgz9ewTZwC2TQY
 xbHY1rG8mEWJvLlp3GbKJJvIDRwKLmjSd2MriBSlDNwrjOFgpCkwUDm7VChKu7t7YUzK
 Mwohf8hyn2hFChaIHGZ0JKWPpgWdIaT2ab/zUInPMcXaD2vDycXmyZY/74CZLyll/2Ys
 3YPhgi6kvK2alg4J5KVcjCLkxrme6De2rMI/UY01QsHQ9LGlzWYulkFeL6+jCAwSJJSd
 4Mfg==
X-Gm-Message-State: APjAAAX87/56CtN7D6xnfKsmPBFqTEbYNuQIhTTnHdACCYGCzbzMMPno
 LTG+9I4j93ZapS4uQE09zIrpnFMwohc=
X-Google-Smtp-Source: APXvYqxzmsnaZw3ijVTn3rbk9JgwL58prLpvd6nWfDVpOBmEk9f80jTEp639L3yjIWg7+0lylTe9jw==
X-Received: by 2002:a17:902:a409:: with SMTP id
 p9mr59748890plq.218.1563570234647; 
 Fri, 19 Jul 2019 14:03:54 -0700 (PDT)
Received: from localhost.localdomain (97-126-117-207.tukw.qwest.net.
 [97.126.117.207])
 by smtp.gmail.com with ESMTPSA id i6sm32724751pgi.40.2019.07.19.14.03.53
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 19 Jul 2019 14:03:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 19 Jul 2019 14:03:24 -0700
Message-Id: <20190719210326.15466-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190719210326.15466-1-richard.henderson@linaro.org>
References: <20190719210326.15466-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::62a
Subject: [Qemu-devel] [PATCH for-4.2 22/24] target/arm: Update
 regime_is_user for EL2&0
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
Cc: peter.maydell@linaro.org, beata.michalska@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index f06e7bcd77..ae3ec9ea67 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8885,6 +8885,7 @@ static inline bool regime_is_user(CPUARMState *env, ARMMMUIdx mmu_idx)
 {
     switch (mmu_idx) {
     case ARMMMUIdx_SE0:
+    case ARMMMUIdx_EL20_0:
     case ARMMMUIdx_Stage1_E0:
     case ARMMMUIdx_MUser:
     case ARMMMUIdx_MSUser:
-- 
2.17.1


