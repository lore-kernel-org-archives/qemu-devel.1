Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C779C00523
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 04:13:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA2C12070A
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 04:13:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qqO5zo4y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA2C12070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip2j3-0001IH-TE
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 23:13:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49653)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ip2Iv-0004kz-Re
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:46:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ip2Iu-0003ap-KC
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:46:45 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f]:33708)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ip2Iu-0003aF-EF
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 22:46:44 -0500
Received: by mail-pl1-x62f.google.com with SMTP id ay11so524398plb.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 19:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BxIVssEy5SXP5eel2z2kxdVW9xUhLnYxR5gpT8BmfJc=;
 b=qqO5zo4y8O/VCitdunyfWefgyXHeRrq9Qez53lzSCXz0KLGnrvTmB62+hnsQiCmucB
 EGRr/aCDt6Gu0qvg1hJBVzvnHfOxJVr4adQOtBZfl0mzg6m7xchg2ggouUyL2TSIrftw
 fq4ibd1o7qSMgt9E1GTG983cWL9ghix+y5ibOlpqqDfoOWxOTnMrd8WdR0ReqBdVOaxh
 BEb5xpf4QieMlaUj04elFd+ZAteRjzRB4FzaJQQLVzk5KvrBGC9pNFFuJ+k/O27h/BU8
 hRsPV9yQLVf1HzQFpXDuwDjf99qksrxuQjkfRPOOk6Wtcdw9x5djLjmBAOmAApz+LLgP
 KJJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BxIVssEy5SXP5eel2z2kxdVW9xUhLnYxR5gpT8BmfJc=;
 b=KoGNCizGYPqXOLZOVzbFPT+lHUgnKg3SN7KKjTGlNUwwRXz0EmlKhsNGFGWd7ci6nG
 2yynYNU4+4vJiEoMywjxey4O0wrjd7uyBPSwUNuxid/1Spw4TrVU4/8cp3DZxwFlobbq
 354FQc1Sd2RFjjIgyo8t8TrZxLmvXzCtDodowJ0KGhg+ZeRMgIqTSCbmJOvEKEGOq3nf
 I0wuZweBKnj+hDr3Sy9Ff5s66WzHVhR3ixjFzzKTNzwv7IwFxPFm3qP2gmsUVcbjWzB+
 89eYslcgQTrT5b+57UVWCZdJJXa9+48TsZrOACYhVCkU5O4QiJHwn0chnqb1EIcqWqvg
 h7jw==
X-Gm-Message-State: APjAAAXYlG6pnQ3WNPE/RjqPxzVskbsjdaHBOJGK+LAl2cvFXTe4SevV
 f16wfd4TRWo+zZCZ5a1Wia2r5N/Vz9s+Ng==
X-Google-Smtp-Source: APXvYqw5lwkcMEU6JZXWm9eySHqSoPwz/N+Aa8fhQL6pzxh94pgTeSMzfYiTXN/ldMKwXoiVH/ozZg==
X-Received: by 2002:a17:90a:3ae5:: with SMTP id
 b92mr2084158pjc.26.1578455203208; 
 Tue, 07 Jan 2020 19:46:43 -0800 (PST)
Received: from localhost.localdomain (alanje.lnk.telstra.net.
 [120.151.179.201])
 by smtp.gmail.com with ESMTPSA id f23sm1198433pgj.76.2020.01.07.19.46.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2020 19:46:42 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 24/41] target/alpha: Remove MMU_MODE{0,1}_SUFFIX
Date: Wed,  8 Jan 2020 14:45:06 +1100
Message-Id: <20200108034523.17349-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200108034523.17349-1-richard.henderson@linaro.org>
References: <20200108034523.17349-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::62f
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 peter.maydell@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The functions generated by these macros are unused.

Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/alpha/cpu.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
index a530249a5b..3f782c0efe 100644
--- a/target/alpha/cpu.h
+++ b/target/alpha/cpu.h
@@ -193,8 +193,6 @@ enum {
    PALcode cheats and usees the KSEG mapping for its code+data rather than
    physical addresses.  */
 
-#define MMU_MODE0_SUFFIX _kernel
-#define MMU_MODE1_SUFFIX _user
 #define MMU_KERNEL_IDX   0
 #define MMU_USER_IDX     1
 #define MMU_PHYS_IDX     2
-- 
2.20.1


