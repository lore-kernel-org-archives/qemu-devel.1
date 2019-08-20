Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9507C3A59E
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 23:57:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3FB6206B6
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 23:57:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A4zd9NlW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3FB6206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0E0E-0008WK-U3
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 19:57:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49015)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i0Dxs-0005Vf-Q7
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 19:55:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i0Dxr-0006kD-9U
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 19:55:00 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:40502)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i0Dxr-0006jH-1e
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 19:54:59 -0400
Received: by mail-pl1-x644.google.com with SMTP id h3so275178pls.7
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2019 16:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:from:to:cc:references:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language;
 bh=bqL6VVZsmBEz56sB/yNc1xn8GU2AW+BrfR4Xoq3SXQ4=;
 b=A4zd9NlWvoMEvO2uju63ZcaopUUzK27bjZ14S+sLJDWlfNu0ZjnFPj/HJI307/ON4X
 FNxbLF89jRUnzPMvsIHPY74J0h16fGiStKHDa6yHFsV16brReKv/yJwOO3yqn5QmlvwY
 Z+ESLrBHPQqVUmY7FmdynIAdJhPfXO9JKAN2J+cZi4PBQAWf1nNEhnNrmoHqw1WMs4uh
 6p0H57On6ot8++GynVEmeQpe0fgXvPwiXq2mFVqrxoUKAI+kfluFgC8r6F+sdDeIlE+1
 l82TFC6BGIbiepinSh1QR23R78xXmCUtJRRYwmgXkIBKFUJkVY//nOA8NRLNrTPgsYR2
 xpsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language;
 bh=bqL6VVZsmBEz56sB/yNc1xn8GU2AW+BrfR4Xoq3SXQ4=;
 b=oacCiYtT0M0ow/YoXtCsWgNl1MJo3etLs1mESFOLA0KPKarol7msVqPZhqzMyPiI0L
 cxeP73PfnvzQGoa0lmWd5qSODaEI9zl4CcV6MJwPWHgvZHGub95/ytIjDbjCi1qbY7iS
 hGneMGodOM8J598iejtbwxCwHFokV2siBeVATto6Zsen2e9QyCdCJ+cyFRxDPUVOtNgS
 wcpuYDSsApz9lvQ7+VpflZHWLSnnonT3v3iuAZgj33myBnGXqTuK9ZzZjXQ8NuRmAe8Q
 4TDYqAngcGQKzixHKMlto6gc0OasuJosU2wVU6Yph79TDYH80vX+mS7dZ2lGlY/MR7Xl
 vLFQ==
X-Gm-Message-State: APjAAAXzzSY7G92ywupKJZif8qn7nFmeoSOIvSpPLVKdLsiNjN2EeZns
 icsWmI3OX9KjzQA9LWQVkCVzcQ==
X-Google-Smtp-Source: APXvYqx+alqDxkv3kra3TaHJGwZSCWJtNEfFyqagQRQ3ZoRIVQC8HNbgh4U5TV4biWux70MHAijq3A==
X-Received: by 2002:a17:902:9a8d:: with SMTP id
 w13mr30403064plp.157.1566345297474; 
 Tue, 20 Aug 2019 16:54:57 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id y13sm13721145pfb.48.2019.08.20.16.54.56
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 20 Aug 2019 16:54:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20190820210720.18976-1-richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <dacbea19-9692-0288-9b64-8500d0cf232a@linaro.org>
Date: Tue, 20 Aug 2019 16:54:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190820210720.18976-1-richard.henderson@linaro.org>
Content-Type: multipart/mixed; boundary="------------5233F652544173C873D1DD62"
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: Re: [Qemu-devel] [PATCH v5 00/17] target/arm: Reduce overhead of
 cpu_get_tb_cpu_state
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a multi-part message in MIME format.
--------------5233F652544173C873D1DD62
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

On 8/20/19 2:07 PM, Richard Henderson wrote:
> Changes since v4:
>   * Split patch 1 into 15 smaller patches.
>   * Cache the new DEBUG_TARGET_EL field.
>   * Split out m-profile hflags separately from a-profile 32-bit.
>   * Move around non-cached tb flags as well, avoiding repetitive
>     checks for m-profile or other mutually exclusive conditions.

Just after I posted this, I started rebasing my VHE patch set on top, and I
found that the new DEBUG_TARGET_EL field has used The Last Bit, so that I could
not add the one bit that I need for VHE.

However, while working on this patch set, I noticed that we have a lot of
unnecessary overlap between A- and M- profile in the TBFLAGs.  Thus point 4
above and the completely separate rebuild_hflags_m32().

