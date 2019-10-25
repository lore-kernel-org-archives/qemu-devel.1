Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7714BCA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 07:26:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D2AD2070B
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 07:26:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A8Q48hIR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D2AD2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNtzO-0004qp-P5
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 03:26:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37067)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtN7-00088P-VI
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:46:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtN6-0003He-Sm
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:46:53 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:41067)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iNtN4-0003CS-PK
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:46:52 -0400
Received: by mail-wr1-x430.google.com with SMTP id p4so926877wrm.8
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 23:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FswrUErKtSfHmvlrq+iA8uPbY7A+O7qv3ayuySYET1I=;
 b=A8Q48hIRTduLXAC/SR7pJlUu9kKbd1BunOMPKOHdOHLRVO2BqzRtjzJQ6L0WhOnFg0
 E2FWdgJtQ505u0epkV+iKKpgd74TsKOZ5MbiKWWw/IumokDkhJq/3O5Va4bRchVpjZfK
 TknjY7DRmeXrREqMJ6qeVU3TU8ojujnX8A8MFfamVl2LinKbEgsJFDFKjgDhM7XCirWM
 OVRDNVA6nrMsHG1aJfTiwe5aDvBhfkgihsJq1bb3hklKNLWiZjXXlT9nR14O7SYBLiFs
 O5rL+XcFGemEsmcn6kjDjSGHk0VtrRi+QnIz3oAEWQgegtda+fsC79yK8KoOqwrl3ST/
 6vCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FswrUErKtSfHmvlrq+iA8uPbY7A+O7qv3ayuySYET1I=;
 b=pK9X67NxmDoCPjAJAVNpxt4e7kGbMAwDlGL1AScVs7nmzX3Q9RmQjYZ+Uhg0OdQn71
 A+FHl+/g6JoHYd0PNzAG+G0K/vKH1O7qb9cxf7AOYiSy9LCM5Sf7+GiXoYbqj6cIsVYK
 CJSBwOkqv7h5Rr0Bn5wVOCHXShsm3f9xMKQ/l4VZkJcAnEFmMiGarQStIWrSo0BwpHKF
 +MGCkWcTbAmD9nk1q7TfklcAg+7cwpHMsGBbv/92pjGAg36edBHw3L91ntk0clfPfkLJ
 hUWbXA4RlmskCXXrcffGotWyuECAxwO+MJgMRZyHETPoRLvtzz6npAr+ioYWKHRKfYUu
 WSUw==
X-Gm-Message-State: APjAAAXoN80vA+kmc5J/mm8JmI4Y1Q+BHBFO/UFpP7yjJcmLdKJPgTdb
 owiyjZVsZ55M4OpZ3Sfv944QZkViSIQ=
X-Google-Smtp-Source: APXvYqzB4g39gQZ9i2oVlQ7JlcsEIck2mtcwz8fKJCowktZKdGR/uPb2IuWaO7qSuLYIVKvsvdRHjA==
X-Received: by 2002:adf:ce87:: with SMTP id r7mr1281489wrn.307.1571986004859; 
 Thu, 24 Oct 2019 23:46:44 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q14sm1482743wre.27.2019.10.24.23.46.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 23:46:41 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 353681FFDB;
 Fri, 25 Oct 2019 07:37:20 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v2 69/73] include/exec: wrap cpu_ldst.h in CONFIG_TCG
Date: Fri, 25 Oct 2019 07:37:09 +0100
Message-Id: <20191025063713.23374-70-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191025063713.23374-1-alex.bennee@linaro.org>
References: <20191025063713.23374-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::430
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This gets around a build problem with --disable-tcg.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index eadcf29d0c4..d85e610e85b 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -22,7 +22,9 @@
 
 #include "cpu.h"
 #include "exec/tb-context.h"
+#ifdef CONFIG_TCG
 #include "exec/cpu_ldst.h"
+#endif
 #include "sysemu/cpus.h"
 
 /* allow to see translation results - the slowdown should be negligible, so we leave it */
-- 
2.20.1


