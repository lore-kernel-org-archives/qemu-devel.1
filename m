Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 235C8C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 16:26:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E228020734
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 16:26:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RERi4p32"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E228020734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jih5T-00027J-49
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 12:26:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47096)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jih3x-0000LW-L3
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 12:25:21 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035]:35838)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jih3w-0000Ux-7d
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 12:25:21 -0400
Received: by mail-pj1-x1035.google.com with SMTP id i4so1631388pjd.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 09:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8qc6oDN4Zl6MEuNRZIzxS7SMNWB7rYpnfgGgJ3Ds2L8=;
 b=RERi4p32fnYEwO1aJGCC2a0euZ7IP0MZUdQPy4PRigx5sz+5KcV9fOV478Cv1hpSIZ
 5LKnUN1ehm+vBukvD7vYusKn27PGCwRT8WV81XMy5gT2HfQFJUuha0mJgt5GcRpoXIYC
 sxLkPpGhHGEi3iFJqmwTpxjoG1AgtytU/3j61Q+y3UtmkQuTrGSU2M9wC+F/wj4Z3xlo
 vCmTd/QLj+AsdsiUb4gaCRvwFzrQfO+tCfagxGUqcYfta3lQFMzZWqRDfuUsBm9sRo+n
 Wkf21mJhhYSf6212mXXR4qOVWxjefHP7ugVMapYTgbROgtQDNIxRQtv1It3WSaIgBwnQ
 XMfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8qc6oDN4Zl6MEuNRZIzxS7SMNWB7rYpnfgGgJ3Ds2L8=;
 b=O9DT1R3Om3xWGNjAhPGCaknoDEFSXHUaSu5L4pa6di6IeNlLJPNjt7q5Raa8Mx5lVL
 bln2GzQ8UcCeVnm7VlAl1NK+P2C8DPb3ztGcCgZPIug/z1+U35FGDbwQ5muCzYunw2Xw
 mOXAUF9aa1zyH/aogdZmXxrAoPQLzwU8QnBM9Ctb/AfZlsNP+9uzO5e1YtsBc9s2qxCH
 dzSa3K/FyZoh2t2n/qx8zL9cPuBAUy8MtWZBKWzo4j8VIQpw18SgljO5WeAZQVvttj7J
 rXAhcJx0kFvqKofJyGMIAzzQMHV2/grvb9CznpvQ41RLCUvRcvS9tRF/Ci9Re5BvsddP
 aQtg==
X-Gm-Message-State: AOAM533D9xA2ZbWEJ7gCmryIhUieVjHRXUH8g82SGHbepBQJp0jvK79+
 YkK6yh2a8jkIdDJ3B6LOZRo86exfqno=
X-Google-Smtp-Source: ABdhPJxlzjqKn7TyQ0aBfPRakieWIytmY/cpLep/rLZlDOshUH5rxuNS7ByOc66J0dOK9Ob8CdsTww==
X-Received: by 2002:a17:90a:266f:: with SMTP id
 l102mr6133308pje.190.1591719918369; 
 Tue, 09 Jun 2020 09:25:18 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id s188sm7580101pfb.118.2020.06.09.09.25.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 09:25:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 9/9] target/arm: Use a non-overlapping group for misc control
Date: Tue,  9 Jun 2020 09:25:04 -0700
Message-Id: <20200609162504.780080-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200609162504.780080-1-richard.henderson@linaro.org>
References: <20200609162504.780080-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The miscellaneous control instructions are mutually exclusive
within the t32 decode sub-group.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/t32.decode | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/t32.decode b/target/arm/t32.decode
index c63082fc9c..c21a988f97 100644
--- a/target/arm/t32.decode
+++ b/target/arm/t32.decode
@@ -312,13 +312,13 @@ CLZ              1111 1010 1011 ---- 1111 .... 1000 ....      @rdm
                  &cps
 
     # Miscellaneous control
-    {
+    [
       CLREX      1111 0011 1011 1111 1000 1111 0010 1111
       DSB        1111 0011 1011 1111 1000 1111 0100 ----
       DMB        1111 0011 1011 1111 1000 1111 0101 ----
       ISB        1111 0011 1011 1111 1000 1111 0110 ----
       SB         1111 0011 1011 1111 1000 1111 0111 0000
-    }
+    ]
 
     # Note that the v7m insn overlaps both the normal and banked insn.
     {
-- 
2.25.1


