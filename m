Return-Path: <SRS0=0Zkw=4R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F8CBC3F2D1
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Feb 2020 02:47:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE427246A8
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Feb 2020 02:47:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iUNDmyal"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE427246A8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7s9q-0003pj-0w
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 21:47:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42690)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j7s6e-00076S-Jm
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 21:43:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j7s6c-00033K-Db
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 21:43:55 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d]:35321)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j7s6c-00031Z-82
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 21:43:54 -0500
Received: by mail-pl1-x62d.google.com with SMTP id g6so1963974plt.2
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 18:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=A1rWgDcZdMUvykrNCtRPCIuuNASTYFpt0ciGUShM3Kc=;
 b=iUNDmyal666Idq4K/Sza2k1RrSTMcZGZQZxnekRDp3+6YuoWSv2nl70AOzBUuvuVVi
 k2xVa0AYms/GBQLV4GZMObuITuHmEtC1Rt62OUisTvEUF35oMXFPsxy8eSfUJOFz15ct
 LvW0FehECdHso91qVTZC6JrQ3F5III16ZTwszudRGxs/lej5d8N3vRgYzhHLn/Gev+0+
 hT0cnGu98QZ6p6VgRZ7oXy7Zhc5nJnh2yuiBRrV2HnnF07WAd4fmiYE1zqPDI4MpvYOE
 +7pzZRDVxO0JVPfjVBV563pX8GX11J09he43qzhdTQa1x5YC+xkg3yLnqu2+ddnT04JW
 lEOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=A1rWgDcZdMUvykrNCtRPCIuuNASTYFpt0ciGUShM3Kc=;
 b=bkN81vip6JAto2twiEdjcMRSBV32NuBypFwKS8QKHPQi2MNI/O+bbobA1NAPINB3Rw
 4V/2Z+CrrWR891178MVYOKUZG9V0AhKBI+RSdQgOy4Gz2UdGJRytdPBhia0BV8bPZaxn
 zjT+c1bnkleNsZPiCAUlTlhh3cIzsP2vZR8RQJgvU6U9V8Vpa0V5S0wKn/lvg+f01whT
 NuVo8nE4hnX2e+1IV9nCgES4azAmwlvHj5UwPU9tAmcsani0zo7nZPvxTOJ0fW9b6OcF
 vc/RFMz9VZmTSZbMaxtNR6CFoRLcZvEwPc8EiKB7YLPEg8NUjCxAETOuHW6FcCyJ6DsV
 h7GQ==
X-Gm-Message-State: APjAAAXTXAnc4t3nktuR+Gim51HJGTzD9fQAE06JCCeuKzl4ScCi3Kv+
 DDiAR4qJ82WpZOuwZwpgZYwL8RM9PD4=
X-Google-Smtp-Source: APXvYqzeBp6sccnE4u402S70mAkiIiL0EGoOzuFm9M2u/qk0we3lKKU5E3a8FBGN0ufPeMJHRhXHnQ==
X-Received: by 2002:a17:90a:ff15:: with SMTP id
 ce21mr7814400pjb.124.1582944232773; 
 Fri, 28 Feb 2020 18:43:52 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id k9sm3649321pjo.19.2020.02.28.18.43.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 18:43:52 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 2/8] compiler.h: Don't use compile-time assert when
 __NO_INLINE__ is defined
Date: Fri, 28 Feb 2020 18:43:41 -0800
Message-Id: <20200229024347.22826-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200229024347.22826-1-richard.henderson@linaro.org>
References: <20200229024347.22826-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::62d
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
Cc: Zenghui Yu <yuzenghui@huawei.com>, peter.maydell@linaro.org,
 Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Zenghui Yu <yuzenghui@huawei.com>

Our robot reported the following compile-time warning while compiling
Qemu with -fno-inline cflags:

In function 'load_memop',
    inlined from 'load_helper' at /qemu/accel/tcg/cputlb.c:1578:20,
    inlined from 'full_ldub_mmu' at /qemu/accel/tcg/cputlb.c:1624:12:
/qemu/accel/tcg/cputlb.c:1502:9: error: call to 'qemu_build_not_reached' declared with attribute error: code path is reachable
         qemu_build_not_reached();
         ^~~~~~~~~~~~~~~~~~~~~~~~
    [...]

It looks like a false-positive because only (MO_UB ^ MO_BSWAP) will
hit the default case in load_memop() while need_swap (size > 1) has
already ensured that MO_UB is not involved.

So the thing is that compilers get confused by the -fno-inline and
just can't accurately evaluate memop_size(op) at compile time, and
then the qemu_build_not_reached() is wrongly triggered by (MO_UB ^
MO_BSWAP).  Let's carefully don't use the compile-time assert when
no functions will be inlined into their callers.

Reported-by: Euler Robot <euler.robot@huawei.com>
Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
Message-Id: <20200205141545.180-1-yuzenghui@huawei.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/compiler.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
index 85c02c16d3..c76281f354 100644
--- a/include/qemu/compiler.h
+++ b/include/qemu/compiler.h
@@ -236,7 +236,7 @@
  * supports QEMU_ERROR, this will be reported at compile time; otherwise
  * this will be reported at link time due to the missing symbol.
  */
-#ifdef __OPTIMIZE__
+#if defined(__OPTIMIZE__) && !defined(__NO_INLINE__)
 extern void QEMU_NORETURN QEMU_ERROR("code path is reachable")
     qemu_build_not_reached(void);
 #else
-- 
2.20.1