If we rearrange things like the appended, then we recover 4 bits.

Thoughts?


r~

--------------5233F652544173C873D1DD62
Content-Type: text/x-patch;
 name="m-tbflag.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="m-tbflag.patch"

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 91a54662c3..0c2803baa1 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3183,38 +3183,50 @@ FIELD(TBFLAG_ANY, BE_DATA, 23, 1)
  */
 FIELD(TBFLAG_ANY, DEBUG_TARGET_EL, 21, 2)
 
-/* Bit usage when in AArch32 state: */
-FIELD(TBFLAG_A32, THUMB, 0, 1)          /* Not cached. */
-FIELD(TBFLAG_A32, VECLEN, 1, 3)         /* Not cached. */
-FIELD(TBFLAG_A32, VECSTRIDE, 4, 2)      /* Not cached. */
+/*
+ * Bit usage when in AArch32 state, both A- and M-profile.
+ */
+FIELD(TBFLAG_AM32, CONDEXEC, 0, 8)      /* Not cached. */
+
+/*
+ * Bit usage when in AArch32 state, for A-profile only.
+ */
+FIELD(TBFLAG_A32, THUMB, 8, 1)          /* Not cached. */
+FIELD(TBFLAG_A32, VECLEN, 9, 3)         /* Not cached. */
+FIELD(TBFLAG_A32, VECSTRIDE, 12, 2)     /* Not cached. */
 /*
  * We store the bottom two bits of the CPAR as TB flags and handle
  * checks on the other bits at runtime. This shares the same bits as
  * VECSTRIDE, which is OK as no XScale CPU has VFP.
  * Not cached, because VECLEN+VECSTRIDE are not cached.
  */
-FIELD(TBFLAG_A32, XSCALE_CPAR, 4, 2)
+FIELD(TBFLAG_A32, XSCALE_CPAR, 12, 2)
+FIELD(TBFLAG_A32, VFPEN, 14, 1)         /* Partially cached, minus FPEXC. */
+FIELD(TBFLAG_A32, SCTLR_B, 15, 1)
 /*
  * Indicates whether cp register reads and writes by guest code should access
  * the secure or nonsecure bank of banked registers; note that this is not
  * the same thing as the current security state of the processor!
  */
-FIELD(TBFLAG_A32, NS, 6, 1)
-FIELD(TBFLAG_A32, VFPEN, 7, 1)          /* Partially cached, minus FPEXC. */
-FIELD(TBFLAG_A32, CONDEXEC, 8, 8)       /* Not cached. */
-FIELD(TBFLAG_A32, SCTLR_B, 16, 1)
-/* For M profile only, set if FPCCR.LSPACT is set */
-FIELD(TBFLAG_A32, LSPACT, 18, 1)        /* Not cached. */
-/* For M profile only, set if we must create a new FP context */
-FIELD(TBFLAG_A32, NEW_FP_CTXT_NEEDED, 19, 1) /* Not cached. */
-/* For M profile only, set if FPCCR.S does not match current security state */
-FIELD(TBFLAG_A32, FPCCR_S_WRONG, 20, 1) /* Not cached. */
-/* For M profile only, Handler (ie not Thread) mode */
-FIELD(TBFLAG_A32, HANDLER, 21, 1)
-/* For M profile only, whether we should generate stack-limit checks */
-FIELD(TBFLAG_A32, STACKCHECK, 22, 1)
+FIELD(TBFLAG_A32, NS, 16, 1)
 
-/* Bit usage when in AArch64 state */
+/*
+ * Bit usage when in AArch32 state, for M-profile only.
+ */
+/* Set if FPCCR.LSPACT is set */
+FIELD(TBFLAG_M32, LSPACT, 8, 1)                  /* Not cached. */
+/* Set if we must create a new FP context */
+FIELD(TBFLAG_M32, NEW_FP_CTXT_NEEDED, 9, 1)      /* Not cached. */
+/* Set if FPCCR.S does not match current security state */
+FIELD(TBFLAG_M32, FPCCR_S_WRONG, 10, 1)          /* Not cached. */
+/* Handler (ie not Thread) mode */
+FIELD(TBFLAG_A32, HANDLER, 11, 1)
+/* Whether we should generate stack-limit checks */
+FIELD(TBFLAG_A32, STACKCHECK, 12, 1)
+
+/*
+ * Bit usage when in AArch64 state
+ */
 FIELD(TBFLAG_A64, TBII, 0, 2)
 FIELD(TBFLAG_A64, SVEEXC_EL, 2, 2)
 FIELD(TBFLAG_A64, ZCR_LEN, 4, 4)

--------------5233F652544173C873D1DD62--

