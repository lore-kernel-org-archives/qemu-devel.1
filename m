Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F764C33CAF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 00:49:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03AAB20728
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 00:49:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PupseyDC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03AAB20728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isFp0-0004i2-6q
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 19:49:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38426)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1isFmT-0001vi-5g
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 19:46:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1isFmS-00061O-3a
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 19:46:33 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:44814)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1isFmR-00060n-V0
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 19:46:32 -0500
Received: by mail-pg1-x541.google.com with SMTP id x7so10766758pgl.11
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2020 16:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=a5HiIt6oABJ3BG1J/pu1JEnVUU32r0DSl4PyBFcvPG8=;
 b=PupseyDCsu0UZJWJT7y4Vyn1WDbUOInc55gtEHuKx5+8s2EC1pF4KeFSa/mPx9H5IZ
 wXnwTtvE8fHjwoHdf7J0Mv/xv3dyIoFdzDzIYpIpERvxdzv8XCB+IGk/rlFjbdLPdViz
 fnQqpHCs7i0gOVMNjcnl3eX9BSqJoZSY5B4V+A7O/yTuZGb7X7VvHjUBK5zoBF/YZTi/
 Vayl+lOkFUZtJAVaSYY/+TxeK4xeqD/NSDDTpLmSONirwepxk4S6Gl8TR4B0EnpgJyrX
 H5/S6SCQKftVBlCtg7OHfdJCJSvN6T2i58I88sMCyNY1ia5cEV7OfQt9RZNuEZlpXl//
 rbmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=a5HiIt6oABJ3BG1J/pu1JEnVUU32r0DSl4PyBFcvPG8=;
 b=g7eXF+raKUDJ8XPE0hv4aKJAfNQRpykMVIoOdR+XpkRg6iK3fYZJu2e2mdFzBBH77O
 t9d9aDcYltCSiZeZdOpjy41vd3ZzezgYnLqojWTpXlOpNMuPtAhIwkypL1QM/4Kepb5N
 vfBFxtPsiUPj4UTj4b2kp3+yTCkZgVXmDthIV4ZEk/lEOca9QGrySaaVdozD07Rsav3t
 qVpbMKeijtadZHDUNP1Clygw/sVKisPLdWnpLbieHRrQgQckKVvxpGoCaUgAsilzBQy6
 S7YW4CqnJEzwlbW2VgL7qo0s9cqLl1S7kwr9W8jiM1n7oYobyluSd9QmK5kucKZPRvsD
 tdoQ==
X-Gm-Message-State: APjAAAWOfvzE192ycyIEStnfzlErUi+VbYJ0hySJM4qgaMjNEgkFn/w1
 CwBSDqUk+DGYxUBcKl8qVGBIFzi73Gs=
X-Google-Smtp-Source: APXvYqx1jvQfKqUz48aRGpDAMRxNuVRcDMvbZZJ16Rg8lRiYUh+bh+3HEFnJoTOS8n8ZHLLoXU67qA==
X-Received: by 2002:a63:111e:: with SMTP id g30mr43679271pgl.251.1579221990703; 
 Thu, 16 Jan 2020 16:46:30 -0800 (PST)
Received: from localhost.localdomain (rrcs-66-91-136-155.west.biz.rr.com.
 [66.91.136.155])
 by smtp.gmail.com with ESMTPSA id 81sm27663582pfx.30.2020.01.16.16.46.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2020 16:46:30 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/2] target/arm: Return correct IL bit in
 merge_syn_data_abort
Date: Thu, 16 Jan 2020 14:46:17 -1000
Message-Id: <20200117004618.2742-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200117004618.2742-1-richard.henderson@linaro.org>
References: <20200117004618.2742-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org, qemu-stable@nongnu.org,
 jeff.kubascik@dornerworks.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jeff Kubascik <jeff.kubascik@dornerworks.com>

The IL bit is set for 32-bit instructions, thus passing false
with the is_16bit parameter to syn_data_abort_with_iss() makes
a syn mask that always has the IL bit set.

Pass is_16bit as true to make the initial syn mask have IL=0,
so that the final IL value comes from or'ing template_syn.

Cc: qemu-stable@nongnu.org
Fixes: aaa1f954d4ca ("target-arm: A64: Create Instruction Syndromes for Data Aborts")
Signed-off-by: Jeff Kubascik <jeff.kubascik@dornerworks.com>
[rth: Extracted this as a self-contained bug fix from a larger patch]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tlb_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/tlb_helper.c b/target/arm/tlb_helper.c
index 5feb312941..e63f8bda29 100644
--- a/target/arm/tlb_helper.c
+++ b/target/arm/tlb_helper.c
@@ -44,7 +44,7 @@ static inline uint32_t merge_syn_data_abort(uint32_t template_syn,
         syn = syn_data_abort_with_iss(same_el,
                                       0, 0, 0, 0, 0,
                                       ea, 0, s1ptw, is_write, fsc,
-                                      false);
+                                      true);
         /* Merge the runtime syndrome with the template syndrome.  */
         syn |= template_syn;
     }
-- 
2.20.1


