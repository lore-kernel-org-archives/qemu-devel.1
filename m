Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A231C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 04:22:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8296206E6
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 04:22:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ENhlwBTP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8296206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh3rt-0005ey-42
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 00:22:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39526)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jh3ng-0004YU-Nu
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 00:17:48 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:50428)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jh3nf-0000kw-PO
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 00:17:48 -0400
Received: by mail-pj1-x1042.google.com with SMTP id jz3so2057014pjb.0
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2020 21:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=icu8Xm8+iq0LFQnztaWvz0M6KFnN5WeXG+dX4xSgCB0=;
 b=ENhlwBTPAICF2kxkscsFd9h5uKG0+SgIUId49kIUuFpcoHB9bONUg3CxMO1dsSB13F
 d2beu93TTZp5rDNJbnIFfRNo5WpId2QtnU1gtjkcSGreHEBDx03NNxhfpfpD7Aw9WUOM
 I5H3llmqRMkcLPI9DDBXaokQbBzQOXaceOEBGr0sp8jln2RB/AK16wSYZhX8giaYAO9T
 ujVEK7YDtkI+mUn1+RYmfsPCaaqCFY8wnEDEVPSi9/NPdBpxec6F//uKhssfBGPTyrRJ
 4B1lWzXixcWNuQmT2YcvKcERPaOYi/XDuBMTFXtTyveW8YbOnFFfHMh+0Aqneb/XZOPm
 bphQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=icu8Xm8+iq0LFQnztaWvz0M6KFnN5WeXG+dX4xSgCB0=;
 b=S/jhcwY9J5Bp9zFpcLPdTZJrPCMYT0GsuCgxpaEA0hYjKu9ABTb4Bm58lzkEOJDEwx
 5ujIUCFjZ3bUcyOwFKfN4wHhIcnTdbHCLMByQVmjYsE3UV/MYMi6cHdn5ttBrjX5EMdM
 00jaMJekeKmqQkmQNPLVjS8oQy1l8rHobCekApEPqrBjQgz8v29t1ks7/Z+3fjnm/ufG
 wQGztxXHEXV+12hILLtFbuh7iI1fE5COlaVL8h99veLyN8ETBWRrcwIbWcQTf2/0QffT
 6lAhYFoFjvTDW490w/JDW2SdY3Fp7BR0YS5e+yDg48Kl8EeML52zb/mUfDZa3bm6TN9k
 8P9w==
X-Gm-Message-State: AOAM533UsJhNcIX7ClPkakUHw/5/LOk0uDv1xD4IBwPR1WGEqNI9v8cW
 Nb37XBM8zwfX61crxL7VYluHiWLTIUw=
X-Google-Smtp-Source: ABdhPJx8ml2qgvN53/sQuOFKl3ajEDeK3rLf3hymF8RR20lvSJn253hHmsa1ufVJis1OY863HtLqsQ==
X-Received: by 2002:a17:902:7d8a:: with SMTP id
 a10mr7643821plm.116.1591330666007; 
 Thu, 04 Jun 2020 21:17:46 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id h15sm5440902pgl.12.2020.06.04.21.17.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2020 21:17:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 09/17] linux-user/aarch64: Implement PR_TAGGED_ADDR_ENABLE
Date: Thu,  4 Jun 2020 21:17:25 -0700
Message-Id: <20200605041733.415188-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200605041733.415188-1-richard.henderson@linaro.org>
References: <20200605041733.415188-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1042.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, steplong@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is the prctl bit that controls whether syscalls accept tagged
addresses.  See Documentation/arm64/tagged-address-abi.rst in the
linux kernel.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/aarch64/target_syscall.h |  4 ++++
 linux-user/syscall.c                | 23 +++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/linux-user/aarch64/target_syscall.h b/linux-user/aarch64/target_syscall.h
index 995e475c73..5fb0bf4a5d 100644
--- a/linux-user/aarch64/target_syscall.h
+++ b/linux-user/aarch64/target_syscall.h
@@ -29,4 +29,8 @@ struct target_pt_regs {
 # define TARGET_PR_PAC_APDBKEY   (1 << 3)
 # define TARGET_PR_PAC_APGAKEY   (1 << 4)
 
+#define TARGET_PR_SET_TAGGED_ADDR_CTRL 55
+#define TARGET_PR_GET_TAGGED_ADDR_CTRL 56
+# define TARGET_PR_TAGGED_ADDR_ENABLE  (1UL << 0)
+
 #endif /* AARCH64_TARGET_SYSCALL_H */
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index d190fb1122..e4da53c5b3 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -10460,6 +10460,29 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
                 }
             }
             return -TARGET_EINVAL;
+        case TARGET_PR_SET_TAGGED_ADDR_CTRL:
+            {
+                abi_ulong valid_mask = TARGET_PR_TAGGED_ADDR_ENABLE;
+
+                if ((arg2 & ~valid_mask) || arg3 || arg4 || arg5) {
+                    return -TARGET_EINVAL;
+                }
+                untagged_addr_mask = (arg2 & TARGET_PR_TAGGED_ADDR_ENABLE
+                                      ? MAKE_64BIT_MASK(0, 56) : -1);
+                return 0;
+            }
+        case TARGET_PR_GET_TAGGED_ADDR_CTRL:
+            {
+                abi_long ret = 0;
+
+                if (arg2 || arg3 || arg4 || arg5) {
+                    return -TARGET_EINVAL;
+                }
+                if (~untagged_addr_mask != 0) {
+                    ret |= TARGET_PR_TAGGED_ADDR_ENABLE;
+                }
+                return ret;
+            }
 #endif /* AARCH64 */
         case PR_GET_SECCOMP:
         case PR_SET_SECCOMP:
-- 
2.25.1


