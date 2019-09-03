Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A22C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 16:28:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A07CE238CF
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 16:28:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rvpJf6PH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A07CE238CF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5Bf4-00054P-OU
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 12:28:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37482)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i5BNG-0001jk-Qc
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:09:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i5BNF-00045Z-SD
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:09:42 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535]:36825)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i5BNF-00044h-Mp
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:09:41 -0400
Received: by mail-pg1-x535.google.com with SMTP id l21so9404665pgm.3
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2019 09:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Ef+oVuDmN7mZPi1NSMRB+wuhc+5vj1zF9TuD8Y3RhI4=;
 b=rvpJf6PHOQ7lkacUnwsgAps9Gwuy/xZAfCx6yBUSMaxzNNxzr/9MT2VF1KvYYYSzWn
 nH4B0gH6TQQkD4LgxqXVaKOuEiO6gc9fIn4DZyKRawSYMk4Yapggbdm4n/hzY6UwQCkq
 Q6p16hTrUZwbv313vsO5nB4efTE2SRWDw3DHudauQnBCvvzXoDb/mQZ1gE8RzLn1BjmZ
 k50CKrnNv2Kf2MyofHqN0Di7UjUjUnmzegyr7DlzUK6wI8k8gfhP71/HwX2vZjz1vnsW
 aX3GZXQLeEsBvugVFuXz9FSWKseTDoLCEcVorCHY0U8CQJesySEjtLFP4mRR2+Ok1RH4
 W8xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Ef+oVuDmN7mZPi1NSMRB+wuhc+5vj1zF9TuD8Y3RhI4=;
 b=mZ54UYH8bE2yw6giL87zT3McgrYKKUiaMCtiaiHOAlwoWpu/7I25MhuEtY2SDm1W0Z
 ZIyzyIfDLolyu4DaTfxYwQHw8oG3Ypehxy1kgcUw987egbm2mdYFbPEuJiFy79VnMk6Y
 CcRhAJKLFJBKWI5VLj7ngDrbjTwi/NJ6qchU7+r0E9h647oKENGgjtKD9bdilhR7dBSh
 rGRmyOAsuUOb4RTJ5AvWk5jcQlke9Qa7ahI9Yc9QiKrnlXq7BZs/vycNAmD38JxR1b3Z
 s/9Pjb83rLX8Nx8UlJ1Bk2BWHS3PTBcxOfMxxmx3Qs/ENBe383QRg4q3A+xng6wTMwxO
 NNXg==
X-Gm-Message-State: APjAAAXcd8RnwIoBA8vUvNXpmV+Y9+am0ylr55gIoxwL1n58RXq9PADg
 qOB6/v93oByaigsqLCqr4iaE2nyvyJ8=
X-Google-Smtp-Source: APXvYqwv24H4/XBb/2cdODqHq0CwiB1D+FYDRs1hjxb/MVfIhJbNmigEBb2v40qPAJWjR+rj8aVs8Q==
X-Received: by 2002:a65:690b:: with SMTP id s11mr28720336pgq.10.1567526980373; 
 Tue, 03 Sep 2019 09:09:40 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id 127sm28089711pfy.56.2019.09.03.09.09.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2019 09:09:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  3 Sep 2019 09:08:55 -0700
Message-Id: <20190903160858.5296-34-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190903160858.5296-1-richard.henderson@linaro.org>
References: <20190903160858.5296-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::535
Subject: [Qemu-devel] [PATCH 33/36] hppa/tcg: Call probe_write() also for
 CONFIG_USER_ONLY
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

We now have a variant for CONFIG_USER_ONLY as well.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20190826075112.25637-7-david@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/op_helper.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/hppa/op_helper.c b/target/hppa/op_helper.c
index df0f1361ef..f0516e81f1 100644
--- a/target/hppa/op_helper.c
+++ b/target/hppa/op_helper.c
@@ -137,9 +137,7 @@ static void do_stby_e(CPUHPPAState *env, target_ulong addr, target_ureg val,
     default:
         /* Nothing is stored, but protection is checked and the
            cacheline is marked dirty.  */
-#ifndef CONFIG_USER_ONLY
         probe_write(env, addr, 0, cpu_mmu_index(env, 0), ra);
-#endif
         break;
     }
 }
-- 
2.17.1


