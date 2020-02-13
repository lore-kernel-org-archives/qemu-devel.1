Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A71CEC352A3
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 23:02:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7397F20675
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 23:02:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BE+uE/Qz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7397F20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2NVB-0004nb-Mi
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 18:02:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55409)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j2NTW-0002SW-Mk
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 18:00:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j2NTV-0002WN-Ja
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 18:00:50 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:51791)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j2NTV-0002U1-BQ
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 18:00:49 -0500
Received: by mail-wm1-x331.google.com with SMTP id t23so8082417wmi.1
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 15:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XyWMlP9lSq+SHEuFrUXA9vT/NjMQXbVZXYjMIeFpuFk=;
 b=BE+uE/QzmzIMit3y/U2+UjFQso1IN3d6c1aebqTkkHEK4r8hOBziUWkSJUXO2H9ANH
 125hHcbkVqXkaxGXTuVgT+Xj/K6lj7Dlokr/BXAABM/AZiDZg0sGZXyH1PWJhId7ZoE9
 FNXpmok+GI6Mt2ikFlVpdDioYE/4Mm2N+dOilRBw9s/Zo+aNl/ut6FBETUr+WQEvPtuy
 XCYl+RM2UQbpEAmxaPbTeQ5mhbqCGivIM+QH2P3E+t3jVvk1S2baQ1ZR91aR6NE8UOsA
 cpUMKgitoW4/K0r8jzD7Gh6NFmh8jA9KsqFk7NIh55JLqCxkQ3DBf9YoppOZ7LU5VL4w
 6TeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XyWMlP9lSq+SHEuFrUXA9vT/NjMQXbVZXYjMIeFpuFk=;
 b=iCkmSc/VmKkdaMfmmmk4q54L41tGn3oS703BDUe3mLl2fTm6acm5ng3XZEIzK5qQI0
 juuZQBTOCWOpqX6m0oN5tBVnh0+4g1NxDqsGa4CSIw9MT6aE12vG30ZrMI4JB0w1Nw4X
 eyhVOd3EZY3GVV3hjBBh3n9sIj6T819Ll7kmoojmMVRfpjFcixgxGffAb9vCI9Dzxqe4
 0Tv5CcPN+ocqWKfPALOgeV3ewDz3fvW9tQUn4j/p8aFOT3c6X5rZmB2eZIrG7p1oR/1s
 UV41elOTpkadLpOxCaYH7twHIMF5r8cP6BmDk966cZZl0lhbZvXLQSS2QpeSZM0Kl1q2
 8PRA==
X-Gm-Message-State: APjAAAUXbFd+15fIIn35O5PZw7NItY8U9q0xpPiFKZLUDvhYJ0LxzASq
 up3GV0SBNErjKJ6zTfNEOO+qGA==
X-Google-Smtp-Source: APXvYqxs9bpll6gQGd3PXZ6P9mqHQhmANao0vOGL1LIvg4DFQVm+k+hPh8ybusWgtw5FS66DT1kmXw==
X-Received: by 2002:a1c:9e89:: with SMTP id h131mr313898wme.161.1581634848250; 
 Thu, 13 Feb 2020 15:00:48 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id e17sm4722373wrn.62.2020.02.13.15.00.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 15:00:45 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 36C4F1FFA9;
 Thu, 13 Feb 2020 22:51:11 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v2 18/19] tests/tcg: fix typo in configure.sh test for v8.3
Date: Thu, 13 Feb 2020 22:51:08 +0000
Message-Id: <20200213225109.13120-19-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200213225109.13120-1-alex.bennee@linaro.org>
References: <20200213225109.13120-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::331
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
Cc: fam@euphon.net, berrange@redhat.com, robert.foley@linaro.org,
 pbonzini@redhat.com, stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org, robhenry@microsoft.com,
 marcandre.lureau@redhat.com, aaron@os.amperecomputing.com, cota@braap.org,
 stefanha@redhat.com, kuhn.chenqun@huawei.com, peter.puhov@linaro.org,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Although most people use the docker images this can trip up on
developer systems with actual valid cross-compilers!

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/configure.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/tcg/configure.sh b/tests/tcg/configure.sh
index 9eb6ba3b7ea..eaaaff6233a 100755
--- a/tests/tcg/configure.sh
+++ b/tests/tcg/configure.sh
@@ -228,7 +228,7 @@ for target in $target_list; do
                 echo "CROSS_CC_HAS_SVE=y" >> $config_target_mak
             fi
             if do_compiler "$target_compiler" $target_compiler_cflags \
-               -march=-march=armv8.3-a -o $TMPE $TMPC; then
+               -march=armv8.3-a -o $TMPE $TMPC; then
                 echo "CROSS_CC_HAS_ARMV8_3=y" >> $config_target_mak
             fi
         ;;
-- 
2.20.1


