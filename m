Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C33C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 16:19:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8505023711
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 16:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PDNKcL9Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8505023711
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5BWc-0002Av-Q2
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 12:19:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37177)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i5BMr-00016G-Vd
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:09:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i5BMq-0003j2-Lp
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:09:17 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d]:41629)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i5BMp-0003hq-Fc
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:09:16 -0400
Received: by mail-pg1-x52d.google.com with SMTP id x15so9393537pgg.8
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2019 09:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=fzo/4dCtD9XDozJ1PtMm7FQw18sTkDVFqteJc2ZqQUI=;
 b=PDNKcL9QMs0N1Zjuav+LT+t/d4gvbLwlUefrlpigEapZkn9iuFsM/rsmwsCHxvLeVp
 9nKZ+UMFobhWdaTkXdDDAx7T1cvUGVifiP4SgWns8BX6NyfPqc8OQ6XrU3GxNmJlr1pr
 fnKGKX3ryh+Lqc+YUpg8+yydds9h6rL+gijC9vZkKWtMk0paspVKacQSEbaabcvc0wPy
 pEJwFYgkEouJBZv1MyZJLu6ia6cX3zCxnqkCG468fYhrHrr7oDLLv54Q/JYjwuEIbMnG
 eWwYEQaXR8b63jNyOi1gka+vctIua3gKNc63SfbTwBRKmHJWWtM5OJx2a/uzv4JyLXQo
 j0MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=fzo/4dCtD9XDozJ1PtMm7FQw18sTkDVFqteJc2ZqQUI=;
 b=TMDbp3Ge+/+9WMhvEbCNAk4dkuld6995OgfjfQ2kbSyV8wiHqrQXkmhaAdzk6N0h29
 crc5kqJ4WExhIYTB13QKoM+rGfkbpvBlZsvg/khCyzguC+LbIQKNTqFDuhXMptRrkZ5M
 zTGe7vV4q6gqYz0JLM3F3+ZGnXdPaifw95HJHusNwHxABAw1P81eKjqM2Eb18ic2gYmV
 8fahoY6jbXRg/FNJS1unXNpRBqdZbBQ1fvzdbB/QdTFpZwOFAtF1B77+ix7LkBqq7TGk
 GYM+d0MSUWqwR2Pu2lELP3C/BMajpxaaB5GKX3SeOpLT+MoCqXHP9zcVpqBozpaX5wpz
 /9KA==
X-Gm-Message-State: APjAAAUzprbWEfubkkLpxNjfiFbpU4YLc0e99PiIhZFcZ2XZbxAUW9iR
 ir8F5duwUuP3BkQ/t4xIo3thXyYYvdA=
X-Google-Smtp-Source: APXvYqwc+RusrwFns0zy5JxXIIFTdq2iq6vgrVUGp077n5OCCQ7O4hJjGgP23k24timwTqQuiMLcIQ==
X-Received: by 2002:a17:90a:bb92:: with SMTP id v18mr59534pjr.78.1567526954161; 
 Tue, 03 Sep 2019 09:09:14 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id 127sm28089711pfy.56.2019.09.03.09.09.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2019 09:09:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  3 Sep 2019 09:08:33 -0700
Message-Id: <20190903160858.5296-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190903160858.5296-1-richard.henderson@linaro.org>
References: <20190903160858.5296-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::52d
Subject: [Qemu-devel] [PATCH 11/36] hw/s390x: Hard code size with
 MO_{8|16|32|64}
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
Cc: peter.maydell@linaro.org, Tony Nguyen <tony.nguyen@bt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Tony Nguyen <tony.nguyen@bt.com>

Temporarily no-op size_memop was introduced to aid the conversion of
memory_region_dispatch_{read|write} operand "unsigned size" into
"MemOp op".

Now size_memop is implemented, again hard coded size but with
MO_{8|16|32|64}. This is more expressive and avoids size_memop calls.

Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Message-Id: <76dc97273a8eb5e10170ffc16526863df808f487.1566466906.git.tony.nguyen@bt.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/s390x/s390-pci-inst.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index 0c958fc391..0e92a372ca 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -782,8 +782,7 @@ int pcistb_service_call(S390CPU *cpu, uint8_t r1, uint8_t r3, uint64_t gaddr,
     for (i = 0; i < len / 8; i++) {
         result = memory_region_dispatch_write(mr, offset + i * 8,
                                               ldq_p(buffer + i * 8),
-                                              size_memop(8),
-                                              MEMTXATTRS_UNSPECIFIED);
+                                              MO_64, MEMTXATTRS_UNSPECIFIED);
         if (result != MEMTX_OK) {
             s390_program_interrupt(env, PGM_OPERAND, 6, ra);
             return 0;
-- 
2.17.1


