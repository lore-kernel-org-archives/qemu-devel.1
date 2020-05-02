Return-Path: <SRS0=t3yw=6Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85388C3A5A9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2020 22:54:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DAE9206B8
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2020 22:54:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nPHy5yfg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DAE9206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jV11e-0004cP-Fv
	for qemu-devel@archiver.kernel.org; Sat, 02 May 2020 18:54:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51672)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jV0sx-0003LC-5d
 for qemu-devel@nongnu.org; Sat, 02 May 2020 18:45:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jV0sw-0004qV-He
 for qemu-devel@nongnu.org; Sat, 02 May 2020 18:45:26 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:39404)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jV0sw-0004pl-2k
 for qemu-devel@nongnu.org; Sat, 02 May 2020 18:45:26 -0400
Received: by mail-pj1-x1042.google.com with SMTP id e6so1858710pjt.4
 for <qemu-devel@nongnu.org>; Sat, 02 May 2020 15:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Satlmvku/pHGor6xmZAkPC5FD5Q8goGXCeVbGvbx+tw=;
 b=nPHy5yfgpXDeN1+IM6iWDH2PgfvnaDOJFAbwk0MFJFhcUueKwuPRKjUQT5W1cYzR3d
 0lUaiCKwbxW2ExeOF/9qs+rjALx6OC7xcCAl78N5Hau9wkC6PjjKTg3FuV62iRsUmMeJ
 BWHEJo85iVCEakK7zngz70NX/YzDtX+PQiu1SzxId6zIpofao814ePS+RIC/5LMvrczT
 QkugSengw/EOT/9LF3kRvXWN2epJ7+EcSQi26ZzOOHqHJaFTy8x+GHYFvb/LTQQxsNLZ
 EtM2RZG/uDksS+SqTk+P7A0blWkrva9mkfUoSqdtomzNI4DFUF1DBKMF/Um5baj3h+cJ
 nSkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Satlmvku/pHGor6xmZAkPC5FD5Q8goGXCeVbGvbx+tw=;
 b=qOar6Rfl0VH2bCDqyOutkz2/HrmpzrU6Q/VDstX5tOGOKDtScf7pTqvwxE3krZFv6R
 CJGNdHcyxAzkFagkwxMtKHnRBG2dfNzV2VyFtsrsXdcQ4hrRdEhl7IYKl877Wd/J7TvH
 Dl07+Ffu+DJ/ztsv8hi/9o8k23iYIw9Q0Pr3nfYWbReKkBzS8U2HMcr+UabQMR096mYw
 TotZpjiOKqkCZ0NdbWNu4KdhjEBULtKrNJln92AJkKg3XddTwO/dXItK2WYgNMogSFL4
 IOFJjVeVQGEvKhkbNUcfljV1UyE5H9HX33ytqUn63rE55rVIfDrG6WqLWi4ZuuC2NFO9
 JUlg==
X-Gm-Message-State: AGi0PuYMoI6ZssjcoftPbAYq1Bo503SQCF0NiqbqBJR3hqmS7dP+E8GX
 McVsah0SBW2t+ccpp1PJEoMIU1xlwsc=
X-Google-Smtp-Source: APiQypIi+98gQRVvIkuF6JT+zSAkPcsYmzLMBAz9/4lUrcI9NQrr2ITkfJm/RQygpkqKvArDLsl8fw==
X-Received: by 2002:a17:902:8608:: with SMTP id
 f8mr11222779plo.110.1588459524389; 
 Sat, 02 May 2020 15:45:24 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id h5sm2956182pjv.4.2020.05.02.15.45.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 May 2020 15:45:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 13/15] target/arm: Clear tail in gvec_fmul_idx_*,
 gvec_fmla_idx_*
Date: Sat,  2 May 2020 15:45:01 -0700
Message-Id: <20200502224503.2282-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200502224503.2282-1-richard.henderson@linaro.org>
References: <20200502224503.2282-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1042.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::1042
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Must clear the tail for AdvSIMD when SVE is enabled.

Fixes: ca40a6e6e39
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/vec_helper.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/arm/vec_helper.c b/target/arm/vec_helper.c
index 6aa2ca0827..a483841add 100644
--- a/target/arm/vec_helper.c
+++ b/target/arm/vec_helper.c
@@ -747,6 +747,7 @@ void HELPER(NAME)(void *vd, void *vn, void *vm, void *stat, uint32_t desc) \
             d[i + j] = TYPE##_mul(n[i + j], mm, stat);                     \
         }                                                                  \
     }                                                                      \
+    clear_tail(d, oprsz, simd_maxsz(desc));                                \
 }
 
 DO_MUL_IDX(gvec_fmul_idx_h, float16, H2)
@@ -771,6 +772,7 @@ void HELPER(NAME)(void *vd, void *vn, void *vm, void *va,                  \
                                      mm, a[i + j], 0, stat);               \
         }                                                                  \
     }                                                                      \
+    clear_tail(d, oprsz, simd_maxsz(desc));                                \
 }
 
 DO_FMLA_IDX(gvec_fmla_idx_h, float16, H2)
-- 
2.20.1


