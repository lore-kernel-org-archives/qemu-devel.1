Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D754BC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 04:21:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2A65206E6
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 04:21:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A0tjNfKG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2A65206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh3rh-0005F5-Qi
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 00:21:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39486)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jh3nd-0004Nt-4h
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 00:17:45 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:38083)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jh3nc-0000k4-BQ
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 00:17:44 -0400
Received: by mail-pj1-x1042.google.com with SMTP id d6so2180032pjs.3
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2020 21:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mHdkZW2BtXgCCzUvavDtufJgojf9AzZZHlwJyJIkodU=;
 b=A0tjNfKG6o69Lfe9DGoQRD5xlUXCVE3IYgfK4e7eSVqCxRoJeP+FDG4Ufc9QSEhVVN
 BF/fnDWIPQEWhfJL9VG1bGcmgvAPP0TQw77ZOtbFm+wtuv7aXUZBO6lj57lqJYT5QWCd
 AXEk+pKZC7KjL+U2FUX2+94bO8y0VSwCJOBbDmBseywpQpO3XiZ8oZdvWXiWB6eyaGwB
 QcFjTHP1k10npcJwNwG/iwZC+LKii0S0hw5JzdbJA868koVF6GHvpIjMnngR02Hvqo0m
 wXZnY3XLVzepBIpLclJvUWZFB1FtB4z8cJa0lrx9UxKHPCcgbBBPjEtK9Wq1jV4vYJkQ
 Weug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mHdkZW2BtXgCCzUvavDtufJgojf9AzZZHlwJyJIkodU=;
 b=WEEcpnByuKF7RGAGU3ypbZc1KAyHCTFBulrvhqR1bb/LEGJAbV3eS/XAULd9Bkgczm
 C+d1hx6MIfBesu+92qFj3QC5eUb6oTjRv4Qg0vNeOeSPsETACvMW3KLvmW06ttRlh8k4
 UIIKkIxvRdMRO3WYUK80s6B5BqMM6jcrqKMszsbC1exaNJKjkDlldQKjR+Rq5MHoc21P
 /xKTgUn+suQSNjpnwPKsUQaFWjFge+76iEOBd7g9vEhphZ4tLMsfvC3vSH5vtCR3muuk
 v/y7b6jYCQqesLVNKkeZDt0GPupjEOo5VzPL8sXoXzIROnF7CGVTiuu5w05CwV/wor6B
 3kbg==
X-Gm-Message-State: AOAM5338i/08oNkW6F4HPjojcSPEJYOUJ5VsUxzbvUXafay5MhHcvb/L
 n1leRAmw8F3rmmEU9J3hLoYORem888A=
X-Google-Smtp-Source: ABdhPJwctokSJwMErfDPEYCtZO4AWVtcyE3yWYzmPyIPu/maWAYpnSJICjtLbuzfwB1NE1SFh5yFMg==
X-Received: by 2002:a17:90b:605:: with SMTP id
 gb5mr699334pjb.167.1591330662669; 
 Thu, 04 Jun 2020 21:17:42 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id h15sm5440902pgl.12.2020.06.04.21.17.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2020 21:17:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 06/17] linux-user: Do not use guest_addr_valid for h2g_valid
Date: Thu,  4 Jun 2020 21:17:22 -0700
Message-Id: <20200605041733.415188-7-richard.henderson@linaro.org>
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

This is the only use of guest_addr_valid that does not begin
with a guest address, but a host address being transformed to
a guest address.

We will shortly adjust guest_addr_valid to handle guest memory
tags, and the host address should not be subjected to that.

Move h2g_valid adjacent to the other h2g macros.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu_ldst.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
index c14a48f65e..3930362e20 100644
--- a/include/exec/cpu_ldst.h
+++ b/include/exec/cpu_ldst.h
@@ -77,15 +77,16 @@ typedef uint64_t abi_ptr;
 #else
 #define guest_addr_valid(x) ((x) <= GUEST_ADDR_MAX)
 #endif
-#define h2g_valid(x) guest_addr_valid((unsigned long)(x) - guest_base)
 
 static inline int guest_range_valid(unsigned long start, unsigned long len)
 {
     return len - 1 <= GUEST_ADDR_MAX && start <= GUEST_ADDR_MAX - len + 1;
 }
 
+#define h2g_valid(x)  ((uintptr_t)(x) - guest_base <= GUEST_ADDR_MAX)
+
 #define h2g_nocheck(x) ({ \
-    unsigned long __ret = (unsigned long)(x) - guest_base; \
+    uintptr_t __ret = (uintptr_t)(x) - guest_base; \
     (abi_ptr)__ret; \
 })
 
-- 
2.25.1


