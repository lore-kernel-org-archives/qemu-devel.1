Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F75C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 16:49:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50E9E22CED
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 16:49:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qZ0vUAel"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50E9E22CED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5C07-0005CK-SO
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 12:49:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37504)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i5BNI-0001m2-Bd
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:09:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i5BNH-000479-83
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:09:44 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b]:35448)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i5BNH-00046F-2T
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:09:43 -0400
Received: by mail-pf1-x42b.google.com with SMTP id 205so8619790pfw.2
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2019 09:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=rllUpWe62ZsfU+30fAApU6qKY3XDd69Sp3kh5Sw9sOs=;
 b=qZ0vUAelF0LSqC6ZaXDi4av155T2gRPVH15s3jA40kwgJLa6rzAl3dv4rT+BbU+/O4
 Un+h8pynsM41v6I4TFGwTU8vU+zfSOEHw107k0jorvZh5GjQfcsNCXF7wFFz/84aqNXS
 yW76dsqeP/XIihETGnaQRex5aZzTKCt0Hy/k58YizaxaeTHn95vo/jzRamTXXALG5VHo
 tGE2eYy3ABKIEPCCcm3ArMmQx01rXbT78n/uf8wNBfjzUKhlWn89+5bCs+wVNbeHZqOf
 nPTmtOGN5Pi00PT8u6Slj47VVAdTspeInA6i+exD+JGEgLaS9tGypj8q92oXPgGyMJeZ
 XKow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=rllUpWe62ZsfU+30fAApU6qKY3XDd69Sp3kh5Sw9sOs=;
 b=AyMk2wTJaC85mQVPZZw1ti0Tag1YL9pXZNIILnkDfJE/x9EZ7oFQThtoY2Cw7dZoiL
 VdnSkq3Wbat5fjumD64xYkj0IAtGmDpra8dL6KFJUkuUky5/vKSzJGJnyPx2W+iJwHUY
 moU3K6rqQOyfxz5OXwNIB11coB0/MEsQMUj0ZPMJv/VlG9HlmFJgnPptoXGcalHcMqFe
 VBVAQNVfITiwmW3za193VBTRDdZ+nLYE+7NTGeuAWXIX1PNP6206nZ2NeEMFHPeOmezi
 iARFKJRvPn4QiUXm9izjHrbnwpKuzqzgZH3hY/bUpz40O+D2KLuWWR+PiJi1yB/7aaNi
 JM/g==
X-Gm-Message-State: APjAAAW+KVhF5PKtfgQJy+vmQ2FMJoq8Qfnz+VvTr/7NmVOhnXKjw9GF
 K7wpDuPk75e4R6oMu7D2Irl0zfKg5O8=
X-Google-Smtp-Source: APXvYqyCvWzXnNgPS5bTAtulEqc0A+SdUsuo4b3IydeF9baCoFmjiEI6S0G3ekPUSpsgmM45btIxRQ==
X-Received: by 2002:a63:4846:: with SMTP id x6mr19144731pgk.332.1567526981618; 
 Tue, 03 Sep 2019 09:09:41 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id 127sm28089711pfy.56.2019.09.03.09.09.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2019 09:09:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  3 Sep 2019 09:08:56 -0700
Message-Id: <20190903160858.5296-35-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190903160858.5296-1-richard.henderson@linaro.org>
References: <20190903160858.5296-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::42b
Subject: [Qemu-devel] [PATCH 34/36] s390x/tcg: Pass a size to probe_write()
 in do_csst()
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
Cc: peter.maydell@linaro.org, David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: David Hildenbrand <david@redhat.com>

... and also call it for CONFIG_USER_ONLY. This function probably will
also need some refactoring in regards to probing, however, we'll have to
come back to that later, once cleaning up the other mem helpers.

The alignment check always makes sure that the write access falls into a
single page.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20190826075112.25637-8-david@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/mem_helper.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index fdff60ce5d..29fcce426e 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -1443,9 +1443,7 @@ static uint32_t do_csst(CPUS390XState *env, uint32_t r3, uint64_t a1,
     }
 
     /* Sanity check writability of the store address.  */
-#ifndef CONFIG_USER_ONLY
-    probe_write(env, a2, 0, mem_idx, ra);
-#endif
+    probe_write(env, a2, 1 << sc, mem_idx, ra);
 
     /*
      * Note that the compare-and-swap is atomic, and the store is atomic,
-- 
2.17.1


